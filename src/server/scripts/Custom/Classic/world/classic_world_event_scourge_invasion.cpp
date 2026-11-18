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

// Classic 1.60 port of the VMaNGOS Scourge Invasion (the Naxxramas opening world event): src/scripts/world/scourge_invasion.cpp/.h
// and the ScourgeInvasionEvent controller in src/game/GameEvents/HardcodedEvents.cpp (VMaNGOS project, GPL-2).
//
// How it runs here
// - Off unless Classic.ScourgeInvasion = 1 in worldserver.conf, or a GM runs ".scourge on" (saved, survives a restart).
// - The controller (a WorldScript, every 20 s before the maps update) starts the master event 17 (Argent Dawn NPCs) and 81
//   (the five dungeon bosses), rotates the six zone attacks (events 90-95, 45-60 min timers, at most two zones at once, never the
//   zone just won twice in a row), counts battles won (world state 2219) and runs the 50 / 100 / 150 milestone events (96-99).
//   It also sends a Pallid Horror or Patchwork Terror into Stormwind and Undercity every 45-60 min.
// - Zone attack: the Herald of the Lich King (Mouth of Kel'Thuzad) is summoned at the zone's point and yells, a storm starts, and
//   the zone's event spawns appear (necropolises, their helpers, summoning circles, minion finders). Each circle raises a
//   Necrotic Shard. Minions spawn around it; every minion killed zaps the shard. A dead shard turns into a Damaged Necrotic Shard
//   with 4 Cultist Engineers channelling on it. Killing a cultist hurts the shard; a player with 8 Necrotic Runes can make a
//   cultist summon a Shadow of Doom, whose death takes a quarter of the shard's health. When the damaged shard dies, the death
//   travels shard -> relay -> proxy -> necropolis health; three hits and that necropolis falls. No necropolis left = the zone is won.
// - All event start / stop, summons of the Herald and the city attackers, weather and clean-up happen in the controller (world
//   thread, maps idle). The creature scripts only touch their own map and the realm world states (WorldStateMgr locks those).
//
// Differences from VMaNGOS (on purpose)
// - VMaNGOS passes the chain on with spells and their target rows (spell_script_target). Here the scripts find the next link
//   themselves (nearest relay / proxy / necropolis health) and cast the same spells only as visuals, so a missing spell target row
//   cannot break the chain. Damage to the shards uses the spells' own values when the client data has them.
// - Relays, proxies, finders, circles, doodads and necropolises that are used up are despawned with a one week respawn instead of
//   being removed from the world; starting the zone event again clears those respawn times (GameEventMgr does that).
// - The invisible minion spawner NPCs (16306 / 16336 / 16338) are skipped: the shard summons the minion at the finder.
// - The minion abilities (EventAI in VMaNGOS, not in the source) are in classic_si_minion with timers from the header's sniff notes.
// - VMaNGOS walks the city attackers on waypoint paths 149701 / 149702 / 151901 / 151902, which are not in our data. Here they walk
//   to Highlord Bolvar Fordragon / Lady Sylvanas Windrunner (their spawn point from the world database) and keep going after fights.
// - Not ported: the purple communique bolts every 15-35 s between necropolis, proxies, relays and shards (visual only), the
//   guard and citizen shouts during a city attack, and the "give me one of your magic items" gossip of the Argent Dawn NPCs.

#include "ScriptMgr.h"
#include "CellImpl.h"
#include "Chat.h"
#include "ChatCommand.h"
#include "Config.h"
#include "Containers.h"
#include "Creature.h"
#include "CreatureAI.h"
#include "CreatureAIImpl.h"
#include "DB2Stores.h"
#include "GameEventMgr.h"
#include "GameObject.h"
#include "GameObjectAI.h"
#include "GameTime.h"
#include "GossipDef.h"
#include "GridNotifiersImpl.h"
#include "Log.h"
#include "Map.h"
#include "MapManager.h"
#include "MotionMaster.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "QuaternionData.h"
#include "RBAC.h"
#include "Random.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "TemporarySummon.h"
#include "Util.h"
#include "Weather.h"
#include "WorldSession.h"
#include "WorldStateMgr.h"
#include "classic_script_text.h"
#include <algorithm>
#include <array>
#include <atomic>
#include <functional>
#include <list>
#include <mutex>
#include <set>
#include <type_traits>
#include <unordered_map>
#include <vector>

namespace ScourgeInvasion
{
enum Spells : uint32
{
    SPELL_COMMUNIQUE_CAMP_TO_RELAY_DEATH    = 28351, // visual, damaged shard -> relay -> proxy -> necropolis health
    SPELL_ZAP_NECROPOLIS                    = 28386, // visual on the necropolis health
    SPELL_DESPAWNER_OTHER                   = 28349, // visual, necropolis health -> necropolis
    SPELL_CAMP_RECEIVES_COMMUNIQUE          = 28449, // impact visual on the shard
    SPELL_DAMAGE_CRYSTAL                    = 28041, // cultist death: damage to the damaged shard
    SPELL_SOUL_REVIVAL                      = 28681, // damaged shard death: +10% damage for the defenders around it
    SPELL_ZAP_CRYSTAL                       = 28032, // minion death: damage to the shard
    SPELL_MINION_SPAWN_IN                   = 28234, // pink lightning
    SPELL_SPIRIT_SPAWN_OUT                  = 17680,
    SPELL_SCOURGE_STRIKE                    = 28265, // minions: instant kill on NPCs
    SPELL_ENRAGE                            = 8599,
    SPELL_BONE_SHARDS                       = 17014,
    SPELL_INFECTED_BITE                     = 7367,
    SPELL_DEMORALIZING_SHOUT                = 16244,
    SPELL_SUNDER_ARMOR                      = 21081,
    SPELL_KNOCKDOWN                         = 16790,
    SPELL_TRAMPLE                           = 5568,
    SPELL_AURA_OF_FEAR                      = 28313,
    SPELL_RIBBON_OF_SOULS                   = 16243,
    SPELL_PSYCHIC_SCREAM                    = 22884,
    SPELL_ARCANE_BOLT                       = 13748,
    SPELL_CREATE_SUMMONER_SHIELD            = 28132,
    SPELL_BUTTRESS_CHANNEL                  = 28078,
    SPELL_SPAWN_SMOKE                       = 10389,
    SPELL_ZAP_CRYSTAL_CORPSE                = 28056, // Shadow of Doom death: a quarter of the damaged shard's health
    SPELL_MINDFLAY                          = 16568,
    SPELL_FEAR                              = 12542,
    SPELL_DAMAGE_VS_GUARDS                  = 28364,
    SPELL_FLAMESHOCKERS_TOUCH               = 28314,
    SPELL_FLAMESHOCKERS_REVENGE             = 28323,
    SPELL_FLAMESHOCKERS_TOUCH2              = 28329,
};

enum Creatures : uint32
{
    NPC_MOUTH_OF_KELTHUZAD                  = 16995, // "Herald of the Lich King" in our data
    NPC_NECROTIC_SHARD                      = 16136,
    NPC_DAMAGED_NECROTIC_SHARD              = 16172,
    NPC_CULTIST_ENGINEER                    = 16230,
    NPC_SHADOW_OF_DOOM                      = 16143,
    NPC_MINION_FINDER                       = 16356,
    NPC_NECROPOLIS                          = 16401,
    NPC_NECROPOLIS_HEALTH                   = 16421,
    NPC_NECROPOLIS_PROXY                    = 16398,
    NPC_NECROPOLIS_RELAY                    = 16386,
    NPC_SKELETAL_SHOCKTROOPER               = 16299,
    NPC_GHOUL_BERSERKER                     = 16141,
    NPC_SPECTRAL_SOLDIER                    = 16298,
    NPC_LUMBERING_HORROR                    = 14697,
    NPC_BONE_WITCH                          = 16380,
    NPC_SPIRIT_OF_THE_DAMNED                = 16379,
    NPC_PALLID_HORROR                       = 16394,
    NPC_PATCHWORK_TERROR                    = 16382,
    NPC_CRACKED_NECROTIC_CRYSTAL            = 16431,
    NPC_FAINT_NECROTIC_CRYSTAL              = 16531,
    NPC_FLAMESHOCKER                        = 16383,
    NPC_HIGHLORD_BOLVAR_FORDRAGON           = 1748,
    NPC_LADY_SYLVANAS_WINDRUNNER            = 10181,
    NPC_VARIMATHRAS                         = 2425,
    NPC_ROYAL_DREADGUARD                    = 13839,
    NPC_STORMWIND_ROYAL_GUARD               = 1756,
    NPC_UNDERCITY_ELITE_GUARDIAN            = 16432,
    NPC_UNDERCITY_GUARDIAN                  = 5624,
    NPC_DEATHGUARD_ELITE                    = 7980,
    NPC_STORMWIND_CITY_GUARD                = 68,
    NPC_STORMWIND_ELITE_GUARD               = 16396,
};

enum GameObjects : uint32
{
    GO_SUMMON_CIRCLE                        = 181136,
    GO_SUMMONER_SHIELD                      = 181142,
    GO_UNDEAD_FIRE                          = 181173,
    GO_UNDEAD_FIRE_AURA                     = 181174,
    GO_SKULLPILE_01                         = 181191,
    GO_SKULLPILE_02                         = 181192,
    GO_SKULLPILE_03                         = 181193,
    GO_SKULLPILE_04                         = 181194,
    GO_NECROPOLIS_TINY                      = 181154,
    GO_NECROPOLIS_SMALL                     = 181373,
    GO_NECROPOLIS_MEDIUM                    = 181374,
    GO_NECROPOLIS_BIG                       = 181215,
    GO_NECROPOLIS_HUGE                      = 181223,
};

enum Misc : uint32
{
    ITEM_NECROTIC_RUNE                      = 22484,
    RUNES_FOR_SHADOW                        = 8,

    ZONE_ATTACK_TIMER_MIN                   = 45 * MINUTE,
    ZONE_ATTACK_TIMER_MAX                   = 60 * MINUTE,
    CITY_ATTACK_TIMER_MIN                   = 45 * MINUTE,
    CITY_ATTACK_TIMER_MAX                   = 60 * MINUTE,

    ZONEID_WINTERSPRING                     = 618,
    ZONEID_AZSHARA                          = 16,
    ZONEID_EASTERN_PLAGUELANDS              = 139,
    ZONEID_BLASTED_LANDS                    = 4,
    ZONEID_BURNING_STEPPES                  = 46,
    ZONEID_TANARIS                          = 440,
    ZONEID_UNDERCITY                        = 1497,
    ZONEID_STORMWIND                        = 1519,

    GAME_EVENT_SCOURGE_INVASION             = 17,
    GAME_EVENT_BOSS_IN_INSTANCE             = 81,
    GAME_EVENT_ATTACK_WINTERSPRING          = 90,
    GAME_EVENT_ATTACK_TANARIS               = 91,
    GAME_EVENT_ATTACK_AZSHARA               = 92,
    GAME_EVENT_ATTACK_BLASTED_LANDS         = 93,
    GAME_EVENT_ATTACK_EASTERN_PLAGUELANDS   = 94,
    GAME_EVENT_ATTACK_BURNING_STEPPES       = 95,
    GAME_EVENT_50_INVASIONS                 = 96,
    GAME_EVENT_100_INVASIONS                = 97,
    GAME_EVENT_150_INVASIONS                = 98,
    GAME_EVENT_INVASIONS_DONE               = 99,

    // client world states (world map / Argent Emissary)
    WS_SI_BATTLES_WON                       = 2219,
    WS_SI_WINTERSPRING_INVADED              = 2259,
    WS_SI_AZSHARA_INVADED                   = 2260,
    WS_SI_BLASTED_LANDS_INVADED             = 2261,
    WS_SI_BURNING_STEPPES_INVADED           = 2262,
    WS_SI_TANARIS_INVADED                   = 2263,
    WS_SI_EASTERN_PLAGUELANDS_INVADED       = 2264,
    WS_SI_AZSHARA_REMAINING                 = 2279,
    WS_SI_BLASTED_LANDS_REMAINING           = 2280,
    WS_SI_BURNING_STEPPES_REMAINING         = 2281,
    WS_SI_PLAGUELANDS_REMAINING             = 2282,
    WS_SI_TANARIS_REMAINING                 = 2283,
    WS_SI_WINTERSPRING_REMAINING            = 2284,

