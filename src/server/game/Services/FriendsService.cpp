/*
 * This file is part of the TrinityCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "FriendsService.h"
#include "BattleTag.h"
#include "BattlenetRpcErrorCodes.h"
#include "CharacterCache.h"
#include "Chat.h"
#include "DatabaseEnv.h"
#include "GameTime.h"
#include "Log.h"
#include "MapUtils.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "Random.h"
#include "RealmList.h"
#include "Util.h"
#include "Client/api/client/v2/friends_listener.pb.h"
#include "Client/api/client/v2/presence_listener.pb.h"
#include "Client/api/client/v2/whisper_listener.pb.h"
#include <mutex>
#include <unordered_set>

// Presence v2 field keys of the official server (sniff 70235, 2026-10-06). Program "BN" group 1 = the Battle.net account, group 2 = the
// online game account (with program "WoW" group 2 fields for the character).
namespace
{
    constexpr uint32 ProgramBN = 0x424E;
    constexpr uint32 ProgramWoW = 0x576F57;
    constexpr uint32 GameAccountRegion = 1;         // the account's region (bnetserver AccountInfo home/preferred region 1); 2 showed
                                                    // "(Europe)" and "Different region" on the invite button
    constexpr uint32 PlatformWin = 0x576E3634;      // official: 1466840628 ("Wn64")
    constexpr std::size_t MaxFriends = 200;
    constexpr std::size_t MaxPendingInvitations = 100;

    enum : uint32
    {
        // BN group 1 (account)
        AccountFullName         = 1,
        AccountBattleTag        = 4,
        AccountLastOnline       = 6,                // int, microseconds
        AccountAppearOffline    = 7,                // bool, set by the client (presence Update)
        AccountBusy             = 11,               // bool, set by the client
        AccountAway             = 12,               // bool, set by the client
        AccountOnlineGameAccounts = 20,             // blob PresenceOnlineGameAccountFieldValue; empty = offline
        AccountLastGameAccount  = 21,               // blob GameAccountHandle
        AccountState            = 22,               // uint (0 offline/away .. 1 online)
        AccountStateTime        = 23,               // int, microseconds

        // BN group 2 (game account)
        GameOnline              = 1,                // bool
        GameTime                = 4,                // int, microseconds
        GameBattleTag           = 5,
        GameAccountName         = 6,                // "<bnet id>#<index>"
        GameBusy                = 10,               // bool
        GameAway                = 12,               // bool
        GameRegion              = 13,
        GamePlatform            = 15,
        GameRegion2             = 17,
        GameBnetAccount         = 20,
        GameProgramName         = 21,               // "WoW"

        // WoW group 2 (character)
        WowRealm                = 1,                // realm address
        WowRace                 = 2,
        WowClass                = 3,
        WowLevel                = 5,
        WowZone                 = 6,
        WowFactionGroup         = 7,                // FactionGroup mask: 1 player | 2 Alliance (3) or 4 Horde (5) - every official sniff
        WowRealm2               = 8,
        WowGender               = 9,                // 0 / 1 (varies per character in the official character select presence)
        WowName                 = 10,               // "Name Surname"
        WowCfgRealm             = 11,
        WowGuid                 = 12,               // character guid counter
        WowFlag13               = 13,               // bool, always false
        WowFlag14               = 14,               // official 18
        WowTimerunningSeason    = 15,               // int, 0 (1 showed the Timerunning hourglass before the name)
    };

    uint64 NowUs()
    {
        return std::chrono::duration_cast<std::chrono::microseconds>(std::chrono::system_clock::now().time_since_epoch()).count();
    }

    // ---- data

    std::mutex FriendCacheLock;
    std::unordered_map<uint32, std::vector<uint32>> FriendCache;       // online (this realm) bnet account -> its friends

    // status the client picked (online / away / busy / appear offline), kept while the account plays on this realm
    // the account fields the client set itself (presence Update), passed on to friends unchanged as the official server does
    struct PresenceStatus
    {
        bool AppearOffline = false;
        std::map<uint32, bgs::protocol::v2::Variant> Fields;
    };

    std::mutex StatusLock;
    std::unordered_map<uint32, PresenceStatus> StatusCache;

    PresenceStatus GetStatus(uint32 accountId)
    {
        std::scoped_lock guard(StatusLock);
        if (PresenceStatus const* status = Trinity::Containers::MapGetValuePtr(StatusCache, accountId))
            return *status;
        return {};
    }

    std::vector<uint32> LoadFriendIds(uint32 accountId)
    {
        std::vector<uint32> ids;
        if (QueryResult result = LoginDatabase.PQuery("SELECT friend_account_id FROM battlenet_friends WHERE account_id = {}", accountId))
        {
            do
                ids.push_back((*result)[0].GetUInt32());
            while (result->NextRow());
        }
        return ids;
    }

    std::vector<uint32> CachedFriendIds(uint32 accountId)
    {
        std::scoped_lock guard(FriendCacheLock);
        if (std::vector<uint32> const* ids = Trinity::Containers::MapGetValuePtr(FriendCache, accountId))
            return *ids;
        return {};
    }

    void ReloadFriendCache(uint32 accountId)
    {
        std::vector<uint32> ids = LoadFriendIds(accountId);
        std::scoped_lock guard(FriendCacheLock);
        if (FriendCache.contains(accountId))
            FriendCache[accountId] = std::move(ids);
    }

    struct AccountInfo
    {
        uint32 Id = 0;
        std::string BattleTag;
    };

    Optional<AccountInfo> GetAccount(uint32 accountId)
    {
        if (QueryResult result = LoginDatabase.PQuery("SELECT id, battle_tag FROM battlenet_accounts WHERE id = {}", accountId))
            return AccountInfo{ (*result)[0].GetUInt32(), (*result)[1].IsNull() ? "" : (*result)[1].GetString() };
        return {};
    }

    std::string ReadBattleTag(uint32 accountId)
    {
        if (QueryResult result = LoginDatabase.PQuery("SELECT battle_tag FROM battlenet_accounts WHERE id = {}", accountId))
            if (!(*result)[0].IsNull())
                return (*result)[0].GetString();
        return {};
    }

    // Gives the account "<name>#<free number>". onlyIfEmpty leaves an account that already has a tag alone (the automatic tag
    // at login). battle_tag has a unique key, so when another account takes the same tag at the same moment the UPDATE does
    // nothing and the next try draws again. Returns the new tag, or empty when the name is invalid or full, or the account got
    // a tag meanwhile.
    std::string AssignBattleTag(uint32 accountId, std::string const& name, bool onlyIfEmpty)
    {
        if (!Trinity::BattleTag::IsValidName(name))     // letters and digits only, so nothing to escape
            return {};

        for (uint32 attempt = 0; attempt < 5; ++attempt)
        {
            std::unordered_set<uint32> taken;
            if (QueryResult result = LoginDatabase.PQuery("SELECT battle_tag FROM battlenet_accounts WHERE battle_tag LIKE '{}#%'", name))
            {
                do
                {
                    if (Optional<uint32> number = Trinity::BattleTag::NumberOf((*result)[0].GetStringView()))
                        taken.insert(*number);
                } while (result->NextRow());
            }

            Optional<uint32> number = Trinity::BattleTag::DrawNumber(taken, [](uint32 min, uint32 max) { return urand(min, max); });
            if (!number)
                return {};

            std::string const tag = Trinity::BattleTag::Make(name, *number);
            LoginDatabase.DirectPExecute("UPDATE IGNORE battlenet_accounts SET battle_tag = '{}' WHERE id = {}{}", tag, accountId,
                onlyIfEmpty ? " AND (battle_tag IS NULL OR battle_tag = '')" : "");
            std::string const now = ReadBattleTag(accountId);
            if (now == tag)
            {
                TC_LOG_INFO("network.rpc", "Battle.net account {}: BattleTag set to '{}'", accountId, tag);
                return tag;
            }
            if (onlyIfEmpty && !now.empty())
                return {};
        }
        return {};
    }

    // "Name#1234" (any case) or an e-mail address
    Optional<AccountInfo> FindAccount(std::string const& target)
    {
        if (target.empty())
            return {};
        std::string upper = target;
        std::ranges::transform(upper, upper.begin(), [](char c) { return char(std::toupper(uint8(c))); });
        LoginDatabase.EscapeString(upper);
        if (QueryResult result = LoginDatabase.PQuery("SELECT id, battle_tag FROM battlenet_accounts WHERE UPPER(battle_tag) = '{}' OR email = '{}' LIMIT 1", upper, upper))
            return AccountInfo{ (*result)[0].GetUInt32(), (*result)[1].IsNull() ? "" : (*result)[1].GetString() };
        return {};
    }

    // A character's name, with or without its Classic 1.60 surname ("Ora", "Ora Brightleaf", "Ora-Brightleaf"). With title
    // friends on (battleNetTitleFriendsEnabledClient) the Add Friend box sends a typed character name this way
    // (C_BattleNet.SendTitleFriendInviteByName); the invitation goes to that character's Battle.net account. Character names
    // are unique on their own, so the surname, when given, only has to match. A character without a Battle.net account
    // (a bot) is not found.
    CharacterCacheEntry const* FindCharacterByTypedName(std::string const& target)
    {
        size_t const split = target.find_first_of(" -");
        std::string name = target.substr(0, split);
        std::string surname = split == std::string::npos ? std::string() : target.substr(split + 1);
        while (!surname.empty() && (surname.back() == ' ' || surname.back() == '\t'))
            surname.pop_back();
        if (!normalizePlayerName(name))
            return nullptr;

        CharacterCacheEntry const* character = sCharacterCache->GetCharacterCacheByName(name);
        if (!character || character->IsDeleted)
            return nullptr;
        if (!surname.empty() && !StringEqualI(surname, character->Surname))
            return nullptr;
        return character;
    }

    Optional<AccountInfo> FindAccountByCharacterName(std::string const& target)
    {
        CharacterCacheEntry const* character = FindCharacterByTypedName(target);
        if (!character)
            return {};

        if (QueryResult result = LoginDatabase.PQuery("SELECT battlenet_account FROM account WHERE id = {}", character->AccountId))
            if (!(*result)[0].IsNull() && (*result)[0].GetUInt32() != 0)
                return GetAccount((*result)[0].GetUInt32());
        return {};
    }

    bool AreFriends(uint32 accountId, uint32 otherId)
    {
        return LoginDatabase.PQuery("SELECT 1 FROM battlenet_friends WHERE account_id = {} AND friend_account_id = {}", accountId, otherId) != nullptr;
    }

    bool IsOnlineAnywhere(uint32 accountId)
    {
        return LoginDatabase.PQuery("SELECT 1 FROM account WHERE battlenet_account = {} AND online <> 0 LIMIT 1", accountId) != nullptr;
    }

    // the player of a Battle.net account that is in world on this realm
    Player* FindOnlinePlayer(uint32 accountId)
    {
        std::shared_lock lock(*HashMapHolder<Player>::GetLock());
        for (auto const& [guid, player] : ObjectAccessor::GetPlayers())
            if (player->GetSession() && player->GetSession()->GetBattlenetAccountId() == accountId && player->IsInWorld())
                return player;
        return nullptr;
    }

    // ---- presence

    bgs::protocol::presence::v2::PresenceField* AddField(bgs::protocol::presence::v2::PresenceFieldState* state, uint32 program, uint32 group, uint32 field, uint64 now)
    {
        bgs::protocol::presence::v2::PresenceField* presenceField = state->add_fields();
        bgs::protocol::presence::v2::PresenceFieldKey* key = presenceField->mutable_key();
        key->set_title_id(program);
        key->set_group(group);
        key->set_field(field);
        key->set_unique_id(0);
        presenceField->set_updated_time_us(now);
        return presenceField;
    }

    void SetHandle(bgs::protocol::account::v2::GameAccountHandle* handle, uint32 gameAccountId)
    {
        handle->set_id(gameAccountId);
        handle->set_title_id(ProgramWoW);
        handle->set_region(GameAccountRegion);
    }

    // account (group 1): BattleTag, online or not, away
    void FillAccountState(bgs::protocol::presence::v2::PresenceFieldState* state, AccountInfo const& account, Player const* player, bool onlineElsewhere, uint64 now)
    {
        PresenceStatus const status = player ? GetStatus(account.Id) : PresenceStatus();
        state->set_account_id(account.Id);
        state->set_oldest_time_us(now);
        if (!account.BattleTag.empty())
            AddField(state, ProgramBN, 1, AccountBattleTag, now)->mutable_value()->set_string_value(account.BattleTag);
        AddField(state, ProgramBN, 1, AccountLastOnline, now)->mutable_value()->set_int_value(now);
        if (!status.Fields.contains(AccountAway))
            AddField(state, ProgramBN, 1, AccountAway, now)->mutable_value()->set_bool_value(player && player->isAFK());
        if (player)
            for (auto const& [field, value] : status.Fields)
                if (field != AccountAppearOffline)
                    *AddField(state, ProgramBN, 1, field, now)->mutable_value() = value;

        bool const online = player || onlineElsewhere;
        bgs::protocol::presence::v2::PresenceOnlineGameAccountFieldValue onlineAccounts;
        if (player)
        {
            bgs::protocol::presence::v2::PresenceOnlineGameAccount* onlineAccount = onlineAccounts.add_online_game_accounts();
            SetHandle(onlineAccount->mutable_game_account(), player->GetSession()->GetAccountId());
            onlineAccount->set_online_time_us(now);

            bgs::protocol::account::v2::GameAccountHandle handle;
            SetHandle(&handle, player->GetSession()->GetAccountId());
            AddField(state, ProgramBN, 1, AccountLastGameAccount, now)->mutable_value()->set_blob_value(handle.SerializeAsString());
        }
        else
        {
            bgs::protocol::presence::v2::PresenceField* field = AddField(state, ProgramBN, 1, AccountLastGameAccount, now);
            field->set_deleted(true);
        }
        AddField(state, ProgramBN, 1, AccountOnlineGameAccounts, now)->mutable_value()->set_blob_value(onlineAccounts.SerializeAsString());
        if (!online || !status.Fields.contains(AccountState))
            AddField(state, ProgramBN, 1, AccountState, now)->mutable_value()->set_uint_value(online ? 1 : 0);
        AddField(state, ProgramBN, 1, AccountStateTime, now)->mutable_value()->set_int_value(now);
    }

    // game account (group 2) with the character, or the fields deleted when it went offline
    void FillGameAccountState(bgs::protocol::presence::v2::PresenceFieldState* state, AccountInfo const& account, WorldSession const* session,
        Player const* player, uint64 now)
    {
        state->set_account_id(account.Id);
        state->set_oldest_time_us(now);
        SetHandle(state->mutable_game_account(), session->GetAccountId());

        AddField(state, ProgramBN, 2, GameOnline, now)->mutable_value()->set_bool_value(player != nullptr);
        AddField(state, ProgramBN, 2, GameTime, now)->mutable_value()->set_int_value(now);
        if (!player)
        {
            for (uint32 field : { WowRealm, WowRace, WowClass, WowLevel, WowZone, WowFactionGroup, WowRealm2, WowGender, WowName, WowCfgRealm,
                WowGuid, WowFlag13, WowFlag14, WowTimerunningSeason })
                AddField(state, ProgramWoW, 2, field, now)->set_deleted(true);
            return;
        }

        if (!account.BattleTag.empty())
            AddField(state, ProgramBN, 2, GameBattleTag, now)->mutable_value()->set_string_value(account.BattleTag);
        AddField(state, ProgramBN, 2, GameAccountName, now)->mutable_value()->set_string_value(session->GetAccountName());
        AddField(state, ProgramBN, 2, GameBusy, now)->mutable_value()->set_bool_value(player->isDND());
        AddField(state, ProgramBN, 2, GameAway, now)->mutable_value()->set_bool_value(player->isAFK());
        AddField(state, ProgramBN, 2, GameRegion, now)->mutable_value()->set_uint_value(GameAccountRegion);
        AddField(state, ProgramBN, 2, GamePlatform, now)->mutable_value()->set_uint_value(PlatformWin);
        AddField(state, ProgramBN, 2, GameRegion2, now)->mutable_value()->set_uint_value(GameAccountRegion);
        AddField(state, ProgramBN, 2, GameBnetAccount, now)->mutable_value()->set_uint_value(account.Id);
        AddField(state, ProgramBN, 2, GameProgramName, now)->mutable_value()->set_string_value("WoW");

        std::string name = player->GetName();
        std::string surname = sCharacterCache->GetCharacterSurnameByGuid(player->GetGUID());
        if (!surname.empty())
            name += " " + surname;

        uint32 const realmAddress = sRealmList->GetCurrentRealmId().GetAddress();
        AddField(state, ProgramWoW, 2, WowRealm, now)->mutable_value()->set_uint_value(realmAddress);
        AddField(state, ProgramWoW, 2, WowRace, now)->mutable_value()->set_uint_value(player->GetRace());
        AddField(state, ProgramWoW, 2, WowClass, now)->mutable_value()->set_uint_value(player->GetClass());
        AddField(state, ProgramWoW, 2, WowLevel, now)->mutable_value()->set_uint_value(player->GetLevel());
        AddField(state, ProgramWoW, 2, WowZone, now)->mutable_value()->set_uint_value(player->GetZoneId());
        AddField(state, ProgramWoW, 2, WowFactionGroup, now)->mutable_value()->set_int_value(player->GetTeamId() == TEAM_ALLIANCE ? 3 : 5);
        AddField(state, ProgramWoW, 2, WowRealm2, now)->mutable_value()->set_uint_value(realmAddress);
        AddField(state, ProgramWoW, 2, WowGender, now)->mutable_value()->set_uint_value(player->GetNativeGender());
        AddField(state, ProgramWoW, 2, WowName, now)->mutable_value()->set_string_value(name);
        AddField(state, ProgramWoW, 2, WowCfgRealm, now)->mutable_value()->set_uint_value(sRealmList->GetCurrentRealmId().Realm);
        AddField(state, ProgramWoW, 2, WowGuid, now)->mutable_value()->set_uint_value(uint32(player->GetGUID().GetCounter()));
        AddField(state, ProgramWoW, 2, WowFlag13, now)->mutable_value()->set_bool_value(false);
        AddField(state, ProgramWoW, 2, WowFlag14, now)->mutable_value()->set_uint_value(18);
        AddField(state, ProgramWoW, 2, WowTimerunningSeason, now)->mutable_value()->set_int_value(0);
    }

    void SendPresence(WorldSession* receiver, bgs::protocol::presence::v2::PresenceStateUpdatedNotification& notification)
    {
        notification.set_subscriber_id(receiver->GetBattlenetAccountId());
        Battlenet::WorldserverService<bgs::protocol::presence::v2::PresenceListener>(receiver).OnPresenceStateUpdated(&notification, true, true);
    }

    // full presence of one account (both levels when it plays on this realm) to a receiver
    void SendAccountPresence(WorldSession* receiver, AccountInfo const& account)
    {
        uint64 const now = NowUs();
        Player const* player = FindOnlinePlayer(account.Id);
        bgs::protocol::presence::v2::PresenceStateUpdatedNotification notification;
        if (player && GetStatus(account.Id).AppearOffline)         // looks offline to friends
        {
            FillAccountState(notification.add_states(), account, nullptr, false, now);
            FillGameAccountState(notification.add_states(), account, player->GetSession(), nullptr, now);
            SendPresence(receiver, notification);
            return;
        }
        FillAccountState(notification.add_states(), account, player, !player && IsOnlineAnywhere(account.Id), now);
        if (player)
            FillGameAccountState(notification.add_states(), account, player->GetSession(), player, now);
        SendPresence(receiver, notification);
    }

    // tell the online friends (this realm) of an account about a change of its presence
    void NotifyFriends(uint32 accountId, std::function<void(bgs::protocol::presence::v2::PresenceStateUpdatedNotification&)> const& fill)
    {
        for (uint32 friendId : CachedFriendIds(accountId))
        {
            if (Player* friendPlayer = FindOnlinePlayer(friendId))
            {
                bgs::protocol::presence::v2::PresenceStateUpdatedNotification notification;
                fill(notification);
                SendPresence(friendPlayer->GetSession(), notification);
            }
        }
    }

    // ---- friends listener notifications

    template<class Notification>
    void ToAccount(uint32 accountId, Notification& notification, void (bgs::protocol::friends::v2::client::FriendsListener::*method)(Notification const*, bool, bool))
    {
        if (Player* player = FindOnlinePlayer(accountId))
        {
            notification.set_agent_account_id(accountId);
            Battlenet::WorldserverService<bgs::protocol::friends::v2::client::FriendsListener> listener(player->GetSession());
            (listener.*method)(&notification, true, true);
        }
    }

    void FillFriend(bgs::protocol::friends::v2::client::Friend* entry, uint32 friendId, std::string const& battleTag, uint32 created)
    {
        entry->set_id(friendId);
        entry->set_level(1);
        if (!battleTag.empty())
            entry->set_battle_tag(battleTag);
        entry->set_creation_time_s(created);
    }

    void FillReceived(bgs::protocol::friends::v2::client::ReceivedInvitation* invitation, uint64 id, AccountInfo const& inviter, uint32 created)
    {
        invitation->set_id(id);
        invitation->mutable_inviter()->set_account_id(inviter.Id);
        if (!inviter.BattleTag.empty())
            invitation->mutable_inviter()->set_battle_tag(inviter.BattleTag);
        invitation->set_level(1);
        invitation->set_program(ProgramWoW);
        invitation->set_creation_time_s(created);
        invitation->set_expiration_time_s(created + 30 * DAY);
    }

    void FillSent(bgs::protocol::friends::v2::client::SentInvitation* invitation, uint64 id, AccountInfo const& invitee, uint32 created)
    {
        invitation->set_id(id);
        invitation->set_target_name(invitee.BattleTag);
        invitation->set_level(1);
        invitation->set_program(ProgramWoW);
        invitation->set_creation_time_s(created);
    }
}

namespace Battlenet::Services
{
FriendsService::FriendsService(WorldSession* session) : BaseService(session) { }

uint32 FriendsService::HandleSubscribe(friends::v2::client::SubscribeRequest const* /*request*/, NoData* /*response*/,
    std::function<void(ServiceBase*, uint32, google::protobuf::Message const*)>& /*continuation*/)
{
    return ERROR_OK;
}

