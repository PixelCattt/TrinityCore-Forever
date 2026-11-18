-- Classic 1.60 (WoW Forever): Scourge Invasion game events (VMaNGOS ids, events 17, 81, 90-99, 129, 130).
-- None of them may start on the calendar: the Scourge Invasion script (classic_world_event_scourge_invasion.cpp) starts and
-- stops them, and only when Classic.ScourgeInvasion = 1 or a GM runs ".scourge on". The script starts them with
-- StartEvent(id, true), which sets the start to "now" and keeps them on until it stops them (length 10 years).
-- Rows 17, 81, 99, 129 and 130 are on dev already (they started about 18 Dec to 8 Jan every year), rows 90-98 are new.

DELETE FROM `game_event` WHERE `eventEntry` IN (17,81,90,91,92,93,94,95,96,97,98,99,129,130);
INSERT INTO `game_event` (`eventEntry`,`start_time`,`end_time`,`occurence`,`length`,`holiday`,`holidayStage`,`WorldStateId`,`description`,`world_event`,`announce`) VALUES
(17,'2037-12-30 00:00:00','2037-12-30 00:00:00',10512000,5256000,0,0,NULL,'Scourge Invasion',0,0),
(81,'2037-12-30 00:00:00','2037-12-30 00:00:00',10512000,5256000,0,0,NULL,'Scourge Invasion - Boss in instance activation',0,0),
(90,'2037-12-30 00:00:00','2037-12-30 00:00:00',10512000,5256000,0,0,NULL,'Scourge Invasion - Attacking Winterspring',0,0),
(91,'2037-12-30 00:00:00','2037-12-30 00:00:00',10512000,5256000,0,0,NULL,'Scourge Invasion - Attacking Tanaris',0,0),
(92,'2037-12-30 00:00:00','2037-12-30 00:00:00',10512000,5256000,0,0,NULL,'Scourge Invasion - Attacking Azshara',0,0),
(93,'2037-12-30 00:00:00','2037-12-30 00:00:00',10512000,5256000,0,0,NULL,'Scourge Invasion - Attacking Blasted Lands',0,0),
(94,'2037-12-30 00:00:00','2037-12-30 00:00:00',10512000,5256000,0,0,NULL,'Scourge Invasion - Attacking Eastern Plaguelands',0,0),
(95,'2037-12-30 00:00:00','2037-12-30 00:00:00',10512000,5256000,0,0,NULL,'Scourge Invasion - Attacking Burning Steppes',0,0),
(96,'2037-12-30 00:00:00','2037-12-30 00:00:00',10512000,5256000,0,0,NULL,'Scourge Invasion - 50 Invasions',0,0),
(97,'2037-12-30 00:00:00','2037-12-30 00:00:00',10512000,5256000,0,0,NULL,'Scourge Invasion - 100 Invasions',0,0),
(98,'2037-12-30 00:00:00','2037-12-30 00:00:00',10512000,5256000,0,0,NULL,'Scourge Invasion - 150 Invasions',0,0),
(99,'2037-12-30 00:00:00','2037-12-30 00:00:00',10512000,5256000,0,0,NULL,'Scourge Invasion - Invasions Done',0,0),
(129,'2037-12-30 00:00:00','2037-12-30 00:00:00',10512000,5256000,0,0,NULL,'Scourge Invasion - Phase 2 - Invasion Stormwind',0,0),
(130,'2037-12-30 00:00:00','2037-12-30 00:00:00',10512000,5256000,0,0,NULL,'Scourge Invasion - Phase 2 - Invasion Undercity',0,0);

-- a saved world event state would override the dates
DELETE FROM `game_event_condition` WHERE `eventEntry` IN (17,81,90,91,92,93,94,95,96,97,98,99,129,130);
DELETE FROM `game_event_prerequisite` WHERE `eventEntry` IN (17,81,90,91,92,93,94,95,96,97,98,99,129,130);
