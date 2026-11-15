-- WoW Forever live drops and vendor items from Everlake's world data, picked on 15 Nov: only what our world lacked.
-- From Everlake's world data (buildthehomelab/wow-everlake-world-data, main a1158b75, GPL-3.0), its exports 19, 20 and 21:
-- Icy Veins' WoW Forever database (db.icy-veins.com/wow-forever, what its players' addons recorded on live Forever, with the
-- chances it measured) and Wowhead's WoW Forever database. Not their files: their rows were compared with ours and only what we
-- lack is written here as our own rows. Safe to run more than once.

-- 1. Creature drops seen on live that ours lacks: 96 rows on 80 creatures (Icy Veins chances). Only spawned creatures, items the
--    client has, and only where the creature's own loot (or its reference tables) does not already hold the item. A row goes in
--    only where the creature's loot id is its own entry (or not set yet; then it is set), so no other creature's loot changes.
DROP TEMPORARY TABLE IF EXISTS `forever_drops_1115`;
CREATE TEMPORARY TABLE `forever_drops_1115` (`Entry` INT UNSIGNED NOT NULL, `Item` INT UNSIGNED NOT NULL, `Chance` FLOAT NOT NULL, `MinCount` TINYINT UNSIGNED NOT NULL, `MaxCount` TINYINT UNSIGNED NOT NULL, PRIMARY KEY (`Entry`,`Item`));
INSERT INTO `forever_drops_1115` (`Entry`,`Item`,`Chance`,`MinCount`,`MaxCount`) VALUES
(588,277957,1.09,1,1),
(595,277957,1.35,1,1),
(597,277957,0.79,1,1),
(660,277957,0.92,1,1),
(671,277957,0.35,1,1),
(699,277957,0.96,1,1),
(701,277957,1.88,1,1),
(780,213127,7.75,1,1),
(813,216616,1.61,1,1),
(939,216616,12.39,1,1),
(978,216616,5.51,1,1),
(1094,264210,0.57,1,1),
(1564,217161,8.43,1,1),
(2287,284870,0.46,1,1),
(2347,213526,86.96,1,1),
(2567,249487,0.93,1,1),
(2570,264212,0.62,1,1),
(2596,251393,1.5,1,1),
(2656,264218,1.12,1,1),
(2701,278515,5.26,1,1),
(2715,278515,5.11,1,1),
(2739,278402,19.26,1,1),
(2740,278402,13.61,1,1),
(2748,252868,2.38,1,1),
(2748,252870,2.38,1,1),
(2748,252919,2.38,1,1),
(2893,278402,1.49,1,1),
(2894,278402,0.73,1,1),
(2927,221359,1.31,1,1),
(2928,221359,1.49,1,1),
(2929,221359,1.14,1,1),
(4323,279934,2.1,1,1),
(4324,279934,1.7,1,1),
(4329,279934,2.99,1,1),
(4331,279934,1.61,1,1),
(4357,279601,22.22,1,1),
(4392,280203,19.36,1,1),
(4467,254078,0.75,1,1),
(4467,279225,9.77,1,1),
(5232,251464,2.04,1,1),
(5245,221361,1.33,1,1),
(5246,221361,4.62,1,1),
(5247,221361,1.21,1,1),
(5297,254094,3.45,1,1),
(5616,264215,1.06,1,1),
(5846,252859,1.59,1,1),
(6195,280608,5.71,1,1),
(6199,274966,3.33,1,1),
(6505,280459,1.54,1,1),
(6506,280459,2.94,1,1),
(7030,264213,3.7,1,1),
(7267,254100,2.08,1,1),
(7271,251403,4.35,1,1),
(7271,251404,2.17,1,1),
(7271,252868,4.35,1,1),
(7271,252869,2.17,1,1),
(7271,277112,32.61,1,1),
(7272,251403,1.61,1,1),
(7797,252918,1.96,1,1),
(7797,252919,1.96,1,1),
(7797,254100,1.96,1,1),
(8127,251403,2.17,1,1),
(8127,251405,2.17,1,1),
(8127,252869,2.17,1,1),
(8127,252870,2.17,1,1),
(8960,277959,37.93,1,1),
(9164,280459,10.0,1,1),
(11561,254663,0.64,1,1),
(12225,251405,8.7,1,1),
(12225,254098,4.35,1,1),
(12225,274964,4.35,1,1),
(12236,274964,4.55,1,1),
(12258,254100,4.55,1,1),
(13282,254100,4.76,1,1),
(254560,266427,0.8,1,1),
(255851,268632,24.76,1,1),
(255901,268632,3.5,1,1),
(256798,266427,1.9,1,1),
(256799,265821,46.45,1,1),
(256807,268632,14.91,1,1),
(256952,266148,4.86,1,1),
(256952,266427,1.64,1,1),
(258331,268632,28.77,1,1),
(259046,268632,9.52,1,1),
(259267,268632,1.26,1,1),
(259269,268632,14.52,1,1),
(260211,268581,89.74,1,1),
(260235,268632,9.2,1,1),
(262037,268632,2.5,1,1),
(262397,270305,38.82,1,1),
(263343,268632,7.71,1,1),
(263348,268632,8.55,1,1),
(263380,268632,4.05,1,1),
(268831,268632,37.1,1,1),
(269175,256036,14.53,1,1),
(269175,256037,81.29,1,1);
UPDATE `creature_template_difficulty` `d` SET `d`.`LootID`=`d`.`Entry` WHERE `d`.`DifficultyID`=0 AND `d`.`LootID`=0
  AND `d`.`Entry` IN (SELECT `Entry` FROM `forever_drops_1115`)
  AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` `l` WHERE `l`.`Entry`=`d`.`Entry`);
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`)
SELECT `s`.`Entry`,0,`s`.`Item`,`s`.`Chance`,0,1,0,`s`.`MinCount`,`s`.`MaxCount`,'Everlake data: Icy Veins Forever' FROM `forever_drops_1115` `s`
JOIN `creature_template_difficulty` `d` ON `d`.`Entry`=`s`.`Entry` AND `d`.`DifficultyID`=0 AND `d`.`LootID`=`s`.`Entry`
WHERE NOT EXISTS (SELECT 1 FROM `creature_loot_template` `x` WHERE `x`.`Entry`=`s`.`Entry` AND `x`.`ItemType`=0 AND `x`.`Item`=`s`.`Item`)
  AND NOT EXISTS (SELECT 1 FROM `creature_template_difficulty` `o` WHERE `o`.`LootID`=`s`.`Entry` AND `o`.`Entry`<>`s`.`Entry`);