uint32 FriendsService::HandleUnsubscribe(friends::v2::client::UnsubscribeRequest const* /*request*/, NoData* /*response*/,
    std::function<void(ServiceBase*, uint32, google::protobuf::Message const*)>& /*continuation*/)
{
    return ERROR_OK;
}

uint32 FriendsService::HandleGetSentInvitations(friends::v2::client::GetSentInvitationsRequest const* /*request*/,
    friends::v2::client::GetSentInvitationsResponse* response, std::function<void(ServiceBase*, uint32, google::protobuf::Message const*)>& /*continuation*/)
{
    if (QueryResult result = LoginDatabase.PQuery("SELECT i.id, i.invitee_account_id, a.battle_tag, i.created FROM battlenet_friend_invitations i "
        "JOIN battlenet_accounts a ON a.id = i.invitee_account_id WHERE i.inviter_account_id = {}", _session->GetBattlenetAccountId()))
    {
        do
        {
            Field* fields = result->Fetch();
            FillSent(response->add_invitations(), fields[0].GetUInt32(), { fields[1].GetUInt32(), fields[2].IsNull() ? "" : fields[2].GetString() },
                fields[3].GetUInt32());
        } while (result->NextRow());
    }
    response->set_continuation(0);
    return ERROR_OK;
}

