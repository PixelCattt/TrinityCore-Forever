-- Portable Repair Bot (creature 277849): what the Portable Repair Bot item (287961) summons. Spell 1324661 is
-- effect 28 (summon) of 277849 for 5 minutes; the realm had no such creature, so the item summoned nothing.
-- Display 149103 is the client's (model 18428, scale 0.5). Everything else is copied from the engineers'
-- Field Repair Bot 74A (14337), which does the same job: faction, vendor + repair flags, mechanical, level 50,
-- and the model info of its display 14379. No vendor stock: it repairs and buys. No spawn: the item summons it.
-- Reported by Everlake (github.com/buildthehomelab/wow-trinitycore-everlake, GPL-3, dc5f4503).
DELETE FROM `creature_template` WHERE `entry`=277849;
INSERT INTO `creature_template` (`entry`,`KillCredit1`,`KillCredit2`,`name`,`femaleName`,`subname`,`TitleAlt`,`IconName`,`RequiredExpansion`,`VignetteID`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`Classification`,`dmgschool`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,`unit_flags`,`unit_flags2`,`unit_flags3`,`family`,`trainer_class`,`type`,`VehicleId`,`AIName`,`MovementType`,`ExperienceModifier`,`RacialLeader`,`movementId`,`WidgetSetID`,`WidgetSetUnitConditionID`,`RegenHealth`,`CreatureImmunitiesId`,`flags_extra`,`ScriptName`,`StringId`,`VerifiedBuild`)
SELECT 277849,0,0,'Portable Repair Bot',NULL,NULL,NULL,NULL,`RequiredExpansion`,0,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`Classification`,`dmgschool`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,`unit_flags`,`unit_flags2`,`unit_flags3`,`family`,`trainer_class`,`type`,`VehicleId`,`AIName`,`MovementType`,`ExperienceModifier`,`RacialLeader`,`movementId`,`WidgetSetID`,`WidgetSetUnitConditionID`,`RegenHealth`,`CreatureImmunitiesId`,`flags_extra`,'',NULL,0
FROM `creature_template` WHERE `entry`=14337;

DELETE FROM `creature_template_difficulty` WHERE `Entry`=277849;
INSERT INTO `creature_template_difficulty` (`Entry`,`DifficultyID`,`LevelScalingDeltaMin`,`LevelScalingDeltaMax`,`ContentTuningID`,`HealthScalingExpansion`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`DamageModifier`,`CreatureDifficultyID`,`TypeFlags`,`TypeFlags2`,`TypeFlags3`,`LootID`,`PickPocketLootID`,`SkinLootID`,`GoldMin`,`GoldMax`,`StaticFlags1`,`StaticFlags2`,`StaticFlags3`,`StaticFlags4`,`StaticFlags5`,`StaticFlags6`,`StaticFlags7`,`StaticFlags8`,`VerifiedBuild`)
SELECT 277849,`DifficultyID`,`LevelScalingDeltaMin`,`LevelScalingDeltaMax`,`ContentTuningID`,`HealthScalingExpansion`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`DamageModifier`,0,`TypeFlags`,`TypeFlags2`,`TypeFlags3`,0,0,0,0,0,`StaticFlags1`,`StaticFlags2`,`StaticFlags3`,`StaticFlags4`,`StaticFlags5`,`StaticFlags6`,`StaticFlags7`,`StaticFlags8`,0
FROM `creature_template_difficulty` WHERE `Entry`=14337;

DELETE FROM `creature_template_model` WHERE `CreatureID`=277849;
INSERT INTO `creature_template_model` (`CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild`) VALUES
(277849,0,149103,1,1,0);

DELETE FROM `creature_classic_level` WHERE `entry`=277849;
INSERT INTO `creature_classic_level` (`entry`,`level_min`,`level_max`) SELECT 277849,`level_min`,`level_max` FROM `creature_classic_level` WHERE `entry`=14337;

-- Only when the display has no model info yet (a real one wins).
INSERT IGNORE INTO `creature_model_info` (`DisplayID`,`BoundingRadius`,`CombatReach`,`DisplayID_Other_Gender`,`VerifiedBuild`)
SELECT 149103,`BoundingRadius`,`CombatReach`,0,0 FROM `creature_model_info` WHERE `DisplayID`=14379;
