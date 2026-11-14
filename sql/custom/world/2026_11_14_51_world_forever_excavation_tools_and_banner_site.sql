-- Two Loch Modan Forever quests from Discord "bugs 4" (2026-11-13). Taken from SIN's fix pack for 0.1.36 and written again
-- here. Safe to run again.

-- Excavation Tools (86613): its starter item 278049 lies in the Excavation Tools chests (665282) at 30%, from Wowhead Forever's
-- "contains 3/10", where most openers were already on the quest and so could not get it. Patch 0093 lets a player who can take
-- the quest open the chest; at 30% such a player still found it empty seven times in ten. The starter is only handed to a player
-- who can take the quest and does not carry it, so it now drops every time for them. INFERRED (no live rate for those players).
-- The quest item 278398 (6 needed, 9 chests) keeps its 70%.
UPDATE `gameobject_loot_template` SET `Chance` = 100
WHERE `Entry` = 665282 AND `Item` = 278049 AND `QuestRequired` = 0 AND `Chance` = 30;

-- Banner of the Fallen (86585, patch 0097): raising the Ironforge standard (spell 1303317) needs spell focus 2311 nearby, and
-- nothing in the world had it, so the standard could not be raised. A spell focus object now stands at Mountaineer Ylva
-- (269153, spawn 26915300), where the quest is given; it copies the South Gate Snow focus (8380007) with focus 2311.
-- INFERRED: the place (the quest says to raise the banner near her). Headsplitter keeps his two spawns beside her.
DELETE FROM `gameobject` WHERE `guid` = 838000800;
DELETE FROM `gameobject_template` WHERE `entry` = 8380008;
DROP TEMPORARY TABLE IF EXISTS `tmp_forever_banner_site`;
CREATE TEMPORARY TABLE `tmp_forever_banner_site` AS SELECT * FROM `gameobject_template` WHERE `entry` = 8380007;
UPDATE `tmp_forever_banner_site` SET `entry` = 8380008, `name` = 'Ironforge Banner Site (spell focus)', `Data0` = 2311;
INSERT INTO `gameobject_template` SELECT * FROM `tmp_forever_banner_site`;
DROP TEMPORARY TABLE `tmp_forever_banner_site`;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`,`ScriptName`,`StringId`,`VerifiedBuild`)
SELECT 838000800,8380008,0,0,0,'0',0,0,0,-1,`position_x`,`position_y`,`position_z`,0,0,0,0,1,300,255,1,'',NULL,0
FROM `creature` WHERE `guid` = 26915300 AND `id` = 269153 AND EXISTS (SELECT 1 FROM `gameobject_template` WHERE `entry` = 8380008);
