-- Missile Barrage 400589 (mage, glacier, Discord 17 Nov: "the casting time is not reduced by 50%, and a missile is fired every 0.5 seconds"
-- does not happen). The buff was used up when Arcane Missiles was cast (2026_11_12_17: phase 1, cast), and the server works out a channel's
-- length only after that, so its -50% duration modifier was already gone. Now it is used up when the channel hits (phase 2), after the
-- length and the missile period are set. The faster missiles come from classic_spell_mage_arcane_missiles_barrage, which reads the
-- buff's dummy effect 1 (-500 ms) into the channel's period, bound here to every Arcane Missiles rank of the client (class mask 0x800).
UPDATE `spell_proc` SET `SpellPhaseMask` = 2 WHERE `SpellId` = 400589 AND `SpellPhaseMask` = 1;
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'classic_spell_mage_arcane_missiles_barrage';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(5143, 'classic_spell_mage_arcane_missiles_barrage'),
(5144, 'classic_spell_mage_arcane_missiles_barrage'),
(5145, 'classic_spell_mage_arcane_missiles_barrage'),
(8416, 'classic_spell_mage_arcane_missiles_barrage'),
(8417, 'classic_spell_mage_arcane_missiles_barrage'),
(10211, 'classic_spell_mage_arcane_missiles_barrage'),
(10212, 'classic_spell_mage_arcane_missiles_barrage'),
(25345, 'classic_spell_mage_arcane_missiles_barrage');
