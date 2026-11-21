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

// Classic 1.60 (Forever): City of Dalaran (map 2959, levels 28-33). Spawns and loot were already in the world DB; this file adds
// the instance, the boss fights, the way in and the way to the last boss. Encounters from the 70862 DungeonEncounter.db2:
// 3311 Atrexis the Grave Knight, 3310 Lyn the Ignored, 3298 Arcane Anomaly, 3301 Arcanic Enigma (the client calls the
// encounter "Mana Elemental"), 3302 Unstable Sentinel, 3300 Mana Devourer, 3299 Fel Ancient, 3303 Shade of the Archmage.
//
// No sniff of any fight exists. The abilities come from the public dungeon guides (Forever 1.60.1). Where a live kill showed
// which spell id a boss casts, that id is used (Strike 12057, Disarm 6713, Unholy Frenzy 1303264, Curse of Thorns 1304473,
// Arcing Smash 16169, Arcane Bolt 1240682 and 1241506, Evocation 1303599; all in the 70862 client):
// Data from Efficient Games (https://efficient.games), licensed under CC BY 4.0 (EG Link output for 1.60.1.70338, creature
// spell casts of one full run). Changed: only the spell ids are taken. Some live effects are server-side (Focal Blast area
// trigger, Bounding Mana and Fel Timbers are dummies, Malfunction pulses), so those are rebuilt here, with damage values
// picked for a level 28-33 group. Every timer and every number marked INFERRED below is a guess, not live data.
//
// 19 Nov: every boss spell checked against the live casts of many runs (EG Link combat logs, builds 70205-70959, all players
// merged: casts per pull, no timestamps). The ids live casts replace our stand-ins (Shadow Bolt Volley 17228, Silence 8988,
// Entangle 1240688, Debilitate 1240750, Malfunction's pulse 1241325), the live spells we lacked are in (Fel Ancient's
// Trample, the Shade's Arcane Explosion and Slow), and each repeat timer is set so a fight of the boss's live health (about
// 230 damage a second from a level 30 group, INFERRED) casts each spell about as often per pull as live does.
//
// The way in: the Sewer Grate (656283) outside the city, map 0 (388.8, 537.4, 45.8). It needs the Dalaran Sewer Key
// (277507); one key opens it for the whole group (guides), so a group member near the grate with the key is enough. Ghosts can
// always go through, for the corpse run. The landing spot is the sewer start next to Rexxie Copperclutch (INFERRED: the
// live landing spot is not known; this one is on the same navmesh as every boss, checked offline).
//
// The way to the last boss: the Portal To the Violet Chamber (656243) casts 1297791, which the client does not have, so the
// portal did nothing. It now takes the player up to the Purple Parlor once Mana Devourer and Fel Ancient are dead, and the
// portal in the Parlor (656320, spell 1297938, also missing) takes them back down.
//
// Fel Ancient stands behind Prismatic Doors (555247). Live opens them through Grindle Firespark, who has no spawn in our
// data, so the doors open when the three bosses of the city squares (Arcane Anomaly, Arcanic Enigma, Unstable Sentinel) are
// dead (INFERRED).

#include "WorldSession.h"
#include "ScriptMgr.h"
#include "Creature.h"
#include "GameObject.h"
#include "GameObjectAI.h"
#include "Chat.h"
#include "Group.h"
#include "InstanceScript.h"
#include "Map.h"
#include "MotionMaster.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellInfo.h"
#include "TemporarySummon.h"
#include "classic_dungeon_encounter_tracker.h"
#include <vector>

