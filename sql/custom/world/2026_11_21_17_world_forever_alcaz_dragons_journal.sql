-- WoW Forever: 96772 The Dragon's Journal (Alcaz Prison), held in 2026_11_14_42 because its giver, Archmage Lan'dalock 264499, is
-- not spawned. Quest record from EG Link (build 1.60.1.70959). Data from Efficient Games (https://efficient.games), licensed under
-- CC BY 4.0 (https://creativecommons.org/licenses/by/4.0/). Source: github.com/JIVESCORP/eg-link-output-wowf. Changed: picked and
-- converted to our tables. The record carries no giver or turn-in and no reward text.
--  * Giver and turn-in: Archmage Lan'dalock 20735, the one we spawn in the Alterac Mountains (map 0, 119.8, 355.1). Live records
--    have no 264499 and show 20735 under that name; the quest text speaks for him and Archmage Timear, who stand
--    together there. INFERRED: 264499 is a second id for him that no data spawns.
--  * The journal (276890) already drops from Blazeroar for the quest (2026_11_14_41).
--  * The reward text is a short placeholder (VerifiedBuild -1 marks it).
-- Safe to run again.

DELETE FROM `quest_template` WHERE `ID`=96772;
INSERT INTO `quest_template` (`ID`,`QuestType`,`LogTitle`,`VerifiedBuild`) VALUES (96772,2,'The Dragon''s Journal',-1);
UPDATE `quest_template` SET `QuestDescription`='Timear and I have been scrying the area on Kalimdor known as Alcaz Island and we''ve all but confirmed the presence of a powerful magic user there. The mage in question was able to dispel our probes, but before she did, I was able to glean an image of a tome of some sort. I believe it was a journal, written in ancient draconic script.\n\nI don''t know what is in that book, but I''d like to study it. We want you to travel to the hidden prison beneath Alcaz Island and recover that book for us.', `LogDescription`='Recover Zarla''s Journal from the depths of Alcaz Prison.', `QuestSortID`=16620, `QuestInfoID`=81, `RewardNextQuest`=0, `RewardXPDifficulty`=6, `RewardXPMultiplier`=2.2, `StartItem`=0, `Flags`=8, `AllowableRaces`=6130900294268439629, `VerifiedBuild`=70959, `RewardFactionID1`=2740, `RewardFactionValue1`=7, `RewardFactionOverride1`=30000, `RewardFactionID2`=72, `RewardFactionValue2`=6 WHERE `ID`=96772;
DELETE FROM `quest_classic_level` WHERE `ID`=96772;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (96772,53,46,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=96772;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (96772,2,53);
DELETE FROM `quest_template_addon` WHERE `ID`=96772;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (96772,0,0,0);
DELETE FROM `quest_offer_reward` WHERE `ID`=96772;
INSERT INTO `quest_offer_reward` (`ID`,`RewardText`,`VerifiedBuild`) VALUES (96772,'Well done, $n. Thank you.',-1);
DELETE FROM `quest_classic_money` WHERE `ID`=96772;
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES (96772,16752,0);
DELETE FROM `quest_objectives` WHERE `QuestID`=96772;
DELETE FROM `quest_objectives` WHERE `ID` IN (475392);
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES (475392,96772,1,0,0,276890,1,0,32,1,0.0,0,1,NULL,70959);
DELETE FROM `creature_queststarter` WHERE `quest`=96772;
DELETE FROM `creature_questender` WHERE `quest`=96772;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (20735,96772,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (20735,96772,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry`=20735;
