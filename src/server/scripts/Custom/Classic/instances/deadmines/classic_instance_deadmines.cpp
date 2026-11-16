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

// Classic 1.60 port of VMaNGOS src/scripts/eastern_kingdoms/westfall/deadmines/instance_deadmines.cpp (ScriptDev2 lineage, GPL-2)
// Ported: instance_deadmines (map 36), at_dmf_chest_dm

#include "ScriptMgr.h"
#include "Creature.h"
#include "GameObject.h"
#include "InstanceScript.h"
#include "Log.h"
#include "Map.h"
#include "MotionMaster.h"
#include "Player.h"
#include "QuestDef.h"
#include "classic_deadmines.h"
#include "classic_dungeon_encounter_tracker.h"
#include "classic_script_text.h"
#include <list>

namespace
{
constexpr uint32 CDM_FACTION_FRIENDLY  = 35;
constexpr uint32 CDM_FACTION_MONSTER   = 17;

constexpr uint32 CDM_RESPAWN_RHAHK_PATROL   = 43199;
constexpr uint32 CDM_RESPAWN_GILNID_PATROL  = 43201;
constexpr uint32 CDM_RESPAWN_PIRATE_ALARM   = 43202;

// hide a gameobject from players (VMaNGOS GameObject::SetVisible)
void ClassicDeadminesSetGoVisible(GameObject* go, bool visible, bool update)
{
    go->m_serverSideVisibility.SetValue(SERVERSIDE_VISIBILITY_GM, visible ? SEC_PLAYER : SEC_GAMEMASTER);
    if (update)
        go->UpdateObjectVisibility();
}
}

namespace
{
// Classic 1.60: TC boss states for the DungeonEncounter.db2 encounters of The Deadmines (map 36), driven by
// ClassicDungeonEncounterTracker (boss kill credit, encounter start / end, instance lock)
// 3676 Miner Johnson is a Forever-only encounter and is left out
enum ClassicDeadminesEncounterBosses : uint32
{
    CDM_ENC_RHAHKZOR = 0,
    CDM_ENC_SNEED = 1,
    CDM_ENC_GILNID = 2,
    CDM_ENC_GREENSKIN = 3,
    CDM_ENC_SMITE = 4,
    CDM_ENC_COOKIE = 5,
    CDM_ENC_VANCLEEF = 6,
    CDM_ENC_MAX
};

constexpr ClassicDungeonBossEntry ClassicDeadminesEncounterBossEntries[] =
{
    { CDM_ENC_RHAHKZOR, 644 }, // Rhahk'Zor
    { CDM_ENC_SNEED, 642, CLASSIC_DUNGEON_BOSS_ENGAGE_ONLY }, // Sneed's Shredder
    { CDM_ENC_SNEED, 643 }, // Sneed
    { CDM_ENC_GILNID, 1763 }, // Gilnid
    { CDM_ENC_GREENSKIN, 647 }, // Captain Greenskin
    { CDM_ENC_SMITE, 646 }, // Mr. Smite
    { CDM_ENC_COOKIE, 645 }, // Cookie
    { CDM_ENC_VANCLEEF, 639 } // Edwin VanCleef
};
}

class classic_instance_deadmines : public InstanceMapScript
{
public:
    classic_instance_deadmines() : InstanceMapScript(ClassicDeadminesScriptName, 36) { }

    struct classic_instance_deadmines_InstanceScript : public InstanceScript
    {
        classic_instance_deadmines_InstanceScript(InstanceMap* map) : InstanceScript(map)
        {
            SetHeaders("CDM");
            SetBossNumber(CDM_ENC_MAX);
            static constexpr DungeonEncounterData encounters[] =
            {
                { CDM_ENC_RHAHKZOR, {{ 2741 }} },
                { CDM_ENC_SNEED, {{ 2742 }} },
                { CDM_ENC_GILNID, {{ 2743 }} },
                { CDM_ENC_GREENSKIN, {{ 2744 }} },
                { CDM_ENC_SMITE, {{ 2745 }} },
                { CDM_ENC_COOKIE, {{ 2746 }} },
                { CDM_ENC_VANCLEEF, {{ 2747 }} }
            };
            LoadDungeonEncounterData(encounters);

            m_auiEncounter[0] = 0;
            m_uiSpawnPatrolOnRhahkDeath = 30000;
            m_isRhahkDead = false;
            m_isGunPowderEventDone = 0;
            m_isGilnidDead = false;
            m_uiSpawnPatrolOnGilnidDeath = 30000;
            m_uiIronDoorTimer = 0;
            m_uiIronDoorStep = 0;
        }

        ClassicDungeonEncounterTracker _encounterTracker{ *this, ClassicDeadminesEncounterBossEntries };

        void OnCreatureRemove(Creature* creature) override
        {
            InstanceScript::OnCreatureRemove(creature);
            _encounterTracker.OnCreatureRemove(creature);
        }

        uint32 m_auiEncounter[CDM_MAX_ENCOUNTER];

