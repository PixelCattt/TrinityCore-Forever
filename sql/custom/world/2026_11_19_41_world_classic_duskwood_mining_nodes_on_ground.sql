-- Duskwood, east of Darkshire: the mining node at 81,28 hung in the air (Discord, VoldemarGreed "bugs 7", point 6, 2026-11-18).
-- Each of these three node spots holds a Silver Vein, a Gold Vein and an Iron Deposit (one pool each, one of them shows). Their z
-- did not match the ground of this client's map. Ground measured on the dev server with .playerbot groundz from z 120 / 80 down
-- (terrain plus VMap, so ledges, rocks and buildings count): one standing surface at each spot, nothing above it.
--   pool 6358, -10233.3 -1358.39: z 83.48, ground 63.18 (20.3 yd in the air)   <- the reported one
--   pool 6341, -10301.6 -1467.02: z 90.22, ground 72.26 (18.0 yd in the air)
--   pool 6357, -10237.8 -1291.58: z 46.97, ground 50.40 ( 3.4 yd under the ground)
-- Safe to run again.
UPDATE `gameobject` SET `position_z` = 63.18 WHERE `guid` IN (30098672, 30098701, 30098730) AND `id` IN (1733, 1734, 1735) AND `map` = 0;
UPDATE `gameobject` SET `position_z` = 72.26 WHERE `guid` IN (30098655, 30098684, 30098713) AND `id` IN (1733, 1734, 1735) AND `map` = 0;
UPDATE `gameobject` SET `position_z` = 50.40 WHERE `guid` IN (30098671, 30098700, 30098729) AND `id` IN (1733, 1734, 1735) AND `map` = 0;
