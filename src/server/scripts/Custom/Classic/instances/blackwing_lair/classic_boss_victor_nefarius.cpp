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

// Classic 1.60 port of VMaNGOS src/scripts/eastern_kingdoms/burning_steppes/blackwing_lair/boss_victor_nefarius.cpp (ScriptDev2 lineage, GPL-2)
// Scripts: boss_victor_nefarius

#include "ScriptMgr.h"
#include "GameObject.h"
#include "InstanceScript.h"
#include "Map.h"
#include "MapReference.h"
#include "MotionMaster.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "QuestDef.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "SpellInfo.h"
#include "TemporarySummon.h"
#include "World.h"
#include "ThreatManager.h"
#include "classic_blackwing_lair.h"
#include "classic_script_text.h"
#include <list>

namespace
{
enum ClassicBwlVictorNefarius : uint32
{
    CLASSIC_BWL_SAY_GAMESBEGIN_1             = 9907,
    CLASSIC_BWL_SAY_GAMESBEGIN_2             = 9845,

    CLASSIC_BWL_SAY_SCEPTER_RUN_START        = 11267,
    CLASSIC_BWL_SAY_SCEPTER_TAUNT_0          = 11214,
    CLASSIC_BWL_SAY_SCEPTER_TAUNT_1          = 11215,
    CLASSIC_BWL_SAY_SCEPTER_TAUNT_2          = 11216,
    CLASSIC_BWL_SAY_SCEPTER_TAUNT_3          = 11217,
    CLASSIC_BWL_SAY_SCEPTER_TAUNT_4          = 11218,
    CLASSIC_BWL_SAY_SCEPTER_RUN_LAUGHTER     = 11230,
    CLASSIC_BWL_SAY_SCEPTER_FAIL_LAUGHTER    = 11231,
    CLASSIC_BWL_SAY_SCEPTER_FAIL             = 11219,

    CLASSIC_BWL_MAX_SCEPTER_TAUNTS           = 6,

    // GOSSIP_TEXT_NEFARIUS_1                = 7134,
    // GOSSIP_TEXT_NEFARIUS_2                = 7198,
    // GOSSIP_TEXT_NEFARIUS_3                = 7199,

    CLASSIC_BWL_MAX_DRAKES                   = 5,
    CLASSIC_BWL_MAX_DRAKE_KILLED             = 42,

    CLASSIC_BWL_SPELL_NEFARIUS_BARRIER       = 22663, // immunity in phase 1
    CLASSIC_BWL_SPELL_SHADOWBOLT             = 22677,
    CLASSIC_BWL_SPELL_SHADOWBOLT_VOLLEY      = 22665,
    CLASSIC_BWL_SPELL_NEFARIUS_FEAR          = 22678,
    CLASSIC_BWL_SPELL_NEFARIUS_SILENCE       = 22666,
    CLASSIC_BWL_SPELL_SHADOW_COMMAND         = 22667, // charm a player
    // SPELL_SHADOW_BLINK                    = 22664, // 22681 ? // teleport around the room, possibly random
    CLASSIC_BWL_SPELL_NEFARIUS_ROOT          = 17507,
    CLASSIC_BWL_SPELL_VISUAL_EFFECT          = 24180,
    CLASSIC_BWL_SPELL_NEF_HOVER              = 17131
};

uint32 const ClassicBwlPossibleDrake[CLASSIC_BWL_MAX_DRAKES] =
{
    CLASSIC_BWL_NPC_BRONZE_DRAKANOID,
    CLASSIC_BWL_NPC_BLUE_DRAKANOID,
    CLASSIC_BWL_NPC_RED_DRAKANOID,
    CLASSIC_BWL_NPC_GREEN_DRAKANOID,
    CLASSIC_BWL_NPC_BLACK_DRAKANOID
};

constexpr uint32 CLASSIC_BWL_MAX_SCEPTER_RUN_TIME   = 5 * HOUR * IN_MILLISECONDS;
constexpr uint32 CLASSIC_BWL_SCEPTER_TAUNT_INTERVAL = CLASSIC_BWL_MAX_SCEPTER_RUN_TIME / CLASSIC_BWL_MAX_SCEPTER_TAUNTS;
constexpr uint32 CLASSIC_BWL_SCEPTER_TAUNT_OFFSET   = CLASSIC_BWL_SCEPTER_TAUNT_INTERVAL / 2;

Position const ClassicBwlNefarianLocs[5] =
{
    { -7599.32f,  -1191.72f,  475.545f  }, // opening where red/blue/black darknid spawner appear (ori 3.05433)
    { -7526.27f,  -1135.04f,  473.445f  }, // same as above, closest to door (ori 5.75959)
    { -7515.644f, -1222.698f, 534.7169f }, // nefarian spawn location (ori 1.798)
    { -7592.0f,   -1264.0f,   481.0f    }, // hide pos (useless; remove this)
    { -7502.002f, -1256.503f, 486.758f  }  // nefarian fly to this position
};
}

