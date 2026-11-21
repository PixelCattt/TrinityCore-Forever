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

-- 79235 On the Lam (level 40, min 30, live build 1.60.1.70959, 2 player(s))
DELETE FROM `quest_template` WHERE `ID`=79235;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (79235,2,405,0,0,3,1.0,0,1.0,0,0,33554432,0,0,0,18446744073709551615,'On the Lam','Find one of the Desolace marauders.','I''ve found a couple of scenes like you describe, $n. Always camps of humans and dwarves. Rumor among the caravans is a group of Horde marauders did it. Seems likely given the victims, and how brutal the attacks were.

Apparently the bandits fled Desolace once an Alliance marshal got hot on their trail.

If you''re looking to track one of ''em down, I''d check Booty Bay. Ports always have shady characters coming and going. You might catch one trying to get a boat to somewhere.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=79235;
DELETE FROM `quest_template_addon` WHERE `ID`=79235;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (79235,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=79235;
DELETE FROM `quest_classic_level` WHERE `ID`=79235;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (79235,40,30,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=79235;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (79235,2,40);
DELETE FROM `creature_queststarter` WHERE `quest`=79235;
DELETE FROM `gameobject_queststarter` WHERE `quest`=79235;
DELETE FROM `creature_questender` WHERE `quest`=79235;
DELETE FROM `gameobject_questender` WHERE `quest`=79235;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (11438,79235,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (215643,79235,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (11438,215643);

-- 79236 Cherry for Your Thoughts? (level 40, min 30, live build 1.60.1.70959, 4 player(s))
DELETE FROM `quest_template` WHERE `ID`=79236;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (79236,2,405,0,0,3,1.0,0,1.0,0,0,33554432,0,0,0,18446744073709551615,'Cherry for Your Thoughts?','Bring a Cherry Grog to Tokal, in Booty Bay, to hear the rest of her story.','You with the marshal? No, you don''t look like it.

The rumors you''ve heard are only half true. Yes, we were pillaging human and dwarven camps, but we weren''t doing it for the Horde. We were privately employed.

I''ll tell you the whole story if you buy me some grog.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=79236;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (445860,79236,1,0,0,4600,1,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=79236;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (79236,0,0,79235);
DELETE FROM `quest_classic_money` WHERE `ID`=79236;
DELETE FROM `quest_classic_level` WHERE `ID`=79236;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (79236,40,30,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=79236;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (79236,2,40);
DELETE FROM `creature_queststarter` WHERE `quest`=79236;
DELETE FROM `gameobject_queststarter` WHERE `quest`=79236;
DELETE FROM `creature_questender` WHERE `quest`=79236;
DELETE FROM `gameobject_questender` WHERE `quest`=79236;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (215643,79236,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (215643,79236,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (215643);

-- 81764 The Mysterious Merchant (level 50, min 45, live build 1.60.1.70959, 3 player(s))
DELETE FROM `quest_template` WHERE `ID`=81764;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (81764,2,-141,0,81765,5,1.0,0,1.0,444651,0,8,0,0,0,6130900294268439629,'The Mysterious Merchant','Travel to Theramore and find the mysterious merchant.','Well met again, $n. Shaw and his spies have provided us with information on a mysterious merchant who just arrived in Kalimdor and is looking to offload a collection of dangerous artifacts. We''ve come to believe that he has an Echoing Orb in his collection. He is staying at the Theramore Inn in Dustwallow Marsh. Travel quickly, retrieve the orb, and speak to no one of this. We are sending you in alone to avoid drawing the attention of our enemies. 

Be safe, and go with the light.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=81764;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (448779,81764,3,0,0,221575,1,0,1,'Travel to Theramore and find the mysterious merchant.',70959);
DELETE FROM `quest_template_addon` WHERE `ID`=81764;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (81764,0,2,0);
DELETE FROM `quest_classic_money` WHERE `ID`=81764;
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES (81764,8225,0);
DELETE FROM `quest_classic_level` WHERE `ID`=81764;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (81764,50,45,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=81764;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (81764,2,50);
DELETE FROM `creature_queststarter` WHERE `quest`=81764;
DELETE FROM `gameobject_queststarter` WHERE `quest`=81764;
DELETE FROM `creature_questender` WHERE `quest`=81764;
DELETE FROM `gameobject_questender` WHERE `quest`=81764;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (5492,81764,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (221575,81764,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (5492,221575);

-- 81924 Wisdom of the Guardians (level 50, min 40, live build 1.60.1.70959, 1 player(s))
DELETE FROM `quest_template` WHERE `ID`=81924;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardItem1`,`RewardAmount1`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (81924,2,-263,0,0,6,1.0,0,1.0,0,0,35651584,0,0,0,18446744073709551615,219326,1,'Wisdom of the Guardians','Prove yourself to the guardian spirits of Feralas, Azshara, and the Hinterlands, then return to Tyrisius in Feralas.','Whatever Kaldorei knowledge you seek will not be found among these ruins, $c. Not anymore.

However, while the physical lies in ruin, the spiritual remains.

Seek the guardian spirits of Azshara, the Hinterlands, and Feralas. You will know them by their shrines. Prove yourself to them, and heed their words. Their wisdom will be passed on to you, so that it will not be lost to time as so much was here.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=81924;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (449002,81924,0,0,0,221935,1,0,1,'Guardian of Feralas',70959),(449003,81924,0,1,1,221933,1,0,1,'Guardian of the Hinterlands',70959),(449004,81924,0,2,2,221928,1,0,1,'Guardian of Azshara',70959);
DELETE FROM `quest_template_addon` WHERE `ID`=81924;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (81924,0,1024,0);
DELETE FROM `quest_classic_money` WHERE `ID`=81924;
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES (81924,14500,0);
DELETE FROM `quest_classic_level` WHERE `ID`=81924;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (81924,50,40,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=81924;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (81924,2,50);
DELETE FROM `creature_queststarter` WHERE `quest`=81924;
DELETE FROM `gameobject_queststarter` WHERE `quest`=81924;
DELETE FROM `creature_questender` WHERE `quest`=81924;
DELETE FROM `gameobject_questender` WHERE `quest`=81924;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (221985,81924,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (221985,81924,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (221985);

-- Faction fixes from Wowhead's reaction (the live-cache templates guessed hostile): Elrick friendly to Alliance, Tyrisius and Tokal
-- friendly to both. Elrick is a "talk to" target (The Mysterious Merchant), so he needs the gossip flag.
UPDATE `creature_template` SET `faction`=12 WHERE `entry`=221575;
UPDATE `creature_template` SET `faction`=35 WHERE `entry` IN (221985,215643);
UPDATE `creature_template` SET `npcflag`=`npcflag`|1 WHERE `entry`=221575;
