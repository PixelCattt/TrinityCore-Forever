-- Restored spawns of 2026_11_05_99 that stand in the rock instead of on the floor. Heights from spawn_ground_probe (PC steps
-- 101/113, rerun 2026-11-15 after the vmap reader fix): terrain height and every building surface 10 yd above and below each
-- spawn, compared with the height the worldserver itself would compute there.
-- * Great Cat Spirit (Moonglade Barrow Dens, Discord 2026-11-14): Relic of the Claw 67309300 stood on the hill top at 592.9,
--   about 155 yd over the den; the den floor at that spot is the one the four fountains 185493 stand on 5 yd away (surface
--   438.2-438.5), so it goes to 438.4. Relic of the Silent Shadow 67309400 stood at 415.6, 15 yd under the den floor with no
--   surface around it; its twin 67309401 5 yd away stands on the floor at 430.35, so it goes there. (INFERRED: floor height
--   taken from the nearest probed spawn, no sniff of these relics.)
-- * Bubbling Swamp Ooze 439410 and 439411 (Dustwallow Marsh) stood 4 and 3.5 yd under the ground; they go onto it.
-- Each row moves only while it still has the old height. Safe to run again.
UPDATE `gameobject` SET `position_z` = 438.4  WHERE `guid` = 67309300 AND `id` = 673093 AND ABS(`position_z` - 592.861) < 0.01;
UPDATE `gameobject` SET `position_z` = 430.35 WHERE `guid` = 67309400 AND `id` = 673094 AND ABS(`position_z` - 415.55) < 0.01;
UPDATE `creature` SET `position_z` = 44.757 WHERE `guid` = 439410 AND `id` = 4394 AND ABS(`position_z` - 40.78) < 0.01;
UPDATE `creature` SET `position_z` = 44.546 WHERE `guid` = 439411 AND `id` = 4394 AND ABS(`position_z` - 41.0521) < 0.01;
