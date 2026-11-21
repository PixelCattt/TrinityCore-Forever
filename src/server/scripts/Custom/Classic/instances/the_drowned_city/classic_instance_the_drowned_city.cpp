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

// Classic 1.60 (Forever): The Drowned City (map 2970, levels 35-40). Encounters from the 70862 DungeonEncounter.db2:
// 3474 Zul'Alai, 3475 Var'Taka, 3476 Captain Dreadrise, 3478 Deathless Guardians (Deathless Marrow), 3511 Primeval Elemental,
// 3479 Min'loth the Serpent.
//
// No sniff of this dungeon exists. The spells are the ones the 70862 client ships for these bosses (Monstrous Slam,
// Harpoon, Embrine, Waterbolt Volley, Bloodbolt, Blood Rite, Freeze Water, Waterbolt, Drench, Deluge, Transform, Poison
// Bolt Volley, Fear, Fatal Bite); what each boss does comes from the public dungeon guides. Timers and damage values are
// INFERRED (picked for a level 35-40 group), so a sniff of the fights should replace them.
//
// 19 Nov: every boss spell id checked against the live casts (EG Link combat logs, builds 70205-70959, all players merged:
// casts per pull, no timestamps). Spells live never casts are gone (Enrage 1284435, Tail Lash 1287872, the wrong Embrine,
// Cleave, Freeze Water and Fear ids), the live ones we lacked are in (Undying Oath, Rotted Strike, Poisoned Blood, Fatal
// Bite), and each repeat timer is set so a fight of the boss's live health (about 300 damage a second from a level 38 group,
// INFERRED) casts each spell about as often per pull as live does.
//
// The live combat logs (EG Link, Efficient Games, CC BY 4.0, builds 70938 and 70959) put the Primeval Elemental in the pool of
// the flooded quarter, 490 y from Deathless Marrow, and show it killed in one run of three: an optional boss, awake from the
// start, not one that waits for Marrow. They also show Deathless Watchers, Guardians and Sorcerers fighting in every run and
// never dying: the dead Marrow's Blood Rite raises, despawned with her. Min'loth does not die at zero health the first time: she turns into the serpent
// (Transform 1283295, creature 260274's model) with full health, and the serpent has to be killed.

#include "ScriptMgr.h"
#include "Creature.h"
#include "InstanceScript.h"
#include "Map.h"
#include "MotionMaster.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellInfo.h"
#include "TemporarySummon.h"
#include "classic_dungeon_encounter_tracker.h"
#include <list>
#include <vector>

