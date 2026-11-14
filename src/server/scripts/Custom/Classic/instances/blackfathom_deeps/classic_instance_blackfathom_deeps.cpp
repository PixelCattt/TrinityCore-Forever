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

// Classic 1.60 port of VMaNGOS src/scripts/kalimdor/ashenvale/blackfathom_deeps/instance_blackfathom_deeps.cpp
// (ScriptDev2 lineage, GPL-2)
// Ported: instance_blackfathom_deeps (map 48), go_fire_of_akumai

#include "ScriptMgr.h"
#include "Creature.h"
#include "CreatureAI.h"
#include "GameObject.h"
#include "GameObjectAI.h"
#include "InstanceScript.h"
#include "Map.h"
#include "ObjectDefines.h"
#include "Player.h"
#include "TemporarySummon.h"
#include "classic_blackfathom_deeps.h"
#include "classic_dungeon_encounter_tracker.h"
#include <array>
#include <initializer_list>
#include <list>
#include <memory>

/* Encounter 0 = Twilight Lord Kelris
   Encounter 1 = Shrine event
   Must kill twilight lord for shrine event to be possible
 */

/* This is the spawn pattern for the event mobs
*       D
*   0       3
*   1   S   4
*   2       5
*       E

* This event spawns 4 sets of mobs
* The order in whitch the fires are lit doesn't matter

* First: 3 Snapjaws: Positions 0, 1, 4, 5                   // 4 Aku'mai Snapjaw (Turtle) ID 4825
* Second: 2 Servants: Positions 1, 4                        // 2 Aku'mai Servant (water elemental) ID 4978
* Third: 4 Crabs: Positions 0, 2, 3, 4                      // 4 NPC_MURKSHALLOW_SNAPCLAW
* Fourth: 10 Murkshallows: Positions 2*0, 1, 2, 3, 4, 2*5   // 8

* On wipe the mobs don't despawn; they stay there until player returns
*/

namespace
{
struct ClassicBfdLocation
{
    float m_fX, m_fY, m_fZ, m_fO;
};

constexpr ClassicBfdLocation ClassicBfdSpawnLocations[6] = // Should be near the correct positions
{
    { -768.949f, -174.413f, -25.87f, 3.09f }, // Left side
    { -768.888f, -164.238f, -25.87f, 3.09f },
    { -768.951f, -153.911f, -25.88f, 3.09f },
    { -867.782f, -174.352f, -25.87f, 6.27f }, // Right side
    { -867.875f, -164.089f, -25.87f, 6.27f },
    { -867.859f, -153.927f, -25.88f, 6.27f }
};

struct ClassicBfdPosCount
{
    uint8 m_uiCount, m_uiSummonPosition;
};

struct ClassicBfdSummonInformation
{
    uint8 m_uiWaveIndex;
    uint32 m_uiNpcEntry;
    ClassicBfdPosCount m_aCountAndPos[3];
};

constexpr ClassicBfdSummonInformation ClassicBfdWaveSummonInformation[] =
{
    { 0, CBFD_NPC_AKUMAI_SNAPJAW,        { { 1, 0 }, { 1, 1 }, { 1, 5 } } },
    { 0, CBFD_NPC_AKUMAI_SNAPJAW,        { { 1, 4 }, { 0, 0 }, { 0, 0 } } },
    { 1, CBFD_NPC_AKUMAI_SERVANT,        { { 1, 1 }, { 1, 4 }, { 0, 0 } } },
    { 2, CBFD_NPC_MURKSHALLOW_SNAPCLAW,  { { 1, 0 }, { 1, 2 }, { 0, 0 } } },
    { 2, CBFD_NPC_MURKSHALLOW_SNAPCLAW,  { { 1, 3 }, { 1, 4 }, { 0, 0 } } },
    { 3, CBFD_NPC_MURKSHALLOW_SOFTSHELL, { { 2, 0 }, { 1, 1 }, { 1, 2 } } },
    { 3, CBFD_NPC_MURKSHALLOW_SOFTSHELL, { { 1, 3 }, { 1, 4 }, { 2, 5 } } }
};

// Twilight Lord Kelris spawn point (VMaNGOS creature guid 27424), used as home position of the wave mobs
// when Kelris' corpse is no longer in the map (TC removes decayed corpses, VMaNGOS kept them).
Position const ClassicBfdKelrisSpawnPos = { -818.832f, -155.576f, -25.7923f, 4.74729f };

constexpr uint32 CBFD_SPELL_SUMMONED_DEMON_VISUAL = 7741;

constexpr std::array<char const*, CBFD_MAX_ENCOUNTER> ClassicBfdEncounterNames =
{
    "Kelris", "Shrine", "Aquanis"
};
}

