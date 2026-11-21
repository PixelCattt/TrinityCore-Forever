-- City of Dalaran trash (map 2959): two live abilities ours never did (data farm 19 Nov, BOSS-SPELLS.md and live-casts-1119.tsv:
-- EG Link combat logs from the live realm, builds 70205-70959, CC BY 4.0, https://efficient.games).
-- 1. Phantasm (246990) casts Reflection Field 1303459 (our row 0 already does), which creates area trigger 43682. We had no
--    create properties for 43682, so the field was never made. Live, Phantasm then gives Reflection Field 1303458 (reflect
--    spells, 115 casts from 20 Phantasms) to whoever stands in it: its allies. The area trigger now casts 1303458 on friends of
--    the Phantasm who enter and takes it off when they leave. The shape is not in the client data: an 8 yd sphere (INFERRED).
-- 2. Fallen Warrior (255069) had no abilities; live casts Hamstring (9080) about once a fight (0.83 a creature). INFERRED timers.
-- Saturated Remnant's Mana Leak (1303503, area trigger 43687) stays open: what its field does is server-side and not in the logs.
-- Safe to run again.

DELETE FROM `areatrigger_template` WHERE `Id` = 43682 AND `IsCustom` = 1;
INSERT INTO `areatrigger_template` (`Id`, `IsCustom`, `Flags`, `ActionSetId`, `ActionSetFlags`, `VerifiedBuild`) VALUES
(43682, 1, 0, 0, 0, 0);

DELETE FROM `areatrigger_template_actions` WHERE `AreaTriggerId` = 43682 AND `IsCustom` = 1;
INSERT INTO `areatrigger_template_actions` (`AreaTriggerId`, `IsCustom`, `ActionType`, `ActionParam`, `TargetType`) VALUES
(43682, 1, 0, 1303458, 1);

DELETE FROM `areatrigger_create_properties` WHERE `Id` = 43682 AND `IsCustom` = 0;
INSERT INTO `areatrigger_create_properties` (`Id`, `IsCustom`, `AreaTriggerId`, `IsAreatriggerCustom`, `Flags`, `MoveCurveId`,
`ScaleCurveId`, `MorphCurveId`, `FacingCurveId`, `AnimId`, `AnimKitId`, `DecalPropertiesId`, `SpellForVisuals`, `PositionalSoundKitId`,
`TimeToTargetScale`, `Speed`, `SpeedIsTime`, `Shape`, `ShapeData0`, `ShapeData1`, `ShapeData2`, `ShapeData3`, `ShapeData4`,
`ShapeData5`, `ShapeData6`, `ShapeData7`, `Roll`, `Pitch`, `Yaw`, `TargetRoll`, `TargetPitch`, `TargetYaw`, `ScriptName`,
`VerifiedBuild`) VALUES
(43682, 0, 43682, 1, 0, 0, 0, 0, 0, -1, -1, 0, NULL, 0, 0, 0, 0, 0, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0);

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 255069 AND `AIName` = '' AND `ScriptName` = '';
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 255069 AND `id` >= 100 AND `comment` LIKE 'EG live%';
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`Difficulties`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`action_param7`,`action_param_string`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_param_string`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`)
SELECT 255069,0,100,0,'',0,0,100,0,4000,8000,15000,20000,0,'',11,9080,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'EG live: Fallen Warrior - Hamstring (9080), INFERRED timers' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `smart_scripts` s WHERE s.`entryorguid` = 255069 AND s.`source_type` = 0 AND s.`action_type` = 11 AND s.`action_param1` = 9080);
