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

// Classic 1.60 port of VMaNGOS src/scripts/eastern_kingdoms/burning_steppes/blackrock_depths/arena_challenge_ai.cpp
// (Blackrock Depths T0.5 Arena Challenge NPC AI, GPL-2)
// Ported: npc_theldren, npc_va_jashni, npc_korv, npc_lefty, npc_snokh_blackspine, npc_volida, npc_malgen_longspear

#include "Player.h"
#include "ScriptMgr.h"
#include "Map.h"
#include "MotionMaster.h"
#include "ScriptedCreature.h"
#include "TemporarySummon.h"

enum ArenaChallenge
{
    SPELL_THELDREN_MORTAL_STRIKE        = 17547,
    SPELL_THELDREN_CHARGE               = 22911,
    SPELL_THELDREN_INTIMIDATING_SHOUT   = 19134,

    SPELL_VA_JASHNI_FLASH_HEAL          = 17138,
    SPELL_VA_JASHNI_SHIELD              = 20697,
    SPELL_VA_JASHNI_RENEW               = 23895,

    SPELL_KORV_FROST_SHOCK              = 21401,
    SPELL_KORV_EARTHBIND_TOTEM          = 15786,
    // Fire Nova Totem 11314 is not in the 1.60 client. Vanilla 11314 summons totem 7844 for 5s (duration index 28),
    // which then explodes with Fire Nova 11307 (still in the client). Done by hand in classic_npc_korv.
    SPELL_KORV_FIRENOVA_TOTEM           = 11314,
    SPELL_KORV_FIRENOVA                 = 11307,
    NPC_KORV_FIRENOVA_TOTEM             = 7844,

    SPELL_LEFTY_FIVE_FAT_FINGERS        = 27673,

    SPELL_SNOKH_BLACKSPINE_PYROBLAST    = 17273,
    SPELL_SNOKH_BLACKSPINE_SCORCH       = 13878,
    SPELL_SNOKH_BLACKSPINE_FLAMESTRIKE  = 18399,
    SPELL_SNOKH_BLACKSPINE_POLYMORPH    = 13323,

    SPELL_VOLIDA_BLIZZARD               = 27618,
    SPELL_VOLIDA_CONEOFCOLD             = 12557,

    SPELL_MALGEN_LONGSPEAR_AIMED_SHOT   = 20902,
    SPELL_MALGEN_LONGSPEAR_MULTISHOT    = 20735,
    SPELL_MALGEN_LONGSPEAR_FEIGN_DEATH  = 5384,
    SPELL_MALGEN_LONGSPEAR_FROST_TRAP   = 13809,
    SPELL_MALGEN_LONGSPEAR_PET          = 19561,
    SPELL_MALGEN_LONGSPEAR_SHOOT        = 6660,

    NPC_MALGEN_LONGSPEAR_PET_GNASHJAW   = 16095
};

/*######
## npc_theldren
######*/

struct classic_npc_theldren : public ScriptedAI
{
    classic_npc_theldren(Creature* creature) : ScriptedAI(creature)
    {
        Initialize();
    }

    uint32 m_uiInterceptTimer;
    uint32 m_uiMortalStrikeTimer;
    uint32 m_uiFearTimer;

    void Initialize()
    {
        m_uiInterceptTimer = 10000;
        m_uiMortalStrikeTimer = 10000;
        m_uiFearTimer = 30000;
    }

    void Reset() override
    {
        Initialize();
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        if (m_uiInterceptTimer < diff)
        {
            Unit* target = GetPlayerAtMinimumRange(8.0f);

            if (target && DoCast(target, SPELL_THELDREN_CHARGE) == SPELL_CAST_OK)
                m_uiInterceptTimer = urand(20000, 30000);
        }
        else
            m_uiInterceptTimer -= diff;

        if (m_uiMortalStrikeTimer < diff)
        {
            if (DoCastVictim(SPELL_THELDREN_MORTAL_STRIKE) == SPELL_CAST_OK)
                m_uiMortalStrikeTimer = urand(8000, 15000);
        }
        else
            m_uiMortalStrikeTimer -= diff;

        if (m_uiFearTimer < diff)
        {
            if (DoCastVictim(SPELL_THELDREN_INTIMIDATING_SHOUT) == SPELL_CAST_OK)
                m_uiFearTimer = urand(30000, 40000);
        }
        else
            m_uiFearTimer -= diff;
    }
};