namespace
{
constexpr uint32 CLASSIC_COD_MAP_ID = 2959;

enum ClassicCityOfDalaranBosses : uint32
{
    CCOD_ENC_ATREXIS = 0,
    CCOD_ENC_LYN = 1,
    CCOD_ENC_ARCANE_ANOMALY = 2,
    CCOD_ENC_ARCANIC_ENIGMA = 3,
    CCOD_ENC_UNSTABLE_SENTINEL = 4,
    CCOD_ENC_MANA_DEVOURER = 5,
    CCOD_ENC_FEL_ANCIENT = 6,
    CCOD_ENC_SHADE = 7,
    CCOD_ENC_MAX
};

enum ClassicCityOfDalaranCreatures : uint32
{
    NPC_COD_ARCANE_ANOMALY = 245999,
    NPC_COD_FEL_ANCIENT = 246003,
    NPC_COD_MANA_DEVOURER = 246008,
    NPC_COD_ARCANIC_ENIGMA = 246016,
    NPC_COD_UNSTABLE_SENTINEL = 246017,
    NPC_COD_SHADE = 246020,
    NPC_COD_LYN = 247032,
    NPC_COD_ATREXIS = 247126,
    NPC_COD_ARCANE_MANALING = 246890,   // the live Summon Manaling creature 269467 has no template; this is the dungeon's own Arcane Manaling
    NPC_COD_RISEN_TERROR = 255065       // Raise Dead adds: the sewer undead of the same dungeon (INFERRED)
};

enum ClassicCityOfDalaranObjects : uint32
{
    GO_COD_PRISMATIC_DOOR_FEL_ANCIENT = 555247,
    GO_COD_FEL_CRACKS = 553754,
    GO_COD_SEWER_GRATE = 656283,
    GO_COD_PORTAL_TO_PARLOR = 656243,
    GO_COD_PORTAL_FROM_PARLOR = 656320,
    GO_COD_CITY_DOOR = 665036
};

enum ClassicCityOfDalaranItems : uint32
{
    ITEM_COD_DALARAN_SEWER_KEY = 277507
};

enum ClassicCityOfDalaranSpells : uint32
{
    // all present in the 70862 client
    SPELL_COD_DISARM = 6713,
    SPELL_COD_STRIKE = 12057,
    SPELL_COD_THRASH = 3391,
    SPELL_COD_UNHOLY_FRENZY = 1303264,
    SPELL_COD_SHADOW_BOLT_VOLLEY = 17228,   // live id (9081 is never cast)
    SPELL_COD_CURSE_OF_THORNS = 1304473,
    SPELL_COD_ARCANE_BOLT = 1240682,        // Arcane Anomaly's live bolt
    SPELL_COD_SHADE_ARCANE_BOLT = 1241506,  // the Shade's live bolt
    SPELL_COD_FOCAL_BLAST = 1241501,        // live spell; its area trigger is server-side, so it is cast for the look only
    SPELL_COD_MANAMORPH = 1240869,
    SPELL_COD_SILENCE = 8988,               // live id: 15 yd around the caster
    SPELL_COD_SUMMON_MANALING = 1304455,    // cast for the look; its creature 269467 has no template
    SPELL_COD_ARCING_SMASH = 16169,
    SPELL_COD_MALFUNCTION_PULSE = 1241325,  // the 25 yd Arcane Explosion live Malfunction (1241329) fires every 2 s
    SPELL_COD_ENTANGLE = 1240688,           // live id: root + damage over time on everyone within 15 yd
    SPELL_COD_TRAMPLE = 1240687,            // live: damage to everyone within 10 yd
    SPELL_COD_FEL_TIMBERS = 1240692,        // live dummy, cast for the look
    SPELL_COD_FELFIRE = 24530,
    SPELL_COD_DRAIN_VITALITY = 1240738,
    SPELL_COD_DEBILITATE = 1240750,         // live id: mana burn on everyone within 45 yd
    SPELL_COD_BOUNDING_MANA = 1241515,      // live dummy, cast for the look
    SPELL_COD_MASS_POLYMORPH = 1303598,
    SPELL_COD_EVOCATION = 1303599,
    SPELL_COD_ARCANE_EXPLOSION = 1304398,   // live: the Shade's 10 yd blast
    SPELL_COD_SLOW = 1303350                // live: the Shade slows everyone within 20 yd
};

// INFERRED landing spots (no sniff): on the navmesh, each one checked with dungeon_reach_check
constexpr Position CodSewerLanding = { 309.8f, 384.0f, 67.5f, 3.90f };
constexpr Position CodParlorLanding = { 440.0f, 360.0f, 294.0f, 6.05f };
constexpr Position CodParlorExitLanding = { 424.0f, 372.0f, 129.1f, 3.80f };

constexpr float CodGrateKeyRange = 40.0f;
constexpr float CodShadeRoomRadius = 32.0f;         // the Parlor is about 48 x 41 yd; leaving it resets the Shade (guides)

constexpr ClassicDungeonBossEntry ClassicCityOfDalaranBossEntries[] =
{
    { CCOD_ENC_ATREXIS, NPC_COD_ATREXIS },
    { CCOD_ENC_LYN, NPC_COD_LYN },
    { CCOD_ENC_ARCANE_ANOMALY, NPC_COD_ARCANE_ANOMALY },
    { CCOD_ENC_ARCANIC_ENIGMA, NPC_COD_ARCANIC_ENIGMA },
    { CCOD_ENC_UNSTABLE_SENTINEL, NPC_COD_UNSTABLE_SENTINEL },
    { CCOD_ENC_MANA_DEVOURER, NPC_COD_MANA_DEVOURER },
    { CCOD_ENC_FEL_ANCIENT, NPC_COD_FEL_ANCIENT },
    { CCOD_ENC_SHADE, NPC_COD_SHADE }
};

// players of the instance within range of a point, alive and attackable by the caster
std::vector<Player*> CodPlayersNear(Creature* me, Position const& pos, float range)
{
    std::vector<Player*> out;
    for (MapReference const& ref : me->GetMap()->GetPlayers())
    {
        Player* player = ref.GetSource();
        if (player && player->IsAlive() && !player->IsGameMaster() && player->GetExactDist(&pos) <= range
            && me->IsValidAttackTarget(player))
            out.push_back(player);
    }
    return out;
}

// a damage spell from the client with our own damage value, so the hit shows in the combat log under that spell's name
void CodHit(Creature* me, Unit* target, uint32 spellId, int32 damage)
{
    CastSpellExtraArgs args(TRIGGERED_FULL_MASK);
    args.AddSpellBP0(damage);
    me->CastSpell(target, spellId, args);
}

// a raised or summoned add joins the fight at once
void CodAddJoins(Creature* me, TempSummon* add)
{
    if (!add)
        return;
    if (Unit* target = me->GetAI()->SelectTarget(SelectTargetMethod::Random, 0, 0.0f, true))
        add->AI()->AttackStart(target);
}
}

