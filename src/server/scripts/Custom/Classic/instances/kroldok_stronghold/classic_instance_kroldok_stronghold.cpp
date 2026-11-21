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

// Classic 1.60 (Forever): Krol'dok Stronghold (map 3039, Riverglades, levels 40-45). Encounters from the 70862
// DungeonEncounter.db2: 3450 Slavecrusher Grox, 3452 Twilight Commander Zarmok, 3453 Handler Ashka, 3449 Nar'gurk,
// 3451 Overseer Mugg (the creature is Overlord Mugg). Bossman Toof (264773) guards the way to Mugg with his shamans but has
// no encounter of his own.
//
// No sniff of this dungeon exists. The spells each boss casts are the ones live players' combat logs show (EG Link, Efficient
// Games, CC BY 4.0, client builds 70938 and 70959): Grox Knockdown and Bloodlust; Zarmok Strike, Rending Whirl and Enrage;
// Ashka Strike, Battle Shout and Command: Kill! with her wolves Snarlfang and Terrorhowl; Nar'gurk Shadow Bolt Volley and
// Convert (he takes a player's mind); Toof Mortal Strike and Demoralizing Shout; Mugg Set of Maces / Set of Mauls and Crushing
// Slam. The trash and its spawns are 2026_11_19_66. Grox's Force Compliance and Ashka's Command: Kill! are server-side dummies
// on live, so what they do here is ours: Command: Kill! sends both wolves at one player. Timers and damage values are INFERRED
// (picked for a level 40-45 group); a sniff of the fights should replace them.
//
// 19 Nov: timers checked against the live casts per pull (EG Link, builds 70205-70959, one pull of each boss, so thin data):
// each boss casts each spell once or twice a pull and Mugg leaps 4 times, so the repeats are set so a fight of the boss's
// live health (about 350 damage a second from a level 43 group, INFERRED) does about that. Mugg's Cleave was ours, not
// live (no Cleave in the pull, 4 Crushing Slams), so it is gone.

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
constexpr uint32 CLASSIC_KDS_MAP_ID = 3039;

enum ClassicKroldokBosses : uint32
{
    CKDS_ENC_GROX = 0,
    CKDS_ENC_ZARMOK = 1,
    CKDS_ENC_ASHKA = 2,
    CKDS_ENC_NARGURK = 3,
    CKDS_ENC_MUGG = 4,
    CKDS_ENC_MAX
};

enum ClassicKroldokCreatures : uint32
{
    NPC_KDS_GROX = 258966,
    NPC_KDS_ZARMOK = 258972,
    NPC_KDS_ASHKA = 259281,
    NPC_KDS_NARGURK = 258964,
    NPC_KDS_MUGG = 258968,
    NPC_KDS_TOOF = 264773,
    NPC_KDS_SHAMAN = 257888,            // Krol'dok Shaman: five stand with Toof
    NPC_KDS_CENTURION = 257885,         // Krol'dok Centurion: two stand with Mugg
    NPC_KDS_SNARLFANG = 259283,         // Ashka's wolves
    NPC_KDS_TERRORHOWL = 259285
};

enum ClassicKroldokSpells : uint32
{
    // the spells the live combat logs show for each boss
    SPELL_KDS_KNOCKDOWN = 11428,        // Grox
    SPELL_KDS_BLOODLUST = 21049,        // Grox
    SPELL_KDS_STRIKE = 12057,           // Zarmok, Ashka
    SPELL_KDS_RENDING_WHIRL = 1280011,  // Zarmok: damage and a bleed around him
    SPELL_KDS_ZARMOK_ENRAGE = 8599,
    SPELL_KDS_BATTLE_SHOUT = 9128,      // Ashka
    SPELL_KDS_COMMAND_KILL = 1282076,   // Ashka: live dummy, the wolves' attack is ours
    SPELL_KDS_SHADOW_BOLT_VOLLEY = 1280356, // Nar'gurk
    SPELL_KDS_CONVERT = 1280259,        // Nar'gurk: control of a player's mind
    SPELL_KDS_MORTAL_STRIKE = 16856,    // Toof
    SPELL_KDS_DEMORALIZING_SHOUT = 16244, // Toof
    SPELL_KDS_CRUSHING_SLAM = 1282397,  // damage and knock back where Mugg lands
    SPELL_KDS_MUGGS_FURY = 1282386,
    SPELL_KDS_SET_OF_MACES = 1282393,
    SPELL_KDS_SET_OF_MAULS = 1282394,
    SPELL_KDS_ENRAGE = 1284435
};

