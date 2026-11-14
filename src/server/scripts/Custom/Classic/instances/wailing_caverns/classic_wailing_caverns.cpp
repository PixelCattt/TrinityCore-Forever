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

// Classic 1.60 port of VMaNGOS src/scripts/kalimdor/the_barrens/wailing_caverns/wailing_caverns.cpp (ScriptDev2 lineage, GPL-2)
// Ported: npc_disciple_of_naralex, npc_evolving_ectoplasm

#include "ScriptMgr.h"
#include "Creature.h"
#include "CreatureAI.h"
#include "InstanceScript.h"
#include "Map.h"
#include "MotionMaster.h"
#include "ObjectAccessor.h"
#include "ObjectDefines.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "ScriptedGossip.h"
#include "Spell.h"
#include "SpellInfo.h"
#include "TemporarySummon.h"
#include "classic_script_text.h"
#include "classic_wailing_caverns.h"
#include <algorithm>
#include <iterator>
#include <vector>

/*######
## npc_disciple_of_naralex
######*/

enum ClassicDiscipleOfNaralex
{
    SPELL_DISCIPLE_MARK         = 5232,
    SPELL_DISCIPLE_SLEEP        = 1090,
    SPELL_DISCIPLE_POTION       = 8141,
    SPELL_DISCIPLE_CLEANSING    = 6270,
    SPELL_DISCIPLE_AWAKENING    = 6271,
    SPELL_DISCIPLE_SHAPESHIFT   = 8153,

    SAY_DISCIPLE_CAST_MARK      = 1255,
    SAY_DISCIPLE_1ST_WP         = 1256,
    SAY_DISCIPLE_AFTER_1ST_TRASH = 1257,
    SAY_DISCIPLE_BEFORE_CIRCLE  = 1258,
    SAY_DISCIPLE_AFTER_CIRCLE   = 1259,
    SAY_DISCIPLE_BEFORE_CHAMBER = 1263,
    SAY_DISCIPLE_BEFORE_RITUAL  = 1264,
    EMOTE_DISCIPLE_1            = 1265,
    EMOTE_NARALEX_1             = 1268,
    SAY_DISCIPLE_ATTACKED       = 1273,
    EMOTE_NARALEX_2             = 1269,
    SAY_DISCIPLE_MUTANUS_SPAWNED = 1276,
    SAY_NARALEX_AWAKEN          = 1271,
    SAY_DISCIPLE_FINAL          = 1267,
    SAY_NARALEX_FINAL1          = 1272,
    SAY_NARALEX_FINAL2          = 2103,

    MOB_DEVIATE_RAPTOR          = 3636,
    MOB_DEVIATE_VIPER           = 5755,
    MOB_DEVIATE_MOCCASIN        = 5762,
    MOB_NIGHTMARE_ECTOPLASM     = 5763,
    MOB_MUTANUS_DEVOURER        = 3654,

    // gossip_menu 201 (default menu) runs gossip_scripts 201 in VMaNGOS: cast Mark of the Wild on the player
    GOSSIP_MENU_DISCIPLE_DEFAULT = 201,

    FACTION_CLASSIC_ESCORT_N_NEUTRAL_ACTIVE = 250          // VMaNGOS FACTION_ESCORT_N_NEUTRAL_ACTIVE
};