uint32 FriendsService::HandleGetReceivedInvitations(friends::v2::client::GetReceivedInvitationsRequest const* /*request*/,
    friends::v2::client::GetReceivedInvitationsResponse* response, std::function<void(ServiceBase*, uint32, google::protobuf::Message const*)>& /*continuation*/)
{
    if (QueryResult result = LoginDatabase.PQuery("SELECT i.id, i.inviter_account_id, a.battle_tag, i.created FROM battlenet_friend_invitations i "
        "JOIN battlenet_accounts a ON a.id = i.inviter_account_id WHERE i.invitee_account_id = {}", _session->GetBattlenetAccountId()))
    {
        do
        {
            Field* fields = result->Fetch();
            FillReceived(response->add_invitations(), fields[0].GetUInt32(), { fields[1].GetUInt32(), fields[2].IsNull() ? "" : fields[2].GetString() },
                fields[3].GetUInt32());
        } while (result->NextRow());
    }
    response->set_continuation(0);
    return ERROR_OK;
}

uint32 FriendsService::HandleGetFriends(friends::v2::client::GetFriendsRequest const* /*request*/,
    friends::v2::client::GetFriendsResponse* response, std::function<void(ServiceBase*, uint32, google::protobuf::Message const*)>& continuation)
{
    std::vector<AccountInfo> friends;
    if (QueryResult result = LoginDatabase.PQuery("SELECT f.friend_account_id, a.battle_tag, f.created, f.note FROM battlenet_friends f "
        "JOIN battlenet_accounts a ON a.id = f.friend_account_id WHERE f.account_id = {}", _session->GetBattlenetAccountId()))
    {
        do
        {
            Field* fields = result->Fetch();
            AccountInfo& account = friends.emplace_back(AccountInfo{ fields[0].GetUInt32(), fields[1].IsNull() ? "" : fields[1].GetString() });
            bgs::protocol::friends::v2::client::Friend* entry = response->add_friends();
            FillFriend(entry, account.Id, account.BattleTag, fields[2].GetUInt32());
            if (!fields[3].GetStringView().empty())
                entry->set_note(fields[3].GetString());
        } while (result->NextRow());
    }
    response->set_continuation(0);
    TC_LOG_INFO("network.rpc", "{} FriendsService.GetFriends: {} friend(s)", _session->GetPlayerInfo(), friends.size());

    // reply first, then the friends' presence (official order)
    continuation(this, ERROR_OK, response);
    continuation = nullptr;
    for (AccountInfo const& account : friends)
        SendAccountPresence(_session, account);
    return ERROR_OK;
}