constexpr ClassicDungeonBossEntry ClassicKroldokBossEntries[] =
{
    { CKDS_ENC_GROX, NPC_KDS_GROX },
    { CKDS_ENC_ZARMOK, NPC_KDS_ZARMOK },
    { CKDS_ENC_ASHKA, NPC_KDS_ASHKA },
    { CKDS_ENC_NARGURK, NPC_KDS_NARGURK },
    { CKDS_ENC_MUGG, NPC_KDS_MUGG }
};


void KdsCallGuards(Creature* me, uint32 entry, float range, Unit* who)
{
    std::list<Creature*> guards;
    me->GetCreatureListWithEntryInGrid(guards, entry, range);
    for (Creature* guard : guards)
        if (guard->IsAlive() && !guard->IsEngaged() && who)
            guard->AI()->AttackStart(who);
}

// a boss whose whole fight is a few spells on timers
struct KdsTimedSpell
{
    uint32 Spell;
    bool OnVictim;          // false: on itself (an area spell around it)
    Milliseconds First;
    Milliseconds RepeatMin;
    Milliseconds RepeatMax;
};

class KdsTimedBossAI : public ScriptedAI
{
public:
    KdsTimedBossAI(Creature* creature, std::initializer_list<KdsTimedSpell> spells) : ScriptedAI(creature), _spells(spells) { }

    void Reset() override { _events.Reset(); }

    void JustEngagedWith(Unit* /*who*/) override
    {
        for (uint32 i = 0; i < _spells.size(); ++i)
            _events.ScheduleEvent(i + 1, _spells[i].First);
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
            KdsTimedSpell const& spell = _spells[ev - 1];
            if (spell.OnVictim)
                DoCastVictim(spell.Spell);
            else
                DoCastSelf(spell.Spell);
            _events.Repeat(spell.RepeatMin, spell.RepeatMax);
        }
    }

protected:
    EventMap _events;
    std::vector<KdsTimedSpell> _spells;
};
}

class classic_instance_kroldok_stronghold : public InstanceMapScript
{
public:
    classic_instance_kroldok_stronghold() : InstanceMapScript("classic_instance_kroldok_stronghold", CLASSIC_KDS_MAP_ID) { }

    struct classic_instance_kroldok_stronghold_InstanceScript : public InstanceScript
    {
        classic_instance_kroldok_stronghold_InstanceScript(InstanceMap* map) : InstanceScript(map)
        {
            SetHeaders("CKDS");
            SetBossNumber(CKDS_ENC_MAX);
            static constexpr DungeonEncounterData encounters[] =
            {
                { CKDS_ENC_GROX, {{ 3450 }} },
                { CKDS_ENC_ZARMOK, {{ 3452 }} },
                { CKDS_ENC_ASHKA, {{ 3453 }} },
                { CKDS_ENC_NARGURK, {{ 3449 }} },
                { CKDS_ENC_MUGG, {{ 3451 }} }
            };
            LoadDungeonEncounterData(encounters);
        }

        ClassicDungeonEncounterTracker _encounterTracker{ *this, ClassicKroldokBossEntries };

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
        return new classic_instance_kroldok_stronghold_InstanceScript(map);
    }
};

// Slavecrusher Grox (the Redridge Prisoners stand with him): Knockdown on the tank and Bloodlust.
struct classic_boss_kds_grox : public KdsTimedBossAI
{
    classic_boss_kds_grox(Creature* creature) : KdsTimedBossAI(creature, {
        { SPELL_KDS_KNOCKDOWN, true, 8s, 30s, 35s },
        { SPELL_KDS_BLOODLUST, false, 15s, 45s, 50s } }) { }
};

