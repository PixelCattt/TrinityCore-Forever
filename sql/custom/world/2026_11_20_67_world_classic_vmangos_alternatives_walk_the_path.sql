-- VMaNGOS spawns with alternative entries ("VMaNGOS inline main" / "VMaNGOS inline alternative" pool members, one pool
-- per original spawn, one of them up at a time): when the original spawn walked a waypoint path, only the main entry
-- got it. The alternatives stood still on the first point of the patrol, often on a road or a bridge. In VMaNGOS the
-- path belongs to the spawn, whichever entry comes up.
-- Found from Discord bug-report 2026-11-20 (61881, post 1573288262078963842, "Free at Last"): Lakota Windsong stopped
-- on the second Thousand Needles rope bridge at -4849 -1846 61, the exact point where pool 1021105 puts a Grimtotem
-- Bandit (walks path 800211050) or, as alternatives, a Grimtotem Stomper or Geomancer that never moved. His
-- screenshot shows the Stomper standing on the bridge in front of her. 528 alternative spawns had this (local count).
-- Now the alternatives walk the main spawn's path: MovementType 2 and the main's creature_addon PathId. Other addon
-- fields (auras, emotes of the main entry) are not copied. Joins only, so it fits any world state; safe to run again.

UPDATE `creature` `ca`
JOIN `pool_members` `a` ON `a`.`type` = 0 AND `a`.`spawnId` = `ca`.`guid` AND `a`.`description` = 'VMaNGOS inline alternative'
JOIN `pool_members` `m` ON `m`.`type` = 0 AND `m`.`poolSpawnId` = `a`.`poolSpawnId` AND `m`.`description` = 'VMaNGOS inline main'
JOIN `creature` `cm` ON `cm`.`guid` = `m`.`spawnId`
JOIN `creature_addon` `am` ON `am`.`guid` = `cm`.`guid`
SET `ca`.`MovementType` = 2, `ca`.`wander_distance` = 0
WHERE `cm`.`MovementType` = 2 AND `am`.`PathId` <> 0;

INSERT INTO `creature_addon` (`guid`, `PathId`, `mount`, `MountCreatureID`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`,
    `PvPFlags`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`)
SELECT `a`.`spawnId`, `am`.`PathId`, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, NULL
FROM `pool_members` `a`
JOIN `pool_members` `m` ON `m`.`type` = 0 AND `m`.`poolSpawnId` = `a`.`poolSpawnId` AND `m`.`description` = 'VMaNGOS inline main'
JOIN `creature` `cm` ON `cm`.`guid` = `m`.`spawnId`
JOIN `creature_addon` `am` ON `am`.`guid` = `cm`.`guid`
JOIN `creature` `ca` ON `ca`.`guid` = `a`.`spawnId`
WHERE `a`.`type` = 0 AND `a`.`description` = 'VMaNGOS inline alternative' AND `cm`.`MovementType` = 2 AND `am`.`PathId` <> 0
ON DUPLICATE KEY UPDATE `PathId` = VALUES(`PathId`);
