-- Clearcasting (16870, from Omen of Clarity 16864): in the Classic client it makes the next damage spell, heal or offensive
-- ability free and is used up by it (SpellAuraOptions ProcCharges 1, ProcTypeMask 0x15550: melee, ranged, helpful and harmful
-- abilities and spells). The retail row from 2024_08_20_00 is for Restoration's Clearcasting and drops the charge on a heal only,
-- so a cat's Shred, Claw and Rip were free and left the charge up for the full 15 s (6_1_8_8_1, Discord Bugs 1.1: "sometimes,
-- when a fight starts, my energy simply doesn't decrease when using abilities"). Same shape as the mage's Clearcasting 12536.
DELETE FROM `spell_proc` WHERE `SpellId`=16870;
INSERT INTO `spell_proc` (`SpellId`,`SchoolMask`,`SpellFamilyName`,`SpellFamilyMask0`,`SpellFamilyMask1`,`SpellFamilyMask2`,`SpellFamilyMask3`,`ProcFlags`,`ProcFlags2`,`SpellTypeMask`,`SpellPhaseMask`,`HitMask`,`AttributesMask`,`DisableEffectsMask`,`ProcsPerMinute`,`Chance`,`Cooldown`,`Charges`) VALUES
(16870,0x00,0,0x00000000,0x00000000,0x00000000,0x00000000,0x15550,0x0,0x7,0x3,0x0,0x8,0x0,0,0,0,1); -- Clearcasting
