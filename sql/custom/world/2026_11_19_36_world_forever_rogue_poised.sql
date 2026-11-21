-- WoW Forever: rogue Poised 1328825 gives its buff 1328826 (-10 energy on the next ability, Composure adds to it; one charge) while the
-- rogue is out of combat at full energy (script classic_spell_rog_poised, as the druid's Poised). The charge is spent when a cast of the
-- abilities the buff names goes out, a finisher that hits nothing or an avoided cast included (wowsims/forever, MIT, sim/rogue/poised.go);
-- PROC_ATTR_REQ_SPELLMOD (8) keeps it to them. Safe to run again.
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'classic_spell_rog_poised';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (1328825, 'classic_spell_rog_poised');
DELETE FROM `spell_proc` WHERE `SpellId` = 1328826;
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `SpellFamilyMask3`,
`ProcFlags`, `ProcFlags2`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(1328826, 0, 0, 0, 0, 0, 0, 0, 0, 7, 1, 0, 8, 0, 0, 100, 0, 1);