    // script world states (VMaNGOS saved variables 17000 + zone / 170000 + zone, moved up so they cannot clash with client ones)
    WS_SCRIPT_ATTACK_TIME_BASE              = 17000000, // + zone id
    WS_SCRIPT_LAST_ATTACK_ZONE              = 17000001,
    WS_SCRIPT_GM_SWITCH                     = 17000002, // 0 = follow the config, 1 = on, 2 = off
    WS_SCRIPT_CITY_TIME_BASE                = 17100000, // + zone id

    // broadcast texts
    BCT_MOUTH_ZONE_ATTACK_START_1           = 13121,
    BCT_MOUTH_ZONE_ATTACK_START_2           = 13125,
    BCT_MOUTH_ZONE_ATTACK_ENDS_1            = 13165,
    BCT_MOUTH_ZONE_ATTACK_ENDS_2            = 13164,
    BCT_MOUTH_ZONE_ATTACK_ENDS_3            = 13163,
    BCT_MOUTH_RANDOM_1                      = 13126,
    BCT_MOUTH_RANDOM_2                      = 13124,
    BCT_MOUTH_RANDOM_3                      = 13122,
    BCT_MOUTH_RANDOM_4                      = 13123,
    BCT_SHADOW_OF_DOOM_TEXT_0               = 12420,
    BCT_SHADOW_OF_DOOM_TEXT_1               = 12421,
    BCT_SHADOW_OF_DOOM_TEXT_2               = 12422,
    BCT_SHADOW_OF_DOOM_TEXT_3               = 12243,
    BCT_CULTIST_ENGINEER_OPTION             = 12112,
    BCT_PALLID_HORROR_YELL1                 = 12329,
    BCT_PALLID_HORROR_YELL2                 = 12327,
    BCT_PALLID_HORROR_YELL3                 = 12326,
    BCT_PALLID_HORROR_YELL4                 = 12342,
    BCT_PALLID_HORROR_YELL5                 = 12343,
    BCT_PALLID_HORROR_YELL6                 = 12330,
    BCT_PALLID_HORROR_YELL7                 = 12328,
    BCT_PALLID_HORROR_YELL8                 = 12325,
    BCT_UNDERCITY_SYLVANAS_1                = 12331,
    BCT_STORMWIND_BOLVAR_2                  = 12318,
    BCT_ARGENT_EMISSARY_OPTION_0            = 12176,
    BCT_ARGENT_EMISSARY_OPTION_1            = 12207,
    BCT_ARGENT_EMISSARY_OPTION_2            = 12434,
    BCT_ARGENT_EMISSARY_OPTION_2_SUB_0      = 12198, // Winterspring
    BCT_ARGENT_EMISSARY_OPTION_2_SUB_1      = 12201, // Tanaris
    BCT_ARGENT_EMISSARY_OPTION_2_SUB_2      = 12203, // Blasted Lands
    BCT_ARGENT_EMISSARY_OPTION_2_SUB_3      = 12205, // Burning Steppes
    BCT_ARGENT_EMISSARY_OPTION_2_SUB_4      = 12476, // Azshara
    BCT_ARGENT_EMISSARY_OPTION_2_SUB_5      = 12477, // Eastern Plaguelands
    BCT_ARGENT_EMISSARY_OPTION_3            = 12398,
    BCT_ARGENT_EMISSARY_OPTION_BACK         = 12478,

    // npc_text (VMaNGOS ids)
    TEXT_CULTIST_ENGINEER                   = 8436,
    TEXT_ARGENT_EMISSARY                    = 8434,
    TEXT_ARGENT_EMISSARY_ANSWER_0           = 8471,
    TEXT_ARGENT_EMISSARY_ANSWER_1           = 8486,
    TEXT_ARGENT_EMISSARY_ANSWER_2           = 8573,
    TEXT_ARGENT_EMISSARY_WINTERSPRING       = 8480,
    TEXT_ARGENT_EMISSARY_TANARIS            = 8482,
    TEXT_ARGENT_EMISSARY_BLASTED_LANDS      = 8483,
    TEXT_ARGENT_EMISSARY_BURNING_STEPPES    = 8484,
    TEXT_ARGENT_EMISSARY_AZSHARA            = 8593,
    TEXT_ARGENT_EMISSARY_PLAGUELANDS        = 8594,
    TEXT_ARGENT_EMISSARY_WINS_0             = 8551,
    TEXT_ARGENT_EMISSARY_WINS_1             = 8554,
    TEXT_ARGENT_EMISSARY_WINS_2             = 8555,
    TEXT_ARGENT_EMISSARY_FREE_OF_SCOURGE    = 8481,
};

enum Actions : int32
{
    ACTION_MOUTH_ZONE_START                 = 1,
    ACTION_MOUTH_ZONE_RESUME                = 2,
    ACTION_MOUTH_ZONE_STOP                  = 3,
    ACTION_HEALTH_ZAP                       = 10,
    ACTION_SHARD_CAMP_TYPE_BASE             = 20, // + camp type (1-3)
    ACTION_FLAMESHOCKER_DESPAWN_TIMER       = 30,
};

enum CampType : uint32
{
    CAMP_NONE                               = 0,
    CAMP_GHOUL_SKELETON                     = 1,
    CAMP_GHOST_GHOUL                        = 2,
    CAMP_GHOST_SKELETON                     = 3,
};

constexpr uint32 SHARD_DATA_CAMP_TYPE = 1;
constexpr uint32 SHADOW_DATA_SUMMONER = 1;

struct InvasionZone
{
    uint32 ZoneId;
    uint32 MapId;
    uint16 EventId;
    uint32 NecropolisCount;
    int32 WsInvaded;
    int32 WsRemaining;
    Position MouthPos;
    char const* Name;
    char const* Key;
};

std::array<InvasionZone, 6> const Zones =
{ {
    { ZONEID_WINTERSPRING,       1, GAME_EVENT_ATTACK_WINTERSPRING,        3, WS_SI_WINTERSPRING_INVADED,        WS_SI_WINTERSPRING_REMAINING,     { 7736.56f, -4033.75f, 696.327f, 5.51524f },   "Winterspring",        "winterspring" },
    { ZONEID_TANARIS,            1, GAME_EVENT_ATTACK_TANARIS,             3, WS_SI_TANARIS_INVADED,             WS_SI_TANARIS_REMAINING,          { -8352.68f, -3972.68f, 10.0753f, 2.14675f },  "Tanaris",             "tanaris" },
    { ZONEID_AZSHARA,            1, GAME_EVENT_ATTACK_AZSHARA,             2, WS_SI_AZSHARA_INVADED,             WS_SI_AZSHARA_REMAINING,          { 3273.75f, -4276.98f, 125.509f, 5.44543f },   "Azshara",             "azshara" },
    { ZONEID_BLASTED_LANDS,      0, GAME_EVENT_ATTACK_BLASTED_LANDS,       2, WS_SI_BLASTED_LANDS_INVADED,       WS_SI_BLASTED_LANDS_REMAINING,    { -11429.3f, -3327.82f, 7.73628f, 1.0821f },   "Blasted Lands",       "blasted" },
    { ZONEID_EASTERN_PLAGUELANDS, 0, GAME_EVENT_ATTACK_EASTERN_PLAGUELANDS, 2, WS_SI_EASTERN_PLAGUELANDS_INVADED, WS_SI_PLAGUELANDS_REMAINING,      { 2014.55f, -4934.52f, 73.9846f, 0.0698132f }, "Eastern Plaguelands", "epl" },
    { ZONEID_BURNING_STEPPES,    0, GAME_EVENT_ATTACK_BURNING_STEPPES,     2, WS_SI_BURNING_STEPPES_INVADED,     WS_SI_BURNING_STEPPES_REMAINING,  { -8229.53f, -1118.11f, 144.012f, 6.17846f },  "Burning Steppes",     "steppes" },
} };

struct CityAttack
{
    uint32 ZoneId;
    uint32 MapId;
    uint32 LeaderEntry;
    Position LeaderFallback;
    std::vector<Position> Spawns;
    char const* Name;
    char const* Key;
};

std::array<CityAttack, 2> const Cities =
{ {
    { ZONEID_UNDERCITY, 0, NPC_LADY_SYLVANAS_WINDRUNNER, { 1289.0f, 314.0f, -57.3f, 0.0f },
        { { 1595.87f, 440.539f, -46.3349f, 2.28207f }, { 1659.2f, 265.988f, -62.1788f, 3.64283f } }, "Undercity", "uc" },
    { ZONEID_STORMWIND, 0, NPC_HIGHLORD_BOLVAR_FORDRAGON, { -8446.6f, 336.0f, 122.2f, 0.0f },
        { { -8578.15f, 886.382f, 87.3148f, 0.586275f } }, "Stormwind", "sw" },
} };

InvasionZone const* FindZone(uint32 zoneId)
{
    for (InvasionZone const& zone : Zones)
        if (zone.ZoneId == zoneId)
            return &zone;
    return nullptr;
}

// the zone of a spawn by its position: its own zone id, else the nearest invasion point on the same map
InvasionZone const* FindZoneFor(WorldObject const* object)
{
    if (InvasionZone const* zone = FindZone(object->GetZoneId()))
        return zone;

    InvasionZone const* best = nullptr;
    float bestDist = 0.0f;
    for (InvasionZone const& zone : Zones)
    {
        if (zone.MapId != object->GetMapId())
            continue;
        float dist = object->GetExactDist2dSq(zone.MouthPos);
        if (!best || dist < bestDist)
        {
            best = &zone;
            bestDist = dist;
        }
    }
    return best;
}

bool IsSiZoneEvent(uint16 eventId)
{
    return eventId >= GAME_EVENT_ATTACK_WINTERSPRING && eventId <= GAME_EVENT_ATTACK_BURNING_STEPPES;
}

int32 GetWs(int32 id)
{
    return WorldStateMgr::GetValue(id, nullptr);
}

void SetWs(int32 id, int32 value)
{
    if (WorldStateMgr::GetValue(id, nullptr) != value)
        WorldStateMgr::SetValueAndSaveInDb(id, value, false, nullptr);
}

// Classic.ScourgeInvasion.ShardDamageRate: scales what minions, cultists and Shadows of Doom do to the shards
std::atomic<float> ShardDamageRate{ 1.0f };

// damage of a spell's first damage effect from the client data, else the fallback
int32 SpellDamage(uint32 spellId, int32 fallback)
{
    if (SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId, DIFFICULTY_NONE))
        for (SpellEffectInfo const& effect : spellInfo->GetEffects())
            if (effect.IsEffect(SPELL_EFFECT_SCHOOL_DAMAGE) || effect.IsEffect(SPELL_EFFECT_ENVIRONMENTAL_DAMAGE))
                if (int32 value = effect.CalcValueAsInt())
                    return std::abs(value);
    return fallback;
}

// VMaNGOS ADD_GOSSIP_ITEM(broadcast text id): the localized BroadcastText, else the English text
std::string GossipText(Player* player, uint32 broadcastTextId, char const* fallback)
{
    if (BroadcastTextEntry const* bct = sBroadcastTextStore.LookupEntry(broadcastTextId))
    {
        char const* text = DB2Manager::GetBroadcastTextValue(bct, player->GetSession()->GetSessionDbLocaleIndex(), player->GetGender());
        if (text && *text)
            return text;
    }
    return fallback;
}

// Summons the event made, per zone, so the controller can clear them when the zone is won or the event is switched off.
// Map threads add, the controller (maps idle) takes them out.
class SummonRegistry
{
public:
    // key: the invasion zone (or city) the summon belongs to; 0 = find it from the position
    void Add(WorldObject const* object, uint32 key = 0)
    {
        if (!key)
        {
            InvasionZone const* zone = FindZoneFor(object);
            key = zone ? zone->ZoneId : 0;
        }
        std::scoped_lock lock(_lock);
        _summons[key].insert(object->GetGUID());
    }

