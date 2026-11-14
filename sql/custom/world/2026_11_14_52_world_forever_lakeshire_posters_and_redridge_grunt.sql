-- Redridge spawns from Discord "bugs 4" (2026-11-13). Taken from SIN's fix pack for 0.1.36 and written again here.
-- Safe to run again (each change only applies while the spawn is still at its old place).

-- Lakeshire 24,46: the two large posters 649051 (spawns 64905100/64905101, from 2026_11_05_99) stood at terrain height 63.93,
-- under the building floor. They go on the wall of the Wanted notice 60 (spawn 30042496, -9243.42, -2213.92, 67.62, facing
-- 3.14159): one 1.3 yd beside it, the other across the doorway 7.2 yd away, both 0.9 yd higher, same facing.
-- INFERRED: placed by eye in the fix pack; the PC step checks they stand on the wall.
UPDATE `gameobject` SET `position_x` = -9243.42, `position_y` = -2215.22, `position_z` = 68.5241, `orientation` = 3.14159,
    `rotation0` = 0, `rotation1` = 0, `rotation2` = 1, `rotation3` = 0
WHERE `guid` = 64905100 AND `id` = 649051 AND ABS(`position_z` - 63.934) < 0.01;
UPDATE `gameobject` SET `position_x` = -9243.42, `position_y` = -2206.72, `position_z` = 68.5241, `orientation` = 3.14159,
    `rotation0` = 0, `rotation1` = 0, `rotation2` = 1, `rotation3` = 0
WHERE `guid` = 64905101 AND `id` = 649051 AND ABS(`position_z` - 63.934) < 0.01;

-- Redridge 68,79: "mob stuck, can't be hit". The standing Blackrock Grunt 440 (spawn 20006742) had no walkable ground under its
-- home spot; it moves 5 yd onto walkable ground. INFERRED from the navmesh by the fix pack; the PC ground probe checks it.
UPDATE `creature` SET `position_x` = -9706.812, `position_y` = -3167.993, `position_z` = 59.415
WHERE `guid` = 20006742 AND `id` = 440 AND ABS(`position_x` + 9711.56) < 0.01 AND ABS(`position_y` + 3165.54) < 0.01;
