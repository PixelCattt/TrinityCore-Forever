-- WoW Forever: The Shaper's Terrace (map 3001, zone 16667, levels 58-60) made playable: instance, way in and out, creature
-- templates, spawns, trash abilities and loot. The fights are in classic_instance_shapers_terrace.cpp.
-- No sniff or combat log of this dungeon exists yet. What is real data and what is a guess:
--  * from Everlake's Forever dungeon work (github.com/buildthehomelab, GPL): the 44 new creatures (names, ranks, types,
--    models), which boss drops which items, the way in (the hill over Marshal's Refuge in Un'Goro Crater, from a public
--    guide), which part of the terrace holds which boss, and 69 of the 70 spawn spots (all checked on our navmesh: on the
--    walkable mesh joined to the landing, at the floor's height).
--  * real: the map and its navmesh; Cinder and Snowtalon (players' caches, 2026_11_14_40); the client's area trigger 10556
--    on map 3001 (-5800, -1280, -6.7), which marks where the dungeon is entered, so the landing is beside it; the
--    graveyard "Un'Goro Crater, Shaper's Terrace GY" (1372); the boss items 280009-280029/280031/280032/280045 and the
--    trash items 287037-287045 (all in our hotfixes); every spell used; the trash abilities, which are those of the
--    Un'Goro creatures the trash is named after (our creature_template and smart_scripts, VMaNGOS spell lists).
--  * ours, INFERRED: the landing (28 y from the client's trigger, on the main navmesh piece: Everlake's landing at
--    (-6117, -1246, -143) is on a piece of the mesh that is not joined to the terrace), Bolt's spot (Everlake's was 17 y
--    from Venomridge, so both would come at once), levels, health and damage multipliers, unit classes of the casters,
--    gold, drop chances, which Un'Goro creature each trash kind takes its abilities from.
--  * Cinder, Snowtalon, Bolt, Vitrix and Nanaya are summoned at their Archival Panels on live; the panels and crystals are
--    not in any data we have, so they stand there.
-- Held: 273116, 273128 and 274964 (in the drop lists, not in our hotfixes), 280030 (no boss drops it), 287046 Pylon Poker
-- (not in our hotfixes).
-- Panic at the Digsite (95924, live record from EG Link): it wants 6 Ravasaur Matriarchs, 9 Ironhide Ravasaurs and
-- Venomridge. Everlake has one spot per pack, so its Matriarch and Ironhide spots are packs of three here, and one more
-- pack of each stands at an INFERRED spot (on the mesh joined to the landing, 39 y and more from any other spawn, 55 y
-- and more from the landing): 6 and 9, as the quest wants. Who gives and takes the quest is not in any data we have, so
-- it has no giver yet (held).
-- Spawn guids 48140000-48140199, reference loot 3001000. Safe to run again.

-- the instance (entrance on Kalimdor)
DELETE FROM `instance_template` WHERE `map` = 3001;
INSERT INTO `instance_template` (`map`,`parent`,`script`) VALUES
(3001,1,'classic_instance_shapers_terrace');

-- templates (names, ranks, types and models from Everlake; levels, health and the rest INFERRED). Cinder and Snowtalon keep
-- their templates from the players' caches (2026_11_14_40).
DELETE FROM `creature_template` WHERE `entry` IN (253201,253214,253215,253218,261749,261750,261752,261770,261771,261773,261774,261779,261780,261781,261782,261783,261784,261785,261786,261809,261811,261812,261813,261898,261934,261968,261993,262081,262114,262115,262117,262127,262164,262166,262167,262168,262188,262190,262191,262197,262299,262300,262301,272561);
INSERT INTO `creature_template` (`entry`,`KillCredit1`,`KillCredit2`,`name`,`femaleName`,`subname`,`TitleAlt`,`IconName`,`RequiredExpansion`,`VignetteID`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`Classification`,`dmgschool`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,`unit_flags`,`unit_flags2`,`unit_flags3`,`family`,`trainer_class`,`type`,`VehicleId`,`AIName`,`MovementType`,`ExperienceModifier`,`RacialLeader`,`movementId`,`WidgetSetID`,`WidgetSetUnitConditionID`,`RegenHealth`,`CreatureImmunitiesId`,`flags_extra`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(253201,0,0,'Titanosaur',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,1,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(253214,0,0,'Ravasaur Hunter',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,1,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(253215,0,0,'Ravasaur Matriarch',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,1,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(253218,0,0,'Izha''Rel',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,2,0,2048,0,0,0,1,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(261749,0,0,'Devilsaur',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,1,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(261750,0,0,'Tyranosaur',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,1,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(261752,0,0,'Devilsaur',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,1,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(261770,0,0,'Azurepetal Trapper',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,4,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(261771,0,0,'Diemetradon',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,1,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(261773,0,0,'Tar Lurker',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,4,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(261774,0,0,'Azurepetal Flayer',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,4,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(261779,0,0,'Tar Walker',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,4,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(261780,0,0,'Quickpetal Lasher',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,10,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(261781,0,0,'Tar Crawler',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,4,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(261782,0,0,'Tar Hunter',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,4,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(261783,0,0,'Thunderstomp Stegodon',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,1,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(261784,0,0,'Spiked Stegodon',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,1,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(261785,0,0,'Plated Stegodon',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,1,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(261786,0,0,'Ironhide Ravasaur',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,1,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(261809,0,0,'Nanaya',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,2,0,2048,0,0,0,5,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(261811,0,0,'Tor''Rel',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,1,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(261812,0,0,'Thunderhoof',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,2,0,2048,0,0,0,1,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(261813,0,0,'Venomridge',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,1,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(261898,0,0,'Ravasaur Juvenile',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,0,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,1,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(261934,0,0,'Ravasaur Stalker',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,1,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(261968,0,0,'Azurepetal Sporecaller',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,4,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(261993,0,0,'King Op',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,2,0,2000,2000,1.0,1.0,2,0,2048,0,0,0,1,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(262081,0,0,'Bolt',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,2,0,2048,0,0,0,1,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(262114,0,0,'Ravasaur Trapper',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,1,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(262115,0,0,'Ravasaur Assassin',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,1,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(262117,0,0,'Stegodon Young',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,1,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(262127,0,0,'Direhorn Matriarch',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,1,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(262164,0,0,'Emerald Flayer',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,10,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(262166,0,0,'Emerald Overgrowth',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,10,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(262167,0,0,'Emerald Seedling',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,0,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,10,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(262168,0,0,'Emerald Harvester',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,10,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(262188,0,0,'Emberleaf Flayer',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,10,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(262190,0,0,'Emberleaf Germinator',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,10,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(262191,0,0,'Emberleaf Scorcher',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,10,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(262197,0,0,'Quickpetal Flayer',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,10,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(262299,0,0,'Eastgrotto Gorilla',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,1,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(262300,0,0,'Eastgrotto Dweller',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,1,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(262301,0,0,'Eastgrotto Silverback',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,1,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(272561,0,0,'Vitrix',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,2,0,2048,0,0,0,1,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0);
UPDATE `creature_template` SET `unit_class` = 2 WHERE `entry` IN (261974,262297);
DELETE FROM `creature_template_difficulty` WHERE `Entry` IN (253201,253214,253215,253218,261749,261750,261752,261770,261771,261773,261774,261779,261780,261781,261782,261783,261784,261785,261786,261809,261811,261812,261813,261898,261934,261968,261993,262081,262114,262115,262117,262127,262164,262166,262167,262168,262188,262190,262191,262197,262299,262300,262301,272561);
INSERT INTO `creature_template_difficulty` (`Entry`,`DifficultyID`,`LevelScalingDeltaMin`,`LevelScalingDeltaMax`,`ContentTuningID`,`HealthScalingExpansion`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`DamageModifier`,`CreatureDifficultyID`,`TypeFlags`,`TypeFlags2`,`TypeFlags3`,`LootID`,`PickPocketLootID`,`SkinLootID`,`GoldMin`,`GoldMax`,`StaticFlags1`,`StaticFlags2`,`StaticFlags3`,`StaticFlags4`,`StaticFlags5`,`StaticFlags6`,`StaticFlags7`,`StaticFlags8`,`VerifiedBuild`) VALUES
(253201,0,0,0,0,0,12.0,1.0,1.0,2.0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(253214,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(253215,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(253218,0,0,0,0,0,7.0,1.0,1.0,2.0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(261749,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(261750,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(261752,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(261770,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(261771,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(261773,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(261774,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(261779,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(261780,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(261781,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(261782,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(261783,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(261784,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(261785,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(261786,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(261809,0,0,0,0,0,16.0,1.0,1.0,2.0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(261811,0,0,0,0,0,7.0,1.0,1.0,2.0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(261812,0,0,0,0,0,12.0,1.0,1.0,2.0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(261813,0,0,0,0,0,12.0,1.0,1.0,2.0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(261898,0,0,0,0,0,1.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(261934,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(261968,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(261993,0,0,0,0,0,8.0,1.0,1.0,2.0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(262081,0,0,0,0,0,12.0,1.0,1.0,2.0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(262114,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(262115,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(262117,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(262127,0,0,0,0,0,12.0,1.0,1.0,2.0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(262164,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(262166,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(262167,0,0,0,0,0,1.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(262168,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(262188,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(262190,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(262191,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(262197,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(262299,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(262300,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(262301,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(272561,0,0,0,0,0,13.0,1.0,1.0,2.0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
DELETE FROM `creature_template_model` WHERE `CreatureID` IN (253201,253214,253215,253218,261749,261750,261752,261770,261771,261773,261774,261779,261780,261781,261782,261783,261784,261785,261786,261809,261811,261812,261813,261898,261934,261968,261993,262081,262114,262115,262117,262127,262164,262166,262167,262168,262188,262190,262191,262197,262299,262300,262301,272561);
INSERT INTO `creature_template_model` (`CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild`) VALUES
(253201,0,142989,1.0,1.0,0),
(253214,0,4442,1.0,1.0,0),
(253215,0,143340,1.0,1.0,0),
(253218,0,143040,1.0,1.0,0),
(261749,0,144495,1.0,1.0,0),
(261750,0,142990,1.0,1.0,0),
(261752,0,144497,1.0,1.0,0),
(261770,0,13172,1.0,1.0,0),
(261771,0,8512,1.0,1.0,0),
(261773,0,9010,1.0,1.0,0),
(261774,0,13172,1.0,1.0,0),
(261779,0,480,1.0,1.0,0),
(261780,0,12348,1.0,1.0,0),
(261781,0,3018,1.0,1.0,0),
(261782,0,1549,1.0,1.0,0),
(261783,0,10934,1.0,1.0,0),
(261784,0,143329,1.0,1.0,0),
(261785,0,2764,1.0,1.0,0),
(261786,0,1337,1.0,1.0,0),
(261809,0,143832,1.0,1.0,0),
(261811,0,143039,1.0,1.0,0),
(261812,0,144514,1.0,1.0,0),
(261813,0,144511,1.0,1.0,0),
(261898,0,11316,1.0,1.0,0),
(261934,0,648,1.0,1.0,0),
(261968,0,132032,1.0,1.0,0),
(261993,0,143129,1.0,1.0,0),
(262081,0,143063,1.0,1.0,0),
(262114,0,1962,1.0,1.0,0),
(262115,0,948,1.0,1.0,0),
(262117,0,1540,1.0,1.0,0),
(262127,0,144515,1.0,1.0,0),
(262164,0,132024,1.0,1.0,0),
(262166,0,138253,1.0,1.0,0),
(262167,0,13172,1.0,1.0,0),
(262168,0,138246,1.0,1.0,0),
(262188,0,13110,1.0,1.0,0),
(262190,0,138256,1.0,1.0,0),
(262191,0,13110,1.0,1.0,0),
(262197,0,132025,1.0,1.0,0),
(262299,0,844,1.0,1.0,0),
(262300,0,5244,1.0,1.0,0),
(262301,0,5244,1.0,1.0,0),
(272561,0,147098,1.0,1.0,0);
DELETE FROM `creature_classic_level` WHERE `entry` IN (253201,253214,253215,253218,261749,261750,261752,261770,261771,261773,261774,261779,261780,261781,261782,261783,261784,261785,261786,261809,261811,261812,261813,261898,261934,261968,261993,262081,262114,262115,262117,262127,262164,262166,262167,262168,262188,262190,262191,262197,262299,262300,262301,272561);
INSERT INTO `creature_classic_level` (`entry`,`level_min`,`level_max`) VALUES
(253201,59,59),
(253214,58,59),
(253215,58,59),
(253218,59,59),
(261749,58,59),
(261750,58,59),
(261752,58,59),
(261770,58,59),
(261771,58,59),
(261773,58,59),
(261774,58,59),
(261779,58,59),
(261780,58,59),
(261781,58,59),
(261782,58,59),
(261783,58,59),
(261784,58,59),
(261785,58,59),
(261786,58,59),
(261809,60,60),
(261811,59,59),
(261812,59,59),
(261813,59,59),
(261898,58,59),
(261934,58,59),
(261968,58,59),
(261993,59,59),
(262081,59,59),
(262114,58,59),
(262115,58,59),
(262117,58,59),
(262127,59,59),
(262164,58,59),
(262166,58,59),
(262167,58,59),
(262168,58,59),
(262188,58,59),
(262190,58,59),
(262191,58,59),
(262197,58,59),
(262299,58,59),
(262300,58,59),
(262301,58,59),
(272561,60,60);

-- boss scripts
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_boss_shapers_titanosaur' WHERE `entry` = 253201;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_boss_shapers_torrel' WHERE `entry` = 261811;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_boss_shapers_izharel' WHERE `entry` = 253218;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_boss_shapers_thunderhoof' WHERE `entry` = 261812;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_boss_shapers_venomridge' WHERE `entry` = 261813;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_boss_shapers_direhorn_matriarch' WHERE `entry` = 262127;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_boss_shapers_cinder' WHERE `entry` = 261974;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_boss_shapers_king_op' WHERE `entry` = 261993;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_boss_shapers_snowtalon' WHERE `entry` = 262297;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_boss_shapers_bolt' WHERE `entry` = 262081;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_boss_shapers_vitrix' WHERE `entry` = 272561;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_boss_shapers_nanaya' WHERE `entry` = 261809;

-- gold (INFERRED) and loot ids
UPDATE `creature_template_difficulty` SET `GoldMin` = 500, `GoldMax` = 1300, `LootID` = `Entry` WHERE `DifficultyID` = 0 AND `Entry` IN (253214,253215,261749,261750,261752,261770,261771,261773,261774,261779,261780,261781,261782,261783,261784,261785,261786,261898,261934,261968,262114,262115,262117,262164,262166,262167,262168,262188,262190,262191,262197,262299,262300,262301);
UPDATE `creature_template_difficulty` SET `GoldMin` = 4500, `GoldMax` = 9000, `LootID` = `Entry` WHERE `DifficultyID` = 0 AND `Entry` IN (253201,261811,253218,261812,261813,262127,261974,261993,262297,262081,272561,261809);

-- the Shaper's Terrace trash items (287037-287045, bind on equip; which items are this dungeon's is read from their names): one roll
-- from the list (chances INFERRED)
DELETE FROM `reference_loot_template` WHERE `Entry` = 3001000;
INSERT INTO `reference_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(3001000,0,287037,0,0,1,1,1,1,'Shaper''s Terrace trash item: Shaper''s Robe'),
(3001000,0,287038,0,0,1,1,1,1,'Shaper''s Terrace trash item: Naturopathy Footpads'),
(3001000,0,287039,0,0,1,1,1,1,'Shaper''s Terrace trash item: Tattered Explorer''s Cuffs'),
(3001000,0,287040,0,0,1,1,1,1,'Shaper''s Terrace trash item: Dinosaur Hide Belt'),
(3001000,0,287041,0,0,1,1,1,1,'Shaper''s Terrace trash item: Time-Forgotten Bindings'),
(3001000,0,287042,0,0,1,1,1,1,'Shaper''s Terrace trash item: Pauldrons of the Stone Guardian'),
(3001000,0,287043,0,0,1,1,1,1,'Shaper''s Terrace trash item: Predaceous Band'),
(3001000,0,287044,0,0,1,1,1,1,'Shaper''s Terrace trash item: Predator''s Shroud'),
(3001000,0,287045,0,0,1,1,1,1,'Shaper''s Terrace trash item: Ancient Mattock');
DELETE FROM `creature_loot_template` WHERE `Entry` IN (253201,253214,253215,261749,261750,261752,261770,261771,261773,261774,261779,261780,261781,261782,261783,261784,261785,261786,261809,261811,261812,261813,261898,261934,261968,261974,262081,262114,262115,262117,262127,262164,262166,262167,262168,262188,262190,262191,262197,262297,262299,262300,262301,272561);
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(253201,0,280009,33.3,0,1,1,1,1,'Titanosaur: boss item, one each kill (which boss: Everlake; chance INFERRED)'),
(253201,0,280010,33.3,0,1,1,1,1,'Titanosaur: boss item, one each kill (which boss: Everlake; chance INFERRED)'),
(253201,0,280011,33.4,0,1,1,1,1,'Titanosaur: boss item, one each kill (which boss: Everlake; chance INFERRED)'),
(261811,0,280012,33.3,0,1,1,1,1,'Tor''Rel: boss item, one each kill (which boss: Everlake; chance INFERRED)'),
(261811,0,280013,33.3,0,1,1,1,1,'Tor''Rel: boss item, one each kill (which boss: Everlake; chance INFERRED)'),
(261811,0,280014,33.4,0,1,1,1,1,'Tor''Rel: boss item, one each kill (which boss: Everlake; chance INFERRED)'),
(261813,0,280015,33.3,0,1,1,1,1,'Venomridge: boss item, one each kill (which boss: Everlake; chance INFERRED)'),
(261813,0,280016,33.3,0,1,1,1,1,'Venomridge: boss item, one each kill (which boss: Everlake; chance INFERRED)'),
(261813,0,280017,33.4,0,1,1,1,1,'Venomridge: boss item, one each kill (which boss: Everlake; chance INFERRED)'),
(261812,0,280018,33.3,0,1,1,1,1,'Thunderhoof: boss item, one each kill (which boss: Everlake; chance INFERRED)'),
(261812,0,280019,33.3,0,1,1,1,1,'Thunderhoof: boss item, one each kill (which boss: Everlake; chance INFERRED)'),
(261812,0,280020,33.4,0,1,1,1,1,'Thunderhoof: boss item, one each kill (which boss: Everlake; chance INFERRED)'),
(262127,0,280021,33.3,0,1,1,1,1,'Direhorn Matriarch: boss item, one each kill (which boss: Everlake; chance INFERRED)'),
(262127,0,280022,33.3,0,1,1,1,1,'Direhorn Matriarch: boss item, one each kill (which boss: Everlake; chance INFERRED)'),
(262127,0,280045,33.4,0,1,1,1,1,'Direhorn Matriarch: boss item, one each kill (which boss: Everlake; chance INFERRED)'),
(261809,0,280023,33.3,0,1,1,1,1,'Nanaya: boss item, one each kill (which boss: Everlake; chance INFERRED)'),
(261809,0,280024,33.3,0,1,1,1,1,'Nanaya: boss item, one each kill (which boss: Everlake; chance INFERRED)'),
(261809,0,280025,33.4,0,1,1,1,1,'Nanaya: boss item, one each kill (which boss: Everlake; chance INFERRED)'),
(262297,0,280026,50.0,0,1,1,1,1,'Snowtalon: boss item, one each kill (which boss: Everlake; chance INFERRED)'),
(262297,0,280027,50.0,0,1,1,1,1,'Snowtalon: boss item, one each kill (which boss: Everlake; chance INFERRED)'),
(261974,0,280028,50.0,0,1,1,1,1,'Cinder: boss item, one each kill (which boss: Everlake; chance INFERRED)'),
(261974,0,280029,50.0,0,1,1,1,1,'Cinder: boss item, one each kill (which boss: Everlake; chance INFERRED)'),
(262081,0,280031,50.0,0,1,1,1,1,'Bolt: boss item, one each kill (which boss: Everlake; chance INFERRED)'),
(262081,0,280032,50.0,0,1,1,1,1,'Bolt: boss item, one each kill (which boss: Everlake; chance INFERRED)'),
(272561,0,280026,16.7,0,1,1,1,1,'Vitrix: one of the Archival Panel bosses'' items each kill (Everlake; chance INFERRED)'),
(272561,0,280027,16.7,0,1,1,1,1,'Vitrix: one of the Archival Panel bosses'' items each kill (Everlake; chance INFERRED)'),
(272561,0,280028,16.7,0,1,1,1,1,'Vitrix: one of the Archival Panel bosses'' items each kill (Everlake; chance INFERRED)'),
(272561,0,280029,16.7,0,1,1,1,1,'Vitrix: one of the Archival Panel bosses'' items each kill (Everlake; chance INFERRED)'),
(272561,0,280031,16.7,0,1,1,1,1,'Vitrix: one of the Archival Panel bosses'' items each kill (Everlake; chance INFERRED)'),
(272561,0,280032,16.5,0,1,1,1,1,'Vitrix: one of the Archival Panel bosses'' items each kill (Everlake; chance INFERRED)'),
(253214,1,3001000,3,0,1,0,1,1,'Ravasaur Hunter: Shaper''s Terrace trash item (chance INFERRED)'),
(253215,1,3001000,3,0,1,0,1,1,'Ravasaur Matriarch: Shaper''s Terrace trash item (chance INFERRED)'),
(261749,1,3001000,3,0,1,0,1,1,'Devilsaur: Shaper''s Terrace trash item (chance INFERRED)'),
(261750,1,3001000,3,0,1,0,1,1,'Tyranosaur: Shaper''s Terrace trash item (chance INFERRED)'),
(261752,1,3001000,3,0,1,0,1,1,'Devilsaur: Shaper''s Terrace trash item (chance INFERRED)'),
(261770,1,3001000,3,0,1,0,1,1,'Azurepetal Trapper: Shaper''s Terrace trash item (chance INFERRED)'),
(261771,1,3001000,3,0,1,0,1,1,'Diemetradon: Shaper''s Terrace trash item (chance INFERRED)'),
(261773,1,3001000,3,0,1,0,1,1,'Tar Lurker: Shaper''s Terrace trash item (chance INFERRED)'),
(261774,1,3001000,3,0,1,0,1,1,'Azurepetal Flayer: Shaper''s Terrace trash item (chance INFERRED)'),
(261779,1,3001000,3,0,1,0,1,1,'Tar Walker: Shaper''s Terrace trash item (chance INFERRED)'),
(261780,1,3001000,3,0,1,0,1,1,'Quickpetal Lasher: Shaper''s Terrace trash item (chance INFERRED)'),
(261781,1,3001000,3,0,1,0,1,1,'Tar Crawler: Shaper''s Terrace trash item (chance INFERRED)'),
(261782,1,3001000,3,0,1,0,1,1,'Tar Hunter: Shaper''s Terrace trash item (chance INFERRED)'),
(261783,1,3001000,3,0,1,0,1,1,'Thunderstomp Stegodon: Shaper''s Terrace trash item (chance INFERRED)'),
(261784,1,3001000,3,0,1,0,1,1,'Spiked Stegodon: Shaper''s Terrace trash item (chance INFERRED)'),
(261785,1,3001000,3,0,1,0,1,1,'Plated Stegodon: Shaper''s Terrace trash item (chance INFERRED)'),
(261786,1,3001000,3,0,1,0,1,1,'Ironhide Ravasaur: Shaper''s Terrace trash item (chance INFERRED)'),
(261898,1,3001000,3,0,1,0,1,1,'Ravasaur Juvenile: Shaper''s Terrace trash item (chance INFERRED)'),
(261934,1,3001000,3,0,1,0,1,1,'Ravasaur Stalker: Shaper''s Terrace trash item (chance INFERRED)'),
(261968,1,3001000,3,0,1,0,1,1,'Azurepetal Sporecaller: Shaper''s Terrace trash item (chance INFERRED)'),
(262114,1,3001000,3,0,1,0,1,1,'Ravasaur Trapper: Shaper''s Terrace trash item (chance INFERRED)'),
(262115,1,3001000,3,0,1,0,1,1,'Ravasaur Assassin: Shaper''s Terrace trash item (chance INFERRED)'),
(262117,1,3001000,3,0,1,0,1,1,'Stegodon Young: Shaper''s Terrace trash item (chance INFERRED)'),
(262164,1,3001000,3,0,1,0,1,1,'Emerald Flayer: Shaper''s Terrace trash item (chance INFERRED)'),
(262166,1,3001000,3,0,1,0,1,1,'Emerald Overgrowth: Shaper''s Terrace trash item (chance INFERRED)'),
(262167,1,3001000,3,0,1,0,1,1,'Emerald Seedling: Shaper''s Terrace trash item (chance INFERRED)'),
(262168,1,3001000,3,0,1,0,1,1,'Emerald Harvester: Shaper''s Terrace trash item (chance INFERRED)'),
(262188,1,3001000,3,0,1,0,1,1,'Emberleaf Flayer: Shaper''s Terrace trash item (chance INFERRED)'),
(262190,1,3001000,3,0,1,0,1,1,'Emberleaf Germinator: Shaper''s Terrace trash item (chance INFERRED)'),
(262191,1,3001000,3,0,1,0,1,1,'Emberleaf Scorcher: Shaper''s Terrace trash item (chance INFERRED)'),
(262197,1,3001000,3,0,1,0,1,1,'Quickpetal Flayer: Shaper''s Terrace trash item (chance INFERRED)'),
(262299,1,3001000,3,0,1,0,1,1,'Eastgrotto Gorilla: Shaper''s Terrace trash item (chance INFERRED)'),
(262300,1,3001000,3,0,1,0,1,1,'Eastgrotto Dweller: Shaper''s Terrace trash item (chance INFERRED)'),
(262301,1,3001000,3,0,1,0,1,1,'Eastgrotto Silverback: Shaper''s Terrace trash item (chance INFERRED)');

-- trash abilities: each kind fights like the Un'Goro creature it is named after (that creature's own rows, same spells and timers)
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` IN (253214,253215,261749,261750,261752,261770,261771,261773,261774,261779,261780,261781,261782,261783,261784,261785,261786,261898,261934,261968,262114,262115,262117,262164,262166,262167,262168,262188,262190,262191,262197,262299,262300,262301);
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` IN (253214,253215,261749,261750,261752,261770,261771,261773,261774,261779,261780,261781,261782,261783,261784,261785,261786,261898,261934,261968,262114,262115,262117,262164,262166,262167,262168,262188,262190,262191,262197,262299,262300,262301);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`Difficulties`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`action_param7`,`action_param_string`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_param_string`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(253214,0,0,0,'',0,0,100,0,8000,8000,20000,20000,0,'',11,13443,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Ravasaur Hunter - as Ravasaur Hunter (6507): VMaNGOS spell list 65070'),
(253214,0,1,0,'',0,0,100,0,4000,4000,20000,20000,0,'',11,3604,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Ravasaur Hunter - as Ravasaur Hunter (6507): VMaNGOS spell list 65070'),
(253215,0,0,0,'',0,0,100,0,8000,8000,20000,20000,0,'',11,13445,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Ravasaur Matriarch - as Ravasaur Matriarch (6581): VMaNGOS spell list 65810'),
(261749,0,0,0,'',0,0,100,0,8000,8000,20000,30000,0,'',11,14099,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Devilsaur - as Devilsaur (6498): VMaNGOS spell list 64980'),
(261750,0,0,0,'',0,0,100,0,8000,8000,20000,30000,0,'',11,14099,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Tyranosaur - as Devilsaur (6498): VMaNGOS spell list 64980'),
(261752,0,0,0,'',0,0,100,0,8000,8000,20000,30000,0,'',11,14099,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Devilsaur - as Devilsaur (6498): VMaNGOS spell list 64980'),
(261770,0,0,0,'',0,0,100,0,6000,6000,18000,23000,0,'',11,11922,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Azurepetal Trapper - as Bloodpetal Trapper (6512): VMaNGOS spell list 65120'),
(261771,0,0,0,'',0,0,100,0,8000,8000,15000,15000,0,'',11,13692,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Diemetradon - as Diemetradon (9163): VMaNGOS spell list 91630'),
(261773,0,0,0,'',0,0,100,0,10000,10000,18000,23000,0,'',11,7279,0,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'Tar Lurker - as Tar Lurker (6518): VMaNGOS spell list 65180'),
(261774,0,0,0,'',0,0,100,0,6000,6000,6000,9000,0,'',11,14112,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Azurepetal Flayer - as Bloodpetal Flayer (6510): VMaNGOS spell list 65100'),
(261779,0,0,0,'',0,0,100,0,8000,8000,14000,19000,0,'',11,5568,0,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'Tar Walker - as Tar Creeper (6527): VMaNGOS spell list 65270'),
(261780,0,0,0,'',0,0,100,0,8000,8000,20000,20000,0,'',11,6607,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Quickpetal Lasher - as Bloodpetal Lasher (6509): VMaNGOS spell list 65090'),
(261781,0,0,0,'',0,0,100,0,8000,8000,14000,19000,0,'',11,5568,0,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'Tar Crawler - as Tar Creeper (6527): VMaNGOS spell list 65270'),
(261782,0,0,0,'',11,0,100,0,0,0,0,0,0,'',11,14178,0,0,0,0,0,0,NULL,1,0,0,0,0,NULL,0,0,0,0,'Tar Hunter - as Tar Beast (6517): Tar Beast - On Respawn - Cast ''Sticky Tar'' (No Repeat)'),
(261783,0,0,0,'',0,0,100,0,5000,5000,8000,14000,0,'',11,14102,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Thunderstomp Stegodon - as Thunderstomp Stegodon (6504): VMaNGOS spell list 65040'),
(261783,0,1,0,'',0,0,100,0,4000,4000,14000,14000,0,'',11,15548,0,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'Thunderstomp Stegodon - as Thunderstomp Stegodon (6504): VMaNGOS spell list 65040'),
(261784,0,0,0,'',0,0,100,0,5000,5000,8000,14000,0,'',11,15652,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Spiked Stegodon - as Spiked Stegodon (6503): VMaNGOS spell list 65030'),
(261785,0,0,0,'',0,0,100,0,5000,5000,8000,14000,0,'',11,15652,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Plated Stegodon - as Plated Stegodon (6502): VMaNGOS spell list 65020'),
(261786,0,0,0,'',0,0,100,0,8000,8000,20000,20000,0,'',11,13443,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Ironhide Ravasaur - as Ravasaur (6505): VMaNGOS spell list 65050'),
(261898,0,0,0,'',0,0,100,0,8000,8000,20000,20000,0,'',11,13443,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Ravasaur Juvenile - as Ravasaur (6505): VMaNGOS spell list 65050'),
(261934,0,0,0,'',0,0,100,0,8000,8000,20000,20000,0,'',11,13443,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Ravasaur Stalker - as Ravasaur Hunter (6507): VMaNGOS spell list 65070'),
(261934,0,1,0,'',0,0,100,0,4000,4000,20000,20000,0,'',11,3604,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Ravasaur Stalker - as Ravasaur Hunter (6507): VMaNGOS spell list 65070'),
(261968,0,0,0,'',11,0,100,0,0,0,0,0,0,'',11,14111,0,0,0,0,0,0,NULL,1,0,0,0,0,NULL,0,0,0,0,'Azurepetal Sporecaller - as Bloodpetal Thresher (6511): Bloodpetal Thresher - On Respawn - Cast ''Bloodpetal Poison Proc'''),
(262114,0,0,0,'',0,0,100,0,8000,8000,20000,20000,0,'',11,13443,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Ravasaur Trapper - as Ravasaur Hunter (6507): VMaNGOS spell list 65070'),
(262114,0,1,0,'',0,0,100,0,4000,4000,20000,20000,0,'',11,3604,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Ravasaur Trapper - as Ravasaur Hunter (6507): VMaNGOS spell list 65070'),
(262115,0,0,0,'',0,0,100,0,8000,8000,20000,20000,0,'',11,13443,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Ravasaur Assassin - as Ravasaur Hunter (6507): VMaNGOS spell list 65070'),
(262115,0,1,0,'',0,0,100,0,4000,4000,20000,20000,0,'',11,3604,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Ravasaur Assassin - as Ravasaur Hunter (6507): VMaNGOS spell list 65070'),
(262117,0,0,0,'',9,0,100,0,6,15,6000,6000,0,'',11,6268,0,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'Stegodon Young - as Stegodon (6501): VMaNGOS EventAI 650101'),
(262117,0,1,0,'',0,0,100,0,5000,5000,8000,14000,0,'',11,15652,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Stegodon Young - as Stegodon (6501): VMaNGOS spell list 65010'),
(262164,0,0,0,'',0,0,100,0,6000,6000,6000,9000,0,'',11,14112,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Emerald Flayer - as Bloodpetal Flayer (6510): VMaNGOS spell list 65100'),
(262166,0,0,0,'',11,0,100,0,0,0,0,0,0,'',11,14111,0,0,0,0,0,0,NULL,1,0,0,0,0,NULL,0,0,0,0,'Emerald Overgrowth - as Bloodpetal Thresher (6511): Bloodpetal Thresher - On Respawn - Cast ''Bloodpetal Poison Proc'''),
(262167,0,0,0,'',0,0,100,0,8000,8000,20000,20000,0,'',11,6607,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Emerald Seedling - as Bloodpetal Lasher (6509): VMaNGOS spell list 65090'),
(262168,0,0,0,'',0,0,100,0,6000,6000,18000,23000,0,'',11,11922,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Emerald Harvester - as Bloodpetal Trapper (6512): VMaNGOS spell list 65120'),
(262188,0,0,0,'',0,0,100,0,6000,6000,6000,9000,0,'',11,14112,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Emberleaf Flayer - as Bloodpetal Flayer (6510): VMaNGOS spell list 65100'),
(262190,0,0,0,'',11,0,100,0,0,0,0,0,0,'',11,14111,0,0,0,0,0,0,NULL,1,0,0,0,0,NULL,0,0,0,0,'Emberleaf Germinator - as Bloodpetal Thresher (6511): Bloodpetal Thresher - On Respawn - Cast ''Bloodpetal Poison Proc'''),
(262191,0,0,0,'',0,0,100,0,6000,6000,6000,9000,0,'',11,14112,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Emberleaf Scorcher - as Bloodpetal Flayer (6510): VMaNGOS spell list 65100'),
(262197,0,0,0,'',0,0,100,0,6000,6000,6000,9000,0,'',11,14112,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Quickpetal Flayer - as Bloodpetal Flayer (6510): VMaNGOS spell list 65100'),
(262299,0,0,1,'',2,0,100,1,0,20,0,0,0,'',11,8599,0,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'Eastgrotto Gorilla - as Un''Goro Stomper (6513): VMaNGOS EventAI 651301'),
(262299,0,1,0,'',61,0,100,0,0,0,0,0,0,'',1,0,0,1,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Eastgrotto Gorilla - as Un''Goro Stomper (6513): VMaNGOS EventAI 651301'),
(262300,0,0,1,'',2,0,100,1,0,20,0,0,0,'',11,8599,0,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'Eastgrotto Dweller - as Un''Goro Stomper (6513): VMaNGOS EventAI 651301'),
(262300,0,1,0,'',61,0,100,0,0,0,0,0,0,'',1,0,0,1,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Eastgrotto Dweller - as Un''Goro Stomper (6513): VMaNGOS EventAI 651301'),
(262301,0,0,0,'',1,0,100,0,0,0,60000,180000,0,'',1,0,0,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'Eastgrotto Silverback - as Un''Goro Thunderer (6516): VMaNGOS EventAI 651601'),
(262301,0,1,0,'',0,0,100,0,5000,5000,9000,15000,0,'',11,12553,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Eastgrotto Silverback - as Un''Goro Thunderer (6516): VMaNGOS spell list 65160');

-- spawns: Everlake's spots (all on our walkable mesh at the floor's height, joined to the landing); Bolt moved 45 y away from
-- Venomridge (INFERRED)
DELETE FROM `creature` WHERE `guid` BETWEEN 48140000 AND 48140199;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(48140000,253201,3001,0,0,'1,201',0,0,0,-1,0,0,-5662.50,-1454.20,36.37,4.155,86400,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Titanosaur: Titanosaur on the paved road (Walk of Communion) (spot from Everlake, on our mesh) */,
(48140001,253214,3001,0,0,'1,201',0,0,0,-1,0,0,-5620.80,-762.50,28.52,2.826,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Ravasaur Hunter: a pack (spot from Everlake, on our mesh) */,
(48140002,253214,3001,0,0,'1,201',0,0,0,-1,0,0,-5795.80,-737.50,42.39,6.246,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Ravasaur Hunter: a pack (spot from Everlake, on our mesh) */,
(48140003,253215,3001,0,0,'1,201',0,0,0,-1,0,0,-5637.50,-729.20,31.60,3.400,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Ravasaur Matriarch: a pack (spot from Everlake, on our mesh) */,
(48140004,253218,3001,0,0,'1,201',0,0,0,-1,0,0,-5687.50,-737.50,26.65,5.312,86400,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Izha'Rel: Izha'Rel beside Tor'Rel (spot from Everlake, on our mesh) */,
(48140005,261749,3001,0,0,'1,201',0,0,0,-1,0,0,-5620.80,-970.80,19.89,4.102,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Devilsaur: a pack (spot from Everlake, on our mesh) */,
(48140006,261750,3001,0,0,'1,201',0,0,0,-1,0,0,-5662.50,-1012.50,13.74,4.157,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Tyranosaur: a pack (spot from Everlake, on our mesh) */,
(48140007,261752,3001,0,0,'1,201',0,0,0,-1,0,0,-5579.20,-929.20,22.40,4.069,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Devilsaur: a pack (spot from Everlake, on our mesh) */,
(48140008,261770,3001,0,0,'1,201',0,0,0,-1,0,0,-5670.80,-704.20,25.80,4.358,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Azurepetal Trapper: a pack (spot from Everlake, on our mesh) */,
(48140009,261770,3001,0,0,'1,201',0,0,0,-1,0,0,-5587.50,-737.50,31.97,3.185,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Azurepetal Trapper: a pack (spot from Everlake, on our mesh) */,
(48140010,261771,3001,0,0,'1,201',0,0,0,-1,0,0,-5529.20,-962.50,18.82,3.878,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Diemetradon: a pack (spot from Everlake, on our mesh) */,
(48140011,261771,3001,0,0,'1,201',0,0,0,-1,0,0,-5579.20,-812.50,18.59,4.242,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Diemetradon: a pack (spot from Everlake, on our mesh) */,
(48140012,261773,3001,0,0,'1,201',0,0,0,-1,0,0,-5912.50,-1262.50,9.71,1.636,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Tar Lurker: a pack (spot from Everlake, on our mesh) */,
(48140013,261773,3001,0,0,'1,201',0,0,0,-1,0,0,-5929.20,-1170.80,9.20,4.975,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Tar Lurker: a pack (spot from Everlake, on our mesh) */,
(48140014,261774,3001,0,0,'1,201',0,0,0,-1,0,0,-5745.80,-737.50,33.59,6.215,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Azurepetal Flayer: a pack (spot from Everlake, on our mesh) */,
(48140015,261774,3001,0,0,'1,201',0,0,0,-1,0,0,-5762.50,-704.20,37.43,5.835,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Azurepetal Flayer: a pack (spot from Everlake, on our mesh) */,
(48140016,261779,3001,0,0,'1,201',0,0,0,-1,0,0,-5912.50,-1137.50,8.45,4.682,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Tar Walker: a pack (spot from Everlake, on our mesh) */,
(48140017,261779,3001,0,0,'1,201',0,0,0,-1,0,0,-5937.50,-1320.80,10.24,1.345,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Tar Walker: a pack (spot from Everlake, on our mesh) */,
(48140018,261780,3001,0,0,'1,201',0,0,0,-1,0,0,-5604.20,-1237.50,38.54,4.444,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Quickpetal Lasher: a pack (spot from Everlake, on our mesh) */,
(48140019,261780,3001,0,0,'1,201',0,0,0,-1,0,0,-5637.50,-1587.50,40.72,1.779,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Quickpetal Lasher: a pack (spot from Everlake, on our mesh) */,
(48140020,261781,3001,0,0,'1,201',0,0,0,-1,0,0,-6029.20,-1462.50,-0.99,4.812,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Tar Crawler: a pack (spot from Everlake, on our mesh) */,
(48140021,261781,3001,0,0,'1,201',0,0,0,-1,0,0,-6020.80,-1712.50,11.57,1.552,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Tar Crawler: a pack (spot from Everlake, on our mesh) */,
(48140022,261782,3001,0,0,'1,201',0,0,0,-1,0,0,-6037.50,-1679.20,8.23,1.390,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Tar Hunter: a pack (spot from Everlake, on our mesh) */,
(48140023,261782,3001,0,0,'1,201',0,0,0,-1,0,0,-6004.20,-1504.20,8.52,4.514,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Tar Hunter: a pack (spot from Everlake, on our mesh) */,
(48140024,261783,3001,0,0,'1,201',0,0,0,-1,0,0,-5520.80,-1037.50,11.19,3.655,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Thunderstomp Stegodon: a pack (spot from Everlake, on our mesh) */,
(48140025,261784,3001,0,0,'1,201',0,0,0,-1,0,0,-5787.50,-904.20,22.63,4.803,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Spiked Stegodon: a pack (spot from Everlake, on our mesh) */,
(48140026,261784,3001,0,0,'1,201',0,0,0,-1,0,0,-5762.50,-1479.20,9.03,1.572,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Spiked Stegodon: a pack (spot from Everlake, on our mesh) */,
(48140027,261785,3001,0,0,'1,201',0,0,0,-1,0,0,-5662.50,-779.20,24.03,4.463,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Plated Stegodon: a pack (spot from Everlake, on our mesh) */,
(48140028,261785,3001,0,0,'1,201',0,0,0,-1,0,0,-5737.50,-1054.20,9.01,4.504,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Plated Stegodon: a pack (spot from Everlake, on our mesh) */,
(48140029,261786,3001,0,0,'1,201',0,0,0,-1,0,0,-5812.50,-1329.20,-6.38,1.261,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Ironhide Ravasaur: a pack (spot from Everlake, on our mesh) */,
(48140030,261786,3001,0,0,'1,201',0,0,0,-1,0,0,-5862.50,-1179.20,0.36,0.051,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Ironhide Ravasaur: a pack (spot from Everlake, on our mesh) */,
(48140031,261809,3001,0,0,'1,201',0,0,0,-1,0,0,-5854.20,-1587.50,37.14,0.360,86400,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Nanaya: Nanaya on the Pillar of Assimilation (spot from Everlake, on our mesh) */,
(48140032,261811,3001,0,0,'1,201',0,0,0,-1,0,0,-5687.50,-745.80,25.93,0.966,86400,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Tor'Rel: Tor'Rel on the northern path (spot from Everlake, on our mesh) */,
(48140033,261812,3001,0,0,'1,201',0,0,0,-1,0,0,-6020.80,-1554.20,9.37,4.849,86400,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Thunderhoof: Thunderhoof on the south rim (Shaper's Plateau) (spot from Everlake, on our mesh) */,
(48140034,261813,3001,0,0,'1,201',0,0,0,-1,0,0,-5912.50,-1220.80,8.88,3.906,86400,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Venomridge: Venomridge by the tar (Botanical Grounds) (spot from Everlake, on our mesh) */,
(48140035,261898,3001,0,0,'1,201',0,0,0,-1,0,0,-5804.20,-1762.50,18.68,1.501,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Ravasaur Juvenile: a pack (spot from Everlake, on our mesh) */,
(48140036,261898,3001,0,0,'1,201',0,0,0,-1,0,0,-5904.20,-1462.50,11.00,1.115,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Ravasaur Juvenile: a pack (spot from Everlake, on our mesh) */,
(48140037,261934,3001,0,0,'1,201',0,0,0,-1,0,0,-5612.50,-879.20,22.61,4.241,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Ravasaur Stalker: a pack (spot from Everlake, on our mesh) */,
(48140038,261934,3001,0,0,'1,201',0,0,0,-1,0,0,-5687.50,-1154.20,8.88,3.400,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Ravasaur Stalker: a pack (spot from Everlake, on our mesh) */,
(48140039,261968,3001,0,0,'1,201',0,0,0,-1,0,0,-5770.80,-762.50,37.17,0.237,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Azurepetal Sporecaller: a pack (spot from Everlake, on our mesh) */,
(48140040,261974,3001,0,0,'1,201',0,0,0,-1,0,0,-5904.20,-862.50,112.81,5.584,86400,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Cinder: Cinder at Ruby Spring, the Red Archival Panel's hills (spot from Everlake, on our mesh) */,
(48140041,261993,3001,0,0,'1,201',0,0,0,-1,0,0,-6020.80,-1829.20,57.07,1.196,86400,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* King Op: King Op among the gorillas, east of the plains (spot from Everlake, on our mesh) */,
(48140042,262081,3001,0,0,'1,201',0,0,0,-1,0,0,-5935.00,-1181.80,9.05,6.110,86400,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Bolt: Bolt behind Venomridge, the Yellow Panel (our spot, INFERRED) */,
(48140043,262114,3001,0,0,'1,201',0,0,0,-1,0,0,-5812.50,-1054.20,13.60,5.104,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Ravasaur Trapper: a pack (spot from Everlake, on our mesh) */,
(48140044,262114,3001,0,0,'1,201',0,0,0,-1,0,0,-5637.50,-1079.20,10.12,3.790,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Ravasaur Trapper: a pack (spot from Everlake, on our mesh) */,
(48140045,262115,3001,0,0,'1,201',0,0,0,-1,0,0,-5687.50,-929.20,18.96,4.414,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Ravasaur Assassin: a pack (spot from Everlake, on our mesh) */,
(48140046,262115,3001,0,0,'1,201',0,0,0,-1,0,0,-5737.50,-779.20,30.89,4.648,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Ravasaur Assassin: a pack (spot from Everlake, on our mesh) */,
(48140047,262117,3001,0,0,'1,201',0,0,0,-1,0,0,-5645.80,-829.20,24.52,4.385,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Stegodon Young: a pack (spot from Everlake, on our mesh) */,
(48140048,262117,3001,0,0,'1,201',0,0,0,-1,0,0,-5770.80,-954.20,18.81,4.748,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Stegodon Young: a pack (spot from Everlake, on our mesh) */,
(48140049,262127,3001,0,0,'1,201',0,0,0,-1,0,0,-5729.20,-1762.50,34.07,1.363,86400,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Direhorn Matriarch: the Direhorn Matriarch at the eastern edge (spot from Everlake, on our mesh) */,
(48140050,262164,3001,0,0,'1,201',0,0,0,-1,0,0,-5787.50,-1279.20,-6.36,1.341,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Emerald Flayer: a pack (spot from Everlake, on our mesh) */,
(48140051,262164,3001,0,0,'1,201',0,0,0,-1,0,0,-5837.50,-1129.20,8.95,5.741,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Emerald Flayer: a pack (spot from Everlake, on our mesh) */,
(48140052,262166,3001,0,0,'1,201',0,0,0,-1,0,0,-5812.50,-1704.20,10.30,1.477,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Emerald Overgrowth: a pack (spot from Everlake, on our mesh) */,
(48140053,262167,3001,0,0,'1,201',0,0,0,-1,0,0,-5820.80,-1454.20,10.20,1.367,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Emerald Seedling: a pack (spot from Everlake, on our mesh) */,
(48140054,262167,3001,0,0,'1,201',0,0,0,-1,0,0,-5995.80,-1429.20,6.73,0.831,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Emerald Seedling: a pack (spot from Everlake, on our mesh) */,
(48140055,262168,3001,0,0,'1,201',0,0,0,-1,0,0,-5579.20,-1012.50,14.72,3.863,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Emerald Harvester: a pack (spot from Everlake, on our mesh) */,
(48140056,262188,3001,0,0,'1,201',0,0,0,-1,0,0,-5729.20,-562.50,5.09,5.428,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Emberleaf Flayer: a pack (spot from Everlake, on our mesh) */,
(48140057,262188,3001,0,0,'1,201',0,0,0,-1,0,0,-5637.50,-670.80,25.27,2.264,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Emberleaf Flayer: a pack (spot from Everlake, on our mesh) */,
(48140058,262190,3001,0,0,'1,201',0,0,0,-1,0,0,-5637.50,-554.20,9.49,3.931,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Emberleaf Germinator: a pack (spot from Everlake, on our mesh) */,
(48140059,262190,3001,0,0,'1,201',0,0,0,-1,0,0,-5679.20,-654.20,19.68,1.802,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Emberleaf Germinator: a pack (spot from Everlake, on our mesh) */,
(48140060,262191,3001,0,0,'1,201',0,0,0,-1,0,0,-5729.20,-620.80,17.14,0.332,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Emberleaf Scorcher: a pack (spot from Everlake, on our mesh) */,
(48140061,262197,3001,0,0,'1,201',0,0,0,-1,0,0,-5679.20,-1537.50,43.07,1.392,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Quickpetal Flayer: a pack (spot from Everlake, on our mesh) */,
(48140062,262197,3001,0,0,'1,201',0,0,0,-1,0,0,-5637.50,-1495.80,40.80,2.198,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Quickpetal Flayer: a pack (spot from Everlake, on our mesh) */,
(48140063,262297,3001,0,0,'1,201',0,0,0,-1,0,0,-5687.50,-604.20,13.02,4.002,86400,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Snowtalon: Snowtalon in the Crystalline Highlands, the Blue Panel (spot from Everlake, on our mesh) */,
(48140064,262299,3001,0,0,'1,201',0,0,0,-1,0,0,-5495.80,-995.80,16.48,3.730,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Eastgrotto Gorilla: a pack (spot from Everlake, on our mesh) */,
(48140065,262299,3001,0,0,'1,201',0,0,0,-1,0,0,-5670.80,-970.80,16.57,4.287,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Eastgrotto Gorilla: a pack (spot from Everlake, on our mesh) */,
(48140066,262300,3001,0,0,'1,201',0,0,0,-1,0,0,-5762.50,-862.50,25.95,4.711,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Eastgrotto Dweller: a pack (spot from Everlake, on our mesh) */,
(48140067,262300,3001,0,0,'1,201',0,0,0,-1,0,0,-5737.50,-1437.50,9.37,1.667,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Eastgrotto Dweller: a pack (spot from Everlake, on our mesh) */,
(48140068,262301,3001,0,0,'1,201',0,0,0,-1,0,0,-5712.50,-1012.50,11.65,4.410,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Eastgrotto Silverback: a pack (spot from Everlake, on our mesh) */,
(48140069,272561,3001,0,0,'1,201',0,0,0,-1,0,0,-5520.80,-845.80,22.18,5.326,86400,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Vitrix: Vitrix at Watcher's Overlook, the Green Panel (spot from Everlake, on our mesh) */,
(48140070,253215,3001,0,0,'1,201',0,0,0,-1,0,0,-5635.02,-731.67,31.50,3.400,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Ravasaur Matriarch: in the pack at (-5637.5, -729.2) (INFERRED spot, on our mesh) */,
(48140071,253215,3001,0,0,'1,201',0,0,0,-1,0,0,-5636.56,-725.83,32.05,3.400,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Ravasaur Matriarch: in the pack at (-5637.5, -729.2) (INFERRED spot, on our mesh) */,
(48140072,253215,3001,0,0,'1,201',0,0,0,-1,0,0,-5710.00,-705.00,27.96,0.020,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Ravasaur Matriarch: in the pack at (-5710.0, -705.0) (INFERRED spot, on our mesh) */,
(48140073,253215,3001,0,0,'1,201',0,0,0,-1,0,0,-5711.83,-702.02,27.81,0.020,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Ravasaur Matriarch: in the pack at (-5710.0, -705.0) (INFERRED spot, on our mesh) */,
(48140074,253215,3001,0,0,'1,201',0,0,0,-1,0,0,-5711.46,-707.62,28.28,0.020,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Ravasaur Matriarch: in the pack at (-5710.0, -705.0) (INFERRED spot, on our mesh) */,
(48140075,261786,3001,0,0,'1,201',0,0,0,-1,0,0,-5815.92,-1329.96,-5.77,1.261,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Ironhide Ravasaur: in the pack at (-5812.5, -1329.2) (INFERRED spot, on our mesh) */,
(48140076,261786,3001,0,0,'1,201',0,0,0,-1,0,0,-5810.16,-1331.80,-5.91,1.261,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Ironhide Ravasaur: in the pack at (-5812.5, -1329.2) (INFERRED spot, on our mesh) */,
(48140077,261786,3001,0,0,'1,201',0,0,0,-1,0,0,-5864.42,-1176.27,1.67,0.051,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Ironhide Ravasaur: in the pack at (-5862.5, -1179.2) (INFERRED spot, on our mesh) */,
(48140078,261786,3001,0,0,'1,201',0,0,0,-1,0,0,-5864.11,-1182.31,0.05,0.051,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Ironhide Ravasaur: in the pack at (-5862.5, -1179.2) (INFERRED spot, on our mesh) */,
(48140079,261786,3001,0,0,'1,201',0,0,0,-1,0,0,-5855.00,-1260.00,-5.83,3.185,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Ironhide Ravasaur: in the pack at (-5855.0, -1260.0) (INFERRED spot, on our mesh) */,
(48140080,261786,3001,0,0,'1,201',0,0,0,-1,0,0,-5853.10,-1262.94,-6.30,3.185,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Ironhide Ravasaur: in the pack at (-5855.0, -1260.0) (INFERRED spot, on our mesh) */,
(48140081,261786,3001,0,0,'1,201',0,0,0,-1,0,0,-5853.37,-1256.90,-6.04,3.185,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Ironhide Ravasaur: in the pack at (-5855.0, -1260.0) (INFERRED spot, on our mesh) */;

-- the way in: the hill over Marshal's Refuge in Un'Goro Crater (map 1; Everlake's spot from a public guide). The landing is 28 y
-- from the client's own trigger of the dungeon (10556), the exit on that trigger (INFERRED spots, on our mesh).
DELETE FROM `world_safe_locs` WHERE `ID` IN (1104128,1104129);
INSERT INTO `world_safe_locs` (`ID`,`MapID`,`LocX`,`LocY`,`LocZ`,`Facing`,`Comment`) VALUES
(1104128,3001,-5792.65,-1252.98,-5.95,1.305,'The Shaper''s Terrace (dungeon) - entrance inside (INFERRED)'),
(1104129,1,-6107.1,-1246.4,-143.25,0.0,'The Shaper''s Terrace (dungeon) - exit outside, the hill over Marshal''s Refuge (INFERRED)');
DELETE FROM `areatrigger_template` WHERE `IsCustom` = 1 AND `Id` IN (328,329);
INSERT INTO `areatrigger_template` (`Id`,`IsCustom`,`Flags`,`ActionSetId`,`ActionSetFlags`,`VerifiedBuild`) VALUES
(328,1,0,0,0,0),
(329,1,0,0,0,0);
DELETE FROM `areatrigger_template_actions` WHERE `IsCustom` = 1 AND `AreaTriggerId` IN (328,329);
INSERT INTO `areatrigger_template_actions` (`AreaTriggerId`,`IsCustom`,`ActionType`,`ActionParam`,`TargetType`) VALUES
(328,1,2,1104128,5),
(329,1,2,1104129,5);
DELETE FROM `areatrigger_create_properties` WHERE `IsCustom` = 1 AND `Id` IN (328,329);
INSERT INTO `areatrigger_create_properties` (`Id`,`IsCustom`,`AreaTriggerId`,`IsAreatriggerCustom`,`Flags`,`MoveCurveId`,`ScaleCurveId`,`MorphCurveId`,`FacingCurveId`,`AnimId`,`AnimKitId`,`DecalPropertiesId`,`SpellForVisuals`,`PositionalSoundKitId`,`TimeToTargetScale`,`Speed`,`SpeedIsTime`,`Shape`,`ShapeData0`,`ShapeData1`,`ShapeData2`,`ShapeData3`,`ShapeData4`,`ShapeData5`,`ShapeData6`,`ShapeData7`,`Roll`,`Pitch`,`Yaw`,`TargetRoll`,`TargetPitch`,`TargetYaw`,`ScriptName`,`VerifiedBuild`) VALUES
(328,1,328,1,0,0,0,0,0,-1,0,0,NULL,0,0,0,0,0,5,5,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,'',0),
(329,1,329,1,0,0,0,0,0,-1,0,0,NULL,0,0,0,0,0,4,4,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,'',0);
DELETE FROM `areatrigger` WHERE `SpawnId` IN (38,39);
INSERT INTO `areatrigger` (`SpawnId`,`AreaTriggerCreatePropertiesId`,`IsCustom`,`MapId`,`SpawnDifficulties`,`PosX`,`PosY`,`PosZ`,`Orientation`,`PhaseUseFlags`,`PhaseId`,`PhaseGroup`,`ScriptName`,`Comment`,`VerifiedBuild`) VALUES
(38,328,1,1,'0',-6117.1,-1246.4,-143.25,0,1,0,0,'','The Shaper''s Terrace - dungeon entrance (Un''Goro Crater, over Marshal''s Refuge; spot from Everlake)',0),
(39,329,1,3001,'1,201',-5800.0,-1280.0,-6.7,0,1,0,0,'','The Shaper''s Terrace (dungeon) - exit (on the client''s trigger 10556)',0);

-- ghosts release to Un'Goro Crater's Shaper's Terrace graveyard
DELETE FROM `graveyard_zone` WHERE `GhostZone` = 16667;
INSERT INTO `graveyard_zone` (`ID`,`GhostZone`,`Comment`) VALUES
(1372,16667,'The Shaper''s Terrace (dungeon) - Un''Goro Crater, Shaper''s Terrace GY');

-- .tele
DELETE FROM `game_tele` WHERE `name` IN ('ShapersTerrace','ShapersTerraceEntrance');
INSERT INTO `game_tele` (`id`,`position_x`,`position_y`,`position_z`,`orientation`,`map`,`name`) VALUES
(2358,-5792.65,-1252.98,-5.95,1.305,3001,'ShapersTerrace'),
(2359,-6107.1,-1246.4,-143.25,0.0,1,'ShapersTerraceEntrance');

-- Panic at the Digsite (95924): the live record (EG Link, build 1.60.1.70959). Data from Efficient Games
-- (https://efficient.games), licensed under CC BY 4.0. Reward text is not in the data and nobody is known to give or take
-- the quest, so it has no giver, turn-in or reward text yet (held until a cache or sniff shows the NPC).
DELETE FROM `quest_template` WHERE `ID` = 95924;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardXPDifficulty`,`RewardXPMultiplier`,`Flags`,`AllowableRaces`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionID2`,`RewardFactionValue2`,`LogTitle`,`LogDescription`,`QuestDescription`,`VerifiedBuild`) VALUES
(95924,2,16985,81,5,2.675,33554696,6130900294268439629,279903,1,279905,1,47,5,72,3,'Panic at the Digsite','Slay 6 Ravasaur Matriarchs, 9 Ironhide Ravasaurs and Venomridge in Shaper''s Terrace.','Ye there! Aye, I''m talkin'' ta ye! We''ve made the discovery of a lifetime down in Un''Goro! Can ye believe it?\n\nThere''s just one problem... our dig site''s been overrun by voracious beasts of the killin'' nature. Very unpleasant indeed.\n\nWith yer help, we can reclaim our camp and git back ta workin''. Now, what do ye say? I''ll make it worth yer while.',70959);
DELETE FROM `quest_template_addon` WHERE `ID` = 95924;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (95924,0,0,0);
DELETE FROM `quest_classic_level` WHERE `ID` = 95924;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (95924,60,55,0);
DELETE FROM `quest_template_classic_level` WHERE `ID` = 95924;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (95924,2,60);
DELETE FROM `quest_classic_money` WHERE `ID` = 95924;
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES (95924,9000,0);
DELETE FROM `quest_objectives` WHERE `QuestID` = 95924 OR `ID` IN (471733,471734,471735);
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(471733,95924,0,0,0,261813,1,0,0,0,0,0,1,NULL,70959),
(471734,95924,0,1,1,253215,6,0,0,0,0,0,1,NULL,70959),
(471735,95924,0,2,2,261786,9,0,0,0,0,0,1,NULL,70959);
