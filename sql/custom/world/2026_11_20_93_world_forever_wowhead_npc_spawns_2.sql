-- WoW Forever: 8 more spawns from Wowhead's WoW Forever NPC pages (map spot to world with the per-zone fits, height from our own
-- spawns nearby). Groundskeeper Lomar, Mokvar, stable mounts at Menethil, Ironforge, Goldshire, Southshore.
-- Safe to run again.
DELETE FROM `creature` WHERE `guid` BETWEEN 47600400 AND 47600410;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(47600400,219,0,0,0,'0',0,0,0,-1,0,0,-1501.33,-1838.66,68.401,0,120,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,-1),
(47600404,230317,1,0,0,'0',0,0,0,-1,0,0,1936.19,-4147.66,40.958,0,120,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,-1),
(47600405,268313,0,0,0,'0',0,0,0,-1,0,0,-3636.30,-720.46,9.898,0,120,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,-1),
(47600406,268314,0,0,0,'0',0,0,0,-1,0,0,-3636.30,-720.46,9.898,0,120,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,-1),
(47600407,276737,0,0,0,'0',0,0,0,-1,0,0,-5531.94,-1359.82,398.694,0,120,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,-1),
(47600408,276787,0,0,0,'0',0,0,0,-1,0,0,-9439.43,-1407.87,47.049,0,120,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,-1),
(47600409,276788,0,0,0,'0',0,0,0,-1,0,0,-781.87,-603.73,15.235,0,120,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,-1),
(47600410,276789,0,0,0,'0',0,0,0,-1,0,0,-781.87,-603.73,15.235,0,120,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,-1);
