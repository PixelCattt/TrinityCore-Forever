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

-- 79939 The Broken Hammer (level 40, min 35, live build 1.60.1.70938, 3 player(s))
DELETE FROM `quest_template` WHERE `ID`=79939;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (79939,2,-141,0,79940,4,1.0,0,1.0,0,215441,0,0,0,0,6130900294268439629,'The Broken Hammer','Recover clues about the recent battle at Mannoroc Coven, and return the Broken Warhammer to Katherine the Pure in Stormwind.','<An ornate broken warhammer lies surrounded by dead Burning Blade Cultists and Scarlet Crusade warriors. A fight clearly happened here, and fairly recently. You also recognize this as the weapon of a paladin of the Order of the Silver Hand. 

While you''ve seen many hammers like this one, the quality and worksmanship of this weapon is fairly unique. You should search the area for clues, and return to Katherine with the broken hammer.>','','',70938);
DELETE FROM `quest_objectives` WHERE `QuestID`=79939;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (446831,79939,1,0,1,215441,1,0,1,NULL,70938),(447347,79939,1,1,2,216956,1,0,1,'Mannoroc Coven Clues',70938),(446830,79939,3,2,0,5492,1,0,1,'Return to Katherine the Pure',70938);
DELETE FROM `quest_template_addon` WHERE `ID`=79939;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (79939,0,2,0);
DELETE FROM `quest_classic_money` WHERE `ID`=79939;
DELETE FROM `quest_classic_level` WHERE `ID`=79939;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (79939,40,35,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=79939;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (79939,2,40);
DELETE FROM `creature_queststarter` WHERE `quest`=79939;
DELETE FROM `gameobject_queststarter` WHERE `quest`=79939;
DELETE FROM `creature_questender` WHERE `quest`=79939;
DELETE FROM `gameobject_questender` WHERE `quest`=79939;
INSERT INTO `gameobject_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (423703,79939,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (5492,79939,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (5492);