namespace
{
float const ClassicDiscipleSummonPos[10][3] =
{
    { -52.9f, 269.8f, -92.8f },
    { -58.5f, 279.8f, -92.8f },
    { -49.6f, 278.2f, -92.8f },
    { 142.7f, 254.0f, -102.2f },
    { 140.5f, 219.8f, -102.4f },
    { 92.2f, 261.9f, -101.5f },
    { 100.3f, 268.6f, -102.2f },
    { 123.8f, 271.9f, -102.4f },
    { 151.9f, 234.3f, -102.5f },
    { 127.6f, 200.8f, -101.8f }
};

struct ClassicDiscipleWaypoint
{
    float x, y, z;
    uint32 waitTime;
};

// VMaNGOS script_waypoint entry 3678 (pointid 0..31)
ClassicDiscipleWaypoint const ClassicDiscipleWaypoints[] =
{
    { -134.9f, 125.4f, -78.1f, 0 },
    { -125.6f, 132.9f, -78.4f, 0 },
    { -113.8f, 139.2f, -80.9f, 0 },
    { -109.8f, 157.5f, -80.2f, 0 },
    { -108.6f, 175.2f, -79.7f, 0 },
    { -108.6f, 195.4f, -80.6f, 0 },
    { -111.0f, 219.0f, -86.5f, 0 },
    { -102.4f, 232.8f, -91.5f, 0 },
    { -82.4f, 224.8f, -93.5f, 0 },
    { -73.4f, 214.7f, -93.2f, 0 },
    { -67.7f, 208.0f, -93.3f, 0 },
    { -43.3f, 205.2f, -96.3f, 0 },
    { -34.6f, 221.3f, -95.8f, 0 },
    { -32.5f, 238.5f, -93.5f, 0 },
    { -42.1f, 258.6f, -92.8f, 0 },
    { -54.0f, 276.2f, -92.8f, 0 },
    { -48.6f, 287.5f, -92.4f, 0 },
    { -47.2f, 296.0f, -90.8f, 0 },
    { -35.6f, 309.0f, -89.7f, 0 },
    { -23.5f, 311.3f, -88.6f, 0 },
    { -8.6f, 302.3f, -87.4f, 0 },
    { -1.2f, 293.2f, -85.5f, 0 },
    { 10.3f, 279.2f, -85.8f, 0 },
    { 23.1f, 264.6f, -86.6f, 0 },
    { 31.9f, 251.4f, -87.6f, 0 },
    { 43.3f, 233.0f, -87.6f, 0 },
    { 52.2f, 208.7f, -89.5f, 3000 },
    { 78.7f, 208.8f, -92.8f, 0 },
    { 88.3f, 225.2f, -94.4f, 0 },
    { 98.7f, 239.0f, -95.8f, 0 },
    { 114.6f, 236.9f, -96.0f, 1000 },
    { 114.6f, 236.9f, -96.0f, 0 }
};
}

struct classic_npc_disciple_of_naralex : public EscortAI
{
    classic_npc_disciple_of_naralex(Creature* creature) : EscortAI(creature)
    {
        m_pInstance = creature->GetInstanceScript();

        for (uint32 i = 0; i < std::size(ClassicDiscipleWaypoints); ++i)
        {
            ClassicDiscipleWaypoint const& wp = ClassicDiscipleWaypoints[i];
            Optional<Milliseconds> wait;
            if (wp.waitTime)
                wait = Milliseconds(wp.waitTime);
            AddWaypoint(i, wp.x, wp.y, wp.z, 0.0f, wait, false);
        }

        Initialize();
    }

    InstanceScript* m_pInstance;
    ObjectGuid m_playerGuid;
    std::vector<ObjectGuid> vSummoned;

    uint32 Event_Timer;
    uint32 Sleep_Timer;
    uint32 Potion_Timer;
    uint32 Cleansing_Timer;

    int32 Point;
    int8 Subevent_Phase;

    bool Yelled;
    bool isAggro;

    void Initialize()
    {
        Event_Timer = 0;
        Sleep_Timer = 5000;
        Potion_Timer = 5000;
        Cleansing_Timer = 0;

        Point = 0;
        Subevent_Phase = 0;

        Yelled = false;
        isAggro = false;
    }

