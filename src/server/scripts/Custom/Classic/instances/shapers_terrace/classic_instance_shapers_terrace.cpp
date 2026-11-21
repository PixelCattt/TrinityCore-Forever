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

// Classic 1.60 (Forever): The Shaper's Terrace (map 3001, levels 58-60). Encounters from the 70938 DungeonEncounter.db2 (map 3001,
// in their journal order): 3498 Titanosaur, 3499 Tor'Rel and Izha'Rel, 3500 Thunderhoof, 3501 Venomridge, 3507 the Direhorn
// Matriarch, 3503 Cinder, 3504 King Op, 3597 Snowtalon, 3505 Bolt, 3600 Vitrix, 3502 Nanaya.
//
// Which spells each boss casts is from Everlake's Forever dungeon work (github.com/buildthehomelab, GPL), which takes them from the
// public dungeon guides; every spell id was checked in our 70938 client and is cast with the client's values (the spells new to
// Forever scale with the caster's level by themselves). This file is our own code. INFERRED (no sniff or combat log exists yet):
// every timer, who each spell goes at where the client leaves it open, and the parts of the fights described below as ours.
//
//   Titanosaur: Mighty Blow on the tank (knocks back), Terrifying Roar (fear around him).
//   Tor'Rel and Izha'Rel (one encounter, both must die): pulling one brings the other. Tor'Rel claws the tank with Fiery Talons,
//     Izha'Rel puts Chilled and Frost Shock on others. Ours: when one of them dies, the other goes Berserk.
//   Thunderhoof: Thunderclap, Shock and Chain Lightning. (His Lightning Cloud makes the client's area trigger 43486, which no
//     data we have describes, so he does not cast it.)
//   Venomridge: Tendon Rip on the tank, Poison Bolt Volley.
//   Direhorn Matriarch: Tail Lash (stun around her), Puncture on the tank, Trihorn Charge at someone else.
//   Cinder: Radiating Heat (burns around him), Conflagration on someone (it then burns the players next to them).
//   King Op: Shock; the Eastgrotto gorillas around him join.
//   Snowtalon: Frost Nova, Howling Blast at someone.
//   Bolt: Thunderclap, Chain Lightning.
//   Vitrix: Leech Poison and Poison Shock at someone.
//   Nanaya: Powerful Slam (stun around her), Sonic Screech (cone), and the powers of the four Archival Panels in turn, 20 s each
//     (ours: the panels' order and length): blue Blizzard on someone, red Blast Wave, green Poison Cloud, yellow Chain Lightning.
//     Her own Blizzard and Poison Cloud make client area triggers no data describes (42519, 42526): she casts the NPC Blizzard
//     8364 at a player's spot and Poison Cloud 3815 instead.

#include "ScriptMgr.h"
#include "Creature.h"
#include "InstanceScript.h"
#include "Map.h"
#include "ScriptedCreature.h"
#include "SpellInfo.h"
#include "classic_dungeon_encounter_tracker.h"
#include <iterator>
#include <list>
#include <span>

