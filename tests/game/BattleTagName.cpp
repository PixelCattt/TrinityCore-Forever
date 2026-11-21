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

#include "BattleTag.h"

using namespace Trinity::BattleTag;

TEST_CASE("BattleTag name rule", "[BattleTag]")
{
    REQUIRE(IsValidName("Ora"));
    REQUIRE(IsValidName("Ab"));
    REQUIRE(IsValidName("Karrz1"));
    REQUIRE(IsValidName("Abcdefghijkl"));
    REQUIRE_FALSE(IsValidName("A"));
    REQUIRE_FALSE(IsValidName("Abcdefghijklm"));
    REQUIRE_FALSE(IsValidName("1Ora"));
    REQUIRE_FALSE(IsValidName("Ora Bright"));
    REQUIRE_FALSE(IsValidName("O'ra"));
    REQUIRE_FALSE(IsValidName("Ora#1234"));
    REQUIRE_FALSE(IsValidName("Zo\xC3\xAB"));
    REQUIRE_FALSE(IsValidName(""));
}

TEST_CASE("BattleTag name from a character", "[BattleTag]")
{
    REQUIRE(NameFromCharacter("Ora") == "Ora");
    REQUIRE(NameFromCharacter("Ora Brightleaf") == "Ora");
    REQUIRE(NameFromCharacter("Ora-Brightleaf") == "Ora");
    REQUIRE(NameFromCharacter("Zo\xC3\xAB").empty());              // accented: the player picks one
    REQUIRE(NameFromCharacter("\xD0\x90\xD0\xBD\xD1\x8F").empty());   // Cyrillic
    REQUIRE(NameFromCharacter("Abcdefghijklm").empty());    // 13 letters
    REQUIRE(NameFromCharacter("").empty());
}

TEST_CASE("BattleTag number read back", "[BattleTag]")
{
    REQUIRE(Make("Ora", 1234) == "Ora#1234");
    REQUIRE(NumberOf("Ora#1234") == 1234u);
    REQUIRE(NumberOf("Ora#12345") == 12345u);
    REQUIRE_FALSE(NumberOf("Ora"));
    REQUIRE_FALSE(NumberOf("Ora#"));
    REQUIRE_FALSE(NumberOf("Ora#12a4"));
    REQUIRE_FALSE(NumberOf("Ora#1234567890"));
}

TEST_CASE("BattleTag draws a free number", "[BattleTag]")
{
    std::unordered_set<uint32> taken = { 1000, 1001, 1002 };
    uint32 next = 1000;
    auto counting = [&next](uint32, uint32) { return next++; };
    REQUIRE(DrawNumber(taken, counting) == 1003u);

    std::unordered_set<uint32> full;
    for (uint32 number = MinNumber; number <= MinNumber + MaxTakenPerName; ++number)
        full.insert(number);
    REQUIRE_FALSE(DrawNumber(full, [](uint32 min, uint32) { return min; }));
}
