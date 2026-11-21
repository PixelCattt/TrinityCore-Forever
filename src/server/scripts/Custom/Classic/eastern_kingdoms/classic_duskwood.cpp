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

// Classic 1.60 port of VMaNGOS src/scripts/eastern_kingdoms/duskwood/duskwood.cpp (Nostalrius/VMaNGOS, GPL-2)
// Ported: commander_felstrom, npc_sirra_vonindi (Stitches event, quest 401) and the Stitches event helpers it drives
// (npc_stitches, watcher_selkin, watcher_blomberg: summoned-only creatures, required by npc_sirra_vonindi).
// Not ported: npc_twilight_corrupter / at_twilight_grove (TC has boss_twilight_corrupter / at_twilight_grove).
// Escort waypoints are the VMaNGOS script_waypoint rows, added inline (TC master has no script_waypoint table).

#include "ScriptMgr.h"
#include "ChatTextBuilder.h"
#include "CreatureTextMgr.h"
#include "CreatureTextMgrImpl.h"
#include "Log.h"
#include "Loot.h"
#include "MotionMaster.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "QuestDef.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "TemporarySummon.h"
#include "classic_script_text.h"
#include <iterator>
#include <set>

namespace
{
struct DuskwoodEscortPoint
{
    float x, y, z;
    uint32 waitMs;
};

// VMaNGOS Creature::MonsterYellToZone(textId)
void DuskwoodYellToZone(Creature* source, uint32 textId)
{
    if (!source)
        return;

    Trinity::BroadcastTextBuilder builder(source, CHAT_MSG_MONSTER_YELL, textId, source->GetGender());
    CreatureTextMgr::SendChatPacket(source, builder, CHAT_MSG_MONSTER_YELL, nullptr, TEXT_RANGE_ZONE);
}
}

/*
 * Commander Felstrom
 */

enum CommanderFelstrom
{
    NPC_COMMANDER_FELSTROM          = 771,
    SPELL_FELSTROM_RESURRECTION     = 3488
};

struct classic_commander_felstrom : public ScriptedAI
{
    classic_commander_felstrom(Creature* creature) : ScriptedAI(creature), _suicide(false), _risen(false), _suicideTimer(1500) { }

    // Felstrom Resurrection summons a new Felstrom and kills the old one. The risen one must not rise again,
    // or every kill at 10% brings back another one (reported as killing him 8 times in one run).
    void IsSummonedBy(WorldObject* summoner) override
    {
        if (summoner && summoner->GetEntry() == NPC_COMMANDER_FELSTROM)
            _risen = true;
    }

    void Reset() override
    {
        _suicideTimer = 1500;
        _suicide = false;
    }

    void JustDied(Unit* killer) override
    {
        // killed by his own resurrection spell: no loot (VMaNGOS SetLootRecipient(nullptr))
        if (killer && killer->GetEntry() == NPC_COMMANDER_FELSTROM)
        {
            me->SetTappedBy(nullptr);
            me->m_loot.reset();
            me->m_personalLoot.clear();
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        if (_suicideTimer < diff)
        {
            if (me->GetHealthPct() <= 10.0f)
            {
                if (!_suicide && !_risen)
                {
                    DoCastSelf(SPELL_FELSTROM_RESURRECTION, true);
                    _suicide = true;
                }
            }
        }
        else
            _suicideTimer -= diff;
    }

private:
    bool _suicide;
    bool _risen;
    uint32 _suicideTimer;
};

/*
 * Watcher Blomberg (Stitches event support)
 */

enum WatcherBlomberg
{
    NPC_WATCHER_DODDS   = 888,
    NPC_WATCHER_PAIGE   = 499,
    SAY_LOOK_ALIVE      = 16,
    FACTION_COMBAT      = 56
};

struct classic_watcher_blomberg : public ScriptedAI
{
    classic_watcher_blomberg(Creature* creature) : ScriptedAI(creature), _isEngaged(false), _sayTimer(3000) { }

