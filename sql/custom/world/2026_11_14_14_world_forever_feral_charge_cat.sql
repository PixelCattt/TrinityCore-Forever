-- Feral Charge in Cat Form did the bear charge (Discord, 6_1_8_8_1, 2026-11-14, 0.1.36): "the character does not leap behind the
-- target". The Forever talent Feral Charge (1238122) is one button: in Cat Form the hidden aura 414925 swaps it for Feral Charge
-- (Cat) 414924, in Bear / Dire Bear Form 1238124 swaps it for Feral Charge (Bear) 16979 (aura 332, Stances cat / bear). Nothing
-- taught those two auras, so HandleShapeshiftBoosts never put them on and the button always cast the plain bear charge.
-- They now come with the talent (not shown in the spell book; a druid who already has the talent gets them at the next login).
-- The cat leap itself (effect 175, no core handler) is done by spell_dru_classic_feral_charge_cat.
-- Safe to run again.
DELETE FROM `spell_learn_spell` WHERE `entry` = 1238122 AND `SpellID` IN (414925, 1238124);
INSERT INTO `spell_learn_spell` (`entry`, `SpellID`, `Active`) VALUES
(1238122, 414925, 0),
(1238122, 1238124, 0);
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_dru_classic_feral_charge_cat';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (414924, 'spell_dru_classic_feral_charge_cat');
