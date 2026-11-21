-- WoW Forever, Duskwood: Grant's Shield 79362 and Silvia's Sword 79363 are two of the four Valor family quests (with Ira's Dagger
-- 96137 and Merrick's Bow 96138). They start from the items the Lost spirits drop (281147, 281145) and end at Sirra Von'Indi 268
-- in Darkshire, for every class. Blizzard reused two old shaman quest ids for them, and our world still carried the old shaman
-- quest's parts on top: class mask 64 (2026_10_27_95), Bath'rah the Windwatcher 6176 as giver and turn-in, the old quest's
-- progress and reward texts, map markers in Alterac and the old French texts. 2026_11_19_40 then made the two drops shaman-only.
-- Result: non-shamans could never do two of the four Valor quests (Discord, VoldemarGreed "bugs 7", points 7 and 9).
-- Live record (EG Link, quests.enUS 70959, CC BY 4.0, github.com/JIVESCORP/eg-link-output-wowf): no class, Alliance races,
-- start items 281147 / 281145, objectives text "return to Sirra Von'Indi in Darkshire". Wowhead Forever lists all four spirits
-- and their quests as one chain. Reward text is a placeholder. Safe to run again.

UPDATE `quest_template_addon` SET `AllowableClasses`=0 WHERE `ID` IN (79362,79363);

DELETE FROM `creature_queststarter` WHERE `quest` IN (79362,79363);
DELETE FROM `creature_questender` WHERE `quest` IN (79362,79363);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (268,79362,70959),(268,79363,70959);

-- the two drops are for everyone again (the loot code still hides a start item from a player who has or has done its quest)
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=1 AND (`SourceGroup`,`SourceEntry`) IN ((272291,281147),(272284,281145));

-- old shaman quest texts out
DELETE FROM `quest_request_items` WHERE `ID` IN (79362,79363);
DELETE FROM `quest_offer_reward` WHERE `ID` IN (79362,79363);
INSERT INTO `quest_offer_reward` (`ID`,`RewardText`,`VerifiedBuild`) VALUES (79362,'Thank you, $n.',-1),(79363,'Thank you, $n.',-1);
DELETE FROM `quest_template_locale` WHERE `ID` IN (79362,79363) AND `locale`='frFR';
DELETE FROM `quest_request_items_locale` WHERE `ID` IN (79362,79363) AND `locale`='frFR';
DELETE FROM `quest_offer_reward_locale` WHERE `ID` IN (79362,79363) AND `locale`='frFR';

-- map markers: the turn-in blob (Idx1 0) and the old blob 3 (79362) / 4 (79363) sat in Alterac (UiMap 1416). The turn-in now
-- points at Sirra Von'Indi like 96139's; the old blob goes. The Duskwood objective blobs stay.
DELETE FROM `quest_poi` WHERE (`QuestID`=79362 AND `Idx1`=3) OR (`QuestID`=79363 AND `Idx1`=4);
DELETE FROM `quest_poi_points` WHERE (`QuestID`=79362 AND `Idx1` IN (0,3)) OR (`QuestID`=79363 AND `Idx1` IN (0,4));
UPDATE `quest_poi` SET `UiMapID`=1431, `MapID`=0 WHERE `QuestID` IN (79362,79363) AND `Idx1`=0;
INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`,`Idx2`,`X`,`Y`,`Z`,`VerifiedBuild`) VALUES (79362,0,0,-10574,-1127,29,0),(79363,0,0,-10574,-1127,29,0);

-- The Valor Family 96139 (same report, point 8: "searched every house and found nothing"): the Memory of Valor (object 673515,
-- guid 67351500) sat at z 40.05, almost 4 yd under the floor of the Raven Hill house (ground measured on dev: floor 43.91,
-- roof 53.62), so nobody could see or open it. Put it on the floor.
UPDATE `gameobject` SET `position_z`=43.91 WHERE `guid`=67351500 AND `id`=673515;
