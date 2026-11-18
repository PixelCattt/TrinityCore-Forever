-- .bug help (cs_misc.cpp). Safe to run again.
DELETE FROM `command` WHERE `name` = 'bug';
INSERT INTO `command` (`name`, `help`) VALUES
('bug', 'Syntax: .bug $text\r\n\r\nReport a bug. Your zone, position, target and quest log are saved with your text, so we can find it. Staff read the reports with .ticket bug list.');
