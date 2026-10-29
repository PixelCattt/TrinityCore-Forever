-- WoW Forever client 1.60.1.70658 (Battle.net update of 2026-10-28). Same game data and protocol as 70634: the update
-- only changed client-side realm/region config, name filters and some art. The Forever realms 70-73 move to 70658.
-- To let older clients keep joining them, list those builds in bnetserver.conf: Realm.AlsoAcceptBuilds = "70634,70630,70532".
-- No auth key is known for 70658: keep Network.SkipBuildAuthKeyCheck = 1 in worldserver.conf.
-- bnetserver and worldserver read build_info only at startup: restart both after this update. Safe to run again.
DELETE FROM `build_info` WHERE `build`=70658;
INSERT INTO `build_info` (`build`,`majorVersion`,`minorVersion`,`bugfixVersion`,`hotfixVersion`) VALUES
(70658,1,60,1,NULL);

UPDATE `realmlist` SET `gamebuild`=70658 WHERE `id` IN (70,71,72,73) AND `gamebuild` IN (70450,70532,70630,70634);