class classic_instance_city_of_dalaran : public InstanceMapScript
{
public:
    classic_instance_city_of_dalaran() : InstanceMapScript("classic_instance_city_of_dalaran", CLASSIC_COD_MAP_ID) { }

    struct classic_instance_city_of_dalaran_InstanceScript : public InstanceScript
    {
        classic_instance_city_of_dalaran_InstanceScript(InstanceMap* map) : InstanceScript(map)
        {
            SetHeaders("CCOD");
            SetBossNumber(CCOD_ENC_MAX);
            static constexpr DungeonEncounterData encounters[] =
            {
                { CCOD_ENC_ATREXIS, {{ 3311 }} },
                { CCOD_ENC_LYN, {{ 3310 }} },
                { CCOD_ENC_ARCANE_ANOMALY, {{ 3298 }} },
                { CCOD_ENC_ARCANIC_ENIGMA, {{ 3301 }} },
                { CCOD_ENC_UNSTABLE_SENTINEL, {{ 3302 }} },
                { CCOD_ENC_MANA_DEVOURER, {{ 3300 }} },
                { CCOD_ENC_FEL_ANCIENT, {{ 3299 }} },
                { CCOD_ENC_SHADE, {{ 3303 }} }
            };
            LoadDungeonEncounterData(encounters);
        }

        ClassicDungeonEncounterTracker _encounterTracker{ *this, ClassicCityOfDalaranBossEntries };
        std::vector<ObjectGuid> _felAncientDoors;
        std::vector<ObjectGuid> _cityDoors;

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

        void OnGameObjectCreate(GameObject* go) override
        {
            InstanceScript::OnGameObjectCreate(go);
            // This runs inside GameObject::AddToWorld, before the object is in the map's object store, so instance->GetGameObject()
            // cannot find it yet: a door made while its bosses are already dead (a respawn, or the grid loading after a restart) was
            // never opened. The city door is opened here on the object itself; a Prismatic Door cannot be deleted in the middle of
            // being added, so Update() removes it on the next map tick.
            if (go->GetEntry() == GO_COD_PRISMATIC_DOOR_FEL_ANCIENT)
                _felAncientDoors.push_back(go->GetGUID());
            else if (go->GetEntry() == GO_COD_CITY_DOOR)
            {
                _cityDoors.push_back(go->GetGUID());
                if (SewerBossesDone())
                    go->SetGoState(GO_STATE_ACTIVE);
            }
        }

        void OnUnitDeath(Unit* unit) override
        {
            _encounterTracker.OnUnitDeath(unit);
        }

        void Update(uint32 diff) override
        {
            _encounterTracker.Update(diff);
            if (!_felAncientDoors.empty() && SquareBossesDone())
                UpdateFelAncientDoors();
        }

        bool SetBossState(uint32 id, EncounterState state) override
        {
            if (!InstanceScript::SetBossState(id, state))
                return false;
            if (state == DONE)
            {
                UpdateFelAncientDoors();
                UpdateCityDoors();
            }
            return true;
        }

        // The round door at the top of the sewer hill (665036) leads from the Underbelly up to the city: it opens once both sewer
        // bosses, Atrexis and Lyn, are dead (INFERRED: no live data on what opens it; the guides do the sewers first).
        bool SewerBossesDone() const
        {
            return GetBossState(CCOD_ENC_ATREXIS) == DONE && GetBossState(CCOD_ENC_LYN) == DONE;
        }

        void UpdateCityDoors()
        {
            if (!SewerBossesDone())
                return;
            for (ObjectGuid const& guid : _cityDoors)
                if (GameObject* door = instance->GetGameObject(guid))
                    door->SetGoState(GO_STATE_ACTIVE);
        }

        bool SquareBossesDone() const
        {
            return GetBossState(CCOD_ENC_ARCANE_ANOMALY) == DONE && GetBossState(CCOD_ENC_ARCANIC_ENIGMA) == DONE
                && GetBossState(CCOD_ENC_UNSTABLE_SENTINEL) == DONE;
        }

        void UpdateFelAncientDoors()
        {
            if (!SquareBossesDone())
                return;
            // The doors are spawned with a 180 s respawn, so a plain despawn brought them back three minutes later and closed the way
            // to Fel Ancient for the rest of the run (fox4039, 14 Nov: "after one wipe the portal to the boss closes again"). They
            // stay gone for a week now, longer than any run; an instance reset brings them back with the bosses. Should one still
            // come back, OnGameObjectCreate queues it and Update() removes it again.
            for (ObjectGuid const& guid : _felAncientDoors)
                if (GameObject* door = instance->GetGameObject(guid))
                    door->DespawnOrUnsummon(0ms, Seconds(WEEK));
            _felAncientDoors.clear();
        }
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new classic_instance_city_of_dalaran_InstanceScript(map);
    }
};

