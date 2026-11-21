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

-- 95992 WANTED: Ghostmaw (level 42, min 38, live build 1.60.1.70959, 5 player(s))
DELETE FROM `quest_template` WHERE `ID`=95992;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardItem1`,`RewardAmount1`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (95992,2,16591,1,0,6,1.0,0,1.0,0,0,36700168,0,0,0,12261800583900083122,274962,1,'WANTED: Ghostmaw','Bring Ghostmaw''s Fang to Tan''jani in Rog''mar.','Dese waters be treacherous. My headhunters keep the paths clear as dey can, but there be a beasty stalkin'' de rivers even we cannot catch. Excitin'', eh?

Boss say we gotta clear it out, so we got a little competition goin''. Find de white one patrollin'' de rivers and bring me its fang. Whoever sticks this slippery crocolisk win de whole pot. Just don''t get snapped yourself, heheh!

-- Tan''jani','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=95992;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (471785,95992,1,0,0,271828,1,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=95992;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (95992,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=95992;
DELETE FROM `quest_classic_level` WHERE `ID`=95992;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (95992,42,38,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=95992;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (95992,2,42);
DELETE FROM `creature_queststarter` WHERE `quest`=95992;
DELETE FROM `gameobject_queststarter` WHERE `quest`=95992;
DELETE FROM `creature_questender` WHERE `quest`=95992;
DELETE FROM `gameobject_questender` WHERE `quest`=95992;
INSERT INTO `gameobject_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (645164,95992,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (263190,95992,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (263190);

-- 96438 Battle at the Mannoroc Coven (level 40, min 35, live build 1.60.1.70959, 1 player(s)); next quest 79939 is not in our world yet, so RewardNextQuest is 0
DELETE FROM `quest_template` WHERE `ID`=96438;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (96438,2,-141,0,0,4,1.0,0,1.0,0,0,0,0,0,0,6130900294268439629,'Battle at the Mannoroc Coven','Investigate the battle at the Mannoroc Coven in Desolace.','$n, I need your aid. One of our brothers passing through Nigel''s Point in Desolace overheard details of a battle that took place at the Mannoroc Coven. It was reported that one side brought powerful holy magic to bear in the battle against the warlocks there. Wielders of the light were certainly involved.

I''d like to learn more of who was involved in this skirmish. If one of our people was involved--or fell there... I want to know about it.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=96438;
DELETE FROM `quest_template_addon` WHERE `ID`=96438;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (96438,0,2,0);
DELETE FROM `quest_classic_money` WHERE `ID`=96438;
DELETE FROM `quest_classic_level` WHERE `ID`=96438;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (96438,40,35,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=96438;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (96438,2,40);
DELETE FROM `creature_queststarter` WHERE `quest`=96438;
DELETE FROM `gameobject_queststarter` WHERE `quest`=96438;
DELETE FROM `creature_questender` WHERE `quest`=96438;
DELETE FROM `gameobject_questender` WHERE `quest`=96438;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (5492,96438,0);
INSERT INTO `gameobject_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (423703,96438,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (5492);

