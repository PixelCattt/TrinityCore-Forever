-- WoW Forever: Shadow Weaving 15257 stacks on every landed Shadow damage spell of the priest, the application of a damage over time effect
-- included. The row from 2026_10_21_41 heard damage only (spell type 1), so Shadow Word: Pain, Devouring Plague and Mind Flay landing
-- stacked nothing and only Mind Blast and Shadow Word: Death hits did. The client's proc flag is a harmful spell landing (0x10000), not a
-- periodic tick (wowsims/forever, MIT, sim/priest/talents_shadow.go; ported from Everlake, GPL, PR 81).
-- The priest family mask names the spells, so other Shadow spells of the priest (Vampiric Embrace, Hex of Weakness) no longer roll it:
--   word 0: Mind Blast 0x2000, Shadow Word: Pain 0x8000, Mind Flay 0x800000, Devouring Plague 0x2000000
--   word 1: Shadow Word: Death 0x2, Mind Sear 0x80000 and 0x100000
-- Spell type 1 | 4 (damage or none) on the hit phase; ProcFlags 0 keeps the client's. Safe to run again.
DELETE FROM `spell_proc` WHERE `SpellId` = 15257;
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `SpellFamilyMask3`,
`ProcFlags`, `ProcFlags2`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(15257, 32, 6, 0x0280A000, 0x00180002, 0, 0, 0, 0, 5, 2, 0, 0, 0, 0, 0, 0, 0);