// ---------------------------------------------------------------------------------------------------------------------
// Atrexis the Grave Knight (sewers, first boss): Disarm on the tank, Strike, Thrash, Unholy Frenzy, Raise Dead (adds).
struct classic_boss_cod_atrexis : public ScriptedAI
{
    classic_boss_cod_atrexis(Creature* creature) : ScriptedAI(creature), _summons(creature) { }

    enum : uint32 { EV_DISARM = 1, EV_STRIKE, EV_THRASH, EV_FRENZY, EV_RAISE_DEAD };
    static constexpr uint32 MaxRaised = 6;          // INFERRED cap, so the adds cannot be farmed

    void Reset() override
    {
        _events.Reset();
        _summons.DespawnAll();
        _raised = 0;
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _events.ScheduleEvent(EV_STRIKE, 5s);           // INFERRED timers: live a pull has 5 Thrash, 4 Strike, 2 Raise Dead,
        _events.ScheduleEvent(EV_DISARM, 15s);          // 1 Disarm and 1 Unholy Frenzy
        _events.ScheduleEvent(EV_THRASH, 4s);
        _events.ScheduleEvent(EV_FRENZY, 20s);
        _events.ScheduleEvent(EV_RAISE_DEAD, 10s);
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
                case EV_STRIKE: DoCastVictim(SPELL_COD_STRIKE); _events.Repeat(10s, 12s); break;
                case EV_DISARM: DoCastVictim(SPELL_COD_DISARM); _events.Repeat(45s, 50s); break;
                case EV_THRASH: DoCastSelf(SPELL_COD_THRASH); _events.Repeat(8s, 10s); break;
                case EV_FRENZY: DoCastSelf(SPELL_COD_UNHOLY_FRENZY); _events.Repeat(45s, 50s); break;
                case EV_RAISE_DEAD:
                    if (_raised < MaxRaised)
                    {
                        for (int i = 0; i < 2 && _raised < MaxRaised; ++i, ++_raised)
                        {
                            Position pos = me->GetRandomNearPosition(6.0f);
                            CodAddJoins(me, me->SummonCreature(NPC_COD_RISEN_TERROR, pos, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 10s));
                        }
                    }
                    _events.Repeat(25s, 28s);
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

// Lyn the Ignored (optional, below Atrexis): Raise Dead, Shadow Bolt Volley, Curse of Thorns on the tank.
struct classic_boss_cod_lyn : public ScriptedAI
{
    classic_boss_cod_lyn(Creature* creature) : ScriptedAI(creature), _summons(creature) { }

    enum : uint32 { EV_VOLLEY = 1, EV_THORNS, EV_RAISE_DEAD };
    static constexpr uint32 MaxRaised = 6;

    void Reset() override
    {
        _events.Reset();
        _summons.DespawnAll();
        _raised = 0;
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _events.ScheduleEvent(EV_THORNS, 3s);           // INFERRED timers: live a pull has 4 volleys, 2 Raise Dead, 2 Curse of Thorns
        _events.ScheduleEvent(EV_VOLLEY, 8s);
        _events.ScheduleEvent(EV_RAISE_DEAD, 12s);
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
                case EV_THORNS: DoCastVictim(SPELL_COD_CURSE_OF_THORNS); _events.Repeat(35s, 40s); break;
                case EV_VOLLEY: DoCastSelf(SPELL_COD_SHADOW_BOLT_VOLLEY); _events.Repeat(15s, 18s); break;
                case EV_RAISE_DEAD:
                    if (_raised < MaxRaised)
                    {
                        Position pos = me->GetRandomNearPosition(6.0f);
                        CodAddJoins(me, me->SummonCreature(NPC_COD_RISEN_TERROR, pos, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 10s));
                        ++_raised;
                    }
                    _events.Repeat(35s, 40s);
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

// Arcane Anomaly (Krasus' Landing): Arcane Bolt on the tank (about 500), Focal Blast: a 3 s beam that sweeps clockwise or
// counterclockwise; whoever stands in it is hit.
struct classic_boss_cod_arcane_anomaly : public ScriptedAI
{
    classic_boss_cod_arcane_anomaly(Creature* creature) : ScriptedAI(creature) { }

    enum : uint32 { EV_BOLT = 1, EV_FOCAL_BLAST, EV_FOCAL_TICK };
    static constexpr int32 BoltDamage = 500;        // guides: about 500 arcane on the tank
    static constexpr int32 BeamDamage = 300;        // INFERRED, per 0.5 s tick
    static constexpr float BeamRange = 30.0f;       // INFERRED
    static constexpr float BeamStep = 0.35f;        // radians per tick: about 120 degrees over the 3 s

    void Reset() override
    {
        _events.Reset();
        _ticks = 0;
        me->SetReactState(REACT_AGGRESSIVE);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _events.ScheduleEvent(EV_BOLT, 6s);             // INFERRED timers: live a pull has 2 Arcane Bolts and 2 Focal Blasts
        _events.ScheduleEvent(EV_FOCAL_BLAST, 15s);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;
        _events.Update(diff);

        while (uint32 ev = _events.ExecuteEvent())
        {
            switch (ev)
            {
                case EV_BOLT:
                    if (_ticks == 0)
                        if (Unit* victim = me->GetVictim())
                            CodHit(me, victim, SPELL_COD_ARCANE_BOLT, BoltDamage);
                    _events.Repeat(20s, 25s);
                    break;
                case EV_FOCAL_BLAST:
                {
                    Unit* target = SelectTarget(SelectTargetMethod::Random, 0, BeamRange, true);
                    if (!target)
                        target = me->GetVictim();
                    me->SetReactState(REACT_PASSIVE);
                    me->AttackStop();
                    me->StopMoving();
                    me->SetFacingToObject(target);
                    _beamFacing = me->GetAbsoluteAngle(target);
                    _beamDirection = urand(0, 1) ? 1.0f : -1.0f;
                    DoCastSelf(SPELL_COD_FOCAL_BLAST, true);
                    _ticks = 6;
                    _events.ScheduleEvent(EV_FOCAL_TICK, 500ms);
                    _events.Repeat(18s, 22s);
                    break;
                }
                case EV_FOCAL_TICK:
                    if (_ticks > 0)
                    {
                        _beamFacing = Position::NormalizeOrientation(_beamFacing + _beamDirection * BeamStep);
                        me->SetFacingTo(_beamFacing);
                        Position const front = me->GetPosition();
                        for (Player* player : CodPlayersNear(me, front, BeamRange))
                        {
                            float const diffAngle = Position::NormalizeOrientation(me->GetAbsoluteAngle(player) - _beamFacing);
                            if (diffAngle < 0.26f || diffAngle > 2 * float(M_PI) - 0.26f)   // 30 degree beam
                                CodHit(me, player, SPELL_COD_ARCANE_BOLT, BeamDamage);
                        }
                        if (--_ticks > 0)
                            _events.ScheduleEvent(EV_FOCAL_TICK, 500ms);
                        else
                        {
                            me->SetReactState(REACT_AGGRESSIVE);
                            if (Unit* victim = me->GetVictim())
                                AttackStart(victim);
                        }
                    }
                    break;
                default: break;
            }
        }
    }

private:
    EventMap _events;
    uint32 _ticks = 0;
    float _beamFacing = 0.0f;
    float _beamDirection = 1.0f;
};

// Arcanic Enigma (southern garden, two Mana Phantoms with it): Manamorph on a random player (dispellable), Silence on the
// players near it, Summon Manaling (adds).
struct classic_boss_cod_arcanic_enigma : public ScriptedAI
{
    classic_boss_cod_arcanic_enigma(Creature* creature) : ScriptedAI(creature), _summons(creature) { }

    enum : uint32 { EV_MANAMORPH = 1, EV_SILENCE, EV_MANALING };
    static constexpr uint32 MaxManalings = 8;       // live: 2 Manalings a cast, 4 casts a pull

    void Reset() override
    {
        _events.Reset();
        _summons.DespawnAll();
        _manalings = 0;
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        me->CallForHelp(20.0f);                     // the two Mana Phantoms next to it
        _events.ScheduleEvent(EV_MANAMORPH, 8s);    // INFERRED timers: live a pull has 4 Manamorph, 4 Summon Manaling, 2 Silence
        _events.ScheduleEvent(EV_SILENCE, 12s);
        _events.ScheduleEvent(EV_MANALING, 10s);
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
                case EV_MANAMORPH:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1, 40.0f, true))
                        DoCast(target, SPELL_COD_MANAMORPH);
                    else
                        DoCastVictim(SPELL_COD_MANAMORPH);
                    _events.Repeat(15s, 18s);
                    break;
                case EV_SILENCE:
                    DoCastSelf(SPELL_COD_SILENCE, true);    // 15 yd around it: ranged players can stay out
                    _events.Repeat(30s, 35s);
                    break;
                case EV_MANALING:
                    DoCastSelf(SPELL_COD_SUMMON_MANALING, true);
                    for (int i = 0; i < 2 && _manalings < MaxManalings; ++i, ++_manalings)
                    {
                        Position pos = me->GetRandomNearPosition(5.0f);
                        CodAddJoins(me, me->SummonCreature(NPC_COD_ARCANE_MANALING, pos, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 10s));
                    }
                    _events.Repeat(14s, 16s);
                    break;
                default: break;
            }
        }
    }

private:
    EventMap _events;
    SummonList _summons;
    uint32 _manalings = 0;
};

