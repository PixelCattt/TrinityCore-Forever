-- Classic 1.60: Shield Specialization procs on blocked attacks only, as both tooltips say. Warrior 12298: "a $m2% chance to generate
-- ${$1310318m1/10} Rage when you Block"; paladin 20150: "gives your blocks a $m2% chance to restore $1310925m1% of your maximum Mana".
-- The client proc data has no hit mask, so without a row the core used the default taken hit mask (normal and critical hits): the
-- paladin got mana from hits that were not blocked, also with no shield on (Discord, dumpins 2026-11-17), and the warrior rage the same
-- way. Same fix as Holy Shield in 2026_11_06_10. The proc chance stays with classic_spell_proc_chance_from_effect (2026_11_12_02).
-- ProcFlags, Chance, Cooldown (paladin 3 s) and Charges 0 keep the client's. Safe to run again.
DELETE FROM `spell_proc` WHERE `SpellId` IN (12298, 20150);
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `SpellFamilyMask3`,
`ProcFlags`, `ProcFlags2`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(12298, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x40, 0, 0, 0, 0, 0, 0),
(20150, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x40, 0, 0, 0, 0, 0, 0);
