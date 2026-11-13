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
 * You should have received a copy of the GNU General Public License
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

// Classic 1.60 port of VMaNGOS src/scripts/eastern_kingdoms/eastern_plaguelands/naxxramas/boss_anubrekhan.cpp (GPL-2)
// Scripts: boss_anubrekhan, mob_cryptguards, go_anub_door

#include "ObjectAccessor.h"
#include "Log.h"
#include "ScriptMgr.h"
#include "Creature.h"
#include "CreatureAI.h"
#include "GameObject.h"
#include "GameObjectAI.h"
#include "InstanceScript.h"
#include "Map.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellAuraDefines.h"
#include "TemporarySummon.h"
#include "ThreatManager.h"
#include "classic_naxxramas.h"
#include "classic_script_text.h"
#include <list>
#include <vector>

namespace
{
enum AnubrekhanData
{
    SAY_ANUB_GREET              = 13004,
    SAY_ANUB_AGGRO1             = 13000,
    SAY_ANUB_AGGRO2             = 13002,
    SAY_ANUB_AGGRO3             = 13003,
    SAY_ANUB_TAUNT1             = 13006,
    SAY_ANUB_TAUNT2             = 13007,
    SAY_ANUB_TAUNT3             = 13008,
    SAY_ANUB_TAUNT4             = 13009,
    SAY_ANUB_SLAY               = 13005,

    EMOTE_ANUB_GENERIC_ENRAGE   = 7798, // used by crypt guards

    SPELL_ANUB_IMPALE           = 28783,        //May be wrong spell id. Causes more dmg than I expect
    SPELL_ANUB_LOCUSTSWARM      = 28785,        //This is a self buff that triggers the dmg debuff

    SPELL_ANUB_SELF_SPAWN_5     = 29105,        // These spells should spawn corpse scarabs, but only show the explosion anim.
    SPELL_ANUB_SELF_SPAWN_10    = 28864,        // If we fix them to spawn scarbs, code must be changed to not manually spawn them too.

    SPELL_CRYPTGUARD_ENRAGE     = 28747,        // 50% attackspeed increase and 100 extra dmg on attack. PROBABLY WRONG SPELL!!!
    SPELL_CRYPTGUARD_CLEAVE     = 26350,        // could be wrong spell.
    SPELL_CRYPTGUARD_WEB        = 28991,
    SPELL_CRYPTGUARD_ACID       = 28969,

    MOB_CRYPT_GUARD             = 16573,
    MOB_CORPSE_SCARAB           = 16698
};

float const CGs[3][4] =
{
    { 3291.26f, -3502.08f, 287.26f, 2.14f },
    { 3285.29f, -3446.64f, 287.26f, 4.2f },
    { 3316.46f, -3476.23f, 287.26f, 3.18f } // this third entry is used as spawn loc during fight.
};

constexpr uint32 CRYPTGUARD_CLEAVE_CD    = 6000;  // Todo: find correct timer
constexpr uint32 CRYPTGUARD_WEB_CD       = 12000; // 10 second duration, so 12sec cd makes sense.
                                                  // From videos you can see there is 1-2sec between consecutive nets.
constexpr uint32 CRYPTGUARD_ACID_CD      = 5000;  // Todo: find correct timer.

// Best guess so far is random between 12 and 18 seconds (see VMaNGOS source for the research notes).
// Timer does not seem to reset after locust swarm, but rather continue from whatever it was when locust started.
uint32 IMPALE_CD() { return urand(12000, 18000); }

// Locust Swarm: 80-120 sec for initial locust, 90-110 for any after that (see VMaNGOS source for the research notes).
uint32 LOCUST_SWARM_CD(bool initial) { return initial ? urand(80000, 120000) : urand(90000, 110000); }
}

struct classic_boss_anubrekhan : public ScriptedAI
{
    classic_instance_naxxramas_InstanceScript* m_pInstance;

    uint32 m_uiImpaleTimer;
    uint32 m_uiLocustSwarmTimer;
    uint32 m_uiCorpseExplosionTimer;
    uint32 m_uiRestoreTargetTimer;
    bool m_firstBlood;

    std::vector<ObjectGuid> deadCryptGuards;
    std::vector<ObjectGuid> summonedCryptGuards;

    classic_boss_anubrekhan(Creature* pCreature) : ScriptedAI(pCreature), m_pInstance(GetClassicNaxxInstance(pCreature)),
        m_uiImpaleTimer(0), m_uiLocustSwarmTimer(0), m_uiCorpseExplosionTimer(0), m_uiRestoreTargetTimer(0), m_firstBlood(false)
    {
        if (!m_pInstance)
            TC_LOG_ERROR("scripts", "classic_boss_anubrekhan::ctor failed to get classic_instance_naxxramas");
    }