    void Reset() override
    {
        // TC also calls Reset() after respawning the escort. Re-arm an unfinished ritual
        // through the instance's existing four-fang-boss gate, without resetting an active
        // escort or replaying a completed Mutanus encounter.
        Initialize();
        if (m_pInstance && !HasEscortState(STATE_ESCORT_ESCORTING) &&
            m_pInstance->GetData(CWC_TYPE_MUTANUS) != DONE)
        {
            uint32 const discipleState = m_pInstance->GetData(CWC_TYPE_DISCIPLE);
            if (discipleState == NOT_STARTED || discipleState == IN_PROGRESS || discipleState == FAIL)
                m_pInstance->SetData(CWC_TYPE_DISCIPLE, NOT_STARTED);
        }
    }

    Creature* GetNaralex() const
    {
        if (!m_pInstance)
            return nullptr;
        return ObjectAccessor::GetCreature(*me, m_pInstance->GetGuidData(CWC_DATA_NARALEX));
    }

    void EnterEvadeMode(EvadeReason why) override
    {
        bool wasAggro = isAggro;
        isAggro = false;
        Yelled = false;

        if (OnCastWaypoint() || OnFightWaypoint())
        {
            // stay paused at the event point, keep the channelled spells running (VMaNGOS does not remove auras here)
            me->CombatStop(true);
            EngagementOver();
            if (wasAggro)
                ReturnToLastPoint();   // VMaNGOS ReturnToCombatStartPosition
            return;
        }

        EscortAI::EnterEvadeMode(why);
        SetEscortPaused(false);
    }

    void JustEngagedWith(Unit* who) override
    {
        isAggro = true;

        // VMaNGOS AttackedBy: yell once when attacked (not during the awakening ritual)
        if (Point != 30 && !Yelled)
        {
            ClassicScriptText(SAY_DISCIPLE_ATTACKED, me, who);
            Yelled = true;
        }

        if (OnCastWaypoint() || OnFightWaypoint())
            return;
        SetEscortPaused(true);
    }

    // VMaNGOS AttackedBy: prevent reaction while casting the cleansing spell
    void AttackStart(Unit* who) override
    {
        if (me->FindCurrentSpellBySpellId(SPELL_DISCIPLE_CLEANSING))
            return;

        EscortAI::AttackStart(who);
    }

    // no escort resume on evade
    bool OnFightWaypoint() const
    {
        return Point == 7; // first turn
    }

    // no attack, no escort resume on evade
    bool OnCastWaypoint() const
    {
        return Point == 30 || // awakening
            (Point == 15 && (Subevent_Phase == 2 || Subevent_Phase == 3)); // cleansing
    }

    void WaypointReached(uint32 waypointId, uint32 /*pathId*/) override
    {
        switch (waypointId)
        {
            case 0:
                ClassicScriptText(SAY_DISCIPLE_CAST_MARK, me);
                me->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                SetEscortPaused(true);
                Event_Timer = 5000;
                Point = waypointId;
                break;
            case 7:
                ClassicScriptText(SAY_DISCIPLE_1ST_WP, me);
                me->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                Event_Timer = 6000;
                Point = waypointId;
                Subevent_Phase = 0;
                SetEscortPaused(true);
                break;
            case 15:
                Subevent_Phase = 0;
                Event_Timer = 2000;
                Point = waypointId;
                SetEscortPaused(true);
                break;
            case 26:
                Event_Timer = 2000;
                Point = waypointId;
                SetEscortPaused(true);
                me->SetFacingTo(6.24f);
                ClassicScriptText(SAY_DISCIPLE_BEFORE_CHAMBER, me);
                me->HandleEmoteCommand(EMOTE_ONESHOT_POINT);
                break;
            case 30:
                if (Creature* naralex = GetNaralex())
                    me->SetFacingToObject(naralex);
                if (m_pInstance)
                    m_pInstance->SetData(CWC_TYPE_DISCIPLE, IN_PROGRESS);
                Event_Timer = 1000;
                Subevent_Phase = 0;
                Point = waypointId;
                SetEscortPaused(true);
                break;
            default:
                Point = waypointId;
                break;
        }
    }