// This script is complicated
// Instead of morphing Victor Nefarius we will have him control phase 1
// And then have him spawn "Nefarian" for phase 2
// When phase 2 starts Victor Nefarius will go invisible and stop attacking
// If Nefarian reched home because nef killed the players then nef will trigger this guy to EnterEvadeMode
// and allow players to start the event over
// If nefarian dies then he will kill himself then he will be despawned in Nefarian script
// To prevent players from doing the event twice

// Dev note: Lord Victor Nefarius should despawn completely, then ~5 seconds later Nefarian should appear.

struct classic_boss_victor_nefarius : public ScriptedAI
{
    classic_boss_victor_nefarius(Creature* creature) : ScriptedAI(creature)
    {
        m_pInstance = creature->GetInstanceScript();

        // VMaNGOS: outside of BWL (UBRS) a NullCreatureAI with UNIT_FLAG_IMMUNE_TO_PLAYER is used instead;
        // the copy summoned during the Vaelastrasz intro also gets a NullCreatureAI.
        m_bInert = creature->GetMapId() != CLASSIC_BWL_MAP_ID || creature->IsSummon();
        if (creature->GetMapId() != CLASSIC_BWL_MAP_ID)
            creature->SetImmuneToPC(true);

        // Select the 2 different drakes that we are going to use until despawned
        // 5 possiblities for the first drake, 4 for the second, 20 total possiblites

        // select two different numbers between 0..MAX_DRAKES-1
        if (m_pInstance)
        {
            uint32 drakesType = m_pInstance->GetData(CLASSIC_BWL_DATA_NEF_COLOR);
            m_uiDrakeTypeOne = ClassicBwlPossibleDrake[drakesType % CLASSIC_BWL_MAX_DRAKES];
            uint32 idx2 = drakesType / CLASSIC_BWL_MAX_DRAKES;
            if (idx2 == drakesType % CLASSIC_BWL_MAX_DRAKES)
                ++idx2;
            m_uiDrakeTypeTwo = ClassicBwlPossibleDrake[idx2 % CLASSIC_BWL_MAX_DRAKES];
        }
    }

    InstanceScript* m_pInstance;
    bool m_bInert;

    uint32 m_uiKilledAdds = 0;
    uint32 m_uiSpawnedAdds = 0;   // Instance.NefarianCapAdds: drakonids called this phase 1
    uint32 m_uiLostAdds = 0;      // drakonids that went away alive (out of combat for 10 s): never killed
    uint32 m_uiAddSpawnTimer = 6000;
    uint32 m_uiAddChromaSpawnTimer = 8000;
    uint32 m_uiShadowBoltTimer = 5000;
    uint32 m_uiShadowBoltVolleyTimer = 15000;
    uint32 m_uiFearTimer = 8000;
    uint32 m_uiSilenceTimer = 20000;
    uint32 m_uiMindControlTimer = 25000;
    uint32 m_uiShadowBlinkTimer = 1000;
    uint32 m_uiDrakeTypeOne = 0;
    uint32 m_uiDrakeTypeTwo = 0;
    uint32 m_uiEventTimer = 1000;
    uint32 blaBlaCount = 0;
    uint32 scepterRunTime = 0;
    uint32 nextScepterTauntTime = 0;
    uint32 scepterTauntID = 0;

