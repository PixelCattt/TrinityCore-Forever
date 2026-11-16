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

// Classic 1.60 port of VMaNGOS src/scripts/kalimdor/feralas/dire_maul/instance_dire_maul.cpp (ScriptDev2 lineage, GPL-2)
// Instance script (map 429) + trash, North (Gordok) guards / Kromcrush / Mizzle / Knot, West Tortheldrin / Kalendris / Ferra,
// East Alzzin and the Warpwood Pod.
// Ported: instance_dire_maul, npc_reste_mana, npc_arcane_aberration, npc_residual_montruosity, boss_ferra,
//         boss_prince_tortheldrin, boss_magister_kalendris, npc_gordok_brute, npc_mizzle_the_crafty, npc_knot_thimblejack,
//         boss_guards, go_broken_trap, go_fixed_trap, boss_kromcrush, boss_alzzin_the_wildshaper, npc_alzzins_minion,
//         go_warpwood_pod

#include "ScriptMgr.h"
#include "Creature.h"
#include "GameObject.h"
#include "GameObjectAI.h"
#include "GossipDef.h"
#include "InstanceScript.h"
#include "Log.h"
#include "Loot.h"
#include "Map.h"
#include "MotionMaster.h"
#include "ObjectMgr.h"
#include "PetDefines.h"
#include "Player.h"
#include "QuestDef.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "SpellAuras.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "StringFormat.h"
#include "TemporarySummon.h"
#include "classic_dire_maul.h"
#include "classic_dungeon_encounter_tracker.h"
#include "classic_script_text.h"
#include <array>
#include <list>
#include <memory>

namespace
{
void ClassicDMEnableCreature(Creature* creature)
{
    creature->SetUninteractible(false);                 // UNIT_FLAG_UNINTERACTIBLE
    creature->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE); // UNIT_FLAG_SPAWNING
    creature->SetImmuneToNPC(false);
}

// VMaNGOS "SetLootRecipient(nullptr)" from JustDied: the loot is already generated in TC when JustDied runs, so drop it.
void ClassicDMClearLoot(Creature* creature)
{
    creature->SetTappedBy(nullptr);
    creature->m_loot.reset();
    creature->m_personalLoot.clear();
    creature->RemoveDynamicFlag(UNIT_DYNFLAG_LOOTABLE);
}

// VMaNGOS saves m_auiEncounter[1,2,3,4,6,7,8,9,10,11] (index 5 = TYPE_SPEAK_ECORCEFER is not saved)
char const* const ClassicDMSaveKeys[INSTANCE_DIRE_MAUL_MAX_ENCOUNTER] =
{
    nullptr, "CristalEvent", "ImmolThar", "TendrisAggro", "Zevrim", nullptr,
    "GordokTribute", "BrokenTrap", "GordokOgreSuit", "ChorushEquipment", "Moldar", "Alzzin"
};
}

/*######
## instance_dire_maul
######*/

namespace
{
// Classic 1.60: TC boss states for the DungeonEncounter.db2 encounters of Dire Maul (map 429), driven by
// ClassicDungeonEncounterTracker (boss kill credit, encounter start / end, instance lock)
enum ClassicDireMaulEncounterBosses : uint32
{
    CDMAUL_ENC_ZEVRIM = 0,
    CDMAUL_ENC_HYDROSPAWN = 1,
    CDMAUL_ENC_LETHTENDRIS = 2,
    CDMAUL_ENC_PUSILLIN = 3,
    CDMAUL_ENC_ALZZIN = 4,
    CDMAUL_ENC_TENDRIS = 5,
    CDMAUL_ENC_ILLYANNA = 6,
    CDMAUL_ENC_KALENDRIS = 7,
    CDMAUL_ENC_IMMOLTHAR = 8,
    CDMAUL_ENC_TORTHELDRIN = 9,
    CDMAUL_ENC_MOLDAR = 10,
    CDMAUL_ENC_KREEG = 11,
    CDMAUL_ENC_FENGUS = 12,
    CDMAUL_ENC_SLIPKIK = 13,
    CDMAUL_ENC_KROMCRUSH = 14,
    CDMAUL_ENC_CHORUSH = 15,
    CDMAUL_ENC_GORDOK = 16,
    CDMAUL_ENC_HELNURATH = 17,
    CDMAUL_ENC_TSUZEE = 18,
    CDMAUL_ENC_MAX
};

constexpr ClassicDungeonBossEntry ClassicDireMaulEncounterBossEntries[] =
{
    { CDMAUL_ENC_ZEVRIM, 11490 }, // Zevrim Thornhoof
    { CDMAUL_ENC_HYDROSPAWN, 13280 }, // Hydrospawn
    { CDMAUL_ENC_LETHTENDRIS, 14327 }, // Lethtendris
    { CDMAUL_ENC_PUSILLIN, 14354 }, // Pusillin
    { CDMAUL_ENC_ALZZIN, 11492 }, // Alzzin the Wildshaper
    { CDMAUL_ENC_TENDRIS, 11489 }, // Tendris Warpwood
    { CDMAUL_ENC_ILLYANNA, 11488 }, // Illyanna Ravenoak
    { CDMAUL_ENC_KALENDRIS, 11487 }, // Magister Kalendris
    { CDMAUL_ENC_IMMOLTHAR, 11496 }, // Immol'thar
    { CDMAUL_ENC_TORTHELDRIN, 11486 }, // Prince Tortheldrin
    { CDMAUL_ENC_MOLDAR, 14326 }, // Guard Mol'dar
    { CDMAUL_ENC_KREEG, 14322 }, // Stomper Kreeg
    { CDMAUL_ENC_FENGUS, 14321 }, // Guard Fengus
    { CDMAUL_ENC_SLIPKIK, 14323 }, // Guard Slip'kik
    { CDMAUL_ENC_KROMCRUSH, 14325 }, // Captain Kromcrush
    { CDMAUL_ENC_CHORUSH, 14324 }, // Cho'Rush the Observer
    { CDMAUL_ENC_GORDOK, 11501 }, // King Gordok
    { CDMAUL_ENC_HELNURATH, 14506 }, // Lord Hel'nurath
    { CDMAUL_ENC_TSUZEE, 11467 } // Tsu'zee
};
}

class classic_instance_dire_maul : public InstanceMapScript
{
public:
    classic_instance_dire_maul() : InstanceMapScript(ClassicDireMaulScriptName, CLASSIC_MAP_DIRE_MAUL) { }

    struct classic_instance_dire_maul_InstanceScript : public InstanceScript
    {
        classic_instance_dire_maul_InstanceScript(InstanceMap* map) : InstanceScript(map)
        {
            SetHeaders(ClassicDireMaulDataHeader);
            SetBossNumber(CDMAUL_ENC_MAX);
            static constexpr DungeonEncounterData encounters[] =
            {
                { CDMAUL_ENC_ZEVRIM, {{ 343 }} },
                { CDMAUL_ENC_HYDROSPAWN, {{ 344 }} },
                { CDMAUL_ENC_LETHTENDRIS, {{ 345 }} },
                { CDMAUL_ENC_PUSILLIN, {{ 2792 }} },
                { CDMAUL_ENC_ALZZIN, {{ 346 }} },
                { CDMAUL_ENC_TENDRIS, {{ 350 }} },
                { CDMAUL_ENC_ILLYANNA, {{ 347 }} },
                { CDMAUL_ENC_KALENDRIS, {{ 348 }} },
                { CDMAUL_ENC_IMMOLTHAR, {{ 349 }} },
                { CDMAUL_ENC_TORTHELDRIN, {{ 361 }} },
                { CDMAUL_ENC_MOLDAR, {{ 362 }} },
                { CDMAUL_ENC_KREEG, {{ 363 }} },
                { CDMAUL_ENC_FENGUS, {{ 364 }} },
                { CDMAUL_ENC_SLIPKIK, {{ 365 }} },
                { CDMAUL_ENC_KROMCRUSH, {{ 366 }} },
                { CDMAUL_ENC_CHORUSH, {{ 367 }} },
                { CDMAUL_ENC_GORDOK, {{ 368 }} },
                { CDMAUL_ENC_HELNURATH, {{ 2793 }} },
                { CDMAUL_ENC_TSUZEE, {{ 2794 }} }
            };
            LoadDungeonEncounterData(encounters);
            m_auiEncounter.fill(0);

            for (uint32 i = 0; i < INSTANCE_DIRE_MAUL_MAX_ENCOUNTER; ++i)
                if (ClassicDMSaveKeys[i])
                    m_savedEncounter[i] = std::make_unique<PersistentInstanceScriptValue<uint32>>(*this, ClassicDMSaveKeys[i], 0u);
        }

        ClassicDungeonEncounterTracker _encounterTracker{ *this, ClassicDireMaulEncounterBossEntries };

        void OnCreatureRemove(Creature* creature) override
        {
            InstanceScript::OnCreatureRemove(creature);
            _encounterTracker.OnCreatureRemove(creature);
        }

        void Update(uint32 diff) override
        {
            _encounterTracker.Update(diff);
        }

        // VMaNGOS Load(): IN_PROGRESS -> NOT_STARTED
        void AfterDataLoad() override
        {
            for (uint32 i = 0; i < INSTANCE_DIRE_MAUL_MAX_ENCOUNTER; ++i)
            {
                if (!m_savedEncounter[i])
                    continue;

                uint32 value = uint32(*m_savedEncounter[i]);
                if (value == IN_PROGRESS)
                    value = NOT_STARTED;
                m_auiEncounter[i] = value;
            }
        }

        // VMaNGOS saves only when some data is set to DONE
        void SaveEncounters()
        {
            for (uint32 i = 0; i < INSTANCE_DIRE_MAUL_MAX_ENCOUNTER; ++i)
                if (m_savedEncounter[i] && uint32(*m_savedEncounter[i]) != m_auiEncounter[i])
                    *m_savedEncounter[i] = m_auiEncounter[i];
        }

        void OnPlayerEnter(Player* player) override
        {
            if (!player)
                return;

            // prevent instance reset exploit
            if (player->HasItemCount(ITEM_GORDOK_INNER_DOOR_KEY, 1))
            {
                if (GetData(TYPE_MOLDAR) != DONE)
                    player->DestroyItemCount(ITEM_GORDOK_INNER_DOOR_KEY, 1, true);
            }

            // set the trap again if server went down
            if (GetData(TYPE_BROKEN_TRAP) == DONE)
            {
                if (GameObject* go = instance->GetGameObject(m_uiBrokenTrapGUID))
                {
                    // VMaNGOS summons it from the player; a player-summoned GO is bound to that player in TC, so summon it from the broken trap
                    Position pos(go->GetPositionX(), go->GetPositionY(), go->GetPositionZ(), 0.0f);
                    go->SummonGameObject(GO_FIXED_TRAP, pos, QuaternionData::fromEulerAnglesZYX(0.0f, 0.0f, 0.0f), 43200s, GO_SUMMON_TIMED_DESPAWN);
                    go->Delete();
                }
            }
        }

