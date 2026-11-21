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

// Classic 1.60 port of VMaNGOS src/scripts/kalimdor/the_barrens/razorfen_kraul/instance_razorfen_kraul.cpp (ScriptDev2 lineage, GPL-2)

#include "ScriptMgr.h"
#include "Creature.h"
#include "GameObject.h"
#include "InstanceScript.h"
#include "Map.h"
#include "MotionMaster.h"
#include "classic_dungeon_encounter_tracker.h"
#include "classic_razorfen_kraul.h"

namespace
{
// Classic 1.60: TC boss states for the DungeonEncounter.db2 encounters of Razorfen Kraul (map 47), driven by
// ClassicDungeonEncounterTracker (boss kill credit, encounter start / end, instance lock)
enum ClassicRazorfenKraulEncounterBosses : uint32
{
    CLASSIC_RFK_ENC_ROOGUG = 0,
    CLASSIC_RFK_ENC_AGGEM = 1,
    CLASSIC_RFK_ENC_JARGBA = 2,
    CLASSIC_RFK_ENC_RAMTUSK = 3,
    CLASSIC_RFK_ENC_AGATHELOS = 4,
    CLASSIC_RFK_ENC_CHARLGA = 5,
    CLASSIC_RFK_ENC_MAX
};

constexpr ClassicDungeonBossEntry ClassicRazorfenKraulEncounterBossEntries[] =
{
    { CLASSIC_RFK_ENC_ROOGUG, 6168 }, // Roogug
    { CLASSIC_RFK_ENC_AGGEM, 4424 }, // Aggem Thorncurse
    { CLASSIC_RFK_ENC_JARGBA, 4428 }, // Death Speaker Jargba
    { CLASSIC_RFK_ENC_RAMTUSK, 4420 }, // Overlord Ramtusk
    { CLASSIC_RFK_ENC_AGATHELOS, 4422 }, // Agathelos the Raging
    { CLASSIC_RFK_ENC_CHARLGA, 4421 } // Charlga Razorflank
};
}

class classic_instance_razorfen_kraul : public InstanceMapScript
{
public:
    classic_instance_razorfen_kraul() : InstanceMapScript(ClassicRFKScriptName, CLASSIC_RFK_MAP_ID) { }

    struct classic_instance_razorfen_kraul_InstanceScript : public InstanceScript
    {
        classic_instance_razorfen_kraul_InstanceScript(InstanceMap* map) : InstanceScript(map),
            _wardKeepersRemaining(0), _savedAgathelos(*this, "Agathelos", NOT_STARTED)
        {
            SetHeaders(ClassicRFKDataHeader);
            SetBossNumber(CLASSIC_RFK_ENC_MAX);
            static constexpr DungeonEncounterData encounters[] =
            {
                { CLASSIC_RFK_ENC_ROOGUG, {{ 2773 }} },
                { CLASSIC_RFK_ENC_AGGEM, {{ 2774 }} },
                { CLASSIC_RFK_ENC_JARGBA, {{ 2775 }} },
                { CLASSIC_RFK_ENC_RAMTUSK, {{ 2776 }} },
                { CLASSIC_RFK_ENC_AGATHELOS, {{ 2777 }} },
                { CLASSIC_RFK_ENC_CHARLGA, {{ 2778 }} }
            };
            LoadDungeonEncounterData(encounters);
            for (uint32& encounter : _encounter)
                encounter = NOT_STARTED;
        }

        ClassicDungeonEncounterTracker _encounterTracker{ *this, ClassicRazorfenKraulEncounterBossEntries };

        void OnCreatureRemove(Creature* creature) override
        {
            InstanceScript::OnCreatureRemove(creature);
            _encounterTracker.OnCreatureRemove(creature);
        }

        void OnUnitDeath(Unit* unit) override
        {
            _encounterTracker.OnUnitDeath(unit);
        }

        void Update(uint32 diff) override
        {
            _encounterTracker.Update(diff);
        }

        // VMaNGOS Load(): saved states, IN_PROGRESS -> NOT_STARTED
        void AfterDataLoad() override
        {
            _encounter[0] = _savedAgathelos;
            for (uint32& encounter : _encounter)
                if (encounter == IN_PROGRESS)
                    encounter = NOT_STARTED;
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            InstanceScript::OnGameObjectCreate(go);

            switch (go->GetEntry())
            {
                case GO_AGATHELOS_WARD:
                    _agathelosWardGUID = go->GetGUID();
                    if (_encounter[0] == DONE)
                        go->SetGoState(GO_STATE_ACTIVE);
                    break;
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
                case NPC_WARD_KEEPER:
                    ++_wardKeepersRemaining;
                    break;
                case NPC_AGATHELOS:
                    _agathelosGUID = creature->GetGUID();
                    break;
                default:
                    break;
            }
        }

        // TYPE_AGATHELOS is set (data DONE) by the Ward Keepers on death (VMaNGOS EventAI 462501, smart_scripts 4625 id 0)
        void SetData(uint32 type, uint32 data) override
        {
            switch (type)
            {
                case TYPE_AGATHELOS:
                    if (_wardKeepersRemaining)
                        --_wardKeepersRemaining;
                    if (!_wardKeepersRemaining)
                    {
                        _encounter[0] = data;
                        DoUseDoorOrButton(_agathelosWardGUID);
                        if (Creature* agathelos = instance->GetCreature(_agathelosGUID))
                        {
                            agathelos->SetWalk(false);
                            // VMaNGOS MoveWaypoint(): Agathelos' spawn has no creature_movement path of its own, so he runs
                            // his entry path (creature_movement_template, waypoint_path 810044220). The TC waypoint movement
                            // takes the creature's path id, which only a creature_addon would set, so set it here.
                            agathelos->LoadPath(PATH_AGATHELOS);
                            agathelos->SetDefaultMovementType(WAYPOINT_MOTION_TYPE);
                            agathelos->GetMotionMaster()->Initialize();
                        }
                    }
                    break;
                default:
                    break;
            }

            if (data == DONE)
                _savedAgathelos = _encounter[0];
        }

        uint32 GetData(uint32 type) const override
        {
            switch (type)
            {
                case TYPE_AGATHELOS:
                    return _encounter[0];
                default:
                    break;
            }
            return 0;
        }

    private:
        uint32 _encounter[RFK_MAX_ENCOUNTER];
        uint8 _wardKeepersRemaining;
        ObjectGuid _agathelosWardGUID;
        ObjectGuid _agathelosGUID;
        PersistentInstanceScriptValue<uint32> _savedAgathelos;
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new classic_instance_razorfen_kraul_InstanceScript(map);
    }
};

void AddSC_classic_instance_razorfen_kraul()
{
    new classic_instance_razorfen_kraul();
}
