-- The Glowing Shard (6981) could not be handed in, and Shenthul's gossip in Orgrimmar summoned the Counterattack event.
-- 2026_11_12_32_world_classic_counterattack_event.sql wrote Counterattack!'s "Warlord Krom'zar comes" and "Counterattack over" lists
-- into the timed action lists 950000302 and 950000303, which were already in use:
--   950000302: Shenthul (3401) gossip 521/2 -> cast 21100 (VMaNGOS gossip_scripts 16)
--   950000303: Sputtervalve (3442) gossip 21/1 -> complete The Glowing Shard 6981 (VMaNGOS gossip_scripts 21)
-- So talking to Sputtervalve ran "Counterattack over" instead of finishing the quest, and Falla Sagewind never took it.
-- The two Counterattack lists move to 950001417 and 950001418 and the two old lists get their rows back.
-- Safe to run again.

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (950000302,950000303,950001417,950001418) AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`Difficulties`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`action_param7`,`action_param_string`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_param_string`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(950001417,9,0,0,'',0,0,100,0,0,0,0,0,0,'',12,9456,1,600000,0,0,0,0,'',8,0,0,0,0,'',-297.624,-1839.22,93.8783,4.81711,'Counterattack - Summon Warlord Krom''zar (VMaNGOS generic_scripts 402102)'),
(950001417,9,1,0,'',0,0,100,0,1000,1000,0,0,0,'',12,9524,1,600000,0,0,0,0,'',8,0,0,0,0,'',-293.931,-1837.24,93.4963,4.43314,'Counterattack - Summon Kolkar Invader with Krom''zar'),
(950001417,9,2,0,'',0,0,100,0,0,0,0,0,0,'',12,9523,1,600000,0,0,0,0,'',8,0,0,0,0,'',-297.878,-1834.64,94.2335,4.79965,'Counterattack - Summon Kolkar Stormseer with Krom''zar'),
(950001418,9,0,0,'',0,0,100,0,0,0,0,0,0,'',74,2,0,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'Counterattack over - Remove the time limit'),
(950001418,9,1,0,'',0,0,100,0,0,0,0,0,0,'',63,1,0,1,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'Counterattack over - Reset Kolkar kill counter'),
(950001418,9,2,0,'',0,0,100,0,0,0,0,0,0,'',1,2,0,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'Counterattack over - Regthar Deathgate - Say Line 2 (VMaNGOS generic_scripts 402106)'),
(950001418,9,3,0,'',0,0,100,0,0,0,0,0,0,'',41,3000,0,0,0,0,0,0,'',11,9524,200,0,0,'',0,0,0,0,'Counterattack over - Despawn the event''s Kolkar Invaders (VMaNGOS generic_scripts 402105)'),
(950001418,9,4,0,'',0,0,100,0,0,0,0,0,0,'',41,3000,0,0,0,0,0,0,'',11,9523,200,0,0,'',0,0,0,0,'Counterattack over - Despawn the event''s Kolkar Stormseers (VMaNGOS generic_scripts 402105)'),
(950001418,9,5,0,'',0,0,100,0,0,0,0,0,0,'',41,3000,0,0,0,0,0,0,'',11,9457,200,0,0,'',0,0,0,0,'Counterattack over - Despawn the event''s Horde Defenders (VMaNGOS generic_scripts 402105)'),
(950001418,9,6,0,'',0,0,100,0,0,0,0,0,0,'',41,3000,0,0,0,0,0,0,'',11,9458,200,0,0,'',0,0,0,0,'Counterattack over - Despawn the event''s Darkspear Hunters (VMaNGOS generic_scripts 402105)'),
(950001418,9,7,0,'',0,0,100,0,1000,1000,0,0,0,'',4,6199,0,0,0,0,0,0,'',10,20013100,9990,0,0,'',0,0,0,0,'Counterattack over - Lanti''gah - Play Sound'),
(950001418,9,8,0,'',0,0,100,0,0,0,0,0,0,'',82,1,0,0,0,0,0,0,'',10,20013100,9990,0,0,'',0,0,0,0,'Counterattack over - Lanti''gah - Add Gossip Flag'),
(950001418,9,9,0,'',0,0,100,0,1000,1000,0,0,0,'',45,1,2,0,0,0,0,0,'',10,20013100,9990,0,0,'',0,0,0,0,'Counterattack over - Lanti''gah - Set Data 1 2 (go home)'),
(950000302,9,0,0,'',0,0,100,0,0,0,0,0,0,'',11,21100,0,0,0,0,0,0,'',7,0,0,0,0,'',0,0,0,0,'VMaNGOS gossip_scripts 16'),
(950000303,9,0,0,'',0,0,100,0,0,0,0,0,0,'',152,6981,0,0,0,0,0,0,'',7,0,0,0,0,'',0,0,0,0,'VMaNGOS gossip_scripts 21');

UPDATE `smart_scripts` SET `action_param1` = 950001417 WHERE `entryorguid` = 3389 AND `source_type` = 0 AND `id` = 13 AND `action_type` = 80;
UPDATE `smart_scripts` SET `action_param1` = 950001418 WHERE `entryorguid` = 3389 AND `source_type` = 0 AND `id` IN (14,15) AND `action_type` = 80;
