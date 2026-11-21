-- WoW Forever: Flurry's buff 12966 spends no charge on Windfury Totem's strike, and a crit leaves it at 3 charges (script
-- classic_spell_warr_flurry_buff; wowsims/forever, MIT, docs/evidence EV-0140, EV-0138). Safe to run again.
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'classic_spell_warr_flurry_buff';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (12966, 'classic_spell_warr_flurry_buff');
