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

// Classic 1.60 port of VMaNGOS src/scripts/eastern_kingdoms/eastern_plaguelands/naxxramas/boss_gluth.cpp (ScriptDev2 lineage, GPL-2)
// Scripts: boss_gluth, mob_zombie_chow, spell_gluth_decimate (28375)

#include "ScriptMgr.h"
#include "Creature.h"
#include "InstanceScript.h"
#include "Map.h"
#include "MotionMaster.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellInfo.h"
#include "SpellScript.h"
#include "TemporarySummon.h"
#include "classic_naxxramas.h"
#include "classic_script_text.h"
#include <list>

namespace
{
float const ClassicGluthZombieSummonLoc[3][3] =
{
    { 3267.9f, -3172.1f, 297.42f },
    { 3253.2f, -3132.3f, 297.42f },
    { 3308.3f, -3185.8f, 297.42f },
};

enum ClassicNaxxGluthData : uint32
{
    EMOTE_GLUTH_FRENZY            = 1191,

    SPELL_GLUTH_DOUBLE_ATTACK     = 19818, // Added on reset in cmangos, not sure why

    SPELL_GLUTH_MORTALWOUND       = 25646,
    SPELL_GLUTH_DECIMATE          = 28374,
    SPELL_GLUTH_DECIMATE_OTHER    = 28375,
    SPELL_GLUTH_FRENZY            = 28371,
    SPELL_GLUTH_BERSERK           = 26662,
    SPELL_GLUTH_TERRIFYING_ROAR   = 29685,

    //SPELL_ZOMBIE_CHOW_SEARCH = 28235, // triggers 28236 every 3 sec, manually implemented instead
    //SPELL_CALL_ALL_ZOMBIE    = 29681, // triggers 29682 every 3 sec, manually implemented instead

    NPC_GLUTH_ZOMBIE_CHOW         = 16360,
    SPELL_GLUTH_INFECTED_WOUND    = 29307
};

enum ClassicNaxxGluthActions : int32
{
    ACTION_GLUTH_ZOMBIE_DECIMATED = 1
};

enum ClassicNaxxGluthEvents : uint32
{
    EVENT_GLUTH_MORTAL_WOUND = 1,
    EVENT_GLUTH_DECIMATE,
    EVENT_GLUTH_FRENZY,
    EVENT_GLUTH_SUMMON,
    EVENT_GLUTH_BERSERK,
    EVENT_GLUTH_TERRIFYING_ROAR,
    EVENT_GLUTH_ZOMBIE_SEARCH,
    EVENT_GLUTH_EVADE_CHECK
};

constexpr Milliseconds CLASSIC_GLUTH_MORTAL_WOUND_CD  = 10000ms;   // verified by: https://www.youtube.com/watch?v=RAPiZgo-pNA
constexpr Milliseconds CLASSIC_GLUTH_DECIMATE_CD      = 105000ms;  // todo: Might be +- 5 seconds
constexpr Milliseconds CLASSIC_GLUTH_FRENZY_CD        = 10000ms;   // verified by: https://www.youtube.com/watch?v=RAPiZgo-pNA
constexpr Milliseconds CLASSIC_GLUTH_SUMMON_CD        = 6000ms;    // verified by dbc spell 28216
constexpr Milliseconds CLASSIC_GLUTH_BERSERK_CD       = 330000ms;  // todo: verify (15 sec after third decimate)
constexpr Milliseconds CLASSIC_GLUTH_FEAR_CD          = 20000ms;   // verified by: https://www.youtube.com/watch?v=RAPiZgo-pNA
constexpr Milliseconds CLASSIC_GLUTH_ZOMBIE_SEARCH_CD = 3000ms;    // dbc confirms this one

// 1.12 spell 28374 (Decimate) hits TARGET_UNIT_SRC_AREA_ENTRY in radius index 22 (200 yd)
constexpr float CLASSIC_GLUTH_DECIMATE_RADIUS = 200.0f;
}

struct classic_boss_gluth : public ScriptedAI
{
    classic_boss_gluth(Creature* creature) : ScriptedAI(creature), m_pInstance(GetClassicNaxxInstance(creature))
    {
        five_percent = uint32(me->GetMaxHealth() * 0.05f);
    }

