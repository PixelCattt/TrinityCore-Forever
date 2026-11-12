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

// Classic 1.60 port of VMaNGOS src/scripts/eastern_kingdoms/loch_modan/loch_modan.cpp (ScriptDev2 lineage, GPL-2)
// Quest support: 273 (Resupplying the Excavation), 309 (Protecting the Shipment).

#include "ScriptMgr.h"
#include "Group.h"
#include "Map.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "QuestDef.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "TemporarySummon.h"
#include "classic_script_text.h"
#include <set>

/*######
## npc_miran
######*/

enum MiranData
{
    QUEST_PROTECTING_THE_SHIPMENT = 309,
    QUEST_RESUPPLYING_EXCAVATION = 273,
    NPC_HULDAR = 2057,
    NPC_MIRAN = 1379,
    NPC_SAEAN = 1380,
    NPC_DARK_IRON_AMBUSHER = 1981,
    SPAWN_GUID_HULDAR = 20008279,
    SPAWN_GUID_MIRAN = 20008975,
    SPAWN_GUID_SAEAN = 20100000,
    QUEST_273_PROTECT_CREDIT = 900273,
    FACTION_DARK_IRON = 54,
    FACTION_SAEAN = 57,
    ACTION_QUEST_273_SAEAN_DIED = 273,
    ACTION_QUEST_273_ABORT = 274,
    DATA_QUEST_273_DAMAGE_PLAYER = 275,
    ACTION_QUEST_273_DAMAGE_PLAYER = 275,
    ACTION_QUEST_273_START = 276,

    SAY_MIRAN_1           = 510,
    SAY_DARK_IRON_DWARF   = 1936,
    SAY_MIRAN_2           = 511,
    SAY_MIRAN_3           = 498,

    NPC_DARK_IRON_RAIDER  = 2149
};

Position const MiranAmbushSpawn[] =
{
    { -5691.93f, -3745.91f, 319.159f, 2.21f },
    { -5706.98f, -3745.39f, 318.728f, 1.04f }
};

namespace
{
struct ClassicEscortPoint
{
    uint32 Id;
    float X, Y, Z;
    uint32 WaitTime;
};
}

// VMaNGOS script_waypoint entry 1379 (pointid, x, y, z, waittime ms). VMaNGOS point ids start at 1; TC EscortAI needs
// node ids equal to the node index (0-based), so node id = VMaNGOS pointid - 1 (translated back in WaypointReached).
ClassicEscortPoint const MiranPath[] =
{
    {  1, -5751.12f, -3441.01f, 301.743f,     0 },
    {  2, -5738.58f, -3485.14f, 302.41f,      0 },
    {  3, -5721.62f, -3507.85f, 304.011f,     0 },
    {  4, -5710.21f, -3527.97f, 304.708f,     0 },
    {  5, -5706.92f, -3542.89f, 304.871f,     0 },
    {  6, -5701.53f, -3551.24f, 305.962f,     0 },
    {  7, -5699.53f, -3555.69f, 306.505f,     0 },
    {  8, -5690.56f, -3571.98f, 309.035f,     0 },
    {  9, -5678.61f, -3587.17f, 310.607f,     0 },
    { 10, -5677.05f, -3594.35f, 311.527f,     0 },
    { 11, -5674.39f, -3605.19f, 312.239f,     0 },
    { 12, -5674.45f, -3614.39f, 312.337f,     0 },
    { 13, -5673.05f, -3630.56f, 311.105f,     0 },
    { 14, -5680.34f, -3645.44f, 315.185f,     0 },
    { 15, -5684.46f, -3650.05f, 314.687f,     0 },
    { 16, -5693.9f,  -3674.14f, 313.03f,      0 },
    { 17, -5701.43f, -3712.54f, 313.959f,     0 },
    { 18, -5698.79f, -3720.88f, 316.943f,     0 },
    { 19, -5699.95f, -3733.63f, 318.597f,     0 }, // Protecting the Shipment - Ambush
    { 20, -5698.61f, -3754.74f, 322.047f,     0 },
    { 21, -5688.68f, -3769.0f,  323.957f,     0 },
    { 22, -5688.14f, -3782.65f, 322.667f,     0 },
    { 23, -5699.23f, -3792.65f, 322.448f, 30000 }, // Protecting the Shipment - End
    { 24, -5700.8f,  -3792.78f, 322.588f,     0 }
};