    void Reset() override
    {
        me->SetWalk(false);
    }

    // VMaNGOS OnRemoveFromWorld
    void OnDespawn() override
    {
        if (Creature* dodds = ObjectAccessor::GetCreature(*me, _doddsGuid))
        {
            if (dodds->IsAlive() && !dodds->GetVictim())
            {
                dodds->ReplaceAllNpcFlags(NPCFlags(dodds->GetCreatureTemplate()->npcflag & 0xFFFFFFFF));
                dodds->RestoreFaction();
                dodds->SetImmuneToNPC(true);
                if (dodds->GetMotionMaster()->GetCurrentMovementGeneratorType() != HOME_MOTION_TYPE)
                    dodds->GetMotionMaster()->MoveTargetedHome();
            }
        }
        if (Creature* paige = ObjectAccessor::GetCreature(*me, _paigeGuid))
        {
            if (paige->IsAlive() && !paige->GetVictim())
            {
                if (paige->GetMotionMaster()->GetCurrentMovementGeneratorType() != HOME_MOTION_TYPE)
                    paige->GetMotionMaster()->MoveTargetedHome();
            }
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (!_isEngaged)
        {
            if (_sayTimer < diff)
            {
                ClassicScriptText(SAY_LOOK_ALIVE, me);
                _isEngaged = true;

                if (Creature* dodds = me->FindNearestCreature(NPC_WATCHER_DODDS, 200.0f))
                {
                    dodds->ReplaceAllNpcFlags(UNIT_NPC_FLAG_NONE);
                    dodds->SetFaction(FACTION_COMBAT);
                    dodds->SetImmuneToNPC(false);
                    dodds->GetMotionMaster()->MovePoint(0, -10903.043945f, -377.539124f, 40.065773f, true, {}, 1.19f);
                    _doddsGuid = dodds->GetGUID();
                }

                if (Creature* paige = me->FindNearestCreature(NPC_WATCHER_PAIGE, 200.0f))
                {
                    paige->GetMotionMaster()->MovePoint(0, -10906.221680f, -375.957214f, 39.960278f, true, {}, 1.19f);
                    _paigeGuid = paige->GetGUID();
                }
            }
            else
                _sayTimer -= diff;
        }

        ScriptedAI::UpdateAI(diff);
    }

private:
    bool _isEngaged;
    uint32 _sayTimer;
    ObjectGuid _doddsGuid;
    ObjectGuid _paigeGuid;
};

/*
 * Watcher Selkin (Stitches event support)
 */

// VMaNGOS script_waypoint entry 1100 (started with Start(true): run)
DuskwoodEscortPoint const SelkinPath[] =
{
    { -10618.2f, -1185.35f, 28.577f,       0 }, // 0
    { -10653.7f, -1192.26f, 28.486f,       0 }, // 1
    { -10689.5f, -1186.75f, 27.227f,       0 }, // 2
    { -10746.6f, -1152.20f, 26.514f,       0 }, // 3
    { -10771.4f, -1127.00f, 28.342f,       0 }, // 4
    { -10780.4f, -1105.50f, 31.711f,       0 }, // 5
    { -10789.7f, -1069.27f, 38.874f,       0 }, // 6
    { -10802.8f, -1037.89f, 45.726f,       0 }, // 7
    { -10807.5f,  -981.94f, 55.335f,       0 }, // 8
    { -10802.0f,  -957.14f, 56.383f,       0 }, // 9
    { -10794.5f,  -931.90f, 55.991f,       0 }, // 10
    { -10796.1f,  -912.86f, 55.861f,       0 }, // 11
    { -10811.0f,  -863.068f, 55.8616f,     0 }, // 12
    { -10828.9f,  -821.049f, 56.0904f, 300000 }, // 13
    { -10868.6f,  -772.222f, 55.6331f,     0 }, // 14
    { -10898.4f,  -739.738f, 55.345f,      0 }, // 15
    { -10918.6f,  -706.129f, 55.587f,      0 }, // 16
    { -10934.6f,  -677.592f, 55.604f,      0 }, // 17
    { -10957.2f,  -648.819f, 55.3365f,     0 }, // 18
    { -10960.2f,  -628.713f, 55.1653f,     0 }, // 19
    { -10951.6f,  -602.768f, 55.289f,      0 }, // 20
    { -10928.4f,  -564.199f, 54.0784f,     0 }, // 21
    { -10915.6f,  -534.164f, 53.903f,      0 }, // 22
    { -10911.0f,  -496.998f, 51.0605f,     0 }, // 23
    { -10907.2f,  -374.86f,  39.8722f,     0 }, // 24
};

struct classic_watcher_selkin : public EscortAI
{
    classic_watcher_selkin(Creature* creature) : EscortAI(creature)
    {
        for (uint32 i = 0; i < std::size(SelkinPath); ++i)
        {
            DuskwoodEscortPoint const& p = SelkinPath[i];
            AddWaypoint(i, p.x, p.y, p.z, 0.0f, p.waitMs ? Optional<Milliseconds>(Milliseconds(p.waitMs)) : Optional<Milliseconds>(), true);
        }
    }

