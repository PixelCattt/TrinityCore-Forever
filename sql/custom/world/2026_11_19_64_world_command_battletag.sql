-- .battletag help (cs_battlenet_account.cpp). Safe to run again.
DELETE FROM `command` WHERE `name` = 'battletag';
INSERT INTO `command` (`name`, `help`) VALUES
('battletag', 'Syntax: .battletag [$name]\r\n\r\nShow your BattleTag, or pick a new name for it: 2-12 letters and digits, starting with a letter. A free number is added, like Name#1234. Battle.net friends see and whisper you by it.');