        void OnPlayerLeave(Player* player) override
        {
            if (!player)
                return;

            player->RemoveAurasDueToSpell(SPELL_KING_OF_GORDOK);
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            InstanceScript::OnGameObjectCreate(go);

            switch (go->GetEntry())
            {
                // DM East
                case GO_CRUMBLE_WALL:
                    m_uiCrumbleWallGUID = go->GetGUID();
                    if (m_auiEncounter[TYPE_ALZZIN] == DONE)
                        go->SetGoState(GO_STATE_ACTIVE);
                    break;
                case GO_CORRUPT_VINE:
                    m_uiCorruptVineGUID = go->GetGUID();
                    if (m_auiEncounter[TYPE_ALZZIN] == DONE)
                        go->SetGoState(GO_STATE_ACTIVE);
                    break;
                case GO_FELVINE_SHARD:
                    m_lFelvineShardGUIDs.push_back(go->GetGUID());
                    break;
                case GO_DOOR_ALZZIN_IN:
                    m_uiDoorAlzzinInGUID = go->GetGUID();
                    break;
                // DM West
                case GO_CRISTAL_1_EVENT:
                    m_auiCristalsGUID[0] = go->GetGUID();
                    break;
                case GO_CRISTAL_2_EVENT:
                    m_auiCristalsGUID[1] = go->GetGUID();
                    break;
                case GO_CRISTAL_3_EVENT:
                    m_auiCristalsGUID[2] = go->GetGUID();
                    break;
                case GO_CRISTAL_4_EVENT:
                    m_auiCristalsGUID[3] = go->GetGUID();
                    break;
                case GO_CRISTAL_5_EVENT:
                    m_auiCristalsGUID[4] = go->GetGUID();
                    break;
                case GO_FORCE_FIELD:
                    m_uiForceFieldGUID = go->GetGUID();
                    break;
                case GO_MAGIC_VORTEX:
                    m_uiMagicVortexGUID = go->GetGUID();
                    break;
                // DM North
                case GO_GORDOK_TRIBUTE:
                    m_uiGordokTributeGUID = go->GetGUID();
                    break;
                case GO_BROKEN_TRAP:
                    m_uiBrokenTrapGUID = go->GetGUID();
                    break;
                case GO_RITUAL_CANDLE_AURA:
                    m_uiRitualCandleAuraGUID = go->GetGUID();
                    break;
                default:
                    break;
            }
        }

        // VMaNGOS OnCreatureDeath
        void OnUnitDeath(Unit* unit) override
        {
            InstanceScript::OnUnitDeath(unit);
            _encounterTracker.OnUnitDeath(unit);

            Creature* creature = unit->ToCreature();
            if (!creature)
                return;

            switch (creature->GetEntry())
            {
                case NPC_ALZZIN:
                    SetData(TYPE_ALZZIN, DONE);
                    break;
                case NPC_IMMOL_THAR:
                    if (Creature* tortheldrin = instance->GetCreature(m_uiTortheldrinGUID))
                        tortheldrin->Yell(SAY_IMMOL_THAR_DEAD);
                    break;
                case NPC_GUARD_MOLDAR:
                    SetData(TYPE_MOLDAR, DONE);
                    if (GetData(TYPE_GORDOK_TRIBUTE) != DONE)
                        SetData(TYPE_GORDOK_TRIBUTE, SPECIAL);
                    break;
                case NPC_GUARD_FENGUS:
                case NPC_GUARD_SLIPKIK:
                case NPC_CAPTAIN_KROMCRUSH:
                case NPC_CHORUSH:
                    if (GetData(TYPE_GORDOK_TRIBUTE) != DONE)
                        SetData(TYPE_GORDOK_TRIBUTE, SPECIAL);
                    break;
                case NPC_KING_GORDOK:
                {
                    // VMaNGOS GetMap()->SummonCreature(..., TEMPSUMMON_DEAD_DESPAWN, 3000000)
                    if (TempSummon* mizzle = instance->SummonCreature(NPC_MIZZLE_THE_CRAFTY, Position(693.44f, 480.806f, 28.175f, 0.02757f)))
                        mizzle->SetTempSummonType(TEMPSUMMON_DEAD_DESPAWN);

                    if (Creature* chorush = instance->GetCreature(m_uiChoRushTheObserverGUID))
                    {
                        if (chorush->IsAlive())
                        {
                            chorush->SetFaction(DM_FACTION_FRIENDLY);
                            chorush->m_Events.AddEventAtOffset([chorush]() { ClassicScriptText(SAY_KING_DEAD, chorush); }, 5s);
                        }
                    }
                    break;
                }
                default:
                    break;
            }
        }

        void OnCreatureCreate(Creature* creature) override
        {
            InstanceScript::OnCreatureCreate(creature);
            _encounterTracker.OnCreatureCreate(creature);

            switch (creature->GetEntry())
            {
                case NPC_IMMOL_THAR:
                    m_uiImmolTharGUID = creature->GetGUID();
                    if (GetData(TYPE_CRISTAL_EVENT) != DONE)
                    {
                        creature->SetUninteractible(true);                 // UNIT_FLAG_UNINTERACTIBLE
                        creature->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);   // UNIT_FLAG_SPAWNING
                    }
                    break;
                case NPC_TORTHELDRIN:
                    m_uiTortheldrinGUID = creature->GetGUID();
                    break;
                case NPC_RESTE_MANA:
                case NPC_ARCANE_ABERRATION:
                    m_lCristalsEventtMobGUIDList.push_back(creature->GetGUID());
                    break;
                case NPC_IMMOL_THAR_GARDIEN:
                    m_lImmolTharGardiensMobGUIDList.push_back(creature->GetGUID());
                    break;
                case NPC_TENDRIS:
                    m_uiTendrisGUID = creature->GetGUID();
                    break;
                case NPC_TENDRIS_PROTECTOR:
                    m_lTendrisProtectorsMobGUIDList.push_back(creature->GetGUID());
                    break;
                case NPC_OLD_IRONBARK:
                    m_uiOldIronbarkGUID = creature->GetGUID();
                    break;
                case NPC_GUARD_SLIPKIK:
                    m_uiSlipKikGUID = creature->GetGUID();
                    break;
                case NPC_CAPTAIN_KROMCRUSH:
                    m_uiCaptainKromcrushGUID = creature->GetGUID();
                    break;
                case NPC_KING_GORDOK:
                    m_uiKingGordokGUID = creature->GetGUID();
                    break;
                case NPC_CHORUSH:
                    m_uiChoRushTheObserverGUID = creature->GetGUID();

                    if (GetData(TYPE_GORDOK_TRIBUTE) == DONE)
                    {
                        creature->SetFaction(DM_FACTION_FRIENDLY);
                        creature->SetStandState(UNIT_STAND_STATE_SIT);
                    }
                    break;
                default:
                    break;
            }
        }

        void SetData(uint32 type, uint32 data) override
        {
            switch (type)
            {
                case TYPE_CRISTAL_EVENT:
                {
                    if (data == DONE)
                    {
                        // Deactivate the force field
                        DoUseDoorOrButton(m_uiForceFieldGUID);
                        DoUseDoorOrButton(m_uiMagicVortexGUID);
                        // The boss becomes attackable ...
                        if (Creature* immolThar = instance->GetCreature(m_uiImmolTharGUID))
                        {
                            ClassicDMEnableCreature(immolThar);
                            // ... and his guardians must attack him.
                            bool hasYelled = false;
                            for (ObjectGuid const& guid : m_lImmolTharGardiensMobGUIDList)
                            {
                                if (Creature* creature = instance->GetCreature(guid))
                                {
                                    // Do not aggro the whole instance either.
                                    if (creature->IsAlive())
                                    {
                                        ClassicDMEnableCreature(creature);

                                        if (creature->GetDistance(immolThar) > 100.0f)
                                            continue;

                                        creature->SetFaction(100);

                                        if (!hasYelled)
                                        {
                                            ClassicScriptText(SAY_FREE_IMMOLTHAR, creature);
                                            hasYelled = true;
                                        }

                                        if (creature->AI())
                                            creature->AI()->AttackStart(immolThar);
                                    }
                                }
                            }
                        }
                        else
                            TC_LOG_ERROR("scripts", "classic_instance_dire_maul: Immol'Thar not found! GUID {}", m_uiImmolTharGUID.ToString());
                    }
                    m_auiEncounter[TYPE_CRISTAL_EVENT] = data;
                    break;
                }
                case TYPE_IMMOL_THAR:
                {
                    if (data == DONE)
                    {
                        if (Creature* tortheldrin = instance->GetCreature(m_uiTortheldrinGUID))
                        {
                            tortheldrin->SetImmuneToPC(false);
                            tortheldrin->SetFaction(14); // VMaNGOS TEMPFACTION_RESTORE_RESPAWN: restored in classic_boss_prince_tortheldrin::JustAppeared
                        }
                        else
                            TC_LOG_ERROR("scripts", "classic_instance_dire_maul: Tortheldrin not found!");
                    }
                    m_auiEncounter[TYPE_IMMOL_THAR] = data;
                    break;
                }
                case TYPE_BOSS_ZEVRIM:
                    m_auiEncounter[TYPE_BOSS_ZEVRIM] = data;
                    break;
                case DATA_TENDRIS_AGGRO:
                    break;
                case TYPE_SPEAK_ECORCEFER:
                {
                    if (data == DONE)
                        DoUseDoorOrButton(m_uiDoorAlzzinInGUID);
                    m_auiEncounter[TYPE_SPEAK_ECORCEFER] = data;
                    break;
                }
                case TYPE_GORDOK_TRIBUTE:
                {
                    if (data == SPECIAL)
                    {
                        // Guards return SPECIAL on death via eventAI
                        --m_uiGuardAliveCount;
                        SetData(TYPE_GORDOK_TRIBUTE, IN_PROGRESS);
                    }
                    if (data == DONE)
                    {
                        if (m_bIsGordokTributeRespawned)
                            return;

                        m_uiFinalGuardAliveCount = m_uiGuardAliveCount;
                        DoRespawnGameObject(m_uiGordokTributeGUID);
                        m_bIsGordokTributeRespawned = true;
                    }
                    m_auiEncounter[TYPE_GORDOK_TRIBUTE] = data;
                    break;
                }
                case TYPE_BROKEN_TRAP:
                    m_auiEncounter[TYPE_BROKEN_TRAP] = data;
                    break;
                case TYPE_GORDOK_OGRE_SUIT:
                    m_auiEncounter[TYPE_GORDOK_OGRE_SUIT] = data;
                    break;
                case TYPE_CHORUSH_EQUIPMENT:
                    m_auiEncounter[TYPE_CHORUSH_EQUIPMENT] = data;
                    break;
                case TYPE_MOLDAR:
                    m_auiEncounter[TYPE_MOLDAR] = data;
                    break;
                case TYPE_ALZZIN:
                    if (data == SPECIAL)
                        DoUseDoorOrButton(m_uiCrumbleWallGUID);
                    else if (data == DONE)
                    {
                        DoUseDoorOrButton(m_uiCorruptVineGUID);

                        for (ObjectGuid const& guid : m_lFelvineShardGUIDs)
                            DoRespawnGameObject(guid);
                    }
                    m_auiEncounter[type] = data;
                    break;
                case DATA_TANNIN_LOOTED:
                    m_bIsTanninLooted = data != 0;
                    break;
                default:
                    break;
            }

            if (data == DONE)
                SaveEncounters();
        }

