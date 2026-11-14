-- Two Sulhasas side by side south of Camp Taurajo (Discord, 6_1_8_8_1, 2026-11-14, 0.1.36). Two imports placed the same Forever
-- NPCs from the same map pins: 2026_10_30_10 (our quest giver spawns, guids 46000000-46000999, made because our data had none)
-- and 2026_11_05_99 (the restored Forever quest data, which brought those NPCs back with their own spawns). Since 0.1.30 both are
-- in the world, so Sulhasa, the Legging It spiders, the Elwynn and Dun Morogh quest NPCs and others stand twice, 0-40 yd apart.
-- Each spawn of ours goes only while another spawn of the same creature stands within 40 yards of it on the same map, so a world
-- DB without the restored spawns keeps ours (the Whispering Horror crypt pool of 2026_11_12_36 has no such partner and stays).
-- Safe to run again.
-- Sulhasa is the one case where the restored copy is the wrong one: EG Link saw players talk to her 2-6 yd from ours (46000000,
-- -3630 -2231) and 12-23 yd from the restored copy (1424200, 10 yd north), so that copy goes first and ours stays.
-- (Data from Efficient Games (https://efficient.games), licensed under CC BY 4.0, npcs 70862.)
DELETE `restored` FROM `creature` `restored`
JOIN `creature` `ours` ON `ours`.`guid` = 46000000 AND `ours`.`id` = 14242
WHERE `restored`.`guid` = 1424200 AND `restored`.`id` = 14242;
DELETE FROM `creature_addon` WHERE `guid` = 1424200 AND NOT EXISTS (SELECT 1 FROM `creature` WHERE `guid` = 1424200);

DROP TEMPORARY TABLE IF EXISTS `tmp_dup_46`;
CREATE TEMPORARY TABLE `tmp_dup_46` (`guid` BIGINT UNSIGNED NOT NULL PRIMARY KEY);
INSERT IGNORE INTO `tmp_dup_46` (`guid`)
SELECT `ours`.`guid` FROM `creature` `ours`
JOIN `creature` `other` ON `other`.`id` = `ours`.`id` AND `other`.`map` = `ours`.`map`
    AND `other`.`guid` NOT BETWEEN 46000000 AND 46000999
    AND (`other`.`position_x` - `ours`.`position_x`) * (`other`.`position_x` - `ours`.`position_x`)
      + (`other`.`position_y` - `ours`.`position_y`) * (`other`.`position_y` - `ours`.`position_y`) < 40 * 40
WHERE `ours`.`guid` BETWEEN 46000000 AND 46000999;

DELETE FROM `creature_addon` WHERE `guid` IN (SELECT `guid` FROM `tmp_dup_46`);
DELETE FROM `pool_members` WHERE `type` = 0 AND `spawnId` IN (SELECT `guid` FROM `tmp_dup_46`);
DELETE FROM `spawn_group` WHERE `spawnType` = 0 AND `spawnId` IN (SELECT `guid` FROM `tmp_dup_46`);
DELETE FROM `creature` WHERE `guid` IN (SELECT `guid` FROM `tmp_dup_46`);
DROP TEMPORARY TABLE `tmp_dup_46`;