    classic_instance_naxxramas_InstanceScript* m_pInstance;
    EventMap m_events;

    uint32 five_percent;

    void Reset() override
    {
        m_events.Reset();

        DespawnAllZombiess();
    }

    void DespawnAllZombiess()
    {
        std::list<Creature*> zombies;
        me->GetCreatureListWithEntryInGrid(zombies, NPC_GLUTH_ZOMBIE_CHOW, 200.0f);
        for (Creature* c : zombies)
            c->DespawnOrUnsummon();
    }

    void JustDied(Unit* /*killer*/) override
    {
        if (m_pInstance)
            m_pInstance->SetData(TYPE_GLUTH, DONE);
        DespawnAllZombiess();
    }

    void MoveInLineOfSight(Unit* pWho) override
    {
        // He should aggro just at the edge of the sewer pipe players jump from. Only a player in his own room: the
        // 49 y reach goes through the wall into Patchwerk's room (one floor lower, ~294 against his ~297.8), and a
        // raid fighting Patchwerk pulled him in (Karrz 11-15: "2 bosses on us").
        if (pWho->GetTypeId() == TYPEID_PLAYER
            && !me->IsInCombat()
            && me->IsWithinDistInMap(pWho, 49.0f)
            && std::abs(pWho->GetPositionZ() - me->GetPositionZ()) < 2.5f
            && me->IsWithinLOSInMap(pWho)
            && !pWho->HasAuraType(SPELL_AURA_FEIGN_DEATH))
        {
            AttackStart(pWho);
        }
        ScriptedAI::MoveInLineOfSight(pWho);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        if (m_pInstance)
            m_pInstance->SetData(TYPE_GLUTH, IN_PROGRESS);

        m_events.ScheduleEvent(EVENT_GLUTH_MORTAL_WOUND,    CLASSIC_GLUTH_MORTAL_WOUND_CD);
        m_events.ScheduleEvent(EVENT_GLUTH_DECIMATE,        CLASSIC_GLUTH_DECIMATE_CD);
        m_events.ScheduleEvent(EVENT_GLUTH_FRENZY,          CLASSIC_GLUTH_FRENZY_CD);
        m_events.ScheduleEvent(EVENT_GLUTH_SUMMON,          CLASSIC_GLUTH_SUMMON_CD);
        m_events.ScheduleEvent(EVENT_GLUTH_BERSERK,         CLASSIC_GLUTH_BERSERK_CD);
        m_events.ScheduleEvent(EVENT_GLUTH_TERRIFYING_ROAR, CLASSIC_GLUTH_FEAR_CD);
        m_events.ScheduleEvent(EVENT_GLUTH_ZOMBIE_SEARCH,   CLASSIC_GLUTH_ZOMBIE_SEARCH_CD);
        m_events.ScheduleEvent(EVENT_GLUTH_EVADE_CHECK,     5s);
    }

    void JustReachedHome() override
    {
        if (m_pInstance)
            m_pInstance->SetData(TYPE_GLUTH, FAIL);
    }

    // VMaNGOS does this in SpellHit (Gluth hit by his own 28374, an area-entry spell whose script target is Gluth and the
    // zombies). TC has no spell_script_target for it, so it is done when the cast finishes: every living player gets 28375
    // and every zombie chow in range is told it was hit (mob_zombie_chow SpellHit in VMaNGOS).
    void OnSpellCast(SpellInfo const* spellInfo) override
    {
        // only want to do these calculations inside naxx
        if (me->GetMapId() != MAP_NAXXRAMAS)
            return;

        if (spellInfo->Id != SPELL_GLUTH_DECIMATE)
            return;

        for (MapReference const& ref : me->GetMap()->GetPlayers())
        {
            Player* pPlayer = ref.GetSource();
            if (!pPlayer)
                continue;
            if (!pPlayer->IsAlive())
                continue;
            DoCast(pPlayer, SPELL_GLUTH_DECIMATE_OTHER, true);
        }

        // TODO(classic): VMaNGOS relies on the zombies being hit by 28374; radius taken from 1.12 spell data.
        std::list<Creature*> zombies;
        me->GetCreatureListWithEntryInGrid(zombies, NPC_GLUTH_ZOMBIE_CHOW, CLASSIC_GLUTH_DECIMATE_RADIUS);
        for (Creature* zombie : zombies)
            if (zombie->IsAlive() && zombie->AI())
                zombie->AI()->DoAction(ACTION_GLUTH_ZOMBIE_DECIMATED);
    }

