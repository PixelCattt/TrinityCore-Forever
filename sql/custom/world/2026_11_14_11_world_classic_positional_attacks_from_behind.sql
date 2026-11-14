-- Classic positional attacks: Backstab, Ambush, Shred, Ravage and Pounce say "Must be behind the target" in the client, but nothing
-- told the server, so they worked from the front. 0x20000 = SPELL_ATTR0_CU_REQ_CASTER_BEHIND_TARGET (Spell::CheckCast -> NOT_BEHIND).
-- Ranks are the trainer ranks in SkillLineAbility. Existing custom bits are kept.
INSERT INTO `spell_custom_attr` (`entry`, `attributes`) VALUES
-- Backstab
(53, 0x20000), (2589, 0x20000), (2590, 0x20000), (2591, 0x20000), (8721, 0x20000), (11279, 0x20000), (11280, 0x20000), (11281, 0x20000), (25300, 0x20000),
-- Ambush
(8676, 0x20000), (8724, 0x20000), (8725, 0x20000), (11267, 0x20000), (11268, 0x20000), (11269, 0x20000),
-- Shred
(5221, 0x20000), (6800, 0x20000), (8992, 0x20000), (9829, 0x20000), (9830, 0x20000),
-- Ravage
(6785, 0x20000), (6787, 0x20000), (9866, 0x20000), (9867, 0x20000),
-- Pounce
(9005, 0x20000), (9823, 0x20000), (9827, 0x20000)
ON DUPLICATE KEY UPDATE `attributes` = `attributes` | 0x20000;

-- Garrote is behind-only too, except with Dirty Deeds (14082), so it is checked in spell_rog_classic_garrote_positional.
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_rog_classic_garrote_positional';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(703, 'spell_rog_classic_garrote_positional'),
(8631, 'spell_rog_classic_garrote_positional'),
(8632, 'spell_rog_classic_garrote_positional'),
(8633, 'spell_rog_classic_garrote_positional'),
(11289, 'spell_rog_classic_garrote_positional'),
(11290, 'spell_rog_classic_garrote_positional');