namespace
{
constexpr uint32 CLASSIC_ST_MAP_ID = 3001;

enum ClassicShapersBosses : uint32
{
    CST_ENC_TITANOSAUR = 0,
    CST_ENC_RAVASAUR_HUNTERS = 1,
    CST_ENC_THUNDERHOOF = 2,
    CST_ENC_VENOMRIDGE = 3,
    CST_ENC_DIREHORN_MATRIARCH = 4,
    CST_ENC_CINDER = 5,
    CST_ENC_KING_OP = 6,
    CST_ENC_SNOWTALON = 7,
    CST_ENC_BOLT = 8,
    CST_ENC_VITRIX = 9,
    CST_ENC_NANAYA = 10,
    CST_ENC_MAX
};

enum ClassicShapersCreatures : uint32
{
    NPC_CST_TITANOSAUR = 253201,
    NPC_CST_IZHAREL = 253218,
    NPC_CST_NANAYA = 261809,
    NPC_CST_TORREL = 261811,
    NPC_CST_THUNDERHOOF = 261812,
    NPC_CST_VENOMRIDGE = 261813,
    NPC_CST_CINDER = 261974,
    NPC_CST_KING_OP = 261993,
    NPC_CST_BOLT = 262081,
    NPC_CST_DIREHORN_MATRIARCH = 262127,
    NPC_CST_SNOWTALON = 262297,
    NPC_CST_VITRIX = 272561,
    NPC_CST_EASTGROTTO_GORILLA = 262299,
    NPC_CST_EASTGROTTO_DWELLER = 262300,
    NPC_CST_EASTGROTTO_SILVERBACK = 262301
};

enum ClassicShapersSpells : uint32
{
    // all present in the 70938 client
    SPELL_CST_MIGHTY_BLOW = 1294312,
    SPELL_CST_TERRIFYING_ROAR = 1294313,
    SPELL_CST_BERSERK = 1287747,
    SPELL_CST_FIERY_TALONS = 1287756,
    SPELL_CST_CHILLED = 6136,
    SPELL_CST_FROST_SHOCK = 15089,
    SPELL_CST_THUNDERCLAP_HOOF = 8078,
    SPELL_CST_SHOCK = 12553,
    SPELL_CST_CHAIN_LIGHTNING = 1310513,
    SPELL_CST_TENDON_RIP = 3604,
    SPELL_CST_POISON_BOLT_VOLLEY = 1310365,
    SPELL_CST_TAIL_LASH = 1287872,
    SPELL_CST_TRIHORN_CHARGE = 1287876,
    SPELL_CST_PUNCTURE = 1287886,
    SPELL_CST_RADIATING_HEAT = 1310267,
    SPELL_CST_CONFLAGRATION = 1310512,
    SPELL_CST_FROST_NOVA = 1310354,
    SPELL_CST_HOWLING_BLAST = 1310514,
    SPELL_CST_THUNDERCLAP_BOLT = 15588,
    SPELL_CST_LEECH_POISON = 1312869,
    SPELL_CST_POISON_SHOCK = 1312870,
    SPELL_CST_POWERFUL_SLAM = 1290463,
    SPELL_CST_SONIC_SCREECH = 1290464,
    SPELL_CST_NANAYA_BLIZZARD = 8364,          // the NPC Blizzard (her own 1291167 needs area trigger 42519)
    SPELL_CST_BLAST_WAVE = 1291176,
    SPELL_CST_NANAYA_POISON_CLOUD = 3815,      // Poison Cloud around the caster (her own 1291274 needs area trigger 42526)
    SPELL_CST_NANAYA_CHAIN_LIGHTNING = 1291380
};

constexpr ClassicDungeonBossEntry ClassicShapersBossEntries[] =
{
    { CST_ENC_TITANOSAUR, NPC_CST_TITANOSAUR },
    { CST_ENC_RAVASAUR_HUNTERS, NPC_CST_TORREL },
    { CST_ENC_RAVASAUR_HUNTERS, NPC_CST_IZHAREL },
    { CST_ENC_THUNDERHOOF, NPC_CST_THUNDERHOOF },
    { CST_ENC_VENOMRIDGE, NPC_CST_VENOMRIDGE },
    { CST_ENC_DIREHORN_MATRIARCH, NPC_CST_DIREHORN_MATRIARCH },
    { CST_ENC_CINDER, NPC_CST_CINDER },
    { CST_ENC_KING_OP, NPC_CST_KING_OP },
    { CST_ENC_SNOWTALON, NPC_CST_SNOWTALON },
    { CST_ENC_BOLT, NPC_CST_BOLT },
    { CST_ENC_VITRIX, NPC_CST_VITRIX },
    { CST_ENC_NANAYA, NPC_CST_NANAYA }
};

// who an ability goes at
enum class CstTarget : uint8
{
    Self,       // the spell picks its targets around the boss
    Tank,       // the boss's victim
    Anyone,     // someone of the group at random
    NotTank,    // someone at random but the tank (falls back to the tank when alone)
    Spot        // the ground under someone at random
};

struct CstAbility
{
    uint32 Spell;
    CstTarget Target;
    Milliseconds First;
    Milliseconds RepeatMin;
    Milliseconds RepeatMax;
};

// A boss of the terrace: its abilities on their own timers (INFERRED), and the creatures that join it when it is pulled.
struct classic_shapers_boss : public ScriptedAI
{
    classic_shapers_boss(Creature* creature, std::span<CstAbility const> abilities) : ScriptedAI(creature), _abilities(abilities) { }

    void Reset() override { _events.Reset(); }

    void JustEngagedWith(Unit* who) override
    {
        for (uint32 i = 0; i < _abilities.size(); ++i)
            _events.ScheduleEvent(i + 1, _abilities[i].First);
        CallHelpers(who);
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
            if (ev > _abilities.size())
            {
                OnExtraEvent(ev);
                continue;
            }
            CstAbility const& ability = _abilities[ev - 1];
            if (CanUse(ability))
                Use(ability);
            _events.Repeat(ability.RepeatMin, ability.RepeatMax);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;
        }
    }

protected:
    // the creatures standing near the boss that join its fight
    virtual void CallHelpers(Unit* /*who*/) { }
    // events past the ability list
    virtual void OnExtraEvent(uint32 /*ev*/) { }
    // whether an ability may be used now (Nanaya: only her current panel's)
    virtual bool CanUse(CstAbility const& /*ability*/) const { return true; }

