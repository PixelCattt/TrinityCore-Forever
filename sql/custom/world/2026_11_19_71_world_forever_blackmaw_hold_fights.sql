-- WoW Forever: Blackmaw Hold fights (classic_instance_blackmaw_hold.cpp). Which spells the bosses cast is from Everlake's
-- Forever dungeon work (github.com/buildthehomelab, GPL); every spell id and its targets are from our 70938 client.
-- Seven of these spells pick their targets "every unit of an entry in the area" and come with no target list in the client,
-- so these rows say who they hit (players, or the boss the spell is for). Safe to run again.

-- what Nightmare Detonation's second effect summons (creature 248546). The client has no record of it and neither does any
-- player cache: an invisible stand-in so the summon does not fail. INFERRED (name, faction, level).
DELETE FROM `creature_template` WHERE `entry` = 248546;
INSERT INTO `creature_template` (`entry`,`KillCredit1`,`KillCredit2`,`name`,`femaleName`,`subname`,`TitleAlt`,`IconName`,`RequiredExpansion`,`VignetteID`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`Classification`,`dmgschool`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,`unit_flags`,`unit_flags2`,`unit_flags3`,`family`,`trainer_class`,`type`,`VehicleId`,`AIName`,`MovementType`,`ExperienceModifier`,`RacialLeader`,`movementId`,`WidgetSetID`,`WidgetSetUnitConditionID`,`RegenHealth`,`CreatureImmunitiesId`,`flags_extra`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(248546,0,0,'Nightmare Detonation',NULL,NULL,NULL,NULL,0,0,35,0,1.0,1.14286,1.0,0,0,2000,2000,1.0,1.0,1,33554434,2048,0,0,0,10,0,'',0,1.0,0,0,0,0,1,0,128,'',NULL,0);
DELETE FROM `creature_template_difficulty` WHERE `Entry` = 248546;
INSERT INTO `creature_template_difficulty` (`Entry`,`DifficultyID`,`LevelScalingDeltaMin`,`LevelScalingDeltaMax`,`ContentTuningID`,`HealthScalingExpansion`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`DamageModifier`,`CreatureDifficultyID`,`TypeFlags`,`TypeFlags2`,`TypeFlags3`,`LootID`,`PickPocketLootID`,`SkinLootID`,`GoldMin`,`GoldMax`,`StaticFlags1`,`StaticFlags2`,`StaticFlags3`,`StaticFlags4`,`StaticFlags5`,`StaticFlags6`,`StaticFlags7`,`StaticFlags8`,`VerifiedBuild`) VALUES
(248546,0,0,0,0,0,1.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
DELETE FROM `creature_template_model` WHERE `CreatureID` = 248546;
INSERT INTO `creature_template_model` (`CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild`) VALUES
(248546,0,1126,1.0,0.0,0),
(248546,1,15435,1.0,1.0,0);
DELETE FROM `creature_classic_level` WHERE `entry` = 248546;
INSERT INTO `creature_classic_level` (`entry`,`level_min`,`level_max`) VALUES
(248546,55,55);

-- spell targets (SourceGroup is the spell's effect mask; 31 with 4 = players, 31 with 3 and an entry = that creature)
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` IN (1247087,1246456,1246364,1245154,1247252,1245119,1244951);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ConditionStringValue1`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 1247087, 0, 0, 31, 0, 4, 0, 0, '', 0, 0, 0, '', 'Varrox Bleakhoof - Fear - players'),
(13, 3, 1246456, 0, 0, 31, 0, 4, 0, 0, '', 0, 0, 0, '', 'Varrox Bleakhoof - Crimson Wrest - players'),
(13, 1, 1246364, 0, 0, 31, 0, 4, 0, 0, '', 0, 0, 0, '', 'Varrox Bleakhoof - Nightmare Detonation - players'),
(13, 1, 1245154, 0, 0, 31, 0, 4, 0, 0, '', 0, 0, 0, '', 'Blackmaw Behemoth - Thunder Roar - players'),
(13, 3, 1247252, 0, 0, 31, 0, 3, 247231, 0, '', 0, 0, 0, '', 'Elder Bramblesnap - Purify - Unbound Spirit'),
(13, 1, 1245119, 0, 0, 31, 0, 3, 247207, 0, '', 0, 0, 0, '', 'Blackmaw Behemoth - Bestial Roar - himself'),
(13, 1, 1244951, 0, 0, 31, 0, 3, 247207, 0, '', 0, 0, 0, '', 'Clawbert - Restore - Blackmaw Behemoth');