namespace
{
constexpr uint32 CLASSIC_TDC_MAP_ID = 2970;

enum ClassicDrownedCityBosses : uint32
{
    CTDC_ENC_ZUL_ALAI = 0,
    CTDC_ENC_VAR_TAKA = 1,
    CTDC_ENC_DREADRISE = 2,
    CTDC_ENC_DEATHLESS = 3,
    CTDC_ENC_PRIMEVAL = 4,
    CTDC_ENC_MIN_LOTH = 5,
    CTDC_ENC_MAX
};

enum ClassicDrownedCityCreatures : uint32
{
    NPC_TDC_ZUL_ALAI = 258905,
    NPC_TDC_VAR_TAKA = 258924,
    NPC_TDC_DREADRISE = 260042,
    NPC_TDC_MARROW = 260202,
    NPC_TDC_PRIMEVAL = 263886,
    NPC_TDC_MIN_LOTH = 260243,
    NPC_TDC_BRINESCALE_PRIESTESS = 260096,
    NPC_TDC_DEATHLESS_WATCHER = 260205,     // Marrow's raised dead (the live logs: they fight, they never die)
    NPC_TDC_DEATHLESS_GUARDIAN = 260213,
    NPC_TDC_DEATHLESS_SORCERER = 260214
};

enum ClassicDrownedCitySpells : uint32
{
    // all present in the 70862 client
    SPELL_TDC_MONSTROUS_SLAM = 1282504,     // damage + stun around the caster (radius index 18)
    SPELL_TDC_UNDYING_OATH = 1282511,       // Zul'Alai, once a pull on live (cast where the guides put his enrage)
    SPELL_TDC_ROTTED_STRIKE = 1282519,      // Zul'Alai, instant, about one a pull on live
    SPELL_TDC_HARPOON = 1282615,            // pulls the target to the caster (triggers 1282659 -> 1282753)
    SPELL_TDC_CLEAVE = 15284,               // Var'Taka's live Cleave (1283413 is not what live casts)
    SPELL_TDC_EMBRINE = 1282842,            // the bubble on one target: live casts 1282842 (EG Link logs, 12x); 1282843 is not what live casts
    SPELL_TDC_WATERBOLT_VOLLEY = 1282860,
    SPELL_TDC_BLOODBOLT = 1283034,
    SPELL_TDC_BLOOD_RITE = 1283033,         // the look of the ritual while the dead rise
    SPELL_TDC_FREEZE_WATER = 1290980,       // frost damage + root around the caster; live casts 1290980 once a pull, never 1290983
    SPELL_TDC_POISONED_BLOOD = 1283027,     // Deathless Marrow, instant, about four a pull on live
    SPELL_TDC_FATAL_BITE = 1283327,         // Min'loth the serpent, on the tank, about one in two pulls on live
    SPELL_TDC_WATERBOLT = 1290978,
    SPELL_TDC_DRENCH = 1283250,
    SPELL_TDC_DELUGE = 1283233,             // live periodic aura; its trigger is server-side, so the pulses are ours
    SPELL_TDC_TRANSFORM = 1283295,          // turns Min'loth into the serpent (creature 260274's model)
    SPELL_TDC_POISON_BOLT_VOLLEY = 1283313,
    SPELL_TDC_FEAR = 1313471                // the id live casts (1283934 is not)
};

constexpr ClassicDungeonBossEntry ClassicDrownedCityBossEntries[] =
{
    { CTDC_ENC_ZUL_ALAI, NPC_TDC_ZUL_ALAI },
    { CTDC_ENC_VAR_TAKA, NPC_TDC_VAR_TAKA },
    { CTDC_ENC_DREADRISE, NPC_TDC_DREADRISE },
    { CTDC_ENC_DEATHLESS, NPC_TDC_MARROW },
    { CTDC_ENC_PRIMEVAL, NPC_TDC_PRIMEVAL },
    { CTDC_ENC_MIN_LOTH, NPC_TDC_MIN_LOTH }
};

// The bosses' spells are all new to Forever: their base points are a share (percent) of the expected creature spell damage at
// the caster's level (SpellEffectInfo::UsesClassicFlatBasePoints), so they are cast with the client's own values. The flat
// numbers this file used to put in effect 0 (300 to 500) were read as percents too and hit 10 to 20 times too hard.
// Deluge's pulses are ours (its trigger is server-side on live): Drench at a third of its client 40 percent (INFERRED).
constexpr int32 TdcDelugePulsePct = 13;

std::vector<Player*> TdcPlayersNear(Creature* me, float range)
{
    std::vector<Player*> out;
    for (MapReference const& ref : me->GetMap()->GetPlayers())
    {
        Player* player = ref.GetSource();
        if (player && player->IsAlive() && !player->IsGameMaster() && player->GetExactDist(me) <= range && me->IsValidAttackTarget(player))
            out.push_back(player);
    }
    return out;
}

// a client spell cast with its own values
void TdcCast(Creature* me, Unit* target, uint32 spellId)
{
    me->CastSpell(target, spellId, CastSpellExtraArgs(TRIGGERED_FULL_MASK));
}

void TdcAddJoins(Creature* me, Creature* add)
{
    if (!add)
        return;
    if (Unit* target = me->GetAI()->SelectTarget(SelectTargetMethod::Random, 0, 0.0f, true))
        add->AI()->AttackStart(target);
}

// the guards standing next to a boss join its fight (Var'Taka's priestesses)
void TdcCallGuards(Creature* me, uint32 entry, float range, Unit* who)
{
    std::list<Creature*> guards;
    me->GetCreatureListWithEntryInGrid(guards, entry, range);
    for (Creature* guard : guards)
        if (guard->IsAlive() && !guard->IsEngaged() && who)
            guard->AI()->AttackStart(who);
}
}

class classic_instance_the_drowned_city : public InstanceMapScript
{
public:
    classic_instance_the_drowned_city() : InstanceMapScript("classic_instance_the_drowned_city", CLASSIC_TDC_MAP_ID) { }

