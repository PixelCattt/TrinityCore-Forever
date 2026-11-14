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

#include "../../src/server/game/Spells/ClassicVanillaAoe.h"
#include <iterator>

using namespace ClassicVanillaAoe;

TEST_CASE("Consecration ranks map to their tick spells as before", "[ClassicVanillaAoe]")
{
    CHECK(ConsecrationTickSpell(26573) == 1280345);
    CHECK(ConsecrationTickSpell(20116) == 1280346);
    CHECK(ConsecrationTickSpell(20922) == 1280347);
    CHECK(ConsecrationTickSpell(20923) == 1280348);
    CHECK(ConsecrationTickSpell(20924) == 1280349);
    CHECK(ConsecrationTickSpell(10) == 0);       // Blizzard is not a Consecration
    CHECK(FindConsecrationRank(1280345) == nullptr); // a tick spell is not a rank
}

TEST_CASE("Vanilla Consecration does 64 / 120 / 192 / 280 / 384 over its 8 ticks", "[ClassicVanillaAoe]")
{
    int32_t const totals[] = { 64, 120, 192, 280, 384 };
    for (std::size_t i = 0; i < std::size(ConsecrationRanks); ++i)
        CHECK(ConsecrationRanks[i].VanillaTick * 8 == totals[i]);
}

TEST_CASE("Improved Blizzard chills 30 / 50 / 65% instead of 15 / 25 / 40%", "[ClassicVanillaAoe]")
{
    CHECK(ImprovedBlizzardChill(-15) == -30);
    CHECK(ImprovedBlizzardChill(-25) == -50);
    CHECK(ImprovedBlizzardChill(-40) == -65);
}

TEST_CASE("Improved Blizzard leaves an amount that is not a Forever rank alone", "[ClassicVanillaAoe]")
{
    // already vanilla (a second pass, or a curve someone changed by hand) must not be pushed further
    CHECK(ImprovedBlizzardChill(-30) == -30);
    CHECK(ImprovedBlizzardChill(-50) == -50);
    CHECK(ImprovedBlizzardChill(-65) == -65);
    CHECK(ImprovedBlizzardChill(0) == 0);
}
