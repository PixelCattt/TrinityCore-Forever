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

#ifndef TRINITYCORE_FRIENDS_SERVICE_H
#define TRINITYCORE_FRIENDS_SERVICE_H

#include "WorldserverService.h"
#include "Client/api/client/v2/friends_service.pb.h"
#include "Client/api/client/v2/presence_service.pb.h"
#include "Client/api/client/v2/whisper_service.pb.h"

class Player;

// Battle.net friends (BattleTag friends) for the Classic 1.60 client. In game the client sends its Battle.net calls through the world
// connection (CMSG_BATTLENET_REQUEST); the official server answers friends v2 Subscribe / GetSentInvitations / GetReceivedInvitations /
// GetFriends at login and pushes presence (presence v2 PresenceListener.OnPresenceStateUpdated), which carries BattleTags, who is online
// and their character. Friends and invitations are in auth (battlenet_friends, battlenet_friend_invitations), shared by every realm.
namespace Battlenet::Services
{
class FriendsService : public WorldserverService<friends::v2::client::FriendsService>
{
    typedef WorldserverService<friends::v2::client::FriendsService> BaseService;

public:
    FriendsService(WorldSession* session);

    uint32 HandleSubscribe(friends::v2::client::SubscribeRequest const* request, NoData* response, std::function<void(ServiceBase*, uint32, ::google::protobuf::Message const*)>& continuation) override;
    uint32 HandleUnsubscribe(friends::v2::client::UnsubscribeRequest const* request, NoData* response, std::function<void(ServiceBase*, uint32, ::google::protobuf::Message const*)>& continuation) override;
    uint32 HandleGetSentInvitations(friends::v2::client::GetSentInvitationsRequest const* request, friends::v2::client::GetSentInvitationsResponse* response, std::function<void(ServiceBase*, uint32, ::google::protobuf::Message const*)>& continuation) override;
    uint32 HandleGetReceivedInvitations(friends::v2::client::GetReceivedInvitationsRequest const* request, friends::v2::client::GetReceivedInvitationsResponse* response, std::function<void(ServiceBase*, uint32, ::google::protobuf::Message const*)>& continuation) override;
    uint32 HandleGetFriends(friends::v2::client::GetFriendsRequest const* request, friends::v2::client::GetFriendsResponse* response, std::function<void(ServiceBase*, uint32, ::google::protobuf::Message const*)>& continuation) override;
    uint32 HandleIsFriend(friends::v2::client::IsFriendRequest const* request, friends::v2::client::IsFriendResponse* response, std::function<void(ServiceBase*, uint32, ::google::protobuf::Message const*)>& continuation) override;
    uint32 HandleSendInvitation(friends::v2::client::SendInvitationRequest const* request, NoData* response, std::function<void(ServiceBase*, uint32, ::google::protobuf::Message const*)>& continuation) override;
    uint32 HandleAcceptInvitation(friends::v2::client::AcceptInvitationRequest const* request, NoData* response, std::function<void(ServiceBase*, uint32, ::google::protobuf::Message const*)>& continuation) override;
    uint32 HandleRevokeInvitation(friends::v2::client::RevokeInvitationRequest const* request, NoData* response, std::function<void(ServiceBase*, uint32, ::google::protobuf::Message const*)>& continuation) override;
    uint32 HandleRevokeAllInvitations(friends::v2::client::RevokeAllInvitationsRequest const* request, NoData* response, std::function<void(ServiceBase*, uint32, ::google::protobuf::Message const*)>& continuation) override;
    uint32 HandleIgnoreInvitation(friends::v2::client::IgnoreInvitationRequest const* request, NoData* response, std::function<void(ServiceBase*, uint32, ::google::protobuf::Message const*)>& continuation) override;
    uint32 HandleRemoveFriend(friends::v2::client::RemoveFriendRequest const* request, NoData* response, std::function<void(ServiceBase*, uint32, ::google::protobuf::Message const*)>& continuation) override;
    uint32 HandleUpdateFriendState(friends::v2::client::UpdateFriendStateRequest const* request, NoData* response, std::function<void(ServiceBase*, uint32, ::google::protobuf::Message const*)>& continuation) override;

private:
    uint32 RemoveInvitation(uint64 invitationId, bool asInvitee, uint32 reason);
};

// Battle.net presence (presence v2): the client's own status (away / busy / appear offline) and presence queries
class PresenceService : public WorldserverService<presence::v2::client::PresenceService>
{
    typedef WorldserverService<presence::v2::client::PresenceService> BaseService;

public:
    PresenceService(WorldSession* session);