    struct classic_instance_the_drowned_city_InstanceScript : public InstanceScript
    {
        classic_instance_the_drowned_city_InstanceScript(InstanceMap* map) : InstanceScript(map)
        {
            SetHeaders("CTDC");
            SetBossNumber(CTDC_ENC_MAX);
            static constexpr DungeonEncounterData encounters[] =
            {
                { CTDC_ENC_ZUL_ALAI, {{ 3474 }} },
                { CTDC_ENC_VAR_TAKA, {{ 3475 }} },
                { CTDC_ENC_DREADRISE, {{ 3476 }} },
                { CTDC_ENC_DEATHLESS, {{ 3478 }} },
                { CTDC_ENC_PRIMEVAL, {{ 3511 }} },
                { CTDC_ENC_MIN_LOTH, {{ 3479 }} }
            };
            LoadDungeonEncounterData(encounters);
        }

        ClassicDungeonEncounterTracker _encounterTracker{ *this, ClassicDrownedCityBossEntries };

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
        return new classic_instance_the_drowned_city_InstanceScript(map);
    }
};

// ---------------------------------------------------------------------------------------------------------------------
// Zul'Alai (first boss, top of the climb from the cave): Monstrous Slam around him (damage and a short stun), and he
// enrages when he gets low (the guides say between 30 and 50 percent; 35 here).
struct classic_boss_tdc_zul_alai : public ScriptedAI
{
    classic_boss_tdc_zul_alai(Creature* creature) : ScriptedAI(creature) { }

    enum : uint32 { EV_SLAM = 1, EV_ROTTED_STRIKE };

    void Reset() override
    {
        _events.Reset();
        _enraged = false;
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _events.ScheduleEvent(EV_SLAM, 12s);            // INFERRED timers: live casts Slam once a pull, Rotted Strike 0.75
        _events.ScheduleEvent(EV_ROTTED_STRIKE, 20s);
    }

    void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*type*/, SpellInfo const* /*spellInfo*/) override
    {
        if (!_enraged && me->HealthBelowPctDamaged(35, damage))
        {
            _enraged = true;
            DoCastSelf(SPELL_TDC_UNDYING_OATH, CastSpellExtraArgs(TRIGGERED_FULL_MASK));
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
                case EV_SLAM: TdcCast(me, me, SPELL_TDC_MONSTROUS_SLAM); _events.Repeat(35s, 40s); break;
                case EV_ROTTED_STRIKE: DoCastVictim(SPELL_TDC_ROTTED_STRIKE, CastSpellExtraArgs(TRIGGERED_FULL_MASK)); _events.Repeat(40s, 50s); break;
                default: break;
            }
        }
    }

private:
    EventMap _events;
    bool _enraged = false;
};

// Var'Taka (north arm): Harpoon pulls someone standing back to her, Cleave on the tank, and her two Brinescale
// Priestesses (SmartAI, Healing Wave) join the fight with her.
struct classic_boss_tdc_var_taka : public ScriptedAI
{
    classic_boss_tdc_var_taka(Creature* creature) : ScriptedAI(creature) { }

    enum : uint32 { EV_HARPOON = 1, EV_CLEAVE };

    void Reset() override { _events.Reset(); }

    void JustEngagedWith(Unit* who) override
    {
        TdcCallGuards(me, NPC_TDC_BRINESCALE_PRIESTESS, 20.0f, who);
        _events.ScheduleEvent(EV_CLEAVE, 6s);           // INFERRED timers
        _events.ScheduleEvent(EV_HARPOON, 12s);
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
                case EV_CLEAVE: DoCastVictim(SPELL_TDC_CLEAVE); _events.Repeat(7s, 10s); break;
                case EV_HARPOON:
                    // someone who is not the tank and stands at least 8 yd away
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1, -8.0f, true))
                        DoCast(target, SPELL_TDC_HARPOON);
                    _events.Repeat(15s, 20s);
                    break;
                default: break;
            }
        }
    }

private:
    EventMap _events;
};

// Captain Dreadrise (the ship in the east plaza): Embrine traps one player in a bubble, Waterbolt Volley hits everyone.
struct classic_boss_tdc_dreadrise : public ScriptedAI
{
    classic_boss_tdc_dreadrise(Creature* creature) : ScriptedAI(creature) { }

    enum : uint32 { EV_EMBRINE = 1, EV_VOLLEY };