DROP TEMPORARY TABLE IF EXISTS `forever_drops_1115`;

-- 2. Herb, chest and node loot seen on live that ours lacks: 19 rows (Icy Veins chances). The entry is the loot id the objects
--    use (herbs: the Forever bonus herb items 268416-268418; Construct Parts 260927; Dented Chest 252023; Bundle of Wood 271629;
--    Purple Berry Bush 278029).
DELETE FROM `gameobject_loot_template` WHERE `ItemType`=0 AND (`Entry`,`Item`) IN ((1417,268416),(1418,268416),(1419,268416),(1420,268416),(1421,268416),(1423,268417),(1424,268416),(1730,268417),(1731,268417),(1733,268416),(1734,268418),(6142,268418),(6152,268418),(137445,260927),(137455,260927),(137456,260927),(139192,252023),(140476,271629),(142369,278029));
INSERT INTO `gameobject_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(1417,0,268416,1.16,0,1,0,1,1,'Everlake data: Icy Veins Forever') /* Mageroyal */,
(1418,0,268416,1.24,0,1,0,1,1,'Everlake data: Icy Veins Forever') /* Briarthorn */,
(1419,0,268416,1.14,0,1,0,1,1,'Everlake data: Icy Veins Forever') /* Bruiseweed */,
(1420,0,268416,1.04,0,1,0,1,1,'Everlake data: Icy Veins Forever') /* Wild Steelbloom */,
(1421,0,268416,2.38,0,1,0,1,1,'Everlake data: Icy Veins Forever') /* Kingsblood */,
(1423,0,268417,0.45,0,1,0,1,1,'Everlake data: Icy Veins Forever') /* Khadgar's Whisker */,
(1424,0,268416,1.28,0,1,0,1,1,'Everlake data: Icy Veins Forever') /* Grave Moss */,
(1730,0,268417,1.11,0,1,0,1,1,'Everlake data: Icy Veins Forever') /* Liferoot */,
(1731,0,268417,1.2,0,1,0,1,1,'Everlake data: Icy Veins Forever') /* Fadeleaf */,
(1733,0,268416,0.84,0,1,0,1,1,'Everlake data: Icy Veins Forever') /* Stranglekelp */,
(1734,0,268418,1.18,0,1,0,1,1,'Everlake data: Icy Veins Forever') /* Goldthorn */,
(6142,0,268418,1.61,0,1,0,1,1,'Everlake data: Icy Veins Forever') /* Purple Lotus */,
(6152,0,268418,1.37,0,1,0,1,1,'Everlake data: Icy Veins Forever') /* Blindweed */,
(137445,0,260927,24.75,0,1,0,1,1,'Everlake data: Icy Veins Forever') /* Construct Parts */,
(137455,0,260927,24.82,0,1,0,1,1,'Everlake data: Icy Veins Forever') /* Construct Parts */,
(137456,0,260927,24.58,0,1,0,1,1,'Everlake data: Icy Veins Forever') /* Construct Parts */,
(139192,0,252023,18.59,0,1,0,1,1,'Everlake data: Icy Veins Forever') /* Dented Chest */,
(140476,0,271629,68.59,0,1,0,1,1,'Everlake data: Icy Veins Forever') /* Bundle of Wood */,
(142369,0,278029,100.0,0,1,0,1,1,'Everlake data: Icy Veins Forever') /* Purple Berry Bush */;

-- 3. Items live vendors sell that ours lack, 4 rows (Icy Veins vendor windows): Aurian Highgrove (265346, bartender) and Bhalir
--    Firebrew (265347, chef). Bought with money. Left out: Lady Palanseer and Blazik Fireclaw (rank and arena gear needs its own
--    costs) and Kerelle (255705, not a vendor in our live capture).
DELETE FROM `npc_vendor` WHERE `ExtendedCost`=0 AND `type`=1 AND (`entry`,`item`) IN ((265346,274616),(265347,278118),(265347,278120),(265347,278122));
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(265346,7,274616,0,0,0,1,0,0,0),
(265347,7,278118,0,0,0,1,0,0,0),
(265347,8,278120,0,0,0,1,0,0,0),
(265347,9,278122,0,0,0,1,0,0,0);

-- 4. Turn-ins for 4 quests that had none in ours: the NPC the quest's own text sends the player to (Wowhead Forever).
--    5659 Touch of Weakness: Aelthalyste (4606); 5383 Krastinov's Bag of Horrors: Eva Sarkhoff (11216); 8290 Vanquish the
--    Invaders: Sentinel Farsong (14733); 8295 Quell the Silverwing Usurpers: Captain Shatterskull (14781).
DELETE FROM `creature_questender` WHERE (`id`,`quest`) IN ((4606,5659),(11216,5383),(14733,8290),(14781,8295));
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (4606,5659,0),(11216,5383,0),(14733,8290,0),(14781,8295,0);
