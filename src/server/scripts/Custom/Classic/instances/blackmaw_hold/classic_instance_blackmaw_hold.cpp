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

// Classic 1.60 (Forever): Blackmaw Hold (map 2974, levels 55-60). Encounters from the 70938 DungeonEncounter.db2 (map 2974,
// in their journal order): 3315 Withermaw, 3316 Impaan the Imprisoner, 3327 Elder Shaman Bloodmane, 3322 Bonesnout the
// Unbroken, 3334 Varrox Bleakhoof, 3323 Blackmaw Behemoth, 3336 Unbound Spirit.
//
// Which spells each boss casts and what each fight does are from Everlake's Forever dungeon work (github.com/buildthehomelab,
// GPL), which takes them from the public dungeon guides; every spell id was checked in our 70938 client. This file is our own
// code. Many of these spells hit for a share of the target's health (effect 165), and the other new ones are a share of the
// expected creature spell damage at the caster's level, so all are cast with the client's values. INFERRED (no sniff or combat
// log exists yet): every timer and threshold, and the add counts.
//
//   Withermaw: Maul on the tank, Intimidating Roar (fear around him), Flesh Maggots crawling out to join.
//   Bonesnout the Unbroken: each living Legashi Ritualist near him takes a quarter off the damage he takes (Profane Bulwark;
//     four make him untouchable), Stomp and Trample. His Ritualists join the fight.
//   Impaan the Imprisoner: one of his nineteen Shadowbolts at someone, and now and then "Imps!!" (imps join the fight).
//   Elder Shaman Bloodmane: Chain Lightning, Purge, two Feral Spirits; his Blackmaw Devotees join the fight.
//   Unbound Spirit: untouchable (Profane Protection) until Elder Bramblesnap's ritual: three waves (spiders, wolves, a bear),
//     then Bramblesnap's Purify lifts the protection and the Spirit fights with Fireball and Fire Nova. The ritual starts when
//     a player talks to Bramblesnap or comes near him (our choice, so a group of bots can start it too).
//   Blackmaw Behemoth with Clawbert: Clawbert casts Lightning Bolt and Restore (heals the Behemoth to full); the Behemoth
//     roars (Bestial Roar) and whirls, and at a quarter of its health eats Clawbert and turns to Thunder Roar.
//   Varrox Bleakhoof: Shadow Bolt Volley, Fear, and Crimson Wrest: a player is seized and a few seconds later Nightmare
//     Detonation bursts around them.
// Fear, Crimson Wrest, Nightmare Detonation, Thunder Roar, Purify, Bestial Roar and Restore pick their targets by conditions
// (2026_11_19_71_world_forever_blackmaw_hold_fights.sql).

#include "ScriptMgr.h"
#include "Creature.h"
#include "InstanceScript.h"
#include "Map.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "SpellInfo.h"
#include "TemporarySummon.h"
#include "classic_dungeon_encounter_tracker.h"
#include <algorithm>
#include <array>
#include <list>