    void Reset() override { _events.Reset(); }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _events.ScheduleEvent(EV_VOLLEY, 10s);          // INFERRED timers: live 2.25 volleys and 1.5 Embrines a pull
        _events.ScheduleEvent(EV_EMBRINE, 15s);
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
                case EV_VOLLEY: TdcCast(me, me, SPELL_TDC_WATERBOLT_VOLLEY); _events.Repeat(18s, 22s); break;
                case EV_EMBRINE:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1, 0.0f, true))
                        DoCast(target, SPELL_TDC_EMBRINE, CastSpellExtraArgs(TRIGGERED_FULL_MASK));
                    _events.Repeat(20s, 25s);
                    break;
                default: break;
            }
        }
    }

private:
    EventMap _events;
};

// Deathless Marrow (the Deathless Guardians encounter, with a Watcher, a Guardian and a Sorcerer standing at her side):
// Bloodbolt on everyone, and the Blood Rite raises Deathless Watchers, Guardians and Sorcerers, who go when she dies. The live
// logs count about ten raised in a fight.
struct classic_boss_tdc_deathless_marrow : public ScriptedAI
{
    classic_boss_tdc_deathless_marrow(Creature* creature) : ScriptedAI(creature), _summons(creature) { }

    enum : uint32 { EV_BLOODBOLT = 1, EV_RITE, EV_POISONED_BLOOD };
    static constexpr uint32 MaxRaised = 9;          // INFERRED cap (three rites)

    void Reset() override
    {
        _events.Reset();
        _summons.DespawnAll();
        _raised = 0;
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _events.ScheduleEvent(EV_BLOODBOLT, 8s);        // INFERRED timers: live 5.5 Bloodbolts and 3.75 Poisoned Bloods a pull
        _events.ScheduleEvent(EV_RITE, 15s);
        _events.ScheduleEvent(EV_POISONED_BLOOD, 12s);
    }

    void JustSummoned(Creature* summon) override { _summons.Summon(summon); }
    void JustDied(Unit* /*killer*/) override { _summons.DespawnAll(); }

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
                case EV_BLOODBOLT: TdcCast(me, me, SPELL_TDC_BLOODBOLT); _events.Repeat(18s, 24s); break;
                case EV_POISONED_BLOOD:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 40.0f, true))
                        TdcCast(me, target, SPELL_TDC_POISONED_BLOOD);
                    _events.Repeat(28s, 34s);
                    break;
                case EV_RITE:
                    if (_raised < MaxRaised)
                    {
                        DoCastSelf(SPELL_TDC_BLOOD_RITE, CastSpellExtraArgs(TRIGGERED_FULL_MASK));
                        for (uint32 entry : { NPC_TDC_DEATHLESS_WATCHER, NPC_TDC_DEATHLESS_GUARDIAN, NPC_TDC_DEATHLESS_SORCERER })
                        {
                            Position pos = me->GetRandomNearPosition(8.0f);
                            TdcAddJoins(me, me->SummonCreature(entry, pos, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 10s));
                            ++_raised;
                        }
                    }
                    _events.Repeat(25s, 30s);
                    break;
                default: break;
            }
        }
    }

private:
    EventMap _events;
    SummonList _summons;
    uint32 _raised = 0;
};

// Primeval Elemental (the pool of the flooded quarter, optional): Freeze Water around it (frost damage and a root, a tick a second for six
// seconds) and Waterbolt on a random player.
struct classic_boss_tdc_primeval_elemental : public ScriptedAI
{
    classic_boss_tdc_primeval_elemental(Creature* creature) : ScriptedAI(creature) { }

    enum : uint32 { EV_WATERBOLT = 1, EV_FREEZE };

    void Reset() override { _events.Reset(); }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _events.ScheduleEvent(EV_WATERBOLT, 4s);        // INFERRED timers: live 5.67 Waterbolts and one Freeze Water a pull
        _events.ScheduleEvent(EV_FREEZE, 18s);
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
                case EV_WATERBOLT:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 40.0f, true))
                        TdcCast(me, target, SPELL_TDC_WATERBOLT);
                    _events.Repeat(6s, 8s);
                    break;
                case EV_FREEZE:
                    DoCastSelf(SPELL_TDC_FREEZE_WATER, CastSpellExtraArgs(TRIGGERED_FULL_MASK));
                    _events.Repeat(40s, 45s);
                    break;
                default: break;
            }
        }
    }

private:
    EventMap _events;
};

// Min'loth the Serpent (last boss, the west courtyard). Naga form: Drench on a random player and Deluge (four waves of
// water on everyone near). At zero health she turns into the serpent with full health: Poison Bolt Volley, Fatal Bite
// and Fear.
struct classic_boss_tdc_min_loth : public ScriptedAI
{
    classic_boss_tdc_min_loth(Creature* creature) : ScriptedAI(creature) { }

