-- WoW Forever: Moonshadow Stave 22458 (aura 1300435), "Harmful spell casts have a chance to deal 91 Arcane or Shadow damage". The aura is a
-- dummy that fired nothing; classic_spell_item_moonshadow_stave fires Shadow 1300437 or Arcane 1300438 at the target. The row prices 1.5
-- procs a minute on the cast time of the spell that landed, at least 1.5 s (Aura::CalcProcChance), in place of the client's retail
-- real-PPM: 3.8% on an instant or a 1.5 s Wrath, 6 to 9% on Starfire. Harmful spells that land, with or without damage (spell type 1 | 4),
-- on the hit phase; ProcFlags 0 and Cooldown 0 keep the client's flags and 10 ms cooldown (wowsims/forever, MIT, docs/evidence EV-0115).
-- Safe to run again.
DELETE FROM `spell_proc` WHERE `SpellId` = 1300435;
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `SpellFamilyMask3`,
`ProcFlags`, `ProcFlags2`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(1300435, 0, 0, 0, 0, 0, 0, 0, 0, 5, 2, 0, 0, 0, 1.5, 0, 0, 0);
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'classic_spell_item_moonshadow_stave';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (1300435, 'classic_spell_item_moonshadow_stave');