    bool NefaEventStart = false;
    bool phase1 = false;
    bool phase2 = false;
    bool phase2bis = false;
    bool Smoke = false;
    bool scepterRun = false;
    bool watchScepterRun = false;

    ObjectGuid m_uiMindControledPlayerGuid;
    float m_uiMindControledPlayerAggro = 0.0f;

    void Reset() override
    {
        if (m_bInert)
            return;

        m_uiKilledAdds            = 0;
        m_uiSpawnedAdds           = 0;
        m_uiLostAdds              = 0;
        m_uiAddSpawnTimer         = 6000;
        m_uiAddChromaSpawnTimer   = urand(7000, 9000);
        m_uiShadowBoltTimer       = 5000;
        m_uiShadowBoltVolleyTimer = 15000;
        m_uiFearTimer             = 8000;
        m_uiSilenceTimer          = 20000;
        m_uiMindControlTimer      = 25000;
        m_uiShadowBlinkTimer      = 1000;
        scepterRunTime            = 0;
        nextScepterTauntTime      = 0;
        scepterTauntID            = 0;

        m_uiMindControledPlayerGuid.Clear();
        m_uiMindControledPlayerAggro = 0;

        m_uiEventTimer  = 1000;
        blaBlaCount     = 0;
        NefaEventStart  = false;
        phase1          = false;
        phase2          = false;
        phase2bis       = false;
        Smoke           = false;
        scepterRun      = false;
        watchScepterRun = false;

        me->SetFaction(CLASSIC_BWL_FACTION_FRIENDLY);

        // set gossip flag to begin the event
        me->SetStandState(UNIT_STAND_STATE_SIT_LOW_CHAIR);
        me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);

        // Make visible if needed
        me->SetVisible(true);