namespace
{
constexpr uint32 CLASSIC_BMH_MAP_ID = 2974;

enum ClassicBlackmawBosses : uint32
{
    CBMH_ENC_WITHERMAW = 0,
    CBMH_ENC_IMPAAN = 1,
    CBMH_ENC_BLOODMANE = 2,
    CBMH_ENC_BONESNOUT = 3,
    CBMH_ENC_VARROX = 4,
    CBMH_ENC_BEHEMOTH = 5,
    CBMH_ENC_SPIRIT = 6,
    CBMH_ENC_MAX
};

enum ClassicBlackmawCreatures : uint32
{
    NPC_BMH_WITHERMAW = 247195,
    NPC_BMH_BONESNOUT = 247198,
    NPC_BMH_IMPAAN = 247206,
    NPC_BMH_BEHEMOTH = 247207,
    NPC_BMH_BLOODMANE = 247209,
    NPC_BMH_SPIRIT = 247231,
    NPC_BMH_VARROX = 247234,
    NPC_BMH_IMP = 247432,
    NPC_BMH_CLAWBERT = 247996,
    NPC_BMH_FERAL_SPIRIT = 248216,
    NPC_BMH_BRAMBLESNAP = 248765,
    NPC_BMH_ETHEREAL_WOLF = 249061,
    NPC_BMH_ETHEREAL_SPIDER = 249064,
    NPC_BMH_ETHEREAL_BEAR = 249065,
    NPC_BMH_RITUALIST = 258668,
    NPC_BMH_FLESH_MAGGOT = 268878,
    NPC_BMH_DEVOTEE = 277474,
    NPC_BMH_STALKER = 255435        // Invisible Stalker (2026_11_14_40): where Nightmare Detonation bursts
};

enum ClassicBlackmawSpells : uint32
{
    // all present in the 70938 client
    SPELL_BMH_MAUL = 1242907,                // 25% of the target's health
    SPELL_BMH_INTIMIDATING_ROAR = 1242884,   // fear around the caster
    SPELL_BMH_STOMP = 1244416,               // stun and 20% of health around the caster
    SPELL_BMH_TRAMPLE = 5568,
    SPELL_BMH_PROFANE_BULWARK = 1277406,     // -25% damage taken per living Ritualist (the amount is set when cast)
    SPELL_BMH_CHAIN_LIGHTNING = 1245324,
    SPELL_BMH_PURGE = 1245883,
    SPELL_BMH_PROFANE_PROTECTION = 1247237,  // immune to all schools
    SPELL_BMH_PURIFY = 1247252,              // removes 1247237
    SPELL_BMH_FIREBALL = 1248131,            // 30% of the target's health
    SPELL_BMH_FIRE_NOVA = 1248008,
    SPELL_BMH_BESTIAL_ROAR = 1245119,
    SPELL_BMH_WHIRLWIND = 1244484,
    SPELL_BMH_THUNDER_ROAR = 1245154,
    SPELL_BMH_RESTORE = 1244951,             // heals the Behemoth 100%
    SPELL_BMH_CLAWBERT_BOLT = 1244981,       // 35% of the target's health
    SPELL_BMH_SHADOW_BOLT_VOLLEY = 9081,
    SPELL_BMH_FEAR = 1247087,
    SPELL_BMH_CRIMSON_WREST = 1246456,       // fear and slow on the one seized
    SPELL_BMH_NIGHTMARE_DETONATION = 1246364 // 50% of health around the seized player
};

// Impaan's nineteen Shadowbolts (30% of the target's health each): one at random each time
constexpr std::array<uint32, 19> BmhImpaanBolts =
{
    1243064, 1243067, 1243068, 1243070, 1243071, 1243072, 1243073, 1243074, 1243076, 1243077,
    1243079, 1243080, 1243081, 1243082, 1243083, 1243084, 1243088, 1243089, 1243090
};

constexpr ClassicDungeonBossEntry ClassicBlackmawBossEntries[] =
{
    { CBMH_ENC_WITHERMAW, NPC_BMH_WITHERMAW },
    { CBMH_ENC_IMPAAN, NPC_BMH_IMPAAN },
    { CBMH_ENC_BLOODMANE, NPC_BMH_BLOODMANE },
    { CBMH_ENC_BONESNOUT, NPC_BMH_BONESNOUT },
    { CBMH_ENC_VARROX, NPC_BMH_VARROX },
    { CBMH_ENC_BEHEMOTH, NPC_BMH_BEHEMOTH },
    { CBMH_ENC_BEHEMOTH, NPC_BMH_CLAWBERT, CLASSIC_DUNGEON_BOSS_ENGAGE_ONLY },
    { CBMH_ENC_SPIRIT, NPC_BMH_SPIRIT }
};

// the creatures standing near a boss join its fight
void BmhCallNear(Creature* me, uint32 entry, float range, Unit* who)
{
    if (!who)
        return;
    std::list<Creature*> near;
    me->GetCreatureListWithEntryInGrid(near, entry, range);
    for (Creature* c : near)
        if (c->IsAlive() && !c->IsEngaged() && c->AI())
            c->AI()->AttackStart(who);
}

// adds the boss brings into its fight: each attacks someone of the group
void BmhSummonAdds(Creature* me, uint32 entry, uint8 count, float spread)
{
    for (uint8 i = 0; i < count; ++i)
        if (Creature* add = me->SummonCreature(entry, me->GetRandomNearPosition(spread), TEMPSUMMON_CORPSE_TIMED_DESPAWN, 10s))
            if (Unit* target = me->AI()->SelectTarget(SelectTargetMethod::Random, 0, 60.0f, true))
                add->AI()->AttackStart(target);
}
}

