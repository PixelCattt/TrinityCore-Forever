// Classic 1.60 (vanilla) daze from behind. Pure rule, no server types, so it can be tested.
#pragma once

#include <algorithm>
#include <cstdint>

namespace ClassicDaze
{
    constexpr float MaxChance = 40.0f;

    // A creature's melee hit from behind dazes a player at 20% from level 30 on, less below (0.65 per level + 0.5, about 7% at level
    // 10), plus 0.2% for each point of the attacker's weapon skill over the victim's defense (less for each point under it), at most
    // 40% (VMaNGOS Unit::RollDazeOutcome). Defense from gear and talents lowers it. TrinityCore's rule multiplied it by 0.16 and
    // used the victim's defense cap for its level, which gave 3.2% at 60 whatever the defense.
    inline float Chance(uint8_t victimLevel, int32_t attackerSkill, int32_t victimDefense)
    {
        float const base = victimLevel < 30 ? 0.65f * float(victimLevel) + 0.5f : 20.0f;
        return std::clamp(base + float(attackerSkill - victimDefense) * 0.2f, 0.0f, MaxChance);
    }
}
