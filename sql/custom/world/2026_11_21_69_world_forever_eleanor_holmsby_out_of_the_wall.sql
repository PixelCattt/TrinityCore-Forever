-- Riverglades: Eleanor Holmsby (259050, starts "Eyes for the Watchman") stood inside a house wall (GitHub issue #20, 2026-11-21,
-- screenshot). Her height was right, her x/y were not. Live spot from Wowhead (npc=259050, one spawn, uiMap 2548 at 43.4, 82.4),
-- converted with the Riverglades map fit X = -6466.54 - 32.3421 * y%, Y = -1891.63 - 48.5013 * x% (0.6 yd on known points; the map
-- coords themselves are good to about 3 yd). Height: INFERRED from the navmesh at the two nearest spawns (Eleanor's old spot 36.52,
-- 259049 at 5.9 yd 37.00). Checks guid and entry, so it only moves our own spawn. Safe to run again.
UPDATE `creature` SET `position_x` = -9131.53, `position_y` = -3996.59, `position_z` = 36.80 WHERE `guid` = 25905000 AND `id` = 259050;