        ObjectGuid m_uiIronCladGUID;
        ObjectGuid m_uiCannonGUID;
        ObjectGuid m_uiSmiteGUID;
        ObjectGuid m_uiRhahkGUID;
        ObjectGuid m_uiGilnidGUID;

        ObjectGuid m_uiDoor1GUID;
        ObjectGuid m_uiDoor2GUID;
        ObjectGuid m_uiDoor3GUID;

        uint32 m_uiSpawnPatrolOnRhahkDeath;
        bool   m_isRhahkDead;
        uint32 m_isGunPowderEventDone;
        bool   m_isGilnidDead;
        uint32 m_uiSpawnPatrolOnGilnidDeath;

        uint32 m_uiIronDoorTimer;
        uint32 m_uiIronDoorStep;

        void OnCreatureCreate(Creature* creature) override
        {
            InstanceScript::OnCreatureCreate(creature);
            _encounterTracker.OnCreatureCreate(creature);

            if (creature->GetEntry() == CDM_NPC_RHAHKZOR)
                m_uiRhahkGUID = creature->GetGUID();

            if (creature->GetEntry() == CDM_NPC_GILDNID)
                m_uiGilnidGUID = creature->GetGUID();

            if (creature->GetEntry() == CDM_NPC_MR_SMITE)
                m_uiSmiteGUID = creature->GetGUID();

            /** Initialize Rhahz Patrol */
            if (creature->GetRespawnDelay() == CDM_RESPAWN_RHAHK_PATROL)
            {
                creature->SetVisible(false);
                creature->SetFaction(CDM_FACTION_FRIENDLY);
            }

            /** Initialize Gilnid Patrol */
            if (creature->GetRespawnDelay() == CDM_RESPAWN_GILNID_PATROL)
            {
                creature->SetVisible(false);
                creature->SetFaction(CDM_FACTION_FRIENDLY);
            }
        }

        // VMaNGOS OnCreatureDeath
        void OnUnitDeath(Unit* unit) override
        {
            _encounterTracker.OnUnitDeath(unit);

            Creature* who = unit->ToCreature();
            if (!who)
                return;

            switch (who->GetEntry())
            {
                case CDM_NPC_RHAHKZOR:
                    if (GameObject* go = instance->GetGameObject(m_uiDoor1GUID))
                        if (go->GetGoState() != GO_STATE_ACTIVE)
                            DoUseDoorOrButton(m_uiDoor1GUID);

                    m_isRhahkDead = true;
                    m_uiSpawnPatrolOnRhahkDeath = 60000;
                    break;
                case CDM_NPC_SNEED:
                    if (GameObject* go = instance->GetGameObject(m_uiDoor2GUID))
                        if (go->GetGoState() != GO_STATE_ACTIVE)
                            DoUseDoorOrButton(m_uiDoor2GUID);
                    break;
                case CDM_NPC_GILDNID:
                    if (GameObject* go = instance->GetGameObject(m_uiDoor3GUID))
                        if (go->GetGoState() != GO_STATE_ACTIVE)
                            DoUseDoorOrButton(m_uiDoor3GUID);

                    m_isGilnidDead = true;
                    m_uiSpawnPatrolOnGilnidDeath = 30000;
                    break;
                default:
                    break;
            }
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            InstanceScript::OnGameObjectCreate(go);

            if (go->GetEntry() == CDM_GO_IRON_CLAD)
                m_uiIronCladGUID = go->GetGUID();

            if (go->GetEntry() == CDM_GO_DEFIAS_CANNON)
                m_uiCannonGUID = go->GetGUID();

            if (go->GetEntry() == CDM_GO_DOOR1)
                m_uiDoor1GUID = go->GetGUID();
            if (go->GetEntry() == CDM_GO_DOOR2 && go->GetPositionX() > -291.0f && go->GetPositionX() < -290.0f)
                m_uiDoor2GUID = go->GetGUID();
            if (go->GetEntry() == CDM_GO_DOOR3 && go->GetPositionX() > -169.0f && go->GetPositionX() < -168.0f)
                m_uiDoor3GUID = go->GetGUID();

            if (go->GetEntry() == CDM_GO_DMF_CHEST)
                ClassicDeadminesSetGoVisible(go, false, false);
        }

        void SetData(uint32 type, uint32 data) override
        {
            if (type == CDM_TYPE_DEFIAS_ENDDOOR)
            {
                if (data == IN_PROGRESS)
                {
                    if (GameObject* go = instance->GetGameObject(m_uiIronCladGUID))
                    {
                        // no breaking the door if it's open
                        if (!(go->GetGoState() == GO_STATE_ACTIVE))
                            go->UseDoorOrButton(0, true);
                        m_uiIronDoorTimer = 3000;
                    }
                }
                m_auiEncounter[0] = data;
            }
            else if (type == CDM_GUN_POWDER_EVENT)
                m_isGunPowderEventDone = data;
        }

