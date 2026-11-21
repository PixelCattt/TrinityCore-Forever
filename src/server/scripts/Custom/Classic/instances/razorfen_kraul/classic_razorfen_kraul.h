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

// Classic 1.60 port of VMaNGOS src/scripts/kalimdor/the_barrens/razorfen_kraul/razorfen_kraul.h (ScriptDev2 lineage, GPL-2)

#ifndef CLASSIC_RAZORFEN_KRAUL_H
#define CLASSIC_RAZORFEN_KRAUL_H

#include "Define.h"

#define ClassicRFKScriptName "classic_instance_razorfen_kraul"
#define ClassicRFKDataHeader "CRFK"

uint32 const CLASSIC_RFK_MAP_ID = 47;

enum ClassicRFKData
{
    RFK_MAX_ENCOUNTER     = 1,

    TYPE_AGATHELOS        = 1
};

enum ClassicRFKEntries
{
    GO_AGATHELOS_WARD     = 21099,

    NPC_WARD_KEEPER       = 4625,
    NPC_AGATHELOS         = 4422,

    // VMaNGOS creature_movement_template path of Agathelos (waypoint_path 810044220, "VMaNGOS 1.12 entry path")
    PATH_AGATHELOS        = 810044220
};

#endif