    void MoveFlying(Creature* creature, uint32 pointId, float x, float y, float z, float orientation)
    {
        // VMaNGOS MovePoint(id, x, y, z, MOVE_FLY_MODE, 35.0f, orientation)
        creature->GetMotionMaster()->MovePoint(pointId, x, y, z, false, orientation, 35.0f);
    }

    void MovementInform(uint32 moveType, uint32 pointId) override
    {
        EscortAI::MovementInform(moveType, pointId);

        if (moveType != POINT_MOTION_TYPE)
            return;

        Creature* naralex = GetNaralex();

        switch (pointId)
        {
            case 33:
                MoveFlying(me, 34, 91.9f, 233.6f, -88.7f, 3.8f);
                if (naralex)
                    MoveFlying(naralex, 34, 91.9f, 233.6f, -85.2f, 3.8f);
                break;
            case 34:
                MoveFlying(me, 35, 84.4f, 218.1f, -85.3f, 4.2f);
                if (naralex)
                    MoveFlying(naralex, 35, 84.4f, 218.1f, -80.8f, 4.2f);
                break;
            case 35:
                MoveFlying(me, 36, 77.4f, 208.2f, -83.1f, 3.9f);
                if (naralex)
                    MoveFlying(naralex, 36, 77.4f, 208.2f, -77.6f, 3.9f);
                break;
            case 36:
                MoveFlying(me, 37, 63.3f, 205.4f, -79.9f, 3.3f);
                if (naralex)
                    MoveFlying(naralex, 37, 63.3f, 205.4f, -74.4f, 3.3f);
                break;
            case 37:
                MoveFlying(me, 38, 33.3f, 201.4f, -70.3f, 3.3f);
                if (naralex)
                    MoveFlying(naralex, 38, 33.3f, 201.4f, -65.8f, 3.3f);
                break;
            case 38:
                // VMaNGOS: SetRespawnTime(12 * HOUR) + invisible + ForcedDespawn
                if (naralex)
                    naralex->DespawnOrUnsummon(0s, Seconds(12 * HOUR));
                me->DespawnOrUnsummon(0s, Seconds(12 * HOUR));
                break;
            default:
                break;
        }
    }

    void JustSummoned(Creature* summoned) override
    {
        if (!summoned)
            return;
        summoned->GetMotionMaster()->MoveIdle();
        vSummoned.push_back(summoned->GetGUID());
    }

    // if the disciple dies his alive summons disappear
    void JustDied(Unit* killer) override
    {
        EscortAI::JustDied(killer);

        for (ObjectGuid const& guid : vSummoned)
            if (Creature* summon = ObjectAccessor::GetCreature(*me, guid))
                if (summon->IsAlive())
                    summon->DespawnOrUnsummon();
        vSummoned.clear();
    }

    // keep only alive summon in vSummoned
    void SummonedCreatureDies(Creature* summoned, Unit* /*killer*/) override
    {
        if (!summoned)
            return;
        auto it = std::find(vSummoned.begin(), vSummoned.end(), summoned->GetGUID());
        if (it != vSummoned.end())
            vSummoned.erase(it);
    }

    void SummonAttacker(uint32 entry, float x, float y, float z)
    {
        me->SummonCreature(entry, x, y, z, 0.0f, TEMPSUMMON_DEAD_DESPAWN);
    }

