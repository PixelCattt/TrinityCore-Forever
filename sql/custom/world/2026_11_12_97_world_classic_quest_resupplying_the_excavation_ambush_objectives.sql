-- Keep quest 273 objective progress in separate player storage slots.
UPDATE `quest_objectives`
SET `StorageIndex` = 1
WHERE `ID` = 90002730 AND `QuestID` = 273;
