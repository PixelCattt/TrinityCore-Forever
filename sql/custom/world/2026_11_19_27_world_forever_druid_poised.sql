-- WoW Forever: Poised 1328829 gives its buff 1328827 (-10 energy on the next cat ability, one charge) while the druid is out of combat at
-- full energy (script classic_spell_dru_poised). The buff's charge is spent at the cast, so a missed, dodged, parried or immune cast spends
-- it too (wowsims/forever, MIT, docs/evidence EV-0035: 27 of 27 avoided casts); PROC_ATTR_REQ_SPELLMOD (8) keeps it to the abilities the
-- cost mod names. ProcFlags 0 keeps the client's. Safe to run again.
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'classic_spell_dru_poised';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (1328829, 'classic_spell_dru_poised');
DELETE FROM `spell_proc` WHERE `SpellId` = 1328827;
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `SpellFamilyMask3`,
`ProcFlags`, `ProcFlags2`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(1328827, 0, 0, 0, 0, 0, 0, 0, 0, 7, 1, 0, 8, 0, 0, 100, 0, 1);
