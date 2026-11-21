-- WoW Forever: warrior attack power shares the client rows leave at 0, so these abilities took no attack power (wowsims/forever, MIT,
-- tools/database/overrides/spell_overrides.go). Rend: each tick + 0.02 x attack power (EV-0019, EV-0048); Thunder Clap: each hit + 0.07 x
-- attack power (EV-0019, EV-0048); Revenge: + 0.25 x attack power, the tooltip's $APR (EV-0048). Safe to run again.
DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('classic_spell_warr_rend_attack_power', 'classic_spell_warr_thunder_clap_attack_power', 'classic_spell_warr_revenge_attack_power');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(772, 'classic_spell_warr_rend_attack_power'), (6546, 'classic_spell_warr_rend_attack_power'), (6547, 'classic_spell_warr_rend_attack_power'),
(6548, 'classic_spell_warr_rend_attack_power'), (11572, 'classic_spell_warr_rend_attack_power'), (11573, 'classic_spell_warr_rend_attack_power'),
(11574, 'classic_spell_warr_rend_attack_power'),
(6343, 'classic_spell_warr_thunder_clap_attack_power'), (8198, 'classic_spell_warr_thunder_clap_attack_power'), (8204, 'classic_spell_warr_thunder_clap_attack_power'),
(8205, 'classic_spell_warr_thunder_clap_attack_power'), (11580, 'classic_spell_warr_thunder_clap_attack_power'), (11581, 'classic_spell_warr_thunder_clap_attack_power'),
(6572, 'classic_spell_warr_revenge_attack_power'), (6574, 'classic_spell_warr_revenge_attack_power'), (7379, 'classic_spell_warr_revenge_attack_power'),
(11600, 'classic_spell_warr_revenge_attack_power'), (11601, 'classic_spell_warr_revenge_attack_power'), (25288, 'classic_spell_warr_revenge_attack_power');