struct classic_npc_va_jashni : public ScriptedAI
{
    classic_npc_va_jashni(Creature* creature) : ScriptedAI(creature)
    {
        Initialize();
    }

    uint32 m_uiFlashHealTimer;
    uint32 m_uiShieldTimer;
    uint32 m_uiRenewTimer;

    void Initialize()
    {
        // The values on the heals are huge... Maybe wrong spells. If not, they
        // should have massive cooldowns
        m_uiFlashHealTimer = 10000;
        m_uiShieldTimer = 20000; // shield is 5000 health...
        m_uiRenewTimer = 30000;  // renew is 2000 health every 3 sec...
    }

    void Reset() override
    {
        Initialize();
    }

    void UpdateAI(uint32 diff) override
    {
        // VMaNGOS FindLowestHpFriendlyUnit(40.0f, 1)
        if (m_uiFlashHealTimer < diff)
        {
            Unit* target = DoSelectLowestHpFriendly(40.0f, 1);

            if (target && DoCast(target, SPELL_VA_JASHNI_FLASH_HEAL) == SPELL_CAST_OK)
                m_uiFlashHealTimer = urand(8000, 14000);
        }
        else
            m_uiFlashHealTimer -= diff;

        if (m_uiShieldTimer < diff)
        {
            Unit* target = DoSelectLowestHpFriendly(40.0f, 1);

            if (target && DoCast(target, SPELL_VA_JASHNI_SHIELD) == SPELL_CAST_OK)
                m_uiShieldTimer = urand(40000, 50000);
        }
        else
            m_uiShieldTimer -= diff;

        if (m_uiRenewTimer < diff)
        {
            Unit* target = DoSelectLowestHpFriendly(40.0f, 1);

            if (target && DoCast(target, SPELL_VA_JASHNI_RENEW) == SPELL_CAST_OK)
                m_uiRenewTimer = urand(55000, 65000);
        }
        else
            m_uiRenewTimer -= diff;

        if (!UpdateVictim())
            return;
    }
};

struct classic_npc_korv : public ScriptedAI
{
    classic_npc_korv(Creature* creature) : ScriptedAI(creature)
    {
        Initialize();
    }

    uint32 m_uiFrostShockTimer;
    uint32 m_uiEarthbindTimer;
    uint32 m_uiFireNovaTimer;

    void Initialize()
    {
        m_uiFrostShockTimer = 10000;
        m_uiEarthbindTimer = 20000;
        m_uiFireNovaTimer = 20000;
    }

    void Reset() override
    {
        Initialize();
    }

    // Replacement for SPELL_KORV_FIRENOVA_TOTEM (11314, missing from the 1.60 client): the totem lives 5s,
    // then casts Fire Nova around itself. Killing the totem first prevents the nova, as in vanilla.
    void SummonFireNovaTotem()
    {
        Position pos = me->GetNearPosition(2.0f, 0.0f);
        TempSummon* totem = me->SummonCreature(NPC_KORV_FIRENOVA_TOTEM, pos, TEMPSUMMON_TIMED_DESPAWN, 6s);
        if (!totem)
            return;

        totem->SetFaction(me->GetFaction());
        totem->SetLevel(me->GetLevel());
        totem->SetReactState(REACT_PASSIVE);
        totem->SetControlled(true, UNIT_STATE_ROOT);
        totem->m_Events.AddEventAtOffset([totem]()
        {
            if (totem->IsAlive())
            {
                totem->CastSpell(totem, SPELL_KORV_FIRENOVA, true);
                totem->DespawnOrUnsummon(500ms);
            }
        }, 5s);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        if (m_uiFrostShockTimer < diff)
        {
            // Spam dat frost shock on random players!
            Unit* target = SelectTarget(SelectTargetMethod::Random, 0);

            if (target && DoCast(target, SPELL_KORV_FROST_SHOCK) == SPELL_CAST_OK)
                m_uiFrostShockTimer = urand(10000, 12000);
        }
        else
            m_uiFrostShockTimer -= diff;

        if (m_uiEarthbindTimer < diff)
        {
            if (DoCastSelf(SPELL_KORV_EARTHBIND_TOTEM) == SPELL_CAST_OK)
                m_uiEarthbindTimer = 20000;
        }
        else
            m_uiEarthbindTimer -= diff;

        if (m_uiFireNovaTimer < diff)
        {
            if (!me->IsNonMeleeSpellCast(false))
            {
                SummonFireNovaTotem();
                m_uiFireNovaTimer = 20000;
            }
        }
        else
            m_uiFireNovaTimer -= diff;
    }
};

