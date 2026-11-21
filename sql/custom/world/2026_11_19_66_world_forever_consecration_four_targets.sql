-- Consecration tick 1280345-1280349 (Forever): only the first 4 enemies take the bigger hit (effect 1), as the spell text says.
DELETE FROM `spell_script_names` WHERE `spell_id` IN (1280345,1280346,1280347,1280348,1280349) AND `ScriptName` = 'classic_spell_pal_consecration_tick';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(1280345,'classic_spell_pal_consecration_tick'),
(1280346,'classic_spell_pal_consecration_tick'),
(1280347,'classic_spell_pal_consecration_tick'),
(1280348,'classic_spell_pal_consecration_tick'),
(1280349,'classic_spell_pal_consecration_tick');
