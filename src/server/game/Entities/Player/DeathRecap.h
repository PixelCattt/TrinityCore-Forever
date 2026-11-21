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

#ifndef TRINITY_DEATH_RECAP_H
#define TRINITY_DEATH_RECAP_H

#include "Define.h"
#include "ObjectGuid.h"
#include <string>
#include <vector>

class Player;
class WorldObject;
struct CalcDamageInfo;
struct SpellNonMeleeDamage;

namespace WorldPackets::Query
{
    class QueryCreatureResponse;
}

namespace WorldPackets::Spells
{
    class MirrorImageComponentedData;
}

// Deathcam: records what happens around players (positions, health, casts, swings) for the last seconds, and on
// death lets anyone on the same map watch it again. The replay is acted out by private copies (visible only to the
// viewer) while the viewer's camera follows the copy of the player who died. Configured by Recap.* in worldserver.conf.
namespace DeathRecap
{
    TC_GAME_API void LoadConfig();

    // recording
    TC_GAME_API void RecordFrame(Player* player, uint32 diff);
    TC_GAME_API void RecordCast(WorldObject const* caster, bool start, uint32 spellId, int32 spellXSpellVisualId, int32 scriptVisualId,
        uint32 castTime, uint32 castFlags, ObjectGuid const& target);
    TC_GAME_API void RecordMelee(CalcDamageInfo const* damageInfo);
    TC_GAME_API void RecordSpellDamage(SpellNonMeleeDamage const* log);
    TC_GAME_API void OnPlayerDeath(Player* player);

    // inspection (.deathrecap): the last recorded death of a player as plain text lines (offsets from the death,
    // positions, health, casts), at most maxLines lines; empty if no death of that player is still recorded
    TC_GAME_API std::vector<std::string> GetLastDeathLines(ObjectGuid const& victim, size_t maxLines);

    // replay
    TC_GAME_API std::string Watch(Player* viewer, uint32 recapId);   // empty on success, otherwise the reason
    TC_GAME_API void Stop(Player* viewer, char const* reason);
    TC_GAME_API void UpdateViewer(Player* viewer);
    TC_GAME_API void OnRemoveFromWorld(Player* player);

    // names of the replayed players (creature entries of the actor pool)
    TC_GAME_API bool BuildCreatureQuery(uint32 entry, WorldPackets::Query::QueryCreatureResponse& response);
    // appearance of a replayed player (the actor is a mirror image of them)
    TC_GAME_API bool BuildMirrorImage(ObjectGuid const& actor, WorldPackets::Spells::MirrorImageComponentedData& data);
}

#endif