        // VMaNGOS SetData64
        void SetGuidData(uint32 type, ObjectGuid data) override
        {
            if (type == TYPE_CRISTAL_EVENT && GetData(TYPE_CRISTAL_EVENT) == NOT_STARTED)
                DoSortCristalsEventMobs();

            if (type == TYPE_CRISTAL_EVENT && GetData(TYPE_CRISTAL_EVENT) == IN_PROGRESS)
            {
                uint8 notEmptyRoomsCount = 0;
                for (uint8 i = 0; i < MAX_CRISTALS; ++i)
                {
                    if (!m_auiCristalsGUID[i].IsEmpty())             // This check is used, to ensure which runes still need processing
                    {
                        m_alCristalsEventtMobGUIDSorted[i].remove(data);
                        if (m_alCristalsEventtMobGUIDSorted[i].empty())
                        {
                            DoUseDoorOrButton(m_auiCristalsGUID[i]);
                            m_auiCristalsGUID[i].Clear();
                        }
                        else
                            ++notEmptyRoomsCount;                   // found a not empty room
                    }
                }
                if (!notEmptyRoomsCount)
                    SetData(TYPE_CRISTAL_EVENT, DONE);
            }

            if (type == DATA_DREADSTEED_RITUAL_PLAYER)
                m_uiRitualPlayerGUID = data;
        }

        uint32 GetData(uint32 type) const override
        {
            if (type == DATA_TANNIN_LOOTED)
                return m_bIsTanninLooted ? 1 : 0;

            if (type == DATA_FINAL_GUARD_ALIVE_COUNT)
                return m_uiFinalGuardAliveCount;

            if (type < INSTANCE_DIRE_MAUL_MAX_ENCOUNTER)
                return m_auiEncounter[type];

            return 0;
        }

        // VMaNGOS GetData64
        ObjectGuid GetGuidData(uint32 type) const override
        {
            switch (type)
            {
                case NPC_GUARD_SLIPKIK:
                    return m_uiSlipKikGUID;
                case NPC_CHORUSH:
                    return m_uiChoRushTheObserverGUID;
                case NPC_KING_GORDOK:
                    return m_uiKingGordokGUID;
                case NPC_IMMOL_THAR:
                    return m_uiImmolTharGUID;
                case NPC_TORTHELDRIN:
                    return m_uiTortheldrinGUID;
                case GO_FORCE_FIELD:
                    return m_uiForceFieldGUID;
                case GO_MAGIC_VORTEX:
                    return m_uiMagicVortexGUID;
                case GO_RITUAL_CANDLE_AURA:
                    return m_uiRitualCandleAuraGUID;
                case DATA_DREADSTEED_RITUAL_PLAYER:
                    return m_uiRitualPlayerGUID;
                default:
                    break;
            }
            return ObjectGuid::Empty;
        }

        void DoSortCristalsEventMobs()
        {
            if (GetData(TYPE_CRISTAL_EVENT) != NOT_STARTED)
                return;

            for (uint8 i = 0; i < MAX_CRISTALS; ++i)
            {
                if (GameObject* rune = instance->GetGameObject(m_auiCristalsGUID[i]))
                {
                    for (ObjectGuid const& guid : m_lCristalsEventtMobGUIDList)
                    {
                        if (Creature* creature = instance->GetCreature(guid))
                        {
                            if (creature->IsAlive() && creature->GetDistance(rune) < 20.0f)
                                m_alCristalsEventtMobGUIDSorted[i].push_back(guid);
                        }
                    }
                }
            }

            SetData(TYPE_CRISTAL_EVENT, IN_PROGRESS);
        }

    protected:
        std::array<uint32, INSTANCE_DIRE_MAUL_MAX_ENCOUNTER> m_auiEncounter;
        std::array<std::unique_ptr<PersistentInstanceScriptValue<uint32>>, INSTANCE_DIRE_MAUL_MAX_ENCOUNTER> m_savedEncounter;

        // East
        ObjectGuid m_uiDoorAlzzinInGUID;
        ObjectGuid m_uiCrumbleWallGUID;
        ObjectGuid m_uiCorruptVineGUID;
        std::list<ObjectGuid> m_lFelvineShardGUIDs;

        // West
        ObjectGuid m_uiMagicVortexGUID;
        ObjectGuid m_uiForceFieldGUID;
        ObjectGuid m_uiImmolTharGUID;
        ObjectGuid m_uiTortheldrinGUID;
        std::array<ObjectGuid, MAX_CRISTALS> m_auiCristalsGUID;
        ObjectGuid m_uiRitualCandleAuraGUID;
        ObjectGuid m_uiRitualPlayerGUID;

        std::array<std::list<ObjectGuid>, MAX_CRISTALS> m_alCristalsEventtMobGUIDSorted;
        std::list<ObjectGuid> m_lCristalsEventtMobGUIDList;
        std::list<ObjectGuid> m_lImmolTharGardiensMobGUIDList;
        std::list<ObjectGuid> m_lTendrisProtectorsMobGUIDList;

        // North
        uint32 m_uiGuardAliveCount = 6;
        uint32 m_uiFinalGuardAliveCount = 6;
        ObjectGuid m_uiTendrisGUID;
        ObjectGuid m_uiOldIronbarkGUID;
        ObjectGuid m_uiSlipKikGUID;
        ObjectGuid m_uiCaptainKromcrushGUID;
        ObjectGuid m_uiKingGordokGUID;
        ObjectGuid m_uiChoRushTheObserverGUID;
        ObjectGuid m_uiGordokTributeGUID;
        ObjectGuid m_uiBrokenTrapGUID;
        bool m_bIsGordokTributeRespawned = false;
        bool m_bIsTanninLooted = false;
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new classic_instance_dire_maul_InstanceScript(map);
    }
};

// TRASH
/*######
## npc_reste_mana (11483)
######*/

enum ClassicDMResteMana
{
    SPELL_CHAINLIGHTNING     = 15659,
    SPELL_BLINK              = 14514
};

struct classic_npc_reste_mana : public ScriptedAI
{
    classic_npc_reste_mana(Creature* creature) : ScriptedAI(creature), m_uiChainLighting_Timer(0), m_uiBlink_Timer(0)
    {
        m_pInstance = creature->GetInstanceScript();
    }

    InstanceScript* m_pInstance;
    uint32 m_uiChainLighting_Timer;
    uint32 m_uiBlink_Timer;

    void Reset() override
    {
        m_uiBlink_Timer = urand(12000, 23000);
        m_uiChainLighting_Timer = urand(2000, 6000);
        me->ApplySpellImmune(0, IMMUNITY_SCHOOL, SPELL_SCHOOL_MASK_ARCANE, true);
    }

    void JustDied(Unit* /*killer*/) override
    {
        if (m_pInstance)
            m_pInstance->SetGuidData(TYPE_CRISTAL_EVENT, me->GetGUID());
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        if (me->IsNonMeleeSpellCast(false))
            return;

        if (m_uiBlink_Timer < diff)
        {
            DoCastVictim(SPELL_BLINK);
            m_uiBlink_Timer = 6000;
            return;
        }
        else
            m_uiBlink_Timer -= diff;

        if (m_uiChainLighting_Timer < diff)
        {
            DoCastVictim(SPELL_CHAINLIGHTNING);
            m_uiChainLighting_Timer = 6000;
            return;
        }
        else
            m_uiChainLighting_Timer -= diff;
    }
};

/*######
## npc_arcane_aberration (11480)
######*/

enum ClassicDMArcaneAberration
{
    SPELL_MANABURN           = 22936,
    SPELL_ARCANEBOLT         = 15979
};

struct classic_npc_arcane_aberration : public ScriptedAI
{
    classic_npc_arcane_aberration(Creature* creature) : ScriptedAI(creature), m_uiArcaneBoltTimer(0), m_bManaBurnDone(false)
    {
        m_pInstance = creature->GetInstanceScript();
    }

    InstanceScript* m_pInstance;
    uint32 m_uiArcaneBoltTimer;
    bool m_bManaBurnDone;

    void Reset() override
    {
        m_uiArcaneBoltTimer = urand(0, 400);
        m_bManaBurnDone = false;
        me->ApplySpellImmune(0, IMMUNITY_SCHOOL, SPELL_SCHOOL_MASK_ARCANE, true);
    }

    void JustDied(Unit* /*killer*/) override
    {
        if (m_pInstance)
            m_pInstance->SetGuidData(TYPE_CRISTAL_EVENT, me->GetGUID());
    }

    void DamageTaken(Unit* /*attacker*/, uint32& /*damage*/, DamageEffectType /*damageType*/, SpellInfo const* /*spellInfo*/) override
    {
        if (me->GetHealthPct() > 5.0f)
            return;

        if (!m_bManaBurnDone)
        {
            DoCastSelf(SPELL_MANABURN);
            m_bManaBurnDone = true;
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        if (me->IsNonMeleeSpellCast(false))
            return;

        if (m_uiArcaneBoltTimer < diff)
        {
            DoCastVictim(SPELL_ARCANEBOLT);
            m_uiArcaneBoltTimer = urand(2400, 3800);
            return;
        }
        else
            m_uiArcaneBoltTimer -= diff;
    }
};

/*######
## npc_residual_montruosity (11484)
######*/

enum ClassicDMResidualMontruosity
{
    SPELL_ARCANEBLAST        = 22940,
    SPELL_SUMMON_MANABURSTS  = 22939,
    SPELL_ARCANEBOLT2        = 13748,