uint32 FriendsService::HandleIsFriend(friends::v2::client::IsFriendRequest const* request, friends::v2::client::IsFriendResponse* response,
    std::function<void(ServiceBase*, uint32, google::protobuf::Message const*)>& /*continuation*/)
{
    response->set_result(AreFriends(_session->GetBattlenetAccountId(), uint32(request->target_account_id())));
    return ERROR_OK;
}

uint32 FriendsService::HandleSendInvitation(friends::v2::client::SendInvitationRequest const* request, NoData* /*response*/,
    std::function<void(ServiceBase*, uint32, google::protobuf::Message const*)>& /*continuation*/)
{
    uint32 const me = _session->GetBattlenetAccountId();
    friends::v2::client::SendInvitationTarget const& target = request->target();
    TC_LOG_INFO("network.rpc", "{} FriendsService.SendInvitation: {}", _session->GetPlayerInfo(), request->ShortDebugString());

    Optional<AccountInfo> invitee;
    if (target.has_account_id())
        invitee = GetAccount(uint32(target.account_id()));
    else if (target.has_battle_tag())
        invitee = FindAccount(target.battle_tag());
    else if (target.has_email())
        invitee = FindAccount(target.email());
    else if (target.has_name())
    {
        invitee = FindAccount(target.name());
        if (!invitee && target.name().find_first_of("#@") == std::string::npos)
        {
            // A bot's account never answers an invitation (and holds many bots): a bot becomes a character friend, shown online
            // or offline in the friends list as soon as it is added, as the legacy Add Friend does (energetik, 19 Nov).
            if (CharacterCacheEntry const* character = FindCharacterByTypedName(target.name());
                character && WorldSession::IsAutomatedAccount(character->AccountId))
            {
                _session->AddCharacterFriend(character->Guid, character->AccountId, character->Race, std::string());
                return ERROR_OK;
            }
            invitee = FindAccountByCharacterName(target.name());
        }
    }

    if (!invitee)
        return ERROR_FRIENDS_RECEIVED_INVITATION_UNDELIVERABLE;
    if (invitee->Id == me)
        return ERROR_INVALID_TARGET_ID;
    if (AreFriends(me, invitee->Id))
        return ERROR_FRIENDS_FRIENDSHIP_ALREADY_EXISTS;
    if (LoginDatabase.PQuery("SELECT 1 FROM battlenet_friend_invitations WHERE inviter_account_id = {} AND invitee_account_id = {}", me, invitee->Id))
        return ERROR_FRIENDS_INVITATION_ALREADY_EXISTS;
    if (QueryResult count = LoginDatabase.PQuery("SELECT COUNT(*) FROM battlenet_friend_invitations WHERE inviter_account_id = {}", me))
        if ((*count)[0].GetUInt64() >= MaxPendingInvitations)
            return ERROR_FRIENDS_TOO_MANY_SENT_INVITATIONS;
    if (LoadFriendIds(me).size() >= MaxFriends)
        return ERROR_FRIENDS_INVITER_AT_MAX_FRIENDS;

    // they invited us already: just accept theirs
    if (QueryResult theirs = LoginDatabase.PQuery("SELECT id FROM battlenet_friend_invitations WHERE inviter_account_id = {} AND invitee_account_id = {}", invitee->Id, me))
    {
        friends::v2::client::AcceptInvitationRequest accept;
        accept.set_invitation_id((*theirs)[0].GetUInt32());
        NoData none;
        std::function<void(ServiceBase*, uint32, google::protobuf::Message const*)> noContinuation;
        return HandleAcceptInvitation(&accept, &none, noContinuation);
    }

    uint32 const created = uint32(GameTime::GetGameTime());
    LoginDatabase.DirectPExecute("INSERT INTO battlenet_friend_invitations (inviter_account_id, invitee_account_id, created) VALUES ({}, {}, {})",
        me, invitee->Id, created);
    QueryResult inserted = LoginDatabase.PQuery("SELECT id FROM battlenet_friend_invitations WHERE inviter_account_id = {} AND invitee_account_id = {}", me, invitee->Id);
    if (!inserted)
        return ERROR_INTERNAL;
    uint64 const invitationId = (*inserted)[0].GetUInt32();

    Optional<AccountInfo> self = GetAccount(me);
    friends::v2::client::SentInvitationAddedNotification sent;
    FillSent(sent.add_invitations(), invitationId, *invitee, created);
    ToAccount(me, sent, &friends::v2::client::FriendsListener::OnSentInvitationAdded);

    friends::v2::client::ReceivedInvitationAddedNotification received;
    FillReceived(received.add_invitations(), invitationId, self.value_or(AccountInfo{ me, "" }), created);
    ToAccount(invitee->Id, received, &friends::v2::client::FriendsListener::OnReceivedInvitationAdded);
    return ERROR_OK;
}

