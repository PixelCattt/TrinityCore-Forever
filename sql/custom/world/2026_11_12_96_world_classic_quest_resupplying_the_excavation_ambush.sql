-- Remove quest 273's display-only area-trigger objective
-- Add a protection objective.
-- The live row is ID 90002730 (Type 10, ObjectID -1); retain its ID and update it in place.
-- ObjectID 900273 is a script-only credit used after all three attackers die.

UPDATE `quest_objectives`
SET `Type` = 0,
    `ObjectID` = 900273,
    `Amount` = 1,
    `Flags` = 0,
    `Visible` = 1,
    `Description` = 'Protect Huldar and Miran'
WHERE `ID` = 90002730 AND `QuestID` = 273;

DELETE FROM `areatrigger_involvedrelation`
WHERE `id` = 171 AND `quest` = 273;

DELETE FROM `smart_scripts`
WHERE (`entryorguid` = 2057 AND `source_type` = 0 AND `comment` = 'Huldar - On player in range - Credit Resupplying the Excavation')
   OR (`entryorguid` = 1380 AND `source_type` = 0 AND `comment` = 'VMaNGOS EventAI 138001');

UPDATE `creature_template`
SET `AIName` = '', `ScriptName` = 'npc_quest_273_huldar'
WHERE `entry` = 2057;

UPDATE `creature_template`
SET `AIName` = '', `ScriptName` = 'npc_quest_273_saean'
WHERE `entry` = 1380;

UPDATE `creature_template`
SET `AIName` = '', `ScriptName` = 'npc_quest_273_ambusher'
WHERE `entry` = 1981;
