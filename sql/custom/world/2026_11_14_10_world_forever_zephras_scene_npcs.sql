-- Zephras Isle (map 2991): orange-named NPCs that cannot be attacked stood all over the island (player report 2026-11-12,
-- High Priestess Lorthuna "Level ??" and a Living Storm by Belathaan in Gustberry Lowlands 59.9 57.4).
-- They are the story versions of NPCs: hostile faction (Al'Aketh 3578, or 14/16) and immune to players (unit_flags 0x100/0x300).
-- On live they only show up during a quest scene. Our scene scripts already summon them, but later imports put fixed copies back
-- (the AnoCore quest data restored by 2026_11_05_99, guids entry*100, VerifiedBuild 0; the Azeroth project beta sniffs of
-- 2026_10_27_70, guids 43000xxx). Live behaviour comes from public data only: EG Link (CC BY 4.0) creature records for builds
-- 70245-70862 (reactions, deaths, the creature cache) and the Icy Veins Forever DB sightings and loot.
-- Safe to run more than once. Spawns are matched by NPC and map, so it also cleans up if one of those imports runs again.

-- 1. Fixed copies of NPCs a scene script summons (src/server/scripts/Custom/Classic/world/classic_npcs_special.cpp):
--    A Firm Response (93746, classic_npc_belathaan_brightwish): High Priestess Lorthuna 256249 (25624900), Living Storm 256250
--      (25625000). The script brings them down next to Belathaan and lets the storms attack; 2026_10_04_06 had removed the sniff
--      copies, 2026_11_05_99 put guessed ones back. This is the pair in the report.
--    The Cult's True Plans (94568, classic_npc_talaanis_shadowsong): the recall crystal images of Lorthuna 264712 (26471200) and
--      Commander Haalien 264713 (26471300). The script summons them and gives the 264712 credit itself.
--    Standing Our Ground (92693, classic_npc_malfunctioning_cyclone_construct): Ferauu the Bludgeon 252863 (25286300, 43000294) and
--      Bandit Henchman 252875 (25287500, 43000296, 43000297). The construct summons them and kills them; the 252863 credit comes
--      from Aamelia. Live data has no player kill of either (EG Link, builds 70235-70790).
--    Confront Lorthuna (92646, classic_npc_ayessa_spire), the top of the spire: Lorthuna 252957 (43000298), Rohash 255833
--      (43000343), Malevolent Storm 255830 (43000335-43000342), Baron Anvillaxx 256617 (43000364), Muln Earthfury 256620
--      (43000365), Archmage Ansirem Runeweaver 256621 (43000366), Earthen Ring Shaman 257862 (43000369), Kirin Tor Mage 257866
--      (43000370). The script summons every one of them during the battle.
DELETE `ca` FROM `creature_addon` `ca` JOIN `creature` `c` ON `c`.`guid` = `ca`.`guid`
WHERE `c`.`map` = 2991 AND `c`.`id` IN (256249,256250,264712,264713,252863,252875,252957,255833,255830,256617,256620,256621,257862,257866);
DELETE `s` FROM `spawn_group` `s` JOIN `creature` `c` ON `c`.`guid` = `s`.`spawnId` AND `s`.`spawnType` = 0
WHERE `c`.`map` = 2991 AND `c`.`id` IN (256249,256250,264712,264713,252863,252875,252957,255833,255830,256617,256620,256621,257862,257866);
DELETE `p` FROM `pool_members` `p` JOIN `creature` `c` ON `c`.`guid` = `p`.`spawnId` AND `p`.`type` = 0
WHERE `c`.`map` = 2991 AND `c`.`id` IN (256249,256250,264712,264713,252863,252875,252957,255833,255830,256617,256620,256621,257862,257866);
DELETE `f` FROM `creature_formations` `f` JOIN `creature` `c` ON `c`.`guid` IN (`f`.`leaderGUID`, `f`.`memberGUID`)
WHERE `c`.`map` = 2991 AND `c`.`id` IN (256249,256250,264712,264713,252863,252875,252957,255833,255830,256617,256620,256621,257862,257866);
DELETE `l` FROM `linked_respawn` `l` JOIN `creature` `c`
  ON (`l`.`guid` = `c`.`guid` AND `l`.`linkType` IN (0, 1)) OR (`l`.`linkedGuid` = `c`.`guid` AND `l`.`linkType` IN (0, 3))
WHERE `c`.`map` = 2991 AND `c`.`id` IN (256249,256250,264712,264713,252863,252875,252957,255833,255830,256617,256620,256621,257862,257866);
DELETE `e` FROM `game_event_creature` `e` JOIN `creature` `c` ON `c`.`guid` = `e`.`guid`
WHERE `c`.`map` = 2991 AND `c`.`id` IN (256249,256250,264712,264713,252863,252875,252957,255833,255830,256617,256620,256621,257862,257866);
DELETE `m` FROM `creature_movement_override` `m` JOIN `creature` `c` ON `c`.`guid` = `m`.`SpawnId`
WHERE `c`.`map` = 2991 AND `c`.`id` IN (256249,256250,264712,264713,252863,252875,252957,255833,255830,256617,256620,256621,257862,257866);
DELETE FROM `creature`
WHERE `map` = 2991 AND `id` IN (256249,256250,264712,264713,252863,252875,252957,255833,255830,256617,256620,256621,257862,257866);

-- 2. Malevolent Storm (255830): the first two storms of the spire battle attack the players next to Baron Anvillaxx, but the
--    template kept the sniffed "immune to players" flag, so neither side could hit the other. On live players kill and loot
--    them (EG Link deaths at the spire, 75.2 53.3, in builds 70245, 70291 and 70790; Icy Veins loot records 70790-70862).
--    The second wave stays immune: the script sets that itself.
UPDATE `creature_template` SET `unit_flags` = `unit_flags` & ~0x100 WHERE `entry` = 255830;

-- 3. High Priestess Lorthuna (252076) and Skypriest Aanders (252077) at the inn of Falaath Village: the guest Aanders receives
--    in Among the Faithful (92528, "he is occupied at present receiving a guest at the inn"), overheard from the Wardrobe
--    (254128, credit 252078). Players doing the quest wear the Mark of Akir (faction 3577, a friend of the Al'Aketh), so the pair
--    is friendly to them; everyone else saw two hostile NPCs they could not fight, also while clearing the village for Havoc in
--    the Highlands (92550). Live sightings are few (EG Link and Icy Veins: one player each) and no capture holds a phase for
--    them, so this is INFERRED: they show only to players who have Among the Faithful in their log (incomplete or complete).
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 32 AND `SourceGroup` = 5 AND `SourceEntry` IN (252076, 252077);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ConditionStringValue1`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(32, 5, 252076, 0, 0, 47, 0, 92528, 10, 0, '', 0, 0, 0, '', 'High Priestess Lorthuna (Falaath inn) - visible while Among the Faithful is in the log'),
(32, 5, 252077, 0, 0, 47, 0, 92528, 10, 0, '', 0, 0, 0, '', 'Skypriest Aanders (Falaath inn) - visible while Among the Faithful is in the log');

-- 4. Slain Fledgling (258458, "Child of Ur'endra"): the kin Ur'endra killed, lying in her cave (Strength and Mercy, 94638). The sniff
--    gave them the immune flags of a corpse but no corpse aura, so four hostile level 10 birds stood around her. They get
--    Permanent Feign Death (1239173), the aura the other Zephras corpses use (Al'Aketh Attacker 253787, Tower Watchman 253357).
--    INFERRED from the name and the quest text: no capture shows their aura.
INSERT INTO `creature_template_addon` (`entry`, `auras`) VALUES (258458, '1239173') ON DUPLICATE KEY UPDATE `auras` = '1239173';

-- Left as they are (checked):
--   Sania Silverstream 251904, Missionary Jasaan 257065: Al'Aketh missionaries, give and take quests while hostile (live, see the
--     Karrz Zephras capture of 2026-11-11).
--   Al'Aketh Attacker 253787: corpses (Permanent Feign Death, uninteractible).
--   Shadowgale Shrieker 256108: ambient birds 40-90 yards above the ground.
--   Living Storm 256250 keeps its template flag: the A Firm Response script lifts it when the storms strike (live deaths, EG Link).
--   Windshaper (3599) and High Order (3600) NPCs: hostile to the other side on live too (EG Link reactions).