namespace
{
// Classic 1.60: TC boss states for the DungeonEncounter.db2 encounters of Blackfathom Deeps (map 48), driven by
// ClassicDungeonEncounterTracker (boss kill credit, encounter start / end, instance lock)
// first id: difficulty 1 (Normal, what the server runs), second id: difficulty 201
// the difficulty 198 set (Baron Aquanis etc.) is left out
enum ClassicBlackfathomDeepsEncounterBosses : uint32
{
    CBFD_ENC_GHAMOORA = 0,
    CBFD_ENC_SAREVESS = 1,
    CBFD_ENC_GELIHAST = 2,
    CBFD_ENC_LORGUS_JETT = 3,
    CBFD_ENC_SERRAKIS = 4,
    CBFD_ENC_KELRIS = 5,
    CBFD_ENC_AKUMAI = 6,
    CBFD_ENC_MAX
};

constexpr ClassicDungeonBossEntry ClassicBlackfathomDeepsEncounterBossEntries[] =
{
    { CBFD_ENC_GHAMOORA, 4887 }, // Ghamoo-ra
    { CBFD_ENC_SAREVESS, 4831 }, // Lady Sarevess
    { CBFD_ENC_GELIHAST, 6243 }, // Gelihast
    { CBFD_ENC_LORGUS_JETT, 12902 }, // Lorgus Jett
    { CBFD_ENC_SERRAKIS, 4830 }, // Old Serra'kis
    { CBFD_ENC_KELRIS, 4832 }, // Twilight Lord Kelris
    { CBFD_ENC_AKUMAI, 4829 } // Aku'mai
};
}

class classic_instance_blackfathom_deeps : public InstanceMapScript
{
public:
    classic_instance_blackfathom_deeps() : InstanceMapScript(ClassicBlackfathomDeepsScriptName, 48) { }

    struct classic_instance_blackfathom_deeps_InstanceScript : public InstanceScript
    {
        classic_instance_blackfathom_deeps_InstanceScript(InstanceMap* map) : InstanceScript(map)
        {
            SetHeaders("CBFD");
            SetBossNumber(CBFD_ENC_MAX);
            static constexpr DungeonEncounterData encounters[] =
            {
                { CBFD_ENC_GHAMOORA, {{ 2916, 2761 }} },
                { CBFD_ENC_SAREVESS, {{ 2915, 2762 }} },
                { CBFD_ENC_GELIHAST, {{ 2914, 2763 }} },
                { CBFD_ENC_LORGUS_JETT, {{ 2913, 2764 }} },
                { CBFD_ENC_SERRAKIS, {{ 2912, 2765 }} },
                { CBFD_ENC_KELRIS, {{ 2911, 2766 }} },
                { CBFD_ENC_AKUMAI, {{ 2910, 2767 }} }
            };
            LoadDungeonEncounterData(encounters);

            // VMaNGOS m_auiEncounter[] + Save()/Load() string -> TC persistent instance values
            for (uint32 i = 0; i < CBFD_MAX_ENCOUNTER; ++i)
                m_auiEncounter[i] = std::make_unique<PersistentInstanceScriptValue<uint32>>(*this, ClassicBfdEncounterNames[i], uint32(NOT_STARTED));

            m_uiShrinesLit = 0;
            m_uiCheckEventEnd = 1000;
            for (uint32& i : m_uiSpawnMobsTimer)
                i = 0;
        }