    NPC_RESIDUAL_MONTRUOSITY = 11484
};

struct classic_npc_residual_montruosity : public ScriptedAI
{
    classic_npc_residual_montruosity(Creature* creature) : ScriptedAI(creature), m_uiArcaneBoltTimer(0), m_uiArcaneBlastTimer(0)
    {
        m_pInstance = creature->GetInstanceScript();
    }

    InstanceScript* m_pInstance;
    uint32 m_uiArcaneBoltTimer;
    uint32 m_uiArcaneBlastTimer;

    void Reset() override
    {
        m_uiArcaneBlastTimer = urand(1000, 2500);
        m_uiArcaneBoltTimer = urand(0, 400);
        me->ApplySpellImmune(0, IMMUNITY_SCHOOL, SPELL_SCHOOL_MASK_ARCANE, true);
    }

    void JustDied(Unit* /*killer*/) override
    {
        DoCastSelf(SPELL_SUMMON_MANABURSTS);
    }

    void UpdateFormationSpeed()
    {
        float newspeed = 1.79f;
        if (!me->GetVictim())
        {
            float closestbefore = 45.0f;
            float closestbehind = 45.0f;

            std::list<Creature*> montruosityList;
            me->GetCreatureListWithEntryInGrid(montruosityList, NPC_RESIDUAL_MONTRUOSITY, 45.0f);
            for (Creature* itr : montruosityList)
            {
                if (itr == me)
                    continue;

                if (!(itr->IsWithinDistInMap(me, 45.0f) && itr->HasInArc(float(M_PI), me)))
                {
                    float distance = me->GetDistance(itr);
                    if (distance < closestbefore)
                        closestbefore = distance;
                }
                else
                {
                    float distance = me->GetDistance(itr);
                    if (distance < closestbehind)
                        closestbehind = distance;
                }
            }
            if ((closestbefore > 36.0f) && (closestbehind < 32.0f))
                newspeed = 2.20f;
            else if ((closestbefore < 32.0f) && (closestbehind > 36.0f))
                newspeed = 1.00f;
        }
        me->SetSpeedRate(MOVE_WALK, newspeed);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
        {
            UpdateFormationSpeed();
            return;
        }

        if (me->IsNonMeleeSpellCast(false))
            return;

        if (m_uiArcaneBoltTimer < diff)
        {
            DoCastVictim(SPELL_ARCANEBOLT2);
            m_uiArcaneBoltTimer = urand(2400, 3800);
            return;
        }
        else
            m_uiArcaneBoltTimer -= diff;

        if (m_uiArcaneBlastTimer < diff)
        {
            DoCastSelf(SPELL_ARCANEBLAST);
            m_uiArcaneBlastTimer = urand(3800, 5200);
            return;
        }
        else
            m_uiArcaneBlastTimer -= diff;
    }
};

/*######
## go_broken_trap
######*/

enum ClassicDMBrokenTrap
{
    QUEST_A_BROKEN_TRAP     = 1193
};

struct classic_go_broken_trap : public GameObjectAI
{
    classic_go_broken_trap(GameObject* go) : GameObjectAI(go) { }

    void OnQuestReward(Player* player, Quest const* quest, LootItemType /*type*/, uint32 /*opt*/) override
    {
        InstanceScript* instance = player->GetInstanceScript();
        if (!instance || quest->GetQuestId() != QUEST_A_BROKEN_TRAP)
            return;

        instance->SetData(TYPE_BROKEN_TRAP, DONE);
        me->SetFlag(GO_FLAG_NOT_SELECTABLE); // VMaNGOS GO_FLAG_NO_INTERACT
        // VMaNGOS: pPlayer->SummonGameObject(GO_FIXED_TRAP, ..., 43200); summoned from the GO here so the trap is not bound to the player
        me->SummonGameObject(GO_FIXED_TRAP, me->GetPosition(), QuaternionData::fromEulerAnglesZYX(me->GetOrientation(), 0.0f, 0.0f), 43200s, GO_SUMMON_TIMED_DESPAWN);
        me->Delete();
    }
};

/*######
## npc_mizzle_the_crafty
######*/

enum ClassicDMMizzle
{
    SAY_KILL_KING_1      = 9348,
    SAY_KILL_KING_2      = 9411
};

struct classic_npc_mizzle_the_crafty : public ScriptedAI
{
    classic_npc_mizzle_the_crafty(Creature* creature) : ScriptedAI(creature), m_bJustReachedHome(false), m_bIntroStarted(false)
    {
        m_pInstance = creature->GetInstanceScript();
    }

    bool m_bJustReachedHome;
    bool m_bIntroStarted;
    InstanceScript* m_pInstance;

    void Reset() override { }

    // VMaNGOS does this in the constructor (Mizzle is summoned by the instance when King Gordok dies)
    void JustAppeared() override
    {
        ScriptedAI::JustAppeared();

        if (m_bIntroStarted)
            return;

        m_bIntroStarted = true;
        me->SetHomePosition(816.30f, 481.80f, 37.30f, 3.170f);
        me->GetMotionMaster()->MoveTargetedHome();
        ClassicScriptText(SAY_KILL_KING_1, me);
    }

    void JustReachedHome() override
    {
        if (!m_bJustReachedHome)
        {
            ClassicScriptText(SAY_KILL_KING_2, me);
            me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
            m_bJustReachedHome = true;
        }
    }

    void SpellHitTarget(WorldObject* /*target*/, SpellInfo const* /*spellInfo*/) override
    {
        me->SetOrientation(3.170f);
    }
};

/*######
## npc_knot_thimblejack
######*/

enum ClassicDMKnotThimblejack
{
    SPELL_GORDOK_OGRE_SUIT_T    = 22813,
    SPELL_GORDOK_OGRE_SUIT_L    = 22815,
    SPELL_LEARN_GOS_T           = 22814,
    SPELL_LEARN_GOS_L           = 22816,

    QUEST_GORDOK_OGRE_SUIT      = 5518,
    QUEST_FREE_KNOT             = 5525,
    QUEST_FREE_KNOT_REPEATABLE  = 7429,

    GOSSIP_MENU_1               = 6795, // npc_text
    GOSSIP_MENU_2               = 6883, // npc_text

    GO_KNOTS_BALL_AND_CHAIN     = 179511
};

char const* const GOSSIP_ITEM_KNOT_WHY_TRAP   = "Why should I bother fixing the trap? Why not just eliminate the guard the old fashioned way?";
char const* const GOSSIP_ITEM_KNOT_OGRE_SUIT  = "Please teach me how to make a Gordok Ogre Suit!";

struct classic_npc_knot_thimblejack : public ScriptedAI
{
    classic_npc_knot_thimblejack(Creature* creature) : ScriptedAI(creature)
    {
        m_pInstance = creature->GetInstanceScript();
    }

    InstanceScript* m_pInstance;

    void Reset() override { }

    void MovementInform(uint32 type, uint32 id) override
    {
        if (type != POINT_MOTION_TYPE)
            return;

        switch (id)
        {
            case 1:
                me->GetMotionMaster()->MovePoint(2, 470.225372f, 542.596065f, -25.363186f);
                break;
            case 2:
                me->GetMotionMaster()->MovePoint(3, 465.367096f, 542.843689f, -23.911942f);
                break;
            case 3:
                me->GetMotionMaster()->MovePoint(4, 453.346649f, 544.004456f, -23.900503f);
                break;
            case 4:
                me->GetMotionMaster()->MovePoint(5, 435.055573f, 542.503967f, -18.395958f);
                break;
            case 5:
                me->GetMotionMaster()->MovePoint(6, 412.700775f, 537.009277f, -18.343367f);
                break;
            case 6:
                me->GetMotionMaster()->MovePoint(7, 401.076355f, 524.250061f, -12.787789f);
                break;
            case 7:
                me->GetMotionMaster()->MovePoint(8, 390.540833f, 502.830505f, -12.675946f);
                break;
            case 8:
                me->GetMotionMaster()->MovePoint(9, 386.112335f, 483.010040f, -7.232251f);
                break;
            case 9:
                me->GetMotionMaster()->MovePoint(10, 385.963501f, 442.606476f, -7.193601f);
                break;
            case 10:
                me->GetMotionMaster()->MovePoint(11, 385.531738f, 416.619385f, -1.703543f);
                break;
            case 11:
                me->GetMotionMaster()->MovePoint(12, 385.355988f, 375.940430f, -1.623023f);
                break;
            case 12:
                me->GetMotionMaster()->MovePoint(13, 385.620300f, 350.467163f, 3.825020f);
                break;
            case 13:
                me->DespawnOrUnsummon(5s); // Despawn after 5 sec
                break;
            default:
                break;
        }
    }

    bool OnGossipHello(Player* player) override
    {
        if (me->IsQuestGiver())
            player->PrepareQuestMenu(me->GetGUID());

        AddGossipItemFor(player, GossipOptionNpc::None, GOSSIP_ITEM_KNOT_WHY_TRAP, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);

        // Once turned in, the quest's status is QUEST_STATUS_REWARDED and its entry leaves the active quest list, so it can
        // never also read as QUEST_STATUS_COMPLETE: the reward check alone is the test.
        if (player->GetQuestRewardStatus(QUEST_GORDOK_OGRE_SUIT))
        {
            if (player->GetBaseSkillValue(SKILL_LEATHERWORKING) >= 275 && !player->HasSpell(SPELL_GORDOK_OGRE_SUIT_L))
                AddGossipItemFor(player, GossipOptionNpc::None, GOSSIP_ITEM_KNOT_OGRE_SUIT, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);

            if (player->GetBaseSkillValue(SKILL_TAILORING) >= 275 && !player->HasSpell(SPELL_GORDOK_OGRE_SUIT_T))
                AddGossipItemFor(player, GossipOptionNpc::None, GOSSIP_ITEM_KNOT_OGRE_SUIT, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
        }

        // TODO(classic): npc_text 6795 / 6883 must exist in the TC world DB (VMaNGOS npc_text ids)
        SendGossipMenuFor(player, GOSSIP_MENU_1, me->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, uint32 /*menuId*/, uint32 gossipListId) override
    {
        uint32 const action = player->PlayerTalkClass->GetGossipOptionAction(gossipListId);
        ClearGossipMenuFor(player);

        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF + 1: SendGossipMenuFor(player, GOSSIP_MENU_2, me->GetGUID()); break;
            case GOSSIP_ACTION_INFO_DEF + 2: player->CastSpell(player, SPELL_LEARN_GOS_L, true); break;
            case GOSSIP_ACTION_INFO_DEF + 3: player->CastSpell(player, SPELL_LEARN_GOS_T, true); break;
            default: break;
        }

        return true;
    }

    void OnQuestReward(Player* player, Quest const* quest, LootItemType /*type*/, uint32 /*opt*/) override
    {
        if (!player->GetInstanceScript())
            return;

        if (quest && (quest->GetQuestId() == QUEST_FREE_KNOT || quest->GetQuestId() == QUEST_FREE_KNOT_REPEATABLE))
        {
            if (GameObject* go = me->FindNearestGameObject(GO_KNOTS_BALL_AND_CHAIN, 20.0f))
                go->Delete();
            me->RemoveNpcFlag(NPCFlags(UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER));
            me->GetMotionMaster()->MovePoint(1, 518.325f, 542.00f, -23.901f);
        }
    }
};

/*######
## npc_gordok_brute
######*/

enum ClassicDMGordokBrute
{
    SPELL_BACK_HAND     =   6253,
    SPELL_ENRAGE        =   15716,
    SPELL_BRUISING_BLOW =   22572,
    SPELL_PUMMEL        =   15615,
    SPELL_UPPERCUT      =   18072
};

struct classic_npc_gordok_brute : public ScriptedAI
{
    classic_npc_gordok_brute(Creature* creature) : ScriptedAI(creature),
        m_uiBackhand_Timer(0), m_uiBruisingBlow_Timer(0), m_uiPummel_Timer(0), m_uiUppercut_Timer(0), m_bEnrage(false)
    {
        /** Save current equipment of the creature */
        m_uiEquipment_id = me->GetCurrentEquipmentId();
    }

