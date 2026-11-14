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

#ifndef TRINITY_CLASSIC_VANILLA_AOE_H
#define TRINITY_CLASSIC_VANILLA_AOE_H

#include <cstdint>

// Forever.VanillaAoE (worldserver.conf, default 0 = the WoW Forever spells): puts the two AoE spells WoW Forever reworked back to
// vanilla 1.12.
//
// Consecration. Forever (client 70790 / 70938): every rank casts a tick spell once a second for 8 sec. Effect 0 of the tick is a
// small hit with no spell power (rank 1: 2), effect 1 is the bigger hit with the spell power (rank 1: 4, coefficient 0.042), and the
// text says only "the first $s3" (4) enemies take effect 1. Vanilla (VMaNGOS spell_template): one hit a second on every enemy in
// it, base points + 1d1 (rank 1: 7 + 1 = 8, 64 over 8 sec), about 33% spell power over the 8 ticks (0.042 a tick, as Forever's
// effect 1). With the switch on, the tick casts effect 0 for 0 and effect 1 for the vanilla tick, so the spell power stays on.
// Mana is vanilla already (SpellPower.db2: 135 / 235 / 320 / 435 / 565).
//
// Improved Blizzard (talent 11185, 3 ranks through curve 83071): Forever chills 15 / 25 / 40%, vanilla 30 / 50 / 65% (12484 /
// 12485 / 12486), 1.5 sec in both.
//
// Pure: no game types, so tests/game/ClassicVanillaAoe.cpp can check it.
namespace ClassicVanillaAoe
{
    struct ConsecrationRank
    {
        uint32_t RankSpell;      // the spell the paladin casts
        uint32_t TickSpell;      // what each 1 sec tick casts at the consecrated spot
        uint32_t TickEffect0Id;  // SpellEffect.db2 row of the tick's effect 0 (the hit every enemy takes)
        uint32_t TickEffect1Id;  // SpellEffect.db2 row of the tick's effect 1 (the "first 4" hit)
        int32_t VanillaTick;     // vanilla damage a tick before spell power (VMaNGOS base points + 1d1)
    };

    inline constexpr ConsecrationRank ConsecrationRanks[] =
    {
        { 26573, 1280345, 1293268, 1330578,  8 },  // rank 1, level 20:  64 over 8 sec
        { 20116, 1280346, 1293269, 1330580, 15 },  // rank 2, level 30: 120
        { 20922, 1280347, 1293270, 1330583, 24 },  // rank 3, level 40: 192
        { 20923, 1280348, 1293271, 1330584, 35 },  // rank 4, level 50: 280
        { 20924, 1280349, 1293272, 1330586, 48 },  // rank 5, level 60: 384
    };

    inline constexpr ConsecrationRank const* FindConsecrationRank(uint32_t rankSpell)
    {
        for (ConsecrationRank const& rank : ConsecrationRanks)
            if (rank.RankSpell == rankSpell)
                return &rank;
        return nullptr;
    }

    // The tick spell of a Consecration rank, 0 when the spell is not one.
    inline constexpr uint32_t ConsecrationTickSpell(uint32_t rankSpell)
    {
        ConsecrationRank const* rank = FindConsecrationRank(rankSpell);
        return rank ? rank->TickSpell : 0;
    }

    // Improved Blizzard talent rows (curve 83071, CurvePoint.db2): rank 1, 2, 3.
    inline constexpr uint32_t ImprovedBlizzardCurvePoints[] = { 241076, 241077, 241078 };
    inline constexpr int32_t ImprovedBlizzardForever[] = { -15, -25, -40 };
    inline constexpr int32_t ImprovedBlizzardVanilla[] = { -30, -50, -65 };

    // The chill (a negative speed percent) for the talent amount the player has. A Forever rank amount becomes the vanilla one of
    // the same rank; anything else (a vanilla amount already, a changed curve) stays as it is.
    inline constexpr int32_t ImprovedBlizzardChill(int32_t talentAmount)
    {
        for (int i = 0; i < 3; ++i)
            if (talentAmount == ImprovedBlizzardForever[i])
                return ImprovedBlizzardVanilla[i];
        return talentAmount;
    }
}

#endif // TRINITY_CLASSIC_VANILLA_AOE_H
