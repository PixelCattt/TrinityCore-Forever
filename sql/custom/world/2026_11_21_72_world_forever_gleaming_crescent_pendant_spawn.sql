-- WoW Forever: quest 98027 "Gleaming Crescent Necklace" (Ashenvale) starts from the Gleaming Crescent Pendant object 669176, but the
-- object was never spawned (2026_11_19_69 held the spawn back until its height was known), so players found nothing under the
-- water (Discord player report). Spot from the Wowhead Forever map point 63,71.5 (Questie has 1921.9,-1931.8, 3 yd away).
-- Height: the lake bed, measured on dev (.playerbot groundz) 2026-11-20. Safe to run again.
DELETE FROM `gameobject` WHERE `guid`=66917600;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`,`ScriptName`,`VerifiedBuild`) VALUES
(66917600,669176,1,331,0,'0',0,0,0,-1,1924.6,-1933.0,84.79,0,0,0,0,1,300,255,1,'',70938) /* Gleaming Crescent Pendant (lake bed, z measured on dev) */;