class classic_instance_blackmaw_hold : public InstanceMapScript
{
public:
    classic_instance_blackmaw_hold() : InstanceMapScript("classic_instance_blackmaw_hold", CLASSIC_BMH_MAP_ID) { }

    struct classic_instance_blackmaw_hold_InstanceScript : public InstanceScript
    {
        classic_instance_blackmaw_hold_InstanceScript(InstanceMap* map) : InstanceScript(map)
        {
            SetHeaders("CBMH");
            SetBossNumber(CBMH_ENC_MAX);
            static constexpr DungeonEncounterData encounters[] =
            {
                { CBMH_ENC_WITHERMAW, {{ 3315 }} },
                { CBMH_ENC_IMPAAN, {{ 3316 }} },
                { CBMH_ENC_BLOODMANE, {{ 3327 }} },
                { CBMH_ENC_BONESNOUT, {{ 3322 }} },
                { CBMH_ENC_VARROX, {{ 3334 }} },
                { CBMH_ENC_BEHEMOTH, {{ 3323 }} },
                { CBMH_ENC_SPIRIT, {{ 3336 }} }
            };
            LoadDungeonEncounterData(encounters);
        }

        ClassicDungeonEncounterTracker _encounterTracker{ *this, ClassicBlackmawBossEntries };

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
        return new classic_instance_blackmaw_hold_InstanceScript(map);
    }
};

// ---------------------------------------------------------------------------------------------------------------------
// Withermaw (the Festering Grotto)
struct classic_boss_blackmaw_withermaw : public ScriptedAI
{
    classic_boss_blackmaw_withermaw(Creature* creature) : ScriptedAI(creature) { }

    enum : uint32 { EV_MAUL = 1, EV_ROAR, EV_MAGGOTS };

    void Reset() override { _events.Reset(); }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _events.ScheduleEvent(EV_MAUL, 5s);              // INFERRED timers
        _events.ScheduleEvent(EV_ROAR, 15s);
        _events.ScheduleEvent(EV_MAGGOTS, 10s);
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
                case EV_MAUL: DoCastVictim(SPELL_BMH_MAUL); _events.Repeat(10s, 14s); break;
                case EV_ROAR: DoCastSelf(SPELL_BMH_INTIMIDATING_ROAR); _events.Repeat(25s, 30s); break;
                case EV_MAGGOTS: BmhSummonAdds(me, NPC_BMH_FLESH_MAGGOT, 3, 6.0f); _events.Repeat(20s, 25s); break;
                default: break;
            }
        }
    }

private:
    EventMap _events;
};

// Bonesnout the Unbroken (Bonesnout's Thicket): a quarter less damage for each living Legashi Ritualist within 40 yards.
struct classic_boss_blackmaw_bonesnout : public ScriptedAI
{
    classic_boss_blackmaw_bonesnout(Creature* creature) : ScriptedAI(creature) { }

    enum : uint32 { EV_STOMP = 1, EV_TRAMPLE, EV_BULWARK };

    void Reset() override
    {
        _events.Reset();
        _ritualists = 0;
        me->RemoveAurasDueToSpell(SPELL_BMH_PROFANE_BULWARK);
    }

    void JustEngagedWith(Unit* who) override
    {
        BmhCallNear(me, NPC_BMH_RITUALIST, 40.0f, who);
        CountRitualists();
        _events.ScheduleEvent(EV_BULWARK, 1s);
        _events.ScheduleEvent(EV_TRAMPLE, 6s);           // INFERRED timers
        _events.ScheduleEvent(EV_STOMP, 15s);
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
                case EV_BULWARK: CountRitualists(); _events.Repeat(1s); break;
                case EV_TRAMPLE: DoCastSelf(SPELL_BMH_TRAMPLE); _events.Repeat(9s, 12s); break;
                case EV_STOMP: DoCastSelf(SPELL_BMH_STOMP); _events.Repeat(18s, 22s); break;
                default: break;
            }
        }
    }

