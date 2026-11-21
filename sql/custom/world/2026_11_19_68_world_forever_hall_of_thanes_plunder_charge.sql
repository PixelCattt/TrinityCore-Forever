-- Hall of Thanes: Plunder (261311) charges a player who is away from him.
-- Live combat logs (EG Link, players on the live realm, builds 70205-70959) show Plunder casting Charge (22911) twice; our
-- script never did. Data from Efficient Games (https://efficient.games), licensed under CC BY 4.0.
-- Two casts in all the logged fights means it does not come every fight, so it is cast only on a target 8-25 y away, like the
-- other creatures in our world that use this spell (INFERRED: the range gate and the 15-20 s repeat).
DELETE FROM `smart_scripts` WHERE `entryorguid` = 261311 AND `source_type` = 0 AND `id` = 3;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`Difficulties`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`action_param7`,`action_param_string`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_param_string`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(261311,0,3,0,'',9,0,100,0,8,25,15000,20000,0,'',11,22911,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Plunder - Target 8-25 y away - Cast 22911 (Charge) - live combat logs (EG Link): 2 casts');
