-- WoW Forever: Forest Song (Ashenvale, about 86,46) had no Maseara Autumnmoon, so her two quests could not be had:
-- 98417 Vengeful Trail (find Kurothel's belongings) and 98418 Shared Fury (Xavian satyrs). Player report on Discord.
-- Adds the NPC, both quests, the Kurothel's Knapsack spawns and the knapsack's quest drop.
-- Data from Efficient Games (https://efficient.games), licensed under CC BY 4.0 (https://creativecommons.org/licenses/by/4.0/).
-- Source: github.com/JIVESCORP/eg-link-output-wowf (quests.enUS 70959, npcs 70450). Changed: converted to our tables;
-- reward text is a placeholder. NPC and knapsack spots from the Wowhead Forever map points.
-- INFERRED, check in game: stats copy Kayneth Stillwind 3848, model and level from the live record. Heights measured on dev
-- (.playerbot groundz) 2026-11-20.
-- Safe to run again: every key is deleted first. Guids: creature 22126900, gameobject 67343100-67343102.

-- 221269 Maseara Autumnmoon: copy of 3848 Kayneth Stillwind (same camp, same side), quest giver, level 31, model 146929
DELETE FROM `creature` WHERE `guid`=22126900;
DELETE FROM `creature_template` WHERE `entry`=221269;
DELETE FROM `creature_template_model` WHERE `CreatureID`=221269;
DELETE FROM `creature_template_difficulty` WHERE `Entry`=221269;
DELETE FROM `creature_classic_level` WHERE `entry`=221269;
INSERT INTO `creature_template` (`entry`,`KillCredit1`,`KillCredit2`,`name`,`femaleName`,`subname`,`TitleAlt`,`IconName`,`RequiredExpansion`,`VignetteID`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`Classification`,`dmgschool`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,`unit_flags`,`unit_flags2`,`unit_flags3`,`family`,`trainer_class`,`type`,`VehicleId`,`AIName`,`MovementType`,`ExperienceModifier`,`RacialLeader`,`movementId`,`WidgetSetID`,`WidgetSetUnitConditionID`,`RegenHealth`,`CreatureImmunitiesId`,`flags_extra`,`ScriptName`,`StringId`,`VerifiedBuild`) SELECT 221269,0,0,'Maseara Autumnmoon',`femaleName`,NULL,`TitleAlt`,`IconName`,`RequiredExpansion`,`VignetteID`,`faction`,2,`speed_walk`,`speed_run`,`scale`,0,`dmgschool`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,8,`unit_flags`,`unit_flags2`,`unit_flags3`,0,`trainer_class`,7,`VehicleId`,'',`MovementType`,`ExperienceModifier`,`RacialLeader`,`movementId`,`WidgetSetID`,`WidgetSetUnitConditionID`,`RegenHealth`,`CreatureImmunitiesId`,`flags_extra`,'',`StringId`,70959 FROM `creature_template` WHERE `entry`=3848;
INSERT INTO `creature_template_model` (`CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild`) VALUES (221269,0,146929,1.0,1.0,70959);
INSERT INTO `creature_template_difficulty` (`Entry`,`DifficultyID`,`LevelScalingDeltaMin`,`LevelScalingDeltaMax`,`ContentTuningID`,`HealthScalingExpansion`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`DamageModifier`,`CreatureDifficultyID`,`TypeFlags`,`TypeFlags2`,`TypeFlags3`,`LootID`,`PickPocketLootID`,`SkinLootID`,`GoldMin`,`GoldMax`,`StaticFlags1`,`StaticFlags2`,`StaticFlags3`,`StaticFlags4`,`StaticFlags5`,`StaticFlags6`,`StaticFlags7`,`StaticFlags8`,`VerifiedBuild`) SELECT 221269,`DifficultyID`,`LevelScalingDeltaMin`,`LevelScalingDeltaMax`,`ContentTuningID`,`HealthScalingExpansion`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`DamageModifier`,270897,`TypeFlags`,`TypeFlags2`,`TypeFlags3`,0,0,0,`GoldMin`,`GoldMax`,`StaticFlags1`,`StaticFlags2`,`StaticFlags3`,`StaticFlags4`,`StaticFlags5`,`StaticFlags6`,`StaticFlags7`,`StaticFlags8`,70959 FROM `creature_template_difficulty` WHERE `Entry`=3848;
INSERT INTO `creature_classic_level` (`entry`,`level_min`,`level_max`) VALUES (221269,31,31);
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(22126900,221269,1,331,0,'0',0,0,0,-1,0,0,2910.2,-3273.8,160.04,2.2,300,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Maseara Autumnmoon, Forest Song (EG point, Wowhead 86.2,45.8; z measured on dev) */;

-- 98417 Vengeful Trail (live record build 70959): giver and turn-in 221269 Maseara Autumnmoon (Wowhead Forever quest page)
DELETE FROM `quest_template` WHERE `ID`=98417;
INSERT INTO `quest_template` (`ID`,`QuestType`,`LogTitle`,`VerifiedBuild`) VALUES (98417,2,'Vengeful Trail',-1);
DELETE FROM `quest_classic_level` WHERE `ID`=98417;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (98417,28,23,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=98417;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (98417,2,28);
DELETE FROM `quest_template_addon` WHERE `ID`=98417;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (98417,0,0,0);
DELETE FROM `quest_offer_reward` WHERE `ID`=98417;
INSERT INTO `quest_offer_reward` (`ID`,`RewardText`,`VerifiedBuild`) VALUES (98417,'Thank you, $n.',-1);
DELETE FROM `creature_queststarter` WHERE `quest`=98417;
DELETE FROM `gameobject_queststarter` WHERE `quest`=98417;
DELETE FROM `creature_questender` WHERE `quest`=98417;
DELETE FROM `gameobject_questender` WHERE `quest`=98417;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (221269,98417,70959);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (221269,98417,70959);
UPDATE `quest_template` SET `QuestDescription`='At the moment our fates bound us most vulnerable, tragedy fell upon our villages. Satyrs defiled our temples, their profane touch staining sacred boughs, and they slaughtered the innocent without mercy.\n\nKurothel was consumed by wrath. The druids are taking the fight to the satyr, and he has followed.\n\nOur bond endures. I feel my husband, west, within these woods. Please, return to me with news of his fate.', `LogDescription`='Maseara Autumnmoon wants you to search west of Forest Song, amongst the Satyrnaar demons. Report any signs of her husband Kurothel upon your return.', `AreaDescription`='', `QuestCompletionLog`='', `QuestSortID`=331, `QuestInfoID`=0, `RewardNextQuest`=98418, `RewardXPDifficulty`=4, `RewardXPMultiplier`=1.0, `Flags`=8, `FlagsEx`=0, `AllowableRaces`=6130900294268439629, `TimeAllowed`=0, `VerifiedBuild`=70959, `RewardFactionID1`=69, `RewardFactionValue1`=2, `RewardFactionOverride1`=0 WHERE `ID`=98417 AND `VerifiedBuild`=-1;
DELETE FROM `quest_objectives` WHERE `QuestID`=98417;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES (477594,98417,1,0,0,281014,1,0,0,0,0,0,1,'Kurothel''s belongings located',70959);
DELETE FROM `quest_classic_money` WHERE `ID`=98417;

-- 98418 Shared Fury (live record build 70959): giver and turn-in 221269 Maseara Autumnmoon (Wowhead Forever quest page)
DELETE FROM `quest_template` WHERE `ID`=98418;
INSERT INTO `quest_template` (`ID`,`QuestType`,`LogTitle`,`VerifiedBuild`) VALUES (98418,2,'Shared Fury',-1);
DELETE FROM `quest_classic_level` WHERE `ID`=98418;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (98418,30,23,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=98418;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (98418,2,30);
DELETE FROM `quest_template_addon` WHERE `ID`=98418;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (98418,0,0,98417);
DELETE FROM `quest_offer_reward` WHERE `ID`=98418;
INSERT INTO `quest_offer_reward` (`ID`,`RewardText`,`VerifiedBuild`) VALUES (98418,'Thank you, $n.',-1);
DELETE FROM `creature_queststarter` WHERE `quest`=98418;
DELETE FROM `gameobject_queststarter` WHERE `quest`=98418;
DELETE FROM `creature_questender` WHERE `quest`=98418;
DELETE FROM `gameobject_questender` WHERE `quest`=98418;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (221269,98418,70959);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (221269,98418,70959);
UPDATE `quest_template` SET `QuestDescription`='Kurothel mentioned sightings of what they say are wolf-men. Those of the pack now lurking in greater numbers in our forest. Last we had spoken, druids were pursuing communication with those of the beast heart who displayed measured control of their animal instincts.\n\nHis written words show a darker struggle. If there is anything we can do to help see HIM again, surely quelling the demon threat that is driving him to this burning transformation will be of aid to his anguished soul.\n\nSlay the Xavian, $n.', `LogDescription`='Kill $1oa Xavian Rogues, $2oa Felsworn, $3oa Betrayers, and $4oa Hellcallers.\nReturn to Maseara Autumnmoon in Forest Song afterwards.', `AreaDescription`='', `QuestCompletionLog`='', `QuestSortID`=331, `QuestInfoID`=0, `RewardNextQuest`=0, `RewardXPDifficulty`=5, `RewardXPMultiplier`=1.0, `Flags`=8, `FlagsEx`=0, `AllowableRaces`=6130900294268439629, `TimeAllowed`=0, `VerifiedBuild`=70959, `RewardFactionID1`=69, `RewardFactionValue1`=2, `RewardFactionOverride1`=0 WHERE `ID`=98418 AND `VerifiedBuild`=-1;
DELETE FROM `quest_objectives` WHERE `QuestID`=98418;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES (477595,98418,0,0,0,3754,5,0,0,0,0,0,1,NULL,70959),(477596,98418,0,1,1,3755,5,0,0,0,0,0,1,NULL,70959),(477597,98418,0,2,2,3757,5,0,0,0,0,0,1,NULL,70959),(477598,98418,0,3,3,3752,5,0,0,0,0,0,1,NULL,70959);
DELETE FROM `quest_classic_money` WHERE `ID`=98418;
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES (98418,2100,0);

-- Kurothel's Knapsack 673431 (template already in our world, loot id 143112): its drop and three spawns (Wowhead points
-- 81.1,49.1 / 81.2,50.3 / 81.7,49.2, turned into world spots with the Ashenvale map fit checked on Maseara's EG point)
DELETE FROM `gameobject_loot_template` WHERE `Entry`=143112;
INSERT INTO `gameobject_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(143112,0,281014,100,1,1,0,1,1,'Vine-Wrapped Scroll (98417)');
DELETE FROM `gameobject` WHERE `guid` BETWEEN 67343100 AND 67343102;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`,`ScriptName`,`VerifiedBuild`) VALUES
(67343100,673431,1,331,0,'0',0,0,0,-1,2785.6,-2976.8,149.73,0,0,0,0,1,120,255,1,'',70959) /* z measured on dev */,
(67343101,673431,1,331,0,'0',0,0,0,-1,2739.5,-2982.5,140.83,0,0,0,0,1,120,255,1,'',70959) /* z measured on dev */,
(67343102,673431,1,331,0,'0',0,0,0,-1,2781.8,-3011.4,154.11,0,0,0,0,1,120,255,1,'',70959) /* z measured on dev */;
