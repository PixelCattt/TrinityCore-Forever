-- WoW Forever live drops from Everlake's world data, picked on 16 Nov, plus a Hallow's End link: only what our world lacked.
-- From Everlake's world data (buildthehomelab/wow-everlake-world-data, GPL-3.0), its exports 27 and 28: Wowhead's WoW Forever
-- database (quest item drops) and Icy Veins' WoW Forever database (recipe drops, with the chances its players' addons measured
-- on live Forever). Not their files: their rows were compared with ours and only what we lack is written here as our own rows.
-- Safe to run more than once.

-- 1. Creature drops seen on live that ours lacks: 72 recipe drops (Icy Veins) and 5 quest item drops (Wowhead) on 60 creatures.
--    Only spawned creatures, items the client has, quest items only for a quest objective we have, and only where the
--    creature's own loot (or its reference tables) does not already hold the item. A row goes in only where the creature's
--    loot id is its own entry (or not set yet; then it is set), so no other creature's loot changes.
DROP TEMPORARY TABLE IF EXISTS `forever_drops_1116`;
CREATE TEMPORARY TABLE `forever_drops_1116` (`Entry` INT UNSIGNED NOT NULL, `Item` INT UNSIGNED NOT NULL, `Chance` FLOAT NOT NULL, `QuestRequired` TINYINT UNSIGNED NOT NULL, `MinCount` TINYINT UNSIGNED NOT NULL, `MaxCount` TINYINT UNSIGNED NOT NULL, PRIMARY KEY (`Entry`,`Item`));
INSERT INTO `forever_drops_1116` (`Entry`,`Item`,`Chance`,`QuestRequired`,`MinCount`,`MaxCount`) VALUES
(1784,252930,2.42,0,1,1),
(1852,17114,1.19,1,1,1),
(2552,254014,0.52,0,1,1),
(2653,251396,0.7,0,1,1),
(2720,249512,2.04,0,1,1),
(2748,251406,0.37,0,1,1),
(2748,254106,0.37,0,1,1),
(4334,254684,2.86,0,1,1),
(4658,254681,1.92,0,1,1),
(4684,250363,0.69,0,1,1),
(5296,252909,1.28,0,1,1),
(5333,254686,1.4,0,1,1),
(5363,250986,1.43,0,1,1),
(5709,251407,1.92,0,1,1),
(5710,251406,3.7,0,1,1),
(5710,254102,1.85,0,1,1),
(5715,254106,5.0,0,1,1),
(5839,264214,0.46,0,1,1),
(5856,254685,1.34,0,1,1),
(6005,252883,2.97,0,1,1),
(6116,252858,2.47,0,1,1),
(6117,251438,1.11,0,1,1),
(6126,254074,2.48,0,1,1),
(6195,252932,0.99,0,1,1),
(6198,252929,0.66,0,1,1),
(6199,251441,1.03,0,1,1),
(6520,252882,2.27,0,1,1),
(7108,251442,2.44,0,1,1),
(7115,252926,0.74,0,1,1),
(7139,254126,2.33,0,1,1),
(7153,252866,0.98,0,1,1),
(7154,249514,1.68,0,1,1),
(7155,251440,1.28,0,1,1),
(7158,252865,2.19,0,1,1),
(7267,251406,1.05,0,1,1),
(7267,251407,0.7,0,1,1),
(7267,252867,0.7,0,1,1),
(7267,254102,0.7,0,1,1),
(7267,254106,0.35,0,1,1),
(7271,254102,0.32,0,1,1),
(7271,254106,0.64,0,1,1),
(7440,252890,3.43,0,1,1),
(7797,251407,0.36,0,1,1),
(7797,254102,0.36,0,1,1),
(8127,251406,0.38,0,1,1),
(8127,251407,1.52,0,1,1),
(8519,17309,24.24,1,1,1),
(8520,17309,23.63,1,1,1),
(8521,17309,47.83,1,1,1),
(8522,17309,46.95,1,1,1),
(8566,251439,1.4,0,1,1),
(8600,251444,3.33,0,1,1),
(8602,250175,9.09,0,1,1),
(8893,251467,1.64,0,1,1),
(9018,252867,3.03,0,1,1),
(9018,254102,3.03,0,1,1),
(9024,252867,3.7,0,1,1),
(9318,252915,2.14,0,1,1),
(9502,252867,4.55,0,1,1),
(9543,251407,4.55,0,1,1),
(9543,254102,4.55,0,1,1),
(9862,264228,5.66,0,1,1),
(9878,252879,2.5,0,1,1),
(12201,251407,0.81,0,1,1),
(12203,252867,1.79,0,1,1),
(12203,254106,1.79,0,1,1),
(12225,251407,0.96,0,1,1),
(12225,254102,0.96,0,1,1),
(12225,254106,0.96,0,1,1),
(12236,254106,0.86,0,1,1),
(12258,251407,0.91,0,1,1),
(13596,252867,0.9,0,1,1),
(13596,254102,0.9,0,1,1),
(13596,254106,1.8,0,1,1),
(13601,252867,1.15,0,1,1),
(13601,254106,1.15,0,1,1),
(249229,284871,1.45,0,1,1);
UPDATE `creature_template_difficulty` `d` SET `d`.`LootID`=`d`.`Entry` WHERE `d`.`DifficultyID`=0 AND `d`.`LootID`=0
  AND `d`.`Entry` IN (SELECT `Entry` FROM `forever_drops_1116`)
  AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` `l` WHERE `l`.`Entry`=`d`.`Entry`);
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`)
SELECT `s`.`Entry`,0,`s`.`Item`,`s`.`Chance`,`s`.`QuestRequired`,1,0,`s`.`MinCount`,`s`.`MaxCount`,IF(`s`.`QuestRequired`=1,'Everlake data: Wowhead Forever','Everlake data: Icy Veins Forever') FROM `forever_drops_1116` `s`
JOIN `creature_template_difficulty` `d` ON `d`.`Entry`=`s`.`Entry` AND `d`.`DifficultyID`=0 AND `d`.`LootID`=`s`.`Entry`
WHERE NOT EXISTS (SELECT 1 FROM `creature_loot_template` `x` WHERE `x`.`Entry`=`s`.`Entry` AND `x`.`ItemType`=0 AND `x`.`Item`=`s`.`Item`)
  AND NOT EXISTS (SELECT 1 FROM `creature_template_difficulty` `o` WHERE `o`.`LootID`=`s`.`Entry` AND `o`.`Entry`<>`s`.`Entry`);
DROP TEMPORARY TABLE IF EXISTS `forever_drops_1116`;

-- 2. Southshore Stink Bomb Counter (15415) belongs to Hallow's End (event 12, as in cmangos classic-db) but was in no event,
--    so it stood all year.
INSERT INTO `game_event_creature` (`eventEntry`,`guid`)
SELECT 12,`c`.`guid` FROM `creature` `c` WHERE `c`.`id`=15415 AND `c`.`map`=0
  AND NOT EXISTS (SELECT 1 FROM `game_event_creature` `g` WHERE `g`.`guid`=`c`.`guid`);
