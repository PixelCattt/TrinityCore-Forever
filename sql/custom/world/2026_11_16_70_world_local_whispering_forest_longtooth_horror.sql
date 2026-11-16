-- Whispering Forest, Tirisfal (fix by SIN, from his Forever Bots 0.1.35 pack "Whispering Forest spawn fixes", apply.sql):
-- the 15 level 47-48 Rabid Longtooth (5288, guids 21200001-21200015) go from the Whispering Forest; the four level 8-9 Rabid
-- Forest Wolves stay. The Whispering Horror (260396) keeps one spawn, 46000006 in the underground crypt (still 5 min respawn).
-- His checks, backup tables (forever_wf035_*) and removals are kept. Only what is needed to run here is changed:
--   * our DB updater runs files as plain statements, not through the mysql client, so his stored procedure (DELIMITER,
--     IF ... SIGNAL) is written out as statements; each of his checks is a row in a CHECK-guarded table, as in his other packs.
--     A failed check stops the file and nothing is changed.
--   * our 0.1.36 file 2026_11_12_36 already deleted the five hill Horrors 26039600-26039604 and put the four crypt Horrors
--     46000004-46000007 in pool 2603960 (one up at a time). His file stops on any pool membership, so that pool goes first, and
--     18 rows are removed (15 Longtooths + 46000004, 46000005, 46000007) instead of his 23.
--   * our level 8-9 rows for the Longtooths (creature_classic_level_spawn, 2026_11_12_21) go with them.
--   * a realm that already ran his own pack has his receipt and 23 backup rows; that is accepted as installed.
CREATE TABLE IF NOT EXISTS forever_wf035_creature_before LIKE creature;
CREATE TABLE IF NOT EXISTS forever_wf035_group_before LIKE spawn_group;
CREATE TABLE IF NOT EXISTS forever_wf035_receipt (
    patch_id TINYINT UNSIGNED PRIMARY KEY,
    group_rows INT UNSIGNED NOT NULL
) ENGINE=InnoDB;

DROP TEMPORARY TABLE IF EXISTS wf035_plan, wf035_guard;
CREATE TEMPORARY TABLE wf035_guard (ok TINYINT NOT NULL, CONSTRAINT wf035_unexpected_world_data CHECK (ok = 1));
CREATE TEMPORARY TABLE wf035_plan (
    guid BIGINT UNSIGNED PRIMARY KEY,
    entry INT UNSIGNED NOT NULL,
    x FLOAT NOT NULL, y FLOAT NOT NULL, z FLOAT NOT NULL
);
-- Source GUIDs and spawn positions distinguish the two imports from local custom spawns.
INSERT INTO wf035_plan VALUES
  (21200001,5288,1981.03,2186.19,137.617), (21200002,5288,1874.30,2200.44,142.587),
  (21200003,5288,1810.94,2105.00,136.203), (21200004,5288,1719.85,2103.36,146.472),
  (21200005,5288,1677.32,2172.19,145.918), (21200006,5288,1671.95,2087.19,149.061),
  (21200007,5288,1627.51,2045.02,147.176), (21200008,5288,1712.46,2252.43,146.924),
  (21200009,5288,1723.01,2326.22,140.271), (21200010,5288,1809.06,2359.44,133.602),
  (21200011,5288,1903.12,2271.83,142.053), (21200012,5288,1800.64,2350.31,132.990),
  (21200013,5288,1733.19,2313.16,141.879), (21200014,5288,1712.78,2266.16,147.217),
  (21200015,5288,1995.04,2192.08,134.658),
  (26039600,260396,2048.07,2644.72,179.735), (26039601,260396,2005.90,2626.65,204.555),
  (26039602,260396,1957.70,2626.65,193.620), (26039603,260396,2054.10,2599.53,171.318),
  (26039604,260396,2036.03,2599.53,154.690), (46000004,260396,2030.00,2653.76,108.200),
  (46000005,260396,2054.10,2599.53,108.591), (46000007,260396,1957.70,2626.65,109.858);

START TRANSACTION;
-- our 0.1.36 pool of the four crypt Horrors (2026_11_12_36)
DELETE FROM pool_members WHERE type = 0 AND poolSpawnId = 2603960 AND spawnId IN (46000004,46000005,46000006,46000007);
DELETE FROM pool_template WHERE entry = 2603960;

-- 'Missing or modified crypt Horror 46000006. Check this world database.'
INSERT INTO wf035_guard SELECT COUNT(*) = 1 FROM creature
WHERE guid=46000006 AND map=0 AND id=260396 AND MovementType=0
  AND wander_distance=0 AND spawntimesecs=300 AND ABS(position_x-2005.90)<0.05
  AND ABS(position_y-2626.65)<0.05 AND ABS(position_z-108.00)<0.05;
-- 'Expected four existing Rabid Forest Wolf spawns in Whispering Forest.'
INSERT INTO wf035_guard SELECT COUNT(*) = 4 FROM creature
WHERE guid BETWEEN 27773000 AND 27773003 AND id=277730 AND map=0
  AND position_x BETWEEN 1750 AND 2050 AND position_y BETWEEN 2150 AND 2400;
-- 'Unexpected additional Longtooth or Horror near the patch area. Review custom spawns.'
INSERT INTO wf035_guard SELECT NOT EXISTS (SELECT 1 FROM creature c LEFT JOIN wf035_plan p ON p.guid=c.guid
           WHERE c.map=0 AND c.id IN (5288,260396) AND c.guid<>46000006 AND p.guid IS NULL
             AND c.position_x BETWEEN 1575 AND 2125 AND c.position_y BETWEEN 1990 AND 2700);

