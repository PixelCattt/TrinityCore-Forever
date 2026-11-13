-- Snowbound (86667, Forever, Loch Modan): "no marker on the map. Ceramic Jar won't activate" (Discord "bugs 4", 2026-11-13).
-- The Ceramic Jar (279380) casts 1306628, which needs spell focus 2317 within 30 yards (client SpellCastingRequirements, 70938)
-- and then turns the jar into the filled jar 279379, the quest's objective. The one object with that focus is "South Gate Snow"
-- (8380007, spawn 838000700, Dun Morogh at the South Gate, from 2026_11_05_99). The quest had a map area only for its turn-in in
-- Loch Modan, so nothing showed where the jar works, and anywhere else the cast fails.
-- Added: a map area for the objective, 30 yards around the snow spot, in Dun Morogh (UiMap 1426, as the vanilla Dun Morogh
-- quests in 2026_10_09_01). INFERRED: the area is ours, not Blizzard's, and Dun Morogh is read from the coordinates; whether the snow object
-- stands on the ground is checked with the ground probe (PC step 105b). The turn-in area stays. Safe to run again.
DELETE FROM `quest_poi` WHERE `QuestID` = 86667 AND `Idx1` = 1;
INSERT INTO `quest_poi` (`QuestID`,`BlobIndex`,`Idx1`,`ObjectiveIndex`,`QuestObjectiveID`,`QuestObjectID`,`MapID`,`UiMapID`,`Priority`,`Flags`,`WorldEffectID`,`PlayerConditionID`,`NavigationPlayerConditionID`,`SpawnTrackingID`,`AlwaysAllowMergingBlobs`,`VerifiedBuild`) VALUES
(86667,0,1,0,9400397,279379,0,1426,0,0,0,0,0,0,0,0);
DELETE FROM `quest_poi_points` WHERE `QuestID` = 86667 AND `Idx1` = 1;
INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`,`Idx2`,`X`,`Y`,`Z`,`VerifiedBuild`) VALUES
(86667,1,0,-5585,-2206,423,0),(86667,1,1,-5600,-2180,423,0),(86667,1,2,-5630,-2180,423,0),(86667,1,3,-5645,-2206,423,0),(86667,1,4,-5630,-2232,423,0),(86667,1,5,-5600,-2232,423,0);