        ClassicDungeonEncounterTracker _encounterTracker{ *this, ClassicBlackfathomDeepsEncounterBossEntries };

        void OnCreatureRemove(Creature* creature) override
        {
            InstanceScript::OnCreatureRemove(creature);
            _encounterTracker.OnCreatureRemove(creature);
        }

        ObjectGuid m_uiTwilightLordKelrisGUID;
        ObjectGuid m_uiShrine1GUID;
        ObjectGuid m_uiShrine2GUID;
        ObjectGuid m_uiShrine3GUID;
        ObjectGuid m_uiShrine4GUID;
        ObjectGuid m_uiShrineOfGelihastGUID;
        ObjectGuid m_uiAltarOfTheDeepsGUID;
        ObjectGuid m_uiMainDoorGUID;
        uint8  m_uiShrinesLit;
        uint32 m_uiSpawnMobsTimer[4];
        std::list<ObjectGuid> m_lWaveMobsGUIDList;
        uint32 m_uiCheckEventEnd;

        std::array<std::unique_ptr<PersistentInstanceScriptValue<uint32>>, CBFD_MAX_ENCOUNTER> m_auiEncounter;

        uint32 Enc(uint32 index) const { return *m_auiEncounter[index]; }
        void SetEnc(uint32 index, uint32 value) { *m_auiEncounter[index] = value; }

        // VMaNGOS Load(): encounters saved as IN_PROGRESS are reset
        void AfterDataLoad() override
        {
            for (auto& value : m_auiEncounter)
                if (uint32(*value) == IN_PROGRESS)
                    value->LoadValue(uint32(NOT_STARTED));
        }

        void OnCreatureCreate(Creature* creature) override
        {
            InstanceScript::OnCreatureCreate(creature);
            _encounterTracker.OnCreatureCreate(creature);

            if (creature->GetEntry() == CBFD_NPC_TWILIGHT_LORD_KELRIS)
                m_uiTwilightLordKelrisGUID = creature->GetGUID();
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            InstanceScript::OnGameObjectCreate(go);

            switch (go->GetEntry())
            {
                case CBFD_GO_SHRINE_1:
                    m_uiShrine1GUID = go->GetGUID();
                    break;
                case CBFD_GO_SHRINE_2:
                    m_uiShrine2GUID = go->GetGUID();
                    break;
                case CBFD_GO_SHRINE_3:
                    m_uiShrine3GUID = go->GetGUID();
                    break;
                case CBFD_GO_SHRINE_4:
                    m_uiShrine4GUID = go->GetGUID();
                    break;
                case CBFD_GO_SHRINE_OF_GELIHAST:
                    m_uiShrineOfGelihastGUID = go->GetGUID();
                    break;
                case CBFD_GO_ALTAR_OF_THE_DEEPS:
                    m_uiAltarOfTheDeepsGUID = go->GetGUID();
                    break;
                case CBFD_GO_PORTAL_DOOR:
                    m_uiMainDoorGUID = go->GetGUID();
                    if (Enc(CBFD_ENCOUNTER_SHRINE) == DONE && Enc(CBFD_ENCOUNTER_KELRIS) == DONE)
                        go->SetGoState(GO_STATE_ACTIVE);
                    break;
                default:
                    break;
            }
        }

