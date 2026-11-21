-- Rogue Dead Drop chain (2026_11_21_86): ground heights measured on dev (.playerbot groundz, 11-21), and a new spot for the
-- Padlocked Reliquary: 252 -301 had no floor at all. It now stands between the two book podiums of the monks' room in the
-- Library (Beginnings of the Undead Threat 238.55 -307.69, its neighbour 238.81 -305.72): "the small room on the left with
-- three monks and a chest, between two podiums". Still an estimate; the floor height is the monks' (20.16).
UPDATE `creature` SET `position_z` = 76.05 WHERE `guid` = 21176500 AND `id` = 211765;
UPDATE `creature` SET `position_z` = 95.87 WHERE `guid` = 21176400 AND `id` = 211764;
UPDATE `gameobject` SET `position_z` = 78.73 WHERE `guid` = 47501150 AND `id` = 410528;
UPDATE `gameobject` SET `position_z` = 137.84 WHERE `guid` = 47501151 AND `id` = 412147;
UPDATE `gameobject` SET `position_z` = 18.53 WHERE `guid` = 47501152 AND `id` = 412759;
UPDATE `gameobject` SET `position_x` = 238.7, `position_y` = -306.7, `position_z` = 21.43, `orientation` = 0,
`rotation0` = 0, `rotation1` = 0, `rotation2` = 0, `rotation3` = 1 WHERE `guid` = 47501153 AND `id` = 412261;
UPDATE `areatrigger` SET `PosZ` = 18.16 WHERE `SpawnId` IN (78676001, 78676002);
