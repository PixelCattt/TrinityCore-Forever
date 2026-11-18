-- WoW Forever client 1.60.1.70959 (Battle.net update of 17 November 2026, first seen 18:25Z, US first).
-- Realm 70 stays on gamebuild 70707. A 70959 client sees and joins it when bnetserver.conf and worldserver.conf have 70959 in
-- Realm.AlsoAcceptBuilds (the repack's start script writes it from repack\client-builds.txt); this row lets bnetserver and worldserver
-- accept that client. Its message numbers are handled per connection: 70959 clients get the 70790 numbering
-- (Classic.Build70790.FirstBuild = 70790 covers every later build) until a 70959 change is known.
-- No auth key is known for 70959: keep Network.SkipBuildAuthKeyCheck = 1 in worldserver.conf.
-- bnetserver and worldserver read build_info only at startup: restart both once after this update. Safe to run again.
DELETE FROM `build_info` WHERE `build`=70959;
INSERT INTO `build_info` (`build`,`majorVersion`,`minorVersion`,`bugfixVersion`,`hotfixVersion`) VALUES
(70959,1,60,1,NULL);
