-- The Great Cat Spirit (98396, Moonglade, Stormrage Barrow Den): "The guards at the entrances, which are relevant to the stealth
-- mechanic, are missing" (Discord, 6_1_8_8_1 "Bugs" 2.3, 2026-11-14). The quest text: the relics "are guarded by powerful enraged
-- spirits that will attack you on sight. A statue at the entrance will bless you with temporary stealth to get past them."
-- The spirits (Restless Spirit 271698) have stood in the den since 2026_11_05_99; the statue never existed here.
-- Sources: Wowhead WoW Forever pages read 2026-11-20 (object 673394 "Great Cat Spirit Statue", display 129433, 2 spots in Moonglade
-- at 71.7,61.9 and 72.2,62.6; npc 271698, 16 spots; spell 1309054 "Feline Blessing of the Silent Shadow": Apply Aura Stealth, 5 min,
-- cannot be used shapeshifted or in combat; spell 1314842, the trial's end blessing, cancels it).
-- Map % to world with the Moonglade map bounds (left -1381.25, right -3689.58, top 8491.67, bottom 6952.08): that maths puts 8 of
-- our 9 spirit spawns within 2.8-11 yd of a Wowhead spot (map % is rounded to 0.1, about 2.3 yd).
-- INFERRED: the statue's object type. The spell is cast on the player by the player (range self, its shapeshift and combat checks are
-- the player's), which is what a spellcaster object (type 22) does: Data0 spell, Data1 charges 0 = no limit. Size 1, facing 0.
-- Heights: .playerbot groundz on dev (2026-11-20, catstatue-1121-groundz-OUTPUT), the surface that fits the floor of the spirits
-- we already have nearby. Left out until a lower search confirms a floor: the second statue (72.2,62.6: no terrain there, only
-- rock at 507/502, 41 yd over the first statue 16 yd away) and two spirit spots (74.0,64.8: no surface under the hill's top at
-- 491.6; 74.5,64.6: only 448.3, 14 yd over the spirit 11 yd away). One statue is enough for the trial ("a statue at the entrance").
-- Safe to run again.
DELETE FROM `gameobject_template` WHERE `entry` = 673394;
INSERT INTO `gameobject_template` (`entry`,`type`,`displayId`,`name`,`IconName`,`castBarCaption`,`unk1`,`size`,`Data0`,`Data1`,`Data2`,`Data3`,`Data4`,`Data5`,`Data6`,`Data7`,`Data8`,`Data9`,`Data10`,`Data11`,`Data12`,`Data13`,`Data14`,`Data15`,`Data16`,`Data17`,`Data18`,`Data19`,`Data20`,`Data21`,`Data22`,`Data23`,`Data24`,`Data25`,`Data26`,`Data27`,`Data28`,`Data29`,`Data30`,`Data31`,`Data32`,`Data33`,`Data34`,`ContentTuningId`,`RequiredLevel`,`AIName`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(673394,22,129433,'Great Cat Spirit Statue','','','',1,1309054,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'','',NULL,0);
DELETE FROM `gameobject` WHERE `guid` IN (67339400,67339401) AND `id` = 673394;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`) VALUES
(67339400, 673394, 1, 0, 0, '0', 0, 0, 0, -1, 7538.7, -3036.3, 460.72, 0, 0, 0, 0, 1, 300, 255, 1, '', NULL, 0);   -- terrain 460.72 (spirits 4-5 yd off at 462)
-- 6 of the 8 Wowhead spirit spots with no spawn of ours near them (Wowhead map %, the nearest spirit we have, the floor used).
DELETE FROM `creature` WHERE `guid` BETWEEN 27169809 AND 27169816 AND `id` = 271698;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(27169809,271698,1,0,0,'0',0,0,0,-1,0,0,7515.6,-3059.4,455.82,0,300,5,0,100,1,NULL,NULL,NULL,NULL,'',NULL,0),   -- 72.7,63.4: floor 455.82 (slope 461 at 27169805 down to 443 at 27169804)
(27169810,271698,1,0,0,'0',0,0,0,-1,0,0,7532.5,-3061.7,465.12,0,300,5,0,100,1,NULL,NULL,NULL,NULL,'',NULL,0),   -- 72.8,62.3: terrain 465.12 (27169806 at 461.65)
(27169811,271698,1,0,0,'0',0,0,0,-1,0,0,7474.0,-3084.8,442.97,0,300,5,0,100,1,NULL,NULL,NULL,NULL,'',NULL,0),   -- 73.8,66.1: floor 442.97 (27169802 at 440.69)
(27169812,271698,1,0,0,'0',0,0,0,-1,0,0,7466.3,-3084.8,442.44,0,300,5,0,100,1,NULL,NULL,NULL,NULL,'',NULL,0),   -- 73.8,66.6: floor 442.44 (27169800 at 439.56)
(27169815,271698,1,0,0,'0',0,0,0,-1,0,0,7460.1,-3121.7,438.21,0,300,5,0,100,1,NULL,NULL,NULL,NULL,'',NULL,0),   -- 75.4,67.0: floor 438.21 (27169801 at 438.87)
(27169816,271698,1,0,0,'0',0,0,0,-1,0,0,7460.1,-3124.0,438.26,0,300,5,0,100,1,NULL,NULL,NULL,NULL,'',NULL,0);   -- 75.5,67.0: floor 438.26 (27169801 at 438.87)
