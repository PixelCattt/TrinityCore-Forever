-- Classic: Loatheb's Corrupted Mind (29201) gives each healer 29185 / 29194 / 29196 / 29198 (proc trigger, 120 s), whose next heal casts the
-- 60 s lock 29184 / 29195 / 29197 / 29199 (aura 112, misc 4327: Spell::CheckCast fizzles healing spells under it). With no spell_proc row the
-- client's proc flags applied, and any helpful spell set off the lock: naxx_loatheb af39 (1119) healers were locked by Inner Focus, Inner Fire,
-- Resurrection and buffs, cast 2 heals in 4 minutes and the raid died with the tanks at 16-42%. Only a heal that lands sets it off now
-- (VMaNGOS restricts the same procs to each class's healing spells). Safe to run again.
DELETE FROM `spell_proc` WHERE `SpellId` IN (29185, 29194, 29196, 29198);
INSERT INTO `spell_proc` (`SpellId`,`SchoolMask`,`SpellFamilyName`,`SpellFamilyMask0`,`SpellFamilyMask1`,`SpellFamilyMask2`,`SpellFamilyMask3`,`ProcFlags`,`ProcFlags2`,`SpellTypeMask`,`SpellPhaseMask`,`HitMask`,`AttributesMask`,`DisableEffectsMask`,`ProcsPerMinute`,`Chance`,`Cooldown`,`Charges`) VALUES
-- ProcFlags 0x4400: done helpful spell (magic or no damage class); SpellTypeMask 2: heal; SpellPhaseMask 2: on hit.
(29185,0,0,0,0,0,0,17408,0,2,2,0,0,0,0,100,0,0),
(29194,0,0,0,0,0,0,17408,0,2,2,0,0,0,0,100,0,0),
(29196,0,0,0,0,0,0,17408,0,2,2,0,0,0,0,100,0,0),
(29198,0,0,0,0,0,0,17408,0,2,2,0,0,0,0,100,0,0);
