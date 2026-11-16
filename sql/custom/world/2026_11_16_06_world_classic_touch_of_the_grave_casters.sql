-- Touch of the Grave never drained for Undead priests, mages and warlocks. The 1.60 client gives casters their own copy of the
-- racial, 1260201 (30% chance, SkillLineAbility class mask 400), while warriors, paladins and rogues learn 1260189 (20%, class
-- mask 11). Only 1260189 had the script that casts the drain 1260198, so the casters' aura procced and did nothing.
DELETE FROM `spell_script_names` WHERE `spell_id` = 1260201 AND `ScriptName` = 'classic_spell_undead_touch_of_the_grave';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(1260201, 'classic_spell_undead_touch_of_the_grave');
