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

#include "CombatLogWatch.h"
#include "CombatLogPacketsCommon.h"
#include "Group.h"
#include "GroupMgr.h"
#include "ObjectAccessor.h"
#include "ObjectGuid.h"
#include "Player.h"
#include "World.h"
#include "WorldSession.h"
#include <atomic>
#include <mutex>
#include <shared_mutex>
#include <unordered_map>

namespace
{
    struct Watch
    {
        uint32 WatcherAccountId = 0;
        ObjectGuid Watched;
        ObjectGuid WatchedGroup;    // empty unless the whole group is watched
    };

    std::shared_mutex WatchesLock;
    std::unordered_map<ObjectGuid, Watch> Watches;  // key: the watching GM
    std::atomic<bool> AnyWatch{ false };            // lets Deliver return at once while nobody watches

    // true when the watched unit, or a member of the watched group, is within range of source on source's map
    bool IsWatchedNear(WorldObject const* source, Watch const& watch, float range)
    {
        if (Unit const* watched = ObjectAccessor::GetUnit(*source, watch.Watched))
            if (source->IsWithinDistInMap(watched, range))
                return true;

        if (watch.WatchedGroup.IsEmpty())
            return false;

        Group const* group = sGroupMgr->GetGroupByGUID(watch.WatchedGroup);
        if (!group)
            return false;

        for (GroupReference const& member : group->GetMembers())
            if (Player const* player = member.GetSource())
                if (source->IsWithinDistInMap(player, range))
                    return true;

        return false;
    }
}

void CombatLogWatch::Start(Player const* watcher, Unit const* watched, bool wholeGroup)
{
    Watch watch;
    watch.WatcherAccountId = watcher->GetSession()->GetAccountId();
    watch.Watched = watched->GetGUID();
    if (wholeGroup)
        if (Player const* player = watched->ToPlayer())
            if (Group const* group = player->GetGroup())
                watch.WatchedGroup = group->GetGUID();

    std::unique_lock lock(WatchesLock);
    Watches[watcher->GetGUID()] = watch;
    AnyWatch.store(true, std::memory_order_relaxed);
}

bool CombatLogWatch::Stop(ObjectGuid const& watcher)
{
    if (!AnyWatch.load(std::memory_order_relaxed))
        return false;

    std::unique_lock lock(WatchesLock);
    bool const removed = Watches.erase(watcher) > 0;
    AnyWatch.store(!Watches.empty(), std::memory_order_relaxed);
    return removed;
}

void CombatLogWatch::Deliver(WorldObject const* source, WorldPackets::CombatLog::CombatLogServerPacket const* combatLog)
{
    if (!AnyWatch.load(std::memory_order_relaxed))
        return;

    float const range = source->GetVisibilityRange();

    std::shared_lock lock(WatchesLock);
    for (auto const& [watcherGuid, watch] : Watches)
    {
        // a GM in range already got this message from SendCombatLogMessage
        if (Player const* watcherHere = ObjectAccessor::GetPlayer(*source, watcherGuid))
            if (source->IsWithinDistInMap(watcherHere, range))
                continue;

        if (!IsWatchedNear(source, watch, range))
            continue;

        // the GM may be on another map: send through the session (thread safe), never touch the GM's Player here
        WorldSession* session = sWorld->FindSession(watch.WatcherAccountId);
        if (!session || !session->GetPlayer() || session->GetPlayer()->GetGUID() != watcherGuid)
            continue;

        session->SendPacket(combatLog->GetFullLogPacket());
    }
}
