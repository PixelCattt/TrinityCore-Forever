-- WoW Forever: quests players do on the live realm that our world did not have at all (and Everlake's open data does not
-- add either). Full live record: title, story, objective line, completion line, levels, races, flags, objectives with their
-- live ids, item/choice/reputation/money rewards, start item, next quest.
-- Quest record: Data from Efficient Games (https://efficient.games), licensed under CC BY 4.0
-- (https://creativecommons.org/licenses/by/4.0/). Source: github.com/JIVESCORP/eg-link-output-wowf quests.enUS (players' quest
-- caches) and npcs (who offered and took each quest), builds 70888-70959. Changed: picked and converted to our tables.
-- Givers, turn-ins, classes and the one previous quest also from NorgannonDB (zmarotrix/NorgannonDB, GPL-3.0, built from
-- QuestieDB GPL-3.0, pfQuest MIT and its Collector add-on).
-- Only quests whose giver (or start item), turn-in and every objective target exist and are spawned in our world are here;
-- the rest are listed in the kit's quests report with the reason they wait. Reward text is not in the data: none is set.
-- Safe to run again: every row is replaced by key.

-- 92867 Ground to Keep (level 39, min 32, live build 1.60.1.70938, 4 player(s))
DELETE FROM `quest_template` WHERE `ID`=92867;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (92867,2,45,1,0,5,1.0,0,1.0,0,0,264,0,0,0,18446744073709551615,280505,1,278567,1,'Ground to Keep','Defeat the Boulderfist, Syndicate, and Witherbark intruders in Stromgarde Keep and return to Groundskeeper Lomar.','Our heritage may be crumbling, but this is not our final redoubt. We have more in reserve, and it must remain hidden for its own protection.

Support grows for preserving our remaining sculptures and sacred burial grounds. The rabble that have taken up residence in our old kingdom have no notion of the vengeance coming for them.

Drive back the Boulderfist and Syndicate. They must learn Stromgarde is not merely fist, eagle, and stones.','','',70938);
DELETE FROM `quest_objectives` WHERE `QuestID`=92867;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (476306,92867,0,0,0,2569,5,0,1,NULL,70938),(476307,92867,0,1,1,2590,3,0,1,NULL,70938),(476308,92867,0,2,2,2588,6,0,1,NULL,70938),(476309,92867,0,3,3,2558,3,0,1,NULL,70938);
DELETE FROM `quest_template_addon` WHERE `ID`=92867;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (92867,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=92867;
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES (92867,4500,0);
DELETE FROM `quest_classic_level` WHERE `ID`=92867;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (92867,39,32,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=92867;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (92867,2,39);
DELETE FROM `creature_queststarter` WHERE `quest`=92867;
DELETE FROM `gameobject_queststarter` WHERE `quest`=92867;
DELETE FROM `creature_questender` WHERE `quest`=92867;
DELETE FROM `gameobject_questender` WHERE `quest`=92867;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (219,92867,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (219,92867,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (219);

