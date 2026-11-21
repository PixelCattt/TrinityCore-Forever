-- WoW Forever: quests players do on the live realm that our world did not have at all (and Everlake's open data does not
-- add either). Full live record: title, story, objective line, completion line, levels, races, flags, objectives with their
-- live ids, item/choice/reputation/money rewards, start item, next quest.
-- Quest record: Data from Efficient Games (https://efficient.games), licensed under CC BY 4.0
-- (https://creativecommons.org/licenses/by/4.0/). Source: github.com/JIVESCORP/eg-link-output-wowf quests.enUS (players' quest
-- caches) and npcs (who offered and took each quest), builds 70888-70959. Changed: picked and converted to our tables.
-- Givers, turn-ins, classes and the one previous quest also from NorgannonDB (zmarotrix/NorgannonDB, GPL-3.0, built from
-- QuestieDB GPL-3.0, pfQuest MIT and its Collector add-on).
-- Givers and turn-ins missing from both: from Wowhead's WoW Forever quest pages (www.wowhead.com/forever).
-- Only quests whose giver (or start item), turn-in and every objective target exist and are spawned in our world are here;
-- the rest are listed in the kit's quests report with the reason they wait. Reward text is not in the data: none is set.
-- Safe to run again: every row is replaced by key.
-- 81786 Hinterlands Mission I: Defeat Moonkin (level 52, min 47, live build 1.60.1.70959, 1 player(s))
DELETE FROM `quest_template` WHERE `ID`=81786;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardItem1`,`RewardAmount1`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (81786,2,47,1,0,5,1.0,0,1.0,446536,0,4352,0,0,0,18446744073709551615,219927,1,2641,6,0,'Hinterlands Mission I: Defeat Moonkin','Defeat 20 Fallen Moonkin in the Hinterlands Nightmare Incursion at Skulk Rock and return to Field Captain Korlian.','While these demons distract us here, the Emerald Dream is being corrupted into nightmare. Quick, travel through the Emerald Dream Portal in Seradane, and journey to the Nightmare Incursion at Skulk Rock. Defeat moonkin there and return to me.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=81786;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (448821,81786,0,0,1,221330,20,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=81786;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (81786,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=81786;
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES (81786,39300,0);
DELETE FROM `quest_classic_level` WHERE `ID`=81786;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (81786,52,47,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=81786;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (81786,2,52);
DELETE FROM `creature_queststarter` WHERE `quest`=81786;
DELETE FROM `gameobject_queststarter` WHERE `quest`=81786;
DELETE FROM `creature_questender` WHERE `quest`=81786;
DELETE FROM `gameobject_questender` WHERE `quest`=81786;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (221479,81786,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (221479,81786,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (221479);

-- 81787 Hinterlands Mission II: Defeat Giant Turtles (level 52, min 47, live build 1.60.1.70959, 1 player(s))
DELETE FROM `quest_template` WHERE `ID`=81787;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardItem1`,`RewardAmount1`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (81787,2,47,1,0,5,1.0,0,1.0,446536,0,4352,0,0,0,18446744073709551615,219927,1,2641,6,0,'Hinterlands Mission II: Defeat Giant Turtles','Defeat 20 Dreamwater Visejaw in the Hinterlands Nightmare Incursion at Shaol''watha and return to Field Captain Korlian.','While these demons distract us here, the Emerald Dream is being corrupted into nightmare. Quick, travel through the Emerald Dream Portal in Seradane, and journey to the Nightmare Incursion at Shaol''watha. Defeat giant turtles there and return to me.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=81787;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (448822,81787,0,0,0,221328,20,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=81787;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (81787,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=81787;
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES (81787,39300,0);
DELETE FROM `quest_classic_level` WHERE `ID`=81787;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (81787,52,47,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=81787;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (81787,2,52);
DELETE FROM `creature_queststarter` WHERE `quest`=81787;
DELETE FROM `gameobject_queststarter` WHERE `quest`=81787;
DELETE FROM `creature_questender` WHERE `quest`=81787;
DELETE FROM `gameobject_questender` WHERE `quest`=81787;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (221479,81787,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (221479,81787,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (221479);

-- 81788 Hinterlands Mission III: Defeat Dragonkin (level 52, min 47, live build 1.60.1.70959, 1 player(s))
DELETE FROM `quest_template` WHERE `ID`=81788;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardItem1`,`RewardAmount1`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (81788,2,47,1,0,5,1.0,0,1.0,446536,0,4352,0,0,0,18446744073709551615,219927,1,2641,6,0,'Hinterlands Mission III: Defeat Dragonkin','Defeat 10 Wrath Whelps and 3 Wyrmkin Starhunters in the Hinterlands Nightmare Incursion at Agol''watha and return to Field Captain Korlian.','While these demons distract us here, the Emerald Dream is being corrupted into nightmare. Quick, travel through the Emerald Dream Portal in Seradane, and journey to the Nightmare Incursion at Agol''watha. Defeat dragonkin there and return to me.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=81788;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (448823,81788,0,0,1,221326,10,0,1,NULL,70959),(448824,81788,0,1,2,221325,3,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=81788;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (81788,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=81788;
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES (81788,39300,0);
DELETE FROM `quest_classic_level` WHERE `ID`=81788;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (81788,52,47,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=81788;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (81788,2,52);
DELETE FROM `creature_queststarter` WHERE `quest`=81788;
DELETE FROM `gameobject_queststarter` WHERE `quest`=81788;
DELETE FROM `creature_questender` WHERE `quest`=81788;
DELETE FROM `gameobject_questender` WHERE `quest`=81788;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (221479,81788,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (221479,81788,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (221479);

-- 81838 Hinterlands Mission XIV: Defeat Doomkin (level 52, min 47, live build 1.60.1.70888, 1 player(s))
DELETE FROM `quest_template` WHERE `ID`=81838;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardItem1`,`RewardAmount1`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (81838,2,47,1,0,5,1.0,0,1.0,446536,0,4352,0,0,0,18446744073709551615,219927,1,2641,6,0,'Hinterlands Mission XIV: Defeat Doomkin','Defeat the Doomkin in the Hinterlands Nightmare Incursion on the deep ledge inside Skulk Rock and return to Field Captain Korlian.','While these demons distract us here, the Emerald Dream is being corrupted into nightmare. Quick, travel through the Emerald Dream Portal in Seradane, and journey to the Nightmare Incursion at Skulk Rock. Defeat the giant moonkin known as the Doomkin there and return to me.','','',70888);
DELETE FROM `quest_objectives` WHERE `QuestID`=81838;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (448878,81838,0,0,0,221333,1,0,1,NULL,70888);
DELETE FROM `quest_template_addon` WHERE `ID`=81838;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (81838,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=81838;
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES (81838,1900,0);
DELETE FROM `quest_classic_level` WHERE `ID`=81838;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (81838,52,47,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=81838;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (81838,2,52);
DELETE FROM `creature_queststarter` WHERE `quest`=81838;
DELETE FROM `gameobject_queststarter` WHERE `quest`=81838;
DELETE FROM `creature_questender` WHERE `quest`=81838;
DELETE FROM `gameobject_questender` WHERE `quest`=81838;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (221479,81838,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (221479,81838,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (221479);

-- 84151 An Earnest Proposition (level 60, min 58, live build 1.60.1.70959, 1 player(s))
DELETE FROM `quest_template` WHERE `ID`=84151;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (84151,2,1537,81,0,5,2.0,0,1.0,0,0,264,0,0,0,18446744073709551615,226953,1,226949,1,'An Earnest Proposition','Acquire 15 Winterspring Blood Samples and 20 gold and bring them along with 1 set of Devout Bracers to Deliana in Ironforge.','Well met, $c.  I''ve something that might interest you.

I have in my possession a set of armor much like the one worn by those of your profession, but of much higher quality.  I''d be willing to trade the bracers for ordinary ones in exchange for a small favor.

The blood of the frostsabers and bears that inhabit Winterspring has properties I''m in need of at the moment.  Bring me a sizeable sample of it along with the bracers and a small amount of gold.  You shall find the effort worth your while.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=84151;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (451814,84151,1,0,0,21928,15,0,1,NULL,70959),(451815,84151,1,1,1,16697,1,0,1,NULL,70959),(451816,84151,8,2,-1,0,200000,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=84151;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (84151,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=84151;
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES (84151,-200000,0);
DELETE FROM `quest_classic_level` WHERE `ID`=84151;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (84151,60,58,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=84151;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (84151,2,60);
DELETE FROM `creature_queststarter` WHERE `quest`=84151;
DELETE FROM `gameobject_queststarter` WHERE `quest`=84151;
DELETE FROM `creature_questender` WHERE `quest`=84151;
DELETE FROM `gameobject_questender` WHERE `quest`=84151;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (230319,84151,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (230319,84151,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (230319);

-- 84152 An Earnest Proposition (level 60, min 58, live build 1.60.1.70959, 2 player(s))
DELETE FROM `quest_template` WHERE `ID`=84152;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardItem1`,`RewardAmount1`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (84152,2,1537,81,0,5,2.0,0,1.0,0,0,264,0,0,0,18446744073709551615,226830,1,'An Earnest Proposition','Acquire 15 Winterspring Blood Samples and 20 gold and bring them along with a set of Shadowcraft Bracers to Deliana in Ironforge.
','Well met, $c.  I''ve something that might interest you.

I have in my possession a set of armor much like the one worn by those of your profession, but of much higher quality.  I''d be willing to trade the bracers for ordinary ones in exchange for a small favor.

The blood of the frostsabers and bears that inhabit Winterspring has properties I''m in need of at the moment.  Bring me a sizeable sample of it along with the bracers and a small amount of gold.  You shall find the effort worth your while.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=84152;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (451820,84152,1,0,0,21928,15,0,1,NULL,70959),(451821,84152,1,1,1,16710,1,0,1,NULL,70959),(451822,84152,8,2,-1,0,200000,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=84152;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (84152,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=84152;
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES (84152,-200000,0);
DELETE FROM `quest_classic_level` WHERE `ID`=84152;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (84152,60,58,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=84152;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (84152,2,60);
DELETE FROM `creature_queststarter` WHERE `quest`=84152;
DELETE FROM `gameobject_queststarter` WHERE `quest`=84152;
DELETE FROM `creature_questender` WHERE `quest`=84152;
DELETE FROM `gameobject_questender` WHERE `quest`=84152;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (230319,84152,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (230319,84152,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (230319);

-- 84153 An Earnest Proposition (level 60, min 58, live build 1.60.1.70959, 2 player(s))
DELETE FROM `quest_template` WHERE `ID`=84153;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardItem1`,`RewardAmount1`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (84153,2,1537,81,0,5,2.0,0,1.0,0,0,264,0,0,0,18446744073709551615,226907,1,'An Earnest Proposition','Acquire 15 Winterspring Blood Samples and 20 gold and bring them along with a set of Dreadmist Bracers to Deliana in Ironforge.
','Well met, $c.  I''ve something that might interest you.

I have in my possession a set of armor much like the one worn by those of your profession, but of much higher quality.  I''d be willing to trade the bracers for ordinary ones in exchange for a small favor.

The blood of the frostsabers and bears that inhabit Winterspring has properties I''m in need of at the moment.  Bring me a sizeable sample of it along with the bracers and a small amount of gold.  You shall find the effort worth your while.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=84153;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (451826,84153,1,0,0,21928,15,0,1,NULL,70959),(451827,84153,1,1,1,16703,1,0,1,NULL,70959),(451828,84153,8,2,-1,0,200000,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=84153;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (84153,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=84153;
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES (84153,-200000,0);
DELETE FROM `quest_classic_level` WHERE `ID`=84153;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (84153,60,58,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=84153;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (84153,2,60);
DELETE FROM `creature_queststarter` WHERE `quest`=84153;
DELETE FROM `gameobject_queststarter` WHERE `quest`=84153;
DELETE FROM `creature_questender` WHERE `quest`=84153;
DELETE FROM `gameobject_questender` WHERE `quest`=84153;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (230319,84153,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (230319,84153,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (230319);

-- 84163 Just Compensation (level 60, min 58, live build 1.60.1.70959, 2 player(s))
DELETE FROM `quest_template` WHERE `ID`=84163;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (84163,2,1537,81,8929,7,2.0,0,1.0,0,0,8,0,0,0,6130900294268439629,227337,1,227338,1,227339,1,227340,1,'Just Compensation','Bring a Wildheart Belt and a set of Wildheart Gloves Deliana in Ironforge.','You kept your word and brought the device built by Mux.  I believe a reward is in order if I''m to keep you interested in saving my skin.  Bring me the belt and set of gloves that you wish to upgrade.  I promise the ones I give you in return will be far superior.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=84163;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (451887,84163,1,0,0,16716,1,0,1,NULL,70959),(451888,84163,1,1,1,16717,1,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=84163;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (84163,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=84163;
DELETE FROM `quest_classic_level` WHERE `ID`=84163;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (84163,60,58,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=84163;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (84163,2,60);
DELETE FROM `creature_queststarter` WHERE `quest`=84163;
DELETE FROM `gameobject_queststarter` WHERE `quest`=84163;
DELETE FROM `creature_questender` WHERE `quest`=84163;
DELETE FROM `gameobject_questender` WHERE `quest`=84163;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (230319,84163,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (230319,84163,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (230319);

-- 84164 Just Compensation (level 60, min 58, live build 1.60.1.70959, 1 player(s))
DELETE FROM `quest_template` WHERE `ID`=84164;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardItem1`,`RewardAmount1`,`RewardItem2`,`RewardAmount2`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (84164,2,1537,81,8929,7,2.0,0,1.0,0,0,8,0,0,0,6130900294268439629,226883,1,226888,1,'Just Compensation','Bring a Beaststalker''s Belt and a set of Beaststalker''s Gloves to Deliana in Ironforge.','You kept your word and brought the device built by Mux.  I believe a reward is in order if I''m to keep you interested in saving my skin.  Bring me an ordinary belt and a set of gloves that you wish to upgrade.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=84164;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (451891,84164,1,0,0,16680,1,0,1,NULL,70959),(451892,84164,1,1,1,16676,1,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=84164;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (84164,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=84164;
DELETE FROM `quest_classic_level` WHERE `ID`=84164;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (84164,60,58,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=84164;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (84164,2,60);
DELETE FROM `creature_queststarter` WHERE `quest`=84164;
DELETE FROM `gameobject_queststarter` WHERE `quest`=84164;
DELETE FROM `creature_questender` WHERE `quest`=84164;
DELETE FROM `gameobject_questender` WHERE `quest`=84164;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (230319,84164,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (230319,84164,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (230319);

-- 84165 Just Compensation (level 60, min 58, live build 1.60.1.70938, 2 player(s))
DELETE FROM `quest_template` WHERE `ID`=84165;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardItem1`,`RewardAmount1`,`RewardItem2`,`RewardAmount2`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (84165,2,1537,81,8929,7,2.0,0,1.0,0,0,8,0,0,0,6130900294268439629,226934,1,226930,1,'Just Compensation','Bring a Magister''s Belt and a set of Magister''s Gloves to Deliana in Ironforge.
','You kept your word and brought the device built by Mux.  I believe a reward is in order if I''m to keep you interested in saving my skin.  Bring me an ordinary belt and a set of gloves that you wish to upgrade.','','',70938);
DELETE FROM `quest_objectives` WHERE `QuestID`=84165;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (451895,84165,1,0,0,16685,1,0,1,NULL,70938),(451896,84165,1,1,1,16684,1,0,1,NULL,70938);
DELETE FROM `quest_template_addon` WHERE `ID`=84165;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (84165,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=84165;
DELETE FROM `quest_classic_level` WHERE `ID`=84165;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (84165,60,58,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=84165;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (84165,2,60);
DELETE FROM `creature_queststarter` WHERE `quest`=84165;
DELETE FROM `gameobject_queststarter` WHERE `quest`=84165;
DELETE FROM `creature_questender` WHERE `quest`=84165;
DELETE FROM `gameobject_questender` WHERE `quest`=84165;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (230319,84165,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (230319,84165,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (230319);

-- 84166 Just Compensation (level 60, min 58, live build 1.60.1.70959, 1 player(s))
DELETE FROM `quest_template` WHERE `ID`=84166;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (84166,2,1537,81,8929,7,2.0,0,1.0,0,0,8,0,0,0,6130900294268439629,227343,1,227344,1,227345,1,'Just Compensation','Bring a Lightforge Belt and a set of Lightforge Gauntlets to Deliana in Ironforge.
','You kept your word and brought the device built by Mux.  I believe a reward is in order if I''m to keep you interested in saving my skin.  Bring me the belt and set of gauntlets that you wish to upgrade.  I promise the ones I give you in return will be far superior.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=84166;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (451899,84166,1,0,0,16723,1,0,1,NULL,70959),(451900,84166,1,1,1,16724,1,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=84166;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (84166,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=84166;
DELETE FROM `quest_classic_level` WHERE `ID`=84166;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (84166,60,58,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=84166;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (84166,2,60);
DELETE FROM `creature_queststarter` WHERE `quest`=84166;
DELETE FROM `gameobject_queststarter` WHERE `quest`=84166;
DELETE FROM `creature_questender` WHERE `quest`=84166;
DELETE FROM `gameobject_questender` WHERE `quest`=84166;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (230319,84166,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (230319,84166,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (230319);

-- 84167 Just Compensation (level 60, min 58, live build 1.60.1.70959, 2 player(s))
DELETE FROM `quest_template` WHERE `ID`=84167;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (84167,2,1537,81,8929,7,2.0,0,1.0,0,0,8,0,0,0,6130900294268439629,227346,1,227347,1,'Just Compensation','Bring a Devout Belt and a set of Devout Gloves to Deliana in Ironforge.','You kept your word and brought the device built by Mux.  I believe a reward is in order if I''m to keep you interested in saving my skin.  Bring me the belt and set of gloves that you wish to upgrade.  I promise the ones I give you in return will be far superior.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=84167;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (451903,84167,1,0,0,16696,1,0,1,NULL,70959),(451904,84167,1,1,1,16692,1,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=84167;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (84167,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=84167;
DELETE FROM `quest_classic_level` WHERE `ID`=84167;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (84167,60,58,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=84167;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (84167,2,60);
DELETE FROM `creature_queststarter` WHERE `quest`=84167;
DELETE FROM `gameobject_queststarter` WHERE `quest`=84167;
DELETE FROM `creature_questender` WHERE `quest`=84167;
DELETE FROM `gameobject_questender` WHERE `quest`=84167;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (230319,84167,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (230319,84167,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (230319);

-- 84168 Just Compensation (level 60, min 58, live build 1.60.1.70938, 3 player(s))
DELETE FROM `quest_template` WHERE `ID`=84168;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardItem1`,`RewardAmount1`,`RewardItem2`,`RewardAmount2`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (84168,2,1537,81,8929,7,2.0,0,1.0,0,0,8,0,0,0,6130900294268439629,226828,1,226832,1,'Just Compensation','Bring a Shadowcraft Belt and a set of Shadowcraft Gloves to Deliana in Ironforge.','You kept your word and brought the device built by Mux.  I believe a reward is in order if I''m to keep you interested in saving my skin.  Bring me the belt and set of gloves that you wish to upgrade.  I promise the ones I give you in return will be far superior.','','',70938);
DELETE FROM `quest_objectives` WHERE `QuestID`=84168;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (451907,84168,1,0,0,16713,1,0,1,NULL,70938),(451908,84168,1,1,1,16712,1,0,1,NULL,70938);
DELETE FROM `quest_template_addon` WHERE `ID`=84168;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (84168,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=84168;
DELETE FROM `quest_classic_level` WHERE `ID`=84168;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (84168,60,58,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=84168;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (84168,2,60);
DELETE FROM `creature_queststarter` WHERE `quest`=84168;
DELETE FROM `gameobject_queststarter` WHERE `quest`=84168;
DELETE FROM `creature_questender` WHERE `quest`=84168;
DELETE FROM `gameobject_questender` WHERE `quest`=84168;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (230319,84168,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (230319,84168,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (230319);

-- 84170 Just Compensation (level 60, min 58, live build 1.60.1.70959, 2 player(s))
DELETE FROM `quest_template` WHERE `ID`=84170;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (84170,2,1537,81,8929,7,2.0,0,1.0,0,0,8,0,0,0,6130900294268439629,227356,1,227357,1,'Just Compensation','Bring a Belt of Valor and a set of Gauntlets of Valor to Deliana in Ironforge.','You kept your word and brought the device built by Mux.  I believe a reward is in order if I''m to keep you interested in saving my skin.  Bring me the belt and set of gauntlets that you wish to upgrade.  I promise the ones I give you in return will be far superior.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=84170;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (451915,84170,1,0,0,16736,1,0,1,NULL,70959),(451916,84170,1,1,1,16737,1,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=84170;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (84170,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=84170;
DELETE FROM `quest_classic_level` WHERE `ID`=84170;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (84170,60,58,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=84170;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (84170,2,60);
DELETE FROM `creature_queststarter` WHERE `quest`=84170;
DELETE FROM `gameobject_queststarter` WHERE `quest`=84170;
DELETE FROM `creature_questender` WHERE `quest`=84170;
DELETE FROM `gameobject_questender` WHERE `quest`=84170;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (230319,84170,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (230319,84170,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (230319);

-- 84171 Just Compensation (level 60, min 58, live build 1.60.1.70938, 3 player(s))
DELETE FROM `quest_template` WHERE `ID`=84171;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (84171,2,1637,81,8930,7,1.0,0,1.0,0,0,8,0,0,0,12261800583900083122,227337,1,227338,1,227339,1,227340,1,'Just Compensation','Bring a Wildheart Belt and a set of Wildheart Gloves to Mokvar in Orgrimmar.','You''ve proven to be a very reliable individual, $n.  As much as I trust that you''ll help me through this predicament, it would be wise of me to reward you according to your performance.

For now I will exchange your belt and gloves.  If we both see this through I shall make the rest of the pieces available to you.','','',70938);
DELETE FROM `quest_objectives` WHERE `QuestID`=84171;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (451919,84171,1,0,0,16716,1,0,1,NULL,70938),(451920,84171,1,1,1,16717,1,0,1,NULL,70938);
DELETE FROM `quest_template_addon` WHERE `ID`=84171;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (84171,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=84171;
DELETE FROM `quest_classic_level` WHERE `ID`=84171;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (84171,60,58,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=84171;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (84171,2,60);
DELETE FROM `creature_queststarter` WHERE `quest`=84171;
DELETE FROM `gameobject_queststarter` WHERE `quest`=84171;
DELETE FROM `creature_questender` WHERE `quest`=84171;
DELETE FROM `gameobject_questender` WHERE `quest`=84171;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (230317,84171,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (230317,84171,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (230317);

-- 84172 Just Compensation (level 60, min 58, live build 1.60.1.70959, 2 player(s))
DELETE FROM `quest_template` WHERE `ID`=84172;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardItem1`,`RewardAmount1`,`RewardItem2`,`RewardAmount2`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (84172,2,1637,81,8930,7,1.0,0,1.0,0,0,8,0,0,0,12261800583900083122,226883,1,226888,1,'Just Compensation','Bring a Beaststalker''s Belt and a set of Beaststalker''s Gloves to Mokvar in Orgrimmar.','You''ve proven to be a very reliable individual, $n.  As much as I trust that you''ll help me through this predicament, it would be wise of me to reward you according to your performance.

For now I will exchange your belt and gloves.  If we both see this through I shall make the rest of the pieces available to you.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=84172;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (451923,84172,1,0,0,16680,1,0,1,NULL,70959),(451924,84172,1,1,1,16676,1,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=84172;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (84172,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=84172;
DELETE FROM `quest_classic_level` WHERE `ID`=84172;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (84172,60,58,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=84172;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (84172,2,60);
DELETE FROM `creature_queststarter` WHERE `quest`=84172;
DELETE FROM `gameobject_queststarter` WHERE `quest`=84172;
DELETE FROM `creature_questender` WHERE `quest`=84172;
DELETE FROM `gameobject_questender` WHERE `quest`=84172;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (230317,84172,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (230317,84172,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (230317);

-- 84173 Just Compensation (level 60, min 58, live build 1.60.1.70959, 3 player(s))
DELETE FROM `quest_template` WHERE `ID`=84173;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardItem1`,`RewardAmount1`,`RewardItem2`,`RewardAmount2`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (84173,2,1637,81,8930,7,1.0,0,1.0,0,0,8,0,0,0,12261800583900083122,226934,1,226930,1,'Just Compensation','Bring a Magister''s Belt and a set of Magister''s Gloves to Mokvar in Orgrimmar.','You''ve proven to be a very reliable individual, $n.  As much as I trust that you''ll help me through this predicament, it would be wise of me to reward you according to your performance.

For now I will exchange your belt and gloves.  If we both see this through I shall make the rest of the pieces available to you.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=84173;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (451927,84173,1,0,0,16685,1,0,1,NULL,70959),(451928,84173,1,1,1,16684,1,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=84173;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (84173,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=84173;
DELETE FROM `quest_classic_level` WHERE `ID`=84173;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (84173,60,58,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=84173;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (84173,2,60);
DELETE FROM `creature_queststarter` WHERE `quest`=84173;
DELETE FROM `gameobject_queststarter` WHERE `quest`=84173;
DELETE FROM `creature_questender` WHERE `quest`=84173;
DELETE FROM `gameobject_questender` WHERE `quest`=84173;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (230317,84173,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (230317,84173,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (230317);

-- 84174 Just Compensation (level 60, min 58, live build 1.60.1.70959, 1 player(s))
DELETE FROM `quest_template` WHERE `ID`=84174;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (84174,2,1637,81,8930,7,1.0,0,1.0,0,0,8,0,0,0,12261800583900083122,227346,1,227347,1,'Just Compensation','Bring a Devout Belt and a set of Devout Gloves to Mokvar in Orgrimmar.','You''ve proven to be a very reliable individual, $n.  As much as I trust that you''ll help me through this predicament, it would be wise of me to reward you according to your performance.

For now I will exchange your belt and gloves.  If we both see this through I shall make the rest of the pieces available to you.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=84174;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (451931,84174,1,0,0,16696,1,0,1,NULL,70959),(451932,84174,1,1,1,16692,1,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=84174;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (84174,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=84174;
DELETE FROM `quest_classic_level` WHERE `ID`=84174;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (84174,60,58,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=84174;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (84174,2,60);
DELETE FROM `creature_queststarter` WHERE `quest`=84174;
DELETE FROM `gameobject_queststarter` WHERE `quest`=84174;
DELETE FROM `creature_questender` WHERE `quest`=84174;
DELETE FROM `gameobject_questender` WHERE `quest`=84174;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (230317,84174,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (230317,84174,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (230317);

-- 84175 Just Compensation (level 60, min 58, live build 1.60.1.70959, 2 player(s))
DELETE FROM `quest_template` WHERE `ID`=84175;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardItem1`,`RewardAmount1`,`RewardItem2`,`RewardAmount2`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (84175,2,1637,81,8930,7,1.0,0,1.0,0,0,8,0,0,0,12261800583900083122,226828,1,226832,1,'Just Compensation','Bring a Shadowcraft Belt and a set of Shadowcraft Gloves to Mokvar in Orgrimmar.','You''ve proven to be a very reliable individual, $n.  As much as I trust that you''ll help me through this predicament, it would be wise of me to reward you according to your performance.

For now I will exchange your belt and gloves.  If we both see this through I shall make the rest of the pieces available to you.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=84175;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (451935,84175,1,0,0,16713,1,0,1,NULL,70959),(451936,84175,1,1,1,16712,1,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=84175;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (84175,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=84175;
DELETE FROM `quest_classic_level` WHERE `ID`=84175;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (84175,60,58,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=84175;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (84175,2,60);
DELETE FROM `creature_queststarter` WHERE `quest`=84175;
DELETE FROM `gameobject_queststarter` WHERE `quest`=84175;
DELETE FROM `creature_questender` WHERE `quest`=84175;
DELETE FROM `gameobject_questender` WHERE `quest`=84175;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (230317,84175,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (230317,84175,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (230317);

-- 84176 Just Compensation (level 60, min 58, live build 1.60.1.70959, 2 player(s))
DELETE FROM `quest_template` WHERE `ID`=84176;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (84176,2,1637,81,8930,7,1.0,0,1.0,0,0,8,0,0,0,12261800583900083122,227350,1,227351,1,227352,1,'Just Compensation','Bring a Cord of the Elements and a set of Gauntlets of the Elements to Mokvar in Orgrimmar.
','You''ve proven to be a very reliable individual, $n.  As much as I trust that you''ll help me through this predicament, it would be wise of me to reward you according to your performance.

For now I will exchange your belt and gauntlets.  If we both see this through I shall make the rest of the pieces available to you.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=84176;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (451939,84176,1,0,0,16673,1,0,1,NULL,70959),(451940,84176,1,1,1,16672,1,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=84176;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (84176,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=84176;
DELETE FROM `quest_classic_level` WHERE `ID`=84176;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (84176,60,58,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=84176;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (84176,2,60);
DELETE FROM `creature_queststarter` WHERE `quest`=84176;
DELETE FROM `gameobject_queststarter` WHERE `quest`=84176;
DELETE FROM `creature_questender` WHERE `quest`=84176;
DELETE FROM `gameobject_questender` WHERE `quest`=84176;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (230317,84176,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (230317,84176,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (230317);

-- 84177 Just Compensation (level 60, min 58, live build 1.60.1.70959, 2 player(s))
DELETE FROM `quest_template` WHERE `ID`=84177;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardItem1`,`RewardAmount1`,`RewardItem2`,`RewardAmount2`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (84177,2,1637,81,8930,7,1.0,0,1.0,0,0,8,0,0,0,12261800583900083122,226911,1,226905,1,'Just Compensation','Bring a Dreadmist Belt and a set of Dreadmist Wraps to Mokvar in Orgrimmar.
','You''ve proven to be a very reliable individual, $n.  As much as I trust that you''ll help me through this predicament, it would be wise of me to reward you according to your performance.

For now I will exchange your belt and gloves.  If we both see this through I shall make the rest of the pieces available to you.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=84177;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (451943,84177,1,0,0,16702,1,0,1,NULL,70959),(451944,84177,1,1,1,16705,1,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=84177;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (84177,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=84177;
DELETE FROM `quest_classic_level` WHERE `ID`=84177;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (84177,60,58,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=84177;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (84177,2,60);
DELETE FROM `creature_queststarter` WHERE `quest`=84177;
DELETE FROM `gameobject_queststarter` WHERE `quest`=84177;
DELETE FROM `creature_questender` WHERE `quest`=84177;
DELETE FROM `gameobject_questender` WHERE `quest`=84177;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (230317,84177,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (230317,84177,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (230317);

-- 84178 Just Compensation (level 60, min 58, live build 1.60.1.70959, 1 player(s))
DELETE FROM `quest_template` WHERE `ID`=84178;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (84178,2,1637,81,8930,7,1.0,0,1.0,0,0,8,0,0,0,12261800583900083122,227356,1,227357,1,'Just Compensation','Bring a Belt of Valor and a set of Gauntlets of Valor to Mokvar in Orgrimmar.
','You''ve proven to be a very reliable individual, $n.  As much as I trust that you''ll help me through this predicament, it would be wise of me to reward you according to your performance.

For now I will exchange your belt and gauntlets.  If we both see this through I shall make the rest of the pieces available to you.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=84178;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (451947,84178,1,0,0,16736,1,0,1,NULL,70959),(451948,84178,1,1,1,16737,1,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=84178;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (84178,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=84178;
DELETE FROM `quest_classic_level` WHERE `ID`=84178;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (84178,60,58,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=84178;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (84178,2,60);
DELETE FROM `creature_queststarter` WHERE `quest`=84178;
DELETE FROM `gameobject_queststarter` WHERE `quest`=84178;
DELETE FROM `creature_questender` WHERE `quest`=84178;
DELETE FROM `gameobject_questender` WHERE `quest`=84178;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (230317,84178,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (230317,84178,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (230317);

-- 84179 Anthion's Parting Words (level 60, min 58, live build 1.60.1.70959, 2 player(s))
DELETE FROM `quest_template` WHERE `ID`=84179;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (84179,2,1537,81,8960,7,2.0,0,1.0,0,22047,0,0,0,0,6130900294268439629,227359,1,227360,1,227361,1,227365,1,'Anthion''s Parting Words','Return to Deliana in Ironforge with a set of Wildheart Boots, a Wildheart Kilt and Wildheart Spaulders.','Valthalak''s soul was stored in this amulet.  In our greed we foolishly split it into three parts, not knowing the curse that would await us.

The only way to stop Valthalak''s spell is to put the medallion back together.  Return to Deliana and tell her that Bodley is her only hope for finding the remaining pieces.  Speak to her about any rewards you''ve arranged for.

I, for once, shall rest in peace.  I wish you the best of luck; you shall need every bit of it!','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=84179;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (451952,84179,1,0,0,16715,1,0,1,NULL,70959),(451953,84179,1,1,1,16719,1,0,1,NULL,70959),(451954,84179,1,2,2,16718,1,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=84179;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (84179,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=84179;
DELETE FROM `quest_classic_level` WHERE `ID`=84179;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (84179,60,58,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=84179;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (84179,2,60);
DELETE FROM `creature_queststarter` WHERE `quest`=84179;
DELETE FROM `gameobject_queststarter` WHERE `quest`=84179;
DELETE FROM `creature_questender` WHERE `quest`=84179;
DELETE FROM `gameobject_questender` WHERE `quest`=84179;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (16016,84179,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (230319,84179,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (16016,230319);

-- 84181 Anthion's Parting Words (level 60, min 58, live build 1.60.1.70959, 1 player(s))
DELETE FROM `quest_template` WHERE `ID`=84181;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardItem1`,`RewardAmount1`,`RewardItem2`,`RewardAmount2`,`RewardItem3`,`RewardAmount3`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (84181,2,1537,81,8960,7,2.0,0,1.0,0,22047,0,0,0,0,6130900294268439629,226931,1,226933,1,226936,1,'Anthion''s Parting Words','Return to Deliana in Ironforge with a set of Magister''s Boots, Magister''s Leggings and Magister''s Mantle.','Valthalak''s soul was stored in this amulet.  In our greed we foolishly split it into three parts, not knowing the curse that would await us.

The only way to stop Valthalak''s spell is to put the medallion back together.  Return to Deliana and tell her that Bodley is her only hope for finding the remaining pieces.  Speak to her about any rewards you''ve arranged for.

I, for once, shall rest in peace.  I wish you the best of luck; you shall need every bit of it!','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=84181;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (451964,84181,1,0,0,16682,1,0,1,NULL,70959),(451965,84181,1,1,1,16687,1,0,1,NULL,70959),(451966,84181,1,2,2,16689,1,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=84181;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (84181,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=84181;
DELETE FROM `quest_classic_level` WHERE `ID`=84181;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (84181,60,58,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=84181;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (84181,2,60);
DELETE FROM `creature_queststarter` WHERE `quest`=84181;
DELETE FROM `gameobject_queststarter` WHERE `quest`=84181;
DELETE FROM `creature_questender` WHERE `quest`=84181;
DELETE FROM `gameobject_questender` WHERE `quest`=84181;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (16016,84181,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (230319,84181,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (16016,230319);

-- 84182 Anthion's Parting Words (level 60, min 58, live build 1.60.1.70959, 2 player(s))
DELETE FROM `quest_template` WHERE `ID`=84182;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (84182,2,1537,81,8960,7,2.0,0,1.0,0,22047,0,0,0,0,6130900294268439629,227368,1,227369,1,227370,1,'Anthion''s Parting Words','Return to Deliana in Ironforge with a set of Lightforge Boots, Lightforge Legplates and Lightforge Spaulders.','Valthalak''s soul was stored in this amulet.  In our greed we foolishly split it into three parts, not knowing the curse that would await us.

The only way to stop Valthalak''s spell is to put the medallion back together.  Return to Deliana and tell her that Bodley is her only hope for finding the remaining pieces.  Speak to her about any rewards you''ve arranged for.

I, for once, shall rest in peace.  I wish you the best of luck; you shall need every bit of it!','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=84182;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (451970,84182,1,0,0,16725,1,0,1,NULL,70959),(451971,84182,1,1,1,16728,1,0,1,NULL,70959),(451972,84182,1,2,2,16729,1,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=84182;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (84182,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=84182;
DELETE FROM `quest_classic_level` WHERE `ID`=84182;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (84182,60,58,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=84182;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (84182,2,60);
DELETE FROM `creature_queststarter` WHERE `quest`=84182;
DELETE FROM `gameobject_queststarter` WHERE `quest`=84182;
DELETE FROM `creature_questender` WHERE `quest`=84182;
DELETE FROM `gameobject_questender` WHERE `quest`=84182;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (16016,84182,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (230319,84182,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (16016,230319);

-- 84183 Anthion's Parting Words (level 60, min 58, live build 1.60.1.70959, 2 player(s))
DELETE FROM `quest_template` WHERE `ID`=84183;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (84183,2,1537,81,8960,7,2.0,0,1.0,0,22047,0,0,0,0,6130900294268439629,227371,1,227372,1,'Anthion''s Parting Words','Return to Deliana in Ironforge with a set of Devout Sandals, Devout Skirt and Devout Mantle.','Valthalak''s soul was stored in this amulet.  In our greed we foolishly split it into three parts, not knowing the curse that would await us.

The only way to stop Valthalak''s spell is to put the medallion back together.  Return to Deliana and tell her that Bodley is her only hope for finding the remaining pieces.  Speak to her about any rewards you''ve arranged for.

I, for once, shall rest in peace.  I wish you the best of luck; you shall need every bit of it!','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=84183;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (451976,84183,1,0,0,16691,1,0,1,NULL,70959),(451977,84183,1,1,1,16694,1,0,1,NULL,70959),(451978,84183,1,2,2,16695,1,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=84183;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (84183,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=84183;
DELETE FROM `quest_classic_level` WHERE `ID`=84183;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (84183,60,58,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=84183;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (84183,2,60);
DELETE FROM `creature_queststarter` WHERE `quest`=84183;
DELETE FROM `gameobject_queststarter` WHERE `quest`=84183;
DELETE FROM `creature_questender` WHERE `quest`=84183;
DELETE FROM `gameobject_questender` WHERE `quest`=84183;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (16016,84183,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (230319,84183,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (16016,230319);

-- 84184 Anthion's Parting Words (level 60, min 58, live build 1.60.1.70959, 3 player(s))
DELETE FROM `quest_template` WHERE `ID`=84184;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardItem1`,`RewardAmount1`,`RewardItem2`,`RewardAmount2`,`RewardItem3`,`RewardAmount3`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (84184,2,1537,81,8960,7,2.0,0,1.0,0,22047,0,0,0,0,6130900294268439629,226831,1,226827,1,226826,1,'Anthion''s Parting Words','Return to Deliana in Ironforge with a set of Shadowcraft Boots, Shadowcraft Pants and Shadowcraft Spaulders.','Valthalak''s soul was stored in this amulet.  In our greed we foolishly split it into three parts, not knowing the curse that would await us.

The only way to stop Valthalak''s spell is to put the medallion back together.  Return to Deliana and tell her that Bodley is her only hope for finding the remaining pieces.  Speak to her about any rewards you''ve arranged for.

I, for once, shall rest in peace.  I wish you the best of luck; you shall need every bit of it!','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=84184;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (451982,84184,1,0,0,16711,1,0,1,NULL,70959),(451983,84184,1,1,1,16709,1,0,1,NULL,70959),(451984,84184,1,2,2,16708,1,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=84184;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (84184,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=84184;
DELETE FROM `quest_classic_level` WHERE `ID`=84184;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (84184,60,58,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=84184;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (84184,2,60);
DELETE FROM `creature_queststarter` WHERE `quest`=84184;
DELETE FROM `gameobject_queststarter` WHERE `quest`=84184;
DELETE FROM `creature_questender` WHERE `quest`=84184;
DELETE FROM `gameobject_questender` WHERE `quest`=84184;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (16016,84184,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (230319,84184,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (16016,230319);

-- 84186 Anthion's Parting Words (level 60, min 58, live build 1.60.1.70959, 1 player(s))
DELETE FROM `quest_template` WHERE `ID`=84186;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (84186,2,1537,81,8960,7,2.0,0,1.0,0,22047,0,0,0,0,6130900294268439629,227381,1,227382,1,'Anthion''s Parting Words','Return to Deliana in Ironforge with a set of Boots of Valor, Legplates of Valor and Spaulders of Valor.','Valthalak''s soul was stored in this amulet.  In our greed we foolishly split it into three parts, not knowing the curse that would await us.

The only way to stop Valthalak''s spell is to put the medallion back together.  Return to Deliana and tell her that Bodley is her only hope for finding the remaining pieces.  Speak to her about any rewards you''ve arranged for.

I, for once, shall rest in peace.  I wish you the best of luck; you shall need every bit of it!','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=84186;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (451994,84186,1,0,0,16734,1,0,1,NULL,70959),(451995,84186,1,1,1,16732,1,0,1,NULL,70959),(451996,84186,1,2,2,16733,1,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=84186;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (84186,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=84186;
DELETE FROM `quest_classic_level` WHERE `ID`=84186;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (84186,60,58,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=84186;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (84186,2,60);
DELETE FROM `creature_queststarter` WHERE `quest`=84186;
DELETE FROM `gameobject_queststarter` WHERE `quest`=84186;
DELETE FROM `creature_questender` WHERE `quest`=84186;
DELETE FROM `gameobject_questender` WHERE `quest`=84186;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (16016,84186,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (230319,84186,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (16016,230319);

-- 84187 Anthion's Parting Words (level 60, min 58, live build 1.60.1.70959, 1 player(s))
DELETE FROM `quest_template` WHERE `ID`=84187;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (84187,2,1637,81,8960,7,1.0,0,1.0,0,22047,0,0,0,0,12261800583900083122,227359,1,227360,1,227361,1,227365,1,'Anthion''s Parting Words','Return to Mokvar in Orgimmar with a set of Wildheart Boots, a Wildheart Kilt and Wildheart Spaulders.
','Valthalak''s soul was stored in this amulet.  In our greed we foolishly split it into three parts, not knowing the curse that would await us.

The only way to stop Valthalak''s spell is to put the amulet back together.  Return to Mokvar and tell him that Bodley is his only hope for finding the remaining pieces.  Speak to him about any rewards you''ve arranged for.

I, for once, shall rest in peace.  I wish you the best of luck; you shall need every bit of it!','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=84187;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (452000,84187,1,0,0,16715,1,0,1,NULL,70959),(452001,84187,1,1,1,16719,1,0,1,NULL,70959),(452002,84187,1,2,2,16718,1,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=84187;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (84187,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=84187;
DELETE FROM `quest_classic_level` WHERE `ID`=84187;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (84187,60,58,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=84187;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (84187,2,60);
DELETE FROM `creature_queststarter` WHERE `quest`=84187;
DELETE FROM `gameobject_queststarter` WHERE `quest`=84187;
DELETE FROM `creature_questender` WHERE `quest`=84187;
DELETE FROM `gameobject_questender` WHERE `quest`=84187;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (16016,84187,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (230317,84187,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (16016,230317);

-- 84188 Anthion's Parting Words (level 60, min 58, live build 1.60.1.70938, 1 player(s))
DELETE FROM `quest_template` WHERE `ID`=84188;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardItem1`,`RewardAmount1`,`RewardItem2`,`RewardAmount2`,`RewardItem3`,`RewardAmount3`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (84188,2,1637,81,8960,7,1.0,0,1.0,0,22047,0,0,0,0,12261800583900083122,226881,1,226882,1,226884,1,'Anthion''s Parting Words','Return to Mokvar in Orgimmar with a set of Beaststalker''s Boots, Beaststalker''s Pants and Beaststalker''s Mantle.','Valthalak''s soul was stored in this amulet.  In our greed we foolishly split it into three parts, not knowing the curse that would await us.

The only way to stop Valthalak''s spell is to put the amulet back together.  Return to Mokvar and tell him that Bodley is his only hope for finding the remaining pieces.  Speak to him about any rewards you''ve arranged for.

I, for once, shall rest in peace.  I wish you the best of luck; you shall need every bit of it!','','',70938);
DELETE FROM `quest_objectives` WHERE `QuestID`=84188;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (452006,84188,1,0,0,16675,1,0,1,NULL,70938),(452007,84188,1,1,1,16678,1,0,1,NULL,70938),(452008,84188,1,2,2,16679,1,0,1,NULL,70938);
DELETE FROM `quest_template_addon` WHERE `ID`=84188;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (84188,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=84188;
DELETE FROM `quest_classic_level` WHERE `ID`=84188;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (84188,60,58,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=84188;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (84188,2,60);
DELETE FROM `creature_queststarter` WHERE `quest`=84188;
DELETE FROM `gameobject_queststarter` WHERE `quest`=84188;
DELETE FROM `creature_questender` WHERE `quest`=84188;
DELETE FROM `gameobject_questender` WHERE `quest`=84188;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (16016,84188,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (230317,84188,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (16016,230317);

-- 84189 Anthion's Parting Words (level 60, min 58, live build 1.60.1.70959, 2 player(s))
DELETE FROM `quest_template` WHERE `ID`=84189;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardItem1`,`RewardAmount1`,`RewardItem2`,`RewardAmount2`,`RewardItem3`,`RewardAmount3`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (84189,2,1637,81,8960,7,1.0,0,1.0,0,21986,0,0,0,0,12261800583900083122,226931,1,226933,1,226936,1,'Anthion''s Parting Words','Return to Mokvar in Orgimmar with a set of Magister''s Boots, Magister''s Leggings and Magister''s Mantle.','Valthalak''s soul was stored in this amulet.  In our greed we foolishly split it into three parts, not knowing the curse that would await us.

The only way to stop Valthalak''s spell is to put the amulet back together.  Return to Mokvar and tell him that Bodley is his only hope for finding the remaining pieces.  Speak to him about any rewards you''ve arranged for.

I, for once, shall rest in peace.  I wish you the best of luck; you shall need every bit of it!','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=84189;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (452012,84189,1,0,0,16682,1,0,1,NULL,70959),(452013,84189,1,1,1,16687,1,0,1,NULL,70959),(452014,84189,1,2,2,16689,1,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=84189;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (84189,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=84189;
DELETE FROM `quest_classic_level` WHERE `ID`=84189;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (84189,60,58,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=84189;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (84189,2,60);
DELETE FROM `creature_queststarter` WHERE `quest`=84189;
DELETE FROM `gameobject_queststarter` WHERE `quest`=84189;
DELETE FROM `creature_questender` WHERE `quest`=84189;
DELETE FROM `gameobject_questender` WHERE `quest`=84189;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (16016,84189,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (230317,84189,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (16016,230317);

-- 84190 Anthion's Parting Words (level 60, min 58, live build 1.60.1.70959, 2 player(s))
DELETE FROM `quest_template` WHERE `ID`=84190;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (84190,2,1637,81,8960,7,1.0,0,1.0,0,22047,0,0,0,0,12261800583900083122,227371,1,227372,1,'Anthion''s Parting Words','Return to Mokvar in Orgimmar with a set of Devout Sandals, Devout Skirt and Devout Mantle.','Valthalak''s soul was stored in this amulet.  In our greed we foolishly split it into three parts, not knowing the curse that would await us.

The only way to stop Valthalak''s spell is to put the amulet back together.  Return to Mokvar and tell him that Bodley is his only hope for finding the remaining pieces.  Speak to him about any rewards you''ve arranged for.

I, for once, shall rest in peace.  I wish you the best of luck; you shall need every bit of it!','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=84190;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (452018,84190,1,0,0,16691,1,0,1,NULL,70959),(452019,84190,1,1,1,16694,1,0,1,NULL,70959),(452020,84190,1,2,2,16695,1,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=84190;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (84190,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=84190;
DELETE FROM `quest_classic_level` WHERE `ID`=84190;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (84190,60,58,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=84190;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (84190,2,60);
DELETE FROM `creature_queststarter` WHERE `quest`=84190;
DELETE FROM `gameobject_queststarter` WHERE `quest`=84190;
DELETE FROM `creature_questender` WHERE `quest`=84190;
DELETE FROM `gameobject_questender` WHERE `quest`=84190;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (16016,84190,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (230317,84190,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (16016,230317);

-- 84191 Anthion's Parting Words (level 60, min 58, live build 1.60.1.70959, 4 player(s))
DELETE FROM `quest_template` WHERE `ID`=84191;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardItem1`,`RewardAmount1`,`RewardItem2`,`RewardAmount2`,`RewardItem3`,`RewardAmount3`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (84191,2,1637,81,8960,7,1.0,0,1.0,0,22047,0,0,0,0,12261800583900083122,226831,1,226827,1,226826,1,'Anthion''s Parting Words','Return to Mokvar in Orgimmar with a set of  Shadowcraft Boots, Shadowcraft Pants and Shadowcraft Spaulders.','Valthalak''s soul was stored in this amulet.  In our greed we foolishly split it into three parts, not knowing the curse that would await us.

The only way to stop Valthalak''s spell is to put the amulet back together.  Return to Mokvar and tell him that Bodley is his only hope for finding the remaining pieces.  Speak to him about any rewards you''ve arranged for.

I, for once, shall rest in peace.  I wish you the best of luck; you shall need every bit of it!','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=84191;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (452024,84191,1,0,0,16711,1,0,1,NULL,70959),(452025,84191,1,1,1,16709,1,0,1,NULL,70959),(452026,84191,1,2,2,16708,1,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=84191;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (84191,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=84191;
DELETE FROM `quest_classic_level` WHERE `ID`=84191;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (84191,60,58,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=84191;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (84191,2,60);
DELETE FROM `creature_queststarter` WHERE `quest`=84191;
DELETE FROM `gameobject_queststarter` WHERE `quest`=84191;
DELETE FROM `creature_questender` WHERE `quest`=84191;
DELETE FROM `gameobject_questender` WHERE `quest`=84191;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (16016,84191,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (230317,84191,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (16016,230317);

-- 84192 Anthion's Parting Words (level 60, min 58, live build 1.60.1.70959, 1 player(s))
DELETE FROM `quest_template` WHERE `ID`=84192;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (84192,2,1637,81,8960,7,1.0,0,1.0,0,22047,0,0,0,0,12261800583900083122,227375,1,227376,1,227377,1,'Anthion''s Parting Words','Return to Mokvar in Orgimmar with a set of Boots of Elements, Kilt of Elements and Pauldrons of Elements.','Valthalak''s soul was stored in this amulet.  In our greed we foolishly split it into three parts, not knowing the curse that would await us.

The only way to stop Valthalak''s spell is to put the amulet back together.  Return to Mokvar and tell him that Bodley is his only hope for finding the remaining pieces.  Speak to him about any rewards you''ve arranged for.

I, for once, shall rest in peace.  I wish you the best of luck; you shall need every bit of it!','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=84192;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (452030,84192,1,0,0,16670,1,0,1,NULL,70959),(452031,84192,1,1,1,16668,1,0,1,NULL,70959),(452032,84192,1,2,2,16669,1,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=84192;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (84192,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=84192;
DELETE FROM `quest_classic_level` WHERE `ID`=84192;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (84192,60,58,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=84192;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (84192,2,60);
DELETE FROM `creature_queststarter` WHERE `quest`=84192;
DELETE FROM `gameobject_queststarter` WHERE `quest`=84192;
DELETE FROM `creature_questender` WHERE `quest`=84192;
DELETE FROM `gameobject_questender` WHERE `quest`=84192;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (16016,84192,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (230317,84192,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (16016,230317);

-- 84193 Anthion's Parting Words (level 60, min 58, live build 1.60.1.70959, 3 player(s))
DELETE FROM `quest_template` WHERE `ID`=84193;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardItem1`,`RewardAmount1`,`RewardItem2`,`RewardAmount2`,`RewardItem3`,`RewardAmount3`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (84193,2,1637,81,8960,7,1.0,0,1.0,0,22047,0,0,0,0,12261800583900083122,226908,1,226910,1,226912,1,'Anthion''s Parting Words','Return to Mokvar in Orgimmar with a set of Dreadmist Sandals, Dreadmist Leggings and Dreadmist Mantle.','Valthalak''s soul was stored in this amulet.  In our greed we foolishly split it into three parts, not knowing the curse that would await us.

The only way to stop Valthalak''s spell is to put the amulet back together.  Return to Mokvar and tell him that Bodley is his only hope for finding the remaining pieces.  Speak to him about any rewards you''ve arranged for.

I, for once, shall rest in peace.  I wish you the best of luck; you shall need every bit of it!','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=84193;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (452036,84193,1,0,0,16704,1,0,1,NULL,70959),(452037,84193,1,1,1,16699,1,0,1,NULL,70959),(452038,84193,1,2,2,16701,1,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=84193;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (84193,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=84193;
DELETE FROM `quest_classic_level` WHERE `ID`=84193;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (84193,60,58,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=84193;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (84193,2,60);
DELETE FROM `creature_queststarter` WHERE `quest`=84193;
DELETE FROM `gameobject_queststarter` WHERE `quest`=84193;
DELETE FROM `creature_questender` WHERE `quest`=84193;
DELETE FROM `gameobject_questender` WHERE `quest`=84193;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (16016,84193,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (230317,84193,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (16016,230317);

-- 84194 Anthion's Parting Words (level 60, min 58, live build 1.60.1.70959, 1 player(s))
DELETE FROM `quest_template` WHERE `ID`=84194;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (84194,2,1637,81,8960,7,1.0,0,1.0,0,22047,0,0,0,0,12261800583900083122,227381,1,227382,1,'Anthion''s Parting Words','Return to Mokvar in Orgimmar with a set of Boots of Valor, Legplates of Valor and Spaulders of Valor.','Valthalak''s soul was stored in this amulet.  In our greed we foolishly split it into three parts, not knowing the curse that would await us.

The only way to stop Valthalak''s spell is to put the amulet back together.  Return to Mokvar and tell him that Bodley is his only hope for finding the remaining pieces.  Speak to him about any rewards you''ve arranged for.

I, for once, shall rest in peace.  I wish you the best of luck; you shall need every bit of it!','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=84194;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (452042,84194,1,0,0,16734,1,0,1,NULL,70959),(452043,84194,1,1,1,16732,1,0,1,NULL,70959),(452044,84194,1,2,2,16733,1,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=84194;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (84194,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=84194;
DELETE FROM `quest_classic_level` WHERE `ID`=84194;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (84194,60,58,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=84194;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (84194,2,60);
DELETE FROM `creature_queststarter` WHERE `quest`=84194;
DELETE FROM `gameobject_queststarter` WHERE `quest`=84194;
DELETE FROM `creature_questender` WHERE `quest`=84194;
DELETE FROM `gameobject_questender` WHERE `quest`=84194;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (16016,84194,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (230317,84194,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (16016,230317);

-- 84202 Saving the Best for Last (level 60, min 58, live build 1.60.1.70959, 2 player(s))
DELETE FROM `quest_template` WHERE `ID`=84202;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (84202,2,1537,81,0,2,2.0,0,1.0,0,0,8,0,0,0,6130900294268439629,227403,1,227404,1,'Saving the Best for Last','Give Deliana your Helm of Valor and Breastplate of Valor.','That''s an amazing story, $n! You have my thanks, and the heartfelt gratitude of all who were involved. Now maybe I''ll be able to sleep at night with both eyes shut.

As to your reward, I believe I have a few things that you''ll really enjoy.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=84202;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (452075,84202,1,0,0,16731,1,0,1,NULL,70959),(452076,84202,1,1,1,16730,1,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=84202;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (84202,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=84202;
DELETE FROM `quest_classic_level` WHERE `ID`=84202;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (84202,60,58,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=84202;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (84202,2,60);
DELETE FROM `creature_queststarter` WHERE `quest`=84202;
DELETE FROM `gameobject_queststarter` WHERE `quest`=84202;
DELETE FROM `creature_questender` WHERE `quest`=84202;
DELETE FROM `gameobject_questender` WHERE `quest`=84202;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (230319,84202,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (230319,84202,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (230319);

-- 84208 Saving the Best for Last (level 60, min 58, live build 1.60.1.70938, 1 player(s))
DELETE FROM `quest_template` WHERE `ID`=84208;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (84208,2,1637,81,0,2,1.0,0,1.0,0,0,8,0,0,0,12261800583900083122,227397,1,227398,1,227399,1,'Saving the Best for Last','Give Mokvar your Coif of Elements and Vest of Elements.','A truly amazing story, $n! You have my thanks, and the heartfelt gratitude of all who were involved, I can assure you. Through your efforts we are delivered from the mistakes of our past.

As to your reward, I believe I have a few things that you have definitely earned and will truly enjoy.','','',70938);
DELETE FROM `quest_objectives` WHERE `QuestID`=84208;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (452099,84208,1,0,0,16667,1,0,1,NULL,70938),(452100,84208,1,1,1,16666,1,0,1,NULL,70938);
DELETE FROM `quest_template_addon` WHERE `ID`=84208;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (84208,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=84208;
DELETE FROM `quest_classic_level` WHERE `ID`=84208;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (84208,60,58,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=84208;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (84208,2,60);
DELETE FROM `creature_queststarter` WHERE `quest`=84208;
DELETE FROM `gameobject_queststarter` WHERE `quest`=84208;
DELETE FROM `creature_questender` WHERE `quest`=84208;
DELETE FROM `gameobject_questender` WHERE `quest`=84208;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (230317,84208,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (230317,84208,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (230317);

-- 84210 Saving the Best for Last (level 60, min 58, live build 1.60.1.70959, 2 player(s))
DELETE FROM `quest_template` WHERE `ID`=84210;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (84210,2,1637,81,0,2,1.0,0,1.0,0,0,8,0,0,0,12261800583900083122,227403,1,227404,1,'Saving the Best for Last','Give Mokvar your Helm of Valor and Breastplate of Valor.','A truly amazing story, $n! You have my thanks, and the heartfelt gratitude of all who were involved, I can assure you. Through your efforts we are delivered from the mistakes of our past.

As to your reward, I believe I have a few things that you have definitely earned and will truly enjoy.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=84210;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (452107,84210,1,0,0,16731,1,0,1,NULL,70959),(452108,84210,1,1,1,16730,1,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=84210;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (84210,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=84210;
DELETE FROM `quest_classic_level` WHERE `ID`=84210;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (84210,60,58,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=84210;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (84210,2,60);
DELETE FROM `creature_queststarter` WHERE `quest`=84210;
DELETE FROM `gameobject_queststarter` WHERE `quest`=84210;
DELETE FROM `creature_questender` WHERE `quest`=84210;
DELETE FROM `gameobject_questender` WHERE `quest`=84210;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (230317,84210,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (230317,84210,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (230317);

-- Dungeon set upgrade quests: the Ironforge ones (Deliana) are Alliance only and the Orgrimmar ones (Mokvar) Horde only, as on
-- live; Anthion offers both versions, so without this each side would also see the other side's copy.
UPDATE `quest_template` SET `AllowableRaces`=6130900294268439629 WHERE `ID` IN (84151,84152,84153,84163,84164,84165,84166,84167,84168,84170,84179,84181,84182,84183,84184,84186,84202);
UPDATE `quest_template` SET `AllowableRaces`=12261800583900083122 WHERE `ID` IN (84171,84172,84173,84174,84175,84176,84177,84178,84187,84188,84189,84190,84191,84192,84193,84194,84208,84210);