namespace
{
bool ClassicQuest273ObjectivesComplete(Player* player)
{
    return player->IsQuestObjectiveComplete(QUEST_RESUPPLYING_EXCAVATION, 9000273) &&
        player->IsQuestObjectiveComplete(QUEST_RESUPPLYING_EXCAVATION, 90002730);
}

void ClassicFailQuest273OnGuardDeath(Creature* huldar)
{
    if (!huldar || !huldar->GetMap())
        return;

    Map::PlayerList const& players = huldar->GetMap()->GetPlayers();
    for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
    {
        Player* player = itr->GetSource();
        if (player && player->GetQuestStatus(QUEST_RESUPPLYING_EXCAVATION) == QUEST_STATUS_INCOMPLETE &&
            huldar->IsWithinDistInMap(player, 75.0f) && !ClassicQuest273ObjectivesComplete(player))
            player->FailQuest(QUEST_RESUPPLYING_EXCAVATION);
    }
}

Creature* ClassicRestoreQuest273Actor(Creature* reference, uint32 entry, ObjectGuid::LowType spawnId, float range)
{
    Creature* actor = reference->FindNearestCreature(entry, range, false);
    if (actor && actor->IsAlive())
        return actor;

    if (actor && actor->GetSpawnId())
        spawnId = actor->GetSpawnId();

    Map* map = reference->GetMap();
    map->RemoveRespawnTime(SPAWN_TYPE_CREATURE, spawnId);
    Creature* restored = new Creature();
    if (!restored->LoadFromDB(spawnId, map, true, false))
    {
        delete restored;
        return nullptr;
    }
    return restored;
}
}

void ClassicRegisterQuest273Damage(Creature* attacker, Unit* damageSource);

struct npc_quest_273_huldar : public ScriptedAI
{
    explicit npc_quest_273_huldar(Creature* creature) : ScriptedAI(creature), _summons(creature) { }

    void Reset() override
    {
        if (_active || _resetInProgress)
            return;

        _remainingAttackers = 0;
        _saeanDefeated = false;
        _pendingDamagePlayer.Clear();
        _participants.clear();
    }

    void MoveInLineOfSight(Unit* who) override
    {
        if (!who)
            return;

        Player* player = who->ToPlayer();
        if (!player || player->GetQuestStatus(QUEST_RESUPPLYING_EXCAVATION) != QUEST_STATUS_INCOMPLETE ||
            !me->IsWithinDistInMap(player, 75.0f))
            return;

        player->KilledMonsterCredit(NPC_HULDAR);
        if (!_active && me->IsWithinDistInMap(player, 20.0f))
            StartAmbush(player);
    }

    void JustSummoned(Creature* summon) override
    {
        _summons.Summon(summon);
        if (_active && summon->GetEntry() == NPC_DARK_IRON_AMBUSHER)
            ++_remainingAttackers;
    }

    void SummonedCreatureDies(Creature* summon, Unit* /*killer*/) override
    {
        if (_active && summon->GetEntry() == NPC_DARK_IRON_AMBUSHER)
            AttackerDefeated();
    }

    void SetGUID(ObjectGuid const& guid, int32 id) override
    {
        if (id == DATA_QUEST_273_DAMAGE_PLAYER)
            _pendingDamagePlayer = guid;
    }

    void DoAction(int32 action) override
    {
        if (_resetInProgress)
            return;

        if (action == ACTION_QUEST_273_SAEAN_DIED && _active && !_saeanDefeated)
        {
            _saeanDefeated = true;
            AttackerDefeated();
        }
        else if (action == ACTION_QUEST_273_DAMAGE_PLAYER && _active)
        {
            if (Player* player = ObjectAccessor::GetPlayer(*me, _pendingDamagePlayer))
                AddParticipantAndParty(player);
            _pendingDamagePlayer.Clear();
        }
        else if (action == ACTION_QUEST_273_ABORT)
            ResetAfterGuardDeath();
    }

    void JustDied(Unit* /*killer*/) override
    {
        if (!_resetInProgress)
            ResetAfterGuardDeath();
    }

private:
    void AddParticipantAndParty(Player* player)
    {
        auto add = [this](Player* member)
        {
            if (member && member->GetQuestStatus(QUEST_RESUPPLYING_EXCAVATION) == QUEST_STATUS_INCOMPLETE &&
                me->IsWithinDistInMap(member, 75.0f) && _participants.insert(member->GetGUID()).second)
                member->KilledMonsterCredit(NPC_HULDAR);
        };

        add(player);
        if (Group* group = player->GetGroup())
            for (GroupReference const& groupRef : group->GetMembers())
                add(groupRef.GetSource());
    }

