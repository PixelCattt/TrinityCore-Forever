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

#ifndef TRINITYCORE_REPUTATION_DISCOUNT_H
#define TRINITYCORE_REPUTATION_DISCOUNT_H

#include "SharedDefines.h"

namespace Trinity::Reputation
{
// Classic 1.60 (WoW Forever live, as in vanilla): vendors, trainers, flight masters and repairs charge the full price up to
// Friendly and 10% less from Honored on, the same at Revered and Exalted. Live racial riding trainers ask 100g / 1,000g at
// Friendly and 90g / 900g at Honored. The retail rule (patch 2.3.0) was 5% per rank above Neutral, 20% at Exalted.
inline constexpr float HonoredPriceFactor = 0.9f;

inline constexpr float PriceFactor(ReputationRank rank)
{
    return rank >= REP_HONORED ? HonoredPriceFactor : 1.0f;
}
}

#endif // TRINITYCORE_REPUTATION_DISCOUNT_H