        void SetData(uint32 type, uint32 data) override
        {
            switch (type)
            {
                case CBFD_TYPE_KELRIS:
                    if (data == DONE && Enc(CBFD_ENCOUNTER_SHRINE) == DONE)
                        DoUseDoorOrButton(m_uiMainDoorGUID);

                    SetEnc(CBFD_ENCOUNTER_KELRIS, data);
                    break;
                case CBFD_TYPE_SHRINE:
                    if (data == IN_PROGRESS)
                    {
                        // VMaNGOS: ASSERT(m_uiShrinesLit < 4)
                        if (m_uiShrinesLit < 4)
                        {
                            m_uiSpawnMobsTimer[m_uiShrinesLit] = 3000;
                            m_uiCheckEventEnd = 5000;
                            ++m_uiShrinesLit;
                        }
                    }
                    else if (data == DONE && Enc(CBFD_ENCOUNTER_KELRIS) == DONE)
                        DoUseDoorOrButton(m_uiMainDoorGUID);

                    SetEnc(CBFD_ENCOUNTER_SHRINE, data);
                    break;
                case CBFD_TYPE_AQUANIS:
                    SetEnc(CBFD_ENCOUNTER_AQUANIS, data);
                    break;
                default:
                    break;
            }
            // VMaNGOS saved on DONE; persistent values are saved by TC whenever they change
        }

        uint32 GetData(uint32 type) const override
        {
            switch (type)
            {
                case CBFD_TYPE_KELRIS:
                    return Enc(CBFD_ENCOUNTER_KELRIS);
                case CBFD_TYPE_SHRINE:
                    return Enc(CBFD_ENCOUNTER_SHRINE);
                case CBFD_TYPE_AQUANIS:
                    return Enc(CBFD_ENCOUNTER_AQUANIS);
                default:
                    break;
            }

            return 0;
        }

        // VMaNGOS GetData64
        ObjectGuid GetGuidData(uint32 type) const override
        {
            switch (type)
            {
                case CBFD_DATA_TWILIGHT_LORD_KELRIS:
                    return m_uiTwilightLordKelrisGUID;
                case CBFD_DATA_SHRINE1:
                    return m_uiShrine1GUID;
                case CBFD_DATA_SHRINE2:
                    return m_uiShrine2GUID;
                case CBFD_DATA_SHRINE3:
                    return m_uiShrine3GUID;
                case CBFD_DATA_SHRINE4:
                    return m_uiShrine4GUID;
                case CBFD_DATA_SHRINE_OF_GELIHAST:
                    return m_uiShrineOfGelihastGUID;
                case CBFD_DATA_MAINDOOR:
                    return m_uiMainDoorGUID;
                default:
                    break;
            }

            return ObjectGuid::Empty;
        }

        // VMaNGOS OnCreatureDeath
        void OnUnitDeath(Unit* unit) override
        {
            _encounterTracker.OnUnitDeath(unit);

            if (unit->GetTypeId() == TYPEID_UNIT && unit->GetEntry() == CBFD_NPC_BARON_AQUANIS)
                SetData(CBFD_TYPE_AQUANIS, DONE);
        }

        void DoSpawnMobs(uint8 waveIndex)
        {
            // VMaNGOS summons from (dead) Kelris and uses his respawn coords as home position
            WorldObject* summoner = nullptr;
            Position home = ClassicBfdKelrisSpawnPos;
            if (Creature* kelris = instance->GetCreature(m_uiTwilightLordKelrisGUID))
            {
                summoner = kelris;
                home = kelris->GetRespawnPosition();
            }
            else
            {
                // TODO(classic): Kelris' corpse already decayed (TC removes it from the map); summon from a shrine instead
                for (ObjectGuid const& guid : { m_uiShrine1GUID, m_uiShrine2GUID, m_uiShrine3GUID, m_uiShrine4GUID })
                {
                    if (GameObject* shrine = instance->GetGameObject(guid))
                    {
                        summoner = shrine;
                        break;
                    }
                }
            }

            if (!summoner)
                return;

            for (ClassicBfdSummonInformation const& info : ClassicBfdWaveSummonInformation)
            {
                if (info.m_uiWaveIndex != waveIndex)
                    continue;

                // Summon mobs at positions
                for (uint8 j = 0; j < 3; ++j)
                {
                    for (uint8 k = 0; k < info.m_aCountAndPos[j].m_uiCount; ++k)
                    {
                        uint8 pos = info.m_aCountAndPos[j].m_uiSummonPosition;
                        float posX = ClassicBfdSpawnLocations[pos].m_fX;
                        float posY = ClassicBfdSpawnLocations[pos].m_fY;
                        float posZ = ClassicBfdSpawnLocations[pos].m_fZ;
                        float posO = ClassicBfdSpawnLocations[pos].m_fO;

                        // Adapt posY slightly in case of higher summon-counts
                        if (info.m_aCountAndPos[j].m_uiCount > 1)
                            posY = posY - INTERACTION_DISTANCE / 2 + k * INTERACTION_DISTANCE / info.m_aCountAndPos[j].m_uiCount;

                        if (TempSummon* summoned = summoner->SummonCreature(info.m_uiNpcEntry, posX, posY, posZ, posO, TEMPSUMMON_DEAD_DESPAWN))
                        {
                            summoned->SetWalk(true);
                            summoned->CastSpell(summoned, CBFD_SPELL_SUMMONED_DEMON_VISUAL, true);  // Summoned Demon (Visual)
                            summoned->SetHomePosition(home.GetPositionX(), home.GetPositionY(), home.GetPositionZ(), 0.0f);
                            if (summoned->IsAIEnabled())
                                CreatureAI::DoZoneInCombat(summoned);
                            m_lWaveMobsGUIDList.push_back(summoned->GetGUID());
                        }
                    }
                }
            }
        }

