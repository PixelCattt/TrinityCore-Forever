-- WoW Forever: Ruthlessness 14156 also rolls after Slice and Dice, a finisher with no damage the Ruthlessness row does not hear.
-- C++: Custom/Classic/world/talents/classic_rogue_abilities.cpp (classic_spell_rog_slice_and_dice_ruthlessness). Safe to run again.
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'classic_spell_rog_slice_and_dice_ruthlessness';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (5171,'classic_spell_rog_slice_and_dice_ruthlessness'),(6774,'classic_spell_rog_slice_and_dice_ruthlessness');
