-- Daggerfang (270693, Loch Modan shore): one at a time instead of twenty-five (Discord "bugs 4", 2026-11-13: "as if there
-- should only be one of these crocolisks, rather than the whole shore being covered in them").
-- The AnoCore port in 2026_11_05_99 placed a Daggerfang on each of its 25 map pins (guids 27069300-27069324, -5120 to -5507 x,
-- -3621 to -3809 y, in no pool). The pins stay as the places it can turn up, in one pool with one Daggerfang up at a time (same
-- as the Whispering Horror, 2026_11_12_36). INFERRED: that Forever has one Daggerfang is the player's report and its name;
-- no sniff of it is in hand. Safe to run again.
DELETE FROM `pool_members` WHERE `type` = 0 AND `spawnId` BETWEEN 27069300 AND 27069324;
DELETE FROM `pool_template` WHERE `entry` = 2706930;
INSERT INTO `pool_template` (`entry`,`max_limit`,`description`) VALUES (2706930,1,'Loch Modan - Daggerfang, one of 25 shore spots');
INSERT INTO `pool_members` (`type`,`spawnId`,`poolSpawnId`,`chance`,`description`) VALUES
(0,27069300,2706930,0,'Daggerfang'),
(0,27069301,2706930,0,'Daggerfang'),
(0,27069302,2706930,0,'Daggerfang'),
(0,27069303,2706930,0,'Daggerfang'),
(0,27069304,2706930,0,'Daggerfang'),
(0,27069305,2706930,0,'Daggerfang'),
(0,27069306,2706930,0,'Daggerfang'),
(0,27069307,2706930,0,'Daggerfang'),
(0,27069308,2706930,0,'Daggerfang'),
(0,27069309,2706930,0,'Daggerfang'),
(0,27069310,2706930,0,'Daggerfang'),
(0,27069311,2706930,0,'Daggerfang'),
(0,27069312,2706930,0,'Daggerfang'),
(0,27069313,2706930,0,'Daggerfang'),
(0,27069314,2706930,0,'Daggerfang'),
(0,27069315,2706930,0,'Daggerfang'),
(0,27069316,2706930,0,'Daggerfang'),
(0,27069317,2706930,0,'Daggerfang'),
(0,27069318,2706930,0,'Daggerfang'),
(0,27069319,2706930,0,'Daggerfang'),
(0,27069320,2706930,0,'Daggerfang'),
(0,27069321,2706930,0,'Daggerfang'),
(0,27069322,2706930,0,'Daggerfang'),
(0,27069323,2706930,0,'Daggerfang'),
(0,27069324,2706930,0,'Daggerfang');
