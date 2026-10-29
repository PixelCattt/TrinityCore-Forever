-- WoW Forever client 1.60.1.70634 (Battle.net update of 2026-10-27), and the builds before it: 70630 (2026-10-26) and 70532.
-- All of them use the same login and world protocol as 70450 (ClassicOpcodes checks are "70425 or later"), and 70634 only
-- changed UI data. The Forever realms 70-73 move to 70634. To let older clients keep joining them, list those builds in
-- bnetserver.conf: Realm.AlsoAcceptBuilds = "70630,70532,70450".
-- No auth key is known for 70532, 70630 or 70634: keep Network.SkipBuildAuthKeyCheck = 1 in worldserver.conf.
-- bnetserver and worldserver read build_info only at startup: restart both after this update. Safe to run again.
DELETE FROM `build_info` WHERE `build` IN (70532,70630,70634);
INSERT INTO `build_info` (`build`,`majorVersion`,`minorVersion`,`bugfixVersion`,`hotfixVersion`) VALUES
(70532,1,60,1,NULL),
(70630,1,60,1,NULL),
(70634,1,60,1,NULL);

UPDATE `realmlist` SET `gamebuild`=70634 WHERE `id` IN (70,71,72,73) AND `gamebuild` IN (70450,70532,70630);
