-- Force of Will (item 11810, equip aura 15594, buff 15595 "reduce all damage taken by 51 for 10 sec").
-- The live spell data gives 15594 a proc chance of 100 and no procs per minute, with a 30 s cooldown, so the trinket went off on the
-- first melee hit taken after every cooldown. Warcraft Logs (wowsims EV-0154, 278 wearers, builds 70888 to 70959): 6.2% on each melee
-- hit taken that deals damage (a white swing or a melee ability; a miss, dodge, parry, full block or full absorb rolls nothing), with
-- the 30 s cooldown. Safe to run again.
DELETE FROM `spell_proc` WHERE `SpellId` = 15594;
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `SpellFamilyMask3`,
`ProcFlags`, `ProcFlags2`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(15594, 0, 0, 0, 0, 0, 0, 0x28, 0, 0, 0, 0x3, 0, 0, 0, 6, 30000, 0);