uint32 FriendsService::HandleAcceptInvitation(friends::v2::client::AcceptInvitationRequest const* request, NoData* /*response*/,
    std::function<void(ServiceBase*, uint32, google::protobuf::Message const*)>& /*continuation*/)
{
    uint32 const me = _session->GetBattlenetAccountId();
    QueryResult result = LoginDatabase.PQuery("SELECT inviter_account_id FROM battlenet_friend_invitations WHERE id = {} AND invitee_account_id = {}",
        request->invitation_id(), me);
    if (!result)
        return ERROR_FRIENDS_INVALID_INVITATION;
    uint32 const inviterId = (*result)[0].GetUInt32();

    if (LoadFriendIds(me).size() >= MaxFriends)
        return ERROR_FRIENDS_INVITEE_AT_MAX_FRIENDS;

    uint32 const created = uint32(GameTime::GetGameTime());
    LoginDatabaseTransaction trans = LoginDatabase.BeginTransaction();
    trans->PAppend("DELETE FROM battlenet_friend_invitations WHERE (inviter_account_id = {0} AND invitee_account_id = {1}) OR (inviter_account_id = {1} AND invitee_account_id = {0})",
        inviterId, me);
    trans->PAppend("REPLACE INTO battlenet_friends (account_id, friend_account_id, created) VALUES ({0}, {1}, {2}), ({1}, {0}, {2})", inviterId, me, created);
    LoginDatabase.DirectCommitTransaction(trans);
    ReloadFriendCache(me);
    ReloadFriendCache(inviterId);

    Optional<AccountInfo> self = GetAccount(me);
    Optional<AccountInfo> inviter = GetAccount(inviterId);
    if (!self || !inviter)
        return ERROR_OK;

    friends::v2::client::ReceivedInvitationRemovedNotification receivedRemoved;
    bgs::protocol::friends::v2::client::RemovedInvitationAssignment* assignment = receivedRemoved.add_assignments();
    assignment->set_invitation_id(request->invitation_id());
    assignment->set_reason(0);
    ToAccount(me, receivedRemoved, &friends::v2::client::FriendsListener::OnReceivedInvitationRemoved);

    friends::v2::client::SentInvitationRemovedNotification sentRemoved;
    assignment = sentRemoved.add_assignments();
    assignment->set_invitation_id(request->invitation_id());
    assignment->set_reason(0);
    ToAccount(inviterId, sentRemoved, &friends::v2::client::FriendsListener::OnSentInvitationRemoved);

    friends::v2::client::FriendAddedNotification addedForMe;
    FillFriend(addedForMe.add_friends(), inviter->Id, inviter->BattleTag, created);
    ToAccount(me, addedForMe, &friends::v2::client::FriendsListener::OnFriendAdded);

    friends::v2::client::FriendAddedNotification addedForInviter;
    FillFriend(addedForInviter.add_friends(), self->Id, self->BattleTag, created);
    ToAccount(inviterId, addedForInviter, &friends::v2::client::FriendsListener::OnFriendAdded);

    // each one's presence to the other
    SendAccountPresence(_session, *inviter);
    if (Player* inviterPlayer = FindOnlinePlayer(inviterId))
        SendAccountPresence(inviterPlayer->GetSession(), *self);
    return ERROR_OK;
}