    // VMaNGOS spawned the initial crypt guards from the AI constructor; TC: once the creature is in the world
    void JustAppeared() override
    {
        ScriptedAI::JustAppeared();
        CheckSpawnInitialCryptGuards();
    }

    void CheckSpawnInitialCryptGuards()
    {
        if (!m_pInstance || m_pInstance->GetData(TYPE_ANUB_REKHAN) == DONE)
            return;

        for (int i = 0; i < 2; i++)
        {
            // While the crypt guard will be despawned manually after CRYPTGUARD_DESPAWN time, when it explodes,
            // we make it a TEMPSUMMON_CORPSE_TIMED_DESPAWN with a slightly longer duration, because if anub is killed
            // before the last crypt guard dies, anubs updateAI will not be able to manually explode and despawn it.
            if (Creature* c = me->SummonCreature(MOB_CRYPT_GUARD, CGs[i][0], CGs[i][1], CGs[i][2], CGs[i][3], TEMPSUMMON_MANUAL_DESPAWN))
                summonedCryptGuards.push_back(c->GetGUID());
            else
                TC_LOG_ERROR("scripts", "classic_boss_anubrekhan::CheckSpawnInitialCryptGuards failed to spawn initial crypt guard");
        }
    }

    void SummonedCreatureDies(Creature* pSummoned, Unit* /*killer*/) override
    {
        if (pSummoned->GetEntry() != MOB_CRYPT_GUARD)
            return;
        deadCryptGuards.push_back(pSummoned->GetGUID());
    }

    void Reset() override
    {
        m_uiImpaleTimer = IMPALE_CD();
        m_uiLocustSwarmTimer = LOCUST_SWARM_CD(true);
        m_uiCorpseExplosionTimer = urand(20000, 80000);
        m_firstBlood = false;
        m_uiRestoreTargetTimer = 0;

        if (!me->IsInWorld())
            return;

        std::list<Creature*> scarabs;
        me->GetCreatureListWithEntryInGrid(scarabs, MOB_CORPSE_SCARAB, 300.0f);
        for (auto it = scarabs.begin(); it != scarabs.end();)
        {
            if (scarabs.size() < 31)
                break;
            (*it)->DespawnOrUnsummon();
            it = scarabs.erase(it);
        }
    }

    void JustReachedHome() override
    {
        if (m_pInstance)
            m_pInstance->SetData(TYPE_ANUB_REKHAN, FAIL);

        // despawn any summoned cryptguards that stil exist
        for (ObjectGuid const& guid : summonedCryptGuards)
            if (Creature* cg = ObjectAccessor::GetCreature(*me, guid))
                cg->DespawnOrUnsummon();
        summonedCryptGuards.clear();

        // despawn any remaining corpses
        for (ObjectGuid const& guid : deadCryptGuards)
            if (Creature* cg = ObjectAccessor::GetCreature(*me, guid))
                cg->DespawnOrUnsummon();
        deadCryptGuards.clear();

        // respawn the two initial guards
        CheckSpawnInitialCryptGuards();
    }

    void KilledUnit(Unit* pVictim) override
    {
        // Scarabs are summoned by instance script when a player dies.
        // See classic_instance_naxxramas_InstanceScript::OnPlayerDeath(Player*)
        if (pVictim->GetTypeId() != TYPEID_PLAYER)
            return;

        if (!m_firstBlood)
        {
            ClassicScriptText(SAY_ANUB_SLAY, me);
            m_firstBlood = true;
            return;
        }
    }

    void JustEngagedWith(Unit* pWho) override
    {
        if (!m_pInstance)
            return;
        m_pInstance->SetData(TYPE_ANUB_REKHAN, IN_PROGRESS);
        // Setting in combat with zone and pulling the two crypt-guards
        DoZoneInCombat();

        for (ObjectGuid const& guid : summonedCryptGuards)
        {
            if (Creature* cg = ObjectAccessor::GetCreature(*me, guid))
            {
                if (cg->IsAIEnabled())
                    cg->AI()->AttackStart(pWho);
                CreatureAI::DoZoneInCombat(cg);
            }
        }

        static uint32 const aggroTexts[3] = { SAY_ANUB_AGGRO1, SAY_ANUB_AGGRO2, SAY_ANUB_AGGRO3 };
        ClassicScriptText(aggroTexts[urand(0, 2)], me);
    }

    void JustDied(Unit* /*pKiller*/) override
    {
        if (m_pInstance)
            m_pInstance->SetData(TYPE_ANUB_REKHAN, DONE);
    }

    void MoveInLineOfSight(Unit* pWho) override
    {
        if (pWho->GetTypeId() == TYPEID_PLAYER
            && !me->IsInCombat()
            && me->IsWithinDistInMap(pWho, 55.0f)
            && !pWho->HasAuraType(SPELL_AURA_FEIGN_DEATH))
        {
            AttackStart(pWho);
        }

        ScriptedAI::MoveInLineOfSight(pWho);
    }