    void Reset() override
    {
        me->SetWalk(false);
    }
};

/*
 * Sirra Von'Indi
 */

enum SirraVonIndi
{
    NPC_STITCHES = 412,

    QUEST_WAIT_FOR_SIRRA_TO_FINISH = 401
};

struct classic_npc_sirra_vonindi : public ScriptedAI
{
    classic_npc_sirra_vonindi(Creature* creature) : ScriptedAI(creature), _timer(3000), _canSummon(false) { }

    void Reset() override { }

    // VMaNGOS ResetCreature (respawn)
    void JustAppeared() override
    {
        _canSummon = false;
        _timer = 3000;
        ScriptedAI::JustAppeared();
    }

    void StitchesDied()
    {
        _timer = 10 * MINUTE * IN_MILLISECONDS;
        _stitchesGuid.Clear();
    }

    bool SummonStitches();

    void LaunchStitches(Creature* stitches) const;

    void OnQuestReward(Player* /*player*/, Quest const* quest, LootItemType /*type*/, uint32 /*opt*/) override
    {
        if (quest->GetQuestId() == QUEST_WAIT_FOR_SIRRA_TO_FINISH)
            SummonStitches();
    }

    void UpdateAI(uint32 diff) override
    {
        if (_stitchesGuid.IsEmpty() && !_canSummon)
        {
            if (_timer < diff)
                _canSummon = true;
            else
                _timer -= diff;
        }

        ScriptedAI::UpdateAI(diff);
    }

private:
    ObjectGuid _stitchesGuid;
    uint32 _timer;
    bool _canSummon;
};

/*
 * Stitches
 */

enum Stitches
{
    NPC_WATCHER_CORWIN      = 1204,
    NPC_WATCHER_SARYS       = 1203,
    NPC_TOWN_CRIER          = 468,
    NPC_WATCHER_HUTCHINS    = 1001,
    NPC_WATCHER_BLOMBERG    = 1000,
    NPC_WATCHER_CUTFORD     = 1436,
    NPC_WATCHER_MERANT      = 1098,
    NPC_WATCHER_GELWIN      = 1099,
    NPC_WATCHER_SELKIN      = 1100,
    NPC_WATCHER_THAYER      = 1101,

    STITCHES_YELL_1         = 277,
    STITCHES_YELL_2         = 278,
    TOWNCRIER_YELL_1        = 89,
    TOWNCRIER_YELL_2        = 90,
    TOWNCRIER_YELL_3        = 91,
    TOWNCRIER_YELL_4        = 92,
    TOWNCRIER_YELL_5        = 93,
    CUTFORD_YELL            = 276,