uint32 FriendsService::RemoveInvitation(uint64 invitationId, bool asInvitee, uint32 reason)
{
    uint32 const me = _session->GetBattlenetAccountId();
    QueryResult result = LoginDatabase.PQuery("SELECT inviter_account_id, invitee_account_id FROM battlenet_friend_invitations WHERE id = {} AND {} = {}",
        invitationId, asInvitee ? "invitee_account_id" : "inviter_account_id", me);
    if (!result)
        return ERROR_FRIENDS_INVALID_INVITATION;
    uint32 const inviterId = (*result)[0].GetUInt32();
    uint32 const inviteeId = (*result)[1].GetUInt32();
    LoginDatabase.DirectPExecute("DELETE FROM battlenet_friend_invitations WHERE id = {}", invitationId);

    friends::v2::client::SentInvitationRemovedNotification sentRemoved;
    bgs::protocol::friends::v2::client::RemovedInvitationAssignment* assignment = sentRemoved.add_assignments();
    assignment->set_invitation_id(invitationId);
    assignment->set_reason(reason);
    ToAccount(inviterId, sentRemoved, &friends::v2::client::FriendsListener::OnSentInvitationRemoved);

    friends::v2::client::ReceivedInvitationRemovedNotification receivedRemoved;
    assignment = receivedRemoved.add_assignments();
    assignment->set_invitation_id(invitationId);
    assignment->set_reason(reason);
    ToAccount(inviteeId, receivedRemoved, &friends::v2::client::FriendsListener::OnReceivedInvitationRemoved);
    return ERROR_OK;
}

uint32 FriendsService::HandleRevokeInvitation(friends::v2::client::RevokeInvitationRequest const* request, NoData* /*response*/,
    std::function<void(ServiceBase*, uint32, google::protobuf::Message const*)>& /*continuation*/)
{
    return RemoveInvitation(request->invitation_id(), false, 2);
}

uint32 FriendsService::HandleRevokeAllInvitations(friends::v2::client::RevokeAllInvitationsRequest const* /*request*/, NoData* /*response*/,
    std::function<void(ServiceBase*, uint32, google::protobuf::Message const*)>& /*continuation*/)
{
    std::vector<uint64> ids;
    if (QueryResult result = LoginDatabase.PQuery("SELECT id FROM battlenet_friend_invitations WHERE inviter_account_id = {}", _session->GetBattlenetAccountId()))
    {
        do
            ids.push_back((*result)[0].GetUInt32());
        while (result->NextRow());
    }
    for (uint64 id : ids)
        RemoveInvitation(id, false, 2);
    return ERROR_OK;
}

uint32 FriendsService::HandleIgnoreInvitation(friends::v2::client::IgnoreInvitationRequest const* request, NoData* /*response*/,
    std::function<void(ServiceBase*, uint32, google::protobuf::Message const*)>& /*continuation*/)
{
    return RemoveInvitation(request->invitation_id(), true, 1);
}

uint32 FriendsService::HandleRemoveFriend(friends::v2::client::RemoveFriendRequest const* request, NoData* /*response*/,
    std::function<void(ServiceBase*, uint32, google::protobuf::Message const*)>& /*continuation*/)
{
    uint32 const me = _session->GetBattlenetAccountId();
    uint32 const other = uint32(request->target_account_id());
    if (!AreFriends(me, other))
        return ERROR_FRIENDS_FRIENDSHIP_DOES_NOT_EXIST;

    LoginDatabase.DirectPExecute("DELETE FROM battlenet_friends WHERE (account_id = {0} AND friend_account_id = {1}) OR (account_id = {1} AND friend_account_id = {0})", me, other);
    ReloadFriendCache(me);
    ReloadFriendCache(other);

    friends::v2::client::FriendRemovedNotification removedForMe;
    removedForMe.add_assignments()->set_id(other);
    ToAccount(me, removedForMe, &friends::v2::client::FriendsListener::OnFriendRemoved);

    friends::v2::client::FriendRemovedNotification removedForOther;
    removedForOther.add_assignments()->set_id(me);
    ToAccount(other, removedForOther, &friends::v2::client::FriendsListener::OnFriendRemoved);
    return ERROR_OK;
}

uint32 FriendsService::HandleUpdateFriendState(friends::v2::client::UpdateFriendStateRequest const* request, NoData* /*response*/,
    std::function<void(ServiceBase*, uint32, google::protobuf::Message const*)>& /*continuation*/)
{
    uint32 const me = _session->GetBattlenetAccountId();
    uint32 const other = uint32(request->target_account_id());
    if (!AreFriends(me, other))
        return ERROR_FRIENDS_FRIENDSHIP_DOES_NOT_EXIST;

    if (request->options().has_note())
    {
        std::string note = request->options().note();
        if (note.length() > 127)
            return ERROR_FRIENDS_NOTE_MAX_SIZE_EXCEEDED;
        LoginDatabase.EscapeString(note);
        LoginDatabase.DirectPExecute("UPDATE battlenet_friends SET note = '{}' WHERE account_id = {} AND friend_account_id = {}", note, me, other);
    }

    friends::v2::client::UpdateFriendStateNotification updated;
    bgs::protocol::friends::v2::client::FriendStateAssignment* assignment = updated.add_assignments();
    assignment->set_id(other);
    if (request->options().has_note())
        assignment->set_note(request->options().note());
    ToAccount(me, updated, &friends::v2::client::FriendsListener::OnUpdateFriendState);
    return ERROR_OK;
}
}

