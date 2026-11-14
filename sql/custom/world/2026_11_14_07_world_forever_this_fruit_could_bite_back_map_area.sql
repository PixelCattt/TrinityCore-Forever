-- This Fruit Could Bite Back (96825, Durotar): the quest shows no map area (Discord, noobiru, 2026-11-14). The 10-01 sniff carried
-- the quest without quest_poi rows. Built from our own data, like 2026_11_12_09: the area is the hull of the 8 sniffed Prickly Pear
-- Fruit spawns (object 656177, drops 275718) west of Razor Hill, 15 yards wider, and the turn-in is Cook Torka (3191, VMaNGOS spot).
-- INFERRED: live areas are not sniffed, so the shape is ours, not Blizzard's. Safe to run again.
DELETE FROM `quest_poi` WHERE `QuestID` = 96825;
INSERT INTO `quest_poi` (`QuestID`,`BlobIndex`,`Idx1`,`ObjectiveIndex`,`QuestObjectiveID`,`QuestObjectID`,`MapID`,`UiMapID`,`Priority`,`Flags`,`WorldEffectID`,`PlayerConditionID`,`NavigationPlayerConditionID`,`SpawnTrackingID`,`AlwaysAllowMergingBlobs`,`VerifiedBuild`) VALUES
(96825,0,0,-1,0,0,1,1411,0,0,0,0,0,0,0,0),
(96825,0,1,0,474461,275718,1,1411,0,0,0,0,0,0,0,0);
DELETE FROM `quest_poi_points` WHERE `QuestID` = 96825;
INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`,`Idx2`,`X`,`Y`,`Z`,`VerifiedBuild`) VALUES
-- Cook Torka, Razor Hill
(96825,0,0,312,-4665,16,0),
-- Prickly Pear Fruit 656177
(96825,1,0,48,-4434,50,0),(96825,1,1,52,-4477,50,0),(96825,1,2,86,-4563,50,0),(96825,1,3,136,-4591,50,0),
(96825,1,4,126,-4484,50,0),(96825,1,5,85,-4428,50,0);