    // The summoned corpse scarab will attack a random target, and add 5k threat to it.
    // The threat amount is a guess, but it can be seen in videos, and it's mentioned on wowhead,
    // that the scarab will "stick" to it's chosen target for quite a while, if not until dead.
    static void EngageCorpseScarab(Creature* cs)
    {
        CreatureAI::DoZoneInCombat(cs);
        if (!cs->IsAIEnabled())
            return;
        if (Unit* csTarget = cs->AI()->SelectTarget(SelectTargetMethod::Random, 0))
        {
            cs->AI()->AttackStart(csTarget);
            cs->GetThreatManager().AddThreat(csTarget, 5000.0f);
        }
    }

    bool ExplodeOneDeadCryptGuard()
    {
        if (deadCryptGuards.empty())
            return false;

        size_t idx = urand(0, uint32(deadCryptGuards.size() - 1));
        ObjectGuid deadCryptGuard = deadCryptGuards[idx];
        deadCryptGuards.erase(deadCryptGuards.begin() + idx);

        if (Creature* cg = ObjectAccessor::GetCreature(*me, deadCryptGuard))
        {
            // The cryptguard casts SPELL_SELF_SPAWN_10 on itself. The spell is bugged and
            // wont spawn any adds, but it will show the visual.
            // TODO(classic): VMaNGOS cg->SendSpellGo(cg, SPELL_SELF_SPAWN_10) (visual only); no TC equivalent
            // Manually summoning 10 corpse scarabs under the Crypt Guard
            for (int i = 0; i < 10; i++)
            {
                if (Creature* cs = me->SummonCreature(MOB_CORPSE_SCARAB, cg->GetPositionX(), cg->GetPositionY(), cg->GetPositionZ(), 0.0f, TEMPSUMMON_CORPSE_DESPAWN))
                    EngageCorpseScarab(cs);
            }

            // Despawning the Crypt guard
            cg->DespawnOrUnsummon(250ms);
            return true;
        }
        return false;
    }

    void RestoreTarget()
    {
        if (Unit* victim = me->GetVictim())
        {
            me->SetFacingToObject(victim);
            me->SetTarget(victim->GetGUID());
        }
        m_uiRestoreTargetTimer = 0;
    }

    void UpdateAI(uint32 uiDiff) override
    {
        if (!UpdateVictim())
            return;

        if (m_pInstance && !m_pInstance->HandleEvadeOutOfHome(me))
            return;

        if (m_uiRestoreTargetTimer)
        {
            if (m_uiRestoreTargetTimer <= uiDiff)
                RestoreTarget();
            else
                m_uiRestoreTargetTimer -= uiDiff;
        }

        // Impale
        // todo: Not sure if the timer should keep running, be paused or reset during locust swarm.
        //       Currently the timer will simply be paused when locust swarm is active, or being cast
        if (!me->HasAura(SPELL_ANUB_LOCUSTSWARM) && !me->IsNonMeleeSpellCast(false))
        {
            if (m_uiImpaleTimer < uiDiff)
            {
                // Do NOT cast it when we are afflicted by locust swarm
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                {
                    me->SetFacingToObject(target);
                    me->SetTarget(target->GetGUID());
                    m_uiRestoreTargetTimer = 1000;
                    m_uiImpaleTimer = IMPALE_CD();
                    DoCast(target, SPELL_ANUB_IMPALE);
                }
            }
            else
                m_uiImpaleTimer -= uiDiff;
        }

        if (m_uiCorpseExplosionTimer < uiDiff)
        {
            if (ExplodeOneDeadCryptGuard())
                m_uiCorpseExplosionTimer = urand(20000, 80000);
            else
                m_uiCorpseExplosionTimer = urand(10000, 20000);
        }
        else
            m_uiCorpseExplosionTimer -= uiDiff;

        // Locust Swarm
        if (m_uiLocustSwarmTimer < uiDiff)
        {
            // restore target at once if we have just done an impale
            if (m_uiRestoreTargetTimer)
                RestoreTarget();

            // Reset cd and summon a new crypt guard at the initial possition of anub'rekhan on successfull cast
            if (DoCastSelf(SPELL_ANUB_LOCUSTSWARM) == SPELL_CAST_OK)
            {
                m_uiLocustSwarmTimer = LOCUST_SWARM_CD(false);
                if (Creature* pCryptGuard = me->SummonCreature(MOB_CRYPT_GUARD, CGs[2][0], CGs[2][1], CGs[2][2], CGs[2][3], TEMPSUMMON_MANUAL_DESPAWN))
                {
                    summonedCryptGuards.push_back(pCryptGuard->GetGUID());

                    CreatureAI::DoZoneInCombat(pCryptGuard);
                    if (pCryptGuard->IsAIEnabled())
                        if (Unit* pCryptTarget = pCryptGuard->AI()->SelectTarget(SelectTargetMethod::Random, 0))
                            pCryptGuard->AI()->AttackStart(pCryptTarget);
                }
            }
        }
        else
            m_uiLocustSwarmTimer -= uiDiff;
    }
};

