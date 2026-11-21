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

// Classic 1.60 (Forever): Alcaz Prison (map 2994, levels 50-55). Encounters from the 70938 DungeonEncounter.db2:
// 3403 Overseer Wrex, 3410 Tidemistress Ca'zass, 3418 Katerina the Cleaner, 3415 The Questioner, 3409 Blazeroar.
//
// Which spells each boss casts, who stands with whom, and Blazeroar's disguise are from Everlake's Forever dungeon
// work (github.com/buildthehomelab, GPL); every spell id was checked in our 70938 client (SpellName and SpellEffect).
// This file is our own code. INFERRED (no sniff or combat log exists yet): every timer, the targets picked, and the
// damage values we set where the client's own value is far off for a level 50-55 group (each one says so below).
//
//   Overseer Wrex: Battle Shout, Mortal Strike. His Slavering Hounds join him (INFERRED).
//   Tidemistress Ca'zass: Frostbolt Volley, Frost Nova, Blizzard. Two Strashaz Enchantresses join her.
//   Katerina the Cleaner: Deadly Poison, Grievous Garrote. Two Alcaz Chaplains join her.
//   The Questioner: Rend, Drain Life. No adds.
//   Blazeroar: fights as Zarla Ober (his Illusion 1267176 turns him into creature 255707) with Fireball and Flamestrike.
//     At 30% he casts Reveal Form 1275847, which takes the Illusion off and heals him in full, then fights as the dragon:
//     Thrash, Flame Breath, Fear, Searing Scales, and Enrage.
//
// Ca'zass's live Blizzard (1271375) makes area trigger 40774, which is neither in the client nor in any server data we
// have, so it would do nothing. She casts the older NPC Blizzard 8364 (a ground area with frost damage) instead.

#include "ScriptMgr.h"
#include "Creature.h"
#include "InstanceScript.h"
#include "Map.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellInfo.h"
#include "classic_dungeon_encounter_tracker.h"
#include <list>

namespace
{
constexpr uint32 CLASSIC_ALCAZ_MAP_ID = 2994;

enum ClassicAlcazBosses : uint32
{
    CALC_ENC_WREX = 0,
    CALC_ENC_CAZASS = 1,
    CALC_ENC_KATERINA = 2,
    CALC_ENC_QUESTIONER = 3,
    CALC_ENC_BLAZEROAR = 4,
    CALC_ENC_MAX
};

enum ClassicAlcazCreatures : uint32
{
    NPC_ALCAZ_WREX = 255391,
    NPC_ALCAZ_CAZASS = 255997,
    NPC_ALCAZ_KATERINA = 257016,
    NPC_ALCAZ_QUESTIONER = 256236,
    NPC_ALCAZ_BLAZEROAR = 255702,
    NPC_ALCAZ_SLAVERING_HOUND = 255267,
    NPC_ALCAZ_STRASHAZ_ENCHANTRESS = 255373,
    NPC_ALCAZ_CHAPLAIN = 255262
};

enum ClassicAlcazSpells : uint32
{
    // all present in the 70938 client
    SPELL_ALCAZ_BATTLE_SHOUT = 9128,
    SPELL_ALCAZ_MORTAL_STRIKE = 16856,
    SPELL_ALCAZ_FROSTBOLT_VOLLEY = 8398,        // effect 1: frost damage to enemies around the caster
    SPELL_ALCAZ_FROST_NOVA = 15532,
    SPELL_ALCAZ_BLIZZARD = 8364,                // ground area, periodic frost damage (see the note at the top)
    SPELL_ALCAZ_DEADLY_POISON = 3583,
    SPELL_ALCAZ_GRIEVOUS_GARROTE = 1271761,     // effect 1: bleed every 3 s
    SPELL_ALCAZ_REND = 12054,
    SPELL_ALCAZ_DRAIN_LIFE = 17620,
    SPELL_ALCAZ_ILLUSION = 1267176,             // transform into creature 255707 (Zarla Ober)
    SPELL_ALCAZ_REVEAL_FORM = 1275847,          // removes 1267176, heals the caster 100%
    SPELL_ALCAZ_FIREBALL = 12466,
    SPELL_ALCAZ_FLAMESTRIKE = 18399,
    SPELL_ALCAZ_THRASH = 3391,
    SPELL_ALCAZ_FLAME_BREATH = 9573,            // cone in front
    SPELL_ALCAZ_ENRAGE = 15716,
    SPELL_ALCAZ_FEAR = 1271593,                 // fear on enemies around the caster
    SPELL_ALCAZ_SEARING_SCALES = 1271604        // fire damage every 3 s on enemies around the caster
};

constexpr ClassicDungeonBossEntry ClassicAlcazBossEntries[] =
{
    { CALC_ENC_WREX, NPC_ALCAZ_WREX },
    { CALC_ENC_CAZASS, NPC_ALCAZ_CAZASS },
    { CALC_ENC_KATERINA, NPC_ALCAZ_KATERINA },
    { CALC_ENC_QUESTIONER, NPC_ALCAZ_QUESTIONER },
    { CALC_ENC_BLAZEROAR, NPC_ALCAZ_BLAZEROAR }
};

// Frostbolt Volley 8398, Blizzard 8364 and Flame Breath 9573 are legacy spells with vanilla rows (classic_spell_value), which
// SpellEffectInfo::CalcValue grows to the caster's level as VMaNGOS does, a value set at the cast included: Volley 233 x the creature
// level scale (3.0 from spell level 20 to Ca'zass's 52) = ~700 to everyone in range, Blizzard 4 + 4 a level = 208 a tick at 52, Flame
// Breath 10 + 10 a level = 550 at Blazeroar's 55. They are cast with their own numbers. Our values 550, 220 and 900 went through the
// same growth on top: the Volley hit for 1615 and killed the healer (alcaz_full af54, 20 Nov), Blizzard ticked ~430.
// INFERRED damage values, only for the Forever spells, whose client values are percentages that do not fit a level 50-55 group:
constexpr int32 AlcazGarroteBleed = 120;        // client: 10 per tick
constexpr int32 AlcazSearingScalesTick = 200;   // client: 5 per tick

constexpr uint8 AlcazRevealPct = 30;

// a client spell, triggered, with our own value in one effect
void AlcazCast(Creature* me, Unit* target, uint32 spellId, SpellValueModFloat effect, int32 value)
{
    CastSpellExtraArgs args(TRIGGERED_FULL_MASK);
    args.AddSpellMod(effect, value);
    me->CastSpell(target, spellId, args);
}

// the creatures standing next to a boss join its fight
void AlcazCallGuards(Creature* me, uint32 entry, float range, Unit* who)
{
    if (!who)
        return;
    std::list<Creature*> guards;
    me->GetCreatureListWithEntryInGrid(guards, entry, range);
    for (Creature* guard : guards)
        if (guard->IsAlive() && !guard->IsEngaged())
            guard->AI()->AttackStart(who);
}
}