// Twilight Commander Zarmok: Strike on the tank, Rending Whirl (damage and a bleed around him), and Enrage when he gets low.
struct classic_boss_kds_zarmok : public KdsTimedBossAI
{
    classic_boss_kds_zarmok(Creature* creature) : KdsTimedBossAI(creature, {
        { SPELL_KDS_STRIKE, true, 6s, 30s, 35s },
        { SPELL_KDS_RENDING_WHIRL, false, 15s, 35s, 40s } }) { }

    void Reset() override
    {
        KdsTimedBossAI::Reset();
        _enraged = false;
    }

    void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*type*/, SpellInfo const* /*spellInfo*/) override
    {
        if (!_enraged && me->HealthBelowPctDamaged(30, damage))     // INFERRED health
        {
            _enraged = true;
            DoCastSelf(SPELL_KDS_ZARMOK_ENRAGE, CastSpellExtraArgs(TRIGGERED_FULL_MASK));
        }
    }

private:
    bool _enraged = false;
};

// War Handler Ashka: Strike and Battle Shout; Snarlfang and Terrorhowl fight with her, and Command: Kill! sends both of them
// at one player.
struct classic_boss_kds_ashka : public ScriptedAI
{
    classic_boss_kds_ashka(Creature* creature) : ScriptedAI(creature) { }

    enum : uint32 { EV_STRIKE = 1, EV_SHOUT, EV_COMMAND };

    void Reset() override { _events.Reset(); }

    void JustEngagedWith(Unit* who) override
    {
        KdsCallGuards(me, NPC_KDS_SNARLFANG, 25.0f, who);
        KdsCallGuards(me, NPC_KDS_TERRORHOWL, 25.0f, who);
        _events.ScheduleEvent(EV_SHOUT, 1s);            // INFERRED timers
        _events.ScheduleEvent(EV_STRIKE, 4s);
        _events.ScheduleEvent(EV_COMMAND, 12s);         // live a pull: 2 Strike, 1 Battle Shout, 1 Command: Kill!
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
                case EV_STRIKE: DoCastVictim(SPELL_KDS_STRIKE); _events.Repeat(14s, 16s); break;
                case EV_SHOUT: DoCastSelf(SPELL_KDS_BATTLE_SHOUT); _events.Repeat(60s); break;
                case EV_COMMAND:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 40.0f, true))
                    {
                        DoCast(target, SPELL_KDS_COMMAND_KILL, CastSpellExtraArgs(TRIGGERED_FULL_MASK));
                        for (uint32 entry : { NPC_KDS_SNARLFANG, NPC_KDS_TERRORHOWL })
                            if (Creature* wolf = me->FindNearestCreature(entry, 60.0f))
                                if (wolf->IsAIEnabled())
                                {
                                    AddThreat(target, 10000.0f, wolf);
                                    wolf->AI()->AttackStart(target);
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
};

// Nar'gurk the Corruptor: Shadow Bolt Volley, and Convert takes a player's mind for a while (not the tank).
struct classic_boss_kds_nargurk : public ScriptedAI
{
    classic_boss_kds_nargurk(Creature* creature) : ScriptedAI(creature) { }

    enum : uint32 { EV_CONVERT = 1, EV_VOLLEY };

    void Reset() override { _events.Reset(); }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _events.ScheduleEvent(EV_VOLLEY, 10s);          // INFERRED timers: live a pull has 1 volley and 1 Convert
        _events.ScheduleEvent(EV_CONVERT, 18s);
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
                case EV_VOLLEY: DoCastSelf(SPELL_KDS_SHADOW_BOLT_VOLLEY); _events.Repeat(30s, 35s); break;
                case EV_CONVERT:
                    // Convert carries the charm itself (SpellEffect: MOD_CHARM on the target); only with someone else left
                    // to fight, never the tank
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1, 30.0f, true))
                        DoCast(target, SPELL_KDS_CONVERT);
                    _events.Repeat(30s, 35s);
                    break;
                default: break;
            }
        }
    }

private:
    EventMap _events;
};

