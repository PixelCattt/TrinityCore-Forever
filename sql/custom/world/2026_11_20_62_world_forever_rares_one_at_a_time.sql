-- Forever rares: one at a time, and not back two minutes after the kill (Sagiroth, Discord 2026-11-20, Decrepit Harvester).
-- The rares added from the 70170/70124 sniffs kept the sniff loader's default respawn of 120 s, and a sniff gives every
-- sighting of a rare its own spawn row, so Decrepit Harvester 276061 (3 rows within 30 yards, Tirisfal) and Blightsculler
-- 271080 (3 rows, Tirisfal) could be up three at once, each back two minutes after a kill. Classification 4 (rare) is the
-- client's own creature query value.
-- Each of the two now has one pool over its three spots (one up at a time, spot picked at each respawn). Respawn 1 hour for
-- the six sniff rares that still had 120 s: INFERRED, no source we have gives their respawn; 1 hour is what the classic
-- Tirisfal rares around them use (Muad, Bayne, Farmer Solliden) and what The Condemned One 276089 already has.

DELETE FROM `pool_members` WHERE `type` = 0 AND `spawnId` IN (21200401,21200402,21200403,21200488,21200489,21200490);
DELETE FROM `pool_template` WHERE `entry` IN (2710800,2760610);
INSERT INTO `pool_template` (`entry`,`max_limit`,`description`) VALUES
(2710800,1,'Blightsculler (271080) - rare, one of 3 spots'),
(2760610,1,'Decrepit Harvester (276061) - rare, one of 3 spots');
INSERT INTO `pool_members` (`type`,`spawnId`,`poolSpawnId`,`chance`,`description`) VALUES
(0,21200401,2710800,0,'Blightsculler spot 1'),
(0,21200402,2710800,0,'Blightsculler spot 2'),
(0,21200403,2710800,0,'Blightsculler spot 3'),
(0,21200488,2760610,0,'Decrepit Harvester spot 1'),
(0,21200489,2760610,0,'Decrepit Harvester spot 2'),
(0,21200490,2760610,0,'Decrepit Harvester spot 3');

-- Tel'daeor the Stormspeaker 259385, Mystmane 259388, Blightsculler 271080, Coldrasp 274300, Decrepit Harvester 276061,
-- Thornstarter Igleg 276108
UPDATE `creature` SET `spawntimesecs` = 3600
WHERE `id` IN (259385,259388,271080,274300,276061,276108) AND `spawntimesecs` = 120;
