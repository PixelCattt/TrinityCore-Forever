-- WoW Forever creatures and objects that the missing Forever quests need, the quest items nothing dropped, and two creature
-- movement fixes. Data from Everlake (GPL-3.0), commit cf07dad, files 2026_11_19_983, 987, 988, 990, 992, 993, 995 and 997,
-- which build them from EG Link (Efficient Games, https://efficient.games, CC BY 4.0: creature details the live server sent
-- players' games), Wowhead's WoW Forever database (www.wowhead.com/forever: NPC pages), Icy Veins' WoW Forever database
-- (db.icy-veins.com/wow-forever: objects, where players' addons saw them, and drops) and QuestieDB (Questie team, GPL-3.0:
-- positions and levels). Changed: checked against our world and written as our own rows; spawns leave npcflag, unit flags and
-- health to the template (NULL). Factions are inferred by Everlake (a same-name twin in the world, else a stock faction by how
-- players see the creature), heights come from Everlake's map and vmap tool. Not checked in game.
-- Everything goes in only where missing. Safe to run more than once.


-- 1. Creatures from EG Link creature details (file 983), only where our world has no template yet.
DROP TEMPORARY TABLE IF EXISTS `forever_ct_983`;
CREATE TEMPORARY TABLE `forever_ct_983` SELECT `entry`,`KillCredit1`,`KillCredit2`,`name`,`femaleName`,`subname`,`TitleAlt`,`IconName`,`RequiredExpansion`,`VignetteID`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`Classification`,`dmgschool`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,`unit_flags`,`unit_flags2`,`unit_flags3`,`family`,`trainer_class`,`type`,`VehicleId`,`AIName`,`MovementType`,`ExperienceModifier`,`RacialLeader`,`movementId`,`WidgetSetID`,`WidgetSetUnitConditionID`,`RegenHealth`,`CreatureImmunitiesId`,`flags_extra`,`ScriptName`,`StringId`,`VerifiedBuild` FROM `creature_template` WHERE 0;
INSERT INTO `forever_ct_983` (`entry`,`KillCredit1`,`KillCredit2`,`name`,`femaleName`,`subname`,`TitleAlt`,`IconName`,`RequiredExpansion`,`VignetteID`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`Classification`,`dmgschool`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,`unit_flags`,`unit_flags2`,`unit_flags3`,`family`,`trainer_class`,`type`,`VehicleId`,`AIName`,`MovementType`,`ExperienceModifier`,`RacialLeader`,`movementId`,`WidgetSetID`,`WidgetSetUnitConditionID`,`RegenHealth`,`CreatureImmunitiesId`,`flags_extra`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(221269,0,0,'Maseara Autumnmoon',NULL,NULL,NULL,NULL,0,0,12,2,1,1.14286,1,0,0,2000,2000,1,1,8,0,2048,0,0,0,7,0,'',0,1,0,0,0,0,1,0,0,'',NULL,0),
(236573,0,0,'Gatekeeper Rageroar',NULL,NULL,NULL,NULL,0,0,414,2,1,1.14286,1,0,0,2000,2000,1,1,1,0,2048,0,0,0,7,0,'',0,1,0,0,0,0,1,0,0,'',NULL,0),
(253097,0,0,'Mirda',NULL,NULL,NULL,NULL,0,0,12,2,1,1.14286,1,0,0,2000,2000,1,1,1,0,2048,0,0,0,7,0,'',0,1,0,0,0,0,1,0,0,'',NULL,0),
(253525,0,0,'Bristleback Thornweaver',NULL,NULL,NULL,NULL,0,0,111,0,1,1.14286,1,0,0,2000,2000,1,1,8,0,2048,0,0,0,7,0,'',1,1,0,0,0,0,1,0,0,'',NULL,0),
(253527,0,0,'Kog''thug the Brave',NULL,NULL,NULL,NULL,0,0,12,2,1,1.14286,1,1,0,2000,2000,1,1,1,0,2048,0,0,0,7,0,'',0,1,0,0,0,0,1,0,0,'',NULL,0),
(254674,0,0,'Woodwyrd',NULL,NULL,NULL,NULL,0,0,35,2,1,1.14286,1,1,0,2000,2000,1,1,1,0,2048,0,0,0,6,0,'',0,1,0,0,0,0,1,0,0,'',NULL,0),
(255678,0,0,'Quolga the Wise',NULL,NULL,NULL,NULL,0,0,35,2,1,1.14286,1,1,0,2000,2000,1,1,1,0,2048,0,0,0,7,0,'',0,1,0,0,0,0,1,0,0,'',NULL,0),
(258048,0,0,'Jom-jom',NULL,NULL,NULL,NULL,0,0,29,2,1,1.14286,1,0,0,2000,2000,1,1,1,0,2048,0,0,0,7,0,'',0,1,0,0,0,0,1,0,0,'',NULL,0),
(258570,0,0,'Da''grosh',NULL,NULL,NULL,NULL,0,0,29,2,1,1.14286,1,0,0,2000,2000,1,1,1,0,2048,0,0,0,7,0,'',0,1,0,0,0,0,1,0,0,'',NULL,0),
(260383,0,0,'Sergeant Ulka',NULL,NULL,NULL,NULL,0,0,29,2,1,1.14286,1,1,0,2000,2000,1,1,1,0,2048,0,0,0,7,0,'',0,1,0,0,0,0,1,0,0,'',NULL,0),
(260390,0,0,'Captain Bentcoin',NULL,NULL,NULL,NULL,0,0,35,2,1,1.14286,1,0,0,2000,2000,1,1,1,0,2048,0,0,0,7,0,'',0,1,0,0,0,0,1,0,0,'',NULL,0),
(260391,0,0,'Captain Haynes',NULL,NULL,NULL,NULL,0,0,35,2,1,1.14286,1,0,0,2000,2000,1,1,1,0,2048,0,0,0,7,0,'',0,1,0,0,0,0,1,0,0,'',NULL,0),
(260931,0,0,'Clubtoe',NULL,NULL,NULL,NULL,0,0,29,2,1,1.14286,1,0,0,2000,2000,1,1,1,0,2048,0,0,0,7,0,'',0,1,0,0,0,0,1,0,0,'',NULL,0),
(260995,0,0,'Ogre Miner',NULL,NULL,NULL,NULL,0,0,29,0,1,1.14286,1,0,0,2000,2000,1,1,1,0,2048,0,0,0,7,0,'',1,1,0,0,0,0,1,0,0,'',NULL,0),
(261208,0,0,'Twilight Brute',NULL,NULL,NULL,NULL,0,0,35,2,1,1.14286,1,0,0,2000,2000,1,1,1,0,2048,0,0,0,7,0,'',0,1,0,0,0,0,1,0,0,'',NULL,0),
(263316,0,0,'Picked Carcass',NULL,NULL,NULL,NULL,0,0,35,2,1,1.14286,1,0,0,2000,2000,1,1,1,0,2048,0,0,0,7,0,'',0,1,0,0,0,0,1,0,0,'',NULL,0),
(263615,0,0,'Krek the Noxious',NULL,NULL,NULL,NULL,0,0,14,0,1,1.14286,1,1,0,2000,2000,1,1,1,0,2048,0,0,0,1,0,'',1,1,0,0,0,0,1,0,0,'',NULL,0),
(266847,0,0,'Anastasia Miller',NULL,NULL,NULL,NULL,0,0,35,2,1,1.14286,1,0,0,2000,2000,1,1,1,0,2048,0,0,0,7,0,'',0,1,0,0,0,0,1,0,0,'',NULL,0),
(268992,0,0,'Zimmix Sputterspark',NULL,NULL,NULL,NULL,0,0,35,2,1,1.14286,1,0,0,2000,2000,1,1,1,0,2048,0,0,0,7,0,'',0,1,0,0,0,0,1,0,0,'',NULL,0);
INSERT INTO `creature_template` (`entry`,`KillCredit1`,`KillCredit2`,`name`,`femaleName`,`subname`,`TitleAlt`,`IconName`,`RequiredExpansion`,`VignetteID`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`Classification`,`dmgschool`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,`unit_flags`,`unit_flags2`,`unit_flags3`,`family`,`trainer_class`,`type`,`VehicleId`,`AIName`,`MovementType`,`ExperienceModifier`,`RacialLeader`,`movementId`,`WidgetSetID`,`WidgetSetUnitConditionID`,`RegenHealth`,`CreatureImmunitiesId`,`flags_extra`,`ScriptName`,`StringId`,`VerifiedBuild`) SELECT `s`.`entry`,`s`.`KillCredit1`,`s`.`KillCredit2`,`s`.`name`,`s`.`femaleName`,`s`.`subname`,`s`.`TitleAlt`,`s`.`IconName`,`s`.`RequiredExpansion`,`s`.`VignetteID`,`s`.`faction`,`s`.`npcflag`,`s`.`speed_walk`,`s`.`speed_run`,`s`.`scale`,`s`.`Classification`,`s`.`dmgschool`,`s`.`BaseAttackTime`,`s`.`RangeAttackTime`,`s`.`BaseVariance`,`s`.`RangeVariance`,`s`.`unit_class`,`s`.`unit_flags`,`s`.`unit_flags2`,`s`.`unit_flags3`,`s`.`family`,`s`.`trainer_class`,`s`.`type`,`s`.`VehicleId`,`s`.`AIName`,`s`.`MovementType`,`s`.`ExperienceModifier`,`s`.`RacialLeader`,`s`.`movementId`,`s`.`WidgetSetID`,`s`.`WidgetSetUnitConditionID`,`s`.`RegenHealth`,`s`.`CreatureImmunitiesId`,`s`.`flags_extra`,`s`.`ScriptName`,`s`.`StringId`,`s`.`VerifiedBuild` FROM `forever_ct_983` `s` WHERE NOT EXISTS (SELECT 1 FROM `creature_template` `x` WHERE `x`.`entry`=`s`.`entry`);
DROP TEMPORARY TABLE IF EXISTS `forever_ct_983`;

DROP TEMPORARY TABLE IF EXISTS `forever_ctd_983`;
CREATE TEMPORARY TABLE `forever_ctd_983` SELECT `Entry`,`DifficultyID`,`LevelScalingDeltaMin`,`LevelScalingDeltaMax`,`ContentTuningID`,`HealthScalingExpansion`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`DamageModifier`,`CreatureDifficultyID`,`TypeFlags`,`TypeFlags2`,`TypeFlags3`,`LootID`,`PickPocketLootID`,`SkinLootID`,`GoldMin`,`GoldMax`,`StaticFlags1`,`StaticFlags2`,`StaticFlags3`,`StaticFlags4`,`StaticFlags5`,`StaticFlags6`,`StaticFlags7`,`StaticFlags8`,`VerifiedBuild` FROM `creature_template_difficulty` WHERE 0;
INSERT INTO `forever_ctd_983` (`Entry`,`DifficultyID`,`LevelScalingDeltaMin`,`LevelScalingDeltaMax`,`ContentTuningID`,`HealthScalingExpansion`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`DamageModifier`,`CreatureDifficultyID`,`TypeFlags`,`TypeFlags2`,`TypeFlags3`,`LootID`,`PickPocketLootID`,`SkinLootID`,`GoldMin`,`GoldMax`,`StaticFlags1`,`StaticFlags2`,`StaticFlags3`,`StaticFlags4`,`StaticFlags5`,`StaticFlags6`,`StaticFlags7`,`StaticFlags8`,`VerifiedBuild`) VALUES
(221269,0,0,0,0,0,10.0,1,1,1,0,134221824,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(236573,0,0,0,0,0,1.25,1,1,1,0,134217728,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(253097,0,0,0,0,0,1.0,1,1,1,0,134217728,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(253525,0,0,0,0,0,1.0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(253527,0,0,0,0,0,1.0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(254674,0,0,0,0,0,1.0,1,1,1,0,134217728,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(255678,0,0,0,0,0,1.0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(258048,0,0,0,0,0,1.8,1,1,1,0,4096,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(258570,0,0,0,0,0,1.3,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(260383,0,0,0,0,0,2.0,1,1,1,0,134217728,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(260390,0,0,0,0,0,1.2,1,1,1,0,134217728,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(260391,0,0,0,0,0,1.2,1,1,1,0,134217728,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(260931,0,0,0,0,0,1.25,1,1,1,0,134217744,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(260995,0,0,0,0,0,1.0,1,1,1,0,134217744,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(261208,0,0,0,0,0,1.0,1,1,1,0,1073741824,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(263316,0,0,0,0,0,1.0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(263615,0,0,0,0,0,3.5,1,1,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(266847,0,0,0,0,0,3.0,1,1,1,0,134217728,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(268992,0,0,0,0,0,2.0,1,1,1,0,134217728,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `creature_template_difficulty` (`Entry`,`DifficultyID`,`LevelScalingDeltaMin`,`LevelScalingDeltaMax`,`ContentTuningID`,`HealthScalingExpansion`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`DamageModifier`,`CreatureDifficultyID`,`TypeFlags`,`TypeFlags2`,`TypeFlags3`,`LootID`,`PickPocketLootID`,`SkinLootID`,`GoldMin`,`GoldMax`,`StaticFlags1`,`StaticFlags2`,`StaticFlags3`,`StaticFlags4`,`StaticFlags5`,`StaticFlags6`,`StaticFlags7`,`StaticFlags8`,`VerifiedBuild`) SELECT `s`.`Entry`,`s`.`DifficultyID`,`s`.`LevelScalingDeltaMin`,`s`.`LevelScalingDeltaMax`,`s`.`ContentTuningID`,`s`.`HealthScalingExpansion`,`s`.`HealthModifier`,`s`.`ManaModifier`,`s`.`ArmorModifier`,`s`.`DamageModifier`,`s`.`CreatureDifficultyID`,`s`.`TypeFlags`,`s`.`TypeFlags2`,`s`.`TypeFlags3`,`s`.`LootID`,`s`.`PickPocketLootID`,`s`.`SkinLootID`,`s`.`GoldMin`,`s`.`GoldMax`,`s`.`StaticFlags1`,`s`.`StaticFlags2`,`s`.`StaticFlags3`,`s`.`StaticFlags4`,`s`.`StaticFlags5`,`s`.`StaticFlags6`,`s`.`StaticFlags7`,`s`.`StaticFlags8`,`s`.`VerifiedBuild` FROM `forever_ctd_983` `s` WHERE NOT EXISTS (SELECT 1 FROM `creature_template_difficulty` `x` WHERE `x`.`Entry`=`s`.`Entry` AND `x`.`DifficultyID`=`s`.`DifficultyID`);
DROP TEMPORARY TABLE IF EXISTS `forever_ctd_983`;

DROP TEMPORARY TABLE IF EXISTS `forever_ctm_983`;
CREATE TEMPORARY TABLE `forever_ctm_983` SELECT `CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild` FROM `creature_template_model` WHERE 0;
INSERT INTO `forever_ctm_983` (`CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild`) VALUES
(221269,0,146929,1.0,1.0,0),
(236573,0,1012,1.0,1,0),
(253097,0,9412,1.2,1.0,0),
(253525,0,6077,1.0,1.0,0),
(253527,0,143817,1.65,1.0,0),
(254674,0,138335,2.0,1.0,0),
(255678,0,6099,1.0,1.0,0),
(258048,0,10714,1.0,1.0,0),
(258570,0,140921,1.0,1.0,0),
(260383,0,142827,1.0,1.0,0),
(260390,0,127,1.0,50.0,0),
(260391,0,4620,1.0,50.0,0),
(260931,0,10714,1.0,1.0,0),
(260995,0,11546,1.0,1.0,0),
(261208,0,10714,1.0,1.0,0),
(263316,0,7555,1.0,1.0,0),
(263615,0,143766,1.75,1.0,0),
(266847,0,144897,1.0,1.0,0),
(268992,0,145735,1.0,1.0,0);
INSERT INTO `creature_template_model` (`CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild`) SELECT `s`.`CreatureID`,`s`.`Idx`,`s`.`CreatureDisplayID`,`s`.`DisplayScale`,`s`.`Probability`,`s`.`VerifiedBuild` FROM `forever_ctm_983` `s` WHERE NOT EXISTS (SELECT 1 FROM `creature_template_model` `x` WHERE `x`.`CreatureID`=`s`.`CreatureID` AND `x`.`Idx`=`s`.`Idx`);
DROP TEMPORARY TABLE IF EXISTS `forever_ctm_983`;

DROP TEMPORARY TABLE IF EXISTS `forever_ccl_983`;
CREATE TEMPORARY TABLE `forever_ccl_983` SELECT `entry`,`level_min`,`level_max` FROM `creature_classic_level` WHERE 0;
INSERT INTO `forever_ccl_983` (`entry`,`level_min`,`level_max`) VALUES
(221269,31,31),
(236573,55,55),
(253097,37,37),
(253525,42,43),
(253527,43,43),
(254674,60,60),
(255678,42,43),
(258048,41,41),
(258570,44,44),
(260383,55,55),
(260390,43,44),
(260391,43,44),
(260931,35,35),
(260995,42,43),
(261208,36,37),
(263316,35,35),
(263615,42,42),
(266847,36,36),
(268992,35,35);
INSERT INTO `creature_classic_level` (`entry`,`level_min`,`level_max`) SELECT `s`.`entry`,`s`.`level_min`,`s`.`level_max` FROM `forever_ccl_983` `s` WHERE NOT EXISTS (SELECT 1 FROM `creature_classic_level` `x` WHERE `x`.`entry`=`s`.`entry`);
DROP TEMPORARY TABLE IF EXISTS `forever_ccl_983`;

--    Model sizes for displays that had none.
DROP TEMPORARY TABLE IF EXISTS `forever_cmi_983`;
CREATE TEMPORARY TABLE `forever_cmi_983` SELECT `DisplayID`,`BoundingRadius`,`CombatReach`,`DisplayID_Other_Gender`,`VerifiedBuild` FROM `creature_model_info` WHERE 0;
INSERT INTO `forever_cmi_983` (`DisplayID`,`BoundingRadius`,`CombatReach`,`DisplayID_Other_Gender`,`VerifiedBuild`) VALUES
(138335,0.347,2.0,0,0),
(140921,0.372,1.5,0,0),
(142827,0.2596,1.65,0,0),
(143766,0.35,0.8,0,0),
(143817,1.06527,1.5,0,0),
(144897,0.208,1.5,0,0),
(145735,0.306,1.5,0,0),
(146929,0.306,1.5,0,0);
INSERT INTO `creature_model_info` (`DisplayID`,`BoundingRadius`,`CombatReach`,`DisplayID_Other_Gender`,`VerifiedBuild`) SELECT `s`.`DisplayID`,`s`.`BoundingRadius`,`s`.`CombatReach`,`s`.`DisplayID_Other_Gender`,`s`.`VerifiedBuild` FROM `forever_cmi_983` `s` WHERE NOT EXISTS (SELECT 1 FROM `creature_model_info` `x` WHERE `x`.`DisplayID`=`s`.`DisplayID`);
DROP TEMPORARY TABLE IF EXISTS `forever_cmi_983`;

--    Spawns (heights from Everlake's map and vmap tool), only for a creature with no spawn of its own yet and only where the guid is free.
DROP TEMPORARY TABLE IF EXISTS `forever_cs_983`;
CREATE TEMPORARY TABLE `forever_cs_983` SELECT `guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild` FROM `creature` WHERE 0;
INSERT INTO `forever_cs_983` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(920010000,221269,1,0,0,'0',0,0,0,-1,0,0,2910.17,-3273.17,160.04,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920010001,236573,1,0,0,'0',0,0,0,-1,0,0,4661.02,-5421.03,107.76,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920010002,253097,1,0,0,'0',0,0,0,-1,0,0,-1658.15,1064.67,89.09,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920010003,253525,1,0,0,'0',0,0,0,-1,0,0,-2194.38,725.71,144.34,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,0),
(920010004,253525,1,0,0,'0',0,0,0,-1,0,0,-2218.71,724.07,147.34,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,0),
(920010005,253525,1,0,0,'0',0,0,0,-1,0,0,-2424.39,721.61,135.45,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,0),
(920010006,253525,1,0,0,'0',0,0,0,-1,0,0,-2226.36,712.38,149.18,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,0),
(920010007,253525,1,0,0,'0',0,0,0,-1,0,0,-2216.79,711.57,145.5,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,0),
(920010008,253525,1,0,0,'0',0,0,0,-1,0,0,-2442.84,707.05,134.06,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,0),
(920010009,253525,1,0,0,'0',0,0,0,-1,0,0,-2243.99,706.64,157.34,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,0),
(920010010,253525,1,0,0,'0',0,0,0,-1,0,0,-2205.04,703.57,144.12,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,0),
(920010011,253525,1,0,0,'0',0,0,0,-1,0,0,-2437.92,696.8,134.94,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,0),
(920010012,253527,1,0,0,'0',0,0,0,-1,0,0,-2325.99,534.03,216.41,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920010013,254674,1,0,0,'0',0,0,0,-1,0,0,-2880.99,596.97,119.71,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920010014,255678,1,0,0,'0',0,0,0,-1,0,0,-2101.99,832.92,192.04,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920010015,258048,0,0,0,'0',0,0,0,-1,0,0,-7267.24,-5449.63,64.19,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920010016,258570,0,0,0,'0',0,0,0,-1,0,0,-7693.07,-3514.96,182.17,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920010017,260383,1,0,0,'0',0,0,0,-1,0,0,-2693.08,-4665.75,10.16,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920010018,260390,0,0,0,'0',0,0,0,-1,0,0,-7750.95,-6317.78,19.3,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920010019,260391,0,0,0,'0',0,0,0,-1,0,0,-7752.89,-6315.84,19.26,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920010020,260931,0,0,0,'0',0,0,0,-1,0,0,-7986.01,-4314.24,7.93,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920010021,260995,0,0,0,'0',0,0,0,-1,0,0,-7616.12,-3177.4,180.32,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,0),
(920010022,261208,0,0,0,'0',0,0,0,-1,0,0,-7977.93,-4276.9,47.02,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920010023,263316,0,0,0,'0',0,0,0,-1,0,0,-8368.51,-4881.69,24.89,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920010024,263615,0,0,0,'0',0,0,0,-1,0,0,-7556.95,-4601.85,14.74,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,0),
(920010025,263615,0,0,0,'0',0,0,0,-1,0,0,-7541.75,-4641.13,13.58,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,0),
(920010026,263615,0,0,0,'0',0,0,0,-1,0,0,-7528.49,-4661.99,14.07,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,0),
(920010027,263615,0,0,0,'0',0,0,0,-1,0,0,-7555.33,-4673.63,11.54,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,0),
(920010028,263615,0,0,0,'0',0,0,0,-1,0,0,-7512.33,-4691.09,11.66,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,0),
(920010029,263615,0,0,0,'0',0,0,0,-1,0,0,-7585.08,-4697.88,10.58,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,0),
(920010030,263615,0,0,0,'0',0,0,0,-1,0,0,-7382.02,-4718.25,95.89,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,0),
(920010031,263615,0,0,0,'0',0,0,0,-1,0,0,-7485.49,-4721.64,12.12,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,0),
(920010032,263615,0,0,0,'0',0,0,0,-1,0,0,-7571.82,-4736.19,12.31,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,0),
(920010033,263615,0,0,0,'0',0,0,0,-1,0,0,-7539.81,-4736.68,11.55,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,0),
(920010034,266847,0,0,0,'0',0,0,0,-1,0,0,-1679.89,-1831.83,86.49,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920010035,268992,0,0,0,'0',0,0,0,-1,0,0,-11712.86,723.79,50.69,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0);
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) SELECT `s`.`guid`,`s`.`id`,`s`.`map`,`s`.`zoneId`,`s`.`areaId`,`s`.`spawnDifficulties`,`s`.`phaseUseFlags`,`s`.`PhaseId`,`s`.`PhaseGroup`,`s`.`terrainSwapMap`,`s`.`modelid`,`s`.`equipment_id`,`s`.`position_x`,`s`.`position_y`,`s`.`position_z`,`s`.`orientation`,`s`.`spawntimesecs`,`s`.`wander_distance`,`s`.`currentwaypoint`,`s`.`curHealthPct`,`s`.`MovementType`,`s`.`npcflag`,`s`.`unit_flags`,`s`.`unit_flags2`,`s`.`unit_flags3`,`s`.`ScriptName`,`s`.`StringId`,`s`.`VerifiedBuild` FROM `forever_cs_983` `s`
WHERE EXISTS (SELECT 1 FROM `creature_template` `t` WHERE `t`.`entry`=`s`.`id`)
  AND NOT EXISTS (SELECT 1 FROM `creature` `x` WHERE `x`.`guid`=`s`.`guid`)
  AND NOT EXISTS (SELECT 1 FROM `creature` `x` WHERE `x`.`id`=`s`.`id` AND `x`.`guid` NOT BETWEEN 920010000 AND 920012999);
DROP TEMPORARY TABLE IF EXISTS `forever_cs_983`;

-- 2. Creatures from Wowhead WoW Forever NPC pages (file 988), only where our world has no template yet.
DROP TEMPORARY TABLE IF EXISTS `forever_ct_988`;
CREATE TEMPORARY TABLE `forever_ct_988` SELECT `entry`,`KillCredit1`,`KillCredit2`,`name`,`femaleName`,`subname`,`TitleAlt`,`IconName`,`RequiredExpansion`,`VignetteID`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`Classification`,`dmgschool`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,`unit_flags`,`unit_flags2`,`unit_flags3`,`family`,`trainer_class`,`type`,`VehicleId`,`AIName`,`MovementType`,`ExperienceModifier`,`RacialLeader`,`movementId`,`WidgetSetID`,`WidgetSetUnitConditionID`,`RegenHealth`,`CreatureImmunitiesId`,`flags_extra`,`ScriptName`,`StringId`,`VerifiedBuild` FROM `creature_template` WHERE 0;
INSERT INTO `forever_ct_988` (`entry`,`KillCredit1`,`KillCredit2`,`name`,`femaleName`,`subname`,`TitleAlt`,`IconName`,`RequiredExpansion`,`VignetteID`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`Classification`,`dmgschool`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,`unit_flags`,`unit_flags2`,`unit_flags3`,`family`,`trainer_class`,`type`,`VehicleId`,`AIName`,`MovementType`,`ExperienceModifier`,`RacialLeader`,`movementId`,`WidgetSetID`,`WidgetSetUnitConditionID`,`RegenHealth`,`CreatureImmunitiesId`,`flags_extra`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(205153,0,0,'Ada Gelhardt',NULL,NULL,NULL,NULL,0,0,12,2,1,1.14286,1,0,0,2000,2000,1,1,1,0,2048,0,0,0,7,0,'',0,1,0,0,0,0,1,0,0,'',NULL,0),
(222478,0,0,'Sentinel Keldara Sunblade',NULL,NULL,NULL,NULL,0,0,124,2,1,1.14286,1,0,0,2000,2000,1,1,1,0,2048,0,0,0,7,0,'',0,1,0,0,0,0,1,0,0,'',NULL,0),
(235906,0,0,'Elder Bramblesnap',NULL,NULL,NULL,NULL,0,0,414,2,1,1.14286,1,0,0,2000,2000,1,1,1,0,2048,0,0,0,7,0,'',0,1,0,0,0,0,1,0,0,'',NULL,0),
(235909,0,0,'Furze',NULL,NULL,NULL,NULL,0,0,414,2,1,1.14286,1,0,0,2000,2000,1,1,1,0,2048,0,0,0,7,0,'',0,1,0,0,0,0,1,0,0,'',NULL,0),
(236770,0,0,'Korsa',NULL,NULL,NULL,NULL,0,0,414,2,1,1.14286,1,0,0,2000,2000,1,1,1,0,2048,0,0,0,7,0,'',0,1,0,0,0,0,1,0,0,'',NULL,0),
(237007,0,0,'Graal',NULL,NULL,NULL,NULL,0,0,414,2,1,1.14286,1,0,0,2000,2000,1,1,1,0,2048,0,0,0,7,0,'',0,1,0,0,0,0,1,0,0,'',NULL,0),
(239831,0,0,'Saria Fairmoon',NULL,NULL,NULL,NULL,0,0,35,2,1,1.14286,1,0,0,2000,2000,1,1,1,0,2048,0,0,0,7,0,'',0,1,0,0,0,0,1,0,0,'',NULL,0),
(244425,0,0,'Barkskin Matriarch',NULL,NULL,NULL,NULL,0,0,35,2,1,1.14286,1,0,0,2000,2000,1,1,1,0,2048,0,0,0,7,0,'',0,1,0,0,0,0,1,0,0,'',NULL,0),
(249853,0,0,'Lorekeeper Nok',NULL,NULL,NULL,NULL,0,0,414,2,1,1.14286,1,0,0,2000,2000,1,1,1,0,2048,0,0,0,7,0,'',0,1,0,0,0,0,1,0,0,'',NULL,0),
(249855,0,0,'Unele',NULL,NULL,NULL,NULL,0,0,414,2,1,1.14286,1,0,0,2000,2000,1,1,1,0,2048,0,0,0,7,0,'',0,1,0,0,0,0,1,0,0,'',NULL,0),
(254357,0,0,'Khan Jehn',NULL,NULL,NULL,NULL,0,0,133,2,1,1.14286,1,0,0,2000,2000,1,1,1,0,2048,0,0,0,7,0,'',0,1,0,0,0,0,1,0,0,'',NULL,0),
(255009,0,0,'Veteran of the Third War',NULL,NULL,NULL,NULL,0,0,35,2,1,1.14286,1,0,0,2000,2000,1,1,1,0,2048,0,0,0,6,0,'',0,1,0,0,0,0,1,0,0,'',NULL,0),
(255685,0,0,'Solstice',NULL,NULL,NULL,NULL,0,0,35,1,1,1.14286,1,0,0,2000,2000,1,1,1,0,2048,0,0,0,1,0,'',1,1,0,0,0,0,1,0,0,'',NULL,0),
(255771,0,0,'Whisperfur',NULL,NULL,NULL,NULL,0,0,35,1,1,1.14286,1,0,0,2000,2000,1,1,1,0,2048,0,0,0,1,0,'',1,1,0,0,0,0,1,0,0,'',NULL,0),
(260271,0,0,'Sully McCleary',NULL,NULL,NULL,NULL,0,0,15,2,1,1.14286,1,0,0,2000,2000,1,1,1,0,2048,0,0,0,7,0,'',0,1,0,0,0,0,1,0,0,'',NULL,0),
(260440,0,0,'Brashann Grimdark',NULL,NULL,NULL,NULL,0,0,14,0,1,1.14286,1,0,0,2000,2000,1,1,1,0,2048,0,0,0,7,0,'',1,1,0,0,0,0,1,0,0,'',NULL,0),
(262041,0,0,'Bor''dorc',NULL,NULL,NULL,NULL,0,0,35,2,1,1.14286,1,0,0,2000,2000,1,1,1,0,2048,0,0,0,7,0,'',0,1,0,0,0,0,1,0,0,'',NULL,0),
(262294,0,0,'Durganon',NULL,NULL,NULL,NULL,0,0,14,2,1,1.14286,1,0,0,2000,2000,1,1,1,0,2048,0,0,0,7,0,'',0,1,0,0,0,0,1,0,0,'',NULL,0),
(264867,0,0,'Ghansurok',NULL,NULL,NULL,NULL,0,0,14,0,1,1.14286,1,0,0,2000,2000,1,1,1,0,2048,0,0,0,1,0,'',1,1,0,0,0,0,1,0,0,'',NULL,0),
(265026,0,0,'Murkborn Elemental',NULL,NULL,NULL,NULL,0,0,7,0,1,1.14286,1,0,0,2000,2000,1,1,1,0,2048,0,0,0,4,0,'',1,1,0,0,0,0,1,0,0,'',NULL,0),
(266593,0,0,'Sergeant Danneth',NULL,NULL,NULL,NULL,0,0,1630,3,1,1.14286,1,0,0,2000,2000,1,1,1,0,2048,0,0,0,7,0,'',0,1,0,0,0,0,1,0,0,'',NULL,0),
(267439,0,0,'Doomguard Xarkul',NULL,NULL,NULL,NULL,0,0,90,0,1,1.14286,1,0,0,2000,2000,1,1,1,0,2048,0,0,0,3,0,'',1,1,0,0,0,0,1,0,0,'',NULL,0),
(270727,0,0,'Gizzix Grimegurgle',NULL,NULL,NULL,NULL,0,0,474,2,1,1.14286,1,0,0,2000,2000,1,1,1,0,2048,0,0,0,7,0,'',0,1,0,0,0,0,1,0,0,'',NULL,0);
INSERT INTO `creature_template` (`entry`,`KillCredit1`,`KillCredit2`,`name`,`femaleName`,`subname`,`TitleAlt`,`IconName`,`RequiredExpansion`,`VignetteID`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`Classification`,`dmgschool`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,`unit_flags`,`unit_flags2`,`unit_flags3`,`family`,`trainer_class`,`type`,`VehicleId`,`AIName`,`MovementType`,`ExperienceModifier`,`RacialLeader`,`movementId`,`WidgetSetID`,`WidgetSetUnitConditionID`,`RegenHealth`,`CreatureImmunitiesId`,`flags_extra`,`ScriptName`,`StringId`,`VerifiedBuild`) SELECT `s`.`entry`,`s`.`KillCredit1`,`s`.`KillCredit2`,`s`.`name`,`s`.`femaleName`,`s`.`subname`,`s`.`TitleAlt`,`s`.`IconName`,`s`.`RequiredExpansion`,`s`.`VignetteID`,`s`.`faction`,`s`.`npcflag`,`s`.`speed_walk`,`s`.`speed_run`,`s`.`scale`,`s`.`Classification`,`s`.`dmgschool`,`s`.`BaseAttackTime`,`s`.`RangeAttackTime`,`s`.`BaseVariance`,`s`.`RangeVariance`,`s`.`unit_class`,`s`.`unit_flags`,`s`.`unit_flags2`,`s`.`unit_flags3`,`s`.`family`,`s`.`trainer_class`,`s`.`type`,`s`.`VehicleId`,`s`.`AIName`,`s`.`MovementType`,`s`.`ExperienceModifier`,`s`.`RacialLeader`,`s`.`movementId`,`s`.`WidgetSetID`,`s`.`WidgetSetUnitConditionID`,`s`.`RegenHealth`,`s`.`CreatureImmunitiesId`,`s`.`flags_extra`,`s`.`ScriptName`,`s`.`StringId`,`s`.`VerifiedBuild` FROM `forever_ct_988` `s` WHERE NOT EXISTS (SELECT 1 FROM `creature_template` `x` WHERE `x`.`entry`=`s`.`entry`);
DROP TEMPORARY TABLE IF EXISTS `forever_ct_988`;

DROP TEMPORARY TABLE IF EXISTS `forever_ctd_988`;
CREATE TEMPORARY TABLE `forever_ctd_988` SELECT `Entry`,`DifficultyID`,`LevelScalingDeltaMin`,`LevelScalingDeltaMax`,`ContentTuningID`,`HealthScalingExpansion`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`DamageModifier`,`CreatureDifficultyID`,`TypeFlags`,`TypeFlags2`,`TypeFlags3`,`LootID`,`PickPocketLootID`,`SkinLootID`,`GoldMin`,`GoldMax`,`StaticFlags1`,`StaticFlags2`,`StaticFlags3`,`StaticFlags4`,`StaticFlags5`,`StaticFlags6`,`StaticFlags7`,`StaticFlags8`,`VerifiedBuild` FROM `creature_template_difficulty` WHERE 0;
INSERT INTO `forever_ctd_988` (`Entry`,`DifficultyID`,`LevelScalingDeltaMin`,`LevelScalingDeltaMax`,`ContentTuningID`,`HealthScalingExpansion`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`DamageModifier`,`CreatureDifficultyID`,`TypeFlags`,`TypeFlags2`,`TypeFlags3`,`LootID`,`PickPocketLootID`,`SkinLootID`,`GoldMin`,`GoldMax`,`StaticFlags1`,`StaticFlags2`,`StaticFlags3`,`StaticFlags4`,`StaticFlags5`,`StaticFlags6`,`StaticFlags7`,`StaticFlags8`,`VerifiedBuild`) VALUES
(205153,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(222478,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(235906,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(235909,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(236770,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(237007,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(239831,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(244425,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(249853,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(249855,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(254357,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(255009,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(255685,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(255771,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(260271,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(260440,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(262041,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(262294,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(264867,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(265026,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(266593,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(267439,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(270727,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `creature_template_difficulty` (`Entry`,`DifficultyID`,`LevelScalingDeltaMin`,`LevelScalingDeltaMax`,`ContentTuningID`,`HealthScalingExpansion`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`DamageModifier`,`CreatureDifficultyID`,`TypeFlags`,`TypeFlags2`,`TypeFlags3`,`LootID`,`PickPocketLootID`,`SkinLootID`,`GoldMin`,`GoldMax`,`StaticFlags1`,`StaticFlags2`,`StaticFlags3`,`StaticFlags4`,`StaticFlags5`,`StaticFlags6`,`StaticFlags7`,`StaticFlags8`,`VerifiedBuild`) SELECT `s`.`Entry`,`s`.`DifficultyID`,`s`.`LevelScalingDeltaMin`,`s`.`LevelScalingDeltaMax`,`s`.`ContentTuningID`,`s`.`HealthScalingExpansion`,`s`.`HealthModifier`,`s`.`ManaModifier`,`s`.`ArmorModifier`,`s`.`DamageModifier`,`s`.`CreatureDifficultyID`,`s`.`TypeFlags`,`s`.`TypeFlags2`,`s`.`TypeFlags3`,`s`.`LootID`,`s`.`PickPocketLootID`,`s`.`SkinLootID`,`s`.`GoldMin`,`s`.`GoldMax`,`s`.`StaticFlags1`,`s`.`StaticFlags2`,`s`.`StaticFlags3`,`s`.`StaticFlags4`,`s`.`StaticFlags5`,`s`.`StaticFlags6`,`s`.`StaticFlags7`,`s`.`StaticFlags8`,`s`.`VerifiedBuild` FROM `forever_ctd_988` `s` WHERE NOT EXISTS (SELECT 1 FROM `creature_template_difficulty` `x` WHERE `x`.`Entry`=`s`.`Entry` AND `x`.`DifficultyID`=`s`.`DifficultyID`);
DROP TEMPORARY TABLE IF EXISTS `forever_ctd_988`;

DROP TEMPORARY TABLE IF EXISTS `forever_ctm_988`;
CREATE TEMPORARY TABLE `forever_ctm_988` SELECT `CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild` FROM `creature_template_model` WHERE 0;
INSERT INTO `forever_ctm_988` (`CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild`) VALUES
(205153,0,13648,1,1,0),
(222478,0,7603,1,1,0),
(235906,0,6829,1,1,0),
(235909,0,3028,1,1,0),
(236770,0,5851,1,1,0),
(237007,0,2003,1,1,0),
(239831,0,127409,1,1,0),
(244425,0,6826,1,1,0),
(249853,0,11363,1,1,0),
(249855,0,1996,1,1,0),
(254357,0,9433,1,1,0),
(255009,0,144574,1,1,0),
(255685,0,139033,1,1,0),
(255771,0,139033,1,1,0),
(260271,0,142287,1,1,0),
(260440,0,142439,1,1,0),
(262041,0,143051,1,1,0),
(262294,0,143121,1,1,0),
(264867,0,4269,1,1,0),
(265026,0,5987,1,1,0),
(266593,0,144845,1,1,0),
(267439,0,2727,1,1,0),
(270727,0,146436,1,1,0);
INSERT INTO `creature_template_model` (`CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild`) SELECT `s`.`CreatureID`,`s`.`Idx`,`s`.`CreatureDisplayID`,`s`.`DisplayScale`,`s`.`Probability`,`s`.`VerifiedBuild` FROM `forever_ctm_988` `s` WHERE NOT EXISTS (SELECT 1 FROM `creature_template_model` `x` WHERE `x`.`CreatureID`=`s`.`CreatureID` AND `x`.`Idx`=`s`.`Idx`);
DROP TEMPORARY TABLE IF EXISTS `forever_ctm_988`;

DROP TEMPORARY TABLE IF EXISTS `forever_ccl_988`;
CREATE TEMPORARY TABLE `forever_ccl_988` SELECT `entry`,`level_min`,`level_max` FROM `creature_classic_level` WHERE 0;
INSERT INTO `forever_ccl_988` (`entry`,`level_min`,`level_max`) VALUES
(205153,10,10),
(222478,44,45),
(235906,55,55),
(235909,50,50),
(236770,50,50),
(237007,53,53),
(239831,55,55),
(244425,57,57),
(249853,50,50),
(249855,50,50),
(254357,42,42),
(255009,61,61),
(255685,60,60),
(255771,60,60),
(260271,50,50),
(260440,58,58),
(262041,60,60),
(262294,59,59),
(264867,61,61),
(265026,59,59),
(266593,52,52),
(267439,61,61),
(270727,40,40);
INSERT INTO `creature_classic_level` (`entry`,`level_min`,`level_max`) SELECT `s`.`entry`,`s`.`level_min`,`s`.`level_max` FROM `forever_ccl_988` `s` WHERE NOT EXISTS (SELECT 1 FROM `creature_classic_level` `x` WHERE `x`.`entry`=`s`.`entry`);
DROP TEMPORARY TABLE IF EXISTS `forever_ccl_988`;

--    Model sizes for displays that had none.
DROP TEMPORARY TABLE IF EXISTS `forever_cmi_988`;
CREATE TEMPORARY TABLE `forever_cmi_988` SELECT `DisplayID`,`BoundingRadius`,`CombatReach`,`DisplayID_Other_Gender`,`VerifiedBuild` FROM `creature_model_info` WHERE 0;
INSERT INTO `forever_cmi_988` (`DisplayID`,`BoundingRadius`,`CombatReach`,`DisplayID_Other_Gender`,`VerifiedBuild`) VALUES
(127409,0.306,1.5,0,0),
(142439,0.372,1.5,0,0),
(143051,0.372,1.5,0,0),
(143121,0.347,1.5,0,0),
(146436,0.306,1.5,0,0);
INSERT INTO `creature_model_info` (`DisplayID`,`BoundingRadius`,`CombatReach`,`DisplayID_Other_Gender`,`VerifiedBuild`) SELECT `s`.`DisplayID`,`s`.`BoundingRadius`,`s`.`CombatReach`,`s`.`DisplayID_Other_Gender`,`s`.`VerifiedBuild` FROM `forever_cmi_988` `s` WHERE NOT EXISTS (SELECT 1 FROM `creature_model_info` `x` WHERE `x`.`DisplayID`=`s`.`DisplayID`);
DROP TEMPORARY TABLE IF EXISTS `forever_cmi_988`;

--    Spawns (heights from Everlake's map and vmap tool), only for a creature with no spawn of its own yet and only where the guid is free.
DROP TEMPORARY TABLE IF EXISTS `forever_cs_988`;
CREATE TEMPORARY TABLE `forever_cs_988` SELECT `guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild` FROM `creature` WHERE 0;
INSERT INTO `forever_cs_988` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(920012000,205153,0,0,0,'0',0,0,0,-1,0,0,-10231.47,719.93,24.5,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920012001,205153,0,0,0,'0',0,0,0,-1,0,0,-10217.07,709.13,24.81,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920012002,205153,0,0,0,'0',0,0,0,-1,0,0,-10231.47,709.13,24.23,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920012003,222478,1,0,0,'0',0,0,0,-1,0,0,3174.29,-4250.68,98.16,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920012004,222478,1,0,0,'0',0,0,0,-1,0,0,3262.2,-4260.82,120.15,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920012005,222478,1,0,0,'0',0,0,0,-1,0,0,3221.62,-4260.82,103.86,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920012006,222478,1,0,0,'0',0,0,0,-1,0,0,3312.92,-4311.53,130.86,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920012007,222478,1,0,0,'0',0,0,0,-1,0,0,3252.05,-4321.67,160.74,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920012008,222478,1,0,0,'0',0,0,0,-1,0,0,3296.01,-4326.75,130.39,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920012009,235906,1,0,0,'0',0,0,0,-1,0,0,4685.7,-5386.55,112.52,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920012010,235909,1,0,0,'0',0,0,0,-1,0,0,4591.03,-5569.1,98.1,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920012011,236770,1,0,0,'0',0,0,0,-1,0,0,4618.08,-6471.71,115.95,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920012012,237007,1,0,0,'0',0,0,0,-1,0,0,4739.8,-6451.42,108.35,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920012013,237007,1,0,0,'0',0,0,0,-1,0,0,4777.0,-6542.7,100.04,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920012014,237007,1,0,0,'0',0,0,0,-1,0,0,4827.72,-6578.2,101.87,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920012015,237007,1,0,0,'0',0,0,0,-1,0,0,4817.57,-6578.2,101.27,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920012016,237007,1,0,0,'0',0,0,0,-1,0,0,4854.77,-6644.12,93.85,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920012017,237007,1,0,0,'0',0,0,0,-1,0,0,4854.77,-6654.26,93.48,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920012018,239831,1,0,0,'0',0,0,0,-1,0,0,3921.54,-5782.07,14.28,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920012019,239831,1,0,0,'0',0,0,0,-1,0,0,3901.25,-5832.78,6.92,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920012020,239831,1,0,0,'0',0,0,0,-1,0,0,3901.25,-5842.92,6.66,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920012021,244425,1,0,0,'0',0,0,0,-1,0,0,4829.78,-1746.0,1155.99,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920012022,244425,1,0,0,'0',0,0,0,-1,0,0,4836.72,-1756.42,1190.28,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920012023,244425,1,0,0,'0',0,0,0,-1,0,0,4864.5,-1773.78,1155.69,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920012024,244425,1,0,0,'0',0,0,0,-1,0,0,4883.01,-1791.15,1149.06,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920012025,244425,1,0,0,'0',0,0,0,-1,0,0,4887.64,-1829.35,1143.89,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920012026,244425,1,0,0,'0',0,0,0,-1,0,0,4876.07,-1874.5,1150.88,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920012027,244425,1,0,0,'0',0,0,0,-1,0,0,4933.93,-1909.22,1462.64,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920012028,244425,1,0,0,'0',0,0,0,-1,0,0,4913.1,-1912.7,1370.87,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920012029,249853,1,0,0,'0',0,0,0,-1,0,0,4665.42,-5376.41,108.48,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920012030,249855,1,0,0,'0',0,0,0,-1,0,0,4726.28,-5467.68,109.25,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920012031,254357,1,0,0,'0',0,0,0,-1,0,0,-1760.38,915.41,107.01,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920012032,255009,1,0,0,'0',0,0,0,-1,0,0,4906.16,-1568.88,1328.26,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920012033,255009,1,0,0,'0',0,0,0,-1,0,0,4896.9,-1589.72,1324.27,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920012034,255009,1,0,0,'0',0,0,0,-1,0,0,4869.12,-1610.55,1315.41,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920012035,255009,1,0,0,'0',0,0,0,-1,0,0,4924.67,-1624.45,1324.66,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920012036,255009,1,0,0,'0',0,0,0,-1,0,0,4933.93,-1631.39,1324.88,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920012037,255009,1,0,0,'0',0,0,0,-1,0,0,4901.53,-1631.39,1320.36,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920012038,255009,1,0,0,'0',0,0,0,-1,0,0,4980.22,-1638.34,1352.73,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920012039,255009,1,0,0,'0',0,0,0,-1,0,0,4943.19,-1638.34,1329.81,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920012040,255009,1,0,0,'0',0,0,0,-1,0,0,4920.05,-1645.28,1324.12,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920012041,255009,1,0,0,'0',0,0,0,-1,0,0,4970.97,-1666.12,1338.85,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920012042,255685,1,0,0,'0',0,0,0,-1,0,0,5207.05,-2256.52,1258.83,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,0),
(920012043,255771,1,0,0,'0',0,0,0,-1,0,0,4869.12,-1860.6,1151.2,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,0),
(920012044,260271,1,0,0,'0',0,0,0,-1,0,0,-3517.33,-4303.5,6.36,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920012045,260440,1,0,0,'0',0,0,0,-1,0,0,4683.96,-2603.81,1147.03,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,0),
(920012046,260440,1,0,0,'0',0,0,0,-1,0,0,4693.22,-2638.54,1152.53,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,0),
(920012047,260440,1,0,0,'0',0,0,0,-1,0,0,4644.61,-2662.85,1146.28,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,0),
(920012048,260440,1,0,0,'0',0,0,0,-1,0,0,4658.5,-2666.32,1145.97,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,0),
(920012049,262041,1,0,0,'0',0,0,0,-1,0,0,6961.87,-4917.47,693.57,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920012050,262294,0,0,0,'0',0,0,0,-1,0,0,-6968.7,-1237.73,180.72,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920012051,264867,1,0,0,'0',0,0,0,-1,0,0,5790.33,-3298.39,1611.87,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,0),
(920012052,264867,1,0,0,'0',0,0,0,-1,0,0,5757.92,-3305.34,1603.49,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,0),
(920012053,264867,1,0,0,'0',0,0,0,-1,0,0,5808.85,-3326.18,1643.82,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,0),
(920012054,264867,1,0,0,'0',0,0,0,-1,0,0,5799.59,-3326.18,1638.65,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,0),
(920012055,264867,1,0,0,'0',0,0,0,-1,0,0,5771.81,-3326.18,1622.73,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,0),
(920012056,265026,1,0,0,'0',0,0,0,-1,0,0,4896.9,-2027.3,1128.63,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,0),
(920012057,265026,1,0,0,'0',0,0,0,-1,0,0,4901.53,-2055.09,1127.7,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,0),
(920012058,266593,0,0,0,'0',0,0,0,-1,0,0,-10915.07,-3419.17,110.21,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0),
(920012059,267439,1,0,0,'0',0,0,0,-1,0,0,5538.04,-3034.45,1549.51,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,0),
(920012060,267439,1,0,0,'0',0,0,0,-1,0,0,5494.06,-3048.34,1574.24,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,0),
(920012061,267439,1,0,0,'0',0,0,0,-1,0,0,5577.39,-3055.29,1559.7,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,0),
(920012062,267439,1,0,0,'0',0,0,0,-1,0,0,5563.5,-3055.29,1564.1,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,0),
(920012063,267439,1,0,0,'0',0,0,0,-1,0,0,5549.61,-3069.18,1561.86,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,0),
(920012064,267439,1,0,0,'0',0,0,0,-1,0,0,5563.5,-3083.07,1565.12,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,0),
(920012065,267439,1,0,0,'0',0,0,0,-1,0,0,5540.35,-3093.49,1562.54,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,0),
(920012066,267439,1,0,0,'0',0,0,0,-1,0,0,5556.56,-3096.96,1565.07,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,0),
(920012067,270727,1,0,0,'0',0,0,0,-1,0,0,-4679.33,-3127.5,52.3,0,300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0);
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) SELECT `s`.`guid`,`s`.`id`,`s`.`map`,`s`.`zoneId`,`s`.`areaId`,`s`.`spawnDifficulties`,`s`.`phaseUseFlags`,`s`.`PhaseId`,`s`.`PhaseGroup`,`s`.`terrainSwapMap`,`s`.`modelid`,`s`.`equipment_id`,`s`.`position_x`,`s`.`position_y`,`s`.`position_z`,`s`.`orientation`,`s`.`spawntimesecs`,`s`.`wander_distance`,`s`.`currentwaypoint`,`s`.`curHealthPct`,`s`.`MovementType`,`s`.`npcflag`,`s`.`unit_flags`,`s`.`unit_flags2`,`s`.`unit_flags3`,`s`.`ScriptName`,`s`.`StringId`,`s`.`VerifiedBuild` FROM `forever_cs_988` `s`
WHERE EXISTS (SELECT 1 FROM `creature_template` `t` WHERE `t`.`entry`=`s`.`id`)
  AND NOT EXISTS (SELECT 1 FROM `creature` `x` WHERE `x`.`guid`=`s`.`guid`)
  AND NOT EXISTS (SELECT 1 FROM `creature` `x` WHERE `x`.`id`=`s`.`id` AND `x`.`guid` NOT BETWEEN 920010000 AND 920012999);
DROP TEMPORARY TABLE IF EXISTS `forever_cs_988`;

-- 3. Quest objects from Icy Veins' WoW Forever database (file 995), only where our world has no template yet.
DROP TEMPORARY TABLE IF EXISTS `forever_gt_995`;
CREATE TEMPORARY TABLE `forever_gt_995` SELECT `entry`,`type`,`displayId`,`name`,`IconName`,`castBarCaption`,`unk1`,`size`,`Data0`,`Data1`,`Data2`,`Data3`,`Data4`,`Data5`,`Data6`,`Data7`,`Data8`,`Data9`,`Data10`,`Data11`,`Data12`,`Data13`,`Data14`,`Data15`,`Data16`,`Data17`,`Data18`,`Data19`,`Data20`,`Data21`,`Data22`,`Data23`,`Data24`,`Data25`,`Data26`,`Data27`,`Data28`,`Data29`,`Data30`,`Data31`,`Data32`,`Data33`,`Data34`,`ContentTuningId`,`RequiredLevel`,`AIName`,`ScriptName`,`StringId`,`VerifiedBuild` FROM `gameobject_template` WHERE 0;
INSERT INTO `forever_gt_995` (`entry`,`type`,`displayId`,`name`,`IconName`,`castBarCaption`,`unk1`,`size`,`Data0`,`Data1`,`Data2`,`Data3`,`Data4`,`Data5`,`Data6`,`Data7`,`Data8`,`Data9`,`Data10`,`Data11`,`Data12`,`Data13`,`Data14`,`Data15`,`Data16`,`Data17`,`Data18`,`Data19`,`Data20`,`Data21`,`Data22`,`Data23`,`Data24`,`Data25`,`Data26`,`Data27`,`Data28`,`Data29`,`Data30`,`Data31`,`Data32`,`Data33`,`Data34`,`ContentTuningId`,`RequiredLevel`,`AIName`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(423703,2,1107,'Broken Warhammer','','','',0.8,0,29896,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5841,0,'','',NULL,0),
(506307,2,216,'Legashi Cauldron','','','',1.5,93,28275,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'','',NULL,0),
(527828,2,323,'Saria''s Knapsack','','','',1.0,43,28550,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'','',NULL,0),
(577959,2,4714,'Shen''dralar Pylon','','','',2.25,0,29082,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'','',NULL,0),
(577960,2,4714,'Shen''dralar Pylon','','','',2.25,0,29082,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'','',NULL,0),
(581918,2,17,'WANTED!','','','',1.0,0,29070,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'','',NULL,0),
(611086,2,41,'Connery''s Trunk','','','',0.6,1634,29881,0,0,0,0,0,0,0,0,155978,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2180,0,'','',NULL,0),
(613773,10,20,'Ashen Soil','','','',1.0,43,93547,0,3000,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,147780,0,0,0,1,0,0,0,0,0,0,0,0,0,0,'','',NULL,0),
(613848,2,8,'Battle Cache','','','',2.0,0,29901,0,41471,0,0,0,0,0,0,156365,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'','',NULL,0),
(617129,10,117833,'Dried Hanging Herbs','','','',1.0,4287,0,0,1000,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,148872,0,0,0,1,0,0,0,0,0,0,0,0,181,0,'','',NULL,0),
(621767,10,49,'Loamy Soil','','','',0.5,4331,94843,0,3000,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,'','',NULL,0),
(621813,10,20,'Loose Soil','questinteract','','',1.2,4334,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,'','',NULL,0),
(625582,2,1,'Fuzzle''s Treasure','','','',1.0,0,29488,0,0,0,0,0,1,0,0,151407,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'','',NULL,0),
(629425,10,4177,'Cannon Ammunition','','','',1.0,4346,95165,0,3000,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,'','',NULL,0),
(629426,10,4177,'Cannon Ammunition','','','',1.0,4346,95165,0,3000,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,'','',NULL,0),
(629427,10,4177,'Cannon Ammunition','','','',1.0,4346,95165,0,3000,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,'','',NULL,0),
(629761,2,116323,'Painted Hide','','','',0.5,0,29550,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'','',NULL,0),
(630887,2,4032,'Venture Co. Ledger','','','',1.5,0,29564,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'','',NULL,0),
(642451,2,5744,'Old Chest','','','',1.5,0,29669,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'','',NULL,0),
(642517,10,123672,'Burned Memorial Candle','','','',1.0,4378,95615,0,3000,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,'','',NULL,0),
(645164,2,17,'WANTED!','','','',1.0,0,29788,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'','',NULL,0),
(650234,2,124714,'Loose Cog','','','',0.5,0,30004,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5841,0,'','',NULL,0),
(651262,2,20,'Unmarked Grave','','','',1.0,0,29862,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'','',NULL,0),
(651409,2,425,'Corrupted Growth','','','',2.0,0,29864,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5841,0,'','',NULL,0),
(651430,10,425,'Corrupted Growth','','','',2.0,93,96296,0,3000,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,5841,0,'','',NULL,0),
(651979,10,84873,'Northern Sentinel Stone','','','',1.0,93,0,0,3000,0,0,0,0,0,0,1293361,0,0,0,0,0,0,0,0,0,0,0,156036,1,0,0,1,0,0,0,0,0,0,0,0,0,0,'','',NULL,0),
(651986,10,84873,'Southern Sentinel Stone','','','',1.0,93,0,0,3000,0,0,0,0,0,0,1293361,0,0,0,0,0,0,0,0,0,0,0,156036,1,0,0,1,0,0,0,0,0,0,0,0,0,0,'','',NULL,0),
(651987,10,84873,'Western Sentinel Stone','','','',1.0,93,0,0,3000,0,0,0,0,0,0,1293361,0,0,0,0,0,0,0,0,0,0,0,156036,1,0,0,1,0,0,0,0,0,0,0,0,0,0,'','',NULL,0),
(652438,2,125238,'Carving','','','',0.45,0,29213,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'','',NULL,0),
(652449,2,125238,'Bone Pile','','','',0.8,0,29894,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'','',NULL,0),
(654121,2,125586,'Embroidered Scabbard','','','',1.0,0,29935,0,43327,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,181,0,'','',NULL,0),
(654126,2,125238,'Weathered Anchor','','','',0.4,0,29946,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,181,0,'','',NULL,0),
(654150,2,125591,'Broken Fishing Basket','','','',2.0,0,29903,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,181,0,'','',NULL,0),
(656157,2,5744,'Syndicate Footlocker','','','',1.0,0,30030,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'','',NULL,0),
(656668,10,324,'South Bonfire','','','',1.36,4088,96959,0,3000,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,'','',NULL,0),
(656669,10,324,'Southeast Bonfire','','','',1.0,4088,96959,0,3000,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,'','',NULL,0),
(656786,2,126458,'Troll Remains','','','',1.0,0,30090,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5841,0,'','',NULL,0),
(656815,2,4,'Old Wardrobe','','','',1.0,0,30095,0,0,0,0,0,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'','',NULL,0),
(658115,2,285,'Lost Shipping Crate','','','',0.75,0,30122,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'','',NULL,0),
(658116,2,285,'Lost Shipping Crate','','','',0.75,0,30123,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'','',NULL,0),
(659199,10,20,'Ashen Soil','','','',0.5,43,93547,0,3000,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,147780,0,0,0,1,0,0,0,0,0,0,0,0,0,0,'','',NULL,0),
(659200,10,20,'Ashen Soil','','','',0.5,43,93547,0,3000,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,147780,0,0,0,1,0,0,0,0,0,0,0,0,0,0,'','',NULL,0),
(661778,2,123673,'Statue of Malorne','','','',0.25,4088,30231,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5841,0,'','',NULL,0),
(676059,2,129893,'Ancient Hilt','','','',1.0,0,30633,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2180,0,'','',NULL,0),
(707249,2,15,'Wanted','','','',0.5,0,30952,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5841,0,'','',NULL,0),
(710894,2,137,'Bookshelf','','','',1.0,0,30989,0,0,0,0,0,0,0,0,168025,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'','',NULL,0);
INSERT INTO `gameobject_template` (`entry`,`type`,`displayId`,`name`,`IconName`,`castBarCaption`,`unk1`,`size`,`Data0`,`Data1`,`Data2`,`Data3`,`Data4`,`Data5`,`Data6`,`Data7`,`Data8`,`Data9`,`Data10`,`Data11`,`Data12`,`Data13`,`Data14`,`Data15`,`Data16`,`Data17`,`Data18`,`Data19`,`Data20`,`Data21`,`Data22`,`Data23`,`Data24`,`Data25`,`Data26`,`Data27`,`Data28`,`Data29`,`Data30`,`Data31`,`Data32`,`Data33`,`Data34`,`ContentTuningId`,`RequiredLevel`,`AIName`,`ScriptName`,`StringId`,`VerifiedBuild`) SELECT `s`.`entry`,`s`.`type`,`s`.`displayId`,`s`.`name`,`s`.`IconName`,`s`.`castBarCaption`,`s`.`unk1`,`s`.`size`,`s`.`Data0`,`s`.`Data1`,`s`.`Data2`,`s`.`Data3`,`s`.`Data4`,`s`.`Data5`,`s`.`Data6`,`s`.`Data7`,`s`.`Data8`,`s`.`Data9`,`s`.`Data10`,`s`.`Data11`,`s`.`Data12`,`s`.`Data13`,`s`.`Data14`,`s`.`Data15`,`s`.`Data16`,`s`.`Data17`,`s`.`Data18`,`s`.`Data19`,`s`.`Data20`,`s`.`Data21`,`s`.`Data22`,`s`.`Data23`,`s`.`Data24`,`s`.`Data25`,`s`.`Data26`,`s`.`Data27`,`s`.`Data28`,`s`.`Data29`,`s`.`Data30`,`s`.`Data31`,`s`.`Data32`,`s`.`Data33`,`s`.`Data34`,`s`.`ContentTuningId`,`s`.`RequiredLevel`,`s`.`AIName`,`s`.`ScriptName`,`s`.`StringId`,`s`.`VerifiedBuild` FROM `forever_gt_995` `s` WHERE NOT EXISTS (SELECT 1 FROM `gameobject_template` `x` WHERE `x`.`entry`=`s`.`entry`);
DROP TEMPORARY TABLE IF EXISTS `forever_gt_995`;

--    Spawns where players' addons saw them, only for an object with no spawn of its own yet.
DROP TEMPORARY TABLE IF EXISTS `forever_gs_995`;
CREATE TEMPORARY TABLE `forever_gs_995` SELECT `guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`,`ScriptName`,`StringId`,`VerifiedBuild` FROM `gameobject` WHERE 0;
INSERT INTO `forever_gs_995` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(920013000,423703,1,0,0,'0',0,0,0,-1,-2088.95,1864.93,66.87,0,0,0,0,1,300,255,1,'',NULL,0),
(920013001,506307,1,0,0,'0',0,0,0,-1,4632.28,-6203.46,104.2,0,0,0,0,1,300,255,1,'',NULL,0),
(920013002,527828,1,0,0,'0',0,0,0,-1,3925.94,-5783.6,14.65,0,0,0,0,1,300,255,1,'',NULL,0),
(920013003,577959,1,0,0,'0',0,0,0,-1,-2369.86,1129.56,108.16,0,0,0,0,1,300,255,1,'',NULL,0),
(920013004,577959,1,0,0,'0',0,0,0,-1,-2381.75,1128.33,133.1,0,0,0,0,1,300,255,1,'',NULL,0),
(920013005,577960,1,0,0,'0',0,0,0,-1,-2217.2,520.3,174.96,0,0,0,0,1,300,255,1,'',NULL,0),
(920013006,581918,1,0,0,'0',0,0,0,-1,-4398.38,3281.61,13.15,0,0,0,0,1,300,255,1,'',NULL,0),
(920013007,611086,0,0,0,'0',0,0,0,-1,-10983.63,1496.62,61.71,0,0,0,0,1,300,255,1,'',NULL,0),
(920013008,613848,1,0,0,'0',0,0,0,-1,5084.61,-1930.76,1390.38,0,0,0,0,1,300,255,1,'',NULL,0),
(920013009,625582,0,0,0,'0',0,0,0,-1,-8010.26,-3911.21,21.53,0,0,0,0,1,300,255,1,'',NULL,0),
(920013010,629761,0,0,0,'0',0,0,0,-1,-8467.13,-5399.67,0.68,0,0,0,0,1,300,255,1,'',NULL,0),
(920013011,630887,0,0,0,'0',0,0,0,-1,-11956.2,-505.24,39.28,0,0,0,0,1,300,255,1,'',NULL,0),
(920013012,645164,0,0,0,'0',0,0,0,-1,-7986.98,-4775.48,24.24,0,0,0,0,1,300,255,1,'',NULL,0),
(920013013,650234,1,0,0,'0',0,0,0,-1,4512.91,-3537.68,986.8,0,0,0,0,1,300,255,1,'',NULL,0),
(920013014,651262,1,0,0,'0',0,0,0,-1,5177.89,-1704.32,1339.83,0,0,0,0,1,300,255,1,'',NULL,0),
(920013015,651409,1,0,0,'0',0,0,0,-1,5000.59,-2609.02,1424.54,0,0,0,0,1,300,255,1,'',NULL,0),
(920013016,652438,1,0,0,'0',0,0,0,-1,-4671.25,-1838.25,115.34,0,0,0,0,1,300,255,1,'',NULL,0),
(920013017,652449,1,0,0,'0',0,0,0,-1,4447.18,-2338.13,1117.34,0,0,0,0,1,300,255,1,'',NULL,0),
(920013018,654121,1,0,0,'0',0,0,0,-1,5227.88,-1228.88,1375.66,0,0,0,0,1,300,255,1,'',NULL,0),
(920013019,654126,0,0,0,'0',0,0,0,-1,-9401.18,-2341.4,56.94,0,0,0,0,1,300,255,1,'',NULL,0),
(920013020,654150,1,0,0,'0',0,0,0,-1,5258.9,-2162.05,1259.38,0,0,0,0,1,300,255,1,'',NULL,0),
(920013021,656157,0,0,0,'0',0,0,0,-1,-770.05,-2029.47,34.08,0,0,0,0,1,300,255,1,'',NULL,0),
(920013022,656786,1,0,0,'0',0,0,0,-1,5344.54,-3060.84,1612.42,0,0,0,0,1,300,255,1,'',NULL,0),
(920013023,656815,1,0,0,'0',0,0,0,-1,5355.19,-2079.05,1287.33,0,0,0,0,1,300,255,1,'',NULL,0),
(920013024,658115,1,0,0,'0',0,0,0,-1,-1724.4,3180.41,5.24,0,0,0,0,1,300,255,1,'',NULL,0),
(920013025,658116,0,0,0,'0',0,0,0,-1,-11296.8,-204.04,75.76,0,0,0,0,1,300,255,1,'',NULL,0),
(920013026,661778,1,0,0,'0',0,0,0,-1,5318.63,-776.21,341.75,0,0,0,0,1,300,255,1,'',NULL,0),
(920013027,676059,2991,0,0,'0',0,0,0,-1,4064.77,998.88,816.68,0,0,0,0,1,300,255,1,'',NULL,0),
(920013028,707249,0,0,0,'0',0,0,0,-1,-7986.33,-4782.75,24.08,0,0,0,0,1,300,255,1,'',NULL,0),
(920013029,710894,1,0,0,'0',0,0,0,-1,5485.27,-3594.28,2181.77,0,0,0,0,1,300,255,1,'',NULL,0);
INSERT INTO `gameobject` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`,`ScriptName`,`StringId`,`VerifiedBuild`) SELECT `s`.`guid`,`s`.`id`,`s`.`map`,`s`.`zoneId`,`s`.`areaId`,`s`.`spawnDifficulties`,`s`.`phaseUseFlags`,`s`.`PhaseId`,`s`.`PhaseGroup`,`s`.`terrainSwapMap`,`s`.`position_x`,`s`.`position_y`,`s`.`position_z`,`s`.`orientation`,`s`.`rotation0`,`s`.`rotation1`,`s`.`rotation2`,`s`.`rotation3`,`s`.`spawntimesecs`,`s`.`animprogress`,`s`.`state`,`s`.`ScriptName`,`s`.`StringId`,`s`.`VerifiedBuild` FROM `forever_gs_995` `s`
WHERE EXISTS (SELECT 1 FROM `gameobject_template` `t` WHERE `t`.`entry`=`s`.`id`)
  AND NOT EXISTS (SELECT 1 FROM `gameobject` `x` WHERE `x`.`guid`=`s`.`guid`)
  AND NOT EXISTS (SELECT 1 FROM `gameobject` `x` WHERE `x`.`id`=`s`.`id` AND `x`.`guid` NOT BETWEEN 920013000 AND 920013999);
DROP TEMPORARY TABLE IF EXISTS `forever_gs_995`;

-- 4. Quest items nothing gave in our world: who drops them, as Icy Veins' WoW Forever database measured it (file 993). A quest item
--    seen fewer than 5 times gets 40. A row goes in only where the creature's loot id is its own entry (or not set yet; then it is set).
DROP TEMPORARY TABLE IF EXISTS `forever_drops_993`;
CREATE TEMPORARY TABLE `forever_drops_993` (`Entry` INT UNSIGNED NOT NULL, `Item` INT UNSIGNED NOT NULL, `Chance` FLOAT NOT NULL, `QuestRequired` TINYINT UNSIGNED NOT NULL, PRIMARY KEY (`Entry`,`Item`));
INSERT INTO `forever_drops_993` (`Entry`,`Item`,`Chance`,`QuestRequired`) VALUES
(6147,243203,40,1),
(6148,246888,40,1),
(268864,249698,4.545,1),
(247248,249698,1.333,1),
(255347,249698,1.017,1),
(249221,263028,40,1),
(249220,263028,40,1),
(249222,263028,40,1),
(260826,263028,40,1),
(269756,278744,40,1),
(5974,280390,40,1),
(5976,280390,40,1);
UPDATE `creature_template_difficulty` `d` SET `d`.`LootID`=`d`.`Entry` WHERE `d`.`DifficultyID`=0 AND `d`.`LootID`=0
  AND `d`.`Entry` IN (SELECT `Entry` FROM `forever_drops_993`)
  AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` `l` WHERE `l`.`Entry`=`d`.`Entry`);
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`)
SELECT `s`.`Entry`,0,`s`.`Item`,`s`.`Chance`,`s`.`QuestRequired`,1,0,1,1,'Icy Veins Forever' FROM `forever_drops_993` `s`
JOIN `creature_template_difficulty` `d` ON `d`.`Entry`=`s`.`Entry` AND `d`.`DifficultyID`=0 AND `d`.`LootID`=`s`.`Entry`
WHERE NOT EXISTS (SELECT 1 FROM `creature_loot_template` `x` WHERE `x`.`Entry`=`s`.`Entry` AND `x`.`ItemType`=0 AND `x`.`Item`=`s`.`Item`)
  AND NOT EXISTS (SELECT 1 FROM `creature_template_difficulty` `o` WHERE `o`.`LootID`=`s`.`Entry` AND `o`.`Entry`<>`s`.`Entry`);
DROP TEMPORARY TABLE IF EXISTS `forever_drops_993`;
INSERT INTO `gameobject_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`)
SELECT 122215,0,216617,100,1,1,0,1,1,'Icy Veins Forever: looted from this object' FROM DUAL
WHERE EXISTS (SELECT 1 FROM `gameobject_template` `g` WHERE `g`.`entry`=424002 AND `g`.`type`=3 AND `g`.`Data1`=122215)
  AND NOT EXISTS (SELECT 1 FROM `gameobject_loot_template` `t` WHERE `t`.`Entry`=122215 AND `t`.`ItemType`=0 AND `t`.`Item`=216617);

-- 5. "Talk to" objectives: this core counts them when the creature's window opens, so the stable mounts of Your First Horse
--    (97171, 98166) and Your First Riding Kodo (97446) and Brie of Kits and Cats (93615) get the gossip flag (only while they
--    have none). Two of the Menethil horses have no spawn: they stand at QuestieDB's points beside the other two, at their
--    floor and facing (Everlake 987; their exact spot is not recorded anywhere).
UPDATE `creature_template` SET `npcflag`=1 WHERE `entry` IN (268313,268314,268316,268318,269138,269139,269140,269141,255773,270542,270543,270544) AND `npcflag`=0;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,
  `equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,
  `npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`)
SELECT `s`.`guid`,`s`.`id`,0,0,0,'0',0,0,0,-1,0,0,`s`.`x`,`s`.`y`,9.9,
  COALESCE((SELECT `c`.`orientation` FROM `creature` `c` WHERE `c`.`id`=268316 ORDER BY `c`.`guid` LIMIT 1),0),300,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,0
FROM (SELECT 920011000 AS `guid`,268313 AS `id`,-3638.5 AS `x`,-723.72 AS `y` UNION ALL SELECT 920011001,268314,-3639.32,-718.76) `s`
WHERE EXISTS (SELECT 1 FROM `creature_template` `t` WHERE `t`.`entry`=`s`.`id`)
  AND NOT EXISTS (SELECT 1 FROM `creature` `x` WHERE `x`.`id`=`s`.`id`)
  AND NOT EXISTS (SELECT 1 FROM `creature` `x` WHERE `x`.`guid`=`s`.`guid`);

-- 6. "Reach a place" objectives: Crate Expectations (92009) counts area trigger 39304 and Challenge of the Desert Wolf (95753)
--    33147; our world has neither. Placed at QuestieDB's objective points (Mount Hyjal, Tanaris) as 10-yard spheres (Everlake
--    987: Blizzard's shape and size are not public).
INSERT INTO `areatrigger_template` (`Id`,`IsCustom`,`Flags`,`ActionSetId`,`ActionSetFlags`,`VerifiedBuild`)
SELECT `s`.`Id`,0,0,0,0,0 FROM (SELECT 39304 AS `Id` UNION ALL SELECT 33147) `s`
WHERE NOT EXISTS (SELECT 1 FROM `areatrigger_template` `t` WHERE `t`.`Id`=`s`.`Id` AND `t`.`IsCustom`=0);
INSERT INTO `areatrigger_create_properties` (`Id`,`IsCustom`,`AreaTriggerId`,`IsAreatriggerCustom`,`Shape`,`ShapeData0`,`ShapeData1`)
SELECT `s`.`Id`,1,`s`.`At`,0,0,10,10 FROM (SELECT 9500101 AS `Id`,39304 AS `At` UNION ALL SELECT 9500102,33147) `s`
WHERE NOT EXISTS (SELECT 1 FROM `areatrigger_create_properties` `p` WHERE `p`.`Id`=`s`.`Id` AND `p`.`IsCustom`=1);
INSERT INTO `areatrigger` (`SpawnId`,`AreaTriggerCreatePropertiesId`,`IsCustom`,`MapId`,`SpawnDifficulties`,`PosX`,`PosY`,`PosZ`,`Orientation`,`PhaseUseFlags`,`PhaseId`,`PhaseGroup`,`ScriptName`,`Comment`,`VerifiedBuild`)
SELECT `s`.`SpawnId`,`s`.`SpawnId`,1,1,'0',`s`.`x`,`s`.`y`,`s`.`z`,0,1,0,0,'',`s`.`c`,0 FROM (
  SELECT 9500101 AS `SpawnId`,4865.42 AS `x`,-3020.91 AS `y`,1191.48 AS `z`,'Quest 92009 Crate Expectations - shipment delivered' AS `c`
  UNION ALL SELECT 9500102,-7613.34,-3373.43,51.92,'Quest 95753 Challenge of the Desert Wolf - Old Totem') `s`
WHERE NOT EXISTS (SELECT 1 FROM `areatrigger` `a` WHERE `a`.`SpawnId`=`s`.`SpawnId`);

-- 7. Water-only creatures that cannot swim sink and bob on the lake bed (Lake Threshers in Redridge and 12 more): they carry
--    AQUATIC without CAN_SWIM, and the core gives the swim flag only from CAN_SWIM (Everlake 995).
UPDATE `creature_template_difficulty` SET `StaticFlags1`=`StaticFlags1`|0x10000000
WHERE `DifficultyID`=0 AND (`StaticFlags1`&0x00040000)<>0 AND (`StaticFlags1`&0x10000000)=0
  AND `Entry` IN (6033,6145,8236,10942,11374,12123,12124,12125,14356,14357,14490,15505,15526);

-- 8. Zephras Isle's Windsong Crawlers, Gustjumpers and Docile Galestriders stand in the sea on live, which only an amphibious
--    creature does; without AMPHIBIOUS they hop in the shallows and cannot reach a player in water (Everlake 997).
UPDATE `creature_template_difficulty` SET `StaticFlags1`=`StaticFlags1`|0x00080000
WHERE `DifficultyID`=0 AND (`StaticFlags1`&0x00080000)=0 AND `Entry` IN (254588,259005,259175);
