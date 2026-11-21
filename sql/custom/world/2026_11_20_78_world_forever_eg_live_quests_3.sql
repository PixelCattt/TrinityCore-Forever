-- WoW Forever: quests players do on the live realm that our world did not have at all (and Everlake's open data does not
-- add either). Full live record: title, story, objective line, completion line, levels, races, flags, objectives with their
-- live ids, item/choice/reputation/money rewards, start item, next quest.
-- Quest record: Data from Efficient Games (https://efficient.games), licensed under CC BY 4.0
-- (https://creativecommons.org/licenses/by/4.0/). Source: github.com/JIVESCORP/eg-link-output-wowf quests.enUS (players' quest
-- caches) and npcs (who offered and took each quest), builds 70888-70959. Changed: picked and converted to our tables.
-- Givers, turn-ins (also checked on Wowhead's WoW Forever quest pages), classes and the one previous quest also from NorgannonDB (zmarotrix/NorgannonDB, GPL-3.0, built from
-- QuestieDB GPL-3.0, pfQuest MIT and its Collector add-on).
-- Only quests whose giver (or start item), turn-in and every objective target exist and are spawned in our world are here;
-- the rest are listed in the kit's quests report with the reason they wait. Reward text is not in the data: none is set.
-- Safe to run again: every row is replaced by key.

-- 79678 Taste Testing (level 40, min 26, live build 1.60.1.70959, 1 player(s))  -- previous quest 79677 is not in our world yet, so PrevQuestID is 0
DELETE FROM `quest_template` WHERE `ID`=79678;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardItem1`,`RewardAmount1`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (79678,2,45,0,0,5,1.0,0,1.0,0,0,2,0,0,0,18446744073709551615,213105,1,'Taste Testing','Taste test the recipe with Skonk.','Ok $r buddy, it time for Skonk favorite part. Skonk have fire hot and ready, and want to share new dish with new friend. You do such big favors for Skonk; it only right you get some too!

Let Skonk know when you ready for tasting.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=79678;
DELETE FROM `quest_template_addon` WHERE `ID`=79678;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (79678,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=79678;
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES (79678,5000,0);
DELETE FROM `quest_classic_level` WHERE `ID`=79678;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (79678,40,26,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=79678;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (79678,2,40);
DELETE FROM `creature_queststarter` WHERE `quest`=79678;
DELETE FROM `gameobject_queststarter` WHERE `quest`=79678;
DELETE FROM `creature_questender` WHERE `quest`=79678;
DELETE FROM `gameobject_questender` WHERE `quest`=79678;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (217300,79678,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (217300,79678,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (217300);

-- 86799 Encroaching Corruption (level 53, min 47, live build 1.60.1.70959, 2 player(s))  -- next quest 86804 is not in our world yet, so RewardNextQuest is 0
DELETE FROM `quest_template` WHERE `ID`=86799;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (86799,2,16,0,0,1,1.0,0,1.0,0,0,36700168,0,0,0,18446744073709551615,576,1,0,'Encroaching Corruption','Speak to Elder Bramblesnap about Furze''s illness.','<Furze lets loose an ugly, hacking, cough.>

Hear me, $r, I haven''t much strength to speak. I am stricken by an illness unlike any I have ever known. It is as if my blood itself is aflame, and my very essence is coming undone. I can hardly move, much less fetch help.

Please, go find Elder Bramblesnap. Her tent is just northwest of here. She will know what to do.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=86799;
DELETE FROM `quest_template_addon` WHERE `ID`=86799;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (86799,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=86799;
DELETE FROM `quest_classic_level` WHERE `ID`=86799;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (86799,53,47,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=86799;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (86799,2,53);
DELETE FROM `creature_queststarter` WHERE `quest`=86799;
DELETE FROM `gameobject_queststarter` WHERE `quest`=86799;
DELETE FROM `creature_questender` WHERE `quest`=86799;
DELETE FROM `gameobject_questender` WHERE `quest`=86799;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (235909,86799,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (235906,86799,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (235906,235909);