private:
    // Profane Bulwark is the client's -25% damage taken; it is put on again with -25% per living Ritualist when the count changes
    void CountRitualists()
    {
        std::list<Creature*> ritualists;
        me->GetCreatureListWithEntryInGrid(ritualists, NPC_BMH_RITUALIST, 40.0f);
        uint32 alive = 0;
        for (Creature* r : ritualists)
            if (r->IsAlive())
                ++alive;
        alive = std::min<uint32>(alive, 4);
        if (alive == _ritualists && (alive == 0) == !me->HasAura(SPELL_BMH_PROFANE_BULWARK))
            return;
        _ritualists = alive;
        me->RemoveAurasDueToSpell(SPELL_BMH_PROFANE_BULWARK);
        if (alive)
            DoCastSelf(SPELL_BMH_PROFANE_BULWARK, CastSpellExtraArgs(TRIGGERED_FULL_MASK).AddSpellBP0(-25 * int32(alive)));
    }

    EventMap _events;
    uint32 _ritualists = 0;
};

// Impaan the Imprisoner (the Defiled Peak)
struct classic_boss_blackmaw_impaan : public ScriptedAI
{
    classic_boss_blackmaw_impaan(Creature* creature) : ScriptedAI(creature) { }

    enum : uint32 { EV_BOLT = 1, EV_IMPS };

    void Reset() override { _events.Reset(); }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _events.ScheduleEvent(EV_BOLT, 2s);              // INFERRED timers
        _events.ScheduleEvent(EV_IMPS, 20s);
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
                case EV_BOLT:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 40.0f, true))
                        DoCast(target, BmhImpaanBolts[urand(0, BmhImpaanBolts.size() - 1)]);
                    _events.Repeat(6s, 8s);
                    break;
                case EV_IMPS:
                    me->Yell("Imps!!", LANG_UNIVERSAL);
                    BmhSummonAdds(me, NPC_BMH_IMP, 3, 8.0f);
                    _events.Repeat(30s, 35s);
                    break;
                default: break;
            }
        }
    }

private:
    EventMap _events;
};

// Elder Shaman Bloodmane (the low chamber of the hold)
struct classic_boss_blackmaw_bloodmane : public ScriptedAI
{
    classic_boss_blackmaw_bloodmane(Creature* creature) : ScriptedAI(creature) { }

    enum : uint32 { EV_CHAIN = 1, EV_PURGE, EV_SPIRITS };

    void Reset() override { _events.Reset(); }

    void JustEngagedWith(Unit* who) override
    {
        BmhCallNear(me, NPC_BMH_DEVOTEE, 30.0f, who);
        _events.ScheduleEvent(EV_CHAIN, 4s);             // INFERRED timers
        _events.ScheduleEvent(EV_PURGE, 12s);
        _events.ScheduleEvent(EV_SPIRITS, 15s);
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
                case EV_CHAIN:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 40.0f, true))
                        DoCast(target, SPELL_BMH_CHAIN_LIGHTNING);
                    _events.Repeat(9s, 12s);
                    break;
                case EV_PURGE: DoCastSelf(SPELL_BMH_PURGE); _events.Repeat(18s, 22s); break;
                case EV_SPIRITS: BmhSummonAdds(me, NPC_BMH_FERAL_SPIRIT, 2, 5.0f); _events.Repeat(35s, 40s); break;
                default: break;
            }
        }
    }

private:
    EventMap _events;
};

// Unbound Spirit (the west room): untouchable until Elder Bramblesnap's ritual has run.
struct classic_boss_blackmaw_unbound_spirit : public ScriptedAI
{
    classic_boss_blackmaw_unbound_spirit(Creature* creature) : ScriptedAI(creature) { }