    void UpdateAI(uint32 uiDiff) override
    {
        if (!UpdateVictim())
            return;

        m_events.Update(uiDiff);
        while (uint32 l_EventId = m_events.ExecuteEvent())
        {
            switch (l_EventId)
            {
                case EVENT_GLUTH_MORTAL_WOUND:
                {
                    // mortal wound current target every
                    if (DoCastVictim(SPELL_GLUTH_MORTALWOUND) == SPELL_CAST_OK)
                        m_events.Repeat(CLASSIC_GLUTH_MORTAL_WOUND_CD);
                    else
                        m_events.Repeat(100ms);
                    break;
                }
                case EVENT_GLUTH_DECIMATE:
                {
                    // decimate every DECIMATE_CD ms
                    // all the decimate logic is handled in OnSpellCast, so we dont put any players on
                    // 5% hp until we know the boss has finished his cast
                    if (DoCastSelf(SPELL_GLUTH_DECIMATE) == SPELL_CAST_OK)
                        m_events.Repeat(CLASSIC_GLUTH_DECIMATE_CD);
                    else
                        m_events.Repeat(100ms);
                    break;
                }
                case EVENT_GLUTH_FRENZY:
                {
                    // Frenzy every FRENZY_CD ms
                    if (DoCastSelf(SPELL_GLUTH_FRENZY) == SPELL_CAST_OK)
                    {
                        m_events.Repeat(CLASSIC_GLUTH_FRENZY_CD);
                        ClassicScriptText(EMOTE_GLUTH_FRENZY, me);
                    }
                    else
                        m_events.Repeat(100ms);
                    break;
                }
                case EVENT_GLUTH_SUMMON:
                    // Summon an add every SUMMON_CD ms
                    SummonAdd();
                    m_events.Repeat(CLASSIC_GLUTH_SUMMON_CD);
                    break;
                case EVENT_GLUTH_BERSERK:
                {
                    // berserk after BERSERK_CD ms
                    if (DoCastSelf(SPELL_GLUTH_BERSERK) == SPELL_CAST_OK)
                        m_events.Repeat(300000ms); // duration of berserk
                    else
                        m_events.Repeat(100ms);
                    break;
                }
                case EVENT_GLUTH_TERRIFYING_ROAR:
                {
                    // fear every FEAR_CD ms
                    if (DoCastSelf(SPELL_GLUTH_TERRIFYING_ROAR) == SPELL_CAST_OK)
                        m_events.Repeat(CLASSIC_GLUTH_FEAR_CD);
                    else
                        m_events.Repeat(100ms);
                    break;
                }
                case EVENT_GLUTH_ZOMBIE_SEARCH:
                {
                    // every ZOMBIE_SEARCH_CD ms he checks if any zombies are close enough to eat
                    DoSearchZombieChow();
                    m_events.Repeat(CLASSIC_GLUTH_ZOMBIE_SEARCH_CD);
                    break;
                }
                case EVENT_GLUTH_EVADE_CHECK:
                {
                    m_events.Repeat(5s);
                    float curZ = me->GetPositionZ(); // encounter floor at ~297.78f
                    // avoid getting stuck in wall on pull; his room floor runs 296.7-298, Patchwerk's 293.7-294.1: below 295.3 he has left his room
                    if (curZ < 295.3f || curZ > 300.0f)
                    {
                        EnterEvadeMode();
                        return;
                    }
                    else
                    {
                        if (me->GetDistance2d(me->GetHomePosition().GetPositionX(), me->GetHomePosition().GetPositionY()) > 150.0f)
                        {
                            EnterEvadeMode();
                            return;
                        }
                    }
                    break;
                }
                default:
                    break;
            }
        }
    }