class classic_instance_alcaz_prison : public InstanceMapScript
{
public:
    classic_instance_alcaz_prison() : InstanceMapScript("classic_instance_alcaz_prison", CLASSIC_ALCAZ_MAP_ID) { }

    struct classic_instance_alcaz_prison_InstanceScript : public InstanceScript
    {
        classic_instance_alcaz_prison_InstanceScript(InstanceMap* map) : InstanceScript(map)
        {
            SetHeaders("CALC");
            SetBossNumber(CALC_ENC_MAX);
            static constexpr DungeonEncounterData encounters[] =
            {
                { CALC_ENC_WREX, {{ 3403 }} },
                { CALC_ENC_CAZASS, {{ 3410 }} },
                { CALC_ENC_KATERINA, {{ 3418 }} },
                { CALC_ENC_QUESTIONER, {{ 3415 }} },
                { CALC_ENC_BLAZEROAR, {{ 3409 }} }
            };
            LoadDungeonEncounterData(encounters);
        }

        ClassicDungeonEncounterTracker _encounterTracker{ *this, ClassicAlcazBossEntries };

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
        return new classic_instance_alcaz_prison_InstanceScript(map);
    }
};

// ---------------------------------------------------------------------------------------------------------------------
// Overseer Wrex: Battle Shout on himself and Mortal Strike on the tank.
struct classic_boss_alcaz_wrex : public ScriptedAI
{
    classic_boss_alcaz_wrex(Creature* creature) : ScriptedAI(creature) { }

    enum : uint32 { EV_BATTLE_SHOUT = 1, EV_MORTAL_STRIKE };

    void Reset() override { _events.Reset(); }

    void JustEngagedWith(Unit* who) override
    {
        AlcazCallGuards(me, NPC_ALCAZ_SLAVERING_HOUND, 15.0f, who);
        _events.ScheduleEvent(EV_BATTLE_SHOUT, 1s);     // INFERRED timers
        _events.ScheduleEvent(EV_MORTAL_STRIKE, 6s);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;
        _events.Update(diff);
        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        while (uint32 ev = _events.ExecuteEvent())
        {
            switch (ev)
            {
                case EV_BATTLE_SHOUT: DoCastSelf(SPELL_ALCAZ_BATTLE_SHOUT, CastSpellExtraArgs(TRIGGERED_FULL_MASK)); _events.Repeat(25s, 30s); break;
                case EV_MORTAL_STRIKE: DoCastVictim(SPELL_ALCAZ_MORTAL_STRIKE); _events.Repeat(7s, 10s); break;
                default: break;
            }
        }
    }

private:
    EventMap _events;
};