        // Check if all the summoned event mobs are dead
        bool IsWaveEventFinished()
        {
            // If not all fires are lighted return
            if (m_uiShrinesLit < 4)
                return false;

            // Update checks completion before dispatching the queued waves. A long tick
            // must not complete the event while those waves still have to spawn.
            for (uint32 timer : m_uiSpawnMobsTimer)
                if (timer)
                    return false;

            // Check if all mobs are dead
            for (ObjectGuid const& guid : m_lWaveMobsGUIDList)
            {
                if (Creature* waveMob = instance->GetCreature(guid))
                    if (waveMob->IsAlive())
                        return false;
            }
            return true;
        }

        void Update(uint32 diff) override
        {
            _encounterTracker.Update(diff);

            // Only use this function if shrine event is in progress
            if (Enc(CBFD_ENCOUNTER_SHRINE) != IN_PROGRESS)
                return;

            if (m_uiCheckEventEnd <= diff)
            {
                if (IsWaveEventFinished())
                    SetData(CBFD_TYPE_SHRINE, DONE);
                else
                    m_uiCheckEventEnd = 1000;
            }
            else
                m_uiCheckEventEnd -= diff;

            for (uint8 i = 0; i < 4; ++i)
            {
                if (m_uiSpawnMobsTimer[i])
                {
                    if (m_uiSpawnMobsTimer[i] <= diff)
                    {
                        DoSpawnMobs(i);
                        m_uiSpawnMobsTimer[i] = 0;
                    }
                    else
                        m_uiSpawnMobsTimer[i] -= diff;
                }
            }
        }
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new classic_instance_blackfathom_deeps_InstanceScript(map);
    }
};

/*######
## go_fire_of_akumai
######*/

struct classic_go_fire_of_akumai : public GameObjectAI
{
    classic_go_fire_of_akumai(GameObject* go) : GameObjectAI(go) { }

    // VMaNGOS GameObjectAI::OnUse
    bool OnGossipHello(Player* /*player*/) override
    {
        InstanceScript* instance = me->GetInstanceScript();
        if (!instance)
            return false;

        if (instance->GetData(CBFD_TYPE_KELRIS) != DONE)
            return false;

        me->SetGoState(GO_STATE_ACTIVE);
        me->SetFlag(GO_FLAG_NOT_SELECTABLE);    // VMaNGOS GO_FLAG_NO_INTERACT (0x10)
        instance->SetData(CBFD_TYPE_SHRINE, IN_PROGRESS);

        return true;
    }
};

void AddSC_classic_instance_blackfathom_deeps()
{
    new classic_instance_blackfathom_deeps();
    RegisterGameObjectAI(classic_go_fire_of_akumai);
}
