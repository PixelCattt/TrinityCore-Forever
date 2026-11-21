-- WoW Forever fixes and live drops from Everlake's world data, picked on 19 Nov: only what our world lacked or had wrong.
-- From Everlake's world data (buildthehomelab/wow-everlake-world-data, main 831178c, GPL-3.0): its files of 18 Nov (924 Kobold
-- Tracks, 925 spawn heights, 932 Azshara, Forge exports 43 and 44 with Wowhead's WoW Forever drop chances, www.wowhead.com/forever).
-- Not their files: each fix was checked against our world and written here as our own rows. Safe to run more than once.

-- 1. Kobold Tracks (563442) for "Shhh! We're Hunting Kobolds" (91772): one track gave credit again after it closed (3 seconds),
--    so a player could click the same track six times. Consumable and Allow Multi-Interact make the clicked track disappear for
--    that player only (GameObject::Use, goober: DespawnForPlayer for the spawn's respawn time); it stays up for everyone else.
UPDATE `gameobject_template` SET `Data5`=1, `Data20`=1 WHERE `entry`=563442 AND `type`=10 AND `Data5`=0 AND `Data20`=0;

-- 2. Creatures of our restored Forever quest data (2026_11_05_99) that stood in the ground under a floor (a house, deck or platform):
--    their height was the bare terrain's. Moved up onto the surface above them, as Everlake's height audit read it from the maps and
--    vmaps (36 creatures, each with at least 2.5 yards free above the new height; for example Sentinel Selarin 3694 in Auberdine).
--    A row changes only while it still has the old height.
UPDATE `creature` SET `position_z`=64.76 WHERE `guid`=18533300 AND `id`=185333 AND `map`=0 AND ABS(`position_z`-63.711)<0.01;
UPDATE `creature` SET `position_z`=43.86 WHERE `guid`=24826500 AND `id`=248265 AND `map`=0 AND ABS(`position_z`-42.406)<0.01;
UPDATE `creature` SET `position_z`=66.71 WHERE `guid`=24877900 AND `id`=248779 AND `map`=0 AND ABS(`position_z`-65.543)<0.01;
UPDATE `creature` SET `position_z`=34.77 WHERE `guid`=25309200 AND `id`=253092 AND `map`=0 AND ABS(`position_z`-33.06)<0.01;
UPDATE `creature` SET `position_z`=4.4 WHERE `guid`=25589001 AND `id`=255890 AND `map`=0 AND ABS(`position_z`-3.599)<0.01;
UPDATE `creature` SET `position_z`=7.12 WHERE `guid`=25589400 AND `id`=255894 AND `map`=0 AND ABS(`position_z`-4.828)<0.01;
UPDATE `creature` SET `position_z`=5.01 WHERE `guid`=25589500 AND `id`=255895 AND `map`=0 AND ABS(`position_z`-3.787)<0.01;
UPDATE `creature` SET `position_z`=24.47 WHERE `guid`=25667500 AND `id`=256675 AND `map`=0 AND ABS(`position_z`-22.638)<0.01;
UPDATE `creature` SET `position_z`=25.17 WHERE `guid`=25684001 AND `id`=256840 AND `map`=0 AND ABS(`position_z`-23.45)<0.01;
UPDATE `creature` SET `position_z`=39.72 WHERE `guid`=25759500 AND `id`=257595 AND `map`=0 AND ABS(`position_z`-38.51)<0.01;
UPDATE `creature` SET `position_z`=40.71 WHERE `guid`=25775400 AND `id`=257754 AND `map`=0 AND ABS(`position_z`-39.132)<0.01;
UPDATE `creature` SET `position_z`=166.65 WHERE `guid`=25868605 AND `id`=258686 AND `map`=0 AND ABS(`position_z`-165.663)<0.01;
UPDATE `creature` SET `position_z`=36.99 WHERE `guid`=25904900 AND `id`=259049 AND `map`=0 AND ABS(`position_z`-36.138)<0.01;
UPDATE `creature` SET `position_z`=40.04 WHERE `guid`=25986100 AND `id`=259861 AND `map`=0 AND ABS(`position_z`-38.507)<0.01;
UPDATE `creature` SET `position_z`=5.99 WHERE `guid`=25996200 AND `id`=259962 AND `map`=0 AND ABS(`position_z`-5.106)<0.01;
UPDATE `creature` SET `position_z`=3.36 WHERE `guid`=26056500 AND `id`=260565 AND `map`=0 AND ABS(`position_z`-2.515)<0.01;
UPDATE `creature` SET `position_z`=62.7 WHERE `guid`=26203702 AND `id`=262037 AND `map`=0 AND ABS(`position_z`-60.994)<0.01;
UPDATE `creature` SET `position_z`=6.08 WHERE `guid`=26312000 AND `id`=263120 AND `map`=0 AND ABS(`position_z`-4.828)<0.01;
UPDATE `creature` SET `position_z`=24.47 WHERE `guid`=26319000 AND `id`=263190 AND `map`=0 AND ABS(`position_z`-22.638)<0.01;
UPDATE `creature` SET `position_z`=2.73 WHERE `guid`=26332600 AND `id`=263326 AND `map`=0 AND ABS(`position_z`-1.869)<0.01;
UPDATE `creature` SET `position_z`=2.73 WHERE `guid`=26338400 AND `id`=263384 AND `map`=0 AND ABS(`position_z`-1.876)<0.01;
UPDATE `creature` SET `position_z`=41.0 WHERE `guid`=26361300 AND `id`=263613 AND `map`=0 AND ABS(`position_z`-39.812)<0.01;
UPDATE `creature` SET `position_z`=54.02 WHERE `guid`=26621602 AND `id`=266216 AND `map`=0 AND ABS(`position_z`-52.441)<0.01;
UPDATE `creature` SET `position_z`=39.36 WHERE `guid`=26968303 AND `id`=269683 AND `map`=0 AND ABS(`position_z`-38.513)<0.01;
UPDATE `creature` SET `position_z`=39.36 WHERE `guid`=26968800 AND `id`=269688 AND `map`=0 AND ABS(`position_z`-38.513)<0.01;
UPDATE `creature` SET `position_z`=39.49 WHERE `guid`=26969900 AND `id`=269699 AND `map`=0 AND ABS(`position_z`-38.513)<0.01;
UPDATE `creature` SET `position_z`=61.29 WHERE `guid`=27057100 AND `id`=270571 AND `map`=0 AND ABS(`position_z`-60.329)<0.01;
UPDATE `creature` SET `position_z`=39.65 WHERE `guid`=27057200 AND `id`=270572 AND `map`=0 AND ABS(`position_z`-38.513)<0.01;
UPDATE `creature` SET `position_z`=39.69 WHERE `guid`=27100500 AND `id`=271005 AND `map`=0 AND ABS(`position_z`-38.336)<0.01;
UPDATE `creature` SET `position_z`=39.75 WHERE `guid`=27100600 AND `id`=271006 AND `map`=0 AND ABS(`position_z`-38.513)<0.01;
UPDATE `creature` SET `position_z`=4.7 WHERE `guid`=27231502 AND `id`=272315 AND `map`=0 AND ABS(`position_z`-1.793)<0.01;
UPDATE `creature` SET `position_z`=93.33 WHERE `guid`=27242000 AND `id`=272420 AND `map`=0 AND ABS(`position_z`-90.916)<0.01;
UPDATE `creature` SET `position_z`=212.38 WHERE `guid`=27291400 AND `id`=272914 AND `map`=0 AND ABS(`position_z`-211.35)<0.01;
UPDATE `creature` SET `position_z`=13.94 WHERE `guid`=369400 AND `id`=3694 AND `map`=1 AND ABS(`position_z`-11.481)<0.01;
UPDATE `creature` SET `position_z`=132.41 WHERE `guid`=25428401 AND `id`=254284 AND `map`=1 AND ABS(`position_z`-130.299)<0.01;
UPDATE `creature` SET `position_z`=1330.36 WHERE `guid`=27574402 AND `id`=275744 AND `map`=1 AND ABS(`position_z`-1328.55)<0.01;

-- 3. Azuregos's Magical Ledger (8575): the Spirit of Azuregos (15481) waited for a choice on gossip menu 15012 (VMaNGOS's id), which
--    our world does not have; its talk runs 6627 -> 15002 -> 15003 -> 15004 -> 15005. So nobody got the ledger (item 20949, made by
--    spell 25600). Now the last choice (menu 15004, option 0) makes the player cast 25600 on themselves (triggered), so the item
--    lands in the player's bags; the talk still opens 15005. The conditions on option 6627/0 (did 8555, not done 8575, no ledger)
--    stay. Only changed while the rows are still the imported ones.
UPDATE `smart_scripts` SET `event_param1`=15004, `event_param2`=0, `link`=0, `action_type`=85, `action_param1`=25600, `action_param2`=2,
  `action_param3`=0, `target_type`=7, `comment`='Spirit of Azuregos - On gossip 15004/0 - Invoker casts 25600 (Magical Ledger 20949)'