namespace Battlenet::Services
{
PresenceService::PresenceService(WorldSession* session) : BaseService(session) { }

uint32 PresenceService::HandleBatchSubscribe(presence::v2::client::BatchSubscribeRequest const* request, NoData* response,
    std::function<void(ServiceBase*, uint32, google::protobuf::Message const*)>& continuation)
{
    uint32 const me = _session->GetBattlenetAccountId();
    std::vector<uint64> ids(request->account_ids().begin(), request->account_ids().end());
    continuation(this, ERROR_OK, response);
    continuation = nullptr;
    for (uint64 id : ids)
        if (uint32(id) != me && AreFriends(me, uint32(id)))
            if (Optional<AccountInfo> account = GetAccount(uint32(id)))
                SendAccountPresence(_session, *account);
    return ERROR_OK;
}

uint32 PresenceService::HandleBatchUnsubscribe(presence::v2::client::BatchUnsubscribeRequest const* /*request*/, NoData* /*response*/,
    std::function<void(ServiceBase*, uint32, google::protobuf::Message const*)>& /*continuation*/)
{
    return ERROR_OK;
}

uint32 PresenceService::HandleQuery(presence::v2::client::QueryRequest const* request, presence::v2::client::QueryResponse* response,
    std::function<void(ServiceBase*, uint32, google::protobuf::Message const*)>& /*continuation*/)
{
    uint32 const me = _session->GetBattlenetAccountId();
    uint32 const target = uint32(request->account_id());
    if (target != me && !AreFriends(me, target))
        return ERROR_OK;

    Optional<AccountInfo> account = GetAccount(target);
    if (!account)
        return ERROR_OK;

    uint64 const now = NowUs();
    Player const* player = FindOnlinePlayer(target);
    if (player && target != me && GetStatus(target).AppearOffline)
        player = nullptr;
    FillAccountState(response->add_states(), *account, player, !player && target != me && IsOnlineAnywhere(target), now);
    if (player)
        FillGameAccountState(response->add_states(), *account, player->GetSession(), player, now);
    return ERROR_OK;
}

uint32 PresenceService::HandleUpdate(presence::v2::client::UpdateRequest const* request, NoData* response,
    std::function<void(ServiceBase*, uint32, google::protobuf::Message const*)>& continuation)
{
    uint32 const me = _session->GetBattlenetAccountId();
    bool wasHidden = false;
    bool hidden = false;
    {
        std::scoped_lock guard(StatusLock);
        PresenceStatus& status = StatusCache[me];
        wasHidden = status.AppearOffline;
        for (presence::v2::PresenceFieldUpdate const& update : request->updates())
        {
            if (update.key().title_id() != ProgramBN || update.key().group() != 1)
                continue;
            uint32 const field = update.key().field();
            if (update.delete_() || !update.has_value())
                status.Fields.erase(field);
            else
                status.Fields[field] = update.value();
            if (field == AccountAppearOffline)
                status.AppearOffline = !update.delete_() && update.value().bool_value();
        }
        hidden = status.AppearOffline;
    }

    TC_LOG_INFO("network.rpc", "{} presence update: {}", _session->GetPlayerInfo(), request->ShortDebugString());

    // reply, then echo the new values to ourselves and tell our friends
    continuation(this, ERROR_OK, response);
    continuation = nullptr;

    uint64 const now = NowUs();
    presence::v2::PresenceStateUpdatedNotification own;
    presence::v2::PresenceFieldState* state = own.add_states();
    state->set_account_id(me);
    state->set_oldest_time_us(now);
    for (presence::v2::PresenceFieldUpdate const& update : request->updates())
    {
        presence::v2::PresenceField* field = state->add_fields();
        *field->mutable_key() = update.key();
        if (update.has_value())
            *field->mutable_value() = update.value();
        if (update.delete_())
            field->set_deleted(true);
        field->set_updated_time_us(now);
    }
    SendPresence(_session, own);

    Optional<AccountInfo> account = GetAccount(me);
    if (!account || (hidden && wasHidden))
        return ERROR_OK;
    for (uint32 friendId : CachedFriendIds(me))
        if (Player* friendPlayer = FindOnlinePlayer(friendId))
            SendAccountPresence(friendPlayer->GetSession(), *account);
    return ERROR_OK;
}

WhisperService::WhisperService(WorldSession* session) : BaseService(session) { }

uint32 WhisperService::HandleSubscribe(whisper::v2::client::SubscribeRequest const* /*request*/, whisper::v2::client::SubscribeResponse* /*response*/,
    std::function<void(ServiceBase*, uint32, google::protobuf::Message const*)>& /*continuation*/)
{
    return ERROR_OK;
}

uint32 WhisperService::HandleUnsubscribe(whisper::v2::client::UnsubscribeRequest const* /*request*/, NoData* /*response*/,
    std::function<void(ServiceBase*, uint32, google::protobuf::Message const*)>& /*continuation*/)
{
    return ERROR_OK;
}

uint32 WhisperService::HandleGetWhisperHistory(whisper::v2::client::GetWhisperHistoryRequest const* /*request*/,
    whisper::v2::client::GetWhisperHistoryResponse* response, std::function<void(ServiceBase*, uint32, google::protobuf::Message const*)>& /*continuation*/)
{
    response->set_continuation(0);
    return ERROR_OK;
}

uint32 WhisperService::HandleSendWhisper(whisper::v2::client::SendWhisperRequest const* request, whisper::v2::client::SendWhisperResponse* response,
    std::function<void(ServiceBase*, uint32, google::protobuf::Message const*)>& /*continuation*/)
{
    static std::atomic<uint64> position = 0;

    uint32 const me = _session->GetBattlenetAccountId();
    uint32 const target = uint32(request->target_account_id());
    std::string const& text = request->options().content();
    if (text.empty() || text.length() > 255 || !AreFriends(me, target))
        return ERROR_INVALID_TARGET_ID;

    Player* receiver = FindOnlinePlayer(target);
    if (!receiver)
        return ERROR_FRIENDS_RECEIVED_INVITATION_UNDELIVERABLE;      // not playing on this realm: the client says the friend is offline

    uint64 const now = NowUs();
    whisper::v2::Whisper* whisper = response->mutable_whisper();
    whisper->mutable_whisper_id()->set_epoch(now);
    whisper->mutable_whisper_id()->set_position(++position);
    whisper->set_sender_account_id(me);
    whisper->set_receiver_account_id(target);
    whisper->set_title_id(ProgramWoW);
    whisper->set_content(text);

    Optional<AccountInfo> self = GetAccount(me);
    whisper::v2::client::WhisperNotification notification;
    notification.set_subscriber_account_id(target);
    *notification.mutable_whisper() = *whisper;
    if (self && !self->BattleTag.empty())
        notification.set_target_battle_tag(self->BattleTag);
    SetHandle(notification.mutable_target_game_account(), _session->GetAccountId());
    Battlenet::WorldserverService<whisper::v2::client::WhisperListener>(receiver->GetSession()).OnWhisper(&notification, true, true);

    TC_LOG_INFO("chat.log.whisper", "{} Battle.net whisper to account {}: {}", _session->GetPlayerInfo(), target, text);
    return ERROR_OK;
}

uint32 WhisperService::HandleAdvanceViewTime(whisper::v2::client::AdvanceViewTimeRequest const* /*request*/, NoData* /*response*/,
    std::function<void(ServiceBase*, uint32, google::protobuf::Message const*)>& /*continuation*/)
{
    return ERROR_OK;
}

uint32 WhisperService::HandleAdvanceClearTime(whisper::v2::client::AdvanceClearTimeRequest const* /*request*/, NoData* /*response*/,
    std::function<void(ServiceBase*, uint32, google::protobuf::Message const*)>& /*continuation*/)
{
    return ERROR_OK;
}

uint32 WhisperService::HandleSetTypingIndicator(whisper::v2::client::SetTypingIndicatorRequest const* request, NoData* /*response*/,
    std::function<void(ServiceBase*, uint32, google::protobuf::Message const*)>& /*continuation*/)
{
    uint32 const me = _session->GetBattlenetAccountId();
    uint32 const target = uint32(request->target_account_id());
    if (!AreFriends(me, target))
        return ERROR_OK;

    if (Player* receiver = FindOnlinePlayer(target))
    {
        whisper::v2::client::TypingIndicatorNotification notification;
        notification.set_subscriber_account_id(target);
        notification.set_target_account_id(me);
        notification.set_indicator(request->indicator());
        Battlenet::WorldserverService<whisper::v2::client::WhisperListener>(receiver->GetSession()).OnTypingIndicator(&notification, true, true);
    }
    return ERROR_OK;
}
}

