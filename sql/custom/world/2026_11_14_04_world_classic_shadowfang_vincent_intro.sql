-- Shadowfang Keep: in Arugal's courtyard intro Deathstalker Vincent (4444) stays standing (Discord, voldemargreed "bugs 5",
-- 2026-11-14: "some kind of scene is supposed to play here, but it's missing"). VMaNGOS generic script 10000 has Arugal kill
-- him at "Say Text 4" (command 28, stand state 7 on the closest 4444 within 20 yards); the conversion to the timed action list
-- 950001264 dropped that one step. It goes back in after the fourth line, before the Dimensional Portal cast, which keeps its
-- 5 s delay. Safe to run again.
DELETE FROM `smart_scripts` WHERE `entryorguid` = 950001264 AND `source_type` = 9 AND `id` IN (9,10);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(950001264,9,9,0,0,0,100,0,0,0,0,0,90,7,0,0,0,0,0,19,4444,20,0,0,0,0,0,'SFK Intro - Deathstalker Vincent Set Stand State to Dead (VMaNGOS generic_scripts 10000)'),
(950001264,9,10,0,0,0,100,0,5000,5000,0,0,11,6700,0,0,0,0,0,1,0,0,0,0,0,0,0,'VMaNGOS generic_scripts 10000');
