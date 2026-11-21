# Notice and credits: WoW Forever Bots (this repository)

"WoW Forever Bots" by Karrz is the name of this bot system. Every upstream credit and license below stays in force.

This module is part of a TrinityCore-based tree and is distributed under the GNU General
Public License version 2 (`COPYING`), the same terms as TrinityCore.

- **PlayerbotV2** was written by agatho (https://github.com/agatho/TrinityCore, branch
  `playerbot-v2`), whose README states "GPL-2.0, same as TrinityCore". The core API, the
  module layout and most of the bot brain, travel and fleet code come from there.
- **Classic (1.12) adaptation, raid, battleground, world-population and auction house work**
  was added for WoW Forever by Karrz (Karrz1).
- **ike3 / cmangos playerbots** (ike3's mangosbot, https://github.com/ike3/mangosbot-bots, for cMaNGOS; GPL-2.0): several behaviours
  (raid brain, speech lines, rpg, battleground paths and objectives, travel) were ported from a
  VMaNGOS-based bot tree that derives from ike3 bots, VMaNGOS and cMaNGOS (all GPL-2.0).
  Source comments name the routines they follow.
- **mod-playerbots** (AzerothCore, AGPL-3.0) was read as a reference for behaviour ideas
  (for example dungeon dispersal and fleeing rules). Its code was not copied; the logic was
  re-written here. Comments mark where an idea came from.
- **Vanilla encounter data and scripts** follow VMaNGOS (GPL-2.0), as do the Classic ports
  already in `src/server/scripts/Custom/Classic`.
- **SimulationCraft (simc)** (GPL-3.0) action lists and talent loadouts were used as
  reference for the retail-era rotations and `sql/playerbot_v2/0004_simc_seed.sql`.

Keep these notices, and the copyright and licence headers that individual files carry, when
redistributing. Source files of the module do not carry per-file headers; this notice and
`COPYING` apply to all of them.

## This repository

- This branch is advocaite's TrinityCore `forever` tree (https://github.com/advocaite/TrinityCore, GPL-2.0, copyright the TrinityCore
  project and contributors) plus WoW Forever Bots. The files that were changed are derived from TrinityCore and stay under its GPL-2.0.
- The 1.12 numbers (spell values, creature stats, ...) are read from the VMaNGOS database dump by `tools/classic_spell_values/`. The dump is
  not part of this repository; it belongs to its authors.