    std::set<ObjectGuid> Take(uint32 zoneId)
    {
        std::scoped_lock lock(_lock);
        std::set<ObjectGuid> out;
        auto itr = _summons.find(zoneId);
        if (itr != _summons.end())
        {
            out.swap(itr->second);
            _summons.erase(itr);
        }
        return out;
    }

private:
    std::mutex _lock;
    std::unordered_map<uint32, std::set<ObjectGuid>> _summons;
};

SummonRegistry& Registry()
{
    static SummonRegistry registry;
    return registry;
}

template<class T>
void DespawnNear(WorldObject* source, std::initializer_list<uint32> entries, float range, Seconds respawn)
{
    for (uint32 entry : entries)
    {
        std::list<T*> list;
        if constexpr (std::is_same_v<T, Creature>)
            source->GetCreatureListWithEntryInGrid(list, entry, range);
        else
            source->GetGameObjectListWithEntryInGrid(list, entry, range);
        for (T* object : list)
            object->DespawnOrUnsummon(0ms, respawn);
    }
}

uint32 CountAliveMinions(WorldObject* source, float range)
{
    uint32 count = 0;
    for (uint32 entry : { NPC_SKELETAL_SHOCKTROOPER, NPC_GHOUL_BERSERKER, NPC_SPECTRAL_SOLDIER, NPC_LUMBERING_HORROR, NPC_BONE_WITCH, NPC_SPIRIT_OF_THE_DAMNED })
    {
        std::list<Creature*> list;
        source->GetCreatureListWithEntryInGrid(list, entry, range);
        for (Creature* minion : list)
            if (minion->IsAlive())
                ++count;
    }
    return count;
}

bool HasRareNear(WorldObject* source)
{
    for (uint32 entry : { NPC_LUMBERING_HORROR, NPC_BONE_WITCH, NPC_SPIRIT_OF_THE_DAMNED })
        if (source->FindNearestCreature(entry, 100.0f, false))
            return true;
    return false;
}

bool IsGuardOrBoss(Unit const* unit)
{
    switch (unit->GetEntry())
    {
        case NPC_ROYAL_DREADGUARD:
        case NPC_STORMWIND_ROYAL_GUARD:
        case NPC_UNDERCITY_ELITE_GUARDIAN:
        case NPC_UNDERCITY_GUARDIAN:
        case NPC_DEATHGUARD_ELITE:
        case NPC_STORMWIND_CITY_GUARD:
        case NPC_HIGHLORD_BOLVAR_FORDRAGON:
        case NPC_LADY_SYLVANAS_WINDRUNNER:
        case NPC_VARIMATHRAS:
        case NPC_STORMWIND_ELITE_GUARD:
            return true;
        default:
            break;
    }
    Creature const* creature = unit->ToCreature();
    return creature && creature->IsGuard();
}

void PullGuard(Creature* scourge, Unit* who)
{
    Creature* guard = who->ToCreature();
    if (!guard || !guard->IsAlive() || guard->IsEngaged() || !guard->AI() || !IsGuardOrBoss(guard))
        return;
    if (!scourge->IsWithinDistInMap(guard, 25.0f) || !scourge->IsWithinLOSInMap(guard))
        return;
    if (!guard->IsValidAttackTarget(scourge))
        return;
    guard->AI()->AttackStart(scourge);
}
}

using namespace ScourgeInvasion;
using namespace Trinity::ChatCommands;

/*
 * Herald of the Lich King (Mouth of Kel'Thuzad): yells at the start and the end of a zone attack and now and then in between.
 */
struct classic_si_mouth : public ScriptedAI
{
    classic_si_mouth(Creature* creature) : ScriptedAI(creature) { }

    void InitializeAI() override
    {
        _yellTimer = urand(150 * IN_MILLISECONDS, HOUR * IN_MILLISECONDS);
    }

    void DoAction(int32 action) override
    {
        switch (action)
        {
            case ACTION_MOUTH_ZONE_START:
                ClassicScriptZoneYell(RAND(BCT_MOUTH_ZONE_ATTACK_START_1, BCT_MOUTH_ZONE_ATTACK_START_2), me);
                break;
            case ACTION_MOUTH_ZONE_STOP:
                ClassicScriptZoneYell(RAND(BCT_MOUTH_ZONE_ATTACK_ENDS_1, BCT_MOUTH_ZONE_ATTACK_ENDS_2, BCT_MOUTH_ZONE_ATTACK_ENDS_3), me);
                me->DespawnOrUnsummon(2s);
                break;
            default:
                break;
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (_yellTimer <= diff)
        {
            ClassicScriptZoneYell(RAND(BCT_MOUTH_RANDOM_1, BCT_MOUTH_RANDOM_2, BCT_MOUTH_RANDOM_3, BCT_MOUTH_RANDOM_4), me);
            _yellTimer = urand(150 * IN_MILLISECONDS, HOUR * IN_MILLISECONDS);
        }
        else
            _yellTimer -= diff;
    }

private:
    uint32 _yellTimer = 0;
};

/*
 * Necropolis, Necropolis Proxy, Necropolis Relay: invisible helpers of the floating necropolis. They keep their grids loaded
 * while the zone is attacked, so the death of a shard far away can still find its way to the necropolis.
 */
struct classic_si_necropolis : public ScriptedAI
{
    classic_si_necropolis(Creature* creature) : ScriptedAI(creature) { }

    void InitializeAI() override
    {
        me->SetReactState(REACT_PASSIVE);
        me->setActive(true);
        me->SetFarVisible(true);
    }

    void UpdateAI(uint32 /*diff*/) override { }
};

/*
 * Necropolis health: takes one zap from every damaged shard of its necropolis; on the third it dies, the necropolis falls and the
 * zone has one necropolis less to clear.
 */
struct classic_si_necropolis_health : public ScriptedAI
{
    classic_si_necropolis_health(Creature* creature) : ScriptedAI(creature) { }

    void InitializeAI() override
    {
        me->SetReactState(REACT_PASSIVE);
        me->setActive(true);
        me->SetFarVisible(true);
        _zapped = 0;
    }

    void DoAction(int32 action) override
    {
        if (action != ACTION_HEALTH_ZAP || !me->IsAlive())
            return;

        me->CastSpell(me, SPELL_ZAP_NECROPOLIS, true);
        if (++_zapped >= 3)
            me->KillSelf();
    }

    void JustDied(Unit* /*killer*/) override
    {
        if (Creature* necropolis = me->FindNearestCreature(NPC_NECROPOLIS, 30.0f))
        {
            me->CastSpell(necropolis, SPELL_DESPAWNER_OTHER, true);
            DespawnNear<GameObject>(necropolis, { GO_NECROPOLIS_TINY, GO_NECROPOLIS_SMALL, GO_NECROPOLIS_MEDIUM, GO_NECROPOLIS_BIG, GO_NECROPOLIS_HUGE }, 30.0f, Seconds(WEEK));
            necropolis->DespawnOrUnsummon(1s, Seconds(WEEK));
        }
        else
            DespawnNear<GameObject>(me, { GO_NECROPOLIS_TINY, GO_NECROPOLIS_SMALL, GO_NECROPOLIS_MEDIUM, GO_NECROPOLIS_BIG, GO_NECROPOLIS_HUGE }, 30.0f, Seconds(WEEK));

        if (InvasionZone const* zone = FindZoneFor(me))
        {
            int32 remaining = GetWs(zone->WsRemaining);
            if (remaining > 0)
                SetWs(zone->WsRemaining, remaining - 1);
            TC_LOG_INFO("scripts", "Scourge Invasion: a necropolis fell in {}, {} left", zone->Name, std::max(remaining - 1, 0));
        }

        me->DespawnOrUnsummon(2s, Seconds(WEEK));
    }

    void UpdateAI(uint32 /*diff*/) override { }

private:
    uint32 _zapped = 0;
};

/*
 * Necrotic Shard (16136) and Damaged Necrotic Shard (16172). Only the event hurts them: minion deaths hurt the shard, cultist and
 * Shadow of Doom deaths the damaged one. Both keep a camp of minions spawning at the finders around them.
 */
struct classic_si_necrotic_shard : public ScriptedAI
{
    classic_si_necrotic_shard(Creature* creature) : ScriptedAI(creature) { }

    void InitializeAI() override
    {
        me->SetReactState(REACT_PASSIVE);
        me->setActive(true);
        me->SetFarVisible(true);
        _events.Reset();

        if (me->GetEntry() == NPC_DAMAGED_NECROTIC_SHARD)
        {
            _events.ScheduleEvent(EVENT_BUTTRESS, 1s);
            _events.ScheduleEvent(EVENT_MINIONS, 3s);
        }
        else
        {
            _campType = urand(CAMP_GHOUL_SKELETON, CAMP_GHOST_SKELETON);
            _events.ScheduleEvent(EVENT_MINIONS, 5s);
        }
    }

    void JustAppeared() override
    {
        ScriptedAI::JustAppeared();
        if (me->GetEntry() == NPC_NECROTIC_SHARD)
            me->CastSpell(me, SPELL_CAMP_RECEIVES_COMMUNIQUE, true);
    }

    void SetData(uint32 type, uint32 value) override
    {
        if (type == SHARD_DATA_CAMP_TYPE && value >= CAMP_GHOUL_SKELETON && value <= CAMP_GHOST_SKELETON)
            _campType = value;
    }

    uint32 GetData(uint32 type) const override
    {
        return type == SHARD_DATA_CAMP_TYPE ? _campType : 0;
    }

    // the only way the shard loses health
    void Zap(uint32 damage)
    {
        if (!me->IsAlive() || !damage)
            return;

        damage = std::max<uint32>(1, uint32(float(damage) * ShardDamageRate.load()));
        if (damage >= me->GetHealth() && me->GetEntry() == NPC_DAMAGED_NECROTIC_SHARD)
            me->CastSpell(me, SPELL_SOUL_REVIVAL, true);

        _allowDamage = true;
        Unit::DealDamage(me, me, damage, nullptr, DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, nullptr, false);
        _allowDamage = false;
    }

    void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*damageType*/, SpellInfo const* /*spellInfo*/) override
    {
        if (!_allowDamage)
            damage = 0;
    }

    void HealReceived(Unit* /*healer*/, uint32& heal) override
    {
        heal = 0;
    }

    void JustDied(Unit* /*killer*/) override
    {
        if (me->GetEntry() == NPC_NECROTIC_SHARD)
        {
            if (Creature* damaged = me->SummonCreature(NPC_DAMAGED_NECROTIC_SHARD, me->GetPosition(), TEMPSUMMON_MANUAL_DESPAWN))
            {
                Registry().Add(damaged);
                if (damaged->AI())
                    damaged->AI()->SetData(SHARD_DATA_CAMP_TYPE, _campType);
            }
            me->DespawnOrUnsummon(1s);
            return;
        }

        // damaged shard: the death goes shard -> relay -> proxy -> necropolis health
        if (Creature* relay = me->FindNearestCreature(NPC_NECROPOLIS_RELAY, 200.0f))
        {
            me->CastSpell(relay, SPELL_COMMUNIQUE_CAMP_TO_RELAY_DEATH, true);
            if (Creature* proxy = relay->FindNearestCreature(NPC_NECROPOLIS_PROXY, 200.0f))
            {
                relay->CastSpell(proxy, SPELL_COMMUNIQUE_CAMP_TO_RELAY_DEATH, true);
                if (Creature* health = proxy->FindNearestCreature(NPC_NECROPOLIS_HEALTH, 200.0f))
                {
                    proxy->CastSpell(health, SPELL_COMMUNIQUE_CAMP_TO_RELAY_DEATH, true);
                    if (health->AI())
                        health->AI()->DoAction(ACTION_HEALTH_ZAP);
                }
                else
                    TC_LOG_ERROR("scripts", "Scourge Invasion: no necropolis health within 200 yd of proxy {}", proxy->GetSpawnId());
                proxy->DespawnOrUnsummon(2s, Seconds(WEEK));
            }
            else
                TC_LOG_ERROR("scripts", "Scourge Invasion: no necropolis proxy within 200 yd of relay {}", relay->GetSpawnId());
            relay->DespawnOrUnsummon(2s, Seconds(WEEK));
        }
        else
            TC_LOG_ERROR("scripts", "Scourge Invasion: no necropolis relay within 200 yd of the damaged shard at {}", me->GetPosition().ToString());

        DespawnNear<Creature>(me, { NPC_CULTIST_ENGINEER }, 15.0f, 0s);
        DespawnNear<GameObject>(me, { GO_SUMMON_CIRCLE, GO_UNDEAD_FIRE, GO_UNDEAD_FIRE_AURA, GO_SKULLPILE_01, GO_SKULLPILE_02, GO_SKULLPILE_03, GO_SKULLPILE_04, GO_SUMMONER_SHIELD }, 60.0f, Seconds(WEEK));
        DespawnNear<Creature>(me, { NPC_MINION_FINDER }, 60.0f, Seconds(WEEK));
        me->DespawnOrUnsummon(5s);
    }

