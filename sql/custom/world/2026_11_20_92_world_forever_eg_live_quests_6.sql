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

-- 93615 Kits and Cats (level 57, min 54, live build 1.60.1.70959, 2 player(s))
DELETE FROM `quest_template` WHERE `ID`=93615;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardItem1`,`RewardAmount1`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (93615,2,616,0,0,4,1.0,0,1.0,0,0,36700168,0,0,0,18446744073709551615,276338,1,'Kits and Cats','Find Shalla''kal''s kittens in the wilds of Mount Hyjal.','Oh, a tasty morsel...

Fear not, I jest. Though I could snap your spine like a dry branch. I am a demigod of the wilds, after all.

If you would gain my favor and avoid my appetite, perhaps I could burden you with a task?

My litter of young have wandered off to entertain themselves. Little on this mountain could threaten them directly, but there are dark things afoot near the summit, and I''d leave nothing to chance.

Would you check on them? In return for my not eating you, of course.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=93615;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (466998,93615,3,0,0,255685,1,0,1,'Solstice found',70959),(467060,93615,3,1,1,255771,1,0,1,'Whisperfur found',70959),(467061,93615,3,2,2,255773,1,0,1,'Brie found',70959);
DELETE FROM `quest_template_addon` WHERE `ID`=93615;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (93615,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=93615;
DELETE FROM `quest_classic_level` WHERE `ID`=93615;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (93615,57,54,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=93615;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (93615,2,57);
DELETE FROM `creature_queststarter` WHERE `quest`=93615;
DELETE FROM `gameobject_queststarter` WHERE `quest`=93615;
DELETE FROM `creature_questender` WHERE `quest`=93615;
DELETE FROM `gameobject_questender` WHERE `quest`=93615;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (255683,93615,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (255683,93615,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (255683);

-- Kits and Cats: the three kittens are "talk to" targets, so they need the gossip flag for the credit to fire on hello
UPDATE `creature_template` SET `npcflag`=`npcflag`|1 WHERE `entry` IN (255685,255771,255773);
