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

#include "../../src/server/game/Entities/Unit/ClassicDaze.h"

using ClassicDaze::Chance;

TEST_CASE("Classic daze: 20% at 60 against equal skill and defense, 0.2% per point between them", "[ClassicDaze]")
{
    CHECK(Chance(60, 300, 300) == Catch::Approx(20.0f));
    CHECK(Chance(60, 315, 300) == Catch::Approx(23.0f));    // a level 63 mob (skill 315)
    CHECK(Chance(60, 300, 400) == Catch::Approx(0.0f));     // a warrior tank with 400 defense is never dazed by a level 60 mob
    CHECK(Chance(60, 300, 350) == Catch::Approx(10.0f));    // 50 defense from gear halves it
}

TEST_CASE("Classic daze: less below level 30, never past 40%", "[ClassicDaze]")
{
    CHECK(Chance(10, 50, 50) == Catch::Approx(7.0f));       // 0.65 * 10 + 0.5
    CHECK(Chance(29, 145, 145) == Catch::Approx(19.35f));
    CHECK(Chance(60, 500, 300) == Catch::Approx(ClassicDaze::MaxChance));
    CHECK(Chance(1, 5, 50) == Catch::Approx(0.0f));
}
