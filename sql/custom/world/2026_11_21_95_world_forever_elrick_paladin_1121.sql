-- Elrick, Paladin of the Silver Hand (81765): the paladin quest that follows The Mysterious Merchant (81764), with the
-- "Speak with Elrick and learn more" step credited when the player talks to Elrick (221575) in Theramore.
-- Quest record: Data from Efficient Games (https://efficient.games), licensed under CC BY 4.0
-- (https://creativecommons.org/licenses/by/4.0/). Source: github.com/JIVESCORP/eg-link-output-wowf quests.enUS, build
-- 1.60.1.70959 (players' quest caches): title, story, objective line, levels, races, flags, objective id, money. Changed:
-- converted to our tables. Giver Elrick from NorgannonDB (zmarotrix/NorgannonDB, GPL-3.0); The Mysterious Merchant already
-- ends at Elrick and names this quest as its next. Paladin only, as the quest before it. Turn-in at Innkeeper Janene (6272,
-- Theramore) from Wowhead's WoW Forever quest page (www.wowhead.com/forever) with EG Link and NorgannonDB. The talk credit
-- follows our core's pattern for "speak with" kill credits (Nazgrel, Sylvanas):
-- credit on gossip hello. Reward text is not in the data: none is set. Not checked in game.
-- Everything only where missing. Safe to run more than once.

INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`)
SELECT 81765,2,-141,0,0,6,1.0,0,1.0,0,0,536870912,0,0,0,6130900294268439629,'Elrick, Paladin of the Silver Hand','Speak with Elrick to learn more.','<The Paladin standing before you is not known to you. Speak with him to determine what he knows of the merchant and the current situation.>','','',70959 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `quest_template` WHERE `ID` = 81765);
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`)
SELECT 448780,81765,0,0,1,221575,1,0,1,'Speak with Elrick and learn more',70959 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `quest_objectives` WHERE `QuestID` = 81765) AND NOT EXISTS (SELECT 1 FROM `quest_objectives` WHERE `ID` = 448780);
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`)
SELECT 81765,0,2,81764 FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `quest_template_addon` WHERE `ID` = 81765);
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`)
SELECT 81765,10325,0 FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `quest_classic_money` WHERE `ID` = 81765);
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`)
SELECT 81765,50,45,0 FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `quest_classic_level` WHERE `ID` = 81765);
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`)
SELECT 81765,2,50 FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `quest_template_classic_level` WHERE `ID` = 81765);
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`)
SELECT 221575,81765,0 FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `creature_queststarter` WHERE `quest` = 81765);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`)
SELECT 6272,81765,0 FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `creature_questender` WHERE `quest` = 81765);
-- an earlier copy of this file set Elrick as the turn-in
UPDATE `creature_questender` SET `id` = 6272 WHERE `quest` = 81765 AND `id` = 221575
  AND NOT EXISTS (SELECT 1 FROM (SELECT `id` FROM `creature_questender` WHERE `quest` = 81765 AND `id` = 6272) x);
UPDATE `creature_template` SET `npcflag` = `npcflag` | 3 WHERE `entry` = 221575 AND (`npcflag` & 3) <> 3;

-- Elrick credits "Speak with Elrick and learn more" when the player talks to him (only counts while 81765 is in the log)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 221575 AND `AIName` = '' AND `ScriptName` = ''
  AND NOT EXISTS (SELECT 1 FROM `smart_scripts` WHERE `entryorguid` = 221575 AND `source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`Difficulties`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`action_param7`,`action_param_string`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_param_string`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`)
SELECT 221575,0,0,0,'',64,0,100,0,0,0,0,0,0,'',33,221575,0,0,0,0,0,0,NULL,7,0,0,0,0,NULL,0,0,0,0,'Elrick - On Gossip Hello - Quest Credit Speak with Elrick (81765)' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `smart_scripts` WHERE `entryorguid` = 221575 AND `source_type` = 0)
  AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 221575 AND `AIName` = 'SmartAI' AND `ScriptName` = '');
