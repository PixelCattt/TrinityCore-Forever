-- A Lesson in Divinity (94440): the Scarlet Crusade Attack Plans (264693) still did not drop for players (Discord, soulkilleer and
-- dumpins, 2026-11-13/14, 0.1.36). The quest sends them to "the Scarlet Crusaders at Venomweb Vale", and the client's creature
-- query lists 264693 as a quest item of the Scarlet Zealot (1537) and the Scarlet Friar (1538) only (sniffed creature_questitem,
-- 2026_10_01_04). 2026_11_05_00 deleted those drops and kept only the Tarnished Zealots (259433) on the west coast, where nobody
-- following the quest text hunts. The plans drop again from 1537 and 1538 (40%, only while on the quest, as 2026_10_01_04 had it;
-- INFERRED chance, the drop was not seen in the sniffs); 259433 keeps its drop. The quest's map area gets a second blob over the
-- Scarlet camp in Venomweb Vale (the 1537/1538 spawns at 2484-2587 x, -823..-953 y, 15 yards wider). Safe to run again.
DELETE `clt` FROM `creature_loot_template` `clt`
JOIN `creature_template_difficulty` `ctd` ON `ctd`.`LootID` = `clt`.`Entry`
WHERE `clt`.`Item` = 264693 AND `ctd`.`Entry` IN (1537,1538) AND `ctd`.`DifficultyID` = 0;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`)
SELECT DISTINCT `LootID`, 0, 264693, 40, 1, 1, 0, 1, 1, 'Scarlet Crusade Attack Plans (A Lesson in Divinity)'
FROM `creature_template_difficulty` WHERE `Entry` IN (1537,1538) AND `DifficultyID` = 0 AND `LootID` > 0;

DELETE FROM `quest_poi` WHERE `QuestID` = 94440 AND `BlobIndex` = 1 AND `Idx1` = 2;
INSERT INTO `quest_poi` (`QuestID`,`BlobIndex`,`Idx1`,`ObjectiveIndex`,`QuestObjectiveID`,`QuestObjectID`,`MapID`,`UiMapID`,`Priority`,`Flags`,`WorldEffectID`,`PlayerConditionID`,`NavigationPlayerConditionID`,`SpawnTrackingID`,`AlwaysAllowMergingBlobs`,`VerifiedBuild`) VALUES
(94440,1,2,0,468587,264693,0,1420,0,0,0,0,0,0,0,0);
DELETE FROM `quest_poi_points` WHERE `QuestID` = 94440 AND `Idx1` = 2;
INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`,`Idx2`,`X`,`Y`,`Z`,`VerifiedBuild`) VALUES
(94440,2,0,2470,-870,60,0),(94440,2,1,2500,-810,60,0),(94440,2,2,2560,-805,60,0),(94440,2,3,2600,-850,60,0),
(94440,2,4,2602,-915,60,0),(94440,2,5,2565,-968,60,0),(94440,2,6,2505,-950,60,0),(94440,2,7,2470,-910,60,0);
