-- WoW Forever (wowsims/forever, MIT, tools/database/overrides/hand_triggers.go). Safe to run again.

-- Zandalarian Hero Badge 19948: its on-use 24574 now applies the 10-stack buff 24575 (+2000 armor, +30 defense, 200 / 3 off per hit
-- taken); it named a trigger the client does not have, so nothing went on (script classic_spell_item_zandalarian_hero_badge).
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'classic_spell_item_zandalarian_hero_badge';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (24574, 'classic_spell_item_zandalarian_hero_badge');

-- Caustic Smog Potion: the thrown potion 1252526 creates area trigger 39425 for 12 sec ("Enemies standing within the cloud suffer
-- $1252543s1 Nature damage every $1252543t1 sec"); the server had no shape or action for it, so the cloud did nothing. Enemies inside get
-- 1252543 (33 Nature a second) from the thrower, removed when they leave or the cloud ends. The client states no radius: an 8 yd sphere is
-- assumed, the size of the classic ground spells (2026_10_04_03).
DELETE FROM `areatrigger_template` WHERE `Id` = 39425 AND `IsCustom` = 1;
INSERT INTO `areatrigger_template` (`Id`, `IsCustom`, `Flags`, `ActionSetId`, `ActionSetFlags`, `VerifiedBuild`) VALUES
(39425, 1, 0, 0, 0, 0);
DELETE FROM `areatrigger_template_actions` WHERE `AreaTriggerId` = 39425 AND `IsCustom` = 1;
INSERT INTO `areatrigger_template_actions` (`AreaTriggerId`, `IsCustom`, `ActionType`, `ActionParam`, `TargetType`) VALUES
(39425, 1, 0, 1252543, 2);
DELETE FROM `areatrigger_create_properties` WHERE `Id` = 39425 AND `IsCustom` = 0;
INSERT INTO `areatrigger_create_properties` (`Id`, `IsCustom`, `AreaTriggerId`, `IsAreatriggerCustom`, `Flags`, `MoveCurveId`,
`ScaleCurveId`, `MorphCurveId`, `FacingCurveId`, `AnimId`, `AnimKitId`, `DecalPropertiesId`, `SpellForVisuals`, `PositionalSoundKitId`,
`TimeToTargetScale`, `Speed`, `SpeedIsTime`, `Shape`, `ShapeData0`, `ShapeData1`, `ShapeData2`, `ShapeData3`, `ShapeData4`,
`ShapeData5`, `ShapeData6`, `ShapeData7`, `Roll`, `Pitch`, `Yaw`, `TargetRoll`, `TargetPitch`, `TargetYaw`, `ScriptName`,
`VerifiedBuild`) VALUES
(39425, 0, 39425, 1, 0, 0, 0, 0, 0, -1, -1, 0, NULL, 0, 0, 0, 0, 0, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0);