    void UpdateAI(uint32 diff) override
    {
        _events.Update(diff);
        while (uint32 eventId = _events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_MINIONS:
                    SpawnMinions();
                    _events.Repeat(5s);
                    break;
                case EVENT_BUTTRESS:
                    // every hour: full health, idle Shadows of Doom go, 4 fresh cultists on the circle
                    me->SetFullHealth();
                    DespawnIdleShadows();
                    SummonCultists();
                    _events.Repeat(1h);
                    break;
                default:
                    break;
            }
        }
    }

private:
    enum
    {
        EVENT_MINIONS = 1,
        EVENT_BUTTRESS,
    };

    void SpawnMinions()
    {
        std::list<Creature*> finders;
        me->GetCreatureListWithEntryInGrid(finders, NPC_MINION_FINDER, 60.0f);
        if (finders.empty())
            return;

        // no more minions than the camp has finders (counted with the ones still waiting to come back)
        _maxFinders = std::max<uint32>(_maxFinders, uint32(finders.size()));
        if (CountAliveMinions(me, 60.0f) >= _maxFinders)
            return;

        finders.sort(Trinity::ObjectDistanceOrderPred(me));
        uint32 wanted = urand(1, 3);
        uint32 done = 0;
        for (Creature* finder : finders)
        {
            if (done >= wanted)
                break;
            if (!finder->IsAlive() || CountAliveMinions(finder, 5.0f))
                continue;

            uint32 entry = PickMinion(finder);
            if (TempSummon* minion = me->SummonCreature(entry, finder->GetPosition(), TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 1h))
            {
                minion->SetWanderDistance(1.0f);
                minion->CastSpell(minion, SPELL_MINION_SPAWN_IN, true);
                Registry().Add(minion);
            }

            // a finder comes back 150-200 s later (sniffed)
            finder->DespawnOrUnsummon(0ms, Seconds(urand(150, 200)));
            ++done;
        }
    }

    uint32 PickMinion(Creature* finder) const
    {
        // sniffed: 19669 minions and 90 rares, about 1 in 217, and never two rares near each other
        bool rare = urand(1, 217) == 1 && !HasRareNear(finder);
        switch (_campType)
        {
            case CAMP_GHOST_GHOUL:
                return rare ? RAND(NPC_SPIRIT_OF_THE_DAMNED, NPC_LUMBERING_HORROR) : RAND(NPC_SPECTRAL_SOLDIER, NPC_GHOUL_BERSERKER);
            case CAMP_GHOST_SKELETON:
                return rare ? RAND(NPC_SPIRIT_OF_THE_DAMNED, NPC_BONE_WITCH) : RAND(NPC_SPECTRAL_SOLDIER, NPC_SKELETAL_SHOCKTROOPER);
            case CAMP_GHOUL_SKELETON:
            default:
                return rare ? RAND(NPC_LUMBERING_HORROR, NPC_BONE_WITCH) : RAND(NPC_GHOUL_BERSERKER, NPC_SKELETAL_SHOCKTROOPER);
        }
    }

    void DespawnIdleShadows()
    {
        std::list<Creature*> shadows;
        me->GetCreatureListWithEntryInGrid(shadows, NPC_SHADOW_OF_DOOM, 200.0f);
        for (Creature* shadow : shadows)
            if (shadow->IsAlive() && !shadow->IsEngaged())
                shadow->DespawnOrUnsummon();
    }

    void SummonCultists()
    {
        DespawnNear<GameObject>(me, { GO_SUMMONER_SHIELD }, 30.0f, 0s);
        DespawnNear<Creature>(me, { NPC_CULTIST_ENGINEER }, 15.0f, 0s);

        GameObject* circle = me->FindNearestGameObject(GO_SUMMON_CIRCLE, 5.0f, false);
        Position const center = circle ? circle->GetPosition() : me->GetPosition();
        for (int i = 0; i < 4; ++i)
        {
            float angle = float(i) * float(M_PI / 2) + center.GetOrientation();
            float x = center.GetPositionX() + 6.95f * std::cos(angle);
            float y = center.GetPositionY() + 6.75f * std::sin(angle);
            float z = center.GetPositionZ() + 5.0f;
            me->UpdateGroundPositionZ(x, y, z);
            if (TempSummon* cultist = me->SummonCreature(NPC_CULTIST_ENGINEER, x, y, z, Position::NormalizeOrientation(angle - float(M_PI)), TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 1h))
                Registry().Add(cultist);
        }
    }

    EventMap _events;
    uint32 _campType = CAMP_NONE;
    uint32 _maxFinders = 0;
    bool _allowDamage = false;
};

/*
 * Cultist Engineer: channels on the damaged shard. Its death hurts the shard. With 8 Necrotic Runes a player can disrupt the
 * ritual: the cultist dies and a Shadow of Doom comes for that player.
 */
struct classic_si_cultist_engineer : public ScriptedAI
{
    classic_si_cultist_engineer(Creature* creature) : ScriptedAI(creature) { }

    void InitializeAI() override
    {
        me->SetReactState(REACT_PASSIVE);
        me->SetCorpseDelay(10, true);
        _channelTimer = 1 * IN_MILLISECONDS;
    }

    void JustAppeared() override
    {
        ScriptedAI::JustAppeared();
        me->CastSpell(me, SPELL_MINION_SPAWN_IN, true);
        if (GameObject* shield = me->SummonGameObject(GO_SUMMONER_SHIELD, me->GetPosition(), QuaternionData::fromEulerAnglesZYX(me->GetOrientation(), 0.0f, 0.0f), Seconds(HOUR)))
            _shield = shield->GetGUID();
    }

    void JustDied(Unit* /*killer*/) override
    {
        if (Creature* shard = me->FindNearestCreature(NPC_DAMAGED_NECROTIC_SHARD, 15.0f))
        {
            if (classic_si_necrotic_shard* ai = CAST_AI(classic_si_necrotic_shard, shard->AI()))
                ai->Zap(SpellDamage(SPELL_DAMAGE_CRYSTAL, 100));
            shard->RemoveAurasDueToSpell(SPELL_BUTTRESS_CHANNEL);
            shard->SetChannelSpellId(0);
        }
        if (GameObject* shield = me->GetMap()->GetGameObject(_shield))
            shield->Delete();
    }

