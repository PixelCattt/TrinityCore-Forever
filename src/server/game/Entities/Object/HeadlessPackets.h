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

#ifndef TRINITYCORE_HEADLESS_PACKETS_H
#define TRINITYCORE_HEADLESS_PACKETS_H

#include "Define.h"
#include <atomic>

class Player;

// A bot session has no client: every object update the server builds for it is thrown away in its SendPacket. Building those
// updates is most of the cost of a busy map (each changed unit is written once for every player that sees it, and nearly every
// player on a bot realm is a bot). When this is on, the create, values, out of range and destroy blocks are not built for a bot at
// all. What the server knows about visibility (the player's client guid list, HaveAtClient) is kept exactly as before, so no game
// rule sees a difference. Config: Bots.SkipClientPackets (worldserver.conf, default 1, `.reload config` applies it). Every use of
// that guid list in the core decides a packet (sends, quest giver status, group member updates), which is what SkipVisibility
// below relies on.
namespace Trinity::HeadlessPackets
{
    TC_GAME_API extern std::atomic<bool> Enabled;

    // True when no update packet needs to be built for this player (a bot session with the switch on).
    TC_GAME_API bool Skip(Player const* receiver);

    // A bot as the viewer: which objects its client would have in view only decides which packets it gets, and it gets none. With
    // Bots.SkipClientVisibility (default 1) a bot keeps no client guid list and the per-object visibility checks for it
    // (CanSeeOrDetect for every object near it, on every move and every visibility pass) are not run. What other players and
    // creatures see of the bot, and creature aggro on it, are unchanged.
    TC_GAME_API extern std::atomic<bool> VisibilityEnabled;
    TC_GAME_API bool SkipVisibility(Player const* viewer);
}

#endif