    void SendAttackerToMe(Creature* creature)
    {
        if (!creature)
            return;

        // Only the last summons are slow
        MovementWalkRunSpeedSelectionMode moveMode = MovementWalkRunSpeedSelectionMode::ForceWalk;
        if (creature->GetEntry() == MOB_DEVIATE_RAPTOR ||
            creature->GetEntry() == MOB_DEVIATE_VIPER)
            moveMode = MovementWalkRunSpeedSelectionMode::ForceRun;

        creature->GetMotionMaster()->MovePoint(0, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), true, {}, {}, moveMode);
    }

    bool OnGossipHello(Player* player) override
    {
        if (m_pInstance && m_pInstance->GetData(CWC_TYPE_DISCIPLE) == SPECIAL)
        {
            // VMaNGOS SetDefaultGossipMenuId(GOSSIP_DISCIPLE_SPECIAL); option 0 is conditioned on TYPE_DISCIPLE == SPECIAL
            player->PrepareGossipMenu(me, CWC_GOSSIP_DISCIPLE_SPECIAL, true);
            player->SendPreparedGossip(me);
            return true;
        }

        // default menu 201: VMaNGOS gossip_scripts 201 casts Mark of the Wild on the player
        me->CastSpell(player, SPELL_DISCIPLE_MARK, false);
        return false;
    }

    // VMaNGOS gossip_scripts 202 (SCRIPT_COMMAND_SEND_SCRIPT_EVENT) -> OnScriptEventHappened
    bool OnGossipSelect(Player* player, uint32 menuId, uint32 /*gossipListId*/) override
    {
        if (menuId != CWC_GOSSIP_DISCIPLE_SPECIAL)
            return false;

        CloseGossipMenuFor(player);

        if (!m_pInstance)
            return true;

        if (m_pInstance->GetData(CWC_TYPE_DISCIPLE) == SPECIAL)
        {
            Start(false, ObjectGuid::Empty); // we don't want the out of range check.
            m_playerGuid = player->GetGUID();
            me->SetFaction(FACTION_CLASSIC_ESCORT_N_NEUTRAL_ACTIVE);
        }
        return true;
    }

    void UpdateEscortAI(uint32 diff) override
    {
        if (!m_pInstance)
            return;

        Creature* naralex = GetNaralex();
        if (!naralex)
            return;

        for (ObjectGuid const& guid : vSummoned)
        {
            if (Creature* summon = ObjectAccessor::GetCreature(*me, guid))
            {
                if (!summon->GetVictim() && me->IsAlive())
                {
                    // the summon has reached the disciple, attack him
                    if (summon->GetDistance2d(me) < ATTACK_DISTANCE)
                    {
                        if (summon->IsAIEnabled())
                            summon->AI()->AttackStart(me);
                    }
                    // the summon is not fighting nor moving, send it to the disciple
                    else if (!summon->isMoving())
                        SendAttackerToMe(summon);
                }
            }
        }

        if (Event_Timer)
        {
            if (Event_Timer <= diff)
            {
                if (!me->IsWalking())
                    me->SetWalk(true);

                switch (Point)
                {
                    case 0:
                    {
                        Map::PlayerList const& players = me->GetMap()->GetPlayers();
                        for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
                        {
                            if (Player* player = itr->GetSource())
                                if (player->IsAlive() && player->GetDistance(me) < 30.0f)
                                    me->CastSpell(player, SPELL_DISCIPLE_MARK, false);
                        }
                        SetEscortPaused(false);
                        Event_Timer = 0;
                        break;
                    }
                    case 7:
                        switch (Subevent_Phase)
                        {
                            case 0:
                                me->SetFacingTo(5.86f);
                                SummonAttacker(MOB_DEVIATE_RAPTOR, -67.851196f, 214.383102f, -93.499001f);
                                SummonAttacker(MOB_DEVIATE_RAPTOR, -69.769707f, 211.342804f, -93.450737f);
                                Subevent_Phase = 1;
                                Event_Timer = 2000;
                                break;
                            case 1:
                                if (vSummoned.empty()) // raptors are dead
                                {
                                    ClassicScriptText(SAY_DISCIPLE_AFTER_1ST_TRASH, me);
                                    me->HandleEmoteCommand(EMOTE_ONESHOT_POINT);
                                    Subevent_Phase = 2;
                                    Event_Timer = 5000;
                                }
                                else
                                    Event_Timer = 1000;
                                break;
                            case 2:
                                SetEscortPaused(false);
                                Event_Timer = 0;
                                break;
                            default:
                                break;
                        }
                        break;
                    case 15:
                        switch (Subevent_Phase)
                        {
                            case 0:
                                ClassicScriptText(SAY_DISCIPLE_BEFORE_CIRCLE, me);
                                me->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                                Subevent_Phase = 1;
                                Event_Timer = 2000;
                                break;
                            case 1:
                                me->CastSpell(me, SPELL_DISCIPLE_CLEANSING, false);
                                me->SetControlled(true, UNIT_STATE_ROOT);
                                Subevent_Phase = 2;
                                Event_Timer = 15000;
                                break;
                            case 2:
                                for (int i = 0; i < 3; ++i)
                                    SummonAttacker(MOB_DEVIATE_VIPER, ClassicDiscipleSummonPos[i][0], ClassicDiscipleSummonPos[i][1], ClassicDiscipleSummonPos[i][2]);
                                Subevent_Phase = 3;
                                Event_Timer = 1000;
                                break;
                            case 3:
                                if (!me->FindCurrentSpellBySpellId(SPELL_DISCIPLE_CLEANSING))
                                {
                                    me->SetControlled(false, UNIT_STATE_ROOT);
                                    Subevent_Phase = 4;
                                }
                                Event_Timer = 1000;
                                break;
                            case 4:
                            {
                                Player* eventStarter = ObjectAccessor::GetPlayer(*me, m_playerGuid);
                                if (!me->IsInCombat() && eventStarter && !eventStarter->IsInCombat())
                                {
                                    ClassicScriptText(SAY_DISCIPLE_AFTER_CIRCLE, me);
                                    me->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                                    Subevent_Phase = 5;
                                }
                                Event_Timer = 2000;
                                break;
                            }
                            case 5:
                                SetEscortPaused(false);
                                Event_Timer = 0;
                                break;
                            default:
                                break;
                        }
                        break;
                    case 26:
                        SetEscortPaused(false);
                        Event_Timer = 0;
                        break;
                    case 30:
                        SetEscortPaused(true);
                        switch (Subevent_Phase)
                        {
                            case 0:
                                me->SetFacingToObject(naralex);
                                ClassicScriptText(SAY_DISCIPLE_BEFORE_RITUAL, me);
                                me->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                                Subevent_Phase = 1;
                                Event_Timer = 2000;
                                break;
                            case 1:
                                // SPELL_AWAKENING has a self stun effect
                                me->CastSpell(me, SPELL_DISCIPLE_AWAKENING, false);
                                ClassicScriptText(EMOTE_DISCIPLE_1, me);
                                me->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                                Subevent_Phase = 2;
                                Event_Timer = 4000;
                                break;
                            case 2:
                                ClassicScriptText(EMOTE_NARALEX_1, naralex);
                                naralex->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                                Subevent_Phase = 3;
                                Event_Timer = 5000;
                                break;
                            case 3:
                                for (int i = 7; i < 10; ++i)
                                    SummonAttacker(MOB_DEVIATE_MOCCASIN, ClassicDiscipleSummonPos[i][0], ClassicDiscipleSummonPos[i][1], ClassicDiscipleSummonPos[i][2]);
                                Event_Timer = 40000;
                                Subevent_Phase = 4;
                                break;
                            case 4:
                                for (int i = 3; i < 10; ++i)
                                    SummonAttacker(MOB_NIGHTMARE_ECTOPLASM, ClassicDiscipleSummonPos[i][0], ClassicDiscipleSummonPos[i][1], ClassicDiscipleSummonPos[i][2]);
                                Event_Timer = 40000;
                                Subevent_Phase = 5;
                                break;
                            case 5:
                                Subevent_Phase = 6;
                                Event_Timer = 10000;
                                ClassicScriptText(EMOTE_NARALEX_2, naralex);
                                naralex->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                                me->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                                break;
                            case 6:
                                SummonAttacker(MOB_MUTANUS_DEVOURER, ClassicDiscipleSummonPos[3][0], ClassicDiscipleSummonPos[3][1], ClassicDiscipleSummonPos[3][2]);
                                Subevent_Phase = 7;
                                Event_Timer = 2000;
                                break;
                            case 7:
                                Subevent_Phase = 8;
                                Event_Timer = 2000;
                                if (Creature* mutanus = naralex->FindNearestCreature(MOB_MUTANUS_DEVOURER, 100.0f))
                                    ClassicScriptText(SAY_DISCIPLE_MUTANUS_SPAWNED, me, mutanus);
                                break;
                            case 8:
                                if (m_pInstance->GetData(CWC_TYPE_MUTANUS) == DONE)
                                {
                                    naralex->SetStandState(UNIT_STAND_STATE_SIT);
                                    ClassicScriptText(SAY_NARALEX_AWAKEN, naralex);
                                    naralex->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                                    me->InterruptNonMeleeSpells(false, SPELL_DISCIPLE_AWAKENING);
                                    me->RemoveAurasDueToSpell(SPELL_DISCIPLE_AWAKENING);
                                    m_pInstance->SetData(CWC_TYPE_DISCIPLE, DONE);
                                    Event_Timer = 2000;
                                    Subevent_Phase = 9;
                                }
                                else
                                    Event_Timer = 2000;
                                break;
                            case 9:
                                if (me->IsAlive() && !me->GetVictim())
                                {
                                    me->CombatStop(true);
                                    EngagementOver();
                                    ClassicScriptText(SAY_DISCIPLE_FINAL, me);
                                    me->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                                    Subevent_Phase = 10;
                                    Event_Timer = 5000;
                                }
                                else
                                    Event_Timer = 2000;
                                break;
                            case 10:
                                ClassicScriptText(SAY_NARALEX_FINAL1, naralex);
                                naralex->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                                naralex->SetStandState(UNIT_STAND_STATE_STAND);
                                Event_Timer = 8000;
                                Subevent_Phase = 11;
                                break;
                            case 11:
                                ClassicScriptText(SAY_NARALEX_FINAL2, naralex);
                                naralex->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                                me->CastSpell(me, SPELL_DISCIPLE_SHAPESHIFT, false);
                                naralex->CastSpell(naralex, SPELL_DISCIPLE_SHAPESHIFT, false);
                                Event_Timer = 8000;
                                Subevent_Phase = 12;
                                break;
                            case 12:
                                me->SetCanFly(true);
                                me->SetDisableGravity(true);
                                naralex->SetCanFly(true);
                                naralex->SetDisableGravity(true);
                                MoveFlying(me, 33, 101.0f, 239.2f, -91.2f, 3.5f);
                                MoveFlying(naralex, 0, 101.0f, 239.2f, -90.7f, 3.5f);
                                // VMaNGOS Stop(): the escort stays paused at point 30 for good (TC EscortAI has no Stop())
                                Event_Timer = 0;
                                break;
                            default:
                                break;
                        }
                        break;
                    default:
                        break;
                }
            }
            else
                Event_Timer -= diff;
        }

        if (Potion_Timer < diff)
        {
            if ((static_cast<double>(me->GetHealth()) / me->GetMaxHealth()) < 0.8)
                me->CastSpell(me, SPELL_DISCIPLE_POTION, false);
            Potion_Timer = 45000;
        }
        else
            Potion_Timer -= diff;

        if (OnCastWaypoint())
            return;

        if (UpdateVictim())
        {
            if (Sleep_Timer < diff)
            {
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1))
                    me->CastSpell(target, SPELL_DISCIPLE_SLEEP, false);
                Sleep_Timer = 30000;
            }
            else
                Sleep_Timer -= diff;
        }
    }
};