    void Use(CstAbility const& ability)
    {
        switch (ability.Target)
        {
            case CstTarget::Self:
                DoCastSelf(ability.Spell);
                break;
            case CstTarget::Tank:
                DoCastVictim(ability.Spell);
                break;
            case CstTarget::Anyone:
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 40.0f, true))
                    DoCast(target, ability.Spell);
                break;
            case CstTarget::NotTank:
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1, 40.0f, true))
                    DoCast(target, ability.Spell);
                else
                    DoCastVictim(ability.Spell);
                break;
            case CstTarget::Spot:
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 40.0f, true))
                    me->CastSpell(target->GetPosition(), ability.Spell, CastSpellExtraArgs());
                break;
        }
    }

    void CallNear(uint32 entry, float range, Unit* who)
    {
        if (!who)
            return;
        std::list<Creature*> near;
        me->GetCreatureListWithEntryInGrid(near, entry, range);
        for (Creature* c : near)
            if (c->IsAlive() && !c->IsEngaged() && c->AI())
                c->AI()->AttackStart(who);
    }

    EventMap _events;

private:
    std::span<CstAbility const> _abilities;
};

constexpr CstAbility CstTitanosaurAbilities[] =
{
    { SPELL_CST_MIGHTY_BLOW, CstTarget::Tank, 7s, 10s, 14s },
    { SPELL_CST_TERRIFYING_ROAR, CstTarget::Self, 15s, 25s, 30s }
};

constexpr CstAbility CstTorRelAbilities[] =
{
    { SPELL_CST_FIERY_TALONS, CstTarget::Tank, 5s, 8s, 11s }
};

constexpr CstAbility CstIzhaRelAbilities[] =
{
    { SPELL_CST_CHILLED, CstTarget::NotTank, 4s, 12s, 15s },
    { SPELL_CST_FROST_SHOCK, CstTarget::Anyone, 8s, 9s, 12s }
};

constexpr CstAbility CstThunderhoofAbilities[] =
{
    { SPELL_CST_THUNDERCLAP_HOOF, CstTarget::Self, 10s, 15s, 20s },
    { SPELL_CST_SHOCK, CstTarget::Anyone, 5s, 8s, 12s },
    { SPELL_CST_CHAIN_LIGHTNING, CstTarget::Anyone, 12s, 12s, 16s }
};

constexpr CstAbility CstVenomridgeAbilities[] =
{
    { SPELL_CST_TENDON_RIP, CstTarget::Tank, 5s, 8s, 12s },
    { SPELL_CST_POISON_BOLT_VOLLEY, CstTarget::Self, 10s, 15s, 20s }
};

constexpr CstAbility CstDirehornAbilities[] =
{
    { SPELL_CST_PUNCTURE, CstTarget::Tank, 6s, 8s, 12s },
    { SPELL_CST_TAIL_LASH, CstTarget::Self, 12s, 15s, 20s },
    { SPELL_CST_TRIHORN_CHARGE, CstTarget::NotTank, 9s, 18s, 22s }
};

constexpr CstAbility CstCinderAbilities[] =
{
    { SPELL_CST_RADIATING_HEAT, CstTarget::Self, 8s, 20s, 25s },
    { SPELL_CST_CONFLAGRATION, CstTarget::NotTank, 12s, 15s, 20s }
};

constexpr CstAbility CstKingOpAbilities[] =
{
    { SPELL_CST_SHOCK, CstTarget::Anyone, 4s, 7s, 10s }
};

constexpr CstAbility CstSnowtalonAbilities[] =
{
    { SPELL_CST_FROST_NOVA, CstTarget::Self, 10s, 15s, 20s },
    { SPELL_CST_HOWLING_BLAST, CstTarget::Anyone, 6s, 9s, 12s }
};

constexpr CstAbility CstBoltAbilities[] =
{
    { SPELL_CST_THUNDERCLAP_BOLT, CstTarget::Self, 10s, 15s, 20s },
    { SPELL_CST_CHAIN_LIGHTNING, CstTarget::Anyone, 6s, 9s, 12s }
};