WHERE `entryorguid`=15481 AND `source_type`=0 AND `id`=0 AND `event_type`=62 AND `event_param1`=15012 AND `action_type`=72;
DELETE FROM `smart_scripts` WHERE `entryorguid`=15481 AND `source_type`=0 AND `id`=1 AND `event_type`=61 AND `action_type`=80 AND `action_param1`=950000539;

-- 4. Love is in the Air: the Pledge of Adoration boxes from Stormwind (21975), Darnassus (22155) and Undercity (22157) did not hold
--    the guard's card their quests ask for (22143, 22140, 22145; quests 8903, 8904, 8971, 8973, 8974). Chances as Wowhead measured
--    on live, only while the quest needs it. The same cards are in these boxes in cmangos classic-db (GPL-2.0).
DELETE FROM `item_loot_template` WHERE (`Entry`,`ItemType`,`Item`) IN ((21975,0,22143),(22155,0,22140),(22157,0,22145));
INSERT INTO `item_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(21975,0,22143,47.92,1,1,0,1,1,'Everlake data: Wowhead Forever'),
(22155,0,22140,46.67,1,1,0,1,1,'Everlake data: Wowhead Forever'),
(22157,0,22145,46.11,1,1,0,1,1,'Everlake data: Wowhead Forever');

-- 5. Creature drops seen on live that ours lacks: 28 rows on 28 creatures (Forever recipes, patterns, schematics and blueprints, a
--    few pieces of gear, the Tiny Azure Whelpling). Only spawned creatures, items the client has, not quest items for quests we
--    lack, and only where the creature's own loot (or its reference tables) does not already hold the item. A row goes in only
--    where the creature's loot id is its own entry (or not set yet; then it is set), so no other creature's loot changes.
DROP TEMPORARY TABLE IF EXISTS `forever_drops_1119`;
CREATE TEMPORARY TABLE `forever_drops_1119` (`Entry` INT UNSIGNED NOT NULL, `Item` INT UNSIGNED NOT NULL, `Chance` FLOAT NOT NULL, `QuestRequired` TINYINT UNSIGNED NOT NULL, `MinCount` TINYINT UNSIGNED NOT NULL, `MaxCount` TINYINT UNSIGNED NOT NULL, PRIMARY KEY (`Entry`,`Item`));
INSERT INTO `forever_drops_1119` (`Entry`,`Item`,`Chance`,`QuestRequired`,`MinCount`,`MaxCount`) VALUES
(1809,252880,1.89,0,1,1),
(1831,252881,0.67,0,1,1),
(2640,250992,0.95,0,1,1),
(5243,234728,0.45,0,1,1),
(5261,234728,0.47,0,1,1),
(5262,252916,0.93,0,1,1),
(7037,264223,1.2,0,1,1),
(7372,264225,1.11,0,1,1),
(7379,252936,7.14,0,1,1),
(7434,250180,3.03,0,1,1),
(8205,286570,9.09,0,1,1),
(8277,282568,7.14,0,1,1),
(8283,282094,5.88,0,1,1),
(8527,264226,0.64,0,1,1),
(8534,252885,3.33,0,1,1),
(8597,252935,2.22,0,1,1),
(9156,273122,0.9,0,1,1),
(10366,284587,0.47,0,1,1),
(10425,252937,3.85,0,1,1),
(10426,264230,0.59,0,1,1),
(10432,273121,5.88,0,1,1),
(10438,284587,0.53,0,1,1),
(10499,252940,8.33,0,1,1),
(10508,273112,2.04,0,1,1),
(10659,268503,2.44,0,1,1),
(10660,268503,2.94,0,1,1),
(11291,252934,1.96,0,1,1),
(14231,285283,4.76,0,1,1);
UPDATE `creature_template_difficulty` `d` SET `d`.`LootID`=`d`.`Entry` WHERE `d`.`DifficultyID`=0 AND `d`.`LootID`=0
  AND `d`.`Entry` IN (SELECT `Entry` FROM `forever_drops_1119`)
  AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` `l` WHERE `l`.`Entry`=`d`.`Entry`);
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`)
SELECT `s`.`Entry`,0,`s`.`Item`,`s`.`Chance`,`s`.`QuestRequired`,1,0,`s`.`MinCount`,`s`.`MaxCount`,'Everlake data: Wowhead Forever' FROM `forever_drops_1119` `s`
JOIN `creature_template_difficulty` `d` ON `d`.`Entry`=`s`.`Entry` AND `d`.`DifficultyID`=0 AND `d`.`LootID`=`s`.`Entry`
WHERE NOT EXISTS (SELECT 1 FROM `creature_loot_template` `x` WHERE `x`.`Entry`=`s`.`Entry` AND `x`.`ItemType`=0 AND `x`.`Item`=`s`.`Item`)
  AND NOT EXISTS (SELECT 1 FROM `creature_template_difficulty` `o` WHERE `o`.`LootID`=`s`.`Entry` AND `o`.`Entry`<>`s`.`Entry`);
DROP TEMPORARY TABLE IF EXISTS `forever_drops_1119`;