    enum : uint32 { EV_FIREBALL = 1, EV_NOVA };

    void JustAppeared() override
    {
        ScriptedAI::JustAppeared();
        Protect();
    }

    void Reset() override
    {
        _events.Reset();
        Protect();
    }

    // Purify takes the protection off: the Spirit can be fought
    void SpellHit(WorldObject* /*caster*/, SpellInfo const* spellInfo) override
    {
        if (spellInfo->Id == SPELL_BMH_PURIFY)
        {
            me->RemoveAurasDueToSpell(SPELL_BMH_PROFANE_PROTECTION);
            me->SetImmuneToPC(false);
        }
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _events.ScheduleEvent(EV_FIREBALL, 3s);          // INFERRED timers
        _events.ScheduleEvent(EV_NOVA, 10s);
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
                        DoCast(target, SPELL_BMH_FIREBALL);
                    _events.Repeat(7s, 9s);
                    break;
                case EV_NOVA:
                    DoCastSelf(SPELL_BMH_FIRE_NOVA);
                    _events.Repeat(14s, 18s);
                    break;
                default: break;
            }
        }
    }

private:
    // the Spirit stays out of reach (players can neither hit nor pull it) until it is purified
    void Protect()
    {
        if (!me->IsAlive())
            return;
        if (!me->HasAura(SPELL_BMH_PROFANE_PROTECTION))
            DoCastSelf(SPELL_BMH_PROFANE_PROTECTION, CastSpellExtraArgs(TRIGGERED_FULL_MASK));
        me->SetImmuneToPC(true);
    }

    EventMap _events;
};

// Elder Bramblesnap: his ritual brings three waves out of the Spirit, then he purifies it.
struct classic_npc_blackmaw_bramblesnap : public ScriptedAI
{
    classic_npc_blackmaw_bramblesnap(Creature* creature) : ScriptedAI(creature) { }

    enum : uint32 { EV_WAVE = 1, EV_CHECK, EV_PURIFY };

    void Reset() override
    {
        _events.Reset();
        _wave = 0;
        _started = false;
        _summons.clear();
    }

    bool OnGossipHello(Player* player) override
    {
        CloseGossipMenuFor(player);
        StartRitual();
        return true;
    }

    // a player who comes close starts it too (INFERRED: the guides say "talk to him")
    void MoveInLineOfSight(Unit* who) override
    {
        if (!_started && who->IsPlayer() && who->IsAlive() && me->IsWithinDistInMap(who, 15.0f))
            StartRitual();
    }

    void JustSummoned(Creature* summon) override { _summons.push_back(summon->GetGUID()); }

    void UpdateAI(uint32 diff) override
    {
        _events.Update(diff);
        while (uint32 ev = _events.ExecuteEvent())
        {
            switch (ev)
            {
                case EV_WAVE: SummonWave(); _events.ScheduleEvent(EV_CHECK, 3s); break;
                case EV_CHECK:
                    // the group wiped or left: the ritual stops, and runs again from the start next time
                    if (!me->SelectNearestPlayer(60.0f))
                    {
                        StopRitual();
                        break;
                    }
                    if (WaveAlive())
                    {
                        _events.Repeat(2s);
                        break;
                    }
                    if (_wave < 3)
                        _events.ScheduleEvent(EV_WAVE, 5s);
                    else
                        _events.ScheduleEvent(EV_PURIFY, 3s);
                    break;
                case EV_PURIFY:
                    DoCastSelf(SPELL_BMH_PURIFY, CastSpellExtraArgs(TRIGGERED_FULL_MASK));
                    if (Creature* spirit = me->FindNearestCreature(NPC_BMH_SPIRIT, 60.0f))
                    {
                        spirit->RemoveAurasDueToSpell(SPELL_BMH_PROFANE_PROTECTION);
                        spirit->SetImmuneToPC(false);
                    }
                    _started = false;   // if the group wipes on the Spirit, it is protected again and the ritual can rerun
                    _wave = 0;
                    break;
                default: break;
            }
        }
    }

private:
    void StopRitual()
    {
        for (ObjectGuid const& guid : _summons)
            if (Creature* add = ObjectAccessor::GetCreature(*me, guid))
                add->DespawnOrUnsummon();
        _summons.clear();
        _events.Reset();
        _wave = 0;
        _started = false;
    }

