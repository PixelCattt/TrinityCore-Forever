-- Retribution Aura and Thorns: 6% of the caster's spell power on every hit, as on live WoW Forever (dumpins, #bug-report
-- 2026-11-17: "only does the base flat dmg"). The client data has no coefficient on the damage shield effect (0), and there
-- were no classic_spell_value rows for these spells, so the server added none.
-- Live: Retribution Aura rank 5 hits fit floor(20 + 0.06 x the paladin's spell power), Thorns rank 6 is 18 + 0.06 x the druid's
-- spell power (combat logs, build 1.60.1.70938, wowsims/forever docs/evidence EV-0141 and EV-0067, MIT). The lower ranks get the
-- same 0.06 as the sim uses for every rank (not measured per rank). The amount is taken from the aura's caster (Unit.cpp,
-- damage shield), so it is the paladin's or druid's spell power, not the struck ally's.
-- Base points and dice are VMaNGOS spell_template (vanilla), the same totals the client has (5/8/12/16/20 and 3/6/9/12/15/18).
DELETE FROM `classic_spell_value` WHERE (`spell_id`,`effect_index`) IN
((7294,0),(10298,0),(10299,0),(10300,0),(10301,0),(467,0),(782,0),(1075,0),(8914,0),(9756,0),(9910,0));
INSERT INTO `classic_spell_value` (`spell_id`,`effect_index`,`effect`,`apply_aura`,`base_points`,`die_sides`,`points_per_level`,`misc_value`,`points_per_combo`,`bonus_coeff`,`spell_name`) VALUES
(7294,0,35,15,4,1,0,0,0,0.06,'Retribution Aura'),
(10298,0,35,15,7,1,0,0,0,0.06,'Retribution Aura'),
(10299,0,35,15,11,1,0,0,0,0.06,'Retribution Aura'),
(10300,0,35,15,15,1,0,0,0,0.06,'Retribution Aura'),
(10301,0,35,15,19,1,0,0,0,0.06,'Retribution Aura'),
(467,0,6,15,2,1,0,0,0,0.06,'Thorns'),
(782,0,6,15,5,1,0,0,0,0.06,'Thorns'),
(1075,0,6,15,8,1,0,0,0,0.06,'Thorns'),
(8914,0,6,15,11,1,0,0,0,0.06,'Thorns'),
(9756,0,6,15,14,1,0,0,0,0.06,'Thorns'),
(9910,0,6,15,17,1,0,0,0,0.06,'Thorns');
