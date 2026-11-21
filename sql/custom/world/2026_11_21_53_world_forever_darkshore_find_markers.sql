-- The Red Crystal (4811) and How Big a Threat? (984), Darkshore: no map point for the place to find (Discord, voldemargreed
-- "bugs" items 7 and 8). Both can be done and turned in since 0.1.37 (2026_11_10_92, 2026_10_25_02, 2026_11_12_03 and the
-- SmartAI complete-quest change), but the map only had the turn-in at Auberdine (the 3.3.5 data of 2026_10_09_01). Each quest
-- now also marks its "find" step: The Red Crystal round its trigger on the eastern ridge, How Big a Threat? round the two
-- furbolg camps whose vanilla triggers credit it (positions and sizes from the vanilla triggers, as in 2026_11_10_92; the
-- areas are ours, a little wider than the triggers, not sniffed). The area hangs off the quest's own area trigger objective,
-- whatever its id, and only goes in where that marker spot is still free. Safe to run more than once.

-- 4811: the red crystal (vanilla trigger 2486, 15 yd)
INSERT INTO `quest_poi` (`QuestID`,`BlobIndex`,`Idx1`,`ObjectiveIndex`,`QuestObjectiveID`,`QuestObjectID`,`MapID`,`UiMapID`,`Priority`,`Flags`,`WorldEffectID`,`PlayerConditionID`,`NavigationPlayerConditionID`,`SpawnTrackingID`,`AlwaysAllowMergingBlobs`,`VerifiedBuild`)
SELECT `o`.`QuestID`,0,10,`o`.`StorageIndex`,`o`.`ID`,0,1,1439,0,0,0,0,0,0,0,0 FROM `quest_objectives` `o`
WHERE `o`.`QuestID`=4811 AND `o`.`Type`=10
  AND `o`.`ID`=(SELECT MIN(`t`.`ID`) FROM (SELECT `ID` FROM `quest_objectives` WHERE `QuestID`=4811 AND `Type`=10) `t`)
  AND NOT EXISTS (SELECT 1 FROM `quest_poi` `p` WHERE `p`.`QuestID`=4811 AND `p`.`BlobIndex`=0 AND `p`.`Idx1`=10);
INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`,`Idx2`,`X`,`Y`,`Z`,`VerifiedBuild`)
SELECT `s`.* FROM (SELECT 4811 AS `QuestID`,10 AS `Idx1`,0 AS `Idx2`,6238 AS `X`,-153 AS `Y`,79 AS `Z`,0 AS `VerifiedBuild` UNION ALL SELECT 4811,10,1,6229,-132,79,0 UNION ALL SELECT 4811,10,2,6208,-123,79,0 UNION ALL SELECT 4811,10,3,6186,-132,79,0 UNION ALL SELECT 4811,10,4,6178,-153,79,0 UNION ALL SELECT 4811,10,5,6186,-174,79,0 UNION ALL SELECT 4811,10,6,6208,-183,79,0 UNION ALL SELECT 4811,10,7,6229,-174,79,0) `s`
WHERE EXISTS (SELECT 1 FROM `quest_poi` `p` WHERE `p`.`QuestID`=4811 AND `p`.`BlobIndex`=0 AND `p`.`Idx1`=10 AND `p`.`QuestObjectiveID` IN (SELECT `ID` FROM `quest_objectives` WHERE `QuestID`=`p`.`QuestID` AND `Type`=10))
  AND NOT EXISTS (SELECT 1 FROM `quest_poi_points` `x` WHERE `x`.`QuestID`=4811 AND `x`.`Idx1`=10);

-- 984: the furbolg camp north of Auberdine (vanilla triggers 231 and 232, 40 yd)
INSERT INTO `quest_poi` (`QuestID`,`BlobIndex`,`Idx1`,`ObjectiveIndex`,`QuestObjectiveID`,`QuestObjectID`,`MapID`,`UiMapID`,`Priority`,`Flags`,`WorldEffectID`,`PlayerConditionID`,`NavigationPlayerConditionID`,`SpawnTrackingID`,`AlwaysAllowMergingBlobs`,`VerifiedBuild`)
SELECT `o`.`QuestID`,0,10,`o`.`StorageIndex`,`o`.`ID`,0,1,1439,0,0,0,0,0,0,0,0 FROM `quest_objectives` `o`
WHERE `o`.`QuestID`=984 AND `o`.`Type`=10
  AND `o`.`ID`=(SELECT MIN(`t`.`ID`) FROM (SELECT `ID` FROM `quest_objectives` WHERE `QuestID`=984 AND `Type`=10) `t`)
  AND NOT EXISTS (SELECT 1 FROM `quest_poi` `p` WHERE `p`.`QuestID`=984 AND `p`.`BlobIndex`=0 AND `p`.`Idx1`=10);
INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`,`Idx2`,`X`,`Y`,`Z`,`VerifiedBuild`)
SELECT `s`.* FROM (SELECT 984 AS `QuestID`,10 AS `Idx1`,0 AS `Idx2`,6048 AS `X`,348 AS `Y`,22 AS `Z`,0 AS `VerifiedBuild` UNION ALL SELECT 984,10,1,6031,390,22,0 UNION ALL SELECT 984,10,2,5988,408,22,0 UNION ALL SELECT 984,10,3,5946,390,22,0 UNION ALL SELECT 984,10,4,5928,348,22,0 UNION ALL SELECT 984,10,5,5946,305,22,0 UNION ALL SELECT 984,10,6,5988,288,22,0 UNION ALL SELECT 984,10,7,6031,305,22,0) `s`
WHERE EXISTS (SELECT 1 FROM `quest_poi` `p` WHERE `p`.`QuestID`=984 AND `p`.`BlobIndex`=0 AND `p`.`Idx1`=10 AND `p`.`QuestObjectiveID` IN (SELECT `ID` FROM `quest_objectives` WHERE `QuestID`=`p`.`QuestID` AND `Type`=10))
  AND NOT EXISTS (SELECT 1 FROM `quest_poi_points` `x` WHERE `x`.`QuestID`=984 AND `x`.`Idx1`=10);

