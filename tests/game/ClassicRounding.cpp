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
#include "ClassicRounding.h"

// Classic 1.60 (WoW Forever, EV-0095): a damage or heal amount rounds up with a chance equal to its fraction.
TEST_CASE("ClassicRounding::RoundByFraction", "[ClassicRounding]")
{
    using ClassicRounding::RoundByFraction;

    SECTION("a whole value never rounds up")
    {
        REQUIRE(RoundByFraction(21.0, 0.0) == 21);
        REQUIRE(RoundByFraction(21.0, 0.999) == 21);
    }

    SECTION("the fraction is the chance of one more")
    {
        REQUIRE(RoundByFraction(20.8, 0.79) == 21);
        REQUIRE(RoundByFraction(20.8, 0.81) == 20);
        REQUIRE(RoundByFraction(20.2, 0.19) == 21);
        REQUIRE(RoundByFraction(20.2, 0.21) == 20);
    }

    SECTION("the average over evenly spread rolls is the exact value")
    {
        double sum = 0.0;
        int const n = 1000;
        for (int i = 0; i < n; ++i)
            sum += RoundByFraction(20.8, (i + 0.5) / n);
        REQUIRE(sum / n == Catch::Approx(20.8).margin(0.001));
    }

    SECTION("nothing below 0")
    {
        REQUIRE(RoundByFraction(-3.4, 0.0) == 0);
        REQUIRE(RoundByFraction(0.0, 0.0) == 0);
    }
}
