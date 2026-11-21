-- WoW Forever: Omen of Clarity 16864 rolls its 2 procs a minute (10 s cooldown) on damage-free hits as well: Faerie Fire 23 of 365,
-- Bash 2 of 22, Growl 0 of 150 (wowsims/forever, MIT, docs/evidence EV-0020). The row hears auto attacks, melee abilities and harmful
-- spells (0x10014, the client's flags without helpful casts) that land, with or without damage (spell type 1 | 4); Aura::CalcProcChance
-- prices a damage-free hit on the paw speed (melee) or the cast time (spells, 1.5 s for an instant). The script keeps Growl and Faerie
-- Fire in Cat, Bear or Dire Bear Form out. Replaces the row 2026_10_11_09 set. Safe to run again.
DELETE FROM `spell_proc` WHERE `SpellId` = 16864;
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `SpellFamilyMask3`,
`ProcFlags`, `ProcFlags2`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(16864, 0, 0, 0, 0, 0, 0, 0x10014, 0, 5, 2, 0, 0, 0, 2, 0, 10000, 0);
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'classic_spell_dru_omen_of_clarity';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (16864, 'classic_spell_dru_omen_of_clarity');
