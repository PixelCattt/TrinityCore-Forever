-- .deathrecap help (cs_misc.cpp, DeathRecap.cpp). Safe to run again.
DELETE FROM `command` WHERE `name` = 'deathrecap';
INSERT INTO `command` (`name`, `help`) VALUES
('deathrecap', 'Syntax: .deathrecap [$playername]\r\n\r\nShow the last recorded death of the selected player, or of the player named: the frames before the death and the casts leading up to it. Deaths are recorded only on realms with the death recap on (Hardcore); elsewhere the command answers that there is no recording.');