    uint8 m_uiEquipment_id;
    uint32 m_uiBackhand_Timer;
    uint32 m_uiBruisingBlow_Timer;
    uint32 m_uiPummel_Timer;
    uint32 m_uiUppercut_Timer;
    bool m_bEnrage;

    void Reset() override
    {
        me->LoadEquipment(m_uiEquipment_id, true);
        m_uiBackhand_Timer     = 2000;
        m_uiUppercut_Timer     = 0;
        m_uiBruisingBlow_Timer = 6000;
        m_uiPummel_Timer       = 5000;
        m_bEnrage = false;
    }

    void JustEngagedWith(Unit* who) override
    {
        switch (urand(0, 4))
        {
            case 0:
                me->Say("Me smash! You die!", LANG_UNIVERSAL);
                break;
            case 1:
                me->Say("The Great One will smash you!", LANG_UNIVERSAL);
                break;
            case 2:
                me->Say(Trinity::StringFormat("Raaar!!! Me smash {}!", who->GetName()), LANG_UNIVERSAL);
                break;
            default:
                break;
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        /** Spell above 30% of life */
        if (m_uiBruisingBlow_Timer < diff)
        {
            if (me->GetHealthPct() > 30.0f)
                if (DoCastVictim(SPELL_BRUISING_BLOW) == SPELL_CAST_OK)
                    m_uiBruisingBlow_Timer = urand(3000, 8000);
        }
        else
            m_uiBruisingBlow_Timer -= diff;

        if (m_uiPummel_Timer < diff)
        {
            if (me->GetHealthPct() > 30.0f && me->GetVictim()->IsNonMeleeSpellCast(true))
                if (DoCastVictim(SPELL_PUMMEL) == SPELL_CAST_OK)
                    m_uiPummel_Timer = urand(8000, 10000);
        }
        else
            m_uiPummel_Timer -= diff;

        if (me->GetHealthPct() < 30.0f && !m_bEnrage)
        {
            me->LoadEquipment(0, true);
            me->TextEmote("Gordok Brute puts his club away and begins swinging wildly!", nullptr, false);

            me->CastSpell(me, SPELL_ENRAGE, false);
            m_bEnrage = true;
        }

        if (me->GetHealthPct() < 30.0f && m_bEnrage)
        {
            if (m_uiBackhand_Timer < diff)
            {
                if (DoCastVictim(SPELL_BACK_HAND) == SPELL_CAST_OK)
                    m_uiBackhand_Timer = urand(5000, 9000);
            }
            else
                m_uiBackhand_Timer -= diff;
        }

        if (m_uiUppercut_Timer < diff)
        {
            if (DoCastVictim(SPELL_UPPERCUT) == SPELL_CAST_OK)
                m_uiUppercut_Timer = urand(6000, 10000);
        }
        else
            m_uiUppercut_Timer -= diff;
    }
};

/*######
## boss_guards
######*/

enum ClassicDMGuards
{
    // For ALL
    SPELL_KNOCK_AWAY            = 10101,
    SPELL_SHIELD_CHARGE         = 15749,
    SPELL_STRIKE                = 14516,
    SPELL_SHIELD_BASH           = 11972,
    SPELL_GUARD_ENRAGE          = 8269,

    // Guard Fengus
    SPELL_FENGUS_FEROCITY       = 22817,
    SPELL_ICE_LOCK              = 22856,

    // Guard Slip'kik
    SPELL_SLIPKIKS_SAVVY        = 22820,

    // Guard Mol'dar
    SPELL_MOLDAR_MOXIE          = 22818,

    EMOTE_ENRAGE                = 9413
};

char const* const SAY_GUARD_BETRAYED = "Why... Boss.. betray.. us...?";

struct classic_boss_guards : public ScriptedAI
{
    classic_boss_guards(Creature* creature) : ScriptedAI(creature),
        m_uiStrike_Timer(0), m_uiShieldCharge_Timer(0), m_uiKnockAway_Timer(0), m_uiShieldBash_Timer(0), m_bEnrageUsed(false), m_uiCombatBugTimer(0)
    {
        pInstance = creature->GetInstanceScript();
    }

    InstanceScript* pInstance;

    uint32 m_uiStrike_Timer;
    uint32 m_uiShieldCharge_Timer;
    uint32 m_uiKnockAway_Timer;
    uint32 m_uiShieldBash_Timer;
    bool m_bEnrageUsed;

    uint32 m_uiCombatBugTimer;

    void Reset() override
    {
        m_uiShieldCharge_Timer = 500;
        m_uiStrike_Timer       = urand(10000, 20000);
        m_uiKnockAway_Timer    = urand(20000, 30000);
        m_uiShieldBash_Timer   = urand(8000, 15000);
        m_bEnrageUsed          = false;

        m_uiCombatBugTimer = 0;
    }

    void JustDied(Unit* /*killer*/) override
    {
        // Guards no longer drop loot after contributing to the Tribute
        if (pInstance && pInstance->GetData(TYPE_GORDOK_TRIBUTE) == DONE)
        {
            me->Say(SAY_GUARD_BETRAYED, LANG_UNIVERSAL);
            ClassicDMClearLoot(me);
        }
    }

    void SpellHitTarget(WorldObject* target, SpellInfo const* spellInfo) override
    {
        if (spellInfo->Id == SPELL_KNOCK_AWAY)
            if (Unit* unit = target->ToUnit())
                ModifyThreatByPercent(unit, -50);
    }

    void UpdateAI(uint32 diff) override
    {
        // Workaround fix for bug where Slip'kik doesnt leave combat properly if he charges through the trap
        if (m_uiCombatBugTimer)
        {
            if (m_uiCombatBugTimer <= diff)
            {
                if (me->IsInCombat() && me->HasAura(SPELL_ICE_LOCK))
                {
                    me->CombatStop(true);
                    me->GetThreatManager().ClearAllThreat();
                }
                m_uiCombatBugTimer = 0;
            }
            else
                m_uiCombatBugTimer -= diff;
        }

        if (!UpdateVictim())
            return;

        // Shield Charge
        if (m_uiShieldCharge_Timer < diff)
        {
            // VMaNGOS SelectAttackingTarget(ATTACKING_TARGET_FARTHEST, 0, SPELL_SHIELD_CHARGE, SELECT_FLAG_PLAYER | SELECT_FLAG_IN_LOS)
            float range = 0.0f;
            if (SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(SPELL_SHIELD_CHARGE, DIFFICULTY_NONE))
                range = spellInfo->GetMaxRange(false);

            if (Unit* target = SelectTarget(SelectTargetMethod::MaxDistance, 0, FarthestTargetSelector(me, range, true, true)))
            {
                if (DoCast(target, SPELL_SHIELD_CHARGE) == SPELL_CAST_OK)
                {
                    m_uiShieldCharge_Timer = urand(12000, 16000);
                    if (me->GetEntry() == NPC_GUARD_SLIPKIK)
                        m_uiCombatBugTimer = 3000;
                }
            }
        }
        else
            m_uiShieldCharge_Timer -= diff;

        // Shield Bash
        if (m_uiShieldBash_Timer < diff)
        {
            if (me->GetVictim()->IsNonMeleeSpellCast(true))
            {
                if (DoCastVictim(SPELL_SHIELD_BASH) == SPELL_CAST_OK)
                    m_uiShieldBash_Timer = urand(10000, 15000);
            }
        }
        else
            m_uiShieldBash_Timer -= diff;

        // Strike
        if (m_uiStrike_Timer < diff)
        {
            if (DoCastVictim(SPELL_STRIKE) == SPELL_CAST_OK)
                m_uiStrike_Timer = urand(10000, 15000);
        }
        else
            m_uiStrike_Timer -= diff;

        // Knock Away
        if (m_uiKnockAway_Timer < diff)
        {
            if (DoCastVictim(SPELL_KNOCK_AWAY) == SPELL_CAST_OK)
                m_uiKnockAway_Timer = urand(20000, 30000);
        }
        else
            m_uiKnockAway_Timer -= diff;

        // Enrage
        if (!m_bEnrageUsed && me->GetHealthPct() < 50.0f)
        {
            DoCastSelf(SPELL_GUARD_ENRAGE);
            ClassicScriptText(EMOTE_ENRAGE, me);
            me->CallForHelp(50.0f);
            m_bEnrageUsed = true;
        }
    }
};

/*######
## go_fixed_trap
######*/

struct classic_go_fixed_trap : public GameObjectAI
{
    classic_go_fixed_trap(GameObject* go) : GameObjectAI(go), _triggered(false) { }

    bool _triggered;