// Bossman Toof (on the way to Mugg, no encounter of his own): Mortal Strike and Demoralizing Shout, and his shamans join him.
struct classic_boss_kds_toof : public KdsTimedBossAI
{
    classic_boss_kds_toof(Creature* creature) : KdsTimedBossAI(creature, {
        { SPELL_KDS_MORTAL_STRIKE, true, 5s, 15s, 20s },
        { SPELL_KDS_DEMORALIZING_SHOUT, false, 2s, 25s, 30s } }) { }

    void JustEngagedWith(Unit* who) override
    {
        KdsTimedBossAI::JustEngagedWith(who);
        KdsCallGuards(me, NPC_KDS_SHAMAN, 25.0f, who);
    }
};

// Overlord Mugg (top of the stronghold): fights with a set of maces, leaps onto a player (Crushing Slam: damage and a
// knock back where he lands), and at half health takes up his mauls in Mugg's Fury. The two Krol'dok Centurions who stand
// with him (the live kills put them 7-8 y from him) join his fight.
struct classic_boss_kds_mugg : public ScriptedAI
{
    classic_boss_kds_mugg(Creature* creature) : ScriptedAI(creature) { }

    enum : uint32 { EV_LEAP = 1 };
    static constexpr uint32 PointLeap = 1;

    void Reset() override
    {
        _events.Reset();
        _fury = false;
        me->RemoveAurasDueToSpell(SPELL_KDS_SET_OF_MAULS);
        me->RemoveAurasDueToSpell(SPELL_KDS_MUGGS_FURY);
        me->RemoveAurasDueToSpell(SPELL_KDS_ENRAGE);
    }

    void JustEngagedWith(Unit* who) override
    {
        DoCastSelf(SPELL_KDS_SET_OF_MACES, CastSpellExtraArgs(TRIGGERED_FULL_MASK));
        KdsCallGuards(me, NPC_KDS_CENTURION, 20.0f, who);
        _events.ScheduleEvent(EV_LEAP, 10s);            // INFERRED timer: live 4 Crushing Slams a pull
    }

    void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*type*/, SpellInfo const* /*spellInfo*/) override
    {
        if (!_fury && me->HealthBelowPctDamaged(50, damage))
        {
            _fury = true;
            me->RemoveAurasDueToSpell(SPELL_KDS_SET_OF_MACES);
            DoCastSelf(SPELL_KDS_SET_OF_MAULS, CastSpellExtraArgs(TRIGGERED_FULL_MASK));
            DoCastSelf(SPELL_KDS_MUGGS_FURY, CastSpellExtraArgs(TRIGGERED_FULL_MASK));
            DoCastSelf(SPELL_KDS_ENRAGE, CastSpellExtraArgs(TRIGGERED_FULL_MASK));
        }
    }

    void MovementInform(uint32 type, uint32 id) override
    {
        if (type != EFFECT_MOTION_TYPE || id != PointLeap)
            return;
        // the client's own value: a Forever spell, its base points are a share of the expected creature spell damage at
        // Mugg's level (SpellEffectInfo::UsesClassicFlatBasePoints), so a flat number here would multiply it many times
        me->CastSpell(me->GetPosition(), SPELL_KDS_CRUSHING_SLAM, CastSpellExtraArgs(TRIGGERED_FULL_MASK));
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;
        _events.Update(diff);
        if (me->HasUnitState(UNIT_STATE_CASTING | UNIT_STATE_JUMPING))
            return;

        while (uint32 ev = _events.ExecuteEvent())
        {
            switch (ev)
            {
                case EV_LEAP:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 40.0f, true))
                        me->GetMotionMaster()->MoveJump(PointLeap, target->GetPosition(), 25.0f, {}, 8.0f);
                    _events.Repeat(15s, 18s);
                    break;
                default: break;
            }
        }
    }

private:
    EventMap _events;
    bool _fury = false;
};

void AddSC_classic_instance_kroldok_stronghold()
{
    new classic_instance_kroldok_stronghold();
    RegisterCreatureAI(classic_boss_kds_grox);
    RegisterCreatureAI(classic_boss_kds_zarmok);
    RegisterCreatureAI(classic_boss_kds_ashka);
    RegisterCreatureAI(classic_boss_kds_nargurk);
    RegisterCreatureAI(classic_boss_kds_toof);
    RegisterCreatureAI(classic_boss_kds_mugg);
}
