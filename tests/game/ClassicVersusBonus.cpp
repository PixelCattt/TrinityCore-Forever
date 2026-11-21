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
#include "tc_catch2.h"

#include "../../src/server/game/Spells/ClassicVersusBonus.h"

using namespace ClassicVersusBonus;

TEST_CASE("A versus bonus counts a target in one of its groups or creature types", "[ClassicVersusBonus]")
{
    uint32_t const beastMask = 1u << (1 - 1);
    uint32_t const humanoidMask = 1u << (7 - 1);

    // Treant's Bane: Plants only
    CHECK(Matches(GROUP_PLANT, 0, GROUP_PLANT, 1u << (4 - 1)));
    CHECK_FALSE(Matches(GROUP_PLANT, 0, 0, 1u << (4 - 1)));                 // a water elemental is no plant
    CHECK_FALSE(Matches(GROUP_PLANT, 0, GROUP_AQUATIC, beastMask));

    // Angerforge's Battle Axe: Trolls and Orcs
    CHECK(Matches(GROUP_TROLL | GROUP_ORC, 0, GROUP_ORC, humanoidMask));
    CHECK(Matches(GROUP_TROLL | GROUP_ORC, 0, GROUP_TROLL, humanoidMask));
    CHECK_FALSE(Matches(GROUP_TROLL | GROUP_ORC, 0, GROUP_DWARF, humanoidMask));

    // Serpentbane Crown: every Beast by its creature type, and Serpentine creatures that are not beasts (a type 10 hydra)
    CHECK(Matches(GROUP_SERPENTINE, beastMask, 0, beastMask));
    CHECK(Matches(GROUP_SERPENTINE, beastMask, GROUP_SERPENTINE, 1u << (10 - 1)));
    CHECK_FALSE(Matches(GROUP_SERPENTINE, beastMask, 0, humanoidMask));

    // a target in no group and of no listed type
    CHECK_FALSE(Matches(GROUP_ALL, 0, 0, humanoidMask));
}

TEST_CASE("A versus factor reads the effect, or the stated override, and never weakens", "[ClassicVersusBonus]")
{
    CHECK(Factor(0.0f, 3.0f) == 3.0f);      // Grass Killer: effect 1 reads 3
    CHECK(Factor(2.0f, 0.0f) == 2.0f);      // a row that states its factor because no effect does
    CHECK(Factor(2.0f, 5.0f) == 2.0f);      // the override wins
    CHECK(Factor(0.0f, 0.0f) == 1.0f);      // an empty effect changes nothing
    CHECK(Factor(0.0f, 0.5f) == 1.0f);      // nor does a factor below 1
}

TEST_CASE("Troll, orc and dwarf players are in their race's group", "[ClassicVersusBonus]")
{
    CHECK(GroupsOfRace(8) == GROUP_TROLL);
    CHECK(GroupsOfRace(2) == GROUP_ORC);
    CHECK(GroupsOfRace(3) == GROUP_DWARF);
    CHECK(GroupsOfRace(1) == 0);    // human
    CHECK(GroupsOfRace(5) == 0);    // undead
    CHECK(GroupsOfRace(7) == 0);    // gnome
}
