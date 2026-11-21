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

// Classic 1.60 port of VMaNGOS src/scripts/kalimdor/feralas/dire_maul/dire_maul.h (ScriptDev2 lineage, GPL-2)
// Shared data ids of the Dire Maul (map 429) instance script "classic_instance_dire_maul".

#ifndef CLASSIC_DIRE_MAUL_H
#define CLASSIC_DIRE_MAUL_H

#include "Define.h"

#define ClassicDireMaulScriptName "classic_instance_dire_maul"
#define ClassicDireMaulDataHeader "DMC"

uint32 const CLASSIC_MAP_DIRE_MAUL = 429;

enum ClassicDireMaulData
{
    MAX_CRISTALS              = 5,

    // instance->SetData / GetData ids (VMaNGOS values)
    TYPE_CRISTAL_EVENT        = 1,
    TYPE_IMMOL_THAR           = 2,
    DATA_TENDRIS_AGGRO        = 3,
    TYPE_BOSS_ZEVRIM          = 4,
    TYPE_SPEAK_ECORCEFER      = 5,
    TYPE_GORDOK_TRIBUTE       = 6,
    TYPE_BROKEN_TRAP          = 7,
    TYPE_GORDOK_OGRE_SUIT     = 8,
    TYPE_CHORUSH_EQUIPMENT    = 9,
    TYPE_MOLDAR               = 10,
    TYPE_ALZZIN               = 11,

    INSTANCE_DIRE_MAUL_MAX_ENCOUNTER = 12,

    DATA_TANNIN_LOOTED            = 13,
    DATA_DREADSTEED_RITUAL_PLAYER = 14,   // SetGuidData / GetGuidData
    DATA_FINAL_GUARD_ALIVE_COUNT  = 15
};

enum ClassicDireMaulCreatures
{
    // DM East
    NPC_OLD_IRONBARK       = 11491,
    NPC_ZEVRIM             = 11490, // unused
    NPC_ALZZIN             = 11492,

    // DM West
    NPC_IMMOL_THAR_GARDIEN = 11466,
    NPC_IMMOL_THAR         = 11496,
    NPC_TORTHELDRIN        = 11486,
    NPC_RESTE_MANA         = 11483,
    NPC_ARCANE_ABERRATION  = 11480,

    NPC_TENDRIS            = 11489,
    NPC_TENDRIS_PROTECTOR  = 11459,

    // DM North
    NPC_GUARD_MOLDAR       = 14326,
    NPC_GUARD_FENGUS       = 14321,
    NPC_GUARD_SLIPKIK      = 14323,
    NPC_CAPTAIN_KROMCRUSH  = 14325,
    NPC_CHORUSH            = 14324,
    NPC_KING_GORDOK        = 11501,
    NPC_MIZZLE_THE_CRAFTY  = 14353
};

enum ClassicDireMaulGameObjects
{
    // DM East
    GO_CRUMBLE_WALL        = 177220,
    GO_FELVINE_SHARD       = 179559,
    GO_CORRUPT_VINE        = 179502,
    GO_CONSERVATORY_DOOR   = 176907, // opened by Ironbark the Redeemed (VMaNGOS had 181496, Naxxramas's Heigan exit door here)

    // DM West
    GO_FORCE_FIELD         = 179503,
    GO_MAGIC_VORTEX        = 179506,
    GO_CRISTAL_1_EVENT     = 177259,
    GO_CRISTAL_2_EVENT     = 177257,
    GO_CRISTAL_3_EVENT     = 177258,
    GO_CRISTAL_4_EVENT     = 179504,
    GO_CRISTAL_5_EVENT     = 179505,
    GO_RITUAL_CANDLE_AURA  = 179688, // invis trap - true caster of 23226

    // DM North
    GO_BROKEN_TRAP         = 179485,
    GO_FIXED_TRAP          = 179512,
    GO_GORDOK_TRIBUTE      = 179564
};

enum ClassicDireMaulMisc
{
    SAY_FREE_IMMOLTHAR     = 9364,
    SAY_KING_DEAD          = 9472,
    SAY_IMMOL_THAR_DEAD    = 9407,

    DM_FACTION_FRIENDLY    = 35,     // VMaNGOS FACTION_FRIENDLY (name clashes with SharedDefines.h)

    SPELL_KING_OF_GORDOK   = 22799,

    ITEM_GORDOK_INNER_DOOR_KEY = 18268,
    ITEM_GORDOK_COURTYARD_KEY  = 18266,

    // npc_j_eevee (VMaNGOS world/npc_j_eevee.cpp, not part of this folder) is summoned by the Dreadsteed ritual pedestal.
    // The pedestal hands it the ritual player with AI()->SetGUID(playerGuid, DM_JEEVEE_GUID_PLAYER).
    DM_JEEVEE_GUID_PLAYER  = 0
};

#endif
