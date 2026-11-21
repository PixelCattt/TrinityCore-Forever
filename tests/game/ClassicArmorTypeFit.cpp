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

#include "../../src/modules/PlayerbotV2/Bot/Gear/ArmorTypeFit.h"

using Playerbot::Gear::ArmorTierFactor;

TEST_CASE("A piece of the wearer's own armor type keeps its full worth", "[ClassicArmorTypeFit]")
{
    CHECK(ArmorTierFactor(3, 3, false) == 1.0f);   // mail on a level 30 warrior
    CHECK(ArmorTierFactor(4, 4, true) == 1.0f);    // plate on a level 60 protection warrior
    CHECK(ArmorTierFactor(1, 1, false) == 1.0f);   // cloth on a mage
    CHECK(ArmorTierFactor(0, 4, false) == 1.0f);   // a ring or trinket (miscellaneous)
}

TEST_CASE("Each armor tier under the best the wearer can put on costs a fifth, two fifths for a tank", "[ClassicArmorTypeFit]")
{
    CHECK(ArmorTierFactor(2, 3, false) == Catch::Approx(0.8f));    // leather on a level 21 warrior (DoctorSun, 17 Nov)
    CHECK(ArmorTierFactor(1, 3, false) == Catch::Approx(0.64f));   // cloth on the same warrior
    CHECK(ArmorTierFactor(1, 2, false) == Catch::Approx(0.8f));    // cloth on a rogue
    CHECK(ArmorTierFactor(3, 4, true) == Catch::Approx(0.6f));     // mail on a level 60 protection warrior
    CHECK(ArmorTierFactor(2, 4, true) == Catch::Approx(0.36f));
}

TEST_CASE("A heavier type than the wearer can put on, or no armor type, is not scaled here", "[ClassicArmorTypeFit]")
{
    CHECK(ArmorTierFactor(4, 3, false) == 1.0f);   // plate on a level 30 warrior: the core refuses it, not the score
    CHECK(ArmorTierFactor(5, 4, false) == 1.0f);   // cosmetic
    CHECK(ArmorTierFactor(6, 4, false) == 1.0f);   // shield
}

TEST_CASE("A heavier piece with fewer stats now beats a lighter one with a few more", "[ClassicArmorTypeFit]")
{
    // EquipFitScore is item level plus the weighted stats: a level 21 warrior's mail chest (item level 20, 20 weighted) against a
    // leather one (item level 20, 28 weighted). Unscaled the leather won 48 to 40.
    float const mail = (20.0f + 20.0f) * ArmorTierFactor(3, 3, false);
    float const leather = (20.0f + 28.0f) * ArmorTierFactor(2, 3, false);
    CHECK(mail > leather);
}
