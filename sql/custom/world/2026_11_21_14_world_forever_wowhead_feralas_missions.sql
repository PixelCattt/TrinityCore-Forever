-- WoW Forever: NPCs live quests need, read from Wowhead's WoW Forever pages (www.wowhead.com/forever) and checked against
-- our world. Templates: name, level range, model, type, elite, faction from the reaction Wowhead shows (both sides 35, Alliance 12,
-- Horde 29, hostile 16, neutral 7). Quest NPCs get the gossip and quest flags. Spawns: Wowhead map spot turned into world
-- coordinates with a per-zone fit from players' positions (Efficient Games EG Link, CC BY 4.0; for Azshara, Blasted Lands,
-- Eastern Plaguelands and Moonglade from NorgannonDB, GPL-3.0, paired with our own spawns), height from our own spawns
-- (nearest within 12 yd on level ground, else 3+ spawns within 25 yd less than 2 yd apart in height). Hostile mobs get every
-- spot Wowhead shows with a known height (5 yd wander). Quest kill-credit helpers are invisible triggers. Some spawned NPCs
-- take their template from the Everlake import (data kit 0015), so apply that first. VerifiedBuild -1 marks estimated rows.
-- Safe to run again: rows are replaced by key.
DELETE FROM `creature_template` WHERE `entry`=221480;
DELETE FROM `creature_template_difficulty` WHERE `DifficultyID`=0 AND `Entry`=221480;
DELETE FROM `creature_template_model` WHERE `CreatureID`=221480;
DELETE FROM `creature_classic_level` WHERE `entry`=221480;
DELETE FROM `creature` WHERE `guid`=47600441;
INSERT INTO `creature_template` (`entry`,`KillCredit1`,`KillCredit2`,`name`,`femaleName`,`subname`,`TitleAlt`,`IconName`,`RequiredExpansion`,`VignetteID`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`Classification`,`dmgschool`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,`unit_flags`,`unit_flags2`,`unit_flags3`,`family`,`trainer_class`,`type`,`VehicleId`,`AIName`,`MovementType`,`ExperienceModifier`,`RacialLeader`,`movementId`,`WidgetSetID`,`WidgetSetUnitConditionID`,`RegenHealth`,`CreatureImmunitiesId`,`flags_extra`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(221480,0,0,'Field Captain Arunnel',NULL,NULL,NULL,NULL,0,0,35,3,1.0,1.14286,1.0,0,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,7,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,-1);
INSERT INTO `creature_template_difficulty` (`Entry`,`DifficultyID`,`LevelScalingDeltaMin`,`LevelScalingDeltaMax`,`ContentTuningID`,`HealthScalingExpansion`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`DamageModifier`,`CreatureDifficultyID`,`TypeFlags`,`TypeFlags2`,`TypeFlags3`,`LootID`,`PickPocketLootID`,`SkinLootID`,`GoldMin`,`GoldMax`,`StaticFlags1`,`StaticFlags2`,`StaticFlags3`,`StaticFlags4`,`StaticFlags5`,`StaticFlags6`,`StaticFlags7`,`StaticFlags8`,`VerifiedBuild`) VALUES
(221480,0,0,0,0,0,1.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1);
INSERT INTO `creature_template_model` (`CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild`) VALUES
(221480,0,1707,1.0,1.0,-1);
INSERT INTO `creature_classic_level` (`entry`,`level_min`,`level_max`) VALUES
(221480,50,50);
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(47600441,221480,1,0,0,'0',0,0,0,-1,0,0,-2940.53,2079.35,30.262,0,120,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,-1);
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

-- 81855 Feralas Mission I: Defeat Children of Cenarius (level 52, min 47, live build 1.60.1.70888, 1 player(s))
DELETE FROM `quest_template` WHERE `ID`=81855;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardItem1`,`RewardAmount1`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (81855,2,357,1,0,5,1.0,0,1.0,446536,0,4352,0,0,0,18446744073709551615,219927,1,2641,6,0,'Feralas Mission I: Defeat Children of Cenarius','Defeat 10 Lost Daughters and 10 Vengeful Sons in the Feralas Nightmare Incursion at the Twin Colossals and return to Field Captain Arunnel.','While these demons distract us here, the Emerald Dream is being corrupted into nightmare. Quick, travel through the Emerald Dream Portal in Dream Bough, and journey to the Nightmare Incursion at the Twin Colossals. Defeat maddened sons and daughters of Cenarius there and return to me.','','',70888);
DELETE FROM `quest_objectives` WHERE `QuestID`=81855;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (448899,81855,0,0,0,221375,10,0,1,NULL,70888),(448900,81855,0,1,2,221377,10,0,1,NULL,70888);
DELETE FROM `quest_template_addon` WHERE `ID`=81855;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (81855,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=81855;
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES (81855,39300,0);
DELETE FROM `quest_classic_level` WHERE `ID`=81855;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (81855,52,47,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=81855;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (81855,2,52);
DELETE FROM `creature_queststarter` WHERE `quest`=81855;
DELETE FROM `gameobject_queststarter` WHERE `quest`=81855;
DELETE FROM `creature_questender` WHERE `quest`=81855;
DELETE FROM `gameobject_questender` WHERE `quest`=81855;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (221480,81855,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (221480,81855,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (221480);

-- 81856 Feralas Mission II: Defeat Harpies (level 52, min 47, live build 1.60.1.70888, 1 player(s))
DELETE FROM `quest_template` WHERE `ID`=81856;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardItem1`,`RewardAmount1`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (81856,2,357,1,0,5,1.0,0,1.0,446536,0,4352,0,0,0,18446744073709551615,219927,1,2641,6,0,'Feralas Mission II: Defeat Harpies','Defeat 10 Dreamspring Roguefeathers and 10 Dreamspring Stormcallers in the Feralas Nightmare Incursion at the Ruins of Ravenwind and return to Field Captain Arunnel.','While these demons distract us here, the Emerald Dream is being corrupted into nightmare. Quick, travel through the Emerald Dream Portal in Dream Bough, and journey to the Nightmare Incursion at the Ruins of Ravenwind. Defeat harpies there and return to me.','','',70888);
DELETE FROM `quest_objectives` WHERE `QuestID`=81856;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (448901,81856,0,0,1,221370,10,0,1,NULL,70888),(448902,81856,0,1,3,221371,10,0,1,NULL,70888);
DELETE FROM `quest_template_addon` WHERE `ID`=81856;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (81856,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=81856;
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES (81856,39300,0);
DELETE FROM `quest_classic_level` WHERE `ID`=81856;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (81856,52,47,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=81856;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (81856,2,52);
DELETE FROM `creature_queststarter` WHERE `quest`=81856;
DELETE FROM `gameobject_queststarter` WHERE `quest`=81856;
DELETE FROM `creature_questender` WHERE `quest`=81856;
DELETE FROM `gameobject_questender` WHERE `quest`=81856;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (221480,81856,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (221480,81856,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (221480);

-- 81857 Feralas Mission III: Defeat Dragonkin (level 52, min 47, live build 1.60.1.70959, 1 player(s))
DELETE FROM `quest_template` WHERE `ID`=81857;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardItem1`,`RewardAmount1`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (81857,2,357,1,0,5,1.0,0,1.0,446536,0,4352,0,0,0,18446744073709551615,219927,1,2641,6,0,'Feralas Mission III: Defeat Dragonkin','Defeat 10 Frenzied Whelps and 3 Wyrmkin Berserkers in the Feralas Nightmare Incursion at Oneiros and return to Field Captain Arunnel.','While these demons distract us here, the Emerald Dream is being corrupted into nightmare. Quick, travel through the Emerald Dream Portal in Dream Bough, and journey to the Nightmare Incursion at Oneiros. Defeat dragonkin there and return to me.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=81857;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (448903,81857,0,0,0,221369,10,0,1,NULL,70959),(448904,81857,0,1,2,221367,3,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=81857;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (81857,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=81857;
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES (81857,39300,0);
DELETE FROM `quest_classic_level` WHERE `ID`=81857;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (81857,52,47,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=81857;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (81857,2,52);
DELETE FROM `creature_queststarter` WHERE `quest`=81857;
DELETE FROM `gameobject_queststarter` WHERE `quest`=81857;
DELETE FROM `creature_questender` WHERE `quest`=81857;
DELETE FROM `gameobject_questender` WHERE `quest`=81857;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (221480,81857,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (221480,81857,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (221480);