    SPELL_AURA_OF_ROT       = 3106
};

struct DuskwoodWatchmanCoords
{
    uint32 entry;
    float x, y, z, o;
};

DuskwoodWatchmanCoords const Watchman[] =
{
    { NPC_WATCHER_HUTCHINS, -10912.09f, -394.11f, 41.11f, 5.93f },
    { NPC_WATCHER_BLOMBERG, -10909.53f, -397.48f, 41.14f, 5.93f },

    { NPC_WATCHER_CUTFORD,  -10910.27f, -519.03f, 52.99f, 5.93f },

    { NPC_WATCHER_SELKIN,   -10618.22f, -1185.36f, 28.58f, 5.93f },
    { NPC_WATCHER_GELWIN,   -10618.90f, -1182.15f, 28.57f, 5.93f },
    { NPC_WATCHER_MERANT,   -10616.64f, -1181.67f, 28.49f, 5.93f },
    { NPC_WATCHER_THAYER,   -10615.99f, -1184.56f, 28.46f, 5.93f },

    { NPC_WATCHER_SARYS,    -10574.31f, -1179.06f, 28.03f, 3.05f },
    { NPC_WATCHER_CORWIN,   -10575.13f, -1170.07f, 28.25f, 3.61f }
};

// VMaNGOS script_waypoint entry 412
DuskwoodEscortPoint const StitchesPath[] =
{
    { -10277.6f,  54.27f,    42.2f,    5000 }, // 0
    { -10301.3f,  61.2281f,  41.6227f,    0 }, // 1
    { -10303.0f,  90.1979f,  37.9904f,    0 }, // 2
    { -10339.0f, 117.446f,   29.0969f,    0 }, // 3
    { -10351.5f, 123.068f,   30.4421f,    0 }, // 4
    { -10370.2f, 150.839f,   35.2507f,    0 }, // 5
    { -10388.7f, 203.77f,    33.8711f,    0 }, // 6
    { -10420.9f, 226.142f,   33.7127f,    0 }, // 7
    { -10453.4f, 242.73f,    31.3118f,    0 }, // 8
    { -10491.1f, 281.42f,    32.1841f,    0 }, // 9
    { -10536.2f, 295.187f,   30.9005f,    0 }, // 10
    { -10625.6f, 293.057f,   33.9319f,    0 }, // 11
    { -10635.4f, 288.561f,   36.2511f,    0 }, // 12
    { -10651.6f, 274.232f,   39.925f,     0 }, // 13
    { -10664.9f, 270.728f,   40.4314f,    0 }, // 14
    { -10687.9f, 283.994f,   40.3164f,    0 }, // 15
    { -10701.6f, 284.716f,   40.3482f,    0 }, // 16
    { -10727.9f, 281.341f,   41.5488f,    0 }, // 17
    { -10735.3f, 284.107f,   40.7814f,    0 }, // 18
    { -10750.9f, 301.799f,   39.2853f,    0 }, // 19
    { -10765.3f, 310.253f,   36.9858f,    0 }, // 20
    { -10795.7f, 308.84f,    32.6619f,    0 }, // 21
    { -10802.5f, 301.769f,   31.3551f,    0 }, // 22
    { -10804.2f, 282.183f,   30.6729f,    0 }, // 23
    { -10787.7f, 202.287f,   30.2021f,    0 }, // 24
    { -10755.3f, 137.25f,    29.0085f,    0 }, // 25
    { -10750.8f, 120.197f,   28.5755f,    0 }, // 26
    { -10754.1f,  71.1714f,  29.1834f,    0 }, // 27
    { -10783.5f,  -4.87522f, 30.1126f,    0 }, // 28
    { -10810.1f, -93.3187f,  29.072f,     0 }, // 29
    { -10835.3f, -164.599f,  33.8591f,    0 }, // 30
    { -10850.0f, -219.687f,  38.0445f,    0 }, // 31
    { -10863.3f, -282.047f,  38.1141f,    0 }, // 32
    { -10867.7f, -298.216f,  37.8923f,    0 }, // 33
    { -10901.5f, -373.583f,  39.92f,      0 }, // 34
    { -10905.3f, -423.588f,  42.1482f,    0 }, // 35
    { -10909.5f, -499.136f,  51.2137f,    0 }, // 36
    { -10912.0f, -520.589f,  53.2373f,    0 }, // 37
    { -10919.5f, -547.104f,  53.9189f,    0 }, // 38
    { -10930.1f, -571.311f,  54.14f,      0 }, // 39
    { -10948.6f, -595.613f,  55.0908f,    0 }, // 40
    { -10955.0f, -609.983f,  55.2477f,    0 }, // 41
    { -10957.9f, -637.303f,  55.182f,     0 }, // 42
    { -10954.8f, -650.701f,  55.4006f,    0 }, // 43
    { -10927.5f, -687.849f,  55.4896f,    0 }, // 44
    { -10908.5f, -724.489f,  54.7121f,    0 }, // 45
    { -10890.9f, -746.88f,   55.4449f,    0 }, // 46
    { -10844.5f, -796.238f,  56.1618f,    0 }, // 47
    { -10828.0f, -828.656f,  55.5704f,    0 }, // 48
    { -10814.2f, -856.816f,  55.9057f,    0 }, // 49
    { -10798.1f, -911.533f,  55.946f,     0 }, // 50
    { -10795.3f, -924.007f,  55.7429f,    0 }, // 51
    { -10798.2f, -945.427f,  56.5852f,    0 }, // 52
    { -10807.3f, -970.333f,  56.2262f,    0 }, // 53
    { -10804.6f, -1033.15f,  46.6068f,    0 }, // 54
    { -10803.3f, -1043.84f,  44.6945f,    0 }, // 55
    { -10786.5f, -1081.55f,  36.1924f,    0 }, // 56
    { -10777.6f, -1115.75f,  29.8918f,    0 }, // 57
    { -10760.7f, -1142.26f,  26.9919f,    0 }, // 58
    { -10705.8f, -1180.28f,  26.4369f,    0 }, // 59
    { -10678.3f, -1190.96f,  27.3871f,    0 }, // 60
    { -10658.8f, -1193.38f,  28.4673f,    0 }, // 61
    { -10618.9f, -1182.64f,  28.586f,     0 }, // 62
    { -10593.9f, -1177.6f,   28.3581f,    0 }, // 63
    { -10573.9f, -1175.1f,   28.003f,     0 }, // 64
    { -10560.3f, -1187.79f,  28.084f,     0 }, // 65
};

struct classic_npc_stitches : public EscortAI
{
    classic_npc_stitches(Creature* creature) : EscortAI(creature), _auraOfRotTimer(0), _launchTimer(10000), _launchChecked(false), _reachedEnd(false), _pathDone(false)
    {
        for (uint32 i = 0; i < std::size(StitchesPath); ++i)
        {
            DuskwoodEscortPoint const& p = StitchesPath[i];
            AddWaypoint(i, p.x, p.y, p.z, 0.0f, p.waitMs ? Optional<Milliseconds>(Milliseconds(p.waitMs)) : Optional<Milliseconds>(), false);
        }

        // VMaNGOS Stop() at the last point: Stitches stays and wanders around instead of despawning
        SetDespawnAtEnd(false);
    }

