-- Item procs and set bonuses whose second effect (a dummy) nothing read. C++: Custom/Classic/world/classic_spell_scripts.cpp and
-- talents/classic_rogue_abilities.cpp (Clean Escape, in classic_spell_rog_vanish). Safe to run again.
-- Fatal Wound / Wound: more damage to a target below the stated health.
-- Drain Life, Corpse Eater, Smite, Lightning Bolt, Holy Cleaver, Blazewind Blast: x times as much damage to one kind of enemy.
-- Toofbreak: x times as much if the target faces you. Rend: x times as much to Dragonkin / if applied from behind.
-- Pendulum of Doom: each swing alternates the attack speed (every swing, landed or not).
DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('classic_spell_item_fatal_wound','classic_spell_item_versus_bonus',
    'classic_spell_item_toofbreak','classic_spell_item_rend_bonus','classic_spell_item_pendulum_of_doom');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(10373,'classic_spell_item_fatal_wound'),(16549,'classic_spell_item_fatal_wound'),(18107,'classic_spell_item_fatal_wound'),
(18206,'classic_spell_item_fatal_wound'),(1300185,'classic_spell_item_fatal_wound'),
(16414,'classic_spell_item_versus_bonus'),(1299869,'classic_spell_item_versus_bonus'),(1299631,'classic_spell_item_versus_bonus'),
(1292851,'classic_spell_item_versus_bonus'),(1293787,'classic_spell_item_versus_bonus'),(1282503,'classic_spell_item_versus_bonus'),
(1320269,'classic_spell_item_toofbreak'),
(14118,'classic_spell_item_rend_bonus'),(1300787,'classic_spell_item_rend_bonus'),
(1293881,'classic_spell_item_pendulum_of_doom');

-- Pendulum of Doom: melee swings, any outcome (normal, crit, miss, dodge, parry, block, absorb, full block).
DELETE FROM `spell_proc` WHERE `SpellId` = 1293881;
INSERT INTO `spell_proc` (`SpellId`,`SchoolMask`,`SpellFamilyName`,`SpellFamilyMask0`,`SpellFamilyMask1`,`SpellFamilyMask2`,`SpellFamilyMask3`,
    `ProcFlags`,`ProcFlags2`,`SpellTypeMask`,`SpellPhaseMask`,`HitMask`,`AttributesMask`,`DisableEffectsMask`,`ProcsPerMinute`,`Chance`,
    `Cooldown`,`Charges`) VALUES
(1293881,0,0,0,0,0,0,0x4,0,0,0,0x2477,0,0,0,100,0,0);