    void StartAmbush(Player* player)
    {
        if (_active)
            return;

        _active = true;
        _remainingAttackers = 0;
        _saeanDefeated = false;
        _pendingDamagePlayer.Clear();
        _summons.DespawnAll();

        Creature* miran = ClassicRestoreQuest273Actor(me, NPC_MIRAN, SPAWN_GUID_MIRAN, 40.0f);
        Creature* saean = ClassicRestoreQuest273Actor(me, NPC_SAEAN, SPAWN_GUID_SAEAN, 40.0f);
        if (!miran || !saean)
        {
            _active = false;
            return;
        }

        _remainingAttackers = 1;
        AddParticipantAndParty(player);

        saean->AI()->DoAction(ACTION_QUEST_273_START);
        saean->AI()->AttackStart(player);

        float x = me->GetPositionX();
        float y = me->GetPositionY();
        float z = me->GetPositionZ();
        float o = me->GetOrientation();
        if (Creature* ambusher = me->SummonCreature(NPC_DARK_IRON_AMBUSHER, x - 4.0f, y - 2.0f, z, o, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5min))
            ambusher->AI()->AttackStart(me);
        if (Creature* ambusher = me->SummonCreature(NPC_DARK_IRON_AMBUSHER, x + 4.0f, y + 2.0f, z, o, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5min))
            ambusher->AI()->AttackStart(miran);

        if (_remainingAttackers != 3)
            AbortAmbush();
    }

    void AttackerDefeated()
    {
        if (_remainingAttackers > 0)
            --_remainingAttackers;
        if (_remainingAttackers)
            return;

        _active = false;
        for (ObjectGuid const& guid : _participants)
            if (Player* player = ObjectAccessor::GetPlayer(*me, guid))
                if (player->GetQuestStatus(QUEST_RESUPPLYING_EXCAVATION) == QUEST_STATUS_INCOMPLETE &&
                    !player->IsQuestObjectiveComplete(QUEST_RESUPPLYING_EXCAVATION, 90002730))
                    player->KilledMonsterCredit(QUEST_273_PROTECT_CREDIT);

        FailNearbyNonParticipants();
        _participants.clear();
        ResetAfterSuccessfulDefense();
    }

    void FailNearbyNonParticipants()
    {
        Map::PlayerList const& players = me->GetMap()->GetPlayers();
        for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
        {
            Player* player = itr->GetSource();
            if (!player || player->GetQuestStatus(QUEST_RESUPPLYING_EXCAVATION) != QUEST_STATUS_INCOMPLETE ||
                !me->IsWithinDistInMap(player, 75.0f) || !player->IsQuestObjectiveComplete(QUEST_RESUPPLYING_EXCAVATION, 9000273) ||
                player->IsQuestObjectiveComplete(QUEST_RESUPPLYING_EXCAVATION, 90002730))
                continue;

            if (_participants.find(player->GetGUID()) == _participants.end())
                player->FailQuest(QUEST_RESUPPLYING_EXCAVATION);
        }
    }

    void AbortAmbush()
    {
        _active = false;
        _remainingAttackers = 0;
        _pendingDamagePlayer.Clear();
        _participants.clear();
        _summons.DespawnAll();
        if (Creature* saean = me->FindNearestCreature(NPC_SAEAN, 40.0f))
            saean->AI()->DoAction(ACTION_QUEST_273_ABORT);
    }

    void ResetAfterGuardDeath()
    {
        if (_resetInProgress)
            return;

        _resetInProgress = true;
        AbortAmbush();

        if (!me->IsAlive())
            me->Respawn(true);
        ClassicRestoreQuest273Actor(me, NPC_MIRAN, SPAWN_GUID_MIRAN, 75.0f);
        ClassicRestoreQuest273Actor(me, NPC_SAEAN, SPAWN_GUID_SAEAN, 75.0f);

        ClassicFailQuest273OnGuardDeath(me);
        _resetInProgress = false;
    }

    void ResetAfterSuccessfulDefense()
    {
        if (_resetInProgress)
            return;

        _resetInProgress = true;
        AbortAmbush();

        ClassicRestoreQuest273Actor(me, NPC_HULDAR, SPAWN_GUID_HULDAR, 75.0f);
        ClassicRestoreQuest273Actor(me, NPC_MIRAN, SPAWN_GUID_MIRAN, 75.0f);
        ClassicRestoreQuest273Actor(me, NPC_SAEAN, SPAWN_GUID_SAEAN, 75.0f);

        _resetInProgress = false;
    }

    bool _active = false;
    bool _saeanDefeated = false;
    bool _resetInProgress = false;
    uint8 _remainingAttackers = 0;
    ObjectGuid _pendingDamagePlayer;
    std::set<ObjectGuid> _participants;
    SummonList _summons;
};

struct npc_quest_273_saean : public ScriptedAI
{
    explicit npc_quest_273_saean(Creature* creature) : ScriptedAI(creature) { }

    void Reset() override
    {
        if (!_encounterActive)
            me->SetFaction(FACTION_SAEAN);
    }