struct classic_npc_lefty : public ScriptedAI
{
    classic_npc_lefty(Creature* creature) : ScriptedAI(creature)
    {
        m_uiFiveFingerTimer = 2000;
    }

    uint32 m_uiFiveFingerTimer;

    void Reset() override
    {
        m_uiFiveFingerTimer = 2000;
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        if (m_uiFiveFingerTimer < diff)
        {
            if (DoCastVictim(SPELL_LEFTY_FIVE_FAT_FINGERS) == SPELL_CAST_OK)
                m_uiFiveFingerTimer = urand(2000, 3000);
        }
        else
            m_uiFiveFingerTimer -= diff;
    }
};

struct classic_npc_snokh_blackspine : public ScriptedAI
{
    classic_npc_snokh_blackspine(Creature* creature) : ScriptedAI(creature)
    {
        Initialize();
    }

    uint32 m_uiPyroblastTimer;
    uint32 m_uiScorchTimer;
    uint32 m_uiFlamestrikeTimer;
    uint32 m_uiPolymorphTimer;

    void Initialize()
    {
        m_uiPyroblastTimer = 15000;
        m_uiScorchTimer = 4000;
        m_uiFlamestrikeTimer = 20000;
        m_uiPolymorphTimer = 30000;
    }

    void Reset() override
    {
        Initialize();
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        if (m_uiPyroblastTimer < diff)
        {
            if (DoCastVictim(SPELL_SNOKH_BLACKSPINE_PYROBLAST) == SPELL_CAST_OK)
                m_uiPyroblastTimer = urand(10000, 20000);
        }
        else
            m_uiPyroblastTimer -= diff;

        if (m_uiScorchTimer < diff)
        {
            if (DoCastVictim(SPELL_SNOKH_BLACKSPINE_SCORCH) == SPELL_CAST_OK)
                m_uiScorchTimer = urand(3000, 5000);
        }
        else
            m_uiScorchTimer -= diff;

        if (m_uiFlamestrikeTimer < diff)
        {
            Unit* target = SelectTarget(SelectTargetMethod::Random, 0);

            if (target && DoCast(target, SPELL_SNOKH_BLACKSPINE_FLAMESTRIKE) == SPELL_CAST_OK)
                m_uiFlamestrikeTimer = urand(10000, 20000);
        }
        else
            m_uiFlamestrikeTimer -= diff;

        if (m_uiPolymorphTimer < diff)
        {
            Unit* target = SelectTarget(SelectTargetMethod::Random, 0);

            if (target && DoCast(target, SPELL_SNOKH_BLACKSPINE_POLYMORPH) == SPELL_CAST_OK)
                m_uiPolymorphTimer = urand(25000, 30000);
        }
        else
            m_uiPolymorphTimer -= diff;
    }
};

struct classic_npc_volida : public ScriptedAI
{
    classic_npc_volida(Creature* creature) : ScriptedAI(creature)
    {
        Initialize();
    }

    uint32 m_uiBlizzardTimer;
    uint32 m_uiConeOfColdTimer;

    void Initialize()
    {
        m_uiBlizzardTimer = 4000;
        m_uiConeOfColdTimer = 20000;
    }

    void Reset() override
    {
        Initialize();
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        if (m_uiBlizzardTimer < diff)
        {
            Unit* target = SelectTarget(SelectTargetMethod::Random, 0);

            if (target && DoCast(target, SPELL_VOLIDA_BLIZZARD) == SPELL_CAST_OK)
                m_uiBlizzardTimer = urand(14000, 18000);
        }
        else
            m_uiBlizzardTimer -= diff;

        if (m_uiConeOfColdTimer < diff)
        {
            if (DoCastVictim(SPELL_VOLIDA_CONEOFCOLD) == SPELL_CAST_OK)
                m_uiConeOfColdTimer = 20000;
        }
        else
            m_uiConeOfColdTimer -= diff;
    }
};

