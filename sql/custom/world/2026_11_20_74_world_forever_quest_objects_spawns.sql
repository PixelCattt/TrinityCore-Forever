-- WoW Forever: quest objects missing from the world, placed where players saw them live.
-- 423703 Broken Warhammer (Desolace, Mannoroc Coven turn-in, quests 79939 / 96438): position from NorgannonDB (GPL-3).
-- 645164 WANTED! board (quest 95992): position from Efficient Games EG Link (CC BY 4.0), seen 7 times.
-- Heights taken from our own nearby spawns (within 12 yd).
DELETE FROM `gameobject` WHERE `guid` IN (47500000,47500001);
INSERT INTO `gameobject` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(47500000,423703,1,0,0,'0',0,0,0,-1,-2088.96,1863.12,66.9568,0,0,0,0,1,120,255,1,'',NULL,-1),
(47500001,645164,0,0,0,'0',0,0,0,-1,-7988.6,-4777.3,24.436,0,0,0,0,1,120,255,1,'',NULL,-1);
