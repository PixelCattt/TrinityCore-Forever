-- WoW Forever: Shadow Word: Death backlash, 30% (effect 2) of the priest's maximum health when the target survives the hit.
-- C++: Custom/Classic/world/talents/classic_talents_priest_paladin.cpp (classic_spell_pri_shadow_word_death_backlash). Safe to run again.
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'classic_spell_pri_shadow_word_death_backlash';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(1309595,'classic_spell_pri_shadow_word_death_backlash'),(1309633,'classic_spell_pri_shadow_word_death_backlash'),
(1309635,'classic_spell_pri_shadow_word_death_backlash'),(1309636,'classic_spell_pri_shadow_word_death_backlash');
