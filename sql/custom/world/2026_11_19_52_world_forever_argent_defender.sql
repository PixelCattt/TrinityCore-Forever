-- WoW Forever: Argent Defender 13243 (aura 17350) procs 0.5 a minute on the attacker's swing interval, rolled by each landed melee hit
-- taken that deals damage, twice that when an Undead strikes, behind the client's 20 s cooldown (wowsims/forever, MIT, docs/evidence
-- EV-0126; the client chance reads 100, so the first hit after each cooldown procced). The row's 1 a minute is the Undead rate; the
-- script classic_spell_item_argent_defender halves it for other attackers. Safe to run again.
DELETE FROM `spell_proc` WHERE `SpellId` = 17350;
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `SpellFamilyMask3`,
`ProcFlags`, `ProcFlags2`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(17350, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 1, 0, 0, 0);
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'classic_spell_item_argent_defender';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (17350, 'classic_spell_item_argent_defender');
