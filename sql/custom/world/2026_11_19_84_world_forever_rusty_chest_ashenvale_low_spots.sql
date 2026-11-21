-- Ashenvale: the last 14 Rusty Chest spots from the WoW Forever live map (see 2026_11_19_83). Our first ground check looked
-- from z 140 down to 60 and found nothing; a check from z 40 finds ground at z 70 to 86, 15 to 30 yd below the chests
-- around them (a hollow or lake bed, INFERRED). They join pool 1400500, which still keeps 30 chests up, now out of 92 places.
-- Same settings as the other 78. New gameobject guids 43100578-43100591 (inside the 43100500-43100599 range).
-- The Barrens Nailed Plank (417072) is lowered onto the ground like the Westfall one: navmesh ground 97.13 minus
-- 0.5 * 5.486 = 94.39 (INFERRED from the model box). Safe to run more than once.
DELETE FROM `pool_members` WHERE `type` = 1 AND `spawnId` BETWEEN 43100578 AND 43100591;
DELETE FROM `gameobject` WHERE `guid` BETWEEN 43100578 AND 43100591;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`) VALUES
(43100578, 19021, 1, 0, 0, '0', 0, 0, 0, -1, 1882.3, -2440.4, 78.523, 2.938, 0, 0, 0.994823, 0.101621, 300, 100, 1, '', NULL, 0),
(43100579, 19021, 1, 0, 0, '0', 0, 0, 0, -1, 1932.3, -2469.3, 80.962, 5.618, 0, 0, 0.326495, -0.945199, 300, 100, 1, '', NULL, 0),
(43100580, 19021, 1, 0, 0, '0', 0, 0, 0, -1, 1924.6, -2477.9, 78.542, 2.178, 0, 0, 0.886164, 0.463372, 300, 100, 1, '', NULL, 0),
(43100581, 19021, 1, 0, 0, '0', 0, 0, 0, -1, 1843.9, -2475.0, 71.405, 5.187, 0, 0, 0.52106, -0.85352, 300, 100, 1, '', NULL, 0),
(43100582, 19021, 1, 0, 0, '0', 0, 0, 0, -1, 1851.6, -2480.8, 70.409, 4.12, 0, 0, 0.882707, -0.469923, 300, 100, 1, '', NULL, 0),
(43100583, 19021, 1, 0, 0, '0', 0, 0, 0, -1, 1832.3, -2480.8, 71.04, 2.522, 0, 0, 0.952396, 0.304865, 300, 100, 1, '', NULL, 0),
(43100584, 19021, 1, 0, 0, '0', 0, 0, 0, -1, 1801.6, -2498.1, 83.355, 0.855, 0, 0, 0.414597, 0.910005, 300, 100, 1, '', NULL, 0),
(43100585, 19021, 1, 0, 0, '0', 0, 0, 0, -1, 1951.5, -2521.2, 79.339, 5.698, 0, 0, 0.288436, -0.957499, 300, 100, 1, '', NULL, 0),
(43100586, 19021, 1, 0, 0, '0', 0, 0, 0, -1, 1951.5, -2544.2, 77.028, 4.346, 0, 0, 0.824089, -0.56646, 300, 100, 1, '', NULL, 0),
(43100587, 19021, 1, 0, 0, '0', 0, 0, 0, -1, 1843.9, -2544.2, 72.812, 3.25, 0, 0, 0.998531, -0.054177, 300, 100, 1, '', NULL, 0),
(43100588, 19021, 1, 0, 0, '0', 0, 0, 0, -1, 1855.4, -2555.8, 73.429, 0.142, 0, 0, 0.07094, 0.997481, 300, 100, 1, '', NULL, 0),
(43100589, 19021, 1, 0, 0, '0', 0, 0, 0, -1, 1786.2, -2561.5, 83.596, 5.956, 0, 0, 0.162864, -0.986649, 300, 100, 1, '', NULL, 0),
(43100590, 19021, 1, 0, 0, '0', 0, 0, 0, -1, 1770.8, -2561.5, 85.791, 5.332, 0, 0, 0.457865, -0.889022, 300, 100, 1, '', NULL, 0),
(43100591, 19021, 1, 0, 0, '0', 0, 0, 0, -1, 1905.4, -2601.9, 78.108, 2.849, 0, 0, 0.989318, 0.145775, 300, 100, 1, '', NULL, 0);
INSERT INTO `pool_members` (`type`, `spawnId`, `poolSpawnId`, `chance`, `description`) VALUES
(1, 43100578, 1400500, 0, 'Rusty Chest in Ashenvale'),
(1, 43100579, 1400500, 0, 'Rusty Chest in Ashenvale'),
(1, 43100580, 1400500, 0, 'Rusty Chest in Ashenvale'),
(1, 43100581, 1400500, 0, 'Rusty Chest in Ashenvale'),
(1, 43100582, 1400500, 0, 'Rusty Chest in Ashenvale'),
(1, 43100583, 1400500, 0, 'Rusty Chest in Ashenvale'),
(1, 43100584, 1400500, 0, 'Rusty Chest in Ashenvale'),
(1, 43100585, 1400500, 0, 'Rusty Chest in Ashenvale'),
(1, 43100586, 1400500, 0, 'Rusty Chest in Ashenvale'),
(1, 43100587, 1400500, 0, 'Rusty Chest in Ashenvale'),
(1, 43100588, 1400500, 0, 'Rusty Chest in Ashenvale'),
(1, 43100589, 1400500, 0, 'Rusty Chest in Ashenvale'),
(1, 43100590, 1400500, 0, 'Rusty Chest in Ashenvale'),
(1, 43100591, 1400500, 0, 'Rusty Chest in Ashenvale');
UPDATE `gameobject` SET `position_z` = 94.39 WHERE `guid` = 41707200 AND `id` = 417072;