// Tidemistress Ca'zass: Frostbolt Volley and Frost Nova around her, Blizzard under someone at random.
struct classic_boss_alcaz_cazass : public ScriptedAI
{
    classic_boss_alcaz_cazass(Creature* creature) : ScriptedAI(creature) { }

    enum : uint32 { EV_VOLLEY = 1, EV_NOVA, EV_BLIZZARD };

    void Reset() override { _events.Reset(); }

    void JustEngagedWith(Unit* who) override
    {
        AlcazCallGuards(me, NPC_ALCAZ_STRASHAZ_ENCHANTRESS, 15.0f, who);
        _events.ScheduleEvent(EV_VOLLEY, 8s);           // INFERRED timers
        _events.ScheduleEvent(EV_NOVA, 12s);
        _events.ScheduleEvent(EV_BLIZZARD, 5s);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;
        _events.Update(diff);
        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        while (uint32 ev = _events.ExecuteEvent())
        {
            switch (ev)
            {
                case EV_VOLLEY:
                    DoCastSelf(SPELL_ALCAZ_FROSTBOLT_VOLLEY, CastSpellExtraArgs(TRIGGERED_FULL_MASK));
                    _events.Repeat(14s, 18s);
                    break;
                case EV_NOVA: DoCastSelf(SPELL_ALCAZ_FROST_NOVA, CastSpellExtraArgs(TRIGGERED_FULL_MASK)); _events.Repeat(16s, 20s); break;
                case EV_BLIZZARD:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 40.0f, true))
                        me->CastSpell(target->GetPosition(), SPELL_ALCAZ_BLIZZARD, CastSpellExtraArgs(TRIGGERED_FULL_MASK));
                    _events.Repeat(12s, 16s);
                    break;
                default: break;
            }
        }
    }

private:
    EventMap _events;
};

// Katerina the Cleaner: Deadly Poison and Grievous Garrote on the tank.
struct classic_boss_alcaz_katerina : public ScriptedAI
{
    classic_boss_alcaz_katerina(Creature* creature) : ScriptedAI(creature) { }

    enum : uint32 { EV_POISON = 1, EV_GARROTE };

    void Reset() override { _events.Reset(); }

    void JustEngagedWith(Unit* who) override
    {
        AlcazCallGuards(me, NPC_ALCAZ_CHAPLAIN, 15.0f, who);
        _events.ScheduleEvent(EV_POISON, 4s);           // INFERRED timers
        _events.ScheduleEvent(EV_GARROTE, 8s);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;
        _events.Update(diff);
        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        while (uint32 ev = _events.ExecuteEvent())
        {
            switch (ev)
            {
                case EV_POISON: DoCastVictim(SPELL_ALCAZ_DEADLY_POISON, CastSpellExtraArgs(TRIGGERED_FULL_MASK)); _events.Repeat(8s, 11s); break;
                case EV_GARROTE:
                    AlcazCast(me, me->GetVictim(), SPELL_ALCAZ_GRIEVOUS_GARROTE, SPELLVALUE_BASE_POINT1, AlcazGarroteBleed);
                    _events.Repeat(15s, 19s);
                    break;
                default: break;
            }
        }
    }

private:
    EventMap _events;
};

// The Questioner: Rend on the tank, Drain Life on someone at random.
struct classic_boss_alcaz_questioner : public ScriptedAI
{
    classic_boss_alcaz_questioner(Creature* creature) : ScriptedAI(creature) { }

    enum : uint32 { EV_REND = 1, EV_DRAIN_LIFE };

    void Reset() override { _events.Reset(); }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _events.ScheduleEvent(EV_REND, 3s);             // INFERRED timers
        _events.ScheduleEvent(EV_DRAIN_LIFE, 8s);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;
        _events.Update(diff);
        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        while (uint32 ev = _events.ExecuteEvent())
        {
            switch (ev)
            {
                case EV_REND: DoCastVictim(SPELL_ALCAZ_REND, CastSpellExtraArgs(TRIGGERED_FULL_MASK)); _events.Repeat(12s, 15s); break;
                case EV_DRAIN_LIFE:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 30.0f, true))
                        DoCast(target, SPELL_ALCAZ_DRAIN_LIFE);
                    _events.Repeat(14s, 18s);
                    break;
                default: break;
            }
        }
    }

private:
    EventMap _events;
};

// Blazeroar: Zarla Ober first (Fireball, Flamestrike), Reveal Form at 30% (full heal), then the dragon.
struct classic_boss_alcaz_blazeroar : public ScriptedAI
{
    classic_boss_alcaz_blazeroar(Creature* creature) : ScriptedAI(creature) { }