    bool OnGossipHello(Player* player) override
    {
        ClearGossipMenuFor(player);
        if (player->HasItemCount(ITEM_NECROTIC_RUNE, RUNES_FOR_SHADOW))
            AddGossipItemFor(player, GossipOptionNpc::None, GossipText(player, BCT_CULTIST_ENGINEER_OPTION, "Use 8 necrotic runes and disrupt his ritual."), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        SendGossipMenuFor(player, TEXT_CULTIST_ENGINEER, me->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, uint32 /*menuId*/, uint32 gossipListId) override
    {
        uint32 const action = GetGossipActionFor(player, gossipListId);
        CloseGossipMenuFor(player);
        if (action != GOSSIP_ACTION_INFO_DEF + 1 || !me->IsAlive() || !player->HasItemCount(ITEM_NECROTIC_RUNE, RUNES_FOR_SHADOW))
            return true;

        player->DestroyItemCount(ITEM_NECROTIC_RUNE, RUNES_FOR_SHADOW, true);
        if (TempSummon* shadow = player->SummonCreature(NPC_SHADOW_OF_DOOM, me->GetPosition(), TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 1h))
        {
            Registry().Add(shadow);
            shadow->SetFacingToObject(player);
            if (shadow->AI())
                shadow->AI()->SetGUID(player->GetGUID(), SHADOW_DATA_SUMMONER);
        }
        me->KillSelf();
        return true;
    }

    void UpdateAI(uint32 diff) override
    {
        if (!_channelTimer)
            return;
        if (_channelTimer > diff)
        {
            _channelTimer -= diff;
            return;
        }
        _channelTimer = 0;

        if (Creature* shard = me->FindNearestCreature(NPC_DAMAGED_NECROTIC_SHARD, 15.0f))
        {
            me->SetChannelSpellId(SPELL_BUTTRESS_CHANNEL);
            me->SetChannelObject(0, shard->GetGUID());
            shard->SetChannelSpellId(SPELL_BUTTRESS_CHANNEL);
        }
    }

private:
    uint32 _channelTimer = 0;
    ObjectGuid _shield;
};

/*
 * Minions (camp minions, rares, Shadow of Doom, Flameshocker): their abilities, the Scourge Strike on NPCs, despawn when left
 * alone, and what their death does to the shard.
 */
struct classic_si_minion : public ScriptedAI
{
    classic_si_minion(Creature* creature) : ScriptedAI(creature) { }

    void InitializeAI() override
    {
        ScriptedAI::InitializeAI();
        switch (me->GetEntry())
        {
            case NPC_LUMBERING_HORROR:
            case NPC_BONE_WITCH:
            case NPC_SPIRIT_OF_THE_DAMNED:
                _despawnCheck = 10 * MINUTE * IN_MILLISECONDS;
                break;
            case NPC_SHADOW_OF_DOOM:
            case NPC_FLAMESHOCKER:
                _despawnCheck = 0; // Shadow of Doom: its 1 hour summon; flameshockers: ACTION_FLAMESHOCKER_DESPAWN_TIMER
                break;
            default:
                _despawnCheck = 150 * IN_MILLISECONDS;
                break;
        }
        _despawnTimer = _despawnCheck;
    }

    void JustAppeared() override
    {
        ScriptedAI::JustAppeared();
        if (me->GetEntry() == NPC_LUMBERING_HORROR)
            me->AddAura(SPELL_AURA_OF_FEAR, me);
    }

    void Reset() override
    {
        _events.Reset();
        _enraged = false;
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        switch (me->GetEntry())
        {
            case NPC_GHOUL_BERSERKER:
                _events.ScheduleEvent(EVENT_INFECTED_BITE, 5s, 13s);
                break;
            case NPC_SKELETAL_SHOCKTROOPER:
                _events.ScheduleEvent(EVENT_BONE_SHARDS, 5s, 16s);
                break;
            case NPC_SPECTRAL_SOLDIER:
                _events.ScheduleEvent(EVENT_DEMORALIZING_SHOUT, 3s, 10s);
                _events.ScheduleEvent(EVENT_SUNDER_ARMOR, 3s, 7s);
                break;
            case NPC_LUMBERING_HORROR:
                _events.ScheduleEvent(EVENT_KNOCKDOWN, 6s, 12s);
                _events.ScheduleEvent(EVENT_TRAMPLE, 8s, 14s);
                break;
            case NPC_SPIRIT_OF_THE_DAMNED:
                _events.ScheduleEvent(EVENT_RIBBON_OF_SOULS, 2s, 5s);
                _events.ScheduleEvent(EVENT_PSYCHIC_SCREAM, 10s, 20s);
                break;
            case NPC_BONE_WITCH:
                _events.ScheduleEvent(EVENT_ARCANE_BOLT, 3s, 8s);
                break;
            case NPC_SHADOW_OF_DOOM:
                _events.ScheduleEvent(EVENT_MINDFLAY, 2s);
                _events.ScheduleEvent(EVENT_FEAR, 2s);
                break;
            case NPC_FLAMESHOCKER:
                _events.ScheduleEvent(EVENT_FLAMESHOCKERS_TOUCH, 2s);
                break;
            default:
                break;
        }
        _events.ScheduleEvent(EVENT_SCOURGE_STRIKE, 1s);
    }

    // Shadow of Doom: who summoned it (8 runes)
    void SetGUID(ObjectGuid const& guid, int32 id) override
    {
        if (id != SHADOW_DATA_SUMMONER || me->GetEntry() != NPC_SHADOW_OF_DOOM)
            return;

        _summoner = guid;
        me->SetImmuneToPC(true);
        me->CastSpell(me, SPELL_SPAWN_SMOKE, true);
        if (Player* player = ObjectAccessor::GetPlayer(*me, guid))
            me->Say(RAND(BCT_SHADOW_OF_DOOM_TEXT_0, BCT_SHADOW_OF_DOOM_TEXT_1, BCT_SHADOW_OF_DOOM_TEXT_2, BCT_SHADOW_OF_DOOM_TEXT_3), player);
        _shadowAttackTimer = 5 * IN_MILLISECONDS;
    }

    void DoAction(int32 action) override
    {
        if (action == ACTION_FLAMESHOCKER_DESPAWN_TIMER)
            _despawnCheck = _despawnTimer = MINUTE * IN_MILLISECONDS;
    }

    void MoveInLineOfSight(Unit* who) override
    {
        if (me->GetEntry() == NPC_FLAMESHOCKER)
            PullGuard(me, who);
        ScriptedAI::MoveInLineOfSight(who);
    }

    void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*damageType*/, SpellInfo const* /*spellInfo*/) override
    {
        if (me->GetEntry() == NPC_GHOUL_BERSERKER && !_enraged && me->HealthBelowPctDamaged(30, damage))
        {
            _enraged = true;
            DoCastSelf(SPELL_ENRAGE, true);
        }
    }

    void JustDied(Unit* /*killer*/) override
    {
        switch (me->GetEntry())
        {
            case NPC_SHADOW_OF_DOOM:
                if (Creature* shard = me->FindNearestCreature(NPC_DAMAGED_NECROTIC_SHARD, 100.0f))
                {
                    me->CastSpell(shard, SPELL_ZAP_CRYSTAL_CORPSE, true);
                    if (classic_si_necrotic_shard* ai = CAST_AI(classic_si_necrotic_shard, shard->AI()))
                        ai->Zap(shard->GetMaxHealth() / 4);
                }
                break;
            case NPC_FLAMESHOCKER:
                DoCastSelf(SPELL_FLAMESHOCKERS_REVENGE, true);
                break;
            default:
                // camp minions and rares: zap the shard of their camp
                if (Creature* shard = me->FindNearestCreature(NPC_NECROTIC_SHARD, 100.0f))
                {
                    me->CastSpell(shard, SPELL_ZAP_CRYSTAL, true);
                    if (classic_si_necrotic_shard* ai = CAST_AI(classic_si_necrotic_shard, shard->AI()))
                        ai->Zap(SpellDamage(SPELL_ZAP_CRYSTAL, 15));
                }
                break;
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (_shadowAttackTimer)
        {
            if (_shadowAttackTimer <= diff)
            {
                _shadowAttackTimer = 0;
                me->SetImmuneToPC(false);
                if (Player* player = ObjectAccessor::GetPlayer(*me, _summoner))
                    if (player->IsAlive() && me->IsWithinLOSInMap(player) && me->IsValidAttackTarget(player))
                        AttackStart(player);
            }
            else
                _shadowAttackTimer -= diff;
        }

        if (_despawnCheck && !me->IsEngaged())
        {
            if (_despawnTimer <= diff)
            {
                me->CastSpell(me, SPELL_SPIRIT_SPAWN_OUT, true);
                me->DespawnOrUnsummon(3s);
                _despawnCheck = 0;
            }
            else
                _despawnTimer -= diff;
        }
        else if (_despawnCheck)
            _despawnTimer = _despawnCheck;

        if (!UpdateVictim())
            return;

        _events.Update(diff);
        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        while (uint32 eventId = _events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_INFECTED_BITE:
                    DoCastVictim(SPELL_INFECTED_BITE);
                    _events.Repeat(13s, 20s);
                    break;
                case EVENT_BONE_SHARDS:
                    DoCastVictim(SPELL_BONE_SHARDS);
                    _events.Repeat(16s, 25s);
                    break;
                case EVENT_DEMORALIZING_SHOUT:
                    DoCastSelf(SPELL_DEMORALIZING_SHOUT);
                    _events.Repeat(20s, 30s);
                    break;
                case EVENT_SUNDER_ARMOR:
                    DoCastVictim(SPELL_SUNDER_ARMOR);
                    _events.Repeat(6500ms, 12s);
                    break;
                case EVENT_KNOCKDOWN:
                    DoCastVictim(SPELL_KNOCKDOWN);
                    _events.Repeat(10s, 16s);
                    break;
                case EVENT_TRAMPLE:
                    DoCastSelf(SPELL_TRAMPLE);
                    _events.Repeat(12s, 18s);
                    break;
                case EVENT_RIBBON_OF_SOULS:
                    DoCastVictim(SPELL_RIBBON_OF_SOULS);
                    _events.Repeat(3s, 6s);
                    break;
                case EVENT_PSYCHIC_SCREAM:
                    DoCastSelf(SPELL_PSYCHIC_SCREAM);
                    _events.Repeat(20s, 30s);
                    break;
                case EVENT_ARCANE_BOLT:
                    DoCastVictim(SPELL_ARCANE_BOLT);
                    _events.Repeat(12s, 20s);
                    break;
                case EVENT_MINDFLAY:
                    DoCastVictim(SPELL_MINDFLAY);
                    _events.Repeat(6500ms, 13s);
                    break;
                case EVENT_FEAR:
                    DoCastVictim(SPELL_FEAR);
                    _events.Repeat(14500ms);
                    break;
                case EVENT_FLAMESHOCKERS_TOUCH:
                    DoCastVictim(RAND(SPELL_FLAMESHOCKERS_TOUCH, SPELL_FLAMESHOCKERS_TOUCH2), true);
                    _events.Repeat(30s, 45s);
                    break;
                case EVENT_SCOURGE_STRIKE:
                    // the Scourge kill NPCs (guards, Argent Dawn) outright, never players or their pets
                    if (me->GetEntry() != NPC_FLAMESHOCKER)
                        if (Unit* victim = me->GetVictim())
                            if (!victim->IsCharmedOwnedByPlayerOrPlayer() && me->IsWithinDistInMap(victim, 30.0f))
                                DoCast(victim, SPELL_SCOURGE_STRIKE, true);
                    _events.Repeat(2s);
                    break;
                default:
                    break;
            }
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;
        }
    }

private:
    enum
    {
        EVENT_INFECTED_BITE = 1,
        EVENT_BONE_SHARDS,
        EVENT_DEMORALIZING_SHOUT,
        EVENT_SUNDER_ARMOR,
        EVENT_KNOCKDOWN,
        EVENT_TRAMPLE,
        EVENT_RIBBON_OF_SOULS,
        EVENT_PSYCHIC_SCREAM,
        EVENT_ARCANE_BOLT,
        EVENT_MINDFLAY,
        EVENT_FEAR,
        EVENT_FLAMESHOCKERS_TOUCH,
        EVENT_SCOURGE_STRIKE,
    };

    EventMap _events;
    ObjectGuid _summoner;
    uint32 _shadowAttackTimer = 0;
    uint32 _despawnCheck = 0;
    uint32 _despawnTimer = 0;
    bool _enraged = false;
};

/*
 * Summoning circle: raises the camp's Necrotic Shard when the zone attack spawns it.
 */
struct classic_si_go_circle : public GameObjectAI
{
    classic_si_go_circle(GameObject* go) : GameObjectAI(go) { }

    void UpdateAI(uint32 /*diff*/) override
    {
        if (_done)
            return;
        _done = true;

        if (me->FindNearestCreature(NPC_NECROTIC_SHARD, 5.0f) || me->FindNearestCreature(NPC_DAMAGED_NECROTIC_SHARD, 5.0f))
            return;

        if (TempSummon* shard = me->SummonCreature(NPC_NECROTIC_SHARD, me->GetPosition(), TEMPSUMMON_MANUAL_DESPAWN))
            Registry().Add(shard);
    }

private:
    bool _done = false;
};

/*
 * Necropolis objects: seen from far away and keep their grid loaded.
 */
struct classic_si_go_necropolis : public GameObjectAI
{
    classic_si_go_necropolis(GameObject* go) : GameObjectAI(go) { }

    void InitializeAI() override
    {
        me->setActive(true);
        me->SetFarVisible(true);
    }
};

/*
 * Argent Emissary: what is happening, which zones are under attack, how many battles are won.
 */
struct classic_si_argent_emissary : public ScriptedAI
{
    classic_si_argent_emissary(Creature* creature) : ScriptedAI(creature) { }