// Unstable Sentinel (trade district): Arcing Smash (frontal cleave), Malfunction: pulses within 25 yd; a stun before it starts
// stops it.
struct classic_boss_cod_unstable_sentinel : public ScriptedAI
{
    classic_boss_cod_unstable_sentinel(Creature* creature) : ScriptedAI(creature) { }

    enum : uint32 { EV_SMASH = 1, EV_MALFUNCTION, EV_MALFUNCTION_START, EV_MALFUNCTION_PULSE };
    static constexpr uint32 Pulses = 5;                // INFERRED; live pulses every 2 s, 25 yd (the guides' range)

    void Reset() override
    {
        _events.Reset();
        _pulses = 0;
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _events.ScheduleEvent(EV_SMASH, 6s);            // INFERRED timers: live a pull has 6 Arcing Smash and 3 Malfunction
        _events.ScheduleEvent(EV_MALFUNCTION, 18s);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;
        _events.Update(diff);

        while (uint32 ev = _events.ExecuteEvent())
        {
            switch (ev)
            {
                case EV_SMASH:
                    if (_pulses == 0 && !me->HasUnitState(UNIT_STATE_CASTING))
                        DoCastVictim(SPELL_COD_ARCING_SMASH);
                    _events.Repeat(11s, 14s);
                    break;
                case EV_MALFUNCTION:
                    me->TextEmote("Unstable Sentinel begins to malfunction!", nullptr, true);
                    _events.ScheduleEvent(EV_MALFUNCTION_START, 2s);    // the window to stun it
                    _events.Repeat(22s, 26s);
                    break;
                case EV_MALFUNCTION_START:
                    if (!me->HasUnitState(UNIT_STATE_STUNNED))
                    {
                        _pulses = Pulses;
                        _events.ScheduleEvent(EV_MALFUNCTION_PULSE, 0s);
                    }
                    break;
                case EV_MALFUNCTION_PULSE:
                    if (_pulses > 0)
                    {
                        DoCastSelf(SPELL_COD_MALFUNCTION_PULSE, true);
                        if (--_pulses > 0)
                            _events.ScheduleEvent(EV_MALFUNCTION_PULSE, 2s);
                    }
                    break;
                default: break;
            }
        }
    }

private:
    EventMap _events;
    uint32 _pulses = 0;
};

