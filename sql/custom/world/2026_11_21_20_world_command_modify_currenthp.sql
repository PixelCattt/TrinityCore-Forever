-- .modify currenthp help (cs_modify.cpp). Safe to run again.
DELETE FROM `command` WHERE `name` = 'modify currenthp';
INSERT INTO `command` (`name`, `help`) VALUES
('modify currenthp', 'Syntax: .modify currenthp #hp\r\n\r\nSet only the current health of the selected unit (player or creature) to #hp. Its maximum health stays as it is. #hp must be between 1 and the maximum.');