    void StartRitual()
    {
        if (_started)
            return;
        Creature* spirit = me->FindNearestCreature(NPC_BMH_SPIRIT, 60.0f);
        if (!spirit || !spirit->HasAura(SPELL_BMH_PROFANE_PROTECTION))
            return;
        _started = true;
        _events.ScheduleEvent(EV_WAVE, 2s);
    }

    void SummonWave()
    {
        Creature* spirit = me->FindNearestCreature(NPC_BMH_SPIRIT, 60.0f);
        if (!spirit)
            return;
        ++_wave;
        _summons.clear();
        uint32 const entry = _wave == 1 ? NPC_BMH_ETHEREAL_SPIDER : _wave == 2 ? NPC_BMH_ETHEREAL_WOLF : NPC_BMH_ETHEREAL_BEAR;
        uint8 const count = _wave == 1 ? 4 : _wave == 2 ? 3 : 1;    // INFERRED counts
        for (uint8 i = 0; i < count; ++i)
            if (Creature* add = me->SummonCreature(entry, spirit->GetRandomNearPosition(8.0f), TEMPSUMMON_CORPSE_TIMED_DESPAWN, 10s))
                if (Player* target = add->SelectNearestPlayer(60.0f))
                    add->AI()->AttackStart(target);
    }

    bool WaveAlive() const
    {
        for (ObjectGuid const& guid : _summons)
            if (Creature* add = ObjectAccessor::GetCreature(*me, guid))
                if (add->IsAlive())
                    return true;
        return false;
    }

    EventMap _events;
    std::vector<ObjectGuid> _summons;
    uint8 _wave = 0;
    bool _started = false;
};

// Clawbert, the Behemoth's keeper: Lightning Bolt, and Restore on the Behemoth when it is hurt.
struct classic_npc_blackmaw_clawbert : public ScriptedAI
{
    classic_npc_blackmaw_clawbert(Creature* creature) : ScriptedAI(creature) { }

    enum : uint32 { EV_BOLT = 1, EV_RESTORE };

    void Reset() override { _events.Reset(); }

    void JustEngagedWith(Unit* who) override
    {
        BmhCallNear(me, NPC_BMH_BEHEMOTH, 30.0f, who);
        _events.ScheduleEvent(EV_BOLT, 3s);              // INFERRED timers
        _events.ScheduleEvent(EV_RESTORE, 20s);
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
                case EV_BOLT:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 40.0f, true))
                        DoCast(target, SPELL_BMH_CLAWBERT_BOLT);
                    _events.Repeat(8s, 10s);
                    break;
                case EV_RESTORE:
                    // only when the Behemoth has lost half its health: a cast the group can interrupt or kill him through
                    if (Creature* behemoth = me->FindNearestCreature(NPC_BMH_BEHEMOTH, 25.0f); behemoth && behemoth->HealthBelowPct(50))
                    {
                        DoCast(behemoth, SPELL_BMH_RESTORE);
                        _events.Repeat(30s, 35s);
                    }
                    else
                        _events.Repeat(3s);
                    break;
                default: break;
            }
        }
    }

private:
    EventMap _events;
};

// Blackmaw Behemoth (the east cave): Bestial Roar and Whirlwind; at 25% it eats Clawbert and turns to Thunder Roar.
struct classic_boss_blackmaw_behemoth : public ScriptedAI
{
    classic_boss_blackmaw_behemoth(Creature* creature) : ScriptedAI(creature) { }

    enum : uint32 { EV_ROAR = 1, EV_WHIRLWIND, EV_THUNDER };

    void Reset() override
    {
        _events.Reset();
        _ate = false;
    }

    void JustEngagedWith(Unit* who) override
    {
        BmhCallNear(me, NPC_BMH_CLAWBERT, 30.0f, who);
        _events.ScheduleEvent(EV_ROAR, 8s);              // INFERRED timers
        _events.ScheduleEvent(EV_WHIRLWIND, 14s);
    }

