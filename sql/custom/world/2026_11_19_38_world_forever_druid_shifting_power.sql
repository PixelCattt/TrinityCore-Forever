-- WoW Forever: Shifting Power 1322605 cannot be used at full energy (Blizzard's 8 October 2026 hotfixes; wowsims/forever, MIT,
-- sim/druid/shifting_power.go). Safe to run again.
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'classic_spell_dru_shifting_power';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (1322605, 'classic_spell_dru_shifting_power');
