-- Elemental Bracers (1016): the quest shows no map area (Discord, voldemargreed "bugs 5", 2026-11-14). The 3.3.5 data
-- (2026_10_09_01) only had the turn-in at Silverwind Refuge. The Divined Scroll (5455, objective 90010164, index 4) is made from
-- Intact Elemental Bracers (12220), which drop from the Befouled Water Elementals (3917) around Lake Falathim; the area is the
-- hull of their 33 spawns in Ashenvale, 15 yards wider. Safe to run again.
DELETE FROM `quest_poi` WHERE `QuestID` = 1016 AND `BlobIndex` = 0 AND `Idx1` = 2;
INSERT INTO `quest_poi` (`QuestID`,`BlobIndex`,`Idx1`,`ObjectiveIndex`,`QuestObjectiveID`,`QuestObjectID`,`MapID`,`UiMapID`,`Priority`,`Flags`,`WorldEffectID`,`PlayerConditionID`,`NavigationPlayerConditionID`,`SpawnTrackingID`,`AlwaysAllowMergingBlobs`,`VerifiedBuild`) VALUES
(1016,0,2,4,90010164,5455,1,1440,0,0,0,0,0,0,0,0);
DELETE FROM `quest_poi_points` WHERE `QuestID` = 1016 AND `Idx1` = 2;
INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`,`Idx2`,`X`,`Y`,`Z`,`VerifiedBuild`) VALUES
(1016,2,0,1842,-1264,77,0),(1016,2,1,1869,-1320,77,0),(1016,2,2,1890,-1320,77,0),(1016,2,3,1965,-1306,77,0),(1016,2,4,2008,-1290,77,0),
(1016,2,5,2094,-1244,77,0),(1016,2,6,2090,-963,77,0),(1016,2,7,2012,-885,77,0),(1016,2,8,1914,-970,77,0),(1016,2,9,1865,-1078,77,0);
