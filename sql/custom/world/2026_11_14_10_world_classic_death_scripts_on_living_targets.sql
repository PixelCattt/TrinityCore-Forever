-- Two death scripts started their timed action list on the dying creature itself. SmartAI does not update a dead creature, so the
-- list never ran (same fault as Fenrus in 2026_11_14_03). The lists now run on the living creatures VMaNGOS ran them on.
--
-- Rethilgore (3914, Shadowfang Keep): on his death Deathstalker Adamant (3849) and Sorcerer Ashcrombe (3850) in the cells
-- speak up (VMaNGOS EventAI 391403 / generic_scripts 391403). The list now runs on Adamant (closest within 50 yards), says his
-- line on himself and Ashcrombe's 4 s later.
UPDATE `smart_scripts` SET `target_type` = 19, `target_param1` = 3849, `target_param2` = 50, `target_param3` = 0
WHERE `entryorguid` = 3914 AND `source_type` = 0 AND `id` = 2 AND `action_type` = 80;
UPDATE `smart_scripts` SET `target_type` = 1, `target_param1` = 0, `target_param2` = 0, `target_param3` = 0
WHERE `entryorguid` = 950001181 AND `source_type` = 9 AND `id` = 0;
--
-- Ursal the Mauler (2039, Teldrassil): on his death the four Enslaved Druids of the Talon (2852) next to him are freed (VMaNGOS
-- EventAI 203902 starts generic_scripts 46212-46215 on spawns 46212-46215, ours 20046212-20046215): they become Freed Druids
-- (2853), stand up and fly off. Each list now runs on its own druid. The VMaNGOS flight path (start waypoints 2/1) is not in our
-- data, so each druid flies toward the spot the Freed Druid's own script uses (10342.3, 1201.52, 1472.23) and is gone after
-- 30 s (INFERRED; the druids come back enslaved on their next respawn).
UPDATE `smart_scripts` SET `target_type` = 10, `target_param1` = 20046212, `target_param2` = 2852, `target_param3` = 0
WHERE `entryorguid` = 2039 AND `source_type` = 0 AND `id` = 1 AND `action_type` = 80;
UPDATE `smart_scripts` SET `target_type` = 10, `target_param1` = 20046213, `target_param2` = 2852, `target_param3` = 0
WHERE `entryorguid` = 2039 AND `source_type` = 0 AND `id` = 2 AND `action_type` = 80;
UPDATE `smart_scripts` SET `target_type` = 10, `target_param1` = 20046214, `target_param2` = 2852, `target_param3` = 0
WHERE `entryorguid` = 2039 AND `source_type` = 0 AND `id` = 3 AND `action_type` = 80;
UPDATE `smart_scripts` SET `target_type` = 10, `target_param1` = 20046215, `target_param2` = 2852, `target_param3` = 0
WHERE `entryorguid` = 2039 AND `source_type` = 0 AND `id` = 4 AND `action_type` = 80;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (950001158,950001159,950001160,950001161) AND `source_type` = 9 AND `id` IN (10,11,12);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(950001158,9,10,0,0,0,100,0,1000,1000,0,0,60,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Freed Druid of the Talon - Set Fly'),
(950001158,9,11,0,0,0,100,0,0,0,0,0,69,0,0,1,0,0,0,8,0,0,0,10342.3,1201.52,1472.23,0,'Freed Druid of the Talon - Fly away'),
(950001158,9,12,0,0,0,100,0,0,0,0,0,41,30000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Freed Druid of the Talon - Gone'),
(950001159,9,10,0,0,0,100,0,1000,1000,0,0,60,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Freed Druid of the Talon - Set Fly'),
(950001159,9,11,0,0,0,100,0,0,0,0,0,69,0,0,1,0,0,0,8,0,0,0,10342.3,1201.52,1472.23,0,'Freed Druid of the Talon - Fly away'),
(950001159,9,12,0,0,0,100,0,0,0,0,0,41,30000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Freed Druid of the Talon - Gone'),
(950001160,9,10,0,0,0,100,0,1000,1000,0,0,60,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Freed Druid of the Talon - Set Fly'),
(950001160,9,11,0,0,0,100,0,0,0,0,0,69,0,0,1,0,0,0,8,0,0,0,10342.3,1201.52,1472.23,0,'Freed Druid of the Talon - Fly away'),
(950001160,9,12,0,0,0,100,0,0,0,0,0,41,30000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Freed Druid of the Talon - Gone'),
(950001161,9,10,0,0,0,100,0,1000,1000,0,0,60,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Freed Druid of the Talon - Set Fly'),
(950001161,9,11,0,0,0,100,0,0,0,0,0,69,0,0,1,0,0,0,8,0,0,0,10342.3,1201.52,1472.23,0,'Freed Druid of the Talon - Fly away'),
(950001161,9,12,0,0,0,100,0,0,0,0,0,41,30000,0,0,0,0,0,1,0,0,0,0,0,0,0,'Freed Druid of the Talon - Gone');