void BattlenetPresence::OnLogin(WorldSession* session)
{
    uint32 const accountId = session->GetBattlenetAccountId();
    Player const* player = session->GetPlayer();
    if (!player)
        return;

    // An account without a BattleTag has no name in its friends' lists (Whisper opened "Tell :" with no target, the Social window
    // showed a bare "#"). Until the player picks one with .battletag, it takes the first name of the character it enters the world
    // with. Bots are left alone.
    bool untagged = false;
    if (accountId && !session->IsBot() && ReadBattleTag(accountId).empty())
        untagged = AssignBattleTag(accountId, Trinity::BattleTag::NameFromCharacter(player->GetName()), true).empty()
            && ReadBattleTag(accountId).empty();

    {
        std::vector<uint32> ids = LoadFriendIds(accountId);
        std::scoped_lock guard(FriendCacheLock);
        FriendCache[accountId] = std::move(ids);
    }

    AccountInfo account = GetAccount(accountId).value_or(AccountInfo{ accountId, "" });
    uint64 const now = NowUs();

    // own presence: the client takes its BattleTag from it
    bgs::protocol::presence::v2::PresenceStateUpdatedNotification own;
    FillAccountState(own.add_states(), account, player, false, now);
    FillGameAccountState(own.add_states(), account, session, player, now);
    SendPresence(session, own);
    TC_LOG_INFO("network.rpc", "{} presence: own state (BattleTag '{}')", session->GetPlayerInfo(), account.BattleTag);

    // we are online: tell our friends
    NotifyFriends(accountId, [&](bgs::protocol::presence::v2::PresenceStateUpdatedNotification& notification)
    {
        FillAccountState(notification.add_states(), account, player, false, now);
        FillGameAccountState(notification.add_states(), account, session, player, now);
    });

    if (untagged)
        ChatHandler(session).SendSysMessage("You have no BattleTag yet, so Battle.net friends can't whisper you. Pick one with .battletag <name>.");
}

std::string BattlenetPresence::GetBattleTag(WorldSession const* session)
{
    return session->GetBattlenetAccountId() ? ReadBattleTag(session->GetBattlenetAccountId()) : std::string();
}

BattlenetPresence::BattleTagResult BattlenetPresence::SetBattleTag(WorldSession* session, std::string const& name, std::string& tag)
{
    uint32 const accountId = session->GetBattlenetAccountId();
    if (!accountId)
        return BattleTagResult::NoAccount;
    if (!Trinity::BattleTag::IsValidName(name))
        return BattleTagResult::InvalidName;

    tag = AssignBattleTag(accountId, name, false);
    if (tag.empty())
        return BattleTagResult::NoFreeNumber;

    // the new tag to the player (Social window) and to online friends (their list and whisper target)
    if (Player const* player = session->GetPlayer())
    {
        AccountInfo const account{ accountId, tag };
        uint64 const now = NowUs();
        bgs::protocol::presence::v2::PresenceStateUpdatedNotification own;
        FillAccountState(own.add_states(), account, player, false, now);
        FillGameAccountState(own.add_states(), account, session, player, now);
        SendPresence(session, own);
        for (uint32 friendId : CachedFriendIds(accountId))
            if (Player* friendPlayer = FindOnlinePlayer(friendId))
                SendAccountPresence(friendPlayer->GetSession(), account);
    }
    return BattleTagResult::Ok;
}

void BattlenetPresence::OnLogout(WorldSession* session)
{
    uint32 const accountId = session->GetBattlenetAccountId();
    AccountInfo account = GetAccount(accountId).value_or(AccountInfo{ accountId, "" });
    uint64 const now = NowUs();
    NotifyFriends(accountId, [&](bgs::protocol::presence::v2::PresenceStateUpdatedNotification& notification)
    {
        FillAccountState(notification.add_states(), account, nullptr, false, now);
        FillGameAccountState(notification.add_states(), account, session, nullptr, now);
    });

    {
        std::scoped_lock guard(FriendCacheLock);
        FriendCache.erase(accountId);
    }
    std::scoped_lock guard(StatusLock);
    StatusCache.erase(accountId);
}

void BattlenetPresence::OnCharacterChanged(Player const* player)
{
    WorldSession* session = player->GetSession();
    if (!session || !player->IsInWorld())
        return;

    uint32 const accountId = session->GetBattlenetAccountId();
    if (CachedFriendIds(accountId).empty() || GetStatus(accountId).AppearOffline)
        return;

    AccountInfo account = GetAccount(accountId).value_or(AccountInfo{ accountId, "" });
    uint64 const now = NowUs();
    NotifyFriends(accountId, [&](bgs::protocol::presence::v2::PresenceStateUpdatedNotification& notification)
    {
        FillGameAccountState(notification.add_states(), account, session, player, now);
    });
}
