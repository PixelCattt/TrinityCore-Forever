-- WoW Forever: Enrage 5229 takes 27% (Bear Form) or 16% (Dire Bear Form) of the item and Agility armor while it lasts
-- (wowsims/forever, MIT, docs/evidence EV-0032, EV-0109, EV-0034). The script makes the armor update when the aura comes and goes;
-- the rule is in Player::UpdateArmor. Safe to run again.
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'classic_spell_dru_enrage_armor';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (5229, 'classic_spell_dru_enrage_armor');