/*######
## npc_evolving_ectoplasm
######*/

enum ClassicEvolvingEctoplasm
{
    SPELL_ECTO_IMMUNE_FIRE      = 7942,
    SPELL_ECTO_IMMUNE_FROST     = 7940,
    SPELL_ECTO_IMMUNE_NATURE    = 7941,
    SPELL_ECTO_IMMUNE_SHADOW    = 7743,

    SPELL_ECTO_TRANSFORM_RED    = 7943,
    SPELL_ECTO_TRANSFORM_BLUE   = 7944,
    SPELL_ECTO_TRANSFORM_GREEN  = 7945,
    SPELL_ECTO_TRANSFORM_BLACK  = 7946,
};

struct classic_npc_evolving_ectoplasm : public ScriptedAI
{
    classic_npc_evolving_ectoplasm(Creature* creature) : ScriptedAI(creature), m_uiImmuneTimer(0), isImmune(false) { }

    uint32 m_uiImmuneTimer;
    bool   isImmune;

    void Reset() override
    {
        me->RemoveAllAuras();
        m_uiImmuneTimer = 0;
        isImmune = false;
    }

    // VMaNGOS DoCastSpellIfCan(me, spell, CF_TRIGGERED | CF_AURA_NOT_PRESENT)
    void CastIfAuraNotPresent(uint32 spellId)
    {
        if (!me->HasAura(spellId))
            DoCastSelf(spellId, true);
    }

