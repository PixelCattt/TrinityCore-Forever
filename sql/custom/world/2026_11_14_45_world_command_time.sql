-- .time help (cs_misc.cpp, DayCycle.h). Safe to run again.
DELETE FROM `command` WHERE `name` IN ('time', 'time day', 'time night', 'time auto');
INSERT INTO `command` (`name`, `help`) VALUES
('time', 'Syntax: .time\r\n\r\nShow your sky: the realm''s day and night, or your own noon or midnight.'),
('time day', 'Syntax: .time day\r\n\r\nKeep noon for your character, wherever you go. Only you see it; it is kept across logins.'),
('time night', 'Syntax: .time night\r\n\r\nKeep midnight for your character, wherever you go. Only you see it; it is kept across logins.'),
('time auto', 'Syntax: .time auto\r\n\r\nYour sky follows the realm''s day and night again.');