    void UpdateAI(uint32 /*diff*/) override
    {
        if (_triggered)
            return;

        InstanceScript* pInstance = me->GetInstanceScript();
        if (!pInstance)
            return;

        if (Creature* slipkik = me->GetMap()->GetCreature(pInstance->GetGuidData(NPC_GUARD_SLIPKIK)))
        {
            if (me->IsWithinDist(slipkik, 2.0f))
            {
                slipkik->CombatStop(true);
                slipkik->GetThreatManager().ClearAllThreat();
                slipkik->SetImmuneToNPC(true);
                slipkik->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE); // UNIT_FLAG_SPAWNING
                slipkik->SetImmuneToPC(true);
                slipkik->CastSpell(slipkik, SPELL_ICE_LOCK, true);
                me->SendCustomAnim(0);
                me->Delete();
                _triggered = true;
            }
        }
    }
};

/*######
## boss_kromcrush
######*/

enum ClassicDMKromcrush
{
    SPELL_RETALIATION           = 22857,
    SPELL_MORTAL_CLEAVE         = 22859,
    SPELL_INTIMIDATING_SHOUT    = 19134,
    SPELL_CALL_REAVERS          = 22860,

    NPC_GORDOK_REAVER           = 11450,

    EMOTE_RETALIATION           = 9477,
    SAY_AGGRO                   = 9418,
    SAY_CALL_HELP               = 9478,
    SAY_GO_FURGUS               = 9416,
    SAY_FIND_FURGUS             = 9424
};

struct ClassicDMGossipMenuItem
{
    uint32 m_uiMenu;       // npc_text id
    char const* m_chItem;
};

ClassicDMGossipMenuItem const sKromcrushGossips[4] =
{
    { 6913, "Um, I'm taking some prisoners we found outside before the king for punishment." },
    { 6915, "Er... that's how I found them. I wanted to show the king that they were a threat. Say Captain... I overhead Guard Fengus calling you a fat, useless knoll lover. " },
    { 6914, "So, now that I'm the king... what have you got for me?!" },
    { 6920, "This sounds like a task worthy of the new king!" }
};

struct classic_boss_kromcrush : public ScriptedAI
{
    classic_boss_kromcrush(Creature* creature) : ScriptedAI(creature),
        m_uiMortalCleave_Timer(0), m_uiIntimidatingShout_Timer(0), m_uiRetaliation_Timer(0), m_bRetaliationUsed(false), m_bCallReavers(false)
    {
        pInstance = creature->GetInstanceScript();
    }

    InstanceScript* pInstance;

    uint32 m_uiMortalCleave_Timer;
    uint32 m_uiIntimidatingShout_Timer;
    uint32 m_uiRetaliation_Timer;
    bool m_bRetaliationUsed;
    bool m_bCallReavers;

    void Reset() override
    {
        m_uiMortalCleave_Timer      = urand(7000, 13000);
        m_uiIntimidatingShout_Timer = 10000;
        m_bRetaliationUsed          = false;
        m_bCallReavers              = false;
    }

    void goToFengus()
    {
        if (pInstance)
            pInstance->SetData(TYPE_GORDOK_OGRE_SUIT, DONE);
        ClassicScriptText(SAY_GO_FURGUS, me);
        DoCastSelf(SPELL_ENRAGE);
        me->SetWalk(false);
        me->GetMotionMaster()->MovePoint(0, 501.971f, 482.321f, 29.463f);
        me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE); // UNIT_FLAG_SPAWNING
        me->SetUninteractible(true);               // UNIT_FLAG_UNINTERACTIBLE
        me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
    }

    void JustEngagedWith(Unit* who) override
    {
        ClassicScriptText(SAY_AGGRO, me, who);
    }

    void MovementInform(uint32 movementType, uint32 pointId) override
    {
        if (movementType != POINT_MOTION_TYPE)
            return;

        switch (pointId)
        {
            case 0: me->GetMotionMaster()->MovePoint(1, 536.947f, 535.784f, 27.917f); break;
            case 1: me->GetMotionMaster()->MovePoint(2, 533.410f, 591.445f, -4.755f); break;
            case 2: me->GetMotionMaster()->MovePoint(3, 538.760f, 540.026f, -25.403f); break;
            case 3: me->GetMotionMaster()->MovePoint(4, 386.963f, 515.853f, -12.788f); break;
            case 4: me->GetMotionMaster()->MovePoint(5, 383.887f, 258.610f, 11.440f); break;
            case 5:
            {
                ClassicScriptText(SAY_FIND_FURGUS, me);
                me->GetMotionMaster()->Clear();
                // VMaNGOS Relocate(383.887f, 258.610f, 11.440f): the creature already stands on that point
                me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                me->SetUninteractible(false);
                break;
            }
            default:
                break;
        }
    }

    void JustDied(Unit* /*killer*/) override
    {
        // Kromcrush no longer drops loot after contributing to the Tribute
        if (pInstance && pInstance->GetData(TYPE_GORDOK_TRIBUTE) == DONE)
        {
            me->Say(SAY_GUARD_BETRAYED, LANG_UNIVERSAL);
            ClassicDMClearLoot(me);
        }
    }

    void EnterEvadeMode(EvadeReason why) override
    {
        ScriptedAI::EnterEvadeMode(why);

        if (pInstance && pInstance->GetData(TYPE_GORDOK_OGRE_SUIT) == DONE)
        {
            me->GetMotionMaster()->Clear();
            MovementInform(POINT_MOTION_TYPE, 4);
        }
    }

    void JustSummoned(Creature* summoned) override
    {
        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
            summoned->AI()->AttackStart(target);
    }

    void CallReavers()
    {
        // Kromcrush summons Reavers in different places depending on where he is ...
        me->HandleEmoteCommand(EMOTE_ONESHOT_ROAR);
        if (me->GetDistance(495.395f, 482.309f, 29.4627f) < 75.0f)
        {
            for (uint8 i = 0; i < 2; ++i)
                me->SummonCreature(NPC_GORDOK_REAVER, 495.395f, 482.309f, 29.4627f, 6.267f, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 5min);
        }
        else
            for (uint8 i = 0; i < 2; ++i)
                me->SummonCreature(NPC_GORDOK_REAVER, 633.437f, 482.309f, 29.4653f, 3.198f, TEMPSUMMON_TIMED_OR_CORPSE_DESPAWN, 5min);

        //don't use spell because the guards despawn atm ...
        //DoCastSelf(SPELL_CALL_REAVERS);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        // Mortal Cleave
        if (m_uiMortalCleave_Timer < diff)
        {
            if (DoCastVictim(SPELL_MORTAL_CLEAVE) == SPELL_CAST_OK)
                m_uiMortalCleave_Timer = urand(15000, 20000);
        }
        else
            m_uiMortalCleave_Timer -= diff;

        // Intimidating Shout
        if (m_uiIntimidatingShout_Timer < diff)
        {
            if (DoCastVictim(SPELL_INTIMIDATING_SHOUT) == SPELL_CAST_OK)
                m_uiIntimidatingShout_Timer = urand(30000, 35000);
        }
        else
            m_uiIntimidatingShout_Timer -= diff;

        // Retaliation
        if (!m_bRetaliationUsed && me->GetHealthPct() < 25.0f)
        {
            DoCastSelf(SPELL_RETALIATION);
            ClassicScriptText(EMOTE_RETALIATION, me);
            m_bRetaliationUsed = true;
        }

        // Call Reavers
        if (!m_bCallReavers && me->GetHealthPct() < 50.0f)
        {
            ClassicScriptText(SAY_CALL_HELP, me);
            CallReavers();
            m_bCallReavers = true;
        }
    }

    bool OnGossipHello(Player* player) override
    {
        if (me->IsQuestGiver())
            player->PrepareQuestMenu(me->GetGUID());

        if (!pInstance)
            return false;

        uint32 menuItem = 0;
        if (pInstance->GetData(TYPE_GORDOK_TRIBUTE) == DONE)
            menuItem = 2;

        AddGossipItemFor(player, GossipOptionNpc::None, sKromcrushGossips[menuItem].m_chItem, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
        // TODO(classic): npc_text 6913 / 6914 / 6915 / 6920 must exist in the TC world DB (VMaNGOS npc_text ids)
        SendGossipMenuFor(player, sKromcrushGossips[menuItem].m_uiMenu, me->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, uint32 /*menuId*/, uint32 gossipListId) override
    {
        if (!pInstance)
            return true;

        uint32 const action = player->PlayerTalkClass->GetGossipOptionAction(gossipListId);

        uint32 menuItem = 1;
        if (pInstance->GetData(TYPE_GORDOK_TRIBUTE) == DONE)
            menuItem = 3;

        ClearGossipMenuFor(player);

        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF:
                AddGossipItemFor(player, GossipOptionNpc::None, sKromcrushGossips[menuItem].m_chItem, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                SendGossipMenuFor(player, sKromcrushGossips[menuItem].m_uiMenu, me->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF + 1:
                CloseGossipMenuFor(player);
                if (menuItem == 3)
                    me->SetNpcFlag(UNIT_NPC_FLAG_QUESTGIVER);
                else
                    goToFengus();
                break;
            default:
                break;
        }
        return true;
    }
};

/*######
## boss_prince_tortheldrin
######*/

enum ClassicDMTortheldrin
{
    SPELL_ARCANE_BLAST     = 22920,
    SPELL_COUNTERSPELL     = 20537,
    SPELL_SUMMON           = 22995,
    SPELL_THRASH           = 8876,
    SPELL_WHIRLWIND        = 15589
};

struct classic_boss_prince_tortheldrin : public ScriptedAI
{
    classic_boss_prince_tortheldrin(Creature* creature) : ScriptedAI(creature),
        arcaneBlastTimer(0), counterspellTimer(0), summonTimer(0), whirlwindTimer(0)
    {
        m_pInstance = creature->GetInstanceScript();
    }

    InstanceScript* m_pInstance;

    uint32 arcaneBlastTimer;
    uint32 counterspellTimer;
    uint32 summonTimer;
    uint32 whirlwindTimer;

    // VMaNGOS instance sets faction 14 with TEMPFACTION_RESTORE_RESPAWN
    void JustAppeared() override
    {
        ScriptedAI::JustAppeared();
        me->RestoreFaction();
    }

    void Reset() override
    {
        arcaneBlastTimer     = urand(15000, 20000);
        counterspellTimer    = urand(10000, 20000);
        summonTimer          = urand(0, 3000);
        whirlwindTimer       = urand(14000, 22000);

        // Thrash
        if (!me->HasAura(SPELL_THRASH))
            DoCastSelf(SPELL_THRASH, true);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        //Summon
        if (summonTimer < diff)
        {
            if (DoCastVictim(SPELL_SUMMON) == SPELL_CAST_OK)
                summonTimer = urand(13000, 20000);
        }
        else
            summonTimer -= diff;

        // Whirlwind
        if (whirlwindTimer < diff)
        {
            bool meleeAttackers = false;
            for (Unit* attacker : me->getAttackers())
            {
                if (me->IsInRange(attacker, 0.0f, 7.0f, false))
                {
                    meleeAttackers = true;
                    break;
                }
            }
            if (meleeAttackers)
                if (DoCastSelf(SPELL_WHIRLWIND) == SPELL_CAST_OK)
                    whirlwindTimer = urand(10000, 20000);
        }
        else
            whirlwindTimer -= diff;

        // Arcane Blast
        if (arcaneBlastTimer < diff)
        {
            if (DoCastVictim(SPELL_ARCANE_BLAST) == SPELL_CAST_OK)
            {
                ResetThreatList();
                arcaneBlastTimer = urand(10000, 15000);
            }
        }
        else
            arcaneBlastTimer -= diff;

        // Counterspell
        if (counterspellTimer < diff)
        {
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, PowerUsersSelector(me, POWER_MANA, 0.0f, true)))
            {
                if (target->IsNonMeleeSpellCast(true))
                {
                    if (DoCast(target, SPELL_COUNTERSPELL) == SPELL_CAST_OK)
                        counterspellTimer = urand(25000, 30000);
                }
            }
        }
        else
            counterspellTimer -= diff;
    }
};

/*######
## boss_alzzin_the_wildshaper
######*/

enum ClassicDMAlzzin
{
    NPC_ALZZINS_MINION          = 11460,

