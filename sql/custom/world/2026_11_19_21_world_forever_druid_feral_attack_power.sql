-- WoW Forever: attack power shares the client rows of these feral abilities do not state, measured in game
-- (wowsims/forever, MIT, docs/evidence EV-0031, EV-0033, EV-0034, EV-0036):
--   Rake 6.5% on the hit and every tick, Swipe 3% on each target, Pounce Bleed 2.5% every tick.
-- C++: Custom/Classic/world/talents/classic_talents_warlock_druid.cpp (classic_spell_dru_feral_attack_power_hit / _tick). Safe to run again.
DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('classic_spell_dru_rake_attack_power','classic_spell_dru_swipe_attack_power','classic_spell_dru_pounce_bleed_attack_power');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(1822,'classic_spell_dru_rake_attack_power'),(1823,'classic_spell_dru_rake_attack_power'),(1824,'classic_spell_dru_rake_attack_power'),(9904,'classic_spell_dru_rake_attack_power'),
(779,'classic_spell_dru_swipe_attack_power'),(780,'classic_spell_dru_swipe_attack_power'),(769,'classic_spell_dru_swipe_attack_power'),(9754,'classic_spell_dru_swipe_attack_power'),(9908,'classic_spell_dru_swipe_attack_power'),
(9007,'classic_spell_dru_pounce_bleed_attack_power'),(9824,'classic_spell_dru_pounce_bleed_attack_power'),(9826,'classic_spell_dru_pounce_bleed_attack_power');
