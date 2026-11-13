-- The Fargodeep Mine (62, Elwynn Forest) could never be completed: it is a go-there quest (flag 4) with one objective, "Scout
-- through the Fargodeep Mine" (90000620, area trigger, any id), and both of its vanilla triggers, 88 (lower mine) and 197 (upper
-- entrance), are gone from the 1.60 client AreaTrigger.db2 (checked in the 70938 copy, PC step 103). No trigger ever fires.
-- Same fix as How Big a Threat? (2026_11_10_92): the two triggers come back as server-side area triggers at the vanilla spots and
-- radii (vMaNGOS areatrigger_template, June 2021 dump) with a SmartAI script that completes the quest on entry. The core change in
-- the same release makes that action fill the catch-all objective too (before, 984 got explored but its objective stayed open).
-- Server-side flag set, so the client is never sent a trigger it does not know. Safe to run again.
DELETE FROM `areatrigger_template` WHERE `Id` = 620 AND `IsCustom` = 1;
INSERT INTO `areatrigger_template` (`Id`, `IsCustom`, `Flags`, `ActionSetId`, `ActionSetFlags`, `VerifiedBuild`) VALUES
(620, 1, 1, 0, 0, 0);
DELETE FROM `areatrigger_create_properties` WHERE `Id` IN (620, 621) AND `IsCustom` = 1;
INSERT INTO `areatrigger_create_properties` (`Id`, `IsCustom`, `AreaTriggerId`, `IsAreatriggerCustom`, `Flags`, `AnimId`, `AnimKitId`,
    `PositionalSoundKitId`, `Speed`, `Shape`, `ShapeData0`, `ShapeData1`, `ShapeData2`, `ShapeData3`, `ShapeData4`, `ShapeData5`,
    `ShapeData6`, `ShapeData7`, `Roll`, `Pitch`, `Yaw`, `ScriptName`, `VerifiedBuild`) VALUES
(620, 1, 620, 1, 0, -1, -1, 0, 0, 0, 10, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAreaTriggerAI', 0),
(621, 1, 620, 1, 0, -1, -1, 0, 0, 0, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAreaTriggerAI', 0);
DELETE FROM `areatrigger` WHERE `SpawnId` IN (9206, 9207);
INSERT INTO `areatrigger` (`SpawnId`, `AreaTriggerCreatePropertiesId`, `IsCustom`, `MapId`, `SpawnDifficulties`, `PosX`, `PosY`, `PosZ`, `Orientation`,
    `PhaseUseFlags`, `PhaseId`, `PhaseGroup`, `ScriptName`, `Comment`, `VerifiedBuild`) VALUES
(9206, 620, 1, 0, '0', -9843.54, 127.525, 5.3698, 0, 0, 0, 0, '', 'Elwynn - Fargodeep Mine, lower mine (quest 62 The Fargodeep Mine, vanilla trigger 88)', 0),
(9207, 621, 1, 0, '0', -9796.18, 157.773, 25.3878, 0, 0, 0, 0, '', 'Elwynn - Fargodeep Mine, upper entrance (quest 62 The Fargodeep Mine, vanilla trigger 197)', 0);

DELETE FROM `smart_scripts` WHERE `entryorguid` = 620 AND `source_type` = 12;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`Difficulties`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`action_param7`,`action_param_string`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_param_string`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(620,12,0,0,'',46,0,100,0,0,0,0,0,0,'',152,62,0,0,0,0,0,0,'',7,0,0,0,0,'',0,0,0,0,'Fargodeep Mine area trigger - On enter - Complete The Fargodeep Mine (62) for the player');
