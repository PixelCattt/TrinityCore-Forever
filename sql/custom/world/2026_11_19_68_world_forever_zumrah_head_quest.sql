-- WoW Forever: Zum'rah's head (96775), a quest live has and we lacked. Mazu'kon (264074, Mulgore) gives it; the quest text sends the
-- head back to him, so he takes it too (live data shows him giving it; nobody was seen turning it in yet). Witch Doctor Zum'rah 7271
-- in Zul'Farrak already drops Zum'rah's Head 277112 in our world.
-- Sources (read as data): quest text, levels, objectives, rewards and races are Blizzard's records as players' clients got them
-- on the live realm; givers are what players saw on live: Efficient Games' EG Link export
-- (github.com/JIVESCORP/eg-link-output-wowf, quests.enUS.json and npcs.json, builds 1.60.1.70790-70959).
-- Data from Efficient Games (https://efficient.games), licensed under CC BY 4.0 (https://creativecommons.org/licenses/by/4.0/).
-- Changed: converted to our quest rows. Not in the data, so the same placeholders as 2026_11_11_74: reward text
-- 'Well done, $n. Thank you.' (VerifiedBuild -1).
-- Safe to run again: every key is deleted first.

-- 96775 Zum'rah's Head (live record build 70959): giver 264074 Mazu'kon, turn-in 264074 Mazu'kon (giver seen on live, turn-in from the quest text)
DELETE FROM `quest_template` WHERE `ID`=96775;
INSERT INTO `quest_template` (`ID`,`QuestType`,`LogTitle`,`VerifiedBuild`) VALUES (96775,2,'Zum''rah''s Head',-1);
DELETE FROM `quest_classic_level` WHERE `ID`=96775;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (96775,46,42,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=96775;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (96775,2,46);
DELETE FROM `quest_template_addon` WHERE `ID`=96775;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (96775,0,0,0);
DELETE FROM `quest_offer_reward` WHERE `ID`=96775;
INSERT INTO `quest_offer_reward` (`ID`,`RewardText`,`VerifiedBuild`) VALUES (96775,'Well done, $n. Thank you.',-1);
DELETE FROM `creature_queststarter` WHERE `quest`=96775;
DELETE FROM `gameobject_queststarter` WHERE `quest`=96775;
DELETE FROM `creature_questender` WHERE `quest`=96775;
DELETE FROM `gameobject_questender` WHERE `quest`=96775;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (264074,96775,70959);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (264074,96775,70959);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (264074);
UPDATE `quest_template` SET `QuestDescription`='Ol'' Mazu''kon got a bone to pick with a Witch Doctor that go by the name of Zum''rah and I be thinkin'' you can help me out with that. \n\nZum''rah practice all his bad voodoo in the Sandfury city of Zul''Farrak, far to the south in the deserts of Tanaris. Go there. Kill Zum''rah, and bring me his head.\n\nTrust me mon, the world be a better place with his head stuck on pike outside my hut than it be sittin'' on his shoulders.', `LogDescription`='Slay Witch Doctor Zum''rah and bring Zum''rah''s Head to Mazu''kon in Mulgore.', `AreaDescription`='', `QuestCompletionLog`='', `LogTitle`='Zum''rah''s Head', `QuestSortID`=1176, `QuestInfoID`=81, `RewardNextQuest`=0, `RewardXPDifficulty`=6, `RewardXPMultiplier`=2.0, `RewardSpell`=0, `StartItem`=0, `Flags`=8, `FlagsEx`=0, `AllowableRaces`=12261800583900083122, `TimeAllowed`=0, `VerifiedBuild`=70959, `RewardItem1`=0, `RewardAmount1`=0, `RewardItem2`=0, `RewardAmount2`=0, `RewardItem3`=0, `RewardAmount3`=0, `RewardItem4`=0, `RewardAmount4`=0, `RewardChoiceItemID1`=0, `RewardChoiceItemQuantity1`=0, `RewardChoiceItemID2`=0, `RewardChoiceItemQuantity2`=0, `RewardChoiceItemID3`=0, `RewardChoiceItemQuantity3`=0, `RewardChoiceItemID4`=0, `RewardChoiceItemQuantity4`=0, `RewardChoiceItemID5`=0, `RewardChoiceItemQuantity5`=0, `RewardChoiceItemID6`=0, `RewardChoiceItemQuantity6`=0, `RewardFactionID1`=2787, `RewardFactionValue1`=7, `RewardFactionOverride1`=30000, `RewardFactionID2`=530, `RewardFactionValue2`=6, `RewardFactionOverride2`=0, `RewardFactionID3`=0, `RewardFactionValue3`=0, `RewardFactionOverride3`=0, `RewardFactionID4`=0, `RewardFactionValue4`=0, `RewardFactionOverride4`=0, `RewardFactionID5`=0, `RewardFactionValue5`=0, `RewardFactionOverride5`=0 WHERE `ID`=96775 AND `VerifiedBuild`=-1;
DELETE FROM `quest_objectives` WHERE `QuestID`=96775;
DELETE FROM `quest_objectives` WHERE `ID` IN (475479);
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(475479,96775,1,0,0,277112,1,0,0,0,0.0,0,1,NULL,70959);
DELETE FROM `quest_classic_money` WHERE `ID`=96775;
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES (96775,6500,0);
