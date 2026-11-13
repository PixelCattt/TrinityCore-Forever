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

// Classic 1.60 Social window, Allies tab. Layouts from an official sniff (70235, 2026-10-06):
//   window opens: Classic CMSG 0x44017C (no data) -> SMSG 0x460359 uint32 0, and CMSG 0x44019C (uint32 0) -> SMSG 0x460364:
//   uint32 count, per ally { packed player guid, 16 bytes (0 in every entry seen), uint32 n,
//                            n x { uint8 type, int64 unix time, int32 value, int32 0 }, uint32 0 }
// Interaction types are the client's Enum.RolodexType (order from Blizzard_RecentAlliesUtil.lua): 0 None, 1 PartyMember, 2 RaidMember,
// 3 Trade, 4 Whisper, 5-10 crafting orders, 11 CreatureKill ("fought together"), 12 CompleteDungeon, ... The value is the area the
// interaction happened in (official sniff: 11 with 16600..16850, 3 / 4 with 0). At most one per type and ally.

#include "Packet.h"
#include "RecentAllies.h"
#include "DatabaseEnv.h"
#include "GameTime.h"
#include "Group.h"
#include "Creature.h"
#include "Log.h"
#include "StringFormat.h"
#include "ThreatManager.h"
#include <mutex>
#include "ObjectAccessor.h"
#include "Opcodes.h"
#include "Player.h"
#include "Util.h"
#include "WorldPacket.h"
#include "WorldSession.h"

namespace
{
    constexpr uint8 InteractionPartyMember = 1;
    constexpr uint8 InteractionRaidMember = 2;
    constexpr uint8 InteractionTrade = 3;
    constexpr uint8 InteractionWhisper = 4;
    constexpr uint8 InteractionCreatureKill = 11;
    constexpr time_t KeepSeconds = 30 * DAY;
    constexpr size_t MaxAllies = 50;
    constexpr time_t RepeatSeconds = 5 * MINUTE;       // whispers and kills: the same pair is saved again at most every 5 minutes
    constexpr size_t MaxFightersPerKill = 10;

    void Record(ObjectGuid const& who, ObjectGuid const& ally, uint8 type, uint32 value)
    {
        CharacterDatabase.PExecute("REPLACE INTO character_recent_allies (guid, ally, type, time, value) VALUES ({}, {}, {}, {}, {})",
            who.GetCounter(), ally.GetCounter(), type, uint64(GameTime::GetGameTime()), value);
    }

    // both directions; throttled interactions are skipped when the pair was saved less than RepeatSeconds ago
    void RecordPair(ObjectGuid const& a, ObjectGuid const& b, uint8 type, uint32 value, bool throttled)
    {
        if (a == b)
            return;

        if (throttled)
        {
            static std::mutex lock;
            static std::unordered_map<std::string, time_t> lastSaved;
            ObjectGuid::LowType const low = std::min(a.GetCounter(), b.GetCounter());
            ObjectGuid::LowType const high = std::max(a.GetCounter(), b.GetCounter());
            std::string const key = Trinity::StringFormat("{}:{}:{}", low, high, type);
            time_t const now = GameTime::GetGameTime();

            std::scoped_lock guard(lock);
            if (lastSaved.size() > 100000)
                lastSaved.clear();
            time_t& last = lastSaved[key];
            if (now - last < RepeatSeconds)
                return;
            last = now;
        }

        Record(a, b, type, value);
        Record(b, a, type, value);
    }
}

void RecentAllies::OnGroupJoin(Group const* group, Player const* newcomer)
{
    if (!group || !newcomer)
        return;

    uint32 const zone = newcomer->GetZoneId();
    uint8 const type = group->isRaidGroup() ? InteractionRaidMember : InteractionPartyMember;
    for (Group::MemberSlot const& slot : group->GetMemberSlots())
    {
        if (slot.guid == newcomer->GetGUID())
            continue;
        RecordPair(newcomer->GetGUID(), slot.guid, type, zone, false);
    }
}

void RecentAllies::OnTrade(Player const* player, Player const* trader)
{
    if (player && trader)
        RecordPair(player->GetGUID(), trader->GetGUID(), InteractionTrade, 0, false);
}

void RecentAllies::OnWhisper(Player const* sender, Player const* receiver)
{
    if (sender && receiver)
        RecordPair(sender->GetGUID(), receiver->GetGUID(), InteractionWhisper, 0, true);
}