SET @wf035_installed = EXISTS (SELECT 1 FROM forever_wf035_receipt WHERE patch_id=1);
-- installed before: 'The installed patch has an incomplete or unexpected backup.'
INSERT INTO wf035_guard SELECT NOT @wf035_installed OR (
       (SELECT COUNT(*) FROM forever_wf035_creature_before) IN (18,23)
   AND (SELECT COUNT(*) FROM forever_wf035_group_before) = (SELECT group_rows FROM forever_wf035_receipt WHERE patch_id=1)
   AND NOT EXISTS (SELECT 1 FROM forever_wf035_creature_before b LEFT JOIN wf035_plan p ON p.guid=b.guid
                   WHERE p.guid IS NULL OR b.map<>0 OR b.id<>p.entry)
   AND NOT EXISTS (SELECT 1 FROM forever_wf035_group_before g LEFT JOIN forever_wf035_creature_before p ON p.guid=g.spawnId
                   WHERE g.spawnType<>0 OR p.guid IS NULL));
-- not installed: 'Unmarked Whispering Forest backup already exists. Inspect it before applying.'
INSERT INTO wf035_guard SELECT @wf035_installed OR (NOT EXISTS (SELECT 1 FROM forever_wf035_creature_before)
   AND NOT EXISTS (SELECT 1 FROM forever_wf035_group_before));
-- not installed: 'Expected 15 imported Longtooths and three surplus Horrors at their 0.1.36 spawn positions.'
INSERT INTO wf035_guard SELECT @wf035_installed OR (SELECT COUNT(*) FROM creature c JOIN wf035_plan p ON p.guid=c.guid
    WHERE c.map=0 AND c.id=p.entry AND ABS(c.position_x-p.x)<0.05
      AND ABS(c.position_y-p.y)<0.05 AND ABS(c.position_z-p.z)<0.05) = 18;
-- not installed: 'Found a custom spawn-specific dependency. Review it before removing these spawns.'
INSERT INTO wf035_guard SELECT @wf035_installed OR NOT EXISTS (SELECT 1 FROM wf035_plan p WHERE
          EXISTS (SELECT 1 FROM pool_members r WHERE r.type=0 AND r.spawnId=p.guid)
       OR EXISTS (SELECT 1 FROM creature_addon r WHERE r.guid=p.guid)
       OR EXISTS (SELECT 1 FROM creature_formations r WHERE r.leaderGUID=p.guid OR r.memberGUID=p.guid)
       OR EXISTS (SELECT 1 FROM game_event_creature r WHERE r.guid=p.guid)
       OR EXISTS (SELECT 1 FROM linked_respawn r WHERE r.guid=p.guid OR r.linkedGuid=p.guid)
       OR EXISTS (SELECT 1 FROM smart_scripts r WHERE r.source_type=0 AND r.entryorguid=-CAST(p.guid AS SIGNED)));
-- not installed: 'An original spawn membership has no matching template. Review this world database.'
INSERT INTO wf035_guard SELECT @wf035_installed OR NOT EXISTS (SELECT 1 FROM wf035_plan p
       JOIN spawn_group g ON g.spawnType=0 AND g.spawnId=p.guid
       LEFT JOIN spawn_group_template t ON t.groupId=g.groupId WHERE t.groupId IS NULL);

INSERT INTO forever_wf035_creature_before SELECT c.* FROM creature c JOIN wf035_plan p ON p.guid=c.guid WHERE NOT @wf035_installed;
INSERT INTO forever_wf035_group_before
    SELECT g.* FROM spawn_group g JOIN wf035_plan p ON p.guid=g.spawnId WHERE g.spawnType=0 AND NOT @wf035_installed;
SET @wf035_group_rows = ROW_COUNT();
INSERT INTO forever_wf035_receipt SELECT 1, @wf035_group_rows FROM DUAL WHERE NOT @wf035_installed;
DELETE g FROM spawn_group g JOIN forever_wf035_group_before b
  ON g.groupId=b.groupId AND g.spawnType=b.spawnType AND g.spawnId=b.spawnId WHERE NOT @wf035_installed;
DELETE c FROM creature c JOIN wf035_plan p ON p.guid=c.guid AND p.entry=c.id WHERE c.map=0 AND NOT @wf035_installed;
-- 'Unexpected number of removed creatures. Transaction reverted.'
SET @wf035_deleted = ROW_COUNT();
INSERT INTO wf035_guard SELECT @wf035_installed OR @wf035_deleted = 18;
-- our 2026_11_12_21 gave these Longtooths level 8-9; that row would point at a missing spawn and log an error at startup
DELETE l FROM creature_classic_level_spawn l JOIN wf035_plan p ON p.guid=l.guid
WHERE NOT EXISTS (SELECT 1 FROM creature c WHERE c.guid=l.guid);
-- 'A removed GUID or its group membership exists. Check for a world update or local changes.'
INSERT INTO wf035_guard SELECT NOT EXISTS (SELECT 1 FROM creature c JOIN wf035_plan p ON p.guid=c.guid)
   AND NOT EXISTS (SELECT 1 FROM spawn_group g JOIN forever_wf035_creature_before p ON p.guid=g.spawnId WHERE g.spawnType=0);
COMMIT;
DROP TEMPORARY TABLE wf035_plan, wf035_guard;