    ObjectGuid TownCrierGuid;
    ObjectGuid SirraVonIndiGuid;

    void Reset() override
    {
        _auraOfRotTimer = 0;
        _launchTimer = 10000;
        _launchChecked = false;
    }

    void TownCrierYell(uint32 textId)
    {
        Creature* townCrier = ObjectAccessor::GetCreature(*me, TownCrierGuid);
        if (townCrier && townCrier->IsAlive())
            DuskwoodYellToZone(townCrier, textId);
    }

    void JustDied(Unit* killer) override
    {
        TownCrierYell(TOWNCRIER_YELL_5);

        DespawnWatchers();

        if (Creature* sirra = ObjectAccessor::GetCreature(*me, SirraVonIndiGuid))
            if (classic_npc_sirra_vonindi* sirraAI = dynamic_cast<classic_npc_sirra_vonindi*>(sirra->AI()))
                sirraAI->StitchesDied();

        EscortAI::JustDied(killer);
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim && victim->GetEntry() == NPC_WATCHER_SELKIN)
            TownCrierYell(TOWNCRIER_YELL_3);
    }

    void DespawnWatchers()
    {
        for (ObjectGuid const& guid : _watchmenGuids)
            if (Creature* watchman = ObjectAccessor::GetCreature(*me, guid))
                watchman->DespawnOrUnsummon();
        _watchmenGuids.clear();
    }

