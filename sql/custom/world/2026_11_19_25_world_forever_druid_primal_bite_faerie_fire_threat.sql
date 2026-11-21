-- WoW Forever druid threat (wowsims/forever, MIT, docs/evidence EV-0034, EV-0037):
--   Primal Bite 407995, 1238069, 1238070 "generating a high amount of threat": 3 times its damage, no flat part.
--   Faerie Fire 770, 778, 9749, 9907: no flat threat from the vanilla rows (36..108); a landed cast in Bear or Dire Bear Form threatens for
--   2 x the caster's level before the form's multiplier, by script (classic_spell_dru_faerie_fire_threat), none in other forms.
-- Runs after 2026_10_25_35_world_classic_spell_threat_vmangos.sql. Safe to run again.
DELETE FROM `spell_threat` WHERE `entry` IN (407995, 1238069, 1238070, 770, 778, 9749, 9907);
INSERT INTO `spell_threat` (`entry`, `flatMod`, `pctMod`, `apPctMod`) VALUES
(407995, 0, 3, 0),
(1238069, 0, 3, 0),
(1238070, 0, 3, 0),
(770, 0, 1, 0),
(778, 0, 1, 0),
(9749, 0, 1, 0),
(9907, 0, 1, 0);
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'classic_spell_dru_faerie_fire_threat';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(770, 'classic_spell_dru_faerie_fire_threat'),
(778, 'classic_spell_dru_faerie_fire_threat'),
(9749, 'classic_spell_dru_faerie_fire_threat'),
(9907, 'classic_spell_dru_faerie_fire_threat');
