-- WoW Forever: the Nightmare Incursion mission bosses (Duskwood, Ashenvale, Hinterlands, Feralas) that the "Defeat ..." missions
-- XIII-XV need. Templates from Wowhead's WoW Forever NPC pages (name, model, type, elite, hostile); Wowhead shows no level for
-- them, so the level is ESTIMATED as the mission's quest level + 1 (28 / 43 / 53); health and damage are the elite defaults
-- (ESTIMATED, VerifiedBuild -1). Spawns: every Wowhead spot, height read on the dev server from its own maps and vmaps (the
-- surface at terrain level where there are several; Tyrannikus only at the one spot with ground under it). Safe to run again.
DELETE FROM `creature_template` WHERE `entry` IN (221204,221206,221207,221265,221266,221267,221331,221334,221391,221393);
DELETE FROM `creature_template_difficulty` WHERE `DifficultyID`=0 AND `Entry` IN (221204,221206,221207,221265,221266,221267,221331,221334,221391,221393);
DELETE FROM `creature_template_model` WHERE `CreatureID` IN (221204,221206,221207,221265,221266,221267,221331,221334,221391,221393);
DELETE FROM `creature_classic_level` WHERE `entry` IN (221204,221206,221207,221265,221266,221267,221331,221334,221391,221393);
INSERT INTO `creature_template` (`entry`,`KillCredit1`,`KillCredit2`,`name`,`femaleName`,`subname`,`TitleAlt`,`IconName`,`RequiredExpansion`,`VignetteID`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`Classification`,`dmgschool`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,`unit_flags`,`unit_flags2`,`unit_flags3`,`family`,`trainer_class`,`type`,`VehicleId`,`AIName`,`MovementType`,`ExperienceModifier`,`RacialLeader`,`movementId`,`WidgetSetID`,`WidgetSetUnitConditionID`,`RegenHealth`,`CreatureImmunitiesId`,`flags_extra`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(221204,0,0,'Ylanthrius',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,2,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,-1),
(221206,0,0,'Vvarc'' Zul',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,7,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,-1),
(221207,0,0,'Amokarok',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,7,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,-1),
(221265,0,0,'Larsera',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,2,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,-1),
(221266,0,0,'Zalius',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,3,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,-1),
(221267,0,0,'Shredder 9000',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,9,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,-1),
(221331,0,0,'Florius',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,2,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,-1),
(221334,0,0,'Ghamoo-Raja',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,1,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,-1),
(221391,0,0,'Slirena',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,7,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,-1),
(221393,0,0,'Tyrannikus',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,2,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,-1);
INSERT INTO `creature_template_difficulty` (`Entry`,`DifficultyID`,`LevelScalingDeltaMin`,`LevelScalingDeltaMax`,`ContentTuningID`,`HealthScalingExpansion`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`DamageModifier`,`CreatureDifficultyID`,`TypeFlags`,`TypeFlags2`,`TypeFlags3`,`LootID`,`PickPocketLootID`,`SkinLootID`,`GoldMin`,`GoldMax`,`StaticFlags1`,`StaticFlags2`,`StaticFlags3`,`StaticFlags4`,`StaticFlags5`,`StaticFlags6`,`StaticFlags7`,`StaticFlags8`,`VerifiedBuild`) VALUES
(221204,0,0,0,0,0,1.0,1.0,1.0,2.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1),
(221206,0,0,0,0,0,1.0,1.0,1.0,2.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1),
(221207,0,0,0,0,0,1.0,1.0,1.0,2.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1),
(221265,0,0,0,0,0,1.0,1.0,1.0,2.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1),
(221266,0,0,0,0,0,1.0,1.0,1.0,2.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1),
(221267,0,0,0,0,0,1.0,1.0,1.0,2.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1),
(221331,0,0,0,0,0,1.0,1.0,1.0,2.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1),
(221334,0,0,0,0,0,1.0,1.0,1.0,2.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1),
(221391,0,0,0,0,0,1.0,1.0,1.0,2.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1),
(221393,0,0,0,0,0,1.0,1.0,1.0,2.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1);
INSERT INTO `creature_template_model` (`CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild`) VALUES
(221204,0,2717,1.0,1.0,-1),
(221206,0,14423,1.0,1.0,-1),
(221207,0,11181,1.0,1.0,-1),
(221265,0,2717,1.0,1.0,-1),
(221266,0,11347,1.0,1.0,-1),
(221267,0,118042,1.0,1.0,-1),
(221331,0,2717,1.0,1.0,-1),
(221334,0,119778,1.0,1.0,-1),
(221391,0,10871,1.0,1.0,-1),
(221393,0,2717,1.0,1.0,-1);
INSERT INTO `creature_classic_level` (`entry`,`level_min`,`level_max`) VALUES
(221204,28,28),
(221206,28,28),
(221207,28,28),
(221265,43,43),
(221266,43,43),
(221267,43,43),
(221331,53,53),
(221334,53,53),
(221391,53,53),
(221393,53,53);
DELETE FROM `creature` WHERE `guid` BETWEEN 47600450 AND 47600489;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(47600450,221204,0,0,0,'0',0,0,0,-1,0,0,-10944.30,-360.10,39.76,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,-1),
(47600451,221204,0,0,0,'0',0,0,0,-1,0,0,-10998.30,-360.10,42.66,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,-1),
(47600452,221204,0,0,0,'0',0,0,0,-1,0,0,-11077.50,-360.10,43.33,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,-1),
(47600453,221206,0,0,0,'0',0,0,0,-1,0,0,-11199.90,-165.60,90.66,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,-1),
(47600454,221206,0,0,0,'0',0,0,0,-1,0,0,-11217.90,-165.60,96.89,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,-1),
(47600455,221206,0,0,0,'0',0,0,0,-1,0,0,-11232.30,-176.40,91.49,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,-1),
(47600456,221207,0,0,0,'0',0,0,0,-1,0,0,-11066.70,-932.50,63.71,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,-1),
(47600457,221207,0,0,0,'0',0,0,0,-1,0,0,-11070.30,-937.90,63.55,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,-1),
(47600458,221207,0,0,0,'0',0,0,0,-1,0,0,-11091.90,-948.70,65.35,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,-1),
(47600459,221265,1,0,0,'0',0,0,0,-1,0,0,2927.90,-3167.10,176.62,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,-1),
(47600460,221265,1,0,0,'0',0,0,0,-1,0,0,2927.90,-3224.70,165.46,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,-1),
(47600461,221265,1,0,0,'0',0,0,0,-1,0,0,2920.20,-3224.70,165.81,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,-1),
(47600462,221266,1,0,0,'0',0,0,0,-1,0,0,2774.10,-2959.50,144.96,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,-1),
(47600463,221266,1,0,0,'0',0,0,0,-1,0,0,2766.40,-2959.50,143.53,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,-1),
(47600464,221266,1,0,0,'0',0,0,0,-1,0,0,2728.00,-2971.00,141.28,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,-1),
(47600465,221267,1,0,0,'0',0,0,0,-1,0,0,2351.30,-3282.40,101.56,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,-1),
(47600466,221267,1,0,0,'0',0,0,0,-1,0,0,2320.50,-3282.40,101.56,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,-1),
(47600467,221267,1,0,0,'0',0,0,0,-1,0,0,2305.20,-3282.40,101.57,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,-1),
(47600468,221331,0,0,0,'0',0,0,0,-1,0,0,476.00,-3324.30,121.05,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,-1),
(47600469,221331,0,0,0,'0',0,0,0,-1,0,0,455.50,-3339.70,119.88,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,-1),
(47600470,221331,0,0,0,'0',0,0,0,-1,0,0,445.20,-3347.40,119.17,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,-1),
(47600471,221334,0,0,0,'0',0,0,0,-1,0,0,799.50,-4001.20,95.38,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,-1),
(47600472,221334,0,0,0,'0',0,0,0,-1,0,0,758.40,-4008.90,92.92,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,-1),
(47600473,221334,0,0,0,'0',0,0,0,-1,0,0,763.50,-4016.60,93.42,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,-1),
(47600474,221391,1,0,0,'0',0,0,0,-1,0,0,-2968.30,2774.90,52.12,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,-1),
(47600475,221391,1,0,0,'0',0,0,0,-1,0,0,-3042.50,2747.10,58.34,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,-1),
(47600476,221391,1,0,0,'0',0,0,0,-1,0,0,-2986.90,2733.20,51.00,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,-1),
(47600479,221393,1,0,0,'0',0,0,0,-1,0,0,-3033.20,1801.10,12.80,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,-1);
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

-- 81742 Duskwood Mission XIII: Defeat Ylanthrius (level 27, min 23, live build 1.60.1.70959, 2 player(s))
DELETE FROM `quest_template` WHERE `ID`=81742;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (81742,2,10,1,0,5,2.0,0,1.0,0,0,4352,0,0,0,18446744073709551615,2641,7,0,'Duskwood Mission XIII: Defeat Ylanthrius','Defeat Ylanthrius in the Duskwood Nightmare Incursion at the Yorgen Farmstead field and return to Field Captain Palandar.','While these demons distract us here, the Emerald Dream is being corrupted into nightmare. Quick, travel through the Emerald Dream Portal in the Twilight Grove, and journey to the Nightmare Incursion at the Yorgen Farmstead. Defeat the dragon Ylanthrius there and return to me.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=81742;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (448730,81742,0,0,1,221204,1,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=81742;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (81742,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=81742;
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES (81742,3400,0);
DELETE FROM `quest_classic_level` WHERE `ID`=81742;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (81742,27,23,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=81742;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (81742,2,27);
DELETE FROM `creature_queststarter` WHERE `quest`=81742;
DELETE FROM `gameobject_queststarter` WHERE `quest`=81742;
DELETE FROM `creature_questender` WHERE `quest`=81742;
DELETE FROM `gameobject_questender` WHERE `quest`=81742;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (221471,81742,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (221471,81742,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (221471);

-- 81743 Duskwood Mission XIV: Defeat Vvarc'zul (level 27, min 23, live build 1.60.1.70959, 1 player(s))
DELETE FROM `quest_template` WHERE `ID`=81743;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (81743,2,10,1,0,5,1.0,0,1.0,0,0,4352,0,0,0,18446744073709551615,2641,4,0,'Duskwood Mission XIV: Defeat Vvarc''zul','Defeat Vvarc''zul in the Duskwood Nightmare Incursion deep in the Vul''gol Ogre Mound and return to Field Captain Palandar.','While these demons distract us here, the Emerald Dream is being corrupted into nightmare. Quick, travel through the Emerald Dream Portal in the Twilight Grove, and journey to the Nightmare Incursion at the Vul''gol Ogre Mound. Defeat the ogre warlord Vvarc''zul there and return to me.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=81743;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (448731,81743,0,0,0,221206,1,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=81743;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (81743,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=81743;
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES (81743,1700,0);
DELETE FROM `quest_classic_level` WHERE `ID`=81743;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (81743,27,23,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=81743;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (81743,2,27);
DELETE FROM `creature_queststarter` WHERE `quest`=81743;
DELETE FROM `gameobject_queststarter` WHERE `quest`=81743;
DELETE FROM `creature_questender` WHERE `quest`=81743;
DELETE FROM `gameobject_questender` WHERE `quest`=81743;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (221471,81743,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (221471,81743,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (221471);

-- 81744 Duskwood Mission XV: Defeat Amokarok (level 27, min 23, live build 1.60.1.70959, 1 player(s))
DELETE FROM `quest_template` WHERE `ID`=81744;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (81744,2,10,1,0,5,1.0,0,1.0,0,0,4352,0,0,0,18446744073709551615,2641,4,0,'Duskwood Mission XV: Defeat Amokarok','Defeat Amokarok in the Duskwood Nightmare Incursion at a campsite near the barn in the Rotting Orchard and return to Field Captain Palandar.','While these demons distract us here, the Emerald Dream is being corrupted into nightmare. Quick, travel through the Emerald Dream Portal in the Twilight Grove, and journey to the Nightmare Incursion at the Rotting Orchard. Defeat the worgen leader Amokarok there and return to me.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=81744;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (448736,81744,0,0,1,221207,1,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=81744;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (81744,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=81744;
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES (81744,1700,0);
DELETE FROM `quest_classic_level` WHERE `ID`=81744;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (81744,27,23,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=81744;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (81744,2,27);
DELETE FROM `creature_queststarter` WHERE `quest`=81744;
DELETE FROM `gameobject_queststarter` WHERE `quest`=81744;
DELETE FROM `creature_questender` WHERE `quest`=81744;
DELETE FROM `gameobject_questender` WHERE `quest`=81744;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (221471,81744,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (221471,81744,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (221471);

-- 81837 Hinterlands Mission XIII: Defeat Florius (level 52, min 47, live build 1.60.1.70959, 2 player(s))
DELETE FROM `quest_template` WHERE `ID`=81837;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardItem1`,`RewardAmount1`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (81837,2,47,1,0,5,2.0,0,1.0,446536,0,4352,0,0,0,18446744073709551615,219927,1,2641,7,0,'Hinterlands Mission XIII: Defeat Florius','Defeat Florius in the Hinterlands Nightmare Incursion at the main courtyard in Agol''watha and return to Field Captain Korlian.','While these demons distract us here, the Emerald Dream is being corrupted into nightmare. Quick, travel through the Emerald Dream Portal in Seradane, and journey to the Nightmare Incursion in Agol''watha. Defeat the dragon Florius there and return to me.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=81837;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (448877,81837,0,0,1,221331,1,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=81837;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (81837,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=81837;
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES (81837,3800,0);
DELETE FROM `quest_classic_level` WHERE `ID`=81837;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (81837,52,47,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=81837;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (81837,2,52);
DELETE FROM `creature_queststarter` WHERE `quest`=81837;
DELETE FROM `gameobject_queststarter` WHERE `quest`=81837;
DELETE FROM `creature_questender` WHERE `quest`=81837;
DELETE FROM `gameobject_questender` WHERE `quest`=81837;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (221479,81837,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (221479,81837,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (221479);

-- 81839 Hinterlands Mission XV: Defeat Ghamoo-Raja (level 52, min 47, live build 1.60.1.70888, 1 player(s))
DELETE FROM `quest_template` WHERE `ID`=81839;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardItem1`,`RewardAmount1`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (81839,2,47,1,0,5,1.0,0,1.0,446536,0,4352,0,0,0,18446744073709551615,219927,1,2641,6,0,'Hinterlands Mission XV: Defeat Ghamoo-Raja','Defeat Ghamoo-Raja in the Hinterlands Nightmare Incursion in the courtyard at Shaol''watha and return to Field Captain Korlian.','While these demons distract us here, the Emerald Dream is being corrupted into nightmare. Quick, travel through the Emerald Dream Portal in Seradane, and journey to the Nightmare Incursion at Shaol''watha. Defeat the turtle "king" known as Ghamoo-Raja there and return to me.','','',70888);
DELETE FROM `quest_objectives` WHERE `QuestID`=81839;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (448882,81839,0,0,1,221334,1,0,1,NULL,70888);
DELETE FROM `quest_template_addon` WHERE `ID`=81839;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (81839,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=81839;
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES (81839,1900,0);
DELETE FROM `quest_classic_level` WHERE `ID`=81839;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (81839,52,47,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=81839;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (81839,2,52);
DELETE FROM `creature_queststarter` WHERE `quest`=81839;
DELETE FROM `gameobject_queststarter` WHERE `quest`=81839;
DELETE FROM `creature_questender` WHERE `quest`=81839;
DELETE FROM `gameobject_questender` WHERE `quest`=81839;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (221479,81839,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (221479,81839,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (221479);

-- 81868 Feralas Mission XIII: Defeat Tyrannikus (level 52, min 47, live build 1.60.1.70959, 1 player(s))
DELETE FROM `quest_template` WHERE `ID`=81868;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardItem1`,`RewardAmount1`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (81868,2,357,1,0,5,2.0,0,1.0,446536,0,4352,0,0,0,18446744073709551615,219927,1,2641,7,0,'Feralas Mission XIII: Defeat Tyrannikus','Defeat Tyrannikus in the Feralas Nightmare Incursion at the ruined temple in Oneiros and return to Field Captain Arunnel.','While these demons distract us here, the Emerald Dream is being corrupted into nightmare. Quick, travel through the Emerald Dream Portal in Dream Bough, and journey to the Nightmare Incursion in Oneiros. Defeat the dragon Tyrannikus there and return to me.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=81868;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (448927,81868,0,0,0,221393,1,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=81868;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (81868,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=81868;
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES (81868,3800,0);
DELETE FROM `quest_classic_level` WHERE `ID`=81868;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (81868,52,47,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=81868;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (81868,2,52);
DELETE FROM `creature_queststarter` WHERE `quest`=81868;
DELETE FROM `gameobject_queststarter` WHERE `quest`=81868;
DELETE FROM `creature_questender` WHERE `quest`=81868;
DELETE FROM `gameobject_questender` WHERE `quest`=81868;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (221480,81868,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (221480,81868,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (221480);

-- 81871 Feralas Mission XV: Defeat Slirena (level 52, min 47, live build 1.60.1.70888, 1 player(s))
DELETE FROM `quest_template` WHERE `ID`=81871;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardItem1`,`RewardAmount1`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (81871,2,357,1,0,5,1.0,0,1.0,446536,0,4352,0,0,0,18446744073709551615,219927,1,2641,6,0,'Feralas Mission XV: Defeat Slirena','Defeat Slirena in the Feralas Nightmare Incursion near the ziggurat in the Ruins of Ravenwind and return to Field Captain Arunnel.','While these demons distract us here, the Emerald Dream is being corrupted into nightmare. Quick, travel through the Emerald Dream Portal in Dream Bough, and journey to the Nightmare Incursion at the Ruins of Ravenwind. Defeat the harpy "queen" Slirena there and return to me.','','',70888);
DELETE FROM `quest_objectives` WHERE `QuestID`=81871;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (448931,81871,0,0,0,221391,1,0,1,NULL,70888);
DELETE FROM `quest_template_addon` WHERE `ID`=81871;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (81871,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=81871;
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES (81871,1900,0);
DELETE FROM `quest_classic_level` WHERE `ID`=81871;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (81871,52,47,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=81871;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (81871,2,52);
DELETE FROM `creature_queststarter` WHERE `quest`=81871;
DELETE FROM `gameobject_queststarter` WHERE `quest`=81871;
DELETE FROM `creature_questender` WHERE `quest`=81871;
DELETE FROM `gameobject_questender` WHERE `quest`=81871;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (221480,81871,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (221480,81871,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (221480);