-- 984: the furbolg camp south (vanilla trigger 235, 70 yd)
INSERT INTO `quest_poi` (`QuestID`,`BlobIndex`,`Idx1`,`ObjectiveIndex`,`QuestObjectiveID`,`QuestObjectID`,`MapID`,`UiMapID`,`Priority`,`Flags`,`WorldEffectID`,`PlayerConditionID`,`NavigationPlayerConditionID`,`SpawnTrackingID`,`AlwaysAllowMergingBlobs`,`VerifiedBuild`)
SELECT `o`.`QuestID`,1,11,`o`.`StorageIndex`,`o`.`ID`,0,1,1439,0,0,0,0,0,0,0,0 FROM `quest_objectives` `o`
WHERE `o`.`QuestID`=984 AND `o`.`Type`=10
  AND `o`.`ID`=(SELECT MIN(`t`.`ID`) FROM (SELECT `ID` FROM `quest_objectives` WHERE `QuestID`=984 AND `Type`=10) `t`)
  AND NOT EXISTS (SELECT 1 FROM `quest_poi` `p` WHERE `p`.`QuestID`=984 AND `p`.`BlobIndex`=1 AND `p`.`Idx1`=11);
INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`,`Idx2`,`X`,`Y`,`Z`,`VerifiedBuild`)
SELECT `s`.* FROM (SELECT 984 AS `QuestID`,11 AS `Idx1`,0 AS `Idx2`,4625 AS `X`,146 AS `Y`,60 AS `Z`,0 AS `VerifiedBuild` UNION ALL SELECT 984,11,1,4604,196,60,0 UNION ALL SELECT 984,11,2,4555,216,60,0 UNION ALL SELECT 984,11,3,4505,196,60,0 UNION ALL SELECT 984,11,4,4485,146,60,0 UNION ALL SELECT 984,11,5,4505,97,60,0 UNION ALL SELECT 984,11,6,4555,76,60,0 UNION ALL SELECT 984,11,7,4604,97,60,0) `s`
WHERE EXISTS (SELECT 1 FROM `quest_poi` `p` WHERE `p`.`QuestID`=984 AND `p`.`BlobIndex`=1 AND `p`.`Idx1`=11 AND `p`.`QuestObjectiveID` IN (SELECT `ID` FROM `quest_objectives` WHERE `QuestID`=`p`.`QuestID` AND `Type`=10))
  AND NOT EXISTS (SELECT 1 FROM `quest_poi_points` `x` WHERE `x`.`QuestID`=984 AND `x`.`Idx1`=11);