    // Spell 28236 could be used instead, but frankly this is more reliable and simple
    // the way the core is
    void DoSearchZombieChow()
    {
        std::list<Creature*> chowableZombies;
        me->GetCreatureListWithEntryInGrid(chowableZombies, NPC_GLUTH_ZOMBIE_CHOW, 15.0f);
        if (chowableZombies.empty())
            return;

        for (Creature* chowableZombie : chowableZombies)
        {
            if (!chowableZombie->IsAlive())
                continue;

            // Using 2d distance, should do fine
            if (chowableZombie->GetDistance2d(me) < 15.0f) // distance based on dbc for spellid 289236
            {
                me->SetFacingToObject(chowableZombie);
                Unit::Kill(me, chowableZombie, false);

                // heals gluth for 5%. SetHealth truncates to maxhealth internally
                me->SetHealth(me->GetHealth() + five_percent);
            }
        }
    }

    void SummonAdd()
    {
        int idx = urand(0, 2);
        float x = ClassicGluthZombieSummonLoc[idx][0] + frand(-7.0f, 7.0f);
        float y = ClassicGluthZombieSummonLoc[idx][1] + frand(-7.0f, 7.0f);
        float z = ClassicGluthZombieSummonLoc[idx][2];// +frand(-7.0f, 7.0f);

        //todo: don't know if we should summon 1, 2 or 3 zombies each time.
        if (Creature* pZombie = me->SummonCreature(NPC_GLUTH_ZOMBIE_CHOW, x, y, z, 0.0f, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 300000ms))
        {
            CreatureAI::DoZoneInCombat(pZombie);
            if (Unit* pTarget = SelectTarget(SelectTargetMethod::Random, 0))
                pZombie->AI()->AttackStart(pTarget);
        }
    }
};

struct classic_mob_zombie_chow : public ScriptedAI
{
    classic_mob_zombie_chow(Creature* creature) : ScriptedAI(creature), m_pInstance(GetClassicNaxxInstance(creature)) { }

    classic_instance_naxxramas_InstanceScript* m_pInstance;
    bool isHitByDecimate = false;

    void Reset() override
    {
        isHitByDecimate = false;
        DoCastSelf(SPELL_GLUTH_INFECTED_WOUND, true);
    }

    bool ChaseGluth()
    {
        if (!m_pInstance)
            return false;

        if (Creature* pGluth = m_pInstance->GetSingleCreatureFromStorage(NPC_GLUTH))
        {
            me->GetMotionMaster()->Clear();
            me->GetMotionMaster()->MoveFollow(pGluth, ATTACK_DISTANCE);
            me->SetTarget(ObjectGuid::Empty);
            return true;
        }
        return false;
    }

    // VMaNGOS SpellHit(Gluth, 28374); triggered from classic_boss_gluth::OnSpellCast
    void DoAction(int32 action) override
    {
        if (action != ACTION_GLUTH_ZOMBIE_DECIMATED)
            return;

        if (ChaseGluth())
        {
            DoCastSelf(SPELL_GLUTH_DECIMATE_OTHER, true);
            isHitByDecimate = true;
        }
    }

    void AttackStart(Unit* pWho) override
    {
        if (isHitByDecimate)
            return;
        ScriptedAI::AttackStart(pWho);
    }

    void UpdateAI(uint32 /*diff*/) override
    {
        if (isHitByDecimate)
        {
            // TC: MoveFollow is FOLLOW_MOTION_TYPE (VMaNGOS checks CHASE_MOTION_TYPE, which its follow does not use either)
            if (me->GetMotionMaster()->GetCurrentMovementGeneratorType() != FOLLOW_MOTION_TYPE)
            {
                ChaseGluth();
            }
            return;
        }

        if (!UpdateVictim())
            return;
    }
};

// 28375 - Decimate (Gluth)
class classic_spell_gluth_decimate : public SpellScript
{
    void HandleDamage(SpellEffIndex /*effIndex*/)
    {
        Unit* target = GetHitUnit();
        if (!target)
            return;

        // damage should put target at maximum 5% hp, but not reduce it below that
        SetHitDamage(std::max<int32>(0, int32(target->GetHealth()) - int32(target->GetMaxHealth() * 0.05f)));
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(classic_spell_gluth_decimate::HandleDamage, EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE);
    }
};

void AddSC_classic_boss_gluth()
{
    RegisterCreatureAI(classic_boss_gluth);
    RegisterCreatureAI(classic_mob_zombie_chow);
    RegisterSpellScript(classic_spell_gluth_decimate);
}
