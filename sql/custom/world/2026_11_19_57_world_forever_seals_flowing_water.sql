-- WoW Forever (wowsims/forever, MIT, tools/database/overrides/spell_overrides.go). Safe to run again.
-- Seal of Light (20165, 20347, 20348, 20349) and Seal of Wisdom (20166, 20356, 20357): 15 procs a minute on the weapon's speed, on landed
-- melee hits (82% a swing on a 3.3 s two-hander, 65% on a 2.6 s one-hander). The client chance reads 100 and no row was set, so every
-- hit procced (EV-0017, EV-0018: one rate fits both weapon speeds). Their judgements keep the client's 50%, as measured.
-- Totem of Flowing Water 23005 (aura 28849): mana on each Lesser Healing Wave cast. The client mask names a bit no spell uses; family 11
-- (shaman) word 0 0x80 is Lesser Healing Wave; cast phase, once a cast (script classic_spell_item_totem_of_flowing_water).
DELETE FROM `spell_proc` WHERE `SpellId` IN (20165, 20347, 20348, 20349, 20166, 20356, 20357, 28849);
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `SpellFamilyMask3`,
`ProcFlags`, `ProcFlags2`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(20165, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 15, 0, 0, 0),
(20347, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 15, 0, 0, 0),
(20348, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 15, 0, 0, 0),
(20349, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 15, 0, 0, 0),
(20166, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 15, 0, 0, 0),
(20356, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 15, 0, 0, 0),
(20357, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 15, 0, 0, 0),
(28849, 0, 11, 0x80, 0, 0, 0, 0x4000, 0, 2, 1, 0, 0, 0, 0, 100, 0, 0);
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'classic_spell_item_totem_of_flowing_water';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (28849, 'classic_spell_item_totem_of_flowing_water');
