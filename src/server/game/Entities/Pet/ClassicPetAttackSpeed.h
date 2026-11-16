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

#ifndef TRINITY_CLASSIC_PET_ATTACK_SPEED_H
#define TRINITY_CLASSIC_PET_ATTACK_SPEED_H

#include <cmath>
#include <cstdint>

// Classic 1.60: every hunter pet swings at 2.0 s and a tamed beast keeps the speed it had in the wild through one of ten pet passives
// (skill line 270, Pet - Hunter, SPELL_AURA_MOD_ATTACKSPEED): Faster Attack I-VII +17, +25, +33, +43, +54, +67, +100% and Slower Attack
// I-III -17, -20, -26%. On a 2.0 s pet they give exactly the common wild speeds 1.7, 1.6, 1.5, 1.4, 1.3, 1.2 and 1.0 s, and the slow ones
// 2.34, 2.4 and 2.52 s (the server applies a slow as a longer swing time: Unit::ApplyAttackTimePercentMod).
// Idea from the Everlake core (GPL, NOTICE.md), written as our own code.
// A beast whose wild speed lies between two steps takes the nearest one (by ratio); 0 (no speed in the creature data) is 2.0 s, no passive.
namespace ClassicPetAttackSpeed
{
    constexpr uint32_t BaseAttackTimeMs = 2000;

    struct Step
    {
        uint32_t spellId;
        int32_t  pct;       // the passive's attack speed change
    };

    constexpr Step Steps[] =
    {
        { 1263110, 100 },   // Faster Attack VII: 1.0 s
        { 1263109,  67 },   // Faster Attack VI:  1.2 s
        { 1263107,  54 },   // Faster Attack V:   1.3 s
        { 1263104,  43 },   // Faster Attack IV:  1.4 s
        { 1263102,  33 },   // Faster Attack III: 1.5 s
        { 1263100,  25 },   // Faster Attack II:  1.6 s
        { 1263099,  17 },   // Faster Attack I:   1.7 s
        { 1263111, -17 },   // Slower Attack I:   2.34 s
        { 1263113, -20 },   // Slower Attack II:  2.4 s
        { 1263114, -26 },   // Slower Attack III: 2.52 s
    };

    // The swing time a passive gives a 2.0 s pet (0 = no passive).
    inline float SwingMs(int32_t pct)
    {
        if (pct > 0)
            return float(BaseAttackTimeMs) / (1.0f + float(pct) / 100.0f);
        return float(BaseAttackTimeMs) * (1.0f - float(pct) / 100.0f);
    }

    // The passive for a beast with this wild attack time; nullptr = none (a 2.0 s beast, or no speed in its data).
    inline Step const* ForWildAttackTime(uint32_t wildMs)
    {
        if (!wildMs)
            return nullptr;
        float best = std::fabs(std::log(float(wildMs) / float(BaseAttackTimeMs)));
        Step const* pick = nullptr;
        for (Step const& step : Steps)
        {
            float const off = std::fabs(std::log(float(wildMs) / SwingMs(step.pct)));
            if (off < best)
            {
                best = off;
                pick = &step;
            }
        }
        return pick;
    }
}

#endif // TRINITY_CLASSIC_PET_ATTACK_SPEED_H
