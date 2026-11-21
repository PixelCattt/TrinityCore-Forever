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

-- 80453 Best Laid Plans (level 50, min 45, live build 1.60.1.70959, 3 player(s))
DELETE FROM `quest_template` WHERE `ID`=80453;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (80453,2,-162,0,80454,1,1.0,0,1.0,0,217609,35651840,0,0,0,18446744073709551615,'Best Laid Plans','Bring the Talisman of Kazdor to Zan Shivsprocket in the basement of Ravenholdt Manor.','Take the talisman down to Zan Shivsprocket, in the basement. I''ve asked him to rig the artifact with a mechanism that will detect any attempt to channel magic energy into, or out of, it.

The mechanism is all but invisible to the naked eye, and will detonate when triggered. With any luck, Caius will be killed in the blast. At the very least, his plans for the talisman will be foiled.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=80453;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (448196,80453,1,0,0,217609,1,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=80453;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (80453,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=80453;
DELETE FROM `quest_classic_level` WHERE `ID`=80453;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (80453,50,45,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=80453;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (80453,2,50);
DELETE FROM `creature_queststarter` WHERE `quest`=80453;
DELETE FROM `gameobject_queststarter` WHERE `quest`=80453;
DELETE FROM `creature_questender` WHERE `quest`=80453;
DELETE FROM `gameobject_questender` WHERE `quest`=80453;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (6707,80453,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (6777,80453,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (6707,6777);

-- 80454 One Last Drop (level 50, min 45, live build 1.60.1.70938, 4 player(s))
DELETE FROM `quest_template` WHERE `ID`=80454;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (80454,2,-162,0,80455,5,1.0,0,1.0,0,217737,35651840,0,0,0,18446744073709551615,'One Last Drop','Take the Modified Talisman to Caius'' dead drop near Pyrewood Village.','The bait is ready, now we must lay the trap. I''ve modified the talisman per Fahrad''s instructions. All that''s left is for you to deliver it as you have the other artifacts before.

Go to the cabin near Pyrewood Village, and put this modified talisman into Caius'' dead drop.

What follows is out of our hands, for now.','','',70938);
DELETE FROM `quest_objectives` WHERE `QuestID`=80454;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (448014,80454,1,0,1,217737,1,0,1,NULL,70938);
DELETE FROM `quest_template_addon` WHERE `ID`=80454;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (80454,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=80454;
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES (80454,8225,0);
DELETE FROM `quest_classic_level` WHERE `ID`=80454;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (80454,50,45,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=80454;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (80454,2,50);
DELETE FROM `creature_queststarter` WHERE `quest`=80454;
DELETE FROM `gameobject_queststarter` WHERE `quest`=80454;
DELETE FROM `creature_questender` WHERE `quest`=80454;
DELETE FROM `gameobject_questender` WHERE `quest`=80454;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (6777,80454,0);
INSERT INTO `gameobject_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (410369,80454,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (6777);

-- 80455 Biding Our Time (level 50, min 45, live build 1.60.1.70959, 2 player(s))
DELETE FROM `quest_template` WHERE `ID`=80455;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardItem1`,`RewardAmount1`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (80455,2,-162,0,0,6,2.0,0,1.0,0,0,35651584,0,0,0,18446744073709551615,219343,1,'Biding Our Time','Report back to Fahrad at Ravenholdt Manor.','The job is done. Better return to Ravenholdt and notify Fahrad.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=80455;
DELETE FROM `quest_template_addon` WHERE `ID`=80455;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (80455,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=80455;
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES (80455,14500,0);
DELETE FROM `quest_classic_level` WHERE `ID`=80455;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (80455,50,45,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=80455;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (80455,2,50);
DELETE FROM `creature_queststarter` WHERE `quest`=80455;
DELETE FROM `gameobject_queststarter` WHERE `quest`=80455;
DELETE FROM `creature_questender` WHERE `quest`=80455;
DELETE FROM `gameobject_questender` WHERE `quest`=80455;
INSERT INTO `gameobject_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (410369,80455,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (6707,80455,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (6707);

-- 93443 Lost Shipping Crate (level 36, min 36, live build 1.60.1.70959, 2 player(s))
DELETE FROM `quest_template` WHERE `ID`=93443;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`ItemDrop1`,`ItemDropQuantity1`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (93443,2,33,0,0,1,1.0,0,1.0,0,276067,36700160,0,0,0,6130900294268439629,276067,1,'Lost Shipping Crate','Deliver the Lost Shipping Crate to Friz Frazzlespark at Powderfuse Port in the Riverglades.','<A handwritten label appears on the side of the crate. On the right side is a map with a large red circle along a southeastern shoreline north of a poorly drawn temple surrounded by water and some kind of winged creatures. On the left is a note in massive font.>

PROPERTY OF FRIZ FRAZZLESPARK

POWDERFUSE PORT

WARNING: NOT for tampering. Do NOT open without supervision.

<An additional note appears at the bottom of the label.>

If lost, return to Friz Frazzlespark. Powderfuse Port. Riverglades.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=93443;
DELETE FROM `quest_template_addon` WHERE `ID`=93443;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (93443,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=93443;
DELETE FROM `quest_classic_level` WHERE `ID`=93443;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (93443,36,36,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=93443;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (93443,2,36);
DELETE FROM `creature_queststarter` WHERE `quest`=93443;
DELETE FROM `gameobject_queststarter` WHERE `quest`=93443;
DELETE FROM `creature_questender` WHERE `quest`=93443;
DELETE FROM `gameobject_questender` WHERE `quest`=93443;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (255897,93443,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (255897);

-- 94895 Lost Shipping Crate (level 38, min 36, live build 1.60.1.70959, 3 player(s))
DELETE FROM `quest_template` WHERE `ID`=94895;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`ItemDrop1`,`ItemDropQuantity1`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (94895,2,405,0,0,1,1.0,0,1.0,0,276067,36700160,0,0,0,12261800583900083122,2827,1,0,276067,1,'Lost Shipping Crate','Deliver the Lost Shipping Crate to Friz Frazzlespark at Powderfuse Port in the Riverglades.','<A handwritten label appears on the side of the crate. On the right side is a map with a large red circle along a southeastern shoreline north of a poorly drawn temple surrounded by water and some kind of winged creatures. On the left is a note in massive font.>

PROPERTY OF FRIZ FRAZZLESPARK

POWDERFUSE PORT

WARNING: NOT for tampering. Do NOT open without supervision.

<An additional note appears at the bottom of the label.>

If lost, return to Friz Frazzlespark. Powderfuse Port. Riverglades.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=94895;
DELETE FROM `quest_template_addon` WHERE `ID`=94895;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (94895,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=94895;
DELETE FROM `quest_classic_level` WHERE `ID`=94895;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (94895,38,36,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=94895;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (94895,2,38);
DELETE FROM `creature_queststarter` WHERE `quest`=94895;
DELETE FROM `gameobject_queststarter` WHERE `quest`=94895;
DELETE FROM `creature_questender` WHERE `quest`=94895;
DELETE FROM `gameobject_questender` WHERE `quest`=94895;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (255897,94895,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (255897);

