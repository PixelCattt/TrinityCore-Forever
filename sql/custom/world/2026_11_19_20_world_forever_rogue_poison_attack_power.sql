-- WoW Forever: Instant Poison adds 1% and Deadly Poison 0.9% (over its four ticks, per stack) of the rogue's melee attack power.
-- Source: wowsims/forever (MIT) docs/evidence EV-0086, a tester's in-game reading. The client rows state no attack power share.
-- C++: Custom/Classic/world/talents/classic_rogue_abilities.cpp. Safe to run again.
DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('classic_spell_rog_instant_poison_attack_power','classic_spell_rog_deadly_poison_attack_power');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(8680,'classic_spell_rog_instant_poison_attack_power'),(8685,'classic_spell_rog_instant_poison_attack_power'),
(8689,'classic_spell_rog_instant_poison_attack_power'),(11335,'classic_spell_rog_instant_poison_attack_power'),
(11336,'classic_spell_rog_instant_poison_attack_power'),(11337,'classic_spell_rog_instant_poison_attack_power'),
(2818,'classic_spell_rog_deadly_poison_attack_power'),(2819,'classic_spell_rog_deadly_poison_attack_power'),
(11353,'classic_spell_rog_deadly_poison_attack_power'),(11354,'classic_spell_rog_deadly_poison_attack_power'),
(25349,'classic_spell_rog_deadly_poison_attack_power');