constexpr CstAbility CstVitrixAbilities[] =
{
    { SPELL_CST_LEECH_POISON, CstTarget::Anyone, 5s, 12s, 15s },
    { SPELL_CST_POISON_SHOCK, CstTarget::Anyone, 8s, 9s, 12s }
};

// Nanaya: the first two all fight; the other four are one panel each, used only while that panel's power is hers
constexpr CstAbility CstNanayaAbilities[] =
{
    { SPELL_CST_POWERFUL_SLAM, CstTarget::Self, 12s, 18s, 22s },
    { SPELL_CST_SONIC_SCREECH, CstTarget::Tank, 8s, 14s, 18s },
    { SPELL_CST_NANAYA_BLIZZARD, CstTarget::Spot, 3s, 9s, 11s },             // blue panel
    { SPELL_CST_BLAST_WAVE, CstTarget::Self, 3s, 8s, 10s },                  // red panel
    { SPELL_CST_NANAYA_POISON_CLOUD, CstTarget::Self, 3s, 9s, 11s },         // green panel
    { SPELL_CST_NANAYA_CHAIN_LIGHTNING, CstTarget::Anyone, 3s, 6s, 8s }      // yellow panel
};
}

class classic_instance_shapers_terrace : public InstanceMapScript
{
public:
    classic_instance_shapers_terrace() : InstanceMapScript("classic_instance_shapers_terrace", CLASSIC_ST_MAP_ID) { }

    struct classic_instance_shapers_terrace_InstanceScript : public InstanceScript
    {
        classic_instance_shapers_terrace_InstanceScript(InstanceMap* map) : InstanceScript(map)
        {
            SetHeaders("CST");
            SetBossNumber(CST_ENC_MAX);
            static constexpr DungeonEncounterData encounters[] =
            {
                { CST_ENC_TITANOSAUR, {{ 3498 }} },
                { CST_ENC_RAVASAUR_HUNTERS, {{ 3499 }} },
                { CST_ENC_THUNDERHOOF, {{ 3500 }} },
                { CST_ENC_VENOMRIDGE, {{ 3501 }} },
                { CST_ENC_DIREHORN_MATRIARCH, {{ 3507 }} },
                { CST_ENC_CINDER, {{ 3503 }} },
                { CST_ENC_KING_OP, {{ 3504 }} },
                { CST_ENC_SNOWTALON, {{ 3597 }} },
                { CST_ENC_BOLT, {{ 3505 }} },
                { CST_ENC_VITRIX, {{ 3600 }} },
                { CST_ENC_NANAYA, {{ 3502 }} }
            };
            LoadDungeonEncounterData(encounters);
        }

        ClassicDungeonEncounterTracker _encounterTracker{ *this, ClassicShapersBossEntries };

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
        return new classic_instance_shapers_terrace_InstanceScript(map);
    }
};

// ---------------------------------------------------------------------------------------------------------------------
struct classic_boss_shapers_titanosaur : public classic_shapers_boss
{
    classic_boss_shapers_titanosaur(Creature* creature) : classic_shapers_boss(creature, CstTitanosaurAbilities) { }
};

// Tor'Rel and Izha'Rel, the Ravasaur Hunters: pulled together; the one left alive goes Berserk (ours).
struct classic_shapers_ravasaur_hunter : public classic_shapers_boss
{
    classic_shapers_ravasaur_hunter(Creature* creature, std::span<CstAbility const> abilities, uint32 mate)
        : classic_shapers_boss(creature, abilities), _mate(mate) { }

    void JustDied(Unit* /*killer*/) override
    {
        if (Creature* mate = me->FindNearestCreature(_mate, 80.0f); mate && mate->IsAlive() && mate->IsEngaged())
            mate->CastSpell(mate, SPELL_CST_BERSERK, CastSpellExtraArgs(TRIGGERED_FULL_MASK));
    }

protected:
    void CallHelpers(Unit* who) override { CallNear(_mate, 40.0f, who); }

private:
    uint32 _mate;
};

struct classic_boss_shapers_torrel : public classic_shapers_ravasaur_hunter
{
    classic_boss_shapers_torrel(Creature* creature) : classic_shapers_ravasaur_hunter(creature, CstTorRelAbilities, NPC_CST_IZHAREL) { }
};

struct classic_boss_shapers_izharel : public classic_shapers_ravasaur_hunter
{
    classic_boss_shapers_izharel(Creature* creature) : classic_shapers_ravasaur_hunter(creature, CstIzhaRelAbilities, NPC_CST_TORREL) { }
};

