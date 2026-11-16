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

// The sky's clock a client is given (SMSG_LOGIN_SET_TIME_SPEED): the client lights the world from it and runs it on by itself.
//  * Forever.DayCycle.Speed (worldserver.conf): the whole realm's sky runs 1x (the realm's own clock, as before), 2x or more.
//    The shown time is worked out from the realm's local time alone, so every player sees the same sky, also after a restart.
//  * .time day / .time night: one character keeps noon or midnight, wherever it goes; .time auto: the realm's sky again.
// Only the sky: events, resets, spawns and scripts keep the realm's own time. The pure part is here, so it can be unit tested;
// Player::SendDayCycle sends it.

#ifndef TRINITYCORE_DAY_CYCLE_H
#define TRINITYCORE_DAY_CYCLE_H

#include "Define.h"

namespace DayCycle
{
    // saved per character (character_day_cycle.mode); a value the server does not know is read as Auto
    enum class SkyMode : uint8
    {
        Auto  = 0,
        Day   = 1,
        Night = 2
    };

    inline SkyMode SkyModeFromDb(uint8 v)
    {
        return v == uint8(SkyMode::Day) ? SkyMode::Day : v == uint8(SkyMode::Night) ? SkyMode::Night : SkyMode::Auto;
    }

    // The client takes a new clock in the middle of a session (its clock shows it) but does not light the world again from
    // it: the sky changes only at the next login. So .time day / night also put a fixed light over every area light of the
    // map (SMSG_OVERRIDE_LIGHT, the same packet scripted events use to darken a zone). Two Light.db2 records of the Forever
    // client whose LightParams have a single LightData keyframe, so they look the same at any hour: 15377 (map 2940, its
    // global light, params 6730) is daylight, 16854 (map 2991, params 7601) is night. Found and tried in game by SIN
    // (Personal Day and Night pack, 0.1.35).
    constexpr int32 DayLightID = 15377;
    constexpr int32 NightLightID = 16854;
    constexpr int32 LightTransitionMs = 200;

    // the light put over the map's area lights for a sky mode; 0: none, the map's own lights
    constexpr int32 OverrideLightFor(SkyMode mode)
    {
        return mode == SkyMode::Day ? DayLightID : mode == SkyMode::Night ? NightLightID : 0;
    }

    // the client's speed for the realm clock: game minutes per real second
    constexpr float NormalSpeed = 0.01666667f;

    constexpr uint32 MinSpeed = 1;
    constexpr uint32 MaxSpeed = 24;   // a whole day and night in an hour

    // Hour and minute the sky shows for a realm-local time (seconds since 1970 as read on the realm's wall clock) at a
    // speed: the time of day runs speed times as fast, counted from 1970, so at 1 it is the realm's own time of day.
    struct SkyClock
    {
        int8 Hour = 0;
        int8 Minute = 0;
        float Speed = NormalSpeed;   // 0: the sky stands still (.time day / night)
    };

    constexpr SkyClock ShownClock(int64 localSeconds, uint32 speed, SkyMode mode)
    {
        if (mode == SkyMode::Day)
            return { 12, 0, 0.0f };
        if (mode == SkyMode::Night)
            return { 0, 0, 0.0f };

        if (speed < MinSpeed)
            speed = MinSpeed;
        if (speed > MaxSpeed)
            speed = MaxSpeed;
        int64 const ofDay = ((localSeconds % 86400) + 86400) % 86400;
        int64 const shown = (ofDay * int64(speed)) % 86400;
        return { int8(shown / 3600), int8(shown % 3600 / 60), NormalSpeed * float(speed) };
    }
}

#endif // TRINITYCORE_DAY_CYCLE_H
