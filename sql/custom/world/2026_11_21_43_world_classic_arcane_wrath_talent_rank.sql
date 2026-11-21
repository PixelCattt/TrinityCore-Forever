-- Classic 1.60 (client 70959): Arcane Wrath 1326079, the rank the Arcane talent teaches, had no script, so its extra spell damage of 5% of
-- maximum mana was missing; the trainer ranks 1326080-1326082 had it (world 2026_10_25_90). Safe to run again.
DELETE FROM `spell_script_names` WHERE `spell_id`=1326079 AND `ScriptName`='classic_spell_mage_arcane_wrath';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(1326079, 'classic_spell_mage_arcane_wrath');
