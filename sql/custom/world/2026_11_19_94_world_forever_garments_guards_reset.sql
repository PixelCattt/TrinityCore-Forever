-- Garments of the Light / of the Moon / of Darkness (priest quests 5621, 5624, 5625, 5648, 5650): after one priest healed a guard
-- (Guard Roberts 12423, Mountaineer Dolf 12427, Deathguard Kel 12428, Sentinel Shaya 12429, Grunt Kor'ja 12430), the guard
-- never got ready again, so every later Lesser Heal did nothing and the quest could not be done until the server restarted
-- (Кожан, Discord 19 Nov: "healing the guard doesn't count").
-- Cause: the VMaNGOS port kept the guard's phases (1 waiting for Lesser Heal Rank 2, 2 waiting for Power Word: Fortitude,
-- 3 done) and the script on waypoint 2 of his exit path that sets phase 1 and despawns him (he respawns ready), but dropped the
-- step that starts that path after the Fortitude. So he stayed in phase 3 after the first priest, and in phase 2 if a priest
-- healed him and left without the Fortitude.
-- Fix: the Fortitude script ends by walking him off on his path again; and if no Fortitude comes within 2 minutes of the heal
-- he waits for a heal again. That 2 minutes is a timed event (not a wait inside the heal script, which would block the
-- Fortitude script from starting) and only acts while he is still waiting for the Fortitude (phase 2). The Fortitude
-- reaction also calls its script with override on, so a running heal script can never block it.
-- Safe to run again.
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `id` = 101 AND `entryorguid` IN (12423,12427,12428,12429,12430);
DELETE FROM `smart_scripts` WHERE `source_type` = 9 AND ((`entryorguid` IN (950001284,950001286,950001288,950001290,950001292) AND `id` = 2) OR (`entryorguid` IN (950001285,950001287,950001289,950001291,950001293) AND `id` = 5));
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`Difficulties`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`action_param7`,`action_param_string`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_param_string`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(950001284,9,2,0,'',0,0,100,0,0,0,0,0,0,'',67,1,120000,120000,0,0,100,0,'',1,0,0,0,0,'',0,0,0,0,'Guard Roberts - Healed - Start a 2 min timer for the Fortitude'),
(12423,0,101,0,'',59,2,100,0,1,0,0,0,0,'',22,1,0,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'Guard Roberts - 2 min after the heal and still no Fortitude - Back to waiting for a heal (Set Phase 1)'),
(950001285,9,5,0,'',0,0,100,0,2000,2000,0,0,0,'',53,1,810124230,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'Guard Roberts - Fortified - Walk off on his path (its waypoint 2 resets him and despawns)'),
(950001286,9,2,0,'',0,0,100,0,0,0,0,0,0,'',67,1,120000,120000,0,0,100,0,'',1,0,0,0,0,'',0,0,0,0,'Mountaineer Dolf - Healed - Start a 2 min timer for the Fortitude'),
(12427,0,101,0,'',59,2,100,0,1,0,0,0,0,'',22,1,0,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'Mountaineer Dolf - 2 min after the heal and still no Fortitude - Back to waiting for a heal (Set Phase 1)'),
(950001287,9,5,0,'',0,0,100,0,2000,2000,0,0,0,'',53,1,810124270,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'Mountaineer Dolf - Fortified - Walk off on his path (its waypoint 2 resets him and despawns)'),
(950001288,9,2,0,'',0,0,100,0,0,0,0,0,0,'',67,1,120000,120000,0,0,100,0,'',1,0,0,0,0,'',0,0,0,0,'Deathguard Kel - Healed - Start a 2 min timer for the Fortitude'),
(12428,0,101,0,'',59,2,100,0,1,0,0,0,0,'',22,1,0,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'Deathguard Kel - 2 min after the heal and still no Fortitude - Back to waiting for a heal (Set Phase 1)'),
(950001289,9,5,0,'',0,0,100,0,2000,2000,0,0,0,'',53,1,810124280,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'Deathguard Kel - Fortified - Walk off on his path (its waypoint 2 resets him and despawns)'),
(950001290,9,2,0,'',0,0,100,0,0,0,0,0,0,'',67,1,120000,120000,0,0,100,0,'',1,0,0,0,0,'',0,0,0,0,'Sentinel Shaya - Healed - Start a 2 min timer for the Fortitude'),
(12429,0,101,0,'',59,2,100,0,1,0,0,0,0,'',22,1,0,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'Sentinel Shaya - 2 min after the heal and still no Fortitude - Back to waiting for a heal (Set Phase 1)'),
(950001291,9,5,0,'',0,0,100,0,2000,2000,0,0,0,'',53,1,810124290,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'Sentinel Shaya - Fortified - Walk off on his path (its waypoint 2 resets him and despawns)'),
(950001292,9,2,0,'',0,0,100,0,0,0,0,0,0,'',67,1,120000,120000,0,0,100,0,'',1,0,0,0,0,'',0,0,0,0,'Grunt Kor''ja - Healed - Start a 2 min timer for the Fortitude'),
(12430,0,101,0,'',59,2,100,0,1,0,0,0,0,'',22,1,0,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'Grunt Kor''ja - 2 min after the heal and still no Fortitude - Back to waiting for a heal (Set Phase 1)'),
(950001293,9,5,0,'',0,0,100,0,2000,2000,0,0,0,'',53,1,810124300,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'Grunt Kor''ja - Fortified - Walk off on his path (its waypoint 2 resets him and despawns)');
UPDATE `smart_scripts` SET `action_param3` = 1 WHERE `source_type` = 0 AND `action_type` = 80 AND `action_param1` IN (950001285,950001287,950001289,950001291,950001293);