    void SpellHit(WorldObject* /*caster*/, SpellInfo const* spellInfo) override
    {
        if (isImmune)
            return;

        // VMaNGOS checks SpellEntry::School (single school)
        uint32 schoolMask = spellInfo->GetSchoolMask();
        if (schoolMask & SPELL_SCHOOL_MASK_FROST)
        {
            CastIfAuraNotPresent(SPELL_ECTO_TRANSFORM_BLUE);
            CastIfAuraNotPresent(SPELL_ECTO_IMMUNE_FROST);
            m_uiImmuneTimer = 10000;
            isImmune = true;
        }
        else if (schoolMask & SPELL_SCHOOL_MASK_FIRE)
        {
            CastIfAuraNotPresent(SPELL_ECTO_TRANSFORM_RED);
            CastIfAuraNotPresent(SPELL_ECTO_IMMUNE_FIRE);
            m_uiImmuneTimer = 10000;
            isImmune = true;
        }
        else if (schoolMask & SPELL_SCHOOL_MASK_NATURE)
        {
            CastIfAuraNotPresent(SPELL_ECTO_TRANSFORM_GREEN);
            CastIfAuraNotPresent(SPELL_ECTO_IMMUNE_NATURE);
            m_uiImmuneTimer = 10000;
            isImmune = true;
        }
        else if (schoolMask & SPELL_SCHOOL_MASK_SHADOW)
        {
            CastIfAuraNotPresent(SPELL_ECTO_TRANSFORM_BLACK);
            CastIfAuraNotPresent(SPELL_ECTO_IMMUNE_SHADOW);
            m_uiImmuneTimer = 10000;
            isImmune = true;
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (m_uiImmuneTimer < diff)
        {
            me->RemoveAurasDueToSpell(SPELL_ECTO_TRANSFORM_RED);
            me->RemoveAurasDueToSpell(SPELL_ECTO_TRANSFORM_BLUE);
            me->RemoveAurasDueToSpell(SPELL_ECTO_TRANSFORM_GREEN);
            me->RemoveAurasDueToSpell(SPELL_ECTO_TRANSFORM_BLACK);
            me->RemoveAurasDueToSpell(SPELL_ECTO_IMMUNE_SHADOW);
            me->RemoveAurasDueToSpell(SPELL_ECTO_IMMUNE_FROST);
            me->RemoveAurasDueToSpell(SPELL_ECTO_IMMUNE_FIRE);
            me->RemoveAurasDueToSpell(SPELL_ECTO_IMMUNE_NATURE);
            isImmune = false;
        }
        else
            m_uiImmuneTimer -= diff;

        UpdateVictim();
    }
};

void AddSC_classic_wailing_caverns()
{
    RegisterCreatureAI(classic_npc_evolving_ectoplasm);
    RegisterCreatureAI(classic_npc_disciple_of_naralex);
}
