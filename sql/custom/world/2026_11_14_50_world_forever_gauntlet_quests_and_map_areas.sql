-- Quests from Discord "bugs 4" (2026-11-13) that show as complete too early or have no map area for their objective.
-- Taken from SIN's fix pack for 0.1.36 and written again here. Safe to run again.

-- The Algaz Gauntlet (455, Wetlands: kill 8 Scouts and 6 Grunts, go through the pass) "can't be turned in" and The Rethban
-- Gauntlet (1699, Redridge, timed: reach the fork and return) "shows complete, can't turn in". Both carry the old completion
-- flag "area trigger" (4) next to a real area trigger objective (455: 385480 trigger 175; 1699: 385494 trigger 482, from EG Link
-- 2026_11_12_14). With that flag, walking into the trigger tells the client the whole quest is complete at once
-- (Player::AreaExploredOrEventHappens -> SendQuestComplete), even with kills still to do, and the quest then also waits on that
-- flag. The objective already does the job, so the flag goes: 455 Flags 12 -> 8, 1699 Flags 5 -> 1. Only when the flags are
-- still the shipped ones. PC step lists every other quest with flag 4 and a trigger objective (no change made to those yet).
UPDATE `quest_template` SET `Flags` = `Flags` & ~4 WHERE (`ID` = 455 AND `Flags` = 12) OR (`ID` = 1699 AND `Flags` = 5);

-- Map areas for the objectives that had none (the turn-in areas stay). Points: Huldar's spawn 20008279 for 273 (its objective is
-- "find Huldar", 9000273, 2026_11_06_50); for 455 and 1699 the area trigger centres as read from the client AreaTrigger.db2
-- by the fix pack (INFERRED until the PC step reads them back). Flags 1 as the other blobs of these quests (2026_10_09_01).
DELETE FROM `quest_poi` WHERE (`QuestID` = 273 AND `Idx1` = 0) OR (`QuestID` = 455 AND `Idx1` = 2) OR (`QuestID` = 1699 AND `Idx1` = 0);
INSERT INTO `quest_poi` (`QuestID`,`BlobIndex`,`Idx1`,`ObjectiveIndex`,`QuestObjectiveID`,`QuestObjectID`,`MapID`,`UiMapID`,`Priority`,`Flags`,`WorldEffectID`,`PlayerConditionID`,`NavigationPlayerConditionID`,`SpawnTrackingID`,`AlwaysAllowMergingBlobs`,`VerifiedBuild`) VALUES
(273,0,0,0,9000273,2057,0,1432,0,1,0,0,0,0,0,0),
(455,0,2,2,385480,175,0,1437,0,1,0,0,0,0,0,0),
(1699,0,0,0,385494,482,0,1433,0,1,0,0,0,0,0,0);
DELETE FROM `quest_poi_points` WHERE (`QuestID` = 273 AND `Idx1` = 0) OR (`QuestID` = 455 AND `Idx1` = 2) OR (`QuestID` = 1699 AND `Idx1` = 0);
INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`,`Idx2`,`X`,`Y`,`Z`,`VerifiedBuild`) VALUES
(273,0,0,-5763,-3433,306,0),
(455,2,0,-4086,-2611,46,0),
(1699,0,0,-8933,-1986,140,0);

-- WANTED: Incinerator Gar'im (95999): 2026_11_12_25 moved Gar'im (spawn 21451900) off the cliff top into Render's Valley, but
-- the quest's map area for him stayed on the cliff (-9817, -3361, 158), so the map still sends players to the old place
-- (Discord "bugs 4": "still in the wrong place"). The area follows him now.
UPDATE `quest_poi_points` SET `X` = -9721, `Y` = -3189, `Z` = 59 WHERE `QuestID` = 95999 AND `Idx1` = 1 AND `Idx2` = 0;
