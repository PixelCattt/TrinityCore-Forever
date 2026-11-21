-- WoW Forever: Mark of the Chosen 17774 (aura 21969), "Has a 2% chance when struck in combat": the client's proc flags 0x2A2A8 also name
-- helpful spells taken (0x8000), so a heal on the wearer could proc it; every measured proc followed a hit taken (wowsims/forever, MIT,
-- sim/common/forever/items_trinkets.go, docs/evidence EV-0036). The row keeps melee swings, melee and ranged abilities, ranged attacks
-- and harmful abilities and spells taken (0x222A8); Chance and Cooldown 0 keep the client's 2% and 120 s. Safe to run again.
DELETE FROM `spell_proc` WHERE `SpellId` = 21969;
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `SpellFamilyMask3`,
`ProcFlags`, `ProcFlags2`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(21969, 0, 0, 0, 0, 0, 0, 0x222A8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
