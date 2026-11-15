-- Ironforge: no Guild Vault at the bank either. Found while checking the Darnassus fix (2026_11_15_50): the dev world has no
-- Guild Vault gameobject (type 34) anywhere in Ironforge. Same fix as Darnassus: one vault in the Vault of Ironforge,
-- 2.5 yd in front of a banker, facing them.
-- INFERRED: the place (no sniff of an Ironforge vault) and the look: the Alliance vault of Stormwind (630865, scale 0.66).
-- The banker is the first one (npcflag BANKER) in the Ironforge box of map 0, so the spot follows our own spawn. Nothing is
-- added if a vault already stands in Ironforge. Safe to run again.
DELETE FROM `gameobject` WHERE `guid` = 838001001;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`,`ScriptName`,`StringId`,`VerifiedBuild`)
SELECT 838001001, 630865, 0, 0, 0, '0', 0, 0, 0, -1,
    c.`position_x` + 2.5 * COS(c.`orientation`), c.`position_y` + 2.5 * SIN(c.`orientation`), c.`position_z`,
    MOD(c.`orientation` + PI(), 2 * PI()), 0, 0, SIN(MOD(c.`orientation` + PI(), 2 * PI()) / 2), COS(MOD(c.`orientation` + PI(), 2 * PI()) / 2),
    120, 255, 1, '', NULL, 0
FROM `creature` c JOIN `creature_template` t ON t.`entry` = c.`id`
WHERE c.`map` = 0 AND (t.`npcflag` & 131072) <> 0
  AND c.`position_x` BETWEEN -5150 AND -4550 AND c.`position_y` BETWEEN -1350 AND -700
  AND EXISTS (SELECT 1 FROM `gameobject_template` WHERE `entry` = 630865)
  AND NOT EXISTS (SELECT 1 FROM (SELECT g.`guid` FROM `gameobject` g JOIN `gameobject_template` gt ON gt.`entry` = g.`id`
                  WHERE gt.`type` = 34 AND g.`map` = 0 AND g.`guid` <> 838001001
                    AND g.`position_x` BETWEEN -5150 AND -4550 AND g.`position_y` BETWEEN -1350 AND -700) v)
ORDER BY c.`guid` LIMIT 1;
