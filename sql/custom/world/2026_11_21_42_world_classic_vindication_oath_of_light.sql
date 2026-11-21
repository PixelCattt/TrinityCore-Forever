-- Classic 1.60 (client 70959, live Forever data): paladin talents that did nothing (classic_talents_priest_paladin.cpp). Safe to run again.
-- Vindication 9452: the attack power debuff 440667 (a third per rank), 5 procs a minute on the weapon's speed from white hits and
-- melee specials that deal damage (wowsims/forever, MIT). The client row says chance 100, which would be every hit.
-- Oath of Light 1328548 / Boundless Light 1328550: read by the paladin's Holy Light, Flash of Light and Holy Shock heals.
DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('classic_spell_pal_vindication', 'classic_spell_pal_oath_of_light_heal');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(9452, 'classic_spell_pal_vindication'),
(635, 'classic_spell_pal_oath_of_light_heal'),
(639, 'classic_spell_pal_oath_of_light_heal'),
(647, 'classic_spell_pal_oath_of_light_heal'),
(1026, 'classic_spell_pal_oath_of_light_heal'),
(1042, 'classic_spell_pal_oath_of_light_heal'),
(3472, 'classic_spell_pal_oath_of_light_heal'),
(10328, 'classic_spell_pal_oath_of_light_heal'),
(10329, 'classic_spell_pal_oath_of_light_heal'),
(25292, 'classic_spell_pal_oath_of_light_heal'),
(19750, 'classic_spell_pal_oath_of_light_heal'),
(19939, 'classic_spell_pal_oath_of_light_heal'),
(19940, 'classic_spell_pal_oath_of_light_heal'),
(19941, 'classic_spell_pal_oath_of_light_heal'),
(19942, 'classic_spell_pal_oath_of_light_heal'),
(19943, 'classic_spell_pal_oath_of_light_heal'),
(25903, 'classic_spell_pal_oath_of_light_heal'),
(25913, 'classic_spell_pal_oath_of_light_heal'),
(25914, 'classic_spell_pal_oath_of_light_heal'),
(1311605, 'classic_spell_pal_oath_of_light_heal');

DELETE FROM `spell_proc` WHERE `SpellId`=9452;
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `SpellFamilyMask3`,
`ProcFlags`, `ProcFlags2`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(9452, 0, 0, 0, 0, 0, 0, 0x14, 0, 0x1, 0x2, 0, 0, 0, 5, 0, 0, 0);