    enum : uint32
    {
        EV_FIREBALL = 1, EV_FLAMESTRIKE,
        EV_THRASH, EV_FLAME_BREATH, EV_FEAR, EV_SEARING_SCALES, EV_ENRAGE
    };
    enum : uint8 { PHASE_ZARLA = 1, PHASE_DRAGON = 2 };

    void JustAppeared() override
    {
        ScriptedAI::JustAppeared();
        PutOnIllusion();
    }

    void Reset() override
    {
        _events.Reset();
        _revealed = false;
        PutOnIllusion();
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _events.SetPhase(PHASE_ZARLA);
        _events.ScheduleEvent(EV_FIREBALL, 2s, 0, PHASE_ZARLA);         // INFERRED timers
        _events.ScheduleEvent(EV_FLAMESTRIKE, 9s, 0, PHASE_ZARLA);
    }

    void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*type*/, SpellInfo const* /*spellInfo*/) override
    {
        if (_revealed)
            return;

        // the disguise always comes off before he can die
        if (damage >= me->GetHealth())
            damage = me->GetHealth() - 1;

        if (me->HealthBelowPctDamaged(AlcazRevealPct, damage))
        {
            _revealed = true;
            me->InterruptNonMeleeSpells(false);
            DoCastSelf(SPELL_ALCAZ_REVEAL_FORM, CastSpellExtraArgs(TRIGGERED_FULL_MASK));
            _events.SetPhase(PHASE_DRAGON);
            _events.ScheduleEvent(EV_THRASH, 4s, 0, PHASE_DRAGON);       // INFERRED timers
            _events.ScheduleEvent(EV_FLAME_BREATH, 7s, 0, PHASE_DRAGON);
            _events.ScheduleEvent(EV_SEARING_SCALES, 10s, 0, PHASE_DRAGON);
            _events.ScheduleEvent(EV_FEAR, 18s, 0, PHASE_DRAGON);
            _events.ScheduleEvent(EV_ENRAGE, 45s, 0, PHASE_DRAGON);
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;
        _events.Update(diff);
        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        while (uint32 ev = _events.ExecuteEvent())
        {
            switch (ev)
            {
                case EV_FIREBALL:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 40.0f, true))
                        DoCast(target, SPELL_ALCAZ_FIREBALL);
                    _events.Repeat(5s, 7s);
                    break;
                case EV_FLAMESTRIKE:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 40.0f, true))
                        me->CastSpell(target->GetPosition(), SPELL_ALCAZ_FLAMESTRIKE, CastSpellExtraArgs());
                    _events.Repeat(14s, 18s);
                    break;
                case EV_THRASH: DoCastSelf(SPELL_ALCAZ_THRASH, CastSpellExtraArgs(TRIGGERED_FULL_MASK)); _events.Repeat(8s, 12s); break;
                case EV_FLAME_BREATH:
                    DoCastVictim(SPELL_ALCAZ_FLAME_BREATH, CastSpellExtraArgs(TRIGGERED_FULL_MASK));
                    _events.Repeat(12s, 15s);
                    break;
                case EV_SEARING_SCALES:
                    AlcazCast(me, me, SPELL_ALCAZ_SEARING_SCALES, SPELLVALUE_BASE_POINT0, AlcazSearingScalesTick);
                    _events.Repeat(20s, 25s);
                    break;
                case EV_FEAR: DoCastSelf(SPELL_ALCAZ_FEAR, CastSpellExtraArgs(TRIGGERED_FULL_MASK)); _events.Repeat(25s, 30s); break;
                case EV_ENRAGE: DoCastSelf(SPELL_ALCAZ_ENRAGE, CastSpellExtraArgs(TRIGGERED_FULL_MASK)); _events.Repeat(45s); break;
                default: break;
            }
        }
    }

private:
    void PutOnIllusion()
    {
        if (me->IsAlive() && me->IsInWorld() && !me->HasAura(SPELL_ALCAZ_ILLUSION))
            DoCastSelf(SPELL_ALCAZ_ILLUSION, CastSpellExtraArgs(TRIGGERED_FULL_MASK));
    }

    EventMap _events;
    bool _revealed = false;
};

void AddSC_classic_instance_alcaz_prison()
{
    new classic_instance_alcaz_prison();
    RegisterCreatureAI(classic_boss_alcaz_wrex);
    RegisterCreatureAI(classic_boss_alcaz_cazass);
    RegisterCreatureAI(classic_boss_alcaz_katerina);
    RegisterCreatureAI(classic_boss_alcaz_questioner);
    RegisterCreatureAI(classic_boss_alcaz_blazeroar);
}