    void SendMainMenu(Player* player)
    {
        AddGossipItemFor(player, GossipOptionNpc::None, GossipText(player, BCT_ARGENT_EMISSARY_OPTION_0, "What's happening?"), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        AddGossipItemFor(player, GossipOptionNpc::None, GossipText(player, BCT_ARGENT_EMISSARY_OPTION_1, "What can I do?"), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
        AddGossipItemFor(player, GossipOptionNpc::None, GossipText(player, BCT_ARGENT_EMISSARY_OPTION_2, "Where are we battling the Scourge?"), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
        AddGossipItemFor(player, GossipOptionNpc::None, GossipText(player, BCT_ARGENT_EMISSARY_OPTION_3, "How many battles have we won?"), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4);
        SendGossipMenuFor(player, TEXT_ARGENT_EMISSARY, me->GetGUID());
    }

    void AddBack(Player* player, uint32 action)
    {
        AddGossipItemFor(player, GossipOptionNpc::None, GossipText(player, BCT_ARGENT_EMISSARY_OPTION_BACK, "I have another question."), GOSSIP_SENDER_MAIN, action);
    }

    void SendZoneAnswer(Player* player, uint32 zoneId, uint32 underAttackText)
    {
        AddBack(player, GOSSIP_ACTION_INFO_DEF + 3);
        InvasionZone const* zone = FindZone(zoneId);
        bool attacked = zone && GetWs(zone->WsRemaining) > 0;
        SendGossipMenuFor(player, attacked ? underAttackText : uint32(TEXT_ARGENT_EMISSARY_FREE_OF_SCOURGE), me->GetGUID());
    }

    bool OnGossipHello(Player* player) override
    {
        // the texts read $2219W: the battles-won world state
        player->SendUpdateWorldState(WS_SI_BATTLES_WON, GetWs(WS_SI_BATTLES_WON));
        for (InvasionZone const& zone : Zones)
            player->SendUpdateWorldState(zone.WsRemaining, GetWs(zone.WsRemaining));

        ClearGossipMenuFor(player);
        SendMainMenu(player);
        return true;
    }

    bool OnGossipSelect(Player* player, uint32 /*menuId*/, uint32 gossipListId) override
    {
        uint32 const action = GetGossipActionFor(player, gossipListId);
        ClearGossipMenuFor(player);

        switch (action)
        {
            case GOSSIP_ACTION_INFO_DEF + 1:
                AddBack(player, GOSSIP_ACTION_INFO_DEF + 5);
                SendGossipMenuFor(player, TEXT_ARGENT_EMISSARY_ANSWER_0, me->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF + 2:
                AddBack(player, GOSSIP_ACTION_INFO_DEF + 5);
                SendGossipMenuFor(player, TEXT_ARGENT_EMISSARY_ANSWER_1, me->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF + 3:
                AddGossipItemFor(player, GossipOptionNpc::None, GossipText(player, BCT_ARGENT_EMISSARY_OPTION_2_SUB_4, "Is Azshara currently under attack?"), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 10);
                AddGossipItemFor(player, GossipOptionNpc::None, GossipText(player, BCT_ARGENT_EMISSARY_OPTION_2_SUB_2, "Are the Blasted Lands currently under attack?"), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 8);
                AddGossipItemFor(player, GossipOptionNpc::None, GossipText(player, BCT_ARGENT_EMISSARY_OPTION_2_SUB_3, "Are the Burning Steppes currently under attack?"), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 9);
                AddGossipItemFor(player, GossipOptionNpc::None, GossipText(player, BCT_ARGENT_EMISSARY_OPTION_2_SUB_1, "Is Tanaris currently under attack?"), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 7);
                AddGossipItemFor(player, GossipOptionNpc::None, GossipText(player, BCT_ARGENT_EMISSARY_OPTION_2_SUB_5, "Are the Eastern Plaguelands currently under attack?"), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 11);
                AddGossipItemFor(player, GossipOptionNpc::None, GossipText(player, BCT_ARGENT_EMISSARY_OPTION_2_SUB_0, "Is Winterspring currently under attack?"), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 6);
                AddBack(player, GOSSIP_ACTION_INFO_DEF + 5);
                SendGossipMenuFor(player, TEXT_ARGENT_EMISSARY_ANSWER_2, me->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF + 4:
                AddBack(player, GOSSIP_ACTION_INFO_DEF + 5);
                SendGossipMenuFor(player, RAND(TEXT_ARGENT_EMISSARY_WINS_0, TEXT_ARGENT_EMISSARY_WINS_1, TEXT_ARGENT_EMISSARY_WINS_2), me->GetGUID());
                break;
            case GOSSIP_ACTION_INFO_DEF + 5:
                SendMainMenu(player);
                break;
            case GOSSIP_ACTION_INFO_DEF + 6:
                SendZoneAnswer(player, ZONEID_WINTERSPRING, TEXT_ARGENT_EMISSARY_WINTERSPRING);
                break;
            case GOSSIP_ACTION_INFO_DEF + 7:
                SendZoneAnswer(player, ZONEID_TANARIS, TEXT_ARGENT_EMISSARY_TANARIS);
                break;
            case GOSSIP_ACTION_INFO_DEF + 8:
                SendZoneAnswer(player, ZONEID_BLASTED_LANDS, TEXT_ARGENT_EMISSARY_BLASTED_LANDS);
                break;
            case GOSSIP_ACTION_INFO_DEF + 9:
                SendZoneAnswer(player, ZONEID_BURNING_STEPPES, TEXT_ARGENT_EMISSARY_BURNING_STEPPES);
                break;
            case GOSSIP_ACTION_INFO_DEF + 10:
                SendZoneAnswer(player, ZONEID_AZSHARA, TEXT_ARGENT_EMISSARY_AZSHARA);
                break;
            case GOSSIP_ACTION_INFO_DEF + 11:
                SendZoneAnswer(player, ZONEID_EASTERN_PLAGUELANDS, TEXT_ARGENT_EMISSARY_PLAGUELANDS);
                break;
            default:
                CloseGossipMenuFor(player);
                break;
        }
        return true;
    }
};

/*
 * Pallid Horror / Patchwork Terror: the city attack. Brings 5-9 Flameshockers, calls more next to the guards, makes the guards
 * come for it, and walks to the throne. Its death leaves a crystal for the city's quest and starts the city's next timer.
 */
struct classic_si_pallid_horror : public ScriptedAI
{
    classic_si_pallid_horror(Creature* creature) : ScriptedAI(creature) { }

    void InitializeAI() override
    {
        ScriptedAI::InitializeAI();
        me->setActive(true);
        me->SetCorpseDelay(10, true);

        _target = FindThrone();
        _events.Reset();
        _events.ScheduleEvent(EVENT_RANDOM_YELL, 5s);
        _events.ScheduleEvent(EVENT_DAMAGE_VS_GUARDS, 5s);
        _events.ScheduleEvent(EVENT_SUMMON_FLAMESHOCKER, 5s);
        _events.ScheduleEvent(EVENT_MARCH, 2s);
    }

    void JustAppeared() override
    {
        ScriptedAI::JustAppeared();
        if (_escortDone)
            return;
        _escortDone = true;
        me->AddAura(SPELL_AURA_OF_FEAR, me);

        // sniffed groups of 5-9 shockers around it
        uint32 amount = urand(5, 9);
        for (uint32 i = 0; i < amount; ++i)
        {
            if (TempSummon* shocker = me->SummonCreature(NPC_FLAMESHOCKER, me->GetPosition(), TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 1h))
            {
                float angle = float(i) * float(2 * M_PI) / float(amount);
                shocker->GetMotionMaster()->MoveFollow(me, 5.0f, ChaseAngle(angle, 0.2f));
                shocker->CastSpell(shocker, SPELL_MINION_SPAWN_IN, true);
                _flameshockers.insert(shocker->GetGUID());
                Registry().Add(shocker, CityKey());
            }
        }
    }

    void Reset() override
    {
        if (me->IsInWorld() && !me->HasAura(SPELL_AURA_OF_FEAR))
            me->AddAura(SPELL_AURA_OF_FEAR, me);
    }

    void EnterEvadeMode(EvadeReason why) override
    {
        // no way home: back to the march
        if (!_EnterEvadeMode(why))
            return;
        Reset();
        _events.RescheduleEvent(EVENT_MARCH, 1s);
    }

    void MoveInLineOfSight(Unit* who) override
    {
        PullGuard(me, who);
        ScriptedAI::MoveInLineOfSight(who);
    }

    void SummonedCreatureDies(Creature* summon, Unit* /*killer*/) override
    {
        _flameshockers.erase(summon->GetGUID());
    }

    void SummonedCreatureDespawn(Creature* summon) override
    {
        _flameshockers.erase(summon->GetGUID());
    }

    void JustDied(Unit* /*killer*/) override
    {
        if (Creature* bolvar = me->FindNearestCreature(NPC_HIGHLORD_BOLVAR_FORDRAGON, 250.0f))
            ClassicScriptZoneYell(BCT_STORMWIND_BOLVAR_2, bolvar, me);
        if (Creature* sylvanas = me->FindNearestCreature(NPC_LADY_SYLVANAS_WINDRUNNER, 250.0f))
            ClassicScriptZoneYell(BCT_UNDERCITY_SYLVANAS_1, sylvanas, me);

        std::set<ObjectGuid> shockers = _flameshockers;
        for (ObjectGuid const& guid : shockers)
            if (Creature* shocker = me->GetMap()->GetCreature(guid))
                if (shocker->IsAlive())
                    shocker->KillSelf();

        bool undercity = me->GetZoneId() == ZONEID_UNDERCITY;
        if (TempSummon* crystal = me->SummonCreature(undercity ? NPC_FAINT_NECROTIC_CRYSTAL : NPC_CRACKED_NECROTIC_CRYSTAL, me->GetPosition(), TEMPSUMMON_TIMED_DESPAWN, 15min))
            crystal->setActive(true);
        me->RemoveAurasDueToSpell(SPELL_AURA_OF_FEAR);

        uint32 delay = urand(CITY_ATTACK_TIMER_MIN, CITY_ATTACK_TIMER_MAX);
        uint32 zoneId = undercity ? ZONEID_UNDERCITY : ZONEID_STORMWIND;
        SetWs(WS_SCRIPT_CITY_TIME_BASE + zoneId, int32(GameTime::GetGameTime() + delay));
        TC_LOG_INFO("scripts", "Scourge Invasion: the Scourge is beaten in {}, next attack in {} minutes", undercity ? "Undercity" : "Stormwind", delay / MINUTE);
    }

    void UpdateAI(uint32 diff) override
    {
        _events.Update(diff);
        while (uint32 eventId = _events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_RANDOM_YELL:
                    ClassicScriptZoneYell(RAND(BCT_PALLID_HORROR_YELL1, BCT_PALLID_HORROR_YELL2, BCT_PALLID_HORROR_YELL3, BCT_PALLID_HORROR_YELL4,
                        BCT_PALLID_HORROR_YELL5, BCT_PALLID_HORROR_YELL6, BCT_PALLID_HORROR_YELL7, BCT_PALLID_HORROR_YELL8), me);
                    _events.Repeat(65s, 300s);
                    break;
                case EVENT_DAMAGE_VS_GUARDS:
                    if (Unit* victim = me->GetVictim())
                        if (!victim->IsCharmedOwnedByPlayerOrPlayer())
                            DoCast(victim, SPELL_DAMAGE_VS_GUARDS, true);
                    _events.Repeat(11s, 81s);
                    break;
                case EVENT_SUMMON_FLAMESHOCKER:
                    SummonFlameshockerAtGuard();
                    _events.Repeat(2s);
                    break;
                case EVENT_MARCH:
                    if (!me->IsEngaged() && me->GetExactDist2d(_target) > 15.0f)
                        me->GetMotionMaster()->MovePoint(1, _target, true);
                    _events.Repeat(10s);
                    break;
                default:
                    break;
            }
        }

        UpdateVictim();
    }

private:
    enum
    {
        EVENT_RANDOM_YELL = 1,
        EVENT_DAMAGE_VS_GUARDS,
        EVENT_SUMMON_FLAMESHOCKER,
        EVENT_MARCH,
    };

    uint32 CityKey() const
    {
        return me->GetExactDist2d(Cities[0].Spawns.front()) < me->GetExactDist2d(Cities[1].Spawns.front()) ? Cities[0].ZoneId : Cities[1].ZoneId;
    }

    Position FindThrone() const
    {
        for (CityAttack const& city : Cities)
        {
            if (me->GetExactDist2d(city.Spawns.front()) > 600.0f)
                continue;
            for (auto const& [spawnId, data] : sObjectMgr->GetAllCreatureData())
                if (data.id == city.LeaderEntry && data.mapId == me->GetMapId())
                    return data.spawnPoint;
            return city.LeaderFallback;
        }
        return me->GetPosition();
    }

    void SummonFlameshockerAtGuard()
    {
        if (_flameshockers.size() >= 30)
            return;

        // a random guard of this zone in range with no flameshocker next to it
        std::list<Creature*> candidates;
        for (uint32 entry : { NPC_ROYAL_DREADGUARD, NPC_STORMWIND_ROYAL_GUARD, NPC_UNDERCITY_ELITE_GUARDIAN, NPC_UNDERCITY_GUARDIAN,
            NPC_DEATHGUARD_ELITE, NPC_STORMWIND_CITY_GUARD, NPC_STORMWIND_ELITE_GUARD })
            me->GetCreatureListWithEntryInGrid(candidates, entry, 150.0f);
        candidates.remove_if([this](Creature* guard)
        {
            return !guard->IsAlive() || guard->GetZoneId() != me->GetZoneId() || !me->IsValidAttackTarget(guard)
                || guard->FindNearestCreature(NPC_FLAMESHOCKER, 10.0f) != nullptr;
        });
        if (candidates.empty())
            return;

        Creature* guard = Trinity::Containers::SelectRandomContainerElement(candidates);
        Position pos = guard->GetNearPosition(5.0f, frand(0.0f, float(2 * M_PI)));
        if (TempSummon* shocker = me->SummonCreature(NPC_FLAMESHOCKER, pos, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 1h))
        {
            _flameshockers.insert(shocker->GetGUID());
            Registry().Add(shocker, CityKey());
            shocker->CastSpell(shocker, SPELL_MINION_SPAWN_IN, true);
            if (shocker->AI())
            {
                shocker->AI()->DoAction(ACTION_FLAMESHOCKER_DESPAWN_TIMER);
                shocker->AI()->AttackStart(guard);
            }
        }
    }

    EventMap _events;
    std::set<ObjectGuid> _flameshockers;
    Position _target;
    bool _escortDone = false;
};

/*
 * The controller: VMaNGOS ScourgeInvasionEvent (HardcodedEvents.cpp).
 */
class classic_world_event_scourge_invasion : public WorldScript
{
public:
    classic_world_event_scourge_invasion() : WorldScript("classic_world_event_scourge_invasion") { Instance = this; }

    static classic_world_event_scourge_invasion* Instance;

    // .reload config; at the start the config is read before the scripts load, so OnStartup reads it too
    void OnConfigLoad(bool /*reload*/) override
    {
        ReadConfig();
    }

    void OnStartup() override
    {
        ReadConfig();
        _timer = 15 * IN_MILLISECONDS; // first look 5 s after the start
    }

    void ReadConfig()
    {
        _configEnabled = sConfigMgr->GetBoolDefault("Classic.ScourgeInvasion", false);
        ShardDamageRate = std::max(0.01f, sConfigMgr->GetFloatDefault("Classic.ScourgeInvasion.ShardDamageRate", 1.0f));
    }

    void OnBeforeMapsUpdate(uint32 diff) override
    {
        _timer += diff;
        if (_timer < UPDATE_INTERVAL && !_forceTick)
            return;
        _timer = 0;
        _forceTick = false;
        Tick();
    }

    // .scourge commands: the controller does the work on its next tick (maps idle)
    struct Requests
    {
        std::vector<uint32> startZones;
        std::vector<uint32> winZones;
        std::vector<uint32> startCities;
        int32 setWins = -1;
    };

    void Request(std::function<void(Requests&)> const& fill)
    {
        std::scoped_lock lock(_requestLock);
        fill(_requests);
        _forceTick = true;
    }

    bool IsEnabled() const
    {
        switch (GetWs(WS_SCRIPT_GM_SWITCH))
        {
            case 1: return true;
            case 2: return false;
            default: return _configEnabled;
        }
    }

    bool IsConfigEnabled() const { return _configEnabled; }
    bool IsRunning() const { return _running; }
    void ForceTick() { _forceTick = true; }

    bool IsZoneActive(InvasionZone const& zone) const
    {
        return sGameEventMgr->IsActiveEvent(zone.EventId);
    }

    bool IsCityUnderAttack(CityAttack const& city) const
    {
        auto itr = _pallids.find(city.ZoneId);
        if (itr == _pallids.end() || itr->second.IsEmpty())
            return false;
        Map* map = sMapMgr->FindMap(city.MapId, 0);
        Creature* pallid = map ? map->GetCreature(itr->second) : nullptr;
        return pallid && pallid->IsAlive();
    }

private:
    static constexpr uint32 UPDATE_INTERVAL = 20 * IN_MILLISECONDS;

    void Tick()
    {
        Requests requests;
        {
            std::scoped_lock lock(_requestLock);
            std::swap(requests, _requests);
        }

        if (requests.setWins >= 0)
            SetWs(WS_SI_BATTLES_WON, requests.setWins);

        if (!IsEnabled())
        {
            if (_running)
                Disable();
            return;
        }

        time_t const now = GameTime::GetGameTime();
        int32 const wins = GetWs(WS_SI_BATTLES_WON);

        // 150 battles won: the invasion is over, only the "invasions done" events stay
        if (wins >= 150)
        {
            _running = true;
            if (!_finished)
            {
                TC_LOG_INFO("scripts", "Scourge Invasion: 150 battles won, the invasion is over");
                StopAllAttacks();
                StopEventIfActive(GAME_EVENT_SCOURGE_INVASION);
                StopEventIfActive(GAME_EVENT_BOSS_IN_INSTANCE);
                _finished = true;
            }
            HandleMilestones(wins);
            UpdateInvadedStates();
            return;
        }
        _finished = false;

        if (!_running)
            Enable();

        StartEventIfInactive(GAME_EVENT_SCOURGE_INVASION);
        StartEventIfInactive(GAME_EVENT_BOSS_IN_INSTANCE);

        for (uint32 zoneId : requests.winZones)
            if (InvasionZone const* zone = FindZone(zoneId))
                if (IsZoneActive(*zone))
                    SetWs(zone->WsRemaining, 0);

        for (uint32 zoneId : requests.startZones)
            if (InvasionZone const* zone = FindZone(zoneId))
                if (!IsZoneActive(*zone))
                    StartZone(*zone, false);

        for (CityAttack const& city : Cities)
        {
            bool forced = std::find(requests.startCities.begin(), requests.startCities.end(), city.ZoneId) != requests.startCities.end();
            if (IsCityUnderAttack(city))
                continue;
            if (forced || GetWs(WS_SCRIPT_CITY_TIME_BASE + city.ZoneId) < now)
                StartCityAttack(city);
        }

        for (InvasionZone const& zone : Zones)
            HandleZone(zone, now);

        HandleMilestones(GetWs(WS_SI_BATTLES_WON));
        UpdateInvadedStates();
    }

    void HandleZone(InvasionZone const& zone, time_t now)
    {
        int32 const attackTimeWs = WS_SCRIPT_ATTACK_TIME_BASE + zone.ZoneId;
        time_t const attackTime = GetWs(attackTimeWs);
        uint32 const nextDelay = urand(ZONE_ATTACK_TIMER_MIN, ZONE_ATTACK_TIMER_MAX);

        if (!IsZoneActive(zone))
        {
            // two zones under attack already: this one waits a full timer once its own has run out
            if (attackTime < now && ActiveZoneCount() > 1)
                SetWs(attackTimeWs, int32(now + nextDelay));

            if (now < time_t(GetWs(attackTimeWs)))
                return;
            if (int32(zone.ZoneId) == GetWs(WS_SCRIPT_LAST_ATTACK_ZONE))
                return;
            if (ActiveZoneCount() > 1 && GetWs(WS_SI_BATTLES_WON) > 0)
                return;

            StartZone(zone, false);
            return;
        }

        // won: no necropolis left
        if (attackTime < now && GetWs(zone.WsRemaining) <= 0)
        {
            SetWs(attackTimeWs, int32(now + nextDelay));
            SetWs(WS_SI_BATTLES_WON, GetWs(WS_SI_BATTLES_WON) + 1);
            SetWs(WS_SCRIPT_LAST_ATTACK_ZONE, int32(zone.ZoneId));
            TC_LOG_INFO("scripts", "Scourge Invasion: {} is defended ({} battles won), next attack there in {} minutes", zone.Name, GetWs(WS_SI_BATTLES_WON), nextDelay / MINUTE);
            StopZone(zone);
        }
    }

    uint32 ActiveZoneCount() const
    {
        uint32 count = 0;
        for (InvasionZone const& zone : Zones)
            if (IsZoneActive(zone))
                ++count;
        return count;
    }

    void StartZone(InvasionZone const& zone, bool resume)
    {
        Map* map = sMapMgr->PrewarmContinentMap(zone.MapId);
        if (!map)
        {
            TC_LOG_ERROR("scripts", "Scourge Invasion: no map {} for {}, trying again next update", zone.MapId, zone.Name);
            return;
        }

        if (!resume)
        {
            SetWs(zone.WsRemaining, int32(zone.NecropolisCount));
            // the win check waits for this time: a GM start (.scourge zone) can come before the zone's timer ran out
            SetWs(WS_SCRIPT_ATTACK_TIME_BASE + zone.ZoneId, int32(GameTime::GetGameTime()));
        }

        StartEventIfInactive(zone.EventId);

        // the Herald of the Lich King, kept in the world (and its grid loaded) while the zone is attacked
        DespawnMouth(zone, false);
        map->LoadGrid(zone.MouthPos.GetPositionX(), zone.MouthPos.GetPositionY());
        if (TempSummon* mouth = map->SummonCreature(NPC_MOUTH_OF_KELTHUZAD, zone.MouthPos))
        {
            mouth->setActive(true);
            mouth->SetFarVisible(true);
            _mouths[zone.ZoneId] = mouth->GetGUID();
            if (mouth->AI())
                mouth->AI()->DoAction(resume ? ACTION_MOUTH_ZONE_RESUME : ACTION_MOUTH_ZONE_START);
        }
        else
            TC_LOG_ERROR("scripts", "Scourge Invasion: could not summon the Herald of the Lich King in {}", zone.Name);

        map->SetZoneWeather(zone.ZoneId, WEATHER_STATE_THUNDERS, 0.25f);
        TC_LOG_INFO("scripts", "Scourge Invasion: {} {}, {} necropolises", resume ? "resuming the attack on" : "attacking", zone.Name, GetWs(zone.WsRemaining));
    }

    void StopZone(InvasionZone const& zone)
    {
        DespawnMouth(zone, true);
        StopEventIfActive(zone.EventId);
        SetWs(zone.WsRemaining, 0);
        ClearSummons(zone.ZoneId, zone.MapId);
        if (Map* map = sMapMgr->FindMap(zone.MapId, 0))
            map->SetZoneWeather(zone.ZoneId, WEATHER_STATE_FINE, 0.0f);
    }

    void DespawnMouth(InvasionZone const& zone, bool yell)
    {
        auto itr = _mouths.find(zone.ZoneId);
        if (itr == _mouths.end())
            return;
        if (Map* map = sMapMgr->FindMap(zone.MapId, 0))
        {
            if (Creature* mouth = map->GetCreature(itr->second))
            {
                if (yell && mouth->AI())
                    mouth->AI()->DoAction(ACTION_MOUTH_ZONE_STOP);
                else
                    mouth->DespawnOrUnsummon();
            }
        }
        _mouths.erase(itr);
    }

    void ClearSummons(uint32 zoneId, uint32 mapId)
    {
        std::set<ObjectGuid> summons = Registry().Take(zoneId);
        Map* map = sMapMgr->FindMap(mapId, 0);
        if (!map)
            return;
        for (ObjectGuid const& guid : summons)
            if (Creature* creature = map->GetCreature(guid))
                creature->DespawnOrUnsummon();
    }

    void StartCityAttack(CityAttack const& city)
    {
        Map* map = sMapMgr->PrewarmContinentMap(city.MapId);
        if (!map)
            return;

        Position const& pos = Trinity::Containers::SelectRandomContainerElement(city.Spawns);
        map->LoadGrid(pos.GetPositionX(), pos.GetPositionY());
        if (TempSummon* pallid = map->SummonCreature(RAND(NPC_PALLID_HORROR, NPC_PATCHWORK_TERROR), pos))
        {
            pallid->setActive(true);
            _pallids[city.ZoneId] = pallid->GetGUID();
            Registry().Add(pallid, city.ZoneId);
            // a timer in case it is never killed (the next one waits for this one)
            SetWs(WS_SCRIPT_CITY_TIME_BASE + city.ZoneId, int32(GameTime::GetGameTime() + CITY_ATTACK_TIMER_MAX));
            TC_LOG_INFO("scripts", "Scourge Invasion: {} attacks {}", pallid->GetName(), city.Name);
        }
        else
            TC_LOG_ERROR("scripts", "Scourge Invasion: could not summon the city attacker in {}", city.Name);
    }

    void StopCityAttacks()
    {
        // the attacker and every flameshocker it brought or called are in the registry under the city
        for (CityAttack const& city : Cities)
            ClearSummons(city.ZoneId, city.MapId);
        _pallids.clear();
    }

    void StopAllAttacks()
    {
        time_t const now = GameTime::GetGameTime();
        for (InvasionZone const& zone : Zones)
        {
            DespawnMouth(zone, false);
            StopEventIfActive(zone.EventId);
            SetWs(zone.WsRemaining, 0);
            SetWs(WS_SCRIPT_ATTACK_TIME_BASE + zone.ZoneId, int32(now));
            ClearSummons(zone.ZoneId, zone.MapId);
            if (Map* map = sMapMgr->FindMap(zone.MapId, 0))
                map->SetZoneWeather(zone.ZoneId, WEATHER_STATE_FINE, 0.0f);
        }
        ClearSummons(0, 0);
        StopCityAttacks();
        for (CityAttack const& city : Cities)
            SetWs(WS_SCRIPT_CITY_TIME_BASE + city.ZoneId, int32(now));
    }

    // VMaNGOS Enable(): resume the zones that still had necropolises when the server stopped
    void Enable()
    {
        _running = true;
        TC_LOG_INFO("scripts", "Scourge Invasion: on ({} battles won)", GetWs(WS_SI_BATTLES_WON));
        StartEventIfInactive(GAME_EVENT_SCOURGE_INVASION);
        StartEventIfInactive(GAME_EVENT_BOSS_IN_INSTANCE);
        for (InvasionZone const& zone : Zones)
            if (GetWs(zone.WsRemaining) > 0 && !IsZoneActive(zone))
                StartZone(zone, true);
    }

    // VMaNGOS Disable(): everything goes, the battles won stay
    void Disable()
    {
        _running = false;
        _finished = false;
        StopAllAttacks();
        for (uint16 eventId : { GAME_EVENT_SCOURGE_INVASION, GAME_EVENT_BOSS_IN_INSTANCE, GAME_EVENT_50_INVASIONS, GAME_EVENT_100_INVASIONS,
            GAME_EVENT_150_INVASIONS, GAME_EVENT_INVASIONS_DONE })
            StopEventIfActive(eventId);
        UpdateInvadedStates();
        TC_LOG_INFO("scripts", "Scourge Invasion: off");
    }

    void HandleMilestones(int32 wins)
    {
        if (wins < 50)
        {
            StopEventIfActive(GAME_EVENT_50_INVASIONS);
            StopEventIfActive(GAME_EVENT_100_INVASIONS);
            StopEventIfActive(GAME_EVENT_150_INVASIONS);
            StopEventIfActive(GAME_EVENT_INVASIONS_DONE);
        }
        else if (wins < 100)
        {
            StartEventIfInactive(GAME_EVENT_50_INVASIONS);
            StopEventIfActive(GAME_EVENT_100_INVASIONS);
            StopEventIfActive(GAME_EVENT_150_INVASIONS);
            StopEventIfActive(GAME_EVENT_INVASIONS_DONE);
        }
        else if (wins < 150)
        {
            StopEventIfActive(GAME_EVENT_50_INVASIONS);
            StartEventIfInactive(GAME_EVENT_100_INVASIONS);
            StopEventIfActive(GAME_EVENT_150_INVASIONS);
            StopEventIfActive(GAME_EVENT_INVASIONS_DONE);
        }
        else
        {
            StopEventIfActive(GAME_EVENT_50_INVASIONS);
            StopEventIfActive(GAME_EVENT_100_INVASIONS);
            StartEventIfInactive(GAME_EVENT_150_INVASIONS);
            StartEventIfInactive(GAME_EVENT_INVASIONS_DONE);
        }
    }

    void UpdateInvadedStates()
    {
        for (InvasionZone const& zone : Zones)
            SetWs(zone.WsInvaded, GetWs(zone.WsRemaining) > 0 ? 1 : 0);
    }

    static void StartEventIfInactive(uint16 eventId)
    {
        if (!sGameEventMgr->IsActiveEvent(eventId))
            sGameEventMgr->StartEvent(eventId, true);
    }

    static void StopEventIfActive(uint16 eventId)
    {
        if (sGameEventMgr->IsActiveEvent(eventId))
            sGameEventMgr->StopEvent(eventId, true);
    }

    std::mutex _requestLock;
    Requests _requests;
    std::unordered_map<uint32, ObjectGuid> _mouths;
    std::unordered_map<uint32, ObjectGuid> _pallids;
    uint32 _timer = 0;
    std::atomic<bool> _forceTick{ false };
    bool _configEnabled = false;
    bool _running = false;
    bool _finished = false;
};

classic_world_event_scourge_invasion* classic_world_event_scourge_invasion::Instance = nullptr;

/*
 * .scourge status | on | off | default | zone <name> | win <name> | city <sw|uc> | wins <n>
 */
class classic_scourge_invasion_commandscript : public CommandScript
{
public:
    classic_scourge_invasion_commandscript() : CommandScript("classic_scourge_invasion_commandscript") { }

    std::span<ChatCommandBuilder const> GetCommands() const override
    {
        static ChatCommandTable scourgeCommandTable =
        {
            { "status",  HandleStatus,  rbac::RBAC_PERM_COMMAND_EVENT_START, Console::Yes },
            { "on",      HandleOn,      rbac::RBAC_PERM_COMMAND_EVENT_START, Console::Yes },
            { "off",     HandleOff,     rbac::RBAC_PERM_COMMAND_EVENT_STOP,  Console::Yes },
            { "default", HandleDefault, rbac::RBAC_PERM_COMMAND_EVENT_START, Console::Yes },
            { "zone",    HandleZone,    rbac::RBAC_PERM_COMMAND_EVENT_START, Console::Yes },
            { "win",     HandleWin,     rbac::RBAC_PERM_COMMAND_EVENT_START, Console::Yes },
            { "city",    HandleCity,    rbac::RBAC_PERM_COMMAND_EVENT_START, Console::Yes },
            { "wins",    HandleWins,    rbac::RBAC_PERM_COMMAND_EVENT_START, Console::Yes },
        };
        static ChatCommandTable commandTable =
        {
            { "scourge", scourgeCommandTable },
        };
        return commandTable;
    }

    static classic_world_event_scourge_invasion* Controller(ChatHandler* handler)
    {
        if (!classic_world_event_scourge_invasion::Instance)
        {
            handler->SendSysMessage("Scourge Invasion: the event script is not loaded.");
            handler->SetSentErrorMessage(true);
        }
        return classic_world_event_scourge_invasion::Instance;
    }

    static InvasionZone const* ZoneByKey(std::string_view key)
    {
        for (InvasionZone const& zone : Zones)
            if (key == zone.Key || StringEqualI(key, zone.Name))
                return &zone;
        return nullptr;
    }

    static bool HandleStatus(ChatHandler* handler)
    {
        classic_world_event_scourge_invasion* controller = Controller(handler);
        if (!controller)
            return false;

        time_t const now = GameTime::GetGameTime();
        int32 gm = GetWs(WS_SCRIPT_GM_SWITCH);
        handler->PSendSysMessage("Scourge Invasion: %s (config %s, GM switch %s), %d battles won, last zone won %d",
            controller->IsEnabled() ? "ON" : "off", controller->IsConfigEnabled() ? "on" : "off",
            gm == 1 ? "on" : gm == 2 ? "off" : "not set", GetWs(WS_SI_BATTLES_WON), GetWs(WS_SCRIPT_LAST_ATTACK_ZONE));
        for (InvasionZone const& zone : Zones)
        {
            int32 next = GetWs(WS_SCRIPT_ATTACK_TIME_BASE + zone.ZoneId) - int32(now);
            handler->PSendSysMessage("  %s (%s): %s, %d necropolises left, timer %d min",
                zone.Name, zone.Key, controller->IsZoneActive(zone) ? "UNDER ATTACK" : "quiet", GetWs(zone.WsRemaining), std::max(next, 0) / int32(MINUTE));
        }
        for (CityAttack const& city : Cities)
        {
            int32 next = GetWs(WS_SCRIPT_CITY_TIME_BASE + city.ZoneId) - int32(now);
            handler->PSendSysMessage("  %s (%s): %s, timer %d min", city.Name, city.Key,
                controller->IsCityUnderAttack(city) ? "UNDER ATTACK" : "quiet", std::max(next, 0) / int32(MINUTE));
        }
        return true;
    }

    static bool HandleOn(ChatHandler* handler)
    {
        classic_world_event_scourge_invasion* controller = Controller(handler);
        if (!controller)
            return false;
        SetWs(WS_SCRIPT_GM_SWITCH, 1);
        controller->ForceTick();
        handler->SendSysMessage("Scourge Invasion: on (saved, stays on after a restart). The first zones start within 20 seconds.");
        return true;
    }

    static bool HandleOff(ChatHandler* handler)
    {
        classic_world_event_scourge_invasion* controller = Controller(handler);
        if (!controller)
            return false;
        SetWs(WS_SCRIPT_GM_SWITCH, 2);
        controller->ForceTick();
        handler->SendSysMessage("Scourge Invasion: off (saved). Everything despawns within 20 seconds, the battles won stay.");
        return true;
    }

    static bool HandleDefault(ChatHandler* handler)
    {
        classic_world_event_scourge_invasion* controller = Controller(handler);
        if (!controller)
            return false;
        SetWs(WS_SCRIPT_GM_SWITCH, 0);
        controller->ForceTick();
        handler->PSendSysMessage("Scourge Invasion: follows Classic.ScourgeInvasion again (now %s).", controller->IsConfigEnabled() ? "on" : "off");
        return true;
    }

    static bool HandleZone(ChatHandler* handler, std::string_view key)
    {
        classic_world_event_scourge_invasion* controller = Controller(handler);
        if (!controller)
            return false;
        InvasionZone const* zone = ZoneByKey(key);
        if (!zone)
        {
            handler->SendSysMessage("Zones: winterspring, tanaris, azshara, blasted, epl, steppes");
            handler->SetSentErrorMessage(true);
            return false;
        }
        if (!controller->IsEnabled())
        {
            handler->SendSysMessage("Scourge Invasion is off. Use .scourge on first.");
            handler->SetSentErrorMessage(true);
            return false;
        }
        uint32 zoneId = zone->ZoneId;
        controller->Request([zoneId](auto& requests) { requests.startZones.push_back(zoneId); });
        handler->PSendSysMessage("Scourge Invasion: %s will be attacked within 20 seconds.", zone->Name);
        return true;
    }

    static bool HandleWin(ChatHandler* handler, std::string_view key)
    {
        classic_world_event_scourge_invasion* controller = Controller(handler);
        if (!controller)
            return false;
        InvasionZone const* zone = ZoneByKey(key);
        if (!zone)
        {
            handler->SendSysMessage("Zones: winterspring, tanaris, azshara, blasted, epl, steppes");
            handler->SetSentErrorMessage(true);
            return false;
        }
        uint32 zoneId = zone->ZoneId;
        controller->Request([zoneId](auto& requests) { requests.winZones.push_back(zoneId); });
        handler->PSendSysMessage("Scourge Invasion: %s counts as defended within 20 seconds (if it is under attack).", zone->Name);
        return true;
    }

    static bool HandleCity(ChatHandler* handler, std::string_view key)
    {
        classic_world_event_scourge_invasion* controller = Controller(handler);
        if (!controller)
            return false;
        for (CityAttack const& city : Cities)
        {
            if (key == city.Key || StringEqualI(key, city.Name))
            {
                if (!controller->IsEnabled())
                {
                    handler->SendSysMessage("Scourge Invasion is off. Use .scourge on first.");
                    handler->SetSentErrorMessage(true);
                    return false;
                }
                uint32 zoneId = city.ZoneId;
                controller->Request([zoneId](auto& requests) { requests.startCities.push_back(zoneId); });
                handler->PSendSysMessage("Scourge Invasion: %s will be attacked within 20 seconds.", city.Name);
                return true;
            }
        }
        handler->SendSysMessage("Cities: sw, uc");
        handler->SetSentErrorMessage(true);
        return false;
    }

    static bool HandleWins(ChatHandler* handler, uint32 wins)
    {
        classic_world_event_scourge_invasion* controller = Controller(handler);
        if (!controller)
            return false;
        int32 value = int32(std::min<uint32>(wins, 1000));
        controller->Request([value](auto& requests) { requests.setWins = value; });
        handler->PSendSysMessage("Scourge Invasion: battles won set to %d (50 / 100 / 150 switch the milestone events).", value);
        return true;
    }
};

void AddSC_classic_world_event_scourge_invasion()
{
    RegisterCreatureAI(classic_si_mouth);
    RegisterCreatureAI(classic_si_necropolis);
    RegisterCreatureAI(classic_si_necropolis_health);
    RegisterCreatureAI(classic_si_necrotic_shard);
    RegisterCreatureAI(classic_si_cultist_engineer);
    RegisterCreatureAI(classic_si_minion);
    RegisterCreatureAI(classic_si_argent_emissary);
    RegisterCreatureAI(classic_si_pallid_horror);
    RegisterGameObjectAI(classic_si_go_circle);
    RegisterGameObjectAI(classic_si_go_necropolis);
    new classic_world_event_scourge_invasion();
    new classic_scourge_invasion_commandscript();
}