    Creature* SummonWatchman(uint8 index)
    {
        Creature* watchman = me->SummonCreature(Watchman[index].entry, Watchman[index].x, Watchman[index].y, Watchman[index].z, Watchman[index].o,
            TEMPSUMMON_DEAD_DESPAWN, Milliseconds(uint64(WEEK) * IN_MILLISECONDS));
        if (watchman)
        {
            watchman->setActive(true);
            watchman->SetCorpseDelay(HOUR);
            watchman->SetRespawnDelay(WEEK);
        }
        return watchman;
    }

    // TODO(classic): VMaNGOS JoinCreatureGroup (formation move + aggro/evade together) for summoned watchmen. TC master
    // formations (CreatureGroup) only work for DB spawns (creature_formations by spawn id); followers use MoveFollow instead.
    void AddToFormation(Creature* leader, Creature* add) const
    {
        if (!leader || !add)
            return;

        add->GetMotionMaster()->MoveFollow(leader, 4.0f, ChaseAngle(leader->GetRelativeAngle(add)));
    }

    void JustSummoned(Creature* summoned) override
    {
        _watchmenGuids.insert(summoned->GetGUID());

        switch (summoned->GetEntry())
        {
            case NPC_WATCHER_HUTCHINS:
                summoned->SetWalk(false);
                summoned->GetMotionMaster()->MovePoint(0, -10905.52f, -374.1f, 39.88f);
                summoned->SetHomePosition(-10905.52f, -374.1f, 39.88f, 0.0f);
                break;
            case NPC_WATCHER_BLOMBERG:
                summoned->SetWalk(false);
                summoned->GetMotionMaster()->MovePoint(0, -10902.211914f, -375.488495f, 40.000954f);
                summoned->SetHomePosition(-10902.211914f, -375.488495f, 40.000954f, 0.0f);
                break;
            case NPC_WATCHER_SELKIN:
                if (classic_watcher_selkin* selkinAI = dynamic_cast<classic_watcher_selkin*>(summoned->AI()))
                    selkinAI->Start(true);
                break;
        }
    }

    void SummonedCreatureDies(Creature* summoned, Unit* /*killer*/) override
    {
        _watchmenGuids.erase(summoned->GetGUID());
    }

    void WaypointReached(uint32 waypointId, uint32 /*pathId*/) override
    {
        switch (waypointId)
        {
            case 10:
            case 29:
                DuskwoodYellToZone(me, STITCHES_YELL_1);
                break;
            case 30:
                TownCrierYell(TOWNCRIER_YELL_1);
                break;
            case 31:
                SummonWatchman(0);
                SummonWatchman(1);
                break;
            case 34:
                if (Creature* cutford = me->FindNearestCreature(NPC_WATCHER_CUTFORD, 300.0f))
                {
                    _watchmenGuids.insert(cutford->GetGUID());
                    cutford->SetWalk(false);
                    if (cutford->GetDistance2d(me) > 40.0f)
                    {
                        cutford->GetMotionMaster()->MovePoint(0, -10904.632f, -425.087f, 42.189217f);
                        cutford->SetHomePosition(-10904.632f, -425.087f, 42.189217f, 0.0f);
                    }
                    else
                        cutford->AI()->AttackStart(me);
                }
                break;
            case 35:
                TownCrierYell(TOWNCRIER_YELL_2);
                break;
            case 39:
            {
                Creature* leader = SummonWatchman(3);
                AddToFormation(leader, SummonWatchman(4));
                AddToFormation(leader, SummonWatchman(5));
                AddToFormation(leader, SummonWatchman(6));
                if (leader)
                    leader->SetWalk(false);
                break;
            }
            case 61:
                DuskwoodYellToZone(me, STITCHES_YELL_1);
                SummonWatchman(7);
                SummonWatchman(8);
                TownCrierYell(TOWNCRIER_YELL_4);
                break;
            case 65:
                me->SetHomePosition(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 1.64f);
                _reachedEnd = true; // Stop() + MoveRandom() once the escort has ended (see UpdateEscortAI)
                _pathDone = true;
                break;
        }
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        if (!urand(0, 3))
            me->Yell(STITCHES_YELL_2);
    }

