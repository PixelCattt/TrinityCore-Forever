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

#include "ClassicPetAttackSpeed.h"

using namespace ClassicPetAttackSpeed;

namespace
{
uint32_t PassiveFor(uint32_t wildMs)
{
    Step const* step = ForWildAttackTime(wildMs);
    return step ? step->spellId : 0;
}
}

TEST_CASE("a 2.0 s beast or one without a speed gets no attack speed passive", "[classic][pet]")
{
    CHECK(PassiveFor(0) == 0);
    CHECK(PassiveFor(2000) == 0);
    CHECK(PassiveFor(1920) == 0);   // 4% off 2.0 s, nearer than Faster Attack I (1.71 s)
}

TEST_CASE("the common wild speeds get the passive that gives exactly that speed", "[classic][pet]")
{
    // The beast counts of the dev world DB, 11-16: 1500 275, 1000 38, 1300 33, 1200 17, 1400 16, 1600 16, 2400 16, 1700 5
    CHECK(PassiveFor(1000) == 1263110);   // Faster Attack VII
    CHECK(PassiveFor(1200) == 1263109);   // VI
    CHECK(PassiveFor(1300) == 1263107);   // V
    CHECK(PassiveFor(1400) == 1263104);   // IV
    CHECK(PassiveFor(1500) == 1263102);   // III
    CHECK(PassiveFor(1600) == 1263100);   // II
    CHECK(PassiveFor(1700) == 1263099);   // I
    CHECK(PassiveFor(2400) == 1263113);   // Slower Attack II
    for (uint32_t wild : { 1000u, 1200u, 1300u, 1400u, 1500u, 1600u, 1700u, 2400u })
        CHECK(std::fabs(SwingMs(ForWildAttackTime(wild)->pct) - float(wild)) < 0.02f * float(wild));
}

TEST_CASE("an uncommon wild speed takes the nearest step", "[classic][pet]")
{
    CHECK(PassiveFor(500) == 1263110);    // faster than any step: the fastest, 1.0 s
    CHECK(PassiveFor(1111) == 1263109);   // 1.11 s: 1.2 s is nearer than 1.0 s by ratio
    CHECK(PassiveFor(1250) == 1263107);   // between 1.2 and 1.3 s (Faster Attack V gives 1.299 s): 1.3 by ratio
    CHECK(PassiveFor(1800) == 1263099);   // 1.71 s is nearer than 2.0 s
    CHECK(PassiveFor(2340) == 1263111);   // Slower Attack I
    CHECK(PassiveFor(3000) == 1263114);   // slower than any step: the slowest, 2.52 s
    CHECK(PassiveFor(4000) == 1263114);
}
