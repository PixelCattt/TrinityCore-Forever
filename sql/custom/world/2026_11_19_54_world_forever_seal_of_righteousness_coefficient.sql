-- WoW Forever: Seal of Righteousness hits take 0.1 (one-hander) or 0.12 (two-hander) of Holy spell power, the tooltip's coefficients;
-- the script classic_spell_pal_seal_of_righteousness adds it, so the damage spells' own vanilla coefficients go to 0 (rank 9 25713 and
-- 25735-25738 had 0, 25739-25742 0.029 to 0.093) (wowsims/forever, MIT, docs/rulings R-0009, docs/evidence EV-0060). Safe to run again.
UPDATE `classic_spell_value` SET `bonus_coeff` = 0 WHERE `spell_id` IN (25713, 25735, 25736, 25737, 25738, 25739, 25740, 25741, 25742);
