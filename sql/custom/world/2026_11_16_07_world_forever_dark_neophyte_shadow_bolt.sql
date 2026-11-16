-- Dark Neophyte 267006 (Cult of the Damned, Tirisfal, level 11-12) only meleed: the Forever template came from a creature
-- query with no AI and no spells, and the official beta sniffs never caught one casting. Players report Shadow Bolt on live.
-- The bolt and its timing follow the VMaNGOS level 10-12 cult and Burning Blade casters (Burning Blade Apprentice, Fizzle
-- Darkstorm, Frostmane Shadowcaster): NPC Shadow Bolt 20791, first cast at once, then every 2.4-3.8 s, standing still while
-- it casts (cast flag 64 = combat move off while the cast works, so it closes in when out of range, out of mana or out of sight).
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 267006;
-- Additive only (id 100, delete by comment): a stock TDB row for this entry, if any, is not ours to remove.
DELETE FROM `smart_scripts` WHERE `entryorguid` = 267006 AND `source_type` = 0 AND `comment` = 'Dark Neophyte - In Combat - Cast Shadow Bolt';
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`Difficulties`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`action_param7`,`action_param_string`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_param_string`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(267006,0,100,0,'',0,0,100,0,0,0,2400,3800,0,'',11,20791,64,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Dark Neophyte - In Combat - Cast Shadow Bolt');