    uint32 HandleBatchSubscribe(presence::v2::client::BatchSubscribeRequest const* request, NoData* response, std::function<void(ServiceBase*, uint32, ::google::protobuf::Message const*)>& continuation) override;
    uint32 HandleBatchUnsubscribe(presence::v2::client::BatchUnsubscribeRequest const* request, NoData* response, std::function<void(ServiceBase*, uint32, ::google::protobuf::Message const*)>& continuation) override;
    uint32 HandleQuery(presence::v2::client::QueryRequest const* request, presence::v2::client::QueryResponse* response, std::function<void(ServiceBase*, uint32, ::google::protobuf::Message const*)>& continuation) override;
    uint32 HandleUpdate(presence::v2::client::UpdateRequest const* request, NoData* response, std::function<void(ServiceBase*, uint32, ::google::protobuf::Message const*)>& continuation) override;
};

// Battle.net whispers between friends (whisper v2), delivered when the friend plays on this realm
class WhisperService : public WorldserverService<whisper::v2::client::WhisperService>
{
    typedef WorldserverService<whisper::v2::client::WhisperService> BaseService;

public:
    WhisperService(WorldSession* session);

    uint32 HandleSubscribe(whisper::v2::client::SubscribeRequest const* request, whisper::v2::client::SubscribeResponse* response, std::function<void(ServiceBase*, uint32, ::google::protobuf::Message const*)>& continuation) override;
    uint32 HandleUnsubscribe(whisper::v2::client::UnsubscribeRequest const* request, NoData* response, std::function<void(ServiceBase*, uint32, ::google::protobuf::Message const*)>& continuation) override;
    uint32 HandleGetWhisperHistory(whisper::v2::client::GetWhisperHistoryRequest const* request, whisper::v2::client::GetWhisperHistoryResponse* response, std::function<void(ServiceBase*, uint32, ::google::protobuf::Message const*)>& continuation) override;
    uint32 HandleSendWhisper(whisper::v2::client::SendWhisperRequest const* request, whisper::v2::client::SendWhisperResponse* response, std::function<void(ServiceBase*, uint32, ::google::protobuf::Message const*)>& continuation) override;
    uint32 HandleAdvanceViewTime(whisper::v2::client::AdvanceViewTimeRequest const* request, NoData* response, std::function<void(ServiceBase*, uint32, ::google::protobuf::Message const*)>& continuation) override;
    uint32 HandleAdvanceClearTime(whisper::v2::client::AdvanceClearTimeRequest const* request, NoData* response, std::function<void(ServiceBase*, uint32, ::google::protobuf::Message const*)>& continuation) override;
    uint32 HandleSetTypingIndicator(whisper::v2::client::SetTypingIndicatorRequest const* request, NoData* response, std::function<void(ServiceBase*, uint32, ::google::protobuf::Message const*)>& continuation) override;
};
}

namespace BattlenetPresence
{
    TC_GAME_API void OnLogin(WorldSession* session);            // character in world: own presence, and tell online friends
    TC_GAME_API void OnLogout(WorldSession* session);           // tell online friends we went offline
    TC_GAME_API void OnCharacterChanged(Player const* player);  // zone or level: tell online friends

    enum class BattleTagResult
    {
        Ok,
        NoAccount,          // a game account without a Battle.net account
        InvalidName,        // not 2-12 letters and digits starting with a letter
        NoFreeNumber        // the name is full, or the tag was taken meanwhile
    };

    // .battletag: the player picks the name, the server draws the number ("Name#1234")
    TC_GAME_API std::string GetBattleTag(WorldSession const* session);
    TC_GAME_API BattleTagResult SetBattleTag(WorldSession* session, std::string const& name, std::string& tag);
}

#endif // TRINITYCORE_FRIENDS_SERVICE_H