    SPELL_DARK_CHANNELING       = 21157,

    // Satyr
    SPELL_ENERVATE              = 22661,
    SPELL_THORNS                = 22128,
    SPELL_WITHER                = 22662,

    // Wolf
    SPELL_DIRE_WOLF_FORM        = 22660,
    SPELL_VICIOUS_BITE          = 19319,
    SPELL_MANGLE                = 22689,

    // Tree
    SPELL_TREE_FORM             = 22688,
    SPELL_WILD_REGENERATION     = 7948,
  //SPELL_KNOCK_AWAY            = 10101,  // already defined
    SPELL_DISARM                = 22691
};

namespace
{
float const ALZZIN_COORDS[2][3] =
{
    {274.844f, -427.251f, -119.962f},
    {262.298f, -445.57f,  -119.962f}
};

float const m_fCoordMinions[15][4] =
{
    {258.87f,  -356.773f, -106.255f, 4.93928f },
    {261.65f,  -358.587f, -105.996f, 5.88176f },
    {260.443f, -357.273f, -106.288f, 3.56047f },
    {261.335f, -354.319f, -105.331f, 1.44862f },
    {263.817f, -354.068f, -105.126f, 6.02139f },
    {252.266f, -365.229f, -109.915f, 4.20624f },
    {254.409f, -365.498f, -109.99f,  1.8675f  },
    {253.869f, -362.235f, -108.675f, 0.331613f},
    {255.764f, -362.91f,  -108.83f,  5.09636f },
    {258.411f, -360.927f, -107.782f, 4.88692f },
    {250.652f, -370.499f, -112.237f, 4.20624f },
    {253.022f, -371.107f, -112.171f, 1.8675f  },
    {250.207f, -372.675f, -112.839f, 0.331613f},
    {252.79f,  -372.777f, -112.676f, 5.09636f },
    {251.389f, -374.372f, -113.371f, 4.88692f }
};

uint32 const m_uiPhaseMask[3][2] = { {1, 2}, {0, 2}, {0, 1} };

float const CLASSIC_DM_VISIBLE_RANGE = 166.0f; // VMaNGOS VISIBLE_RANGE
}

struct classic_boss_alzzin_the_wildshaper : public ScriptedAI
{
    explicit classic_boss_alzzin_the_wildshaper(Creature* creature) : ScriptedAI(creature)
    {
        pInstance = creature->GetInstanceScript();
    }

    InstanceScript* pInstance;

    bool m_bSummoned = false;
    bool m_bCastThorns = false;

    uint8 m_uiOOCPhase = 0;
    uint32 m_uiOOCTimer = 0;

    uint8 m_uiChPhase = 0;
    uint32 m_uiPhaseTimer = 0;
    uint32 m_uiEvadeTimer = 0;

    uint32 m_uiThornsTimer = 0;
    uint32 m_uiDisarmTimer = 0;
    uint32 m_uiEnervateTimer = 0;
    uint32 m_uiKnockAwayTimer = 0;
    uint32 m_uiMangleTimer = 0;
    uint32 m_uiViciousBiteTimer = 0;
    uint32 m_uiWildRegenerationTimer = 0;
    uint32 m_uiWitherTimer = 0;

    void Reset() override
    {
        m_uiOOCPhase = 0;
        m_uiOOCTimer = urand(30000, 45000);

        m_uiThornsTimer            = urand(1000, 3000);
        m_uiDisarmTimer            = urand(5000, 10000);
        m_uiEnervateTimer          = urand(5000, 10000);
        m_uiKnockAwayTimer         = urand(6000, 11000);
        m_uiMangleTimer            = urand(3000, 7000);
        m_uiViciousBiteTimer       = urand(5000, 10000);
        m_uiWildRegenerationTimer  = urand(5000, 8000);
        m_uiWitherTimer            = urand(2000, 5000);

        m_uiPhaseTimer             = urand(12000, 15000);
        m_uiChPhase = 0;
        m_uiEvadeTimer             = 3000;
        m_bSummoned                = false;

        m_bCastThorns = DoCastSelf(SPELL_THORNS) != SPELL_CAST_OK;
    }

    void SummonAdds()
    {
        for (uint8 i = 0; i < 15; ++i)
        {
            if (Creature* add = me->SummonCreature(NPC_ALZZINS_MINION,
                m_fCoordMinions[i][0],
                m_fCoordMinions[i][1],
                m_fCoordMinions[i][2],
                m_fCoordMinions[i][3], TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 20s))
            {
                add->AI()->AttackStart(me->GetVictim());
            }
        }
    }

    void ChangeForm()
    {
        uint8 newPhase = 0;
        if (roll_chance(50))
            newPhase = m_uiPhaseMask[m_uiChPhase][0];
        else
            newPhase = m_uiPhaseMask[m_uiChPhase][1];

        switch (newPhase)
        {
            case 0: // NORMAL
                me->RemoveAurasDueToSpell(SPELL_DIRE_WOLF_FORM);
                me->RemoveAurasDueToSpell(SPELL_TREE_FORM);
                break;

            case 1: // WOLF
                DoCastSelf(SPELL_DIRE_WOLF_FORM);
                me->RemoveAurasDueToSpell(SPELL_TREE_FORM);
                break;

            case 2: // TREE
                DoCastSelf(SPELL_TREE_FORM);
                me->RemoveAurasDueToSpell(SPELL_DIRE_WOLF_FORM);
                break;
        }

        m_uiChPhase = newPhase;
    }

    // VMaNGOS AuraRemoved(uint32 spellId, uint32 mode)
    void OnAuraRemoved(AuraApplication const* aurApp) override
    {
        if (aurApp->GetBase()->GetId() == SPELL_THORNS)
            m_bCastThorns = true;
    }

    void SummonedCreatureDies(Creature* summoned, Unit* /*killer*/) override
    {
        if (!m_bSummoned)
            summoned->DespawnOrUnsummon(1ms);
    }

    void MovementInform(uint32 movementType, uint32 pointId) override
    {
        if (movementType != POINT_MOTION_TYPE)
            return;

        switch (pointId)
        {
            case 0:
                me->GetMotionMaster()->MoveIdle();
                me->SetFacingTo(6.13f);
                DoCastSelf(SPELL_DARK_CHANNELING);
                m_uiOOCTimer = urand(10000, 30000);
                break;
            case 1:
                me->GetMotionMaster()->Initialize();
                m_uiOOCTimer = urand(30000, 45000);
                break;
            default:
                break;
        }
    }

    void UpdateAI(uint32 diff) override
    {
        // Thorns
        if (m_bCastThorns)
        {
            if (m_uiThornsTimer < diff)
            {
                if (!me->HasAura(SPELL_DIRE_WOLF_FORM) && !me->HasAura(SPELL_TREE_FORM))
                {
                    if (DoCastSelf(SPELL_THORNS) == SPELL_CAST_OK)
                    {
                        m_uiThornsTimer = urand(10000, 15000);
                        m_bCastThorns = false;
                    }
                }
            }
            else
                m_uiThornsTimer -= diff;
        }

        if (!UpdateVictim())
        {
            if (!m_uiOOCTimer)
                return;

            if (m_uiOOCTimer <= diff)
            {
                me->InterruptNonMeleeSpells(false);
                float const* point = ALZZIN_COORDS[m_uiOOCPhase];
                me->GetMotionMaster()->MovePoint(m_uiOOCPhase, point[0], point[1], point[2]);

                m_uiOOCPhase ^= 1;
                m_uiOOCTimer = 0;
            }
            else
                m_uiOOCTimer -= diff;

            return;
        }

        if (!m_bSummoned && me->GetHealthPct() < 45.0f)
        {
            if (pInstance && pInstance->GetData(TYPE_ALZZIN) != SPECIAL)
                pInstance->SetData(TYPE_ALZZIN, SPECIAL);

            me->CallForHelp(CLASSIC_DM_VISIBLE_RANGE);
            SummonAdds();

            m_bSummoned = true;
        }

        // Check Evade Zone
        if (m_uiEvadeTimer < diff)
        {
            if (me->GetDistance(ALZZIN_COORDS[0][0], ALZZIN_COORDS[0][1], ALZZIN_COORDS[0][2]) > 40.0f)
            {
                // Say something
                EnterEvadeMode(EvadeReason::Boundary);
                return;
            }
            m_uiEvadeTimer = 3000;
        }
        else
            m_uiEvadeTimer -= diff;

        // Phase
        if (m_uiPhaseTimer < diff)
        {
            ChangeForm();
            m_uiPhaseTimer = urand(12000, 15000);
        }
        else
            m_uiPhaseTimer -= diff;

        switch (m_uiChPhase)
        {
            case 0: // NORMAL
                // Wither
                if (m_uiWitherTimer < diff)
                {
                    if (!me->GetVictim()->HasAura(SPELL_WITHER) && DoCastVictim(SPELL_WITHER) == SPELL_CAST_OK)
                        m_uiWitherTimer = urand(8000, 10000);
                }
                else
                    m_uiWitherTimer -= diff;

                // Enervate
                if (m_uiEnervateTimer < diff)
                {
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, PowerUsersSelector(me, POWER_MANA, 0.0f, true)))
                        if (DoCast(target, SPELL_ENERVATE) == SPELL_CAST_OK)
                            m_uiEnervateTimer = urand(12000, 15000);
                }
                else
                    m_uiEnervateTimer -= diff;
                break;

