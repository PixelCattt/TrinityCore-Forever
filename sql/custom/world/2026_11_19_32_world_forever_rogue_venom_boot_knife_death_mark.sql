-- WoW Forever rogue talents that did nothing (bare dummies): Venom 1329328 and Boot Knife 1329286 on Shank, and Death Mark (finisher).
-- C++: Custom/Classic/world/talents/classic_rogue_abilities.cpp (classic_spell_rog_shank_talents, classic_spell_rog_death_mark).
-- Death Mark stores the rogue's damage on the marked target through its own proc flags (the client's); the row keeps every damaging
-- hit and tick the target takes heard. Safe to run again.
DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('classic_spell_rog_shank_talents','classic_spell_rog_death_mark');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(1329283,'classic_spell_rog_shank_talents'),(1329549,'classic_spell_rog_shank_talents'),
(1316709,'classic_spell_rog_death_mark'),(1325756,'classic_spell_rog_death_mark'),(1325757,'classic_spell_rog_death_mark'),(1325758,'classic_spell_rog_death_mark');
DELETE FROM `spell_proc` WHERE `SpellId` IN (1316709, 1325756, 1325757, 1325758);
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `SpellFamilyMask3`,
`ProcFlags`, `ProcFlags2`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(1316709, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 100, 0, 0),
(1325756, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 100, 0, 0),
(1325757, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 100, 0, 0),
(1325758, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 100, 0, 0);
