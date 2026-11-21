-- WoW Forever: Dark Sacrifice 1277324-1277328 takes its health (effect 0, periodic dummy) and adds the priest's Spirit to its mana.
-- C++: Custom/Classic/world/talents/classic_talents_priest_paladin.cpp (classic_spell_pri_dark_sacrifice). Safe to run again.
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'classic_spell_pri_dark_sacrifice';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(1277324,'classic_spell_pri_dark_sacrifice'),(1277325,'classic_spell_pri_dark_sacrifice'),(1277326,'classic_spell_pri_dark_sacrifice'),
(1277327,'classic_spell_pri_dark_sacrifice'),(1277328,'classic_spell_pri_dark_sacrifice');
