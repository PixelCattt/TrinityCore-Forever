-- Sentinel Lynessa Duskblossom (275744), Teldrassil: SIN's fix (his Forever Bots 0.1.35 pack "Ban'ethil Barrow Den spawn
-- fix", apply.sql, Karrz 2026-11-16: swap to his). Her three-spot pool 1302288 as it was in 0.1.35 (2026_11_05_99), with spot
-- 27574402 moved to the floor a player picked in game (9870.52, 1557.70, 1329.29, facing 5.34).
-- Only what is needed to run here: our 0.1.36 file 2026_11_12_25 deleted spots 27574401/27574402, moved 27574400 down into the
-- den and dropped the pool. Those rows come back first exactly as 2026_11_05_99 had them; then his file runs unchanged.
DELETE FROM `pool_members` WHERE `type` = 0 AND `spawnId` IN (27574400,27574401,27574402);
DELETE FROM `pool_template` WHERE `entry` = 1302288;
DELETE FROM `creature` WHERE `guid` IN (27574400,27574401,27574402) AND `id` = 275744;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(27574400,275744,1,0,0,'0',0,0,0,-1,0,0,10008.8e0,1620.07e0,1326.42e0,0.0e0,300,0.0e0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0),
(27574401,275744,1,0,0,'0',0,0,0,-1,0,0,9988.44e0,1584.43e0,1319.07e0,0.0e0,300,0.0e0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0),
(27574402,275744,1,0,0,'0',0,0,0,-1,0,0,9869.66e0,1558.97e0,1328.55e0,0.0e0,300,0.0e0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0);
INSERT INTO `pool_template` (`entry`,`max_limit`,`description`) VALUES (1302288,1,'Sentinel Lynessa Duskblossom - one of three spots');
INSERT INTO `pool_members` (`type`,`spawnId`,`poolSpawnId`,`chance`,`description`) VALUES
(0,27574400,1302288,0.0e0,'Sentinel Lynessa Duskblossom'),
(0,27574401,1302288,0.0e0,'Sentinel Lynessa Duskblossom'),
(0,27574402,1302288,0.0e0,'Sentinel Lynessa Duskblossom');

-- SIN's apply.sql, unchanged:
-- Run as a single batch in the Forever Bots 0.1.35 world database (MySQL 8, stop on error).
DROP TEMPORARY TABLE IF EXISTS lynessa_spawn_guard;
CREATE TEMPORARY TABLE lynessa_spawn_guard (ok INT NOT NULL CHECK (ok = 1));
START TRANSACTION;
SELECT guid FROM creature WHERE guid = 27574402 AND id = 275744 AND map = 1 FOR UPDATE;
INSERT INTO lynessa_spawn_guard SELECT COUNT(*) FROM creature WHERE guid = 27574402 AND id = 275744 AND map = 1 AND ((ABS(position_x - 9869.66015625) < 0.001 AND ABS(position_y - 1558.9699707) < 0.001 AND ABS(position_z - 1328.55004883) < 0.001 AND ABS(orientation - 0) < 0.001) OR (ABS(position_x - 9870.520508) < 0.001 AND ABS(position_y - 1557.701172) < 0.001 AND ABS(position_z - 1329.287476) < 0.001 AND ABS(orientation - 5.336902) < 0.001));
UPDATE creature SET position_x = 9870.520508, position_y = 1557.701172, position_z = 1329.287476, orientation = 5.336902 WHERE guid = 27574402 AND id = 275744 AND map = 1 AND (ABS(position_x - 9869.66015625) < 0.001 AND ABS(position_y - 1558.9699707) < 0.001 AND ABS(position_z - 1328.55004883) < 0.001 AND ABS(orientation - 0) < 0.001);
INSERT INTO lynessa_spawn_guard SELECT COUNT(*) FROM creature WHERE guid = 27574402 AND id = 275744 AND map = 1 AND (ABS(position_x - 9870.520508) < 0.001 AND ABS(position_y - 1557.701172) < 0.001 AND ABS(position_z - 1329.287476) < 0.001 AND ABS(orientation - 5.336902) < 0.001);
COMMIT;
DROP TEMPORARY TABLE lynessa_spawn_guard;
