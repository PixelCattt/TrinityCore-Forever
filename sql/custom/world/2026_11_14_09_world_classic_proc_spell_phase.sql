-- Three proc rows had no SpellPhaseMask while their client proc flags need one (SpellMgr::LoadSpellProcs: "Proc will not be triggered"),
-- so every spell or ability event was dropped before the chance roll:
--   400588 Missile Barrage (2026_10_25_93): procs only from spells (client flags: deal harmful spell), so it never procced at all
--          (Discord #general, glacier_07395, 2026-11-14: "I've never triggered it. I've been trying for a long time").
--   20049 Vengeance and 20784 Tamed Pet Passive / Frenzy (2026_10_21_41): only white melee crits counted; crits of spells and
--          abilities (Crusader Strike, Judgement, Exorcism, pet abilities) never did.
-- All three now proc on the hit phase. The rows are otherwise as before. Safe to run again.
DELETE FROM `spell_proc` WHERE `SpellId` IN (400588, 20049, 20784);
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `SpellFamilyMask3`,
`ProcFlags`, `ProcFlags2`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(400588, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x2, 0,   0x2, 0, 0, 100, 0, 0),  -- chance per spell rolled by classic_spell_mage_missile_barrage
(20049,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0x2, 0x2, 0,   0, 0, 0,   0, 0),  -- critical hits only
(20784,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0x2, 0x2, 0,   0, 0, 0,   0, 0);  -- critical hits only
