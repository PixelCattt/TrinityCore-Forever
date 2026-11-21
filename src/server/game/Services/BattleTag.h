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

#ifndef TRINITYCORE_BATTLE_TAG_H
#define TRINITYCORE_BATTLE_TAG_H

#include "Define.h"
#include "Optional.h"
#include <string>
#include <string_view>
#include <unordered_set>

// A Battle.net account's BattleTag ("Name#1234"). The client names a Battle.net friend by it (friends list, whisper target,
// the player's own tag in the Social window). Nothing else gives accounts one here (there is no Battle.net site), so an
// account without a tag gets friends that cannot whisper it. The player picks the name (.battletag <name>) and the server
// draws the number; until then the account takes the first name of the character it enters the world with, when that name
// is a valid tag name.
namespace Trinity::BattleTag
{
    constexpr std::size_t MinNameLength = 2;
    constexpr std::size_t MaxNameLength = 12;
    constexpr uint32 MinNumber = 1000;              // four digits, drawn among the free ones
    constexpr uint32 MaxNumber = 9999;
    constexpr std::size_t MaxTakenPerName = 8000;   // of 9000: past this a name counts as full

    // 2-12 ASCII letters and digits, starting with a letter. This also keeps a name safe in SQL and LIKE patterns.
    inline bool IsValidName(std::string_view name)
    {
        auto isLetter = [](char c) { return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z'); };
        auto isDigit = [](char c) { return c >= '0' && c <= '9'; };
        if (name.size() < MinNameLength || name.size() > MaxNameLength || !isLetter(name.front()))
            return false;
        for (char c : name)
            if (!isLetter(c) && !isDigit(c))
                return false;
        return true;
    }

    // The automatic name: the character's first name (up to a space or '-' before a surname), when it is a valid tag name.
    // Empty otherwise (accented or Cyrillic letters, too long): that player is asked to pick one.
    inline std::string NameFromCharacter(std::string_view characterName)
    {
        std::string_view const first = characterName.substr(0, characterName.find_first_of(" -#"));
        return IsValidName(first) ? std::string(first) : std::string();
    }

    inline std::string Make(std::string_view name, uint32 number)
    {
        std::string tag(name);
        tag += '#';
        tag += std::to_string(number);
        return tag;
    }

    // The number after the last '#' of a stored tag, if it is one.
    inline Optional<uint32> NumberOf(std::string_view tag)
    {
        std::size_t const hash = tag.rfind('#');
        if (hash == std::string_view::npos)
            return {};
        std::string_view const digits = tag.substr(hash + 1);
        if (digits.empty() || digits.size() > 9)
            return {};
        uint32 number = 0;
        for (char c : digits)
        {
            if (c < '0' || c > '9')
                return {};
            number = number * 10 + uint32(c - '0');
        }
        return number;
    }

    // A free four-digit number for a name whose tags already use `taken`. None when the name is full.
    // random(min, max) returns a number in [min, max].
    template<class Random>
    Optional<uint32> DrawNumber(std::unordered_set<uint32> const& taken, Random random)
    {
        std::size_t count = 0;
        for (uint32 number : taken)
            if (number >= MinNumber && number <= MaxNumber)
                ++count;
        if (count > MaxTakenPerName)
            return {};
        for (;;)
        {
            uint32 const number = random(MinNumber, MaxNumber);
            if (!taken.contains(number))
                return number;
        }
    }
}

#endif // TRINITYCORE_BATTLE_TAG_H
