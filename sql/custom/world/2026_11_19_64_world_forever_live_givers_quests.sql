-- WoW Forever: six quests live has and we lacked, now that players' live data shows who gives and who takes them
-- (2026_11_11_74 held four of them back for "no giver known" / "no turn-in known").
-- Riverglades: On the Other Side 95033 (Tan'jani to Witch Doctor Uzer'i), A Gift From Our Enemies 94480 (Krom'rosh to Gorg),
-- A Serving of Strength 94481 (Gorg), The Goblin Trader 93976 (Kreza Darkthorn to Friz Frazzlespark).
-- Arathi Highlands: Finding Tan'jani 95143 (Tor'gan at Hammerfall to Tan'jani). Swamp of Sorrows: The Visiting Mage 93464 (Magtoor
-- to Azore Aldamort). Every giver, turn-in and kill target is in our world already; none of these needs an object or a drop.
-- Sources (read as data): quest text, levels, objectives, rewards and races are Blizzard's records as players' clients got them
-- on the live realm; givers and turn-ins are what players saw on live: Efficient Games' EG Link export
-- (github.com/JIVESCORP/eg-link-output-wowf, quests.enUS.json and npcs.json, builds 1.60.1.70790-70959).
-- Data from Efficient Games (https://efficient.games), licensed under CC BY 4.0 (https://creativecommons.org/licenses/by/4.0/).
-- Changed: converted to our quest rows. The item a quest hands out at the start (StartItem) is live's.
-- Not in the data, so the same placeholders as 2026_11_11_74: reward text 'Well done, $n. Thank you.' (VerifiedBuild -1).
-- Safe to run again: every key is deleted first.

-- 95143 Finding Tan'jani (live record build 70938): giver 2706 Tor'gan, turn-in 263190 Tan'jani (both seen on live)
DELETE FROM `quest_template` WHERE `ID`=95143;
INSERT INTO `quest_template` (`ID`,`QuestType`,`LogTitle`,`VerifiedBuild`) VALUES (95143,2,'Finding Tan''jani',-1);
DELETE FROM `quest_classic_level` WHERE `ID`=95143;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (95143,38,36,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=95143;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (95143,2,38);
DELETE FROM `quest_template_addon` WHERE `ID`=95143;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (95143,0,0,0);
DELETE FROM `quest_offer_reward` WHERE `ID`=95143;
INSERT INTO `quest_offer_reward` (`ID`,`RewardText`,`VerifiedBuild`) VALUES (95143,'Well done, $n. Thank you.',-1);
DELETE FROM `creature_queststarter` WHERE `quest`=95143;
DELETE FROM `gameobject_queststarter` WHERE `quest`=95143;
DELETE FROM `creature_questender` WHERE `quest`=95143;
DELETE FROM `gameobject_questender` WHERE `quest`=95143;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (2706,95143,70938);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (263190,95143,70938);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (263190,2706);
UPDATE `quest_template` SET `QuestDescription`='I''ve been watching you, $n. You handle yourself well out here. Perhaps you''d be interested in helping me locate my brother, Tan''jani.\n\nHe was always searching for something--for what I do not know. I received two messages since he left. The first from another traveler, letting me know he''d run into Tan''jani somewhere south of Loch Modan. The second was a bloodstained letter mentioning Riverglades and somewhere called Rog''mar, even further south. The rest was illegible.\n\nThink you can locate him for me?', `LogDescription`='Find Tan''jani at Rog''mar in the Riverglades.', `AreaDescription`='', `QuestCompletionLog`='', `LogTitle`='Finding Tan''jani', `QuestSortID`=45, `QuestInfoID`=0, `RewardNextQuest`=0, `RewardXPDifficulty`=1, `RewardXPMultiplier`=1.0, `RewardSpell`=0, `StartItem`=0, `Flags`=33554432, `FlagsEx`=0, `AllowableRaces`=12261800583900083122, `TimeAllowed`=0, `VerifiedBuild`=70938, `RewardItem1`=0, `RewardAmount1`=0, `RewardItem2`=0, `RewardAmount2`=0, `RewardItem3`=0, `RewardAmount3`=0, `RewardItem4`=0, `RewardAmount4`=0, `RewardChoiceItemID1`=0, `RewardChoiceItemQuantity1`=0, `RewardChoiceItemID2`=0, `RewardChoiceItemQuantity2`=0, `RewardChoiceItemID3`=0, `RewardChoiceItemQuantity3`=0, `RewardChoiceItemID4`=0, `RewardChoiceItemQuantity4`=0, `RewardChoiceItemID5`=0, `RewardChoiceItemQuantity5`=0, `RewardChoiceItemID6`=0, `RewardChoiceItemQuantity6`=0, `RewardFactionID1`=76, `RewardFactionValue1`=1, `RewardFactionOverride1`=0, `RewardFactionID2`=0, `RewardFactionValue2`=0, `RewardFactionOverride2`=0, `RewardFactionID3`=0, `RewardFactionValue3`=0, `RewardFactionOverride3`=0, `RewardFactionID4`=0, `RewardFactionValue4`=0, `RewardFactionOverride4`=0, `RewardFactionID5`=0, `RewardFactionValue5`=0, `RewardFactionOverride5`=0 WHERE `ID`=95143 AND `VerifiedBuild`=-1;
DELETE FROM `quest_objectives` WHERE `QuestID`=95143;
DELETE FROM `quest_classic_money` WHERE `ID`=95143;

-- 95033 On the Other Side (live record build 70938): giver 263190 Tan'jani, turn-in 8115 Witch Doctor Uzer'i (both seen on live)
DELETE FROM `quest_template` WHERE `ID`=95033;
INSERT INTO `quest_template` (`ID`,`QuestType`,`LogTitle`,`VerifiedBuild`) VALUES (95033,2,'On the Other Side',-1);
DELETE FROM `quest_classic_level` WHERE `ID`=95033;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (95033,41,40,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=95033;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (95033,2,41);
DELETE FROM `quest_template_addon` WHERE `ID`=95033;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (95033,0,0,0);
DELETE FROM `quest_offer_reward` WHERE `ID`=95033;
INSERT INTO `quest_offer_reward` (`ID`,`RewardText`,`VerifiedBuild`) VALUES (95033,'Well done, $n. Thank you.',-1);
DELETE FROM `creature_queststarter` WHERE `quest`=95033;
DELETE FROM `gameobject_queststarter` WHERE `quest`=95033;
DELETE FROM `creature_questender` WHERE `quest`=95033;
DELETE FROM `gameobject_questender` WHERE `quest`=95033;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (263190,95033,70938);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (8115,95033,70938);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (263190,8115);
UPDATE `quest_template` SET `QuestDescription`='If you be gettin'' tired of dem wide open plains, my old friend Uzer''i always be lookin'' for help. He always be twistin'' dem magics, but little do most o'' dem people know he be quite da hunter too.\n\nIf you''s interested, you can find him all da way out at Camp Mojache in Feralas.\n\nTell him ol'' Tan''jani sent ya.', `LogDescription`='Tan''jani wants you to speak with Witch Doctor Uzer''i at Camp Mojache in Feralas.', `AreaDescription`='', `QuestCompletionLog`='', `LogTitle`='On the Other Side', `QuestSortID`=16591, `QuestInfoID`=0, `RewardNextQuest`=0, `RewardXPDifficulty`=1, `RewardXPMultiplier`=1.0, `RewardSpell`=0, `StartItem`=0, `Flags`=36700160, `FlagsEx`=0, `AllowableRaces`=12261800583900083122, `TimeAllowed`=0, `VerifiedBuild`=70938, `RewardItem1`=0, `RewardAmount1`=0, `RewardItem2`=0, `RewardAmount2`=0, `RewardItem3`=0, `RewardAmount3`=0, `RewardItem4`=0, `RewardAmount4`=0, `RewardChoiceItemID1`=0, `RewardChoiceItemQuantity1`=0, `RewardChoiceItemID2`=0, `RewardChoiceItemQuantity2`=0, `RewardChoiceItemID3`=0, `RewardChoiceItemQuantity3`=0, `RewardChoiceItemID4`=0, `RewardChoiceItemQuantity4`=0, `RewardChoiceItemID5`=0, `RewardChoiceItemQuantity5`=0, `RewardChoiceItemID6`=0, `RewardChoiceItemQuantity6`=0, `RewardFactionID1`=0, `RewardFactionValue1`=0, `RewardFactionOverride1`=0, `RewardFactionID2`=0, `RewardFactionValue2`=0, `RewardFactionOverride2`=0, `RewardFactionID3`=0, `RewardFactionValue3`=0, `RewardFactionOverride3`=0, `RewardFactionID4`=0, `RewardFactionValue4`=0, `RewardFactionOverride4`=0, `RewardFactionID5`=0, `RewardFactionValue5`=0, `RewardFactionOverride5`=0 WHERE `ID`=95033 AND `VerifiedBuild`=-1;
DELETE FROM `quest_objectives` WHERE `QuestID`=95033;
DELETE FROM `quest_classic_money` WHERE `ID`=95033;

-- 94480 A Gift From Our Enemies (live record build 70938): giver 256418 Krom'rosh, turn-in 256655 Gorg (both seen on live)
DELETE FROM `quest_template` WHERE `ID`=94480;
INSERT INTO `quest_template` (`ID`,`QuestType`,`LogTitle`,`VerifiedBuild`) VALUES (94480,2,'A Gift From Our Enemies',-1);
DELETE FROM `quest_classic_level` WHERE `ID`=94480;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (94480,36,36,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=94480;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (94480,2,36);
DELETE FROM `quest_template_addon` WHERE `ID`=94480;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (94480,0,0,0);
DELETE FROM `quest_offer_reward` WHERE `ID`=94480;
INSERT INTO `quest_offer_reward` (`ID`,`RewardText`,`VerifiedBuild`) VALUES (94480,'Well done, $n. Thank you.',-1);
DELETE FROM `creature_queststarter` WHERE `quest`=94480;
DELETE FROM `gameobject_queststarter` WHERE `quest`=94480;
DELETE FROM `creature_questender` WHERE `quest`=94480;
DELETE FROM `gameobject_questender` WHERE `quest`=94480;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (256418,94480,70938);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (256655,94480,70938);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (256418,256655);
UPDATE `quest_template` SET `QuestDescription`='The humans of these lands are only one of many threats. With the encroaching Twilight and snarls of gnolls echoing from the hills nearby, battle may call at a moment''s notice. Maintaining the strength of our allies may be the difference between Rog''mar''s success or our removal from these lands.\n\nDeliver the goods you''ve gathered to Gorg. He''ll make sure our allies are well fed.', `LogDescription`='Deliver the Stolen Feed to Gorg in Rog''mar.', `AreaDescription`='', `QuestCompletionLog`='', `LogTitle`='A Gift From Our Enemies', `QuestSortID`=16591, `QuestInfoID`=0, `RewardNextQuest`=94481, `RewardXPDifficulty`=1, `RewardXPMultiplier`=1.0, `RewardSpell`=0, `StartItem`=265065, `Flags`=36700160, `FlagsEx`=0, `AllowableRaces`=12261800583900083122, `TimeAllowed`=0, `VerifiedBuild`=70938, `RewardItem1`=0, `RewardAmount1`=0, `RewardItem2`=0, `RewardAmount2`=0, `RewardItem3`=0, `RewardAmount3`=0, `RewardItem4`=0, `RewardAmount4`=0, `RewardChoiceItemID1`=0, `RewardChoiceItemQuantity1`=0, `RewardChoiceItemID2`=0, `RewardChoiceItemQuantity2`=0, `RewardChoiceItemID3`=0, `RewardChoiceItemQuantity3`=0, `RewardChoiceItemID4`=0, `RewardChoiceItemQuantity4`=0, `RewardChoiceItemID5`=0, `RewardChoiceItemQuantity5`=0, `RewardChoiceItemID6`=0, `RewardChoiceItemQuantity6`=0, `RewardFactionID1`=0, `RewardFactionValue1`=0, `RewardFactionOverride1`=0, `RewardFactionID2`=0, `RewardFactionValue2`=0, `RewardFactionOverride2`=0, `RewardFactionID3`=0, `RewardFactionValue3`=0, `RewardFactionOverride3`=0, `RewardFactionID4`=0, `RewardFactionValue4`=0, `RewardFactionOverride4`=0, `RewardFactionID5`=0, `RewardFactionValue5`=0, `RewardFactionOverride5`=0 WHERE `ID`=94480 AND `VerifiedBuild`=-1;
DELETE FROM `quest_objectives` WHERE `QuestID`=94480;
DELETE FROM `quest_classic_money` WHERE `ID`=94480;

-- 94481 A Serving of Strength (live record build 70959): giver 256655 Gorg, turn-in 256655 Gorg (both seen on live)
DELETE FROM `quest_template` WHERE `ID`=94481;
INSERT INTO `quest_template` (`ID`,`QuestType`,`LogTitle`,`VerifiedBuild`) VALUES (94481,2,'A Serving of Strength',-1);
DELETE FROM `quest_classic_level` WHERE `ID`=94481;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (94481,38,36,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=94481;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (94481,2,38);
DELETE FROM `quest_template_addon` WHERE `ID`=94481;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (94481,0,0,94480);
DELETE FROM `quest_offer_reward` WHERE `ID`=94481;
INSERT INTO `quest_offer_reward` (`ID`,`RewardText`,`VerifiedBuild`) VALUES (94481,'Well done, $n. Thank you.',-1);
DELETE FROM `creature_queststarter` WHERE `quest`=94481;
DELETE FROM `gameobject_queststarter` WHERE `quest`=94481;
DELETE FROM `creature_questender` WHERE `quest`=94481;
DELETE FROM `gameobject_questender` WHERE `quest`=94481;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (256655,94481,70959);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (256655,94481,70959);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (256655);
UPDATE `quest_template` SET `QuestDescription`='This hearty stew keeps our trainees fed, enough so that our enemies remain at a distance.\n\nBring this and feed our trainees to the west. Don''t listen to any complaints. With how difficult defending our supply lines has become, they should be so lucky we''re not feeding them dirt.', `LogDescription`='Feed $1oa Rog''mar Trainees at the training grounds.', `AreaDescription`='', `QuestCompletionLog`='', `LogTitle`='A Serving of Strength', `QuestSortID`=16591, `QuestInfoID`=0, `RewardNextQuest`=0, `RewardXPDifficulty`=4, `RewardXPMultiplier`=1.0, `RewardSpell`=0, `StartItem`=265066, `Flags`=36700160, `FlagsEx`=0, `AllowableRaces`=12261800583900083122, `TimeAllowed`=0, `VerifiedBuild`=70959, `RewardItem1`=0, `RewardAmount1`=0, `RewardItem2`=0, `RewardAmount2`=0, `RewardItem3`=0, `RewardAmount3`=0, `RewardItem4`=0, `RewardAmount4`=0, `RewardChoiceItemID1`=0, `RewardChoiceItemQuantity1`=0, `RewardChoiceItemID2`=0, `RewardChoiceItemQuantity2`=0, `RewardChoiceItemID3`=0, `RewardChoiceItemQuantity3`=0, `RewardChoiceItemID4`=0, `RewardChoiceItemQuantity4`=0, `RewardChoiceItemID5`=0, `RewardChoiceItemQuantity5`=0, `RewardChoiceItemID6`=0, `RewardChoiceItemQuantity6`=0, `RewardFactionID1`=0, `RewardFactionValue1`=0, `RewardFactionOverride1`=0, `RewardFactionID2`=0, `RewardFactionValue2`=0, `RewardFactionOverride2`=0, `RewardFactionID3`=0, `RewardFactionValue3`=0, `RewardFactionOverride3`=0, `RewardFactionID4`=0, `RewardFactionValue4`=0, `RewardFactionOverride4`=0, `RewardFactionID5`=0, `RewardFactionValue5`=0, `RewardFactionOverride5`=0 WHERE `ID`=94481 AND `VerifiedBuild`=-1;
DELETE FROM `quest_objectives` WHERE `QuestID`=94481;
DELETE FROM `quest_objectives` WHERE `ID` IN (468777);
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(468777,94481,0,0,0,256749,8,0,0,0,0.0,0,1,'Rog''mar Trainee fed',70959);
DELETE FROM `quest_classic_money` WHERE `ID`=94481;

-- 93976 The Goblin Trader (live record build 70959): giver 256657 Kreza Darkthorn, turn-in 255897 Friz Frazzlespark (both seen on live)
DELETE FROM `quest_template` WHERE `ID`=93976;
INSERT INTO `quest_template` (`ID`,`QuestType`,`LogTitle`,`VerifiedBuild`) VALUES (93976,2,'The Goblin Trader',-1);
DELETE FROM `quest_classic_level` WHERE `ID`=93976;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (93976,36,36,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=93976;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (93976,2,36);
DELETE FROM `quest_template_addon` WHERE `ID`=93976;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (93976,0,0,0);
DELETE FROM `quest_offer_reward` WHERE `ID`=93976;
INSERT INTO `quest_offer_reward` (`ID`,`RewardText`,`VerifiedBuild`) VALUES (93976,'Well done, $n. Thank you.',-1);
DELETE FROM `creature_queststarter` WHERE `quest`=93976;
DELETE FROM `gameobject_queststarter` WHERE `quest`=93976;
DELETE FROM `creature_questender` WHERE `quest`=93976;
DELETE FROM `gameobject_questender` WHERE `quest`=93976;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (256657,93976,70959);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (255897,93976,70959);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (255897,256657);
UPDATE `quest_template` SET `QuestDescription`='While Gur''dok and I continue our work, we did fashion a particular blade for a friend--perhaps friend is too strong a word--for an acquaintance down at the docks. This particular individual is well known and connected all across the Kingdoms and beyond.\n\nTake this. When you deliver it, let her know I sent you. And tell her we''re even.', `LogDescription`='Deliver the blade to Kreza Darkthorn''s acquaintance at the docks east of Rog''mar.', `AreaDescription`='', `QuestCompletionLog`='', `LogTitle`='The Goblin Trader', `QuestSortID`=16591, `QuestInfoID`=0, `RewardNextQuest`=95288, `RewardXPDifficulty`=1, `RewardXPMultiplier`=1.0, `RewardSpell`=0, `StartItem`=263973, `Flags`=36700160, `FlagsEx`=0, `AllowableRaces`=12261800583900083122, `TimeAllowed`=0, `VerifiedBuild`=70959, `RewardItem1`=0, `RewardAmount1`=0, `RewardItem2`=0, `RewardAmount2`=0, `RewardItem3`=0, `RewardAmount3`=0, `RewardItem4`=0, `RewardAmount4`=0, `RewardChoiceItemID1`=0, `RewardChoiceItemQuantity1`=0, `RewardChoiceItemID2`=0, `RewardChoiceItemQuantity2`=0, `RewardChoiceItemID3`=0, `RewardChoiceItemQuantity3`=0, `RewardChoiceItemID4`=0, `RewardChoiceItemQuantity4`=0, `RewardChoiceItemID5`=0, `RewardChoiceItemQuantity5`=0, `RewardChoiceItemID6`=0, `RewardChoiceItemQuantity6`=0, `RewardFactionID1`=0, `RewardFactionValue1`=0, `RewardFactionOverride1`=0, `RewardFactionID2`=0, `RewardFactionValue2`=0, `RewardFactionOverride2`=0, `RewardFactionID3`=0, `RewardFactionValue3`=0, `RewardFactionOverride3`=0, `RewardFactionID4`=0, `RewardFactionValue4`=0, `RewardFactionOverride4`=0, `RewardFactionID5`=0, `RewardFactionValue5`=0, `RewardFactionOverride5`=0 WHERE `ID`=93976 AND `VerifiedBuild`=-1;
DELETE FROM `quest_objectives` WHERE `QuestID`=93976;
DELETE FROM `quest_objectives` WHERE `ID` IN (468026);
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(468026,93976,1,0,1,263973,1,0,0,0,0.0,0,1,NULL,70959);
DELETE FROM `quest_classic_money` WHERE `ID`=93976;

-- 93464 The Visiting Mage (live record build 70959): giver 1776 Magtoor, turn-in 11863 Azore Aldamort (both seen on live)
DELETE FROM `quest_template` WHERE `ID`=93464;
INSERT INTO `quest_template` (`ID`,`QuestType`,`LogTitle`,`VerifiedBuild`) VALUES (93464,2,'The Visiting Mage',-1);
DELETE FROM `quest_classic_level` WHERE `ID`=93464;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (93464,38,30,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=93464;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (93464,2,38);
DELETE FROM `quest_template_addon` WHERE `ID`=93464;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (93464,0,0,0);
DELETE FROM `quest_offer_reward` WHERE `ID`=93464;
INSERT INTO `quest_offer_reward` (`ID`,`RewardText`,`VerifiedBuild`) VALUES (93464,'Well done, $n. Thank you.',-1);
DELETE FROM `creature_queststarter` WHERE `quest`=93464;
DELETE FROM `gameobject_queststarter` WHERE `quest`=93464;
DELETE FROM `creature_questender` WHERE `quest`=93464;
DELETE FROM `gameobject_questender` WHERE `quest`=93464;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (1776,93464,70959);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (11863,93464,70959);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (11863,1776);
UPDATE `quest_template` SET `QuestDescription`='Allow me to admit something, $n. While draenethyst is sacred to us, and keeps us sane, none here fully understand it.\n\nI recall a mage who once came to the Harborage, from Desolace. A human by the name of Azore. He feared the power of the draenethyst; said it shouldn''t fall into the wrong hands. \n\nAt the time, we drove him away to protect what was ours. Lately, however, I find myself wondering what exactly he knew.\n\nI ask that you find this mage, $r. His knowledge could be of immense value to us.', `LogDescription`='Find the mage in Desolace who knows about the power of draenethyst.', `AreaDescription`='', `QuestCompletionLog`='', `LogTitle`='The Visiting Mage', `QuestSortID`=8, `QuestInfoID`=0, `RewardNextQuest`=93465, `RewardXPDifficulty`=3, `RewardXPMultiplier`=1.0, `RewardSpell`=0, `StartItem`=0, `Flags`=8, `FlagsEx`=0, `AllowableRaces`=18446744073709551615, `TimeAllowed`=0, `VerifiedBuild`=70959, `RewardItem1`=0, `RewardAmount1`=0, `RewardItem2`=0, `RewardAmount2`=0, `RewardItem3`=0, `RewardAmount3`=0, `RewardItem4`=0, `RewardAmount4`=0, `RewardChoiceItemID1`=0, `RewardChoiceItemQuantity1`=0, `RewardChoiceItemID2`=0, `RewardChoiceItemQuantity2`=0, `RewardChoiceItemID3`=0, `RewardChoiceItemQuantity3`=0, `RewardChoiceItemID4`=0, `RewardChoiceItemQuantity4`=0, `RewardChoiceItemID5`=0, `RewardChoiceItemQuantity5`=0, `RewardChoiceItemID6`=0, `RewardChoiceItemQuantity6`=0, `RewardFactionID1`=0, `RewardFactionValue1`=0, `RewardFactionOverride1`=0, `RewardFactionID2`=0, `RewardFactionValue2`=0, `RewardFactionOverride2`=0, `RewardFactionID3`=0, `RewardFactionValue3`=0, `RewardFactionOverride3`=0, `RewardFactionID4`=0, `RewardFactionValue4`=0, `RewardFactionOverride4`=0, `RewardFactionID5`=0, `RewardFactionValue5`=0, `RewardFactionOverride5`=0 WHERE `ID`=93464 AND `VerifiedBuild`=-1;
DELETE FROM `quest_objectives` WHERE `QuestID`=93464;
DELETE FROM `quest_classic_money` WHERE `ID`=93464;