// Mana Devourer (by the Violet Hold): Drain Vitality on the tank, Debilitate (arcane damage and mana burn on the group).
// Everything left alive in its room joins the fight.
struct classic_boss_cod_mana_devourer : public ScriptedAI
{
    classic_boss_cod_mana_devourer(Creature* creature) : ScriptedAI(creature) { }

    enum : uint32 { EV_DRAIN = 1, EV_DEBILITATE };

    void Reset() override { _events.Reset(); }

    void JustEngagedWith(Unit* /*who*/) override
    {
        me->CallForHelp(35.0f);                     // guides: clear the room first
        _events.ScheduleEvent(EV_DRAIN, 5s);        // INFERRED timers: live a pull has 4 Drain Vitality and 2 Debilitate
        _events.ScheduleEvent(EV_DEBILITATE, 15s);
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
                case EV_DRAIN: DoCastVictim(SPELL_COD_DRAIN_VITALITY); _events.Repeat(15s, 18s); break;
                case EV_DEBILITATE:
                    DoCastSelf(SPELL_COD_DEBILITATE);
                    _events.Repeat(30s, 35s);
                    break;
                default: break;
            }
        }
    }

private:
    EventMap _events;
};

// Fel Ancient (city centre): Trample and Entangle (root with damage) on everyone near it, Fel Timbers: green pools that burn
// whoever stands in them.
struct classic_boss_cod_fel_ancient : public ScriptedAI
{
    classic_boss_cod_fel_ancient(Creature* creature) : ScriptedAI(creature) { }

    enum : uint32 { EV_ENTANGLE = 1, EV_FEL_TIMBERS, EV_POOL_TICK, EV_TRAMPLE };
    static constexpr float PoolRadius = 4.0f;       // INFERRED
    static constexpr int32 PoolDamage = 90;         // INFERRED, per second
    static constexpr Seconds PoolDuration = 15s;    // INFERRED

    struct Pool { Position pos; uint32 ticksLeft; };

    void Reset() override
    {
        _events.Reset();
        _pools.clear();
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _events.ScheduleEvent(EV_TRAMPLE, 8s);          // INFERRED timers: live a pull has 3 Trample, 3 Entangle, 3 Fel Timbers
        _events.ScheduleEvent(EV_ENTANGLE, 12s);
        _events.ScheduleEvent(EV_FEL_TIMBERS, 10s);
        _events.ScheduleEvent(EV_POOL_TICK, 1s);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;
        _events.Update(diff);

        while (uint32 ev = _events.ExecuteEvent())
        {
            switch (ev)
            {
                case EV_TRAMPLE:
                    DoCastSelf(SPELL_COD_TRAMPLE, true);
                    _events.Repeat(20s, 24s);
                    break;
                case EV_ENTANGLE:
                    DoCastSelf(SPELL_COD_ENTANGLE, true);
                    _events.Repeat(20s, 24s);
                    break;
                case EV_FEL_TIMBERS:
                    DoCastSelf(SPELL_COD_FEL_TIMBERS, true);
                    for (int i = 0; i < 2; ++i)
                        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 40.0f, true))
                        {
                            Position pos = target->GetPosition();
                            me->SummonGameObject(GO_COD_FEL_CRACKS, pos, QuaternionData::fromEulerAnglesZYX(pos.GetOrientation(), 0.0f, 0.0f),
                                PoolDuration);
                            _pools.push_back({ pos, uint32(PoolDuration.count()) });
                        }
                    _events.Repeat(25s, 28s);
                    break;
                case EV_POOL_TICK:
                    for (Pool& pool : _pools)
                    {
                        for (Player* player : CodPlayersNear(me, pool.pos, PoolRadius))
                            CodHit(me, player, SPELL_COD_FELFIRE, PoolDamage);
                        --pool.ticksLeft;
                    }
                    std::erase_if(_pools, [](Pool const& pool) { return pool.ticksLeft == 0; });
                    _events.Repeat(1s);
                    break;
                default: break;
            }
        }
    }

