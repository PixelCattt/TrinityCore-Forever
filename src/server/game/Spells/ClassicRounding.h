// Classic 1.60 (WoW Forever): how a fractional damage or heal amount becomes whole. The amount a hit, heal or tick deals is its exact value,
// power and multipliers included, rounded up with a chance equal to its fraction and down otherwise, so it averages the exact value: Flame
// Shock Rank 1 at level 11 (exact 20.8) landed 21 on 21 of 26 hits and 20 on the rest, and a rank with a whole base never rounds up
// (wowsims/forever, MIT, docs/evidence EV-0095). The roll is passed in so the rule stays pure.
#pragma once

#include <cmath>
#include <cstdint>
#include <limits>

namespace ClassicRounding
{
    // floor(value), plus one when roll (uniform in [0, 1)) falls under the fraction; negative values become 0
    inline int32_t RoundByFraction(double value, double roll)
    {
        if (!(value > 0.0))
            return 0;
        if (value >= double(std::numeric_limits<int32_t>::max()))
            return std::numeric_limits<int32_t>::max();
        double const whole = std::floor(value);
        return int32_t(whole) + (roll < value - whole ? 1 : 0);
    }
}
