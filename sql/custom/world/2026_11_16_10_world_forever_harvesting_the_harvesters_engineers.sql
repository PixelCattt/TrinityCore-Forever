-- Harvesting the Harvesters (Ozwin Ironsprocket 253395, Saldean's Farm, Westfall): three quests with the same name, and a player
-- could not finish one of them (Discord, voldemargreed "bugs 3" 4, 2026-11-13). 92909 is for everybody; 92910 (started by the
-- Precessive Autocognition Assembly 255155 from harvest golems) and 92911 (asks for Copper Modulators and a Crude Scope, rewards
-- the Harvester Override Signalcaster and its schematic) are the Engineering part (ATT Forever: requireSkill ENGINEERING). Our data
-- had no skill on them, so anybody got the Assembly and then a quest only an engineer can make the parts for.
-- Now 92910 and 92911 need Engineering (202) and the Assembly only drops for engineers. Safe to run again.

INSERT INTO `quest_template_addon` (`ID`) VALUES (92910) ON DUPLICATE KEY UPDATE `ID` = `ID`;
UPDATE `quest_template_addon` SET `RequiredSkillID` = 202, `RequiredSkillPoints` = 1 WHERE `ID` IN (92910,92911);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 1 AND `SourceEntry` = 255155 AND `ConditionTypeOrReference` = 7;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(1, 36, 255155, 0, 0, 7, 0, 202, 1, 0, 0, 0, 0, '', 'Precessive Autocognition Assembly - only for engineers'),
(1, 114, 255155, 0, 0, 7, 0, 202, 1, 0, 0, 0, 0, '', 'Precessive Autocognition Assembly - only for engineers'),
(1, 480, 255155, 0, 0, 7, 0, 202, 1, 0, 0, 0, 0, '', 'Precessive Autocognition Assembly - only for engineers');