private:
    EventMap _events;
    std::vector<Pool> _pools;
};

// Shade of the Archmage (Purple Parlor, last boss): Arcane Bolt on the tank, Bounding Mana: a sphere goes out to a player and
// back, then Arcane Explosion hits everyone within 10 yd of it (live spell radius; the guides say 20); Slow on everyone
// within 20 yd; when its mana runs out it casts Mass Polymorph on the group and Evocation, then the cycle starts again.
// Leaving the room resets it.
struct classic_boss_cod_shade_of_the_archmage : public ScriptedAI
{
    classic_boss_cod_shade_of_the_archmage(Creature* creature) : ScriptedAI(creature) { }

    enum : uint32 { EV_BOLT = 1, EV_BOUNDING_MANA, EV_EXPLOSION, EV_OUT_OF_MANA, EV_EVOCATION, EV_LEASH, EV_LONE_EXPLOSION, EV_SLOW };
    static constexpr int32 BoltDamage = 600;            // INFERRED
    static constexpr Seconds ManaCycle = 50s;           // INFERRED: how long its mana lasts

    void Reset() override
    {
        _events.Reset();
        _polymorphing = false;
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _events.ScheduleEvent(EV_BOLT, 3s);             // INFERRED timers: live a pull has 19 Arcane Bolts, 5 Arcane Explosions,
        _events.ScheduleEvent(EV_BOUNDING_MANA, 12s);   // 3 Bounding Mana, 2 Slow, 1 Mass Polymorph and 1 Evocation
        _events.ScheduleEvent(EV_LONE_EXPLOSION, 25s);
        _events.ScheduleEvent(EV_SLOW, 18s);
        _events.ScheduleEvent(EV_OUT_OF_MANA, ManaCycle);
        _events.ScheduleEvent(EV_LEASH, 2s);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;
        _events.Update(diff);

        while (uint32 ev = _events.ExecuteEvent())
        {
            switch (ev)
            {
                case EV_LEASH:
                    if (me->GetExactDist2d(me->GetHomePosition()) > CodShadeRoomRadius)
                    {
                        EnterEvadeMode(EvadeReason::Boundary);
                        return;
                    }
                    _events.Repeat(2s);
                    break;
                case EV_BOLT:
                    if (!_polymorphing)
                        if (Unit* victim = me->GetVictim())
                            CodHit(me, victim, SPELL_COD_SHADE_ARCANE_BOLT, BoltDamage);
                    _events.Repeat(4s, 5s);
                    break;
                case EV_BOUNDING_MANA:
                    if (!_polymorphing)
                    {
                        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 40.0f, true))
                            me->CastSpell(target, SPELL_COD_BOUNDING_MANA, true);
                        _events.ScheduleEvent(EV_EXPLOSION, 6s);   // INFERRED: the sphere's trip out and back
                    }
                    _events.Repeat(25s, 30s);
                    break;
                case EV_EXPLOSION:
                    DoCastSelf(SPELL_COD_ARCANE_EXPLOSION, true);
                    break;
                case EV_LONE_EXPLOSION:                     // live casts more explosions than spheres (5 to 3 a pull)
                    if (!_polymorphing)
                        DoCastSelf(SPELL_COD_ARCANE_EXPLOSION, true);
                    _events.Repeat(35s, 40s);
                    break;
                case EV_SLOW:
                    if (!_polymorphing)
                        DoCastSelf(SPELL_COD_SLOW, true);
                    _events.Repeat(40s, 45s);
                    break;
                case EV_OUT_OF_MANA:
                    _polymorphing = true;
                    me->TextEmote("Shade of the Archmage is out of mana!", nullptr, true);
                    DoCastSelf(SPELL_COD_MASS_POLYMORPH, true);
                    _events.ScheduleEvent(EV_EVOCATION, 1s);
                    break;
                case EV_EVOCATION:
                    DoCastSelf(SPELL_COD_EVOCATION);
                    _polymorphing = false;
                    _events.ScheduleEvent(EV_OUT_OF_MANA, ManaCycle);
                    break;
                default: break;
            }
        }
    }