struct classic_boss_shapers_thunderhoof : public classic_shapers_boss
{
    classic_boss_shapers_thunderhoof(Creature* creature) : classic_shapers_boss(creature, CstThunderhoofAbilities) { }
};

struct classic_boss_shapers_venomridge : public classic_shapers_boss
{
    classic_boss_shapers_venomridge(Creature* creature) : classic_shapers_boss(creature, CstVenomridgeAbilities) { }
};

struct classic_boss_shapers_direhorn_matriarch : public classic_shapers_boss
{
    classic_boss_shapers_direhorn_matriarch(Creature* creature) : classic_shapers_boss(creature, CstDirehornAbilities) { }
};

struct classic_boss_shapers_cinder : public classic_shapers_boss
{
    classic_boss_shapers_cinder(Creature* creature) : classic_shapers_boss(creature, CstCinderAbilities) { }
};

// King Op: the gorillas of the east grotto come to his call.
struct classic_boss_shapers_king_op : public classic_shapers_boss
{
    classic_boss_shapers_king_op(Creature* creature) : classic_shapers_boss(creature, CstKingOpAbilities) { }

protected:
    void CallHelpers(Unit* who) override
    {
        CallNear(NPC_CST_EASTGROTTO_GORILLA, 30.0f, who);
        CallNear(NPC_CST_EASTGROTTO_DWELLER, 30.0f, who);
        CallNear(NPC_CST_EASTGROTTO_SILVERBACK, 30.0f, who);
    }
};

struct classic_boss_shapers_snowtalon : public classic_shapers_boss
{
    classic_boss_shapers_snowtalon(Creature* creature) : classic_shapers_boss(creature, CstSnowtalonAbilities) { }
};

struct classic_boss_shapers_bolt : public classic_shapers_boss
{
    classic_boss_shapers_bolt(Creature* creature) : classic_shapers_boss(creature, CstBoltAbilities) { }
};

struct classic_boss_shapers_vitrix : public classic_shapers_boss
{
    classic_boss_shapers_vitrix(Creature* creature) : classic_shapers_boss(creature, CstVitrixAbilities) { }
};

// Nanaya: Powerful Slam and Sonic Screech all fight, and one Archival Panel's power at a time, 20 s each (blue, red, green, yellow).
struct classic_boss_shapers_nanaya : public classic_shapers_boss
{
    classic_boss_shapers_nanaya(Creature* creature) : classic_shapers_boss(creature, CstNanayaAbilities) { }

    static constexpr uint32 EV_NEXT_PANEL = std::size(CstNanayaAbilities) + 1;
    static constexpr uint8 FIRST_PANEL_ABILITY = 2;
    static constexpr uint8 PANELS = 4;

    void Reset() override
    {
        classic_shapers_boss::Reset();
        _panel = 0;
    }

    void JustEngagedWith(Unit* who) override
    {
        classic_shapers_boss::JustEngagedWith(who);
        _panel = 0;
        _events.ScheduleEvent(EV_NEXT_PANEL, 20s);
    }

protected:
    void OnExtraEvent(uint32 ev) override
    {
        if (ev != EV_NEXT_PANEL)
            return;
        _panel = (_panel + 1) % PANELS;
        _events.Repeat(20s);
    }

    bool CanUse(CstAbility const& ability) const override
    {
        for (uint8 i = 0; i < PANELS; ++i)
            if (CstNanayaAbilities[FIRST_PANEL_ABILITY + i].Spell == ability.Spell)
                return i == _panel;
        return true;
    }

private:
    uint8 _panel = 0;
};

void AddSC_classic_instance_shapers_terrace()
{
    new classic_instance_shapers_terrace();
    RegisterCreatureAI(classic_boss_shapers_titanosaur);
    RegisterCreatureAI(classic_boss_shapers_torrel);
    RegisterCreatureAI(classic_boss_shapers_izharel);
    RegisterCreatureAI(classic_boss_shapers_thunderhoof);
    RegisterCreatureAI(classic_boss_shapers_venomridge);
    RegisterCreatureAI(classic_boss_shapers_direhorn_matriarch);
    RegisterCreatureAI(classic_boss_shapers_cinder);
    RegisterCreatureAI(classic_boss_shapers_king_op);
    RegisterCreatureAI(classic_boss_shapers_snowtalon);
    RegisterCreatureAI(classic_boss_shapers_bolt);
    RegisterCreatureAI(classic_boss_shapers_vitrix);
    RegisterCreatureAI(classic_boss_shapers_nanaya);
}
