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

// Classic 1.60 (Forever): Ruins of Lordaeron (map 2999). The bosses run SmartAI, so the boss states come from
// ClassicDungeonEncounterTracker. Encounter to creature from the official dungeon sniff (ENCOUNTER_START / END next to the
// boss threat and kill packets): The Butcher encounter (3355) is The Baron. Viktor the Vile (3411) is from EG Link's
// encounter data (boss 256035 on map 2999); he comes when the Warm Kindling fire is lit (SmartGameObjectAI, world SQL).
// Lordaeron Captain (3408) is not seen yet and has no boss id here.

#include "ScriptMgr.h"
#include "Creature.h"
#include "InstanceScript.h"
#include "Map.h"
#include "classic_dungeon_encounter_tracker.h"

namespace
{
constexpr uint32 CLASSIC_ROL_MAP_ID = 2999;

enum ClassicRuinsOfLordaeronEncounterBosses : uint32
{
    CROL_ENC_WITHERFANG = 0,
    CROL_ENC_RATHMAEL = 1,
    CROL_ENC_THE_BUTCHER = 2,
    CROL_ENC_THE_ABANDONED = 3,
    CROL_ENC_BJORK = 4,
    CROL_ENC_VIKTOR = 5,
    CROL_ENC_MAX
};

constexpr ClassicDungeonBossEntry ClassicRuinsOfLordaeronEncounterBossEntries[] =
{
    { CROL_ENC_WITHERFANG, 250483 },    // Witherfang
    { CROL_ENC_RATHMAEL, 250657 },      // Rath'mael
    { CROL_ENC_THE_BUTCHER, 250660 },   // The Baron
    { CROL_ENC_THE_ABANDONED, 250631 }, // The Abandoned (comes out of the statue)
    { CROL_ENC_BJORK, 256097 },         // Bjork
    { CROL_ENC_VIKTOR, 256035 }         // Viktor the Vile (summoned by the Warm Kindling fire)
};
}

class classic_instance_ruins_of_lordaeron : public InstanceMapScript
{
public:
    classic_instance_ruins_of_lordaeron() : InstanceMapScript("classic_instance_ruins_of_lordaeron", CLASSIC_ROL_MAP_ID) { }

    struct classic_instance_ruins_of_lordaeron_InstanceScript : public InstanceScript
    {
        classic_instance_ruins_of_lordaeron_InstanceScript(InstanceMap* map) : InstanceScript(map)
        {
            SetHeaders("CROL");
            SetBossNumber(CROL_ENC_MAX);
            static constexpr DungeonEncounterData encounters[] =
            {
                { CROL_ENC_WITHERFANG, {{ 3353 }} },
                { CROL_ENC_RATHMAEL, {{ 3354 }} },
                { CROL_ENC_THE_BUTCHER, {{ 3355 }} },
                { CROL_ENC_THE_ABANDONED, {{ 3357 }} },
                { CROL_ENC_BJORK, {{ 3412 }} },
                { CROL_ENC_VIKTOR, {{ 3411 }} }
            };
            LoadDungeonEncounterData(encounters);
        }

        ClassicDungeonEncounterTracker _encounterTracker{ *this, ClassicRuinsOfLordaeronEncounterBossEntries };

        void OnCreatureCreate(Creature* creature) override
        {
            InstanceScript::OnCreatureCreate(creature);
            _encounterTracker.OnCreatureCreate(creature);
        }

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
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new classic_instance_ruins_of_lordaeron_InstanceScript(map);
    }
};

void AddSC_classic_instance_ruins_of_lordaeron()
{
    new classic_instance_ruins_of_lordaeron();
}
