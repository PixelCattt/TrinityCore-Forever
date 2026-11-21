-- Unsealed Wrath (1310735, Forever paladin talent; chris04666, Discord 2026-11-19: "does nothing, no buff shows when attacking").
-- classic_spell_pal_unsealed_wrath (2026_11_05_03) stores the active seal as its Echo aura on each melee swing and replays the stored
-- seals on a seal swap, but the live spell data gives the talent only a spell modifier effect and no proc data, so the server has no
-- proc entry for it: an aura without one never procs (Aura::GetProcEffectMask), and the script never ran. This row makes it proc on
-- the paladin's own melee swings; the script's CheckProc keeps it to main-hand auto attacks on a living target. Safe to run again.
DELETE FROM `spell_proc` WHERE `SpellId` = 1310735;
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `SpellFamilyMask3`,
`ProcFlags`, `ProcFlags2`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(1310735, 0, 0, 0, 0, 0, 0, 0x4, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0);