        LoadScepterRun();
    }

    void LoadScepterRun()
    {
        if (!m_pInstance)
            return;

        if (m_pInstance->GetData(CLASSIC_BWL_TYPE_SCEPTER_RUN) == FAIL)
            return;

        watchScepterRun = true;

        if (m_pInstance->GetData(CLASSIC_BWL_TYPE_SCEPTER_RUN) == IN_PROGRESS)
        {
            scepterRun = true;
            scepterRunTime = m_pInstance->GetData(CLASSIC_BWL_DATA_SCEPTER_RUN_TIME);

            // Find elapsed time + taunt time offset
            uint32 elapsedTime = CLASSIC_BWL_MAX_SCEPTER_RUN_TIME - scepterRunTime;
            elapsedTime += CLASSIC_BWL_SCEPTER_TAUNT_OFFSET;

            // Restore next scepter taunt ID
            scepterTauntID = elapsedTime / CLASSIC_BWL_SCEPTER_TAUNT_INTERVAL;
            // Restore time to next taunt
            nextScepterTauntTime = CLASSIC_BWL_SCEPTER_TAUNT_INTERVAL - (elapsedTime % CLASSIC_BWL_SCEPTER_TAUNT_INTERVAL);
        }
    }

    void StartScepterRun()
    {
        ClassicScriptText(CLASSIC_BWL_SAY_SCEPTER_RUN_START, me);

        scepterTauntID = 0;
        nextScepterTauntTime = CLASSIC_BWL_SCEPTER_TAUNT_OFFSET;

        scepterRunTime = CLASSIC_BWL_MAX_SCEPTER_RUN_TIME;
        scepterRun = true;

        m_pInstance->SetData(CLASSIC_BWL_TYPE_SCEPTER_RUN, IN_PROGRESS);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        if (m_bInert)
            return;

        if (m_pInstance)
            m_pInstance->SetData(CLASSIC_BWL_TYPE_NEFARIAN, IN_PROGRESS);

        DoZoneInCombat();
    }

    void JustReachedHome() override
    {
        if (m_bInert)
            return;

        me->SetFaction(CLASSIC_BWL_FACTION_FRIENDLY);
        me->SetUninteractible(false); // VMaNGOS UNIT_FLAG_NOT_SELECTABLE

        if (m_pInstance)
            m_pInstance->SetData(CLASSIC_BWL_TYPE_NEFARIAN, FAIL);

        std::list<GameObject*> lGameObjects;
        me->GetGameObjectListWithEntryInGrid(lGameObjects, CLASSIC_BWL_GO_DRAKONID_BONES, 250.0f);
        for (GameObject* pGo : lGameObjects)
            pGo->Delete();

        // VMaNGOS: SetRespawnDelay(10) + DisappearAndDie() (@TODO there: "Find out why there is this reset bug !!")
        me->DespawnOrUnsummon(0s, 10s);
    }

    void JustSummoned(Creature* pSummoned) override
    {
        if (Unit* pTarget = SelectTarget(SelectTargetMethod::Random, 0))
        {
            CreatureAI::DoZoneInCombat(pSummoned);
            if (pSummoned->AI())
                pSummoned->AI()->AttackStart(pTarget);
        }

        // VMaNGOS SetRespawnDelay(7 * DAY): temp summons never respawn in TC
    }

    void SummonedCreatureDies(Creature* pSummoned, Unit* /*killer*/) override
    {
        // Despawn self when Nefarian is killed
        if (pSummoned->GetEntry() == CLASSIC_BWL_NPC_NEFARIAN)
        {
            if (!m_pInstance)
                return;

            uint32 scepterRunResult = FAIL;

            // Check for successful Scepter Shard Run
            if (scepterRun)
            {
                // Check if still has time left
                if (Player* scepterChampion = ObjectAccessor::GetPlayer(*me, m_pInstance->GetGuidData(CLASSIC_BWL_DATA_SCEPTER_CHAMPION)))
                    if (scepterChampion->GetQuestStatus(CLASSIC_BWL_QUEST_NEFARIUS_CORRUPTION) == QUEST_STATUS_INCOMPLETE)
                        scepterRunResult = DONE;
            }

            m_pInstance->SetData(CLASSIC_BWL_TYPE_SCEPTER_RUN, scepterRunResult);

            // VMaNGOS: SetRespawnDelay(7 * DAY) + ForcedDespawn()
            me->DespawnOrUnsummon(0s, Seconds(7 * DAY));
        }
        else
            ++m_uiKilledAdds;
    }

    void SummonedCreatureDespawn(Creature* pSummoned) override
    {
        if (pSummoned->GetEntry() != CLASSIC_BWL_NPC_NEFARIAN && pSummoned->IsAlive())
            ++m_uiLostAdds;
    }

    // VMaNGOS gossip_scripts 604500 (gossip option "Attack them, minions!"):
    // the instance forwards SetData(CLASSIC_BWL_GOSSIP_OPTION_NEFARIUS) here.
    void DoAction(int32 action) override
    {
        if (m_bInert)
            return;

        if (action == CLASSIC_BWL_ACTION_NEFARIUS_START)
            NefaEventStart = true;
    }

    bool OnGossipSelect(Player* pPlayer, uint32 menuId, uint32 gossipListId) override
    {
        if (m_bInert)
            return false;

        // VMaNGOS DB: gossip menu 6045, last option triggers gossip script 604500 -> event start
        if (menuId == CLASSIC_BWL_GOSSIP_OPTION_NEFARIUS && gossipListId == 0)
        {
            CloseGossipMenuFor(pPlayer);
            NefaEventStart = true;
        }
        return false;
    }

    void UpdateAI(uint32 uiDiff) override
    {
        if (m_bInert)
            return;

        if (NefaEventStart && !phase1)
        {
            if (m_uiEventTimer < uiDiff)
            {
                ++blaBlaCount;
                switch (blaBlaCount)
                {
                    case 1:
                        ClassicScriptText(CLASSIC_BWL_SAY_GAMESBEGIN_1, me);
                        m_uiEventTimer = 7000;
                        break;
                    case 2:
                        ClassicScriptText(CLASSIC_BWL_SAY_GAMESBEGIN_2, me);
                        m_uiEventTimer = 4000;
                        break;
                    case 3:
                    {
                        DoCastSelf(CLASSIC_BWL_SPELL_NEFARIUS_BARRIER);
                        me->SetImmuneToPC(false); // VMaNGOS RemoveFlag(UNIT_FLAG_IMMUNE_TO_PLAYER)
                        me->SetFaction(CLASSIC_BWL_FACTION_MONSTER);
                        // VMaNGOS leaves these to its DB gossip script (604500)
                        me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
                        me->SetStandState(UNIT_STAND_STATE_STAND);

                        for (MapReference const& itr : me->GetMap()->GetPlayers())
                            if (Player* pPlayer = itr.GetSource())
                                if (pPlayer->IsAlive())
                                    me->GetThreatManager().AddThreat(pPlayer, 10000.0f);

                        DoCastSelf(CLASSIC_BWL_SPELL_NEFARIUS_ROOT, true); // root
                        break;
                    }
                    default:
                        break;
                }
            }
            else
                m_uiEventTimer -= uiDiff;
        }

        if (watchScepterRun && m_pInstance)
        {
            if (scepterRun)
                HandleScepterRun(uiDiff);
            else
            {
                uint32 scepterRunStatus = m_pInstance->GetData(CLASSIC_BWL_TYPE_SCEPTER_RUN);

                if (FAIL == scepterRunStatus)
                    watchScepterRun = false;
                else if (SPECIAL == scepterRunStatus)
                    StartScepterRun();
            }
        }

        if (!UpdateVictim())
            return;

        if (phase2bis)
            return;

        if (m_uiKilledAdds >= CLASSIC_BWL_MAX_DRAKE_KILLED) // 42 drakes killed
        {
            phase2bis = true;
            if (phase2)
                return;
        }

        // Instance.NefarianCapAdds (the TrinityCore way): no drakonid after the 42nd has come. Off: they come until 42 are killed (1.12).
        bool const capAdds = sWorld->getBoolConfig(CONFIG_BWL_NEFARIAN_CAP_ADDS);
        auto callAdd = [&](uint32 entry, Position const& at)
        {
            if (capAdds && m_uiSpawnedAdds >= CLASSIC_BWL_MAX_DRAKE_KILLED)
                return;
            if (me->SummonCreature(entry, at.GetPositionX(), at.GetPositionY(), at.GetPositionZ(), 5.000f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 10s))
                ++m_uiSpawnedAdds;
        };

        // Add spawning mechanism
        if (m_uiAddSpawnTimer < uiDiff)
        {
            callAdd(m_uiDrakeTypeOne, ClassicBwlNefarianLocs[0]);
            callAdd(m_uiDrakeTypeTwo, ClassicBwlNefarianLocs[1]);

            m_uiAddSpawnTimer = urand(6000, 7000);
        }
        else
            m_uiAddSpawnTimer -= uiDiff;

        if (m_uiAddChromaSpawnTimer < uiDiff)
        {
            callAdd(CLASSIC_BWL_NPC_CHROMATIC_DRAKANOID, ClassicBwlNefarianLocs[0]);
            callAdd(CLASSIC_BWL_NPC_CHROMATIC_DRAKANOID, ClassicBwlNefarianLocs[1]);
            m_uiAddChromaSpawnTimer = 35000;
        }
        else
            m_uiAddChromaSpawnTimer -= uiDiff;

        if (phase2) // 40 drakes killed
            return;

        // Begin phase 2 by spawning Nefarian
        // Instance.NefarianCapAdds: with no more drakonids to come, one that went away alive must not leave the raid short of 40 kills
        // for good. He lands once all 42 are gone.
        bool const allGone = capAdds && m_uiSpawnedAdds >= CLASSIC_BWL_MAX_DRAKE_KILLED &&
                             m_uiKilledAdds + m_uiLostAdds >= CLASSIC_BWL_MAX_DRAKE_KILLED;
        if (m_uiKilledAdds >= (CLASSIC_BWL_MAX_DRAKE_KILLED - 2) || allGone) // 40 drakes killed
        {
            // Inturrupt any spell casting
            me->InterruptNonMeleeSpells(false);

            // Root self
            DoCastSelf(CLASSIC_BWL_SPELL_NEFARIUS_ROOT, true);

            // Make super invis
            me->SetVisible(false);

            // Spawn Nefarian
            // Summon as active, to be able to work proper!
            if (Creature* pNefarian = me->SummonCreature(CLASSIC_BWL_NPC_NEFARIAN,
                ClassicBwlNefarianLocs[2].GetPositionX(),
                ClassicBwlNefarianLocs[2].GetPositionY(),
                ClassicBwlNefarianLocs[2].GetPositionZ(),
                0.0f, TEMPSUMMON_MANUAL_DESPAWN))
            {
                pNefarian->setActive(true);
                pNefarian->SetFarVisible(true);
                pNefarian->CastSpell(pNefarian, CLASSIC_BWL_SPELL_NEF_HOVER, true);
                // VMaNGOS SetFly(true)
                pNefarian->SetCanFly(true);
                pNefarian->SetDisableGravity(true);
            }

            // Nefarian spawn when 40 drakes are killed
            // Adds will stop spawning when 42 are killed
            // He flies then arrives at his spawn point staying in the air
            // 10 seconds later: arise and cast shadow flame
            phase2 = true;
            return;
        }

        // Shadowbolt Timer
        if (m_uiShadowBoltTimer < uiDiff)
        {
            if (DoCastVictim(CLASSIC_BWL_SPELL_SHADOWBOLT) == SPELL_CAST_OK)
                m_uiShadowBoltTimer = urand(3000, 10000);
        }
        else
            m_uiShadowBoltTimer -= uiDiff;

        // Shadowbolt Volley Timer
        if (m_uiShadowBoltVolleyTimer < uiDiff)
        {
            if (DoCastVictim(CLASSIC_BWL_SPELL_SHADOWBOLT_VOLLEY) == SPELL_CAST_OK)
                m_uiShadowBoltVolleyTimer = 15000;
        }
        else
            m_uiShadowBoltVolleyTimer -= uiDiff;

        // Fear Timer
        if (m_uiFearTimer < uiDiff)
        {
            if (Unit* pTarget = SelectTarget(SelectTargetMethod::Random, 0))
            {
                if (DoCast(pTarget, CLASSIC_BWL_SPELL_NEFARIUS_FEAR) == SPELL_CAST_OK)
                    m_uiFearTimer = urand(15000, 25000);
            }
        }
        else
            m_uiFearTimer -= uiDiff;

        // Silence Timer
        if (m_uiSilenceTimer < uiDiff)
        {
            if (Unit* pTarget = SelectTarget(SelectTargetMethod::Random, 0))
            {
                if (DoCast(pTarget, CLASSIC_BWL_SPELL_NEFARIUS_SILENCE) == SPELL_CAST_OK)
                    m_uiSilenceTimer = urand(25000, 40000);
            }
        }
        else
            m_uiSilenceTimer -= uiDiff;

        // Shadow Blink Timer
        if (m_uiShadowBlinkTimer < uiDiff)
        {
            if (!Smoke)
            {
                me->InterruptNonMeleeSpells(false);
                me->CastSpell(me, CLASSIC_BWL_SPELL_VISUAL_EFFECT, true); // VMaNGOS SendSpellGo (visual only)
                m_uiShadowBlinkTimer = 1000;
                Smoke = true;
            }
            else if (Unit* pTarget = SelectTarget(SelectTargetMethod::Random, 0))
            {
                me->NearTeleportTo(pTarget->GetPositionX() + float(urand(0, 8)), pTarget->GetPositionY() + float(urand(0, 8)), pTarget->GetPositionZ(), me->GetOrientation());
                me->CastSpell(me, CLASSIC_BWL_SPELL_VISUAL_EFFECT, true); // VMaNGOS SendSpellGo (visual only)
                AttackStart(pTarget);
                DoZoneInCombat();
                DoCastSelf(CLASSIC_BWL_SPELL_NEFARIUS_ROOT, true); // Root Self
                m_uiShadowBlinkTimer = urand(20000, 25000);
                m_uiShadowBoltTimer = urand(3000, 6000);
                Smoke = false;
            }
        }
        else
            m_uiShadowBlinkTimer -= uiDiff;

        if (!m_uiMindControledPlayerGuid.IsEmpty())
        {
            if (Player* pTarget = ObjectAccessor::GetPlayer(*me, m_uiMindControledPlayerGuid))
            {
                if (!pTarget->HasAura(CLASSIC_BWL_SPELL_SHADOW_COMMAND))
                {
                    ModifyThreatByPercent(pTarget, -100);
                    me->GetThreatManager().AddThreat(pTarget, m_uiMindControledPlayerAggro, nullptr, true, true); // VMaNGOS addThreatDirectly
                    DoCastSelf(CLASSIC_BWL_SPELL_NEFARIUS_ROOT, true);   // Root self
                    m_uiMindControledPlayerGuid.Clear();
                    m_uiMindControledPlayerAggro = 0;
                }
            }
            else
            {
                m_uiMindControledPlayerGuid.Clear();
                m_uiMindControledPlayerAggro = 0;
            }
        }

        // Mind Control Timer
        if (m_uiMindControlTimer < uiDiff)
        {
            if (Unit* pTarget = SelectTarget(SelectTargetMethod::Random, 1))
            {
                m_uiMindControledPlayerGuid = pTarget->GetGUID();
                m_uiMindControledPlayerAggro = me->GetThreatManager().GetThreat(pTarget);
                // VMaNGOS: CF_AURA_NOT_PRESENT
                if (!pTarget->HasAura(CLASSIC_BWL_SPELL_SHADOW_COMMAND) && DoCast(pTarget, CLASSIC_BWL_SPELL_SHADOW_COMMAND) == SPELL_CAST_OK)
                    m_uiMindControlTimer = urand(25000, 40000);
            }
        }
        else
            m_uiMindControlTimer -= uiDiff;
    }

    void HandleScepterRun(uint32 uiDiff)
    {
        if (!m_pInstance)
            return;

        // Handle Nefarius' taunts throughout the run
        if (nextScepterTauntTime <= uiDiff)
        {
            switch (scepterTauntID)
            {
                case 0:
                    ClassicScriptText(CLASSIC_BWL_SAY_SCEPTER_TAUNT_0, me);
                    ClassicScriptText(CLASSIC_BWL_SAY_SCEPTER_RUN_LAUGHTER, me);
                    break;
                case 1:
                    ClassicScriptText(CLASSIC_BWL_SAY_SCEPTER_TAUNT_1, me);
                    break;
                case 2:
                    ClassicScriptText(CLASSIC_BWL_SAY_SCEPTER_TAUNT_2, me);
                    break;
                case 3:
                    ClassicScriptText(CLASSIC_BWL_SAY_SCEPTER_TAUNT_3, me);
                    break;
                case 4:
                    ClassicScriptText(CLASSIC_BWL_SAY_SCEPTER_TAUNT_4, me);
                    break;
                default:
                    break;
            }

            ++scepterTauntID;
            nextScepterTauntTime = CLASSIC_BWL_SCEPTER_TAUNT_INTERVAL;
        }
        else
            nextScepterTauntTime -= uiDiff;

        // Check overall Scepter Run time
        if (scepterRunTime <= uiDiff)
            FailScepterRun();
        else
            scepterRunTime -= uiDiff;

        m_pInstance->SetData(CLASSIC_BWL_DATA_SCEPTER_RUN_TIME, scepterRunTime);
    }

    void FailScepterRun()
    {
        if (!m_pInstance)
            return;

        scepterRun = false;
        watchScepterRun = false;
        m_pInstance->SetData(CLASSIC_BWL_TYPE_SCEPTER_RUN, FAIL);

        ClassicScriptText(CLASSIC_BWL_SAY_SCEPTER_FAIL, me);
        ClassicScriptText(CLASSIC_BWL_SAY_SCEPTER_FAIL_LAUGHTER, me);
    }
};

void AddSC_classic_boss_victor_nefarius()
{
    RegisterCreatureAI(classic_boss_victor_nefarius);
}