        uint32 GetData(uint32 type) const override
        {
            if (type == CDM_TYPE_DEFIAS_ENDDOOR)
                return m_auiEncounter[0];
            else if (type == CDM_GUN_POWDER_EVENT)
                return m_isGunPowderEventDone;
            return 0;
        }

        // VMaNGOS GetData64
        ObjectGuid GetGuidData(uint32 type) const override
        {
            if (type == CDM_DATA_DEFIAS_DOOR)
                return m_uiIronCladGUID;

            return ObjectGuid::Empty;
        }

        void ShowPatrol(Creature* source, uint32 entry, uint32 respawnDelay)
        {
            std::list<Creature*> escortList;
            source->GetCreatureListWithEntryInGrid(escortList, entry, 400.0f);
            for (Creature* creature : escortList)
            {
                if (creature->GetRespawnDelay() == respawnDelay)
                {
                    creature->SetVisible(true);
                    creature->SetFaction(CDM_FACTION_MONSTER);
                }
            }
        }

        void Update(uint32 diff) override
        {
            _encounterTracker.Update(diff);

            if (m_isRhahkDead && m_uiSpawnPatrolOnRhahkDeath)
            {
                if (m_uiSpawnPatrolOnRhahkDeath <= diff)
                {
                    if (Creature* rhahk = instance->GetCreature(m_uiRhahkGUID))
                    {
                        ShowPatrol(rhahk, 634, CDM_RESPAWN_RHAHK_PATROL);
                        ShowPatrol(rhahk, 1729, CDM_RESPAWN_RHAHK_PATROL);
                        m_uiSpawnPatrolOnRhahkDeath = 0;
                    }
                    // TODO(classic): TC removes a dead creature from the map once its corpse decays (VMaNGOS keeps it);
                    // if Rhahk'Zor's corpse is gone the patrol is never shown (same retry-forever logic as VMaNGOS).
                }
                else
                    m_uiSpawnPatrolOnRhahkDeath -= diff;
            }

            if (m_isGilnidDead && m_uiSpawnPatrolOnGilnidDeath)
            {
                if (m_uiSpawnPatrolOnGilnidDeath <= diff)
                {
                    if (Creature* gilnid = instance->GetCreature(m_uiGilnidGUID))
                    {
                        ShowPatrol(gilnid, 4417, CDM_RESPAWN_GILNID_PATROL);
                        ShowPatrol(gilnid, 4418, CDM_RESPAWN_GILNID_PATROL);
                        m_uiSpawnPatrolOnGilnidDeath = 0;
                    }
                }
                else
                    m_uiSpawnPatrolOnGilnidDeath -= diff;
            }

            if (m_uiIronDoorTimer)
            {
                if (m_uiIronDoorTimer <= diff)
                {
                    if (Creature* mrSmite = instance->GetCreature(m_uiSmiteGUID))
                    {
                        switch (m_uiIronDoorStep)
                        {
                            case 0:
                            {
                                ClassicScriptText(CDM_INST_SAY_ALARM1, mrSmite);
                                std::list<Creature*> escortList;
                                mrSmite->GetCreatureListWithEntryInGrid(escortList, CDM_NPC_PIRATE, 400.0f);
                                for (Creature* pirate : escortList)
                                    if (pirate->GetRespawnDelay() == CDM_RESPAWN_PIRATE_ALARM)
                                        pirate->GetMotionMaster()->MovePoint(0, -99.6611f, -671.071655f, 7.42241f, true, {}, {}, MovementWalkRunSpeedSelectionMode::ForceRun);
                                ++m_uiIronDoorStep;
                                m_uiIronDoorTimer = 15000;
                                break;
                            }
                            case 1:
                                ClassicScriptText(CDM_INST_SAY_ALARM2, mrSmite);
                                m_uiIronDoorStep = 0;
                                m_uiIronDoorTimer = 0;
                                TC_LOG_DEBUG("scripts", "Instance Deadmines: Iron door event reached end.");
                                break;
                            default:
                                break;
                        }
                    }
                    else
                        m_uiIronDoorTimer = 0;
                }
                else
                    m_uiIronDoorTimer -= diff;
            }
        }
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new classic_instance_deadmines_InstanceScript(map);
    }
};

class classic_at_dmf_chest_dm : public AreaTriggerScript
{
public:
    classic_at_dmf_chest_dm() : AreaTriggerScript("classic_at_dmf_chest_dm") { }

    bool OnTrigger(Player* player, AreaTriggerEntry const* /*trigger*/) override
    {
        // Darkmoon chest visible only for players on the quest
        if (player->GetQuestStatus(CDM_QUEST_FORTUNE_AWAITS) == QUEST_STATUS_COMPLETE)
        {
            if (GameObject* go = player->FindNearestGameObject(CDM_GO_DMF_CHEST, 100.0f))
                ClassicDeadminesSetGoVisible(go, true, true);
        }

        return false;
    }
};

void AddSC_classic_instance_deadmines()
{
    new classic_instance_deadmines();
    new classic_at_dmf_chest_dm();
}