struct classic_mob_cryptguards : public ScriptedAI
{
    classic_instance_naxxramas_InstanceScript* m_pInstance;
    bool isEnraged;
    uint32 webTimer;
    uint32 acidSpitTimer;
    uint32 cleaveTimer;

    classic_mob_cryptguards(Creature* pCreature) : ScriptedAI(pCreature), m_pInstance(GetClassicNaxxInstance(pCreature))
    {
        isEnraged = false;
        webTimer = CRYPTGUARD_WEB_CD;
        acidSpitTimer = CRYPTGUARD_ACID_CD;
        cleaveTimer = CRYPTGUARD_CLEAVE_CD;
    }

    void Reset() override
    {
        isEnraged = false;

        webTimer        = CRYPTGUARD_WEB_CD;
        acidSpitTimer   = CRYPTGUARD_ACID_CD;
        cleaveTimer     = CRYPTGUARD_CLEAVE_CD;
    }

    void JustEngagedWith(Unit* pWho) override
    {
        // Make sure anub is pulled too. Anub will take care of pulling the other crypt-guard
        if (m_pInstance)
            if (Creature* anub = m_pInstance->GetSingleCreatureFromStorage(NPC_ANUB_REKHAN))
                if (anub->IsAIEnabled())
                    anub->AI()->AttackStart(pWho);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        // Crypt guards enrage at 50%
        if (!isEnraged && me->GetHealthPct() <= 50.0f)
        {
            if (DoCastSelf(SPELL_CRYPTGUARD_ENRAGE) == SPELL_CAST_OK)
            {
                ClassicScriptText(EMOTE_ANUB_GENERIC_ENRAGE, me);
                isEnraged = true;
            }
        }

        if (webTimer < diff)
        {
            if (DoCastSelf(SPELL_CRYPTGUARD_WEB) == SPELL_CAST_OK)
            {
                ResetThreatList();
                webTimer = CRYPTGUARD_WEB_CD;
            }
        }
        else
            webTimer -= diff;

        if (cleaveTimer < diff)
        {
            if (DoCastVictim(SPELL_CRYPTGUARD_CLEAVE) == SPELL_CAST_OK)
                cleaveTimer = CRYPTGUARD_CLEAVE_CD;
        }
        else
            cleaveTimer -= diff;

        if (acidSpitTimer < diff)
        {
            if (DoCastVictim(SPELL_CRYPTGUARD_ACID) == SPELL_CAST_OK)
                acidSpitTimer = CRYPTGUARD_ACID_CD;
        }
        else
            acidSpitTimer -= diff;
    }
};

// VMaNGOS GameObjectAI::OnUse -> TC OnGossipHello (called at the start of GameObject::Use; false = default use)
struct classic_go_anub_door : public GameObjectAI
{
    bool haveDoneIntro;
    classic_instance_naxxramas_InstanceScript* m_pInstance;

    classic_go_anub_door(GameObject* pGo) : GameObjectAI(pGo), haveDoneIntro(false), m_pInstance(GetClassicNaxxInstance(pGo))
    {
        if (!m_pInstance)
            TC_LOG_ERROR("scripts", "classic_go_anub_door could not find instanceData");
    }

    bool OnGossipHello(Player* /*user*/) override
    {
        if (haveDoneIntro)
            return false;

        haveDoneIntro = true;

        if (!m_pInstance)
            return false;

        // Not entirely sure if anub should be able to do all of these SAY_TAUNT* texts on door-open.
        // Wowwiki seems quite sure of it, but it makes more sense if it's just the GREET being used
        // on door open, while the rest are said at random points during the fight?
        if (Creature* anubRekhan = m_pInstance->GetSingleCreatureFromStorage(NPC_ANUB_REKHAN))
        {
            static uint32 const greetTexts[5] = { SAY_ANUB_GREET, SAY_ANUB_TAUNT1, SAY_ANUB_TAUNT2, SAY_ANUB_TAUNT3, SAY_ANUB_TAUNT4 };
            if (anubRekhan->IsAlive())
                ClassicScriptText(greetTexts[urand(0, 4)], anubRekhan);
        }
        me->SetFlag(GO_FLAG_NOT_SELECTABLE);
        return false;
    }
};

void AddSC_classic_boss_anubrekhan()
{
    RegisterCreatureAI(classic_boss_anubrekhan);
    RegisterCreatureAI(classic_mob_cryptguards);
    RegisterGameObjectAI(classic_go_anub_door);
}
