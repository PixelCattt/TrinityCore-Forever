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

#ifndef TRINITYCORE_COMBAT_LOG_WATCH_H
#define TRINITYCORE_COMBAT_LOG_WATCH_H

#include "Define.h"

class ObjectGuid;
class Player;
class Unit;
class WorldObject;

namespace WorldPackets::CombatLog
{
    class CombatLogServerPacket;
}

// Lets a GM receive the combat log around a unit, or around every member of its group, from any distance
// (.gm combatlog). Each GM has at most one watch; nobody watches unless a GM starts one, so the combat
// log costs nothing extra by default. The watch ends with .gm combatlog stop or when the GM logs out.
namespace CombatLogWatch
{
    // wholeGroup: also watch every member of the watched player's group (the group as it is at the time of the event)
    TC_GAME_API void Start(Player const* watcher, Unit const* watched, bool wholeGroup);

    // returns false when the GM had no watch
    TC_GAME_API bool Stop(ObjectGuid const& watcher);

    // Called after a combat log message was sent to the players in range of source (map update thread).
    // Sends it to every GM whose watched unit (or a member of the watched group) is in range of source,
    // unless that GM is in range already and so got it the normal way.
    TC_GAME_API void Deliver(WorldObject const* source, WorldPackets::CombatLog::CombatLogServerPacket const* combatLog);
}

#endif // TRINITYCORE_COMBAT_LOG_WATCH_H