    void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*type*/, SpellInfo const* /*spellInfo*/) override
    {
        if (_ate || !me->HealthBelowPctDamaged(25, damage))
            return;
        _ate = true;
        if (Creature* clawbert = me->FindNearestCreature(NPC_BMH_CLAWBERT, 60.0f); clawbert && clawbert->IsAlive())
        {
            me->TextEmote("The Blackmaw Behemoth devours Clawbert!");
            Unit::Kill(me, clawbert);
        }
        _events.ScheduleEvent(EV_THUNDER, 1s);
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
                case EV_ROAR: DoCastSelf(SPELL_BMH_BESTIAL_ROAR); _events.Repeat(25s, 30s); break;
                case EV_WHIRLWIND: DoCastSelf(SPELL_BMH_WHIRLWIND); _events.Repeat(20s, 25s); break;
                case EV_THUNDER: DoCastSelf(SPELL_BMH_THUNDER_ROAR); _events.Repeat(15s, 18s); break;
                default: break;
            }
        }
    }

private:
    EventMap _events;
    bool _ate = false;
};

// Varrox Bleakhoof (the end of the hold)
struct classic_boss_blackmaw_varrox : public ScriptedAI
{
    classic_boss_blackmaw_varrox(Creature* creature) : ScriptedAI(creature) { }

    enum : uint32 { EV_VOLLEY = 1, EV_FEAR, EV_WREST, EV_DETONATE };

    void Reset() override
    {
        _events.Reset();
        _seized.Clear();
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _events.ScheduleEvent(EV_VOLLEY, 6s);            // INFERRED timers
        _events.ScheduleEvent(EV_FEAR, 20s);
        _events.ScheduleEvent(EV_WREST, 12s);
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
                case EV_VOLLEY: DoCastSelf(SPELL_BMH_SHADOW_BOLT_VOLLEY); _events.Repeat(12s, 15s); break;
                case EV_FEAR: DoCastSelf(SPELL_BMH_FEAR); _events.Repeat(25s, 30s); break;
                case EV_WREST:
                    // one player is seized (the spell's own fear and slow on that player only)
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1, 40.0f, true))
                    {
                        me->AddAura(SPELL_BMH_CRIMSON_WREST, target);
                        _seized = target->GetGUID();
                        _events.ScheduleEvent(EV_DETONATE, 4s);
                    }
                    _events.Repeat(20s, 24s);
                    break;
                case EV_DETONATE:
                    // the burst comes from where the seized player stands: a stalker there casts it for Varrox
                    if (Unit* seized = ObjectAccessor::GetUnit(*me, _seized))
                        if (Creature* stalker = me->SummonCreature(NPC_BMH_STALKER, seized->GetPosition(), TEMPSUMMON_TIMED_DESPAWN, 5s))
                        {
                            stalker->SetFaction(me->GetFaction());
                            stalker->CastSpell(stalker, SPELL_BMH_NIGHTMARE_DETONATION, CastSpellExtraArgs(TRIGGERED_FULL_MASK).SetOriginalCaster(me->GetGUID()));
                        }
                    _seized.Clear();
                    break;
                default: break;
            }
        }
    }

private:
    EventMap _events;
    ObjectGuid _seized;
};

void AddSC_classic_instance_blackmaw_hold()
{
    new classic_instance_blackmaw_hold();
    RegisterCreatureAI(classic_boss_blackmaw_withermaw);
    RegisterCreatureAI(classic_boss_blackmaw_bonesnout);
    RegisterCreatureAI(classic_boss_blackmaw_impaan);
    RegisterCreatureAI(classic_boss_blackmaw_bloodmane);
    RegisterCreatureAI(classic_boss_blackmaw_unbound_spirit);
    RegisterCreatureAI(classic_npc_blackmaw_bramblesnap);
    RegisterCreatureAI(classic_npc_blackmaw_clawbert);
    RegisterCreatureAI(classic_boss_blackmaw_behemoth);
    RegisterCreatureAI(classic_boss_blackmaw_varrox);
}
