-- WoW Forever: two item procs whose client proc chance reads 100, a sentinel the tooltips contradict ("has a chance"). Rates counted
-- in Forever dungeon logs, builds 70862 to 70938 (wowsims/forever, MIT, docs/evidence EV-0115):
--   Draconic Infused Emblem 22268 (aura 1318931 -> 1318930): 8% on each landed harmful spell, rolled per target, no cooldown (435 procs in ~5,200 hits).
--   Zealot Plate 274651 (aura 1294668 -> 1294666): 5% on each melee swing taken, 15 s cooldown (the client's own cooldown); spell-type 0 keeps melee abilities out.
-- ProcFlags 0 keeps the client's flags. Safe to run again.
DELETE FROM `spell_proc` WHERE `SpellId` IN (1318931, 1294668);
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `SpellFamilyMask3`,
`ProcFlags`, `ProcFlags2`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(1318931, 0, 0, 0, 0, 0, 0, 0, 0, 5, 2, 0, 0, 0, 0, 8, 0, 0),      -- Draconic Infused Emblem: harmful spells that land (damage or not)
(1294668, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 15000, 0);  -- Zealot Plate: struck by a melee swing
