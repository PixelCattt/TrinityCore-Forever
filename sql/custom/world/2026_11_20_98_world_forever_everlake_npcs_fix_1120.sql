-- Fixes for 2026_11_20_96_world_forever_everlake_npcs_1120.sql (Forever creatures from open data via Everlake, GPL-3.0).
-- Safe to run more than once.

-- 1. Its spawns wrote 0 into the per-spawn npcflag and unit flag columns and 100 into curHealthPct. A value there replaces the
--    template's on this core, so quest givers lost their quest marker, every creature lost unit_flags2 2048, and the health
--    value logged an error at start for creatures that regenerate. NULL keeps the template's values, like our other spawns.
UPDATE `creature` SET `npcflag`=NULL WHERE `guid` BETWEEN 920001000 AND 920006049 AND `id` IN (214456,218230,222233,244530,252711,253394,253524,253526,254040,254283,254566,254567,254717,254770,254775,255003,255691,256028,256891,256899,257250,257861,257916,259054,259055,259256,259258,260244,260968,260973,260993,260996,261497,261711,262072,262169,263141,263307,269057,270919,276401,278088) AND `npcflag`=0;
UPDATE `creature` SET `unit_flags`=NULL WHERE `guid` BETWEEN 920001000 AND 920006049 AND `id` IN (214456,218230,222233,244530,252711,253394,253524,253526,254040,254283,254566,254567,254717,254770,254775,255003,255691,256028,256891,256899,257250,257861,257916,259054,259055,259256,259258,260244,260968,260973,260993,260996,261497,261711,262072,262169,263141,263307,269057,270919,276401,278088) AND `unit_flags`=0;
UPDATE `creature` SET `unit_flags2`=NULL WHERE `guid` BETWEEN 920001000 AND 920006049 AND `id` IN (214456,218230,222233,244530,252711,253394,253524,253526,254040,254283,254566,254567,254717,254770,254775,255003,255691,256028,256891,256899,257250,257861,257916,259054,259055,259256,259258,260244,260968,260973,260993,260996,261497,261711,262072,262169,263141,263307,269057,270919,276401,278088) AND `unit_flags2`=0;
UPDATE `creature` SET `unit_flags3`=NULL WHERE `guid` BETWEEN 920001000 AND 920006049 AND `id` IN (214456,218230,222233,244530,252711,253394,253524,253526,254040,254283,254566,254567,254717,254770,254775,255003,255691,256028,256891,256899,257250,257861,257916,259054,259055,259256,259258,260244,260968,260973,260993,260996,261497,261711,262072,262169,263141,263307,269057,270919,276401,278088) AND `unit_flags3`=0;
UPDATE `creature` SET `curHealthPct`=NULL WHERE `guid` BETWEEN 920001000 AND 920006049 AND `id` IN (214456,218230,222233,244530,252711,253394,253524,253526,254040,254283,254566,254567,254717,254770,254775,255003,255691,256028,256891,256899,257250,257861,257916,259054,259055,259256,259258,260244,260968,260973,260993,260996,261497,261711,262072,262169,263141,263307,269057,270919,276401,278088) AND `curHealthPct`=100;

-- 2. The kill credits the live client gives these creatures (EG Link's creature details): Bristleback Nomad and Bristleback
--    Skullcrusher count as Bristleback Quilboar (253852), Empowered Brute and Twilight Ritualist as Twilight Ritual Circle
--    (262006). Neither credit creature had a template, so the core dropped the credit. Names from QuestieDB (GPL-3.0); built
--    like our other invisible kill credit creatures (e.g. 253370). They are never spawned.
DROP TEMPORARY TABLE IF EXISTS `forever_credit_1120`;
CREATE TEMPORARY TABLE `forever_credit_1120` (`entry` INT UNSIGNED NOT NULL PRIMARY KEY, `name` VARCHAR(100) NOT NULL);
INSERT INTO `forever_credit_1120` VALUES (253852,'Bristleback Quilboar'),(262006,'Twilight Ritual Circle');
INSERT INTO `creature_template` (`entry`,`KillCredit1`,`KillCredit2`,`name`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`Classification`,
  `dmgschool`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,`unit_flags`,`unit_flags2`,`unit_flags3`,`family`,
  `trainer_class`,`type`,`VehicleId`,`AIName`,`MovementType`,`ExperienceModifier`,`RacialLeader`,`movementId`,`WidgetSetID`,
  `WidgetSetUnitConditionID`,`RegenHealth`,`CreatureImmunitiesId`,`flags_extra`,`ScriptName`,`VerifiedBuild`)
SELECT `s`.`entry`,0,0,`s`.`name`,35,0,1,1.14286,1,0,0,2000,2000,1,1,1,33555200,2048,0,0,0,10,0,'',0,1,0,0,0,0,1,0,0,'',0
FROM `forever_credit_1120` `s` WHERE NOT EXISTS (SELECT 1 FROM `creature_template` `x` WHERE `x`.`entry`=`s`.`entry`);
INSERT INTO `creature_template_difficulty` (`Entry`,`DifficultyID`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`DamageModifier`)
SELECT `s`.`entry`,0,1,1,1,1 FROM `forever_credit_1120` `s`
WHERE NOT EXISTS (SELECT 1 FROM `creature_template_difficulty` `x` WHERE `x`.`Entry`=`s`.`entry` AND `x`.`DifficultyID`=0);
INSERT INTO `creature_template_model` (`CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild`)
SELECT `s`.`entry`,0,11686,1,1,0 FROM `forever_credit_1120` `s`
WHERE NOT EXISTS (SELECT 1 FROM `creature_template_model` `x` WHERE `x`.`CreatureID`=`s`.`entry`);
INSERT INTO `creature_classic_level` (`entry`,`level_min`,`level_max`)
SELECT `s`.`entry`,1,1 FROM `forever_credit_1120` `s`
WHERE NOT EXISTS (SELECT 1 FROM `creature_classic_level` `x` WHERE `x`.`entry`=`s`.`entry`);
DROP TEMPORARY TABLE IF EXISTS `forever_credit_1120`;
