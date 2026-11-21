-- Cleave 19983 (Sapphiron, Vaelastrasz and other classic NPCs) only chains to those within 5 yards of the target it lands on, as in vanilla.
-- C++: classic_spell_cleave_melee_reach (Custom/Classic/world/classic_spell_scripts.cpp). Safe to run again.
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'classic_spell_cleave_melee_reach';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(19983, 'classic_spell_cleave_melee_reach');