    void DoAction(int32 action) override
    {
        if (action == ACTION_QUEST_273_START)
        {
            _encounterActive = true;
            me->SetFaction(FACTION_DARK_IRON);
        }
        else if (action == ACTION_QUEST_273_ABORT)
        {
            _encounterActive = false;
            me->CombatStop(true);
            me->SetFaction(FACTION_SAEAN);
        }
    }

    void DamageTaken(Unit* attacker, uint32& damage, DamageEffectType /*damageType*/, SpellInfo const* /*spellInfo*/) override
    {
        if (damage > 0)
            ClassicRegisterQuest273Damage(me, attacker);
    }

    void JustDied(Unit* /*killer*/) override
    {
        _encounterActive = false;
        if (Creature* huldar = me->FindNearestCreature(NPC_HULDAR, 50.0f))
            huldar->AI()->DoAction(ACTION_QUEST_273_SAEAN_DIED);
    }

private:
    bool _encounterActive = false;
};

struct npc_quest_273_ambusher : public ScriptedAI
{
    explicit npc_quest_273_ambusher(Creature* creature) : ScriptedAI(creature) { }

    void DamageTaken(Unit* attacker, uint32& damage, DamageEffectType /*damageType*/, SpellInfo const* /*spellInfo*/) override
    {
        if (damage > 0)
            ClassicRegisterQuest273Damage(me, attacker);
    }
};

void ClassicRegisterQuest273Damage(Creature* attacker, Unit* damageSource)
{
    if (!damageSource)
        return;

    Player* player = damageSource->GetCharmerOrOwnerPlayerOrPlayerItself();
    if (!player)
        return;

    if (Creature* huldar = attacker->FindNearestCreature(NPC_HULDAR, 75.0f))
    {
        huldar->AI()->SetGUID(player->GetGUID(), DATA_QUEST_273_DAMAGE_PLAYER);
        huldar->AI()->DoAction(ACTION_QUEST_273_DAMAGE_PLAYER);
    }
}

struct classic_npc_miran : public EscortAI
{
    classic_npc_miran(Creature* creature) : EscortAI(creature), _dwarves(0) { }

    void Reset() override
    {
        if (!HasEscortState(STATE_ESCORT_ESCORTING))
            _dwarves = 0;
    }

    void JustDied(Unit* /*killer*/) override
    {
        if (Creature* huldar = me->FindNearestCreature(NPC_HULDAR, 75.0f, false))
            huldar->AI()->DoAction(ACTION_QUEST_273_ABORT);
    }

    void WaypointReached(uint32 waypointId, uint32 /*pathId*/) override
    {
        switch (waypointId + 1) // VMaNGOS point id
        {
            case 19:
                ClassicScriptText(SAY_MIRAN_1, me);
                me->SummonCreature(NPC_DARK_IRON_RAIDER, MiranAmbushSpawn[0], TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 25s);
                me->SummonCreature(NPC_DARK_IRON_RAIDER, MiranAmbushSpawn[1], TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 25s);
                break;
            case 23:
                ClassicScriptText(SAY_MIRAN_3, me);
                if (Player* player = GetPlayerForEscort())
                    player->GroupEventHappens(QUEST_PROTECTING_THE_SHIPMENT, me);
                break;
        }
    }

    void SummonedCreatureDies(Creature* summoned, Unit* /*killer*/) override
    {
        if (summoned->GetEntry() == NPC_DARK_IRON_RAIDER)
        {
            --_dwarves;
            if (!_dwarves)
                ClassicScriptText(SAY_MIRAN_2, me);
        }
    }

    void JustSummoned(Creature* summoned) override
    {
        if (summoned->GetEntry() == NPC_DARK_IRON_RAIDER)
        {
            if (!_dwarves)
                ClassicScriptText(SAY_DARK_IRON_DWARF, summoned);
            ++_dwarves;
            if (summoned->AI())
                summoned->AI()->AttackStart(me);
        }
    }

    void OnQuestAccept(Player* player, Quest const* quest) override
    {
        if (quest->GetQuestId() == QUEST_PROTECTING_THE_SHIPMENT)
        {
            ResetPath();
            for (ClassicEscortPoint const& point : MiranPath)
            {
                Optional<Milliseconds> wait;
                if (point.WaitTime)
                    wait = Milliseconds(point.WaitTime);
                AddWaypoint(point.Id - 1, point.X, point.Y, point.Z, 0.0f, wait, false);
            }
            Start(false, player->GetGUID(), quest);
        }
    }

private:
    uint8 _dwarves;
};

void AddSC_classic_loch_modan()
{
    RegisterCreatureAI(classic_npc_miran);
    RegisterCreatureAI(npc_quest_273_huldar);
    RegisterCreatureAI(npc_quest_273_saean);
    RegisterCreatureAI(npc_quest_273_ambusher);
}
