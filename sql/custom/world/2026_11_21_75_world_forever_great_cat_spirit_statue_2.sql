-- The Great Cat Spirit trial, Stormrage Barrow Den (Moonglade): follow-up to 2026_11_21_74. Heights from .playerbot groundz on dev
-- searched down from just above each spot (catstatue-1121-groundz-v2-OUTPUT, 2026-11-20).
-- * The first statue stands on the entrance floor at 463.49 (an object floor 2.8 yd over the terrain at 460.72), not on the terrain.
-- * The second statue (Wowhead 72.2,62.6) goes on the same entrance floor 16 yd away, 463.28.
-- * The last two Wowhead spirit spots: 74.0,64.8 on the den floor at 439.51 (the spirit 14 yd off at 440.69), 74.5,64.6 at 436.08
--   (the spirit 11 yd off at 434.57).
-- Safe to run again.
UPDATE `gameobject` SET `position_z` = 463.49 WHERE `guid` = 67339400 AND `id` = 673394;
DELETE FROM `gameobject` WHERE `guid` = 67339401 AND `id` = 673394;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`) VALUES
(67339401, 673394, 1, 0, 0, '0', 0, 0, 0, -1, 7527.9, -3047.9, 463.28, 0, 0, 0, 0, 1, 300, 255, 1, '', NULL, 0);
DELETE FROM `creature` WHERE `guid` IN (27169813, 27169814) AND `id` = 271698;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(27169813,271698,1,0,0,'0',0,0,0,-1,0,0,7494.0,-3089.4,439.51,0,300,5,0,100,1,NULL,NULL,NULL,NULL,'',NULL,0),
(27169814,271698,1,0,0,'0',0,0,0,-1,0,0,7497.1,-3101.0,436.08,0,300,5,0,100,1,NULL,NULL,NULL,NULL,'',NULL,0);