void RecentAllies::OnCreatureKill(Creature* creature)
{
    if (!creature || creature->IsPet() || creature->IsTotem())
        return;

    std::vector<ObjectGuid> fighters;
    for (ThreatReference const* ref : creature->GetThreatManager().GetUnsortedThreatList())
    {
        Player const* player = ref->GetVictim()->GetCharmerOrOwnerPlayerOrPlayerItself();
        if (player && std::ranges::find(fighters, player->GetGUID()) == fighters.end())
            fighters.push_back(player->GetGUID());
        if (fighters.size() >= MaxFightersPerKill)
            break;
    }

    uint32 const zone = creature->GetZoneId();
    for (std::size_t i = 0; i < fighters.size(); ++i)
        for (std::size_t j = i + 1; j < fighters.size(); ++j)
            RecordPair(fighters[i], fighters[j], InteractionCreatureKill, zone, true);
}

void WorldSession::HandleRecentAllyProbe(WorldPackets::Null& packet)
{
    WorldPacket const* raw = packet.GetRawPacket();
    switch (packet.GetOpcode())
    {
        case CMSG_CLASSIC_SOCIAL_WINDOW_OPEN:
        {
            WorldPacket response(SMSG_CLASSIC_SOCIAL_WINDOW_OPEN_RESPONSE, 4);
            response << uint32(0);
            SendPacket(&response);
            break;
        }
        case CMSG_RECENT_ALLY_REQUEST_DATA:
        {
            ObjectGuid::LowType const me = _player->GetGUID().GetCounter();
            time_t const since = GameTime::GetGameTime() - KeepSeconds;
            CharacterDatabase.PExecute("DELETE FROM character_recent_allies WHERE guid = {} AND time < {}", me, uint64(since));

            // allies by their latest interaction, newest first; each with its interactions (one per type)
            std::vector<std::pair<ObjectGuid::LowType, std::vector<std::tuple<uint8, int64, int32>>>> allies;
            if (QueryResult result = CharacterDatabase.PQuery(
                "SELECT ally, type, time, value FROM character_recent_allies WHERE guid = {} AND time >= {} ORDER BY time DESC", me, uint64(since)))
            {
                do
                {
                    Field* fields = result->Fetch();
                    ObjectGuid::LowType const ally = fields[0].GetUInt64();
                    auto itr = std::find_if(allies.begin(), allies.end(), [&](auto const& a) { return a.first == ally; });
                    if (itr == allies.end())
                    {
                        if (allies.size() >= MaxAllies)
                            continue;
                        itr = allies.emplace(allies.end(), ally, std::vector<std::tuple<uint8, int64, int32>>());
                    }
                    itr->second.emplace_back(fields[1].GetUInt8(), int64(fields[2].GetUInt64()), int32(fields[3].GetUInt32()));
                } while (result->NextRow());
            }

            WorldPacket response(SMSG_RECENT_ALLY_LIST, 4 + allies.size() * 48);
            response << uint32(allies.size());
            for (auto const& [ally, interactions] : allies)
            {
                // online allies: their zone in the 4th uint32 and uint32 0xC0000000 after the interactions (official sniff: an online
                // ally in Thunder Bluff had 0, 0, 0, 1638 and 00 00 00 C0; offline ones all zero)
                ObjectGuid const allyGuid = ObjectGuid::Create<HighGuid::Player>(ally);
                Player const* online = ObjectAccessor::FindConnectedPlayer(allyGuid);
                response << allyGuid;
                response << uint32(0) << uint32(0) << uint32(0) << uint32(online ? online->GetZoneId() : 0);
                response << uint32(interactions.size());
                for (auto const& [type, time, value] : interactions)
                {
                    response << uint8(type);
                    response << int64(time);
                    response << int32(value);
                    response << int32(0);
                }
                response << uint32(online ? 0xC0000000 : 0);
            }
            SendPacket(&response);
            break;
        }
        default:            // CMSG_RECENT_ALLY_SET_NOTE: layout not seen yet; logged to learn it
            TC_LOG_INFO("network.opcode", "RecentAllies: {} size {} data {} from {}", GetOpcodeNameForLogging(packet.GetOpcode()), raw->size(),
                Trinity::Impl::ByteArrayToHexStr(raw->data(), std::min<size_t>(raw->size(), 256)), GetPlayerInfo());
            break;
    }
}