- Libraries under `dep/` keep their own licenses (see each folder).
- mod-playerbots (AzerothCore) is AGPL-3.0: used only as a reference for ideas, no code copied. SimulationCraft is GPL-3.0: data used as reference.
- World of Warcraft data, names and client files belong to Blizzard Entertainment and are not included.
- Some live WoW Forever world data (quest texts and objective counts, object templates, vendor items, trainer levels and prices) in
  `sql/custom/world/2026_11_11_10_world_forever_eg_link_live_data.sql` and `2026_11_11_11_world_forever_eg_link_trainer_prices.sql`:
  Data from [Efficient Games](https://efficient.games) (https://github.com/JIVESCORP/eg-link-output-wowf), licensed under
  [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). Changed: only the records we lacked or had different were picked and
  converted to our database tables.
- Live WoW Forever quest data (quest order, givers and turn-ins) in `sql/custom/world/2026_11_12_15_*.sql`, `2026_11_13_86_*.sql`,
  `2026_11_13_87_*.sql`, `2026_11_14_97_*.sql`, `2026_11_16_96_*.sql`, `2026_11_18_97_*.sql`, `2026_11_19_97_*.sql` and `2026_11_20_95_*.sql`: from [Questie](https://github.com/Questie/QuestieDB) (Questie team, GPL-3.0), its Forever corrections and
  play traces. Changed: converted to our database tables, only where ours lacked it.
- Live WoW Forever world data (quest records, object templates, vendor items, trainer levels) in
  `sql/custom/world/2026_11_12_14_*.sql`, `2026_11_13_88_*.sql`, `2026_11_13_90_*.sql`, `2026_11_14_96_*.sql`, `2026_11_15_96_*.sql`, `2026_11_17_81_*.sql`,
  `2026_11_17_96_*.sql`, `2026_11_18_96_*.sql`, `2026_11_19_96_*.sql`, `2026_11_21_95_*.sql` and `2026_11_21_51_*.sql` (vendors and trainers) (and the prerequisite check in
  `2026_11_19_97_*.sql`; the giver in `2026_11_21_95_*.sql` from NorgannonDB by zmarotrix, GPL-3.0): Data from
  [Efficient Games](https://efficient.games) (https://github.com/JIVESCORP/eg-link-output-wowf), licensed under
  [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/). Changed: only the records we lacked or had different were picked and
  converted to our database tables.
- Creature drops in `sql/custom/world/2026_11_20_99_world_forever_wowhead_drops_1120.sql` and
  `2026_11_21_50_world_forever_wowhead_dungeon_drops_1121.sql` (dungeon bosses, rares and elites): Wowhead's WoW Forever database
  (www.wowhead.com/forever), drop counts over kills from its NPC pages. Changed: written as our own loot rows with the measured chance.
- Trainer lists in `sql/custom/world/2026_11_21_54_world_forever_wowhead_trainers_1121.sql`: Wowhead's WoW Forever database
  (www.wowhead.com/forever), the spells, prices and skill levels on its trainer pages. Changed: written as our own trainer rows.
- French quest text in `sql/custom/world/2026_11_15_98_world_forever_quest_locale_frFR_wowhead.sql`: from Wowhead's WoW Forever
  database (www.wowhead.com/forever), French pages, collected and shared by Ashendris (Mizuka). Changed: compared with our world and
  only the fields we lacked or that differ from live were written.
- Quest givers, drops and vendor items in `sql/custom/world/2026_11_13_91_world_forever_everlake_data.sql` and
  `2026_11_15_97_world_forever_everlake_data_1115.sql`, `2026_11_16_97_world_forever_everlake_data_1116.sql`,
  `2026_11_17_97_world_forever_everlake_data_1117.sql`, `2026_11_19_98_world_forever_everlake_data_1119.sql` (with Everlake's fixes for
  Kobold Tracks, spawn heights and the Azuregos ledger) `2026_11_19_99_world_forever_everlake_writs_1119.sql` (Craftsman's Writs,
  rare drops, quest fixes) and `2026_11_20_96_world_forever_everlake_npcs_1120.sql` (creatures and objects quests need, EG Link
  templates only; fixed by `2026_11_20_98_world_forever_everlake_npcs_fix_1120.sql`) and
  `2026_11_20_97_world_forever_everlake_quests_1120.sql` (seven Forever quests),
  `2026_11_21_90_world_forever_everlake_npcs_objects_1121.sql` (creatures, objects, quest-item drops, swim fixes) and
  `2026_11_21_91_world_forever_everlake_quests_1121.sql` (Forever quests and Icy Veins turn-in texts),
  `2026_11_21_52_world_forever_everlake_quests_2_1121.sql` (six more of those quests) and
  `2026_11_21_92_world_forever_everlake_bosses_1121.sql` (Kresh, Old Serra'kis and Mana Wraith abilities) and
  `2026_11_21_93_world_forever_everlake_gossip_1121.sql` (132 gossip choices that had no option; VMaNGOS menus and conditions) and
  `2026_11_21_94_world_forever_everlake_gossip_2_1121.sql` (the last gossip choices and conversations; VMaNGOS and AzerothCore): from Everlake's world data
  ([buildthehomelab/wow-everlake-world-data](https://github.com/buildthehomelab/wow-everlake-world-data), GPL-3.0), which in turn
  credits EG Link (CC BY 4.0), Polestar forever-db, QuestieDB, ForeverDB.net (GPL-3.0), NorgannonDB by zmarotrix (GPL-3.0), Icy Veins'
  WoW Forever database (db.icy-veins.com/wow-forever) and Wowhead's WoW Forever database (www.wowhead.com/forever). Changed: compared with our world and only rows we lacked were written as ours.
- Ideas from the Everlake core (https://github.com/buildthehomelab/wow-trinitycore-everlake, GPL-2.0, a fork of this core), written
  as our own code: the hunter pet's food type taken from the client's Item table (`ObjectMgr::LoadItemTemplates`), and the hunter
  pet's wild attack speed through the client's Faster / Slower Attack passives (`ClassicPetAttackSpeed.h`), and Classic mob tagging,
  where the first player or bot to hit a mob owns it with their group (`Classic.FirstTagOwnsMob`, `Creature::SetTappedBy`, off by default).
- From the Everlake core (https://github.com/buildthehomelab/wow-trinitycore-everlake, GPL, a fork of this core), written as our
  own code: ranged weapons and wands take the ranged stat budget column (`GetRandomPropertyPoints`, ItemEnchantmentMgr.cpp).
- From the Everlake core (https://github.com/buildthehomelab/wow-trinitycore-everlake, GPL-2.0, a fork of this core), taken as
  given: a TACT key we don't hold is answered "not public" (`HotfixHandler.cpp`, Everlake 973f193b), and worldserver.conf.d files
  keep their keys with no `[section]` header or with several (`ConfigMgr::LoadAdditionalFile` and its test, Everlake db11c6d9 and
  03481268).
- Weapon chance-on-hit rates in `sql/custom/world/2026_11_06_41_world_classic_weapon_proc_every_hit.sql` and
  `2026_11_16_80_world_forever_item_proc_ppm_measured.sql`: from [wowsims/forever](https://github.com/wowsims/forever)
  (`tools/database/overrides/weapon_procs.go`), MIT licence, copyright the wowsims contributors. Only the rates were taken.
- Forever Combat Nameplates (`src/modules/PlayerbotV2/Addon/ForeverCombatNameplates` and the combat nameplate filter in `Player.cpp`,
  `ChatHandler.cpp`, `WorldSession.cpp` and `ViewerDependentValues.h`): by SIN, GPL-2.0 (COPYING in the add-on folder).
- The Hallow's End link for the Southshore Stink Bomb Counter in `sql/custom/world/2026_11_16_97_*.sql` and the Pledge of Adoration
  cards in `2026_11_19_98_*.sql` were checked against
  [cmangos classic-db](https://github.com/cmangos/classic-db) (GPL-2.0).
- `sql/custom/world/2026_11_20_70_*`, `_71_*` and `_72_*` (live NPC templates, new quests, live drops): data from
  [Efficient Games](https://efficient.games) (https://github.com/JIVESCORP/eg-link-output-wowf), licensed under
  [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/), picked and converted to our tables. Quest givers, turn-ins, classes
  and previous quests in `_71_` also from [NorgannonDB](https://github.com/zmarotrix/NorgannonDB) by zmarotrix (GPL-3.0).
