-- WoW Forever: quest 98027 "Gleaming Crescent Necklace" (Ashenvale), started from the Gleaming Crescent Pendant object and
-- turned in to Maliynn, as on the live realm.
-- Data from Efficient Games (https://efficient.games), licensed under CC BY 4.0 (https://creativecommons.org/licenses/by/4.0/).
-- Source: github.com/JIVESCORP/eg-link-output-wowf (quests.enUS). Changed: converted to our tables; reward text is a placeholder.
-- The pendant's spawn is held back below until its height is known. Safe to run again.

-- 98027 Gleaming Crescent Necklace (live record build 70938): giver object 669176 Gleaming Crescent Pendant, turn-in 3961 Maliynn (giver and turn-in from the live quest text; the object template is already in 2026_11_11_12)
DELETE FROM `quest_template` WHERE `ID`=98027;
INSERT INTO `quest_template` (`ID`,`QuestType`,`LogTitle`,`VerifiedBuild`) VALUES (98027,2,'Gleaming Crescent Necklace',-1);
DELETE FROM `quest_classic_level` WHERE `ID`=98027;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (98027,26,22,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=98027;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (98027,2,26);
DELETE FROM `quest_template_addon` WHERE `ID`=98027;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (98027,0,0,0);
DELETE FROM `quest_offer_reward` WHERE `ID`=98027;
INSERT INTO `quest_offer_reward` (`ID`,`RewardText`,`VerifiedBuild`) VALUES (98027,'Well done, $n. Thank you.',-1);
DELETE FROM `creature_queststarter` WHERE `quest`=98027;
DELETE FROM `gameobject_queststarter` WHERE `quest`=98027;
DELETE FROM `creature_questender` WHERE `quest`=98027;
DELETE FROM `gameobject_questender` WHERE `quest`=98027;
INSERT INTO `gameobject_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (669176,98027,70938);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (3961,98027,70938);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (3961);
UPDATE `quest_template` SET `QuestDescription`='<The silver necklace in your hands gleams gently as you examine it. The small crescent moon shape seems similar to other night elf symbols you''ve seen before.\n\nUpon flipping the necklace over there is a small inscription: "Alor''lormah, Maliynn". Perhaps it belongs to Maliynn in Astranaar?>', `LogDescription`='Deliver the Crescent Necklace to Maliynn in Astranaar.', `AreaDescription`='', `QuestCompletionLog`='', `LogTitle`='Gleaming Crescent Necklace', `QuestSortID`=331, `QuestInfoID`=0, `RewardNextQuest`=0, `RewardXPDifficulty`=4, `RewardXPMultiplier`=1.0, `RewardSpell`=0, `StartItem`=279274, `Flags`=0, `FlagsEx`=0, `AllowableRaces`=6130900294268439629, `TimeAllowed`=0, `VerifiedBuild`=70938, `RewardItem1`=281290, `RewardAmount1`=1, `RewardItem2`=0, `RewardAmount2`=0, `RewardItem3`=0, `RewardAmount3`=0, `RewardItem4`=0, `RewardAmount4`=0, `RewardChoiceItemID1`=0, `RewardChoiceItemQuantity1`=0, `RewardChoiceItemID2`=0, `RewardChoiceItemQuantity2`=0, `RewardChoiceItemID3`=0, `RewardChoiceItemQuantity3`=0, `RewardChoiceItemID4`=0, `RewardChoiceItemQuantity4`=0, `RewardChoiceItemID5`=0, `RewardChoiceItemQuantity5`=0, `RewardChoiceItemID6`=0, `RewardChoiceItemQuantity6`=0, `RewardFactionID1`=69, `RewardFactionValue1`=5, `RewardFactionOverride1`=0, `RewardFactionID2`=0, `RewardFactionValue2`=0, `RewardFactionOverride2`=0, `RewardFactionID3`=0, `RewardFactionValue3`=0, `RewardFactionOverride3`=0, `RewardFactionID4`=0, `RewardFactionValue4`=0, `RewardFactionOverride4`=0, `RewardFactionID5`=0, `RewardFactionValue5`=0, `RewardFactionOverride5`=0 WHERE `ID`=98027 AND `VerifiedBuild`=-1;
DELETE FROM `quest_objectives` WHERE `QuestID`=98027;
DELETE FROM `quest_classic_money` WHERE `ID`=98027;

-- Pendant spawn (Questie position, map 1). Held back: the height is unknown and the spot is under water with no navmesh to
-- read a height from. Fill in position_z (and keep the guid) once a height is measured in game, then take the comment marks off.
-- DELETE FROM `gameobject` WHERE `guid`=66917600;
-- INSERT INTO `gameobject` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`,`ScriptName`,`VerifiedBuild`) VALUES
-- (66917600,669176,1,331,0,'0',0,0,0,-1,1921.9,-1931.8,<z>,0,0,0,0,1,300,255,1,'',70938);
