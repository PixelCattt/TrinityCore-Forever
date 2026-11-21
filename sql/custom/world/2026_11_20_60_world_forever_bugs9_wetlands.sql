-- Voldemar's "bugs 9" (Discord bug report, 2026-11-20), the Wetlands part: Neru, Carnage and the quest map markers.
-- 1. Neru (271458), the fourth golem of Gleaning Our Future (98310): our world had its Heart of Neru drop (2026_11_01_14) but no
--    Neru at all, so the quest could not be finished. Template copied from its twin Modr (271460, same quest, same level and
--    rank); model 146665 from Wowhead Forever's model viewer; one spawn at the centre of Wowhead's 4 pins (60.5,22.45, behind
--    Direforge Hill), z from the PC's ground height there (35.88, open ground, no cave). Like Ados, Modr and Golm: 600 s respawn,
--    5 yd wander. Level 32 elite (Wowhead).
-- 2. Carnage (271336): its only spawn (27133600, from 2026_11_05_99) stood at 67.4,40, at the foot of the hill below Raptor
--    Ridge, not in its cave lair, so players searching the cave found nothing. Wowhead pins it at 68.9-69.6, 28.2-29 inside the
--    cave under the ridge. Moved to the middle pin (69.2,28.2) on the cave floor at 54.21: the PC's ground heights there are
--    196.62 (the cliff top above), 72.58 and 54.21, and the Elder Razormaw spawned 4 yd away (20009653) stands at 54.21.
--    The two spawns of 2026_10_30_10 (46000363/46000364) were on the cliff top (z 196.7 and 247.1 from terrain); they go.
-- 3. Map markers: Gleaning Our Future (98310), Carnage (98283) and Razormaw Needling (98245) had none; Claws from the Deep (279)
--    had the murlocs and the turn-in but no marker for Gobbler (Gobbler's Head). Built like 2026_11_13_39: the turn-in at the
--    ender's spawn, and an area for each objective round its spawns or Wowhead's pins, 15 yards wider (golems: 25 yd round the
--    spawn). INFERRED: live areas are not sniffed, so the shapes are ours, not Blizzard's.
-- Wowhead pins (x%, y%) to world: x = -2147.91 - 27.5626 * y%, y = -389.59 - 41.354 * x% (fitted on 100 of our Wetlands spawns;
-- checks: Modr 51.6,17.2 vs Wowhead 51.2,17.5; Golm 67.6,72.2 vs 67.6,70.4; Whelgar 38.7,52.3 vs 38.8,52.2).
-- Safe to run again.

-- 1. Neru
DELETE FROM `creature_template` WHERE `entry`=271458;
INSERT INTO `creature_template` SELECT 271458,`KillCredit1`,`KillCredit2`,'Neru',`femaleName`,`subname`,`TitleAlt`,`IconName`,`RequiredExpansion`,`VignetteID`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`Classification`,`dmgschool`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,`unit_flags`,`unit_flags2`,`unit_flags3`,`family`,`trainer_class`,`type`,`VehicleId`,`AIName`,`MovementType`,`ExperienceModifier`,`RacialLeader`,`movementId`,`WidgetSetID`,`WidgetSetUnitConditionID`,`RegenHealth`,`CreatureImmunitiesId`,`flags_extra`,`ScriptName`,`StringId`,0 FROM `creature_template` WHERE `entry`=271460;
DELETE FROM `creature_template_difficulty` WHERE `Entry`=271458;
INSERT INTO `creature_template_difficulty` SELECT 271458,`DifficultyID`,`LevelScalingDeltaMin`,`LevelScalingDeltaMax`,`ContentTuningID`,`HealthScalingExpansion`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`DamageModifier`,`CreatureDifficultyID`,`TypeFlags`,`TypeFlags2`,`TypeFlags3`,271458,`PickPocketLootID`,`SkinLootID`,`GoldMin`,`GoldMax`,`StaticFlags1`,`StaticFlags2`,`StaticFlags3`,`StaticFlags4`,`StaticFlags5`,`StaticFlags6`,`StaticFlags7`,`StaticFlags8`,0 FROM `creature_template_difficulty` WHERE `Entry`=271460;
DELETE FROM `creature_template_model` WHERE `CreatureID`=271458;
INSERT INTO `creature_template_model` (`CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild`) VALUES (271458,0,146665,1,1,0);
DELETE FROM `creature_classic_level` WHERE `entry`=271458;
INSERT INTO `creature_classic_level` (`entry`,`level_min`,`level_max`) VALUES (271458,32,32);
DELETE FROM `creature` WHERE `guid`=27145800;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(27145800,271458,0,0,0,'0',0,0,0,-1,0,0,-2766.70,-2891.50,35.88,0,600,5,0,100,1,NULL,NULL,NULL,NULL,'',NULL,0);

-- 2. Carnage in its cave
DELETE FROM `creature_addon` WHERE `guid` IN (27133600,46000363,46000364);
DELETE FROM `creature` WHERE `guid` IN (27133600,46000363,46000364);
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(27133600,271336,0,0,0,'0',0,0,0,-1,0,0,-2927.94,-3243.02,54.21,3.14,600,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0);

-- 3. Map markers (Wetlands, UiMap 1437)
DELETE FROM `quest_poi` WHERE `QuestID` IN (98310,98283,98245);
DELETE FROM `quest_poi` WHERE `QuestID`=279 AND `BlobIndex`=0 AND `Idx1`=1;
INSERT INTO `quest_poi` (`QuestID`,`BlobIndex`,`Idx1`,`ObjectiveIndex`,`QuestObjectiveID`,`QuestObjectID`,`MapID`,`UiMapID`,`Priority`,`Flags`,`WorldEffectID`,`PlayerConditionID`,`NavigationPlayerConditionID`,`SpawnTrackingID`,`AlwaysAllowMergingBlobs`,`VerifiedBuild`) VALUES
(98310,0,0,-1,0,0,0,1437,0,0,0,0,0,0,0,0),
(98310,0,1,0,9831000,280395,0,1437,0,0,0,0,0,0,0,0),
(98310,0,2,1,9831001,280396,0,1437,0,0,0,0,0,0,0,0),
(98310,0,3,2,9831002,280397,0,1437,0,0,0,0,0,0,0,0),
(98310,0,4,3,9831003,280398,0,1437,0,0,0,0,0,0,0,0),
(98283,0,0,-1,0,0,0,1437,0,0,0,0,0,0,0,0),
(98283,0,1,0,9828300,280331,0,1437,0,0,0,0,0,0,0,0),
(98283,0,2,1,9828301,280330,0,1437,0,0,0,0,0,0,0,0),
(98245,0,0,-1,0,0,0,1437,0,0,0,0,0,0,0,0),
(98245,0,1,0,9824500,280103,0,1437,0,0,0,0,0,0,0,0),
(98245,0,2,0,9824500,280103,0,1437,0,0,0,0,0,0,0,0),
(279,0,1,1,90002794,3618,0,1437,0,1,0,0,0,0,0,0);

DELETE FROM `quest_poi_points` WHERE `QuestID` IN (98310,98283,98245);
DELETE FROM `quest_poi_points` WHERE `QuestID`=279 AND `Idx1`=1;
INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`,`Idx2`,`X`,`Y`,`Z`,`VerifiedBuild`) VALUES
-- turn-in: Prospector Whelgar 1077
(98310,0,0,-3592,-1994,117,0),
-- Ados 271338
(98310,1,0,-3413,-3590,48,0),(98310,1,1,-3420,-3573,48,0),(98310,1,2,-3438,-3565,48,0),(98310,1,3,-3456,-3573,48,0),(98310,1,4,-3463,-3590,48,0),(98310,1,5,-3456,-3608,48,0),(98310,1,6,-3438,-3615,48,0),(98310,1,7,-3420,-3608,48,0),
-- Modr 271460
(98310,2,0,-2597,-2523,80,0),(98310,2,1,-2604,-2506,80,0),(98310,2,2,-2622,-2498,80,0),(98310,2,3,-2640,-2506,80,0),(98310,2,4,-2647,-2523,80,0),(98310,2,5,-2640,-2541,80,0),(98310,2,6,-2622,-2548,80,0),(98310,2,7,-2604,-2541,80,0),
-- Golm 271462
(98310,3,0,-4113,-3185,14,0),(98310,3,1,-4120,-3167,14,0),(98310,3,2,-4138,-3160,14,0),(98310,3,3,-4156,-3167,14,0),(98310,3,4,-4163,-3185,14,0),(98310,3,5,-4156,-3203,14,0),(98310,3,6,-4138,-3210,14,0),(98310,3,7,-4120,-3203,14,0),
-- Neru 271458 (new spawn, this file)
(98310,4,0,-2742,-2892,36,0),(98310,4,1,-2749,-2874,36,0),(98310,4,2,-2767,-2866,36,0),(98310,4,3,-2784,-2874,36,0),(98310,4,4,-2792,-2892,36,0),(98310,4,5,-2784,-2909,36,0),(98310,4,6,-2767,-2916,36,0),(98310,4,7,-2749,-2909,36,0),
-- turn-in: Rethiel the Greenwarden 1244
(98283,0,0,-3261,-2721,10,0),
-- Maddened Rotclaw 271334 (Malignant Rotclaw Flesh): hull of the 41 Wowhead pins, 15 yd wider
(98283,1,0,-3626,-3030,25,0),(98283,1,1,-3545,-3295,25,0),(98283,1,2,-3516,-3312,25,0),(98283,1,3,-3343,-3290,25,0),(98283,1,4,-2845,-2824,25,0),(98283,1,5,-2799,-2744,25,0),(98283,1,6,-2801,-2613,25,0),(98283,1,7,-3439,-2744,25,0),
-- Carnage 271336 (Carnage's Head): the cave from its mouth (69.5,34.7) to the lair
(98283,2,0,-3124,-3264,60,0),(98283,2,1,-3117,-3278,60,0),(98283,2,2,-3102,-3278,60,0),(98283,2,3,-2942,-3278,60,0),(98283,2,4,-2913,-3261,60,0),(98283,2,5,-2903,-3242,60,0),(98283,2,6,-2913,-3224,60,0),(98283,2,7,-2933,-3224,60,0),(98283,2,8,-3117,-3250,60,0),
-- turn-in: Howin Kindfeather 270637
(98245,0,0,-3300,-2432,19,0),
-- Highland Razormaw 1018 (Razormaw Incisor), west: 5 Wowhead pins, 15 yd wider
(98245,1,0,-2741,-1863,0,0),(98245,1,1,-2698,-1880,0,0),(98245,1,2,-2630,-1824,0,0),(98245,1,3,-2684,-1810,0,0),
-- Highland / Elder Razormaw 1018 / 1019 (Razormaw Incisor), Raptor Ridge: 23 Wowhead pins, 15 yd wider
(98245,2,0,-3177,-3211,60,0),(98245,2,1,-3123,-3262,60,0),(98245,2,2,-2986,-3328,60,0),(98245,2,3,-2924,-3296,60,0),(98245,2,4,-2888,-3211,60,0),(98245,2,5,-2888,-3202,60,0),(98245,2,6,-2891,-3197,60,0),(98245,2,7,-2983,-3075,60,0),(98245,2,8,-3002,-3075,60,0),(98245,2,9,-3174,-3165,60,0),
-- Gobbler 1259 (Gobbler's Head 3618): its spawn and Wowhead's 3 pins (16.3-17.5, 39.4-40.4), 10 yd wider
(279,1,0,-3271,-1111,0,0),(279,1,1,-3266,-1145,0,0),(279,1,2,-3255,-1160,0,0),(279,1,3,-3235,-1159,0,0),(279,1,4,-3224,-1144,0,0),(279,1,5,-3231,-1058,0,0),(279,1,6,-3264,-1054,0,0);
