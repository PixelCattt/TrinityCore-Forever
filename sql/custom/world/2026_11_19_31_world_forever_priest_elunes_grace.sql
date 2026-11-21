-- WoW Forever: Elune's Grace 2651 "Reduces the chance you'll be hit by melee and ranged attacks by $s1% for $d or until you are missed $n
-- times." Its 3 charges are spent by melee and ranged attacks that miss the priest; with no row the default hit mask spent them on hits
-- (tooltip; wowsims/forever, MIT, sim/priest/elunes_grace.go). ProcFlags 0 and Charges 0 keep the client's (0x2A8: melee swing, melee
-- ability, ranged auto attack and ranged ability taken; 3 charges). HitMask 0x4 = PROC_HIT_MISS. Safe to run again.
DELETE FROM `spell_proc` WHERE `SpellId` = 2651;
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `SpellFamilyMask3`,
`ProcFlags`, `ProcFlags2`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(2651, 0, 0, 0, 0, 0, 0, 0, 0, 7, 2, 0x4, 0, 0, 0, 100, 0, 0);
