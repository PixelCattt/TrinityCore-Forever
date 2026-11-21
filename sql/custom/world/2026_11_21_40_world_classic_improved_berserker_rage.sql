-- Classic 1.60 (client 70959): warrior talent Improved Berserker Rage 20500 gives its rage and its chance to remove movement impairing
-- effects when Berserker Rage is used (classic_talents_warrior_rogue_hunter.cpp). Both talent effects are dummies without a triggered spell,
-- so it did nothing and proc'd on every spell. Safe to run again.
DELETE FROM `spell_script_names` WHERE `ScriptName`='classic_spell_warr_improved_berserker_rage';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(20500, 'classic_spell_warr_improved_berserker_rage');
