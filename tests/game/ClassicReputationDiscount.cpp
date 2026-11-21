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
#include "ReputationDiscount.h"

// Classic 1.60 reputation prices (WoW Forever live, vanilla): full price up to Friendly, 10% off from Honored on.
TEST_CASE("Classic reputation discount: nothing up to Friendly, 10% from Honored", "[ClassicReputationDiscount]")
{
    using Trinity::Reputation::PriceFactor;
    CHECK(PriceFactor(REP_HATED) == 1.0f);
    CHECK(PriceFactor(REP_NEUTRAL) == 1.0f);
    CHECK(PriceFactor(REP_FRIENDLY) == 1.0f);
    CHECK(PriceFactor(REP_HONORED) == 0.9f);
    CHECK(PriceFactor(REP_REVERED) == 0.9f);
    CHECK(PriceFactor(REP_EXALTED) == 0.9f);
    // live riding trainers: Journeyman Riding 1,000g at Friendly, 900g at Honored
    CHECK(uint32(10000000 * PriceFactor(REP_FRIENDLY)) == 10000000u);
    CHECK(uint32(10000000 * PriceFactor(REP_HONORED)) == 9000000u);
}
