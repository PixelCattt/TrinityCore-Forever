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

#ifndef TRINITY_CLASSIC_VERSUS_BONUS_H
#define TRINITY_CLASSIC_VERSUS_BONUS_H

#include <cstdint>

// Classic 1.60 (WoW Forever): item effects that are stronger against one kind of enemy, which only the tooltip names ("Deals $s2 times as much
// damage to Plants", "Attacks against Dwarves are $s2 times as likely to activate this effect", "Restores $s1 times as much if attacking an
// Earth Elemental"). The factor is the base points of one effect of the spell (a dummy that does nothing else); the kind of enemy is either a
// creature type (Beast, Undead) or a group no creature field holds (Trolls, Plants, Naga), kept per creature entry in creature_versus_group.
// Tables: spell_versus_bonus (the spells) and creature_versus_group (the creatures), loaded by SpellMgr::LoadClassicVersusBonus.
namespace ClassicVersusBonus
{
    // creature_versus_group.groups and spell_versus_bonus.versus_groups bits
    enum Group : uint32_t
    {
        GROUP_TROLL           = 0x0001,
        GROUP_ORC             = 0x0002,
        GROUP_DWARF           = 0x0004,
        GROUP_PLANT           = 0x0008,
        GROUP_AQUATIC         = 0x0010,
        GROUP_EARTH_ELEMENTAL = 0x0020,
        GROUP_GOLEM           = 0x0040,
        GROUP_TITAN_FORGED    = 0x0080,
        GROUP_FIRE_ELEMENTAL  = 0x0100,
        GROUP_MOUNTAIN_GIANT  = 0x0200,
        GROUP_NAGA            = 0x0400,
        GROUP_SATYR           = 0x0800,
        GROUP_DINOSAUR        = 0x1000,
        GROUP_SERPENTINE      = 0x2000,
        GROUP_ALL             = 0x3FFF
    };

    // spell_versus_bonus.kind: what the factor scales
    enum class Kind : uint8_t
    {
        Damage     = 0, // every damage effect of the spell, direct and periodic (spell_id is the spell that deals the damage)
        ProcChance = 1, // the proc chance of the aura spell_id; the effect holding the factor is only a number and never procs itself
        Restore    = 2, // the amount of the spell the aura spell_id triggers on proc (mana, health)
        Max
    };

    // Player races that are one of the groups: a troll, orc or dwarf player is one too (race ids 8, 2, 3)
    inline uint32_t GroupsOfRace(uint8_t race)
    {
        switch (race)
        {
            case 2: return GROUP_ORC;
            case 3: return GROUP_DWARF;
            case 8: return GROUP_TROLL;
            default: return 0;
        }
    }

    // A target counts when it is in one of the row's groups or of one of its creature types (creatureTypeMask: 1 << (type - 1)).
    inline bool Matches(uint32_t rowGroups, uint32_t rowTypes, uint32_t targetGroups, uint32_t targetTypeMask)
    {
        return (rowGroups & targetGroups) != 0 || (rowTypes & targetTypeMask) != 0;
    }

    // The factor a row applies: the stated override, else the base points of the holding effect. A factor below 1 would weaken the effect
    // against the very enemies it is meant for, so it is never applied (a missing or zero effect reads as 1).
    inline float Factor(float overrideFactor, float basePoints)
    {
        float const factor = overrideFactor > 0.0f ? overrideFactor : basePoints;
        return factor > 1.0f ? factor : 1.0f;
    }
}

#endif
