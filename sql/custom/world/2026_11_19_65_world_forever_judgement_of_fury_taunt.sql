-- Judgement of Fury (Seal of Fury): "taunts the target to attack you for 4 sec". The script only matched the paladin's threat to the
-- top of the list, so a mob already on someone else stayed there. 9970901 is the real 4 sec taunt (SPELL_AURA_MOD_TAUNT) that the
-- judgement script now puts on the target, the same way Taunt and Growl work. Hidden, not logged, cannot miss.
DELETE FROM `serverside_spell` WHERE `Id` = 9970901;
DELETE FROM `serverside_spell_effect` WHERE `SpellID` = 9970901;
INSERT INTO `serverside_spell` (`Id`, `DifficultyID`, `Attributes`, `AttributesEx3`, `CastingTimeIndex`, `ProcChance`, `DurationIndex`, `RangeIndex`, `EquippedItemClass`, `SpellName`, `SpellFamilyName`, `SchoolMask`) VALUES
(9970901, 0, 384, 262144, 1, 0, 35, 13, -1, 'Judgement of Fury', 10, 2);
INSERT INTO `serverside_spell_effect` (`SpellID`, `EffectIndex`, `DifficultyID`, `Effect`, `EffectAura`, `EffectBasePoints`, `EffectMiscValue1`, `ImplicitTarget1`) VALUES
(9970901, 0, 0, 6, 11, 0, 0, 6);