            case 1: // WOLF
                // Mangle
                if (m_uiMangleTimer < diff)
                {
                    if (!me->GetVictim()->HasAura(SPELL_MANGLE) && DoCastVictim(SPELL_MANGLE) == SPELL_CAST_OK)
                        m_uiMangleTimer = urand(8000, 10000);
                }
                else
                    m_uiMangleTimer -= diff;

                // Vicious Bite
                if (m_uiViciousBiteTimer < diff)
                {
                    if (DoCastVictim(SPELL_VICIOUS_BITE) == SPELL_CAST_OK)
                        m_uiViciousBiteTimer = urand(8000, 15000);
                }
                else
                    m_uiViciousBiteTimer -= diff;
                break;

            case 2: // WOOD
                // Knock Away
                if (m_uiKnockAwayTimer < diff)
                {
                    if (DoCastVictim(SPELL_KNOCK_AWAY) == SPELL_CAST_OK)
                        m_uiKnockAwayTimer = urand(16000, 20000);
                }
                else
                    m_uiKnockAwayTimer -= diff;

                // Disarm
                if (m_uiDisarmTimer < diff)
                {
                    if (DoCastVictim(SPELL_DISARM) == SPELL_CAST_OK)
                        m_uiDisarmTimer = urand(16000, 20000);
                }
                else
                    m_uiDisarmTimer -= diff;

                // Wild Regeneration
                if (m_uiWildRegenerationTimer < diff)
                {
                    if (me->GetHealthPct() < 50.0f)
                    {
                        if (!me->HasAura(SPELL_WILD_REGENERATION) && DoCastSelf(SPELL_WILD_REGENERATION) == SPELL_CAST_OK)
                            m_uiWildRegenerationTimer = urand(10000, 15000);
                    }
                }
                else
                    m_uiWildRegenerationTimer -= diff;
                break;
        }
    }
};

/*######
## npc_alzzins_minion
######*/

struct classic_npc_alzzins_minion : public ScriptedAI
{
    explicit classic_npc_alzzins_minion(Creature* creature) : ScriptedAI(creature) { }

    void Reset() override
    {
        if (TempSummon* summon = me->ToTempSummon())
        {
            if (Unit* summoner = summon->GetSummonerUnit())
            {
                if (summoner->IsAlive())
                    me->GetMotionMaster()->MoveFollow(summoner, PET_FOLLOW_DIST, ChaseAngle(frand(0.0f, 6.2832f)));
            }
        }
    }

    void MoveInLineOfSight(Unit* who) override
    {
        if (!me->IsInCombat())
        {
            if (who->IsPlayer() && me->IsValidAttackTarget(who) && me->IsWithinDistInMap(who, 30.0f) && me->IsWithinLOSInMap(who))
                AttackStart(who);
        }
    }

    void UpdateAI(uint32 /*diff*/) override
    {
        UpdateVictim();
    }
};

/*######
## boss_ferra
######*/

enum ClassicDMFerra
{
    SPELL_CHARGE = 22911,
    SPELL_MAUL   = 17156
};

struct classic_boss_ferra : public ScriptedAI
{
    classic_boss_ferra(Creature* creature) : ScriptedAI(creature), m_uiCharge_Timer(0), m_uiMaul_Timer(0)
    {
        pInstance = creature->GetInstanceScript();
    }

    InstanceScript* pInstance;

    uint32 m_uiCharge_Timer;
    uint32 m_uiMaul_Timer;

    void Reset() override
    {
        m_uiCharge_Timer        = 0;
        m_uiMaul_Timer          = urand(5000, 10000);

        me->SetNoCallAssistance(true);
    }

    void MoveInLineOfSight(Unit* who) override
    {
        if (!me->IsInCombat())
        {
            if (who->IsPlayer() && me->IsWithinDistInMap(who, 80.0f) && me->IsWithinLOSInMap(who)
                && me->IsValidAttackTarget(who))
            {
                // don't aggro people through the floor, ever!
                if ((me->GetPositionZ() - who->GetPositionZ()) < 10.0f)
                    AttackStart(who);
            }
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        // Maul
        if (m_uiMaul_Timer < diff)
        {
            if (DoCastVictim(SPELL_MAUL) == SPELL_CAST_OK)
                m_uiMaul_Timer = urand(15000, 20000);
        }
        else
            m_uiMaul_Timer -= diff;

        // Charge
        if (m_uiCharge_Timer < diff)
        {
            if (DoCastVictim(SPELL_CHARGE) == SPELL_CAST_OK)
                m_uiCharge_Timer = urand(6000, 10000);
        }
        else
            m_uiCharge_Timer -= diff;
    }
};

/*######
## boss_magister_kalendris
######*/

enum ClassicDMKalendris
{
    SPELL_SHADOWFORM             = 22917,
    SPELL_SHADOW_WORD_PAIN       = 17146,
    SPELL_MIND_FLAY              = 22919,
    SPELL_MIND_BLAST             = 17287,
    SPELL_DOMINATE_MIND          = 7645
};

struct classic_boss_magister_kalendris : public ScriptedAI
{
    classic_boss_magister_kalendris(Creature* creature) : ScriptedAI(creature)
    {
        m_pInstance = creature->GetInstanceScript();
    }

    InstanceScript* m_pInstance;

    uint32 m_uiShadowWordPainTimer = 0;
    uint32 m_uiMindFlayTimer = 0;
    uint32 m_uiMindBlastTimer = 0;
    uint32 m_uiDominateMindTimer = 0;

    bool m_bShadowformUsed = false;
    bool m_bInMeele = true; // uninitialized in VMaNGOS

    void Reset() override
    {
        m_bShadowformUsed = false;
        m_uiShadowWordPainTimer     = urand(5000, 10000);
        m_uiMindFlayTimer           = urand(10000, 20000);
        m_uiMindBlastTimer          = 0;
        m_uiDominateMindTimer       = urand(20000, 30000);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        // Shadow Word Pain
        if (m_uiShadowWordPainTimer < diff)
        {
            if (!me->GetVictim()->HasAura(SPELL_SHADOW_WORD_PAIN) && DoCastVictim(SPELL_SHADOW_WORD_PAIN) == SPELL_CAST_OK)
                m_uiShadowWordPainTimer = urand(9000, 11000);
        }
        else
            m_uiShadowWordPainTimer -= diff;

        // MindFlay
        if (m_uiMindFlayTimer < diff)
        {
            if (DoCastVictim(SPELL_MIND_FLAY) == SPELL_CAST_OK)
                m_uiMindFlayTimer = urand(18000, 23000);
        }
        else
            m_uiMindFlayTimer -= diff;

        // Mind Blast
        if (m_uiMindBlastTimer < diff)
        {
            if (DoCastVictim(SPELL_MIND_BLAST) == SPELL_CAST_OK)
                m_uiMindBlastTimer = (m_bInMeele ? urand(7000, 10000) : urand(2000, 3000));
        }
        else
            m_uiMindBlastTimer -= diff;

        // Dominate Mind
        if (m_uiDominateMindTimer < diff)
        {
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1, 0.0f, true))
                if (DoCast(target, SPELL_DOMINATE_MIND) == SPELL_CAST_OK)
                    m_uiDominateMindTimer = urand(25000, 35000);
        }
        else
            m_uiDominateMindTimer -= diff;

        // Shadowform
        if (!m_bShadowformUsed && me->GetHealthPct() < 50.0f)
        {
            if (DoCastSelf(SPELL_SHADOWFORM) == SPELL_CAST_OK)
                m_bShadowformUsed = true;
        }

        Unit* victim = me->GetVictim();
        if (!victim)
            return;

        if (!IsCombatMovementAllowed())
        { //Melee
            if (!m_bInMeele && (me->GetDistance2d(victim) < 5.0f || me->GetDistance2d(victim) > 30.0f || !me->IsWithinLOSInMap(victim) || me->GetPowerPct(POWER_MANA) < 5.0f))
            {
                SetCombatMovement(true);
                DoStartMovement(victim);
                m_bInMeele = true;
                return;
            }
        }
        else
        { //Range
            if (m_bInMeele && me->GetDistance2d(victim) >= 5.0f && me->GetDistance2d(victim) <= 30.0f && me->IsWithinLOSInMap(victim) && me->GetPowerPct(POWER_MANA) >= 5.0f)
            {
                SetCombatMovement(false);
                m_bInMeele = false;
                DoStartNoMovement(victim);
                return;
            }
        }
    }
};

/*######
## go_warpwood_pod
######*/

struct classic_go_warpwood_pod : public GameObjectAI
{
    classic_go_warpwood_pod(GameObject* go) : GameObjectAI(go) { }

    // VMaNGOS OnUse(Unit*)
    bool OnGossipHello(Player* player) override
    {
        if (GameObjectTemplate const* info = me->GetGOInfo())
        {
            if (info->type == GAMEOBJECT_TYPE_CHEST && info->chest.linkedTrap)
            {
                if (GameObjectTemplate const* trap = sObjectMgr->GetGameObjectTemplate(info->chest.linkedTrap))
                {
                    if (trap->trap.spell)
                    {
                        player->CastSpell(player, trap->trap.spell, true);
                        me->SetLootState(GO_JUST_DEACTIVATED);
                    }
                }
            }
        }
        return true;
    }
};

void AddSC_classic_instance_dire_maul()
{
    new classic_instance_dire_maul();

    // DM West
    RegisterCreatureAI(classic_npc_reste_mana);
    RegisterCreatureAI(classic_npc_arcane_aberration);
    RegisterCreatureAI(classic_npc_residual_montruosity);
    RegisterCreatureAI(classic_boss_ferra);
    RegisterCreatureAI(classic_boss_prince_tortheldrin);
    RegisterCreatureAI(classic_boss_magister_kalendris);

    // DM North
    RegisterCreatureAI(classic_npc_gordok_brute);
    RegisterCreatureAI(classic_npc_mizzle_the_crafty);
    RegisterCreatureAI(classic_npc_knot_thimblejack);
    RegisterCreatureAI(classic_boss_guards);
    RegisterGameObjectAI(classic_go_broken_trap);
    RegisterGameObjectAI(classic_go_fixed_trap);
    RegisterCreatureAI(classic_boss_kromcrush);

    // DM East
    RegisterCreatureAI(classic_boss_alzzin_the_wildshaper);
    RegisterCreatureAI(classic_npc_alzzins_minion);
    RegisterGameObjectAI(classic_go_warpwood_pod);
}