    void UpdateEscortAI(uint32 diff) override
    {
        if (!_launchChecked)
        {
            if (_launchTimer < diff)
            {
                if (!HasEscortState(STATE_ESCORT_ESCORTING) && !_pathDone) // never relaunch after the path is done
                {
                    TC_LOG_ERROR("scripts", "[Duskwood.Stitches] Emergency launch.");
                    Start(true);
                }

                _launchChecked = true;
            }
            else
                _launchTimer -= diff;
        }

        if (_reachedEnd && !HasEscortState(STATE_ESCORT_ESCORTING) && !me->IsEngaged())
        {
            _reachedEnd = false;
            // VMaNGOS MoveRandom() without distance; TC needs an explicit wander distance for a summoned creature
            me->GetMotionMaster()->MoveRandom(5.0f);
        }

        if (!UpdateVictim())
            return;

        if (_auraOfRotTimer < diff)
        {
            if (DoCastVictim(SPELL_AURA_OF_ROT) == SPELL_CAST_OK)
                _auraOfRotTimer = 3000;
        }
        else
            _auraOfRotTimer -= diff;
    }

private:
    std::set<ObjectGuid> _watchmenGuids;
    uint32 _auraOfRotTimer;
    uint32 _launchTimer;
    bool _launchChecked;
    bool _reachedEnd;
    bool _pathDone;
};

/*
 * Sirra Von'Indi
 */

bool classic_npc_sirra_vonindi::SummonStitches()
{
    if (ObjectAccessor::GetCreature(*me, _stitchesGuid))
        return false;

    if (!_canSummon)
        return false;

    if (Creature* stitches = me->SummonCreature(NPC_STITCHES, -10277.63f, 54.27f, 42.2f, 4.22f, TEMPSUMMON_DEAD_DESPAWN, 0s))
    {
        stitches->setActive(true);
        _canSummon = false;
        _stitchesGuid = stitches->GetGUID();
        stitches->SetObjectScale(2.0f);

        LaunchStitches(stitches);
        return true;
    }

    return false;
}

void classic_npc_sirra_vonindi::LaunchStitches(Creature* stitches) const
{
    if (classic_npc_stitches* stitchesAI = dynamic_cast<classic_npc_stitches*>(stitches->AI()))
    {
        if (Creature* townCrier = me->FindNearestCreature(NPC_TOWN_CRIER, 400.0f))
            stitchesAI->TownCrierGuid = townCrier->GetGUID();

        stitchesAI->SirraVonIndiGuid = me->GetGUID();

        stitchesAI->Start(true);
    }
    else
        TC_LOG_ERROR("scripts", "[Duskwood.Stitches] Failed to cast AI (creature {} needs ScriptName classic_npc_stitches).", uint32(NPC_STITCHES));
}

void AddSC_classic_duskwood()
{
    RegisterCreatureAI(classic_commander_felstrom);
    RegisterCreatureAI(classic_watcher_selkin);
    RegisterCreatureAI(classic_watcher_blomberg);
    RegisterCreatureAI(classic_npc_stitches);
    RegisterCreatureAI(classic_npc_sirra_vonindi);
}
