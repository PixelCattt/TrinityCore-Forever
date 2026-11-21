-- .gm combatlog help (cs_gm.cpp). Safe to run again.
DELETE FROM `command` WHERE `name` = 'gm combatlog';
INSERT INTO `command` (`name`, `help`) VALUES
('gm combatlog', 'Syntax: .gm combatlog [group|off]\r\n\r\nReceive the combat log around the selected unit from any distance, as if you stood next to it. With group, around every member of the selected player''s group. off stops it. One watch per GM; it also ends when you log out. Nobody gets anything extra until a GM starts a watch.');