    enum : uint32 { EV_DRENCH = 1, EV_DELUGE, EV_DELUGE_PULSE, EV_POISON_VOLLEY, EV_FATAL_BITE, EV_FEAR };
    static constexpr uint32 DelugePulses = 4;
    static constexpr float DelugeRange = 30.0f;

    void Reset() override
    {
        _events.Reset();
        _serpent = false;
        _pulses = 0;
        me->RemoveAurasDueToSpell(SPELL_TDC_TRANSFORM);
        me->RemoveAurasDueToSpell(SPELL_TDC_DELUGE);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _events.ScheduleEvent(EV_DRENCH, 8s);           // INFERRED timers: live a pull has 1.5 Drench, 0.75 Deluge, 1.5 Poison Bolt
        _events.ScheduleEvent(EV_DELUGE, 20s);          // Volley, 1.25 Fear, 0.5 Fatal Bite
    }

    void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*type*/, SpellInfo const* /*spellInfo*/) override
    {
        if (_serpent || damage < me->GetHealth())
            return;

        damage = me->GetHealth() - 1;
        _serpent = true;
        _events.Reset();
        me->InterruptNonMeleeSpells(false);
        me->RemoveAurasDueToSpell(SPELL_TDC_DELUGE);
        DoCastSelf(SPELL_TDC_TRANSFORM, CastSpellExtraArgs(TRIGGERED_FULL_MASK));
        me->SetFullHealth();
        _events.ScheduleEvent(EV_POISON_VOLLEY, 6s);
        _events.ScheduleEvent(EV_FEAR, 12s);
        _events.ScheduleEvent(EV_FATAL_BITE, 18s);
    }

    void JustDied(Unit* /*killer*/) override
    {
        me->RemoveAurasDueToSpell(SPELL_TDC_DELUGE);
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
                case EV_DRENCH:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 40.0f, true))
                        TdcCast(me, target, SPELL_TDC_DRENCH);
                    _events.Repeat(20s, 25s);
                    break;
                case EV_DELUGE:
                    DoCastSelf(SPELL_TDC_DELUGE, CastSpellExtraArgs(TRIGGERED_FULL_MASK));
                    _pulses = 0;
                    _events.ScheduleEvent(EV_DELUGE_PULSE, 1s);
                    _events.Repeat(40s, 45s);
                    break;
                case EV_DELUGE_PULSE:
                    for (Player* player : TdcPlayersNear(me, DelugeRange))
                    {
                        CastSpellExtraArgs args(TRIGGERED_FULL_MASK);
                        args.AddSpellBP0(TdcDelugePulsePct);
                        me->CastSpell(player, SPELL_TDC_DRENCH, args);
                    }
                    if (++_pulses < DelugePulses)
                        _events.Repeat(2s);
                    else
                        me->RemoveAurasDueToSpell(SPELL_TDC_DELUGE);
                    break;
                case EV_POISON_VOLLEY: TdcCast(me, me, SPELL_TDC_POISON_BOLT_VOLLEY); _events.Repeat(20s, 25s); break;
                case EV_FATAL_BITE: DoCastVictim(SPELL_TDC_FATAL_BITE, CastSpellExtraArgs(TRIGGERED_FULL_MASK)); _events.Repeat(40s, 50s); break;
                case EV_FEAR:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1, 20.0f, true))
                        DoCast(target, SPELL_TDC_FEAR, CastSpellExtraArgs(TRIGGERED_FULL_MASK));
                    _events.Repeat(25s, 30s);
                    break;
                default: break;
            }
        }
    }

private:
    EventMap _events;
    bool _serpent = false;
    uint32 _pulses = 0;
};

void AddSC_classic_instance_the_drowned_city()
{
    new classic_instance_the_drowned_city();
    RegisterCreatureAI(classic_boss_tdc_zul_alai);
    RegisterCreatureAI(classic_boss_tdc_var_taka);
    RegisterCreatureAI(classic_boss_tdc_dreadrise);
    RegisterCreatureAI(classic_boss_tdc_deathless_marrow);
    RegisterCreatureAI(classic_boss_tdc_primeval_elemental);
    RegisterCreatureAI(classic_boss_tdc_min_loth);
}
