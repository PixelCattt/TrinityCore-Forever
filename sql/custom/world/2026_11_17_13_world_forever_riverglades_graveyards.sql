-- Riverglades (zone 16591, WoW Forever): the zone had no graveyard and no spirit healer, so a ghost there was sent to the default
-- graveyard (Westfall for the Alliance, the Crossroads for the Horde) (Tornn, Discord 17 Nov: "a weird graveyard / respawn point
-- in the new zone"). INFERRED: the live graveyard spots are in no data we have. One spirit healer per town, on open flat ground
-- next to its flight master (ground probe step 154p: one surface, no roof, the points around it within 0.4 yd of the same height):
--   1104114 the Alliance keep (gryphon master Gretchen Mayberry), Alliance only
--   1104115 Powderfuse Port, the goblin port (Innkeeper Zizplink's town), both factions
--   1104116 the Horde camp (wind rider master Grakna), Horde only
DELETE FROM `world_safe_locs` WHERE `ID` IN (1104114,1104115,1104116);
INSERT INTO `world_safe_locs` (`ID`,`MapID`,`LocX`,`LocY`,`LocZ`,`Facing`,`Comment`) VALUES
(1104114,0,-9105.10,-4820.80,23.30,270.0,'Riverglades, Alliance keep GY (INFERRED, probe 154p)'),
(1104115,0,-8196.80,-5606.80,4.70,0.0,'Riverglades, Powderfuse Port GY (INFERRED, probe 154p)'),
(1104116,0,-7928.10,-4762.30,21.60,270.0,'Riverglades, Horde camp GY (INFERRED, probe 154p)');
DELETE FROM `graveyard_zone` WHERE `ID` IN (1104114,1104115,1104116);
INSERT INTO `graveyard_zone` (`ID`,`GhostZone`,`Comment`) VALUES
(1104114,16591,'Riverglades - Riverglades, Alliance keep GY'),
(1104115,16591,'Riverglades - Riverglades, Powderfuse Port GY'),
(1104116,16591,'Riverglades - Riverglades, Horde camp GY');
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=27 AND `SourceGroup`=16591 AND `SourceEntry` IN (1104114,1104116);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(27,16591,1104114,0,0,6,0,469,0,0,0,0,0,'','Graveyard 1104114 (Riverglades) - Alliance only'),
(27,16591,1104116,0,0,6,0,67,0,0,0,0,0,'','Graveyard 1104116 (Riverglades) - Horde only');
-- the spirit healers, on the graveyard spots
DELETE FROM `creature` WHERE `guid` BETWEEN 47220000 AND 47220002 AND `id`=6491;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`VerifiedBuild`) VALUES
(47220000,6491,0,0,0,'0',0,0,0,-1,0,0,-9105.10,-4820.80,23.30,4.712,490,0,0,100,0,0),
(47220001,6491,0,0,0,'0',0,0,0,-1,0,0,-8196.80,-5606.80,4.70,0.000,490,0,0,100,0,0),
(47220002,6491,0,0,0,'0',0,0,0,-1,0,0,-7928.10,-4762.30,21.60,4.712,490,0,0,100,0,0);
