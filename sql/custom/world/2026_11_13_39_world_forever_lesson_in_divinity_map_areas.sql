-- A Lesson in Divinity (94427-94441, Forever paladin chain): no part of it had a map area, so the quest log could not show
-- where to go (Discord, soulkilleer, 2026-11-13: "the Scarlet plans for 94440 don't drop and the quest has no map marker").
-- The plans (264693) do drop, 48% and only while on the quest, but only from the Tarnished Zealots (259433) of the Scarlet camp
-- on the north coast of Tirisfal Glades (24 spawns, 1797-2015 x, 2364-2541 y; PC step 104); without a marker nothing points there.
-- Built like 2026_11_12_09: the turn-in spot of each part at its ender's spawn, and for 94440 one area around the Zealots'
-- spawns, 15 yards wider. Undercity parts use UiMap 1458, the rest Tirisfal Glades 1420 (as the Forever Tirisfal quests in
-- 2026_11_05_99). INFERRED: live areas are not sniffed, so the shapes are ours, not Blizzard's. Safe to run again.
DELETE FROM `quest_poi` WHERE `QuestID` IN (94427,94434,94435,94436,94438,94440,94441);
INSERT INTO `quest_poi` (`QuestID`,`BlobIndex`,`Idx1`,`ObjectiveIndex`,`QuestObjectiveID`,`QuestObjectID`,`MapID`,`UiMapID`,`Priority`,`Flags`,`WorldEffectID`,`PlayerConditionID`,`NavigationPlayerConditionID`,`SpawnTrackingID`,`AlwaysAllowMergingBlobs`,`VerifiedBuild`) VALUES
(94427,0,0,-1,0,0,0,1458,0,0,0,0,0,0,0,0),
(94434,0,0,-1,0,0,0,1458,0,0,0,0,0,0,0,0),
(94435,0,0,-1,0,0,0,1420,0,0,0,0,0,0,0,0),
(94436,0,0,-1,0,0,0,1420,0,0,0,0,0,0,0,0),
(94438,0,0,-1,0,0,0,1420,0,0,0,0,0,0,0,0),
(94440,0,0,-1,0,0,0,1420,0,0,0,0,0,0,0,0),
(94441,0,0,-1,0,0,0,1420,0,0,0,0,0,0,0,0),
(94440,0,1,0,468587,264693,0,1420,0,0,0,0,0,0,0,0);

DELETE FROM `quest_poi_points` WHERE `QuestID` IN (94427,94434,94435,94436,94438,94440,94441);
INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`,`Idx2`,`X`,`Y`,`Z`,`VerifiedBuild`) VALUES
-- turn-in spots: 257648 (Undercity) for 94427/94434, 246378 for 94435/94441, 257655 for 94436/94440, 257663 for 94438
(94427,0,0,1638,245,-43,0),
(94434,0,0,1638,245,-43,0),
(94435,0,0,2492,2035,156,0),
(94436,0,0,2497,2043,138,0),
(94438,0,0,2398,-871,67,0),
(94440,0,0,2497,2043,138,0),
(94441,0,0,2492,2035,156,0),
-- Tarnished Zealot 259433 (drops the Scarlet plans 264693)
(94440,1,0,1787,2403,132,0),(94440,1,1,1895,2350,132,0),(94440,1,2,2011,2450,132,0),(94440,1,3,2028,2540,132,0),(94440,1,4,1995,2548,132,0),(94440,1,5,1935,2548,132,0),(94440,1,6,1881,2527,132,0);