struct classic_npc_malgen_longspear : public ScriptedAI
{
    classic_npc_malgen_longspear(Creature* creature) : ScriptedAI(creature)
    {
        Initialize();
    }

    uint32 m_uiAimedShotTimer;
    uint32 m_uiMultiShotTimer;
    uint32 m_uiFeignDeathTimer;
    uint32 m_uiFrostTrapTimer;
    bool m_bIsFeigned;
    ObjectGuid m_petGuid;

    void Initialize()
    {
        m_uiAimedShotTimer = 8000;
        m_uiMultiShotTimer = 15000;
        m_uiFeignDeathTimer = 10000;
        m_uiFrostTrapTimer = 0;

        m_bIsFeigned = false;

        m_petGuid.Clear();
    }

    void Reset() override
    {
        Initialize();
    }

    void EnterEvadeMode(EvadeReason why) override
    {
        if (Creature* creature = me->GetMap()->GetCreature(m_petGuid))
        {
            creature->DespawnOrUnsummon();
            m_petGuid.Clear();
        }

        // TODO(classic): VMaNGOS overrides EnterEvadeMode without calling the base implementation (the creature never
        // really evades there); TC needs the base call to leave combat and go home.
        ScriptedAI::EnterEvadeMode(why);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        // Summon pet
        if (me->GetMap()->GetCreature(m_petGuid))
            return;

        if (Creature* pet = me->SummonCreature(NPC_MALGEN_LONGSPEAR_PET_GNASHJAW, me->GetPositionX(),
            me->GetPositionY(), me->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 10s))
        {
            m_petGuid = pet->GetGUID();
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (!m_bIsFeigned && !UpdateVictim())
            return;

        if (m_uiFeignDeathTimer < diff)
        {
            // Feign death, lay trap, re-acquire target
            if (DoCastSelf(SPELL_MALGEN_LONGSPEAR_FEIGN_DEATH, true) == SPELL_CAST_OK)
            {
                // Feign for 1 secs, then trap and repop
                m_bIsFeigned = true;
                m_uiFrostTrapTimer = 1000;
                m_uiFeignDeathTimer = urand(50000, 60000);
            }
        }
        else
            m_uiFeignDeathTimer -= diff;

        if (m_uiFrostTrapTimer)
        {
            if (m_uiFrostTrapTimer < diff)
            {
                me->RemoveAurasDueToSpell(SPELL_MALGEN_LONGSPEAR_FEIGN_DEATH);

                DoCastSelf(SPELL_MALGEN_LONGSPEAR_FROST_TRAP, true);
                m_uiFrostTrapTimer = 0;

                m_bIsFeigned = false;

                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                    me->GetMotionMaster()->MoveChase(target);
            }
            else
                m_uiFrostTrapTimer -= diff;
        }

        if (m_bIsFeigned)
            return;

        if (m_uiAimedShotTimer < diff)
        {
            Unit* target = GetPlayerAtMinimumRange(8.0f);

            if (target && DoCast(target, SPELL_MALGEN_LONGSPEAR_AIMED_SHOT) == SPELL_CAST_OK)
                m_uiAimedShotTimer = urand(18000, 24000);
        }
        else
            m_uiAimedShotTimer -= diff;

        if (m_uiMultiShotTimer < diff)
        {
            Unit* target = GetPlayerAtMinimumRange(8.0f);

            if (target && DoCast(target, SPELL_MALGEN_LONGSPEAR_MULTISHOT) == SPELL_CAST_OK)
                m_uiMultiShotTimer = 20000;
        }
        else
            m_uiMultiShotTimer -= diff;
    }
};

void AddSC_classic_arena_challenge_ai()
{
    RegisterCreatureAI(classic_npc_theldren);
    RegisterCreatureAI(classic_npc_va_jashni);
    RegisterCreatureAI(classic_npc_korv);
    RegisterCreatureAI(classic_npc_lefty);
    RegisterCreatureAI(classic_npc_snokh_blackspine);
    RegisterCreatureAI(classic_npc_volida);
    RegisterCreatureAI(classic_npc_malgen_longspear);
}
