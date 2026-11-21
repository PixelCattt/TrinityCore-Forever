-- WoW Forever, Thousand Needles shaman chain Elemental Aid 79360 -> Eyes on the Sky 79364 -> Storm, Earth, and Fire 79361 (-> Heed
-- My Call 79366 -> The Tempest's Weapons 79442). These ids were old shaman quests that Bath'rah the Windwatcher 6176 (Alterac)
-- gave and took. Our world still had Bath'rah as giver and turn-in of all three, the map markers at Bath'rah in Alterac (UiMap
-- 1416) and Elemental Aid's old reward text (it hands the note to Bath'rah). Same reused-id trap as 2026_11_21_73.
-- Live record (EG Link npcs 70888, CC BY 4.0, github.com/JIVESCORP/eg-link-output-wowf): Prate Cloudseer 5905 gives 79360 and
-- 79361 and takes 79361 and 79364; Rau Cliffrunner 4722 gives 79364 and takes 79360. Bath'rah gives and takes none of the
-- three (he has 79365 and 79442 on live). Class (shaman) stays: the live quests are class-sorted. Reward text is a placeholder.
-- Safe to run again.
DELETE FROM `creature_queststarter` WHERE `id`=6176 AND `quest` IN (79360,79361,79364);
-- Rau Cliffrunner takes Elemental Aid on live but does not give it (Prate Cloudseer does)
DELETE FROM `creature_queststarter` WHERE `id`=4722 AND `quest`=79360;
DELETE FROM `creature_questender` WHERE `id`=6176 AND `quest` IN (79360,79361,79364);
DELETE FROM `creature_queststarter` WHERE (`id`,`quest`) IN ((5905,79360),(5905,79361),(4722,79364));
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (5905,79360,70888),(5905,79361,70888),(4722,79364,70888);
DELETE FROM `creature_questender` WHERE (`id`,`quest`) IN ((4722,79360),(5905,79361),(5905,79364));
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (4722,79360,70888),(5905,79361,70888),(5905,79364,70888);

UPDATE `quest_offer_reward` SET `RewardText`='Thank you, $n.' WHERE `ID`=79360 AND `RewardText` LIKE '%Bath''rah%';

-- map markers: turn-in at the live turn-in NPC in Thousand Needles (UiMap 1441, spots from the same live record), old Alterac
-- blob 1 goes
DELETE FROM `quest_poi` WHERE `QuestID` IN (79360,79364) AND `Idx1`=1 AND `UiMapID`=1416;
DELETE FROM `quest_poi_points` WHERE `QuestID` IN (79360,79364) AND `Idx1` IN (0,1);
UPDATE `quest_poi` SET `UiMapID`=1441, `MapID`=1 WHERE `QuestID` IN (79360,79364) AND `Idx1`=0;
INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`,`Idx2`,`X`,`Y`,`Z`,`VerifiedBuild`) VALUES
(79360,0,0,-5481,-2463,0,0),  -- Rau Cliffrunner
(79364,0,0,-5221,-2791,0,0);  -- Prate Cloudseer