private:
    EventMap _events;
    bool _polymorphing = false;
};

// ---------------------------------------------------------------------------------------------------------------------
// A line in the player's chat, Russian for a Russian client.
static void CodSay(Player* player, char const* en, char const* ru)
{
    ChatHandler(player->GetSession()).SendSysMessage(player->GetSession()->GetSessionDbcLocale() == LOCALE_ruRU ? ru : en);
}

// Sewer Grate (656283, map 0): the way into the dungeon.
struct classic_go_cod_sewer_grate : public GameObjectAI
{
    classic_go_cod_sewer_grate(GameObject* go) : GameObjectAI(go) { }

    static bool HasKeyNear(Player* player)
    {
        if (player->HasItemCount(ITEM_COD_DALARAN_SEWER_KEY))
            return true;
        if (Group* group = player->GetGroup())
            for (GroupReference const& ref : group->GetMembers())
                if (Player* member = ref.GetSource())
                    if (member != player && member->IsInMap(player) && member->GetExactDist(player) <= CodGrateKeyRange
                        && member->HasItemCount(ITEM_COD_DALARAN_SEWER_KEY))
                        return true;
        return false;
    }

    bool OnGossipHello(Player* player) override
    {
        if (!player->IsGameMaster() && player->IsAlive() && !HasKeyNear(player))
        {
            CodSay(player, "The grate is locked. You need the Dalaran Sewer Key.", "Решётка заперта. Нужен ключ от канализации Даларана.");
            return true;
        }

        player->TeleportTo(CLASSIC_COD_MAP_ID, CodSewerLanding.GetPositionX(), CodSewerLanding.GetPositionY(),
            CodSewerLanding.GetPositionZ(), CodSewerLanding.GetOrientation());
        return true;
    }
};

// Portal To the Violet Chamber (656243): up to the Purple Parlor, once Mana Devourer and Fel Ancient are dead.
struct classic_go_cod_portal_to_parlor : public GameObjectAI
{
    classic_go_cod_portal_to_parlor(GameObject* go) : GameObjectAI(go) { }

    bool OnGossipHello(Player* player) override
    {
        InstanceScript* instance = me->GetInstanceScript();
        bool const open = player->IsGameMaster() || (instance && instance->GetBossState(CCOD_ENC_MANA_DEVOURER) == DONE
            && instance->GetBossState(CCOD_ENC_FEL_ANCIENT) == DONE);
        if (open)
            player->NearTeleportTo(CodParlorLanding);
        else
            CodSay(player, "The portal is dormant until Mana Devourer and Fel Ancient are defeated.",
                "Портал не работает, пока не побеждены Пожиратель маны и Древень Скверны.");
        return true;
    }
};

// The round door from the sewers up to the city (665036): says why it is shut until Atrexis and Lyn are dead.
struct classic_go_cod_city_door : public GameObjectAI
{
    classic_go_cod_city_door(GameObject* go) : GameObjectAI(go) { }

    bool OnGossipHello(Player* player) override
    {
        if (me->GetGoState() == GO_STATE_ACTIVE)
            return true;                // already open
        InstanceScript* instance = me->GetInstanceScript();
        bool const done = instance && instance->GetBossState(CCOD_ENC_ATREXIS) == DONE && instance->GetBossState(CCOD_ENC_LYN) == DONE;
        if (done || player->IsGameMaster())
            me->SetGoState(GO_STATE_ACTIVE);
        else
            CodSay(player, "The way up is sealed until Atrexis and Lyn are defeated.",
                "Путь наверх закрыт, пока не побеждены Атрексий и Лин.");
        return true;
    }
};

// Portal To the Violet Chamber (656320) in the Purple Parlor: back down.
struct classic_go_cod_portal_from_parlor : public GameObjectAI
{
    classic_go_cod_portal_from_parlor(GameObject* go) : GameObjectAI(go) { }

    bool OnGossipHello(Player* player) override
    {
        player->NearTeleportTo(CodParlorExitLanding);
        return true;
    }
};

void AddSC_classic_instance_city_of_dalaran()
{
    new classic_instance_city_of_dalaran();
    RegisterCreatureAI(classic_boss_cod_atrexis);
    RegisterCreatureAI(classic_boss_cod_lyn);
    RegisterCreatureAI(classic_boss_cod_arcane_anomaly);
    RegisterCreatureAI(classic_boss_cod_arcanic_enigma);
    RegisterCreatureAI(classic_boss_cod_unstable_sentinel);
    RegisterCreatureAI(classic_boss_cod_mana_devourer);
    RegisterCreatureAI(classic_boss_cod_fel_ancient);
    RegisterCreatureAI(classic_boss_cod_shade_of_the_archmage);
    RegisterGameObjectAI(classic_go_cod_sewer_grate);
    RegisterGameObjectAI(classic_go_cod_portal_to_parlor);
    RegisterGameObjectAI(classic_go_cod_portal_from_parlor);
    RegisterGameObjectAI(classic_go_cod_city_door);
}
