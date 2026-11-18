-- WoW Forever live realm: English capture from 2026-11-16 22:17 (client 70938), map 2991 around Zephras. Only what our data
-- lacks or has wrong. Safe to run more than once. No new spawns. Goes on top of 2026_11_16_58.

-- 1. Galemender Delanea 259398: live faction 3578 (ours 14, hostile) and the staff live shows.
UPDATE `creature_template` SET `faction` = 3578 WHERE `entry` = 259398;
DELETE FROM `creature_equip_template` WHERE `ID` = 1 AND `CreatureID` = 259398;
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `AppearanceModID1`, `ItemVisual1`, `ItemID2`, `AppearanceModID2`, `ItemVisual2`, `ItemID3`, `AppearanceModID3`, `ItemVisual3`, `VerifiedBuild`) VALUES (259398, 1, 249392, 0, 0, 0, 0, 0, 0, 0, 0, 70938);
UPDATE `creature` SET `equipment_id` = 1 WHERE `equipment_id` = 0 AND `id` = 259398;

-- 2. Nyalah Brightfire 257006 works standing live (emote state 69).
DELETE FROM `creature_addon` WHERE `guid` = 21101592;
INSERT INTO `creature_addon` (`guid`, `emote`) VALUES (21101592, 69);

-- 3. Spell focus 652589 is named Cookpot live (ours had the model file name).
UPDATE `gameobject_template` SET `name` = 'Cookpot' WHERE `entry` = 652589;

-- 4. Windsong Crawler 254588: 5 more kills, so the sniff counts become n of 23 (4562 is new). Realm drop log rows stay.
DELETE FROM `creature_loot_template` WHERE `Entry` = 254588 AND `ItemType` = 0 AND `Item` IN (1416, 1417, 2213, 2675, 4562, 4873, 4874, 5571, 8181, 211787, 257941);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES (254588, 0, 1416, 4.35, 0, 1, 0, 1, 1, 'sniff: 1 of 23 kills'), (254588, 0, 1417, 4.35, 0, 1, 0, 1, 1, 'sniff: 1 of 23 kills'), (254588, 0, 2213, 4.35, 0, 1, 0, 1, 1, 'sniff: 1 of 23 kills'), (254588, 0, 2675, 34.78, 0, 1, 0, 1, 1, 'sniff: 8 of 23 kills'), (254588, 0, 4562, 4.35, 0, 1, 0, 1, 1, 'sniff: 1 of 23 kills'), (254588, 0, 4873, 56.52, 0, 1, 0, 1, 1, 'sniff: 13 of 23 kills'), (254588, 0, 4874, 43.48, 0, 1, 0, 1, 1, 'sniff: 10 of 23 kills'), (254588, 0, 5571, 4.35, 0, 1, 0, 1, 1, 'sniff: 1 of 23 kills'), (254588, 0, 8181, 4.35, 0, 1, 0, 1, 1, 'sniff: 1 of 23 kills'), (254588, 0, 211787, 4.35, 0, 1, 0, 1, 1, 'sniff: 1 of 23 kills'), (254588, 0, 257941, 56.52, 1, 1, 0, 1, 1, 'sniff: 13 of 23 kills');
