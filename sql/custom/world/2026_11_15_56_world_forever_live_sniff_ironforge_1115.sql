-- WoW Forever live realm: ironforge-1115.pkt (Karrz, 2026-11-15, snapshot at 13:19 while still recording): Dun Morogh, Kharanos
-- and part of Ironforge (throne room, the Commons, the bank, the lower halls). Only what our data lacks. Comes after 2026_11_15_55.
-- Positions and rotations are read from the live CreateObject data. Safe to run more than once: every insert skips a spawn of
-- the same entry already within 5 yards, so it also leaves alone what the 212000xx sniff imports already placed.
--
-- 162 Ironforge objects live sends under new ids (braziers, chairs, district signs, forges) stand exactly where our older ids
-- already stand, so they are left out: adding them would put two copies in the same spot.

-- 1. Object templates our data lacks (from live's query answers): two Guild Vaults, two Barbershop Chairs, two Dwarven High Back
--    Chairs and the braziers of the lower halls.
INSERT IGNORE INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `VerifiedBuild`) VALUES
(630860, 34, 122618, 'Guild Vault', '', '', '', 1.0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 70938),
(650705, 7, 648, 'Dwarven High Back Chair', '', '', '', 1.0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 70938),
(650706, 7, 648, 'Dwarven High Back Chair', '', '', '', 1.0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 70938),
(650707, 32, 7896, 'Barbershop Chair', '', '', '', 1.0, 1, 0, 0, 0, 67, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 70938),
(650708, 32, 7896, 'Barbershop Chair', '', '', '', 1.0, 1, 0, 0, 0, 67, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 70938),
(650710, 8, 197, 'Dwarven Brazier', '', '', '', 1.0, 4, 5, 2061, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 70938),
(650711, 8, 197, 'Dwarven Brazier', '', '', '', 1.0, 4, 5, 2061, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 70938),
(650712, 8, 197, 'Dwarven Brazier', '', '', '', 1.0, 4, 5, 2061, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 70938),
(650713, 8, 197, 'Dwarven Brazier', '', '', '', 1.0, 4, 5, 2061, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 70938),
(650714, 8, 197, 'Dwarven Brazier', '', '', '', 1.0, 4, 5, 2061, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 70938),
(650716, 8, 197, 'Dwarven Brazier', '', '', '', 1.0, 4, 5, 2061, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 70938),
(650718, 8, 197, 'Dwarven Brazier', '', '', '', 1.0, 4, 5, 2061, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 70938),
(650719, 8, 197, 'Dwarven Brazier', '', '', '', 1.0, 4, 5, 2061, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 70938),
(707346, 8, 197, 'Doodad_DwarvenBrazier197', '', '', '', 1.0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 70938);

-- 2. Their spawns. A Barbershop Chair (650707) stands where our Dwarven High Back Chair (guid 30001821) stood; live has no chair
--    there any more, so ours goes. Live has two Guild Vaults in the bank (630860), so the single one placed by guess in
--    2026_11_15_52 (guid 838001001, the Darnassus vault 630865) is removed in their favour.
DELETE FROM `gameobject` WHERE `guid` = 30001821 AND `id` = 171649;
DELETE FROM `gameobject` WHERE `guid` = 838001001 AND `id` = 630865;
DELETE FROM `gameobject` WHERE `guid` BETWEEN 46110000 AND 46110014;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`,
  `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`)
SELECT n.guid, n.id, 0, 0, 0, '0', 0, 0, 0, -1, n.x, n.y, n.z, n.o, n.r0, n.r1, n.r2, n.r3, 120, 255, 1, '', 70938 FROM (
  SELECT 46110000 AS guid, 630860 AS id, -4905.441 AS x, -992.344 AS y, 503.94 AS z, 5.32326 AS o, 0.0 AS r0, 0.0 AS r1, -0.461748 AS r2, 0.887011 AS r3
  UNION ALL SELECT 46110001 AS guid, 630860 AS id, -4887.29 AS x, -977.446 AS y, 503.94 AS z, 5.23599 AS o, 0.0 AS r0, 0.0 AS r1, -0.5 AS r2, 0.866025 AS r3
  UNION ALL SELECT 46110002 AS guid, 650705 AS id, -4836.208 AS x, -925.143 AS y, 502.22 AS z, 1.67551 AS o, 0.0 AS r0, 0.0 AS r1, 0.743144 AS r2, 0.669131 AS r3
  UNION ALL SELECT 46110003 AS guid, 650706 AS id, -4838.559 AS x, -925.495 AS y, 502.22 AS z, 1.69297 AS o, 0.0 AS r0, 0.0 AS r1, 0.748955 AS r2, 0.662621 AS r3
  UNION ALL SELECT 46110004 AS guid, 650707 AS id, -4826.539 AS x, -921.986 AS y, 502.49 AS z, 4.82584 AS o, 0.0 AS r0, 0.0 AS r1, -0.665881 AS r2, 0.746058 AS r3
  UNION ALL SELECT 46110005 AS guid, 650708 AS id, -4820.603 AS x, -921.132 AS y, 502.49 AS z, 4.82584 AS o, 0.0 AS r0, 0.0 AS r1, -0.665881 AS r2, 0.746058 AS r3
  UNION ALL SELECT 46110006 AS guid, 650710 AS id, -4818.826 AS x, -1035.018 AS y, 440.315 AS z, 1.9984 AS o, 0.0 AS r0, 0.0 AS r1, 0.841039 AS r2, 0.540975 AS r3
  UNION ALL SELECT 46110007 AS guid, 650711 AS id, -4816.843 AS x, -1028.344 AS y, 440.315 AS z, 1.9984 AS o, 0.0 AS r0, 0.0 AS r1, 0.841039 AS r2, 0.540975 AS r3
  UNION ALL SELECT 46110008 AS guid, 650712 AS id, -4830.4 AS x, -977.438 AS y, 466.349 AS z, 1.9984 AS o, 0.0 AS r0, 0.0 AS r1, 0.841039 AS r2, 0.540975 AS r3
  UNION ALL SELECT 46110009 AS guid, 650713 AS id, -4840.737 AS x, -1002.769 AS y, 446.692 AS z, 1.9984 AS o, 0.0 AS r0, 0.0 AS r1, 0.841039 AS r2, 0.540975 AS r3
  UNION ALL SELECT 46110010 AS guid, 650714 AS id, -4833.124 AS x, -1024.766 AS y, 448.805 AS z, 1.9984 AS o, 0.0 AS r0, 0.0 AS r1, 0.841039 AS r2, 0.540975 AS r3
  UNION ALL SELECT 46110011 AS guid, 650716 AS id, -4800.31 AS x, -978.111 AS y, 399.091 AS z, 4.59292 AS o, 0.0 AS r0, 0.0 AS r1, -0.74806 AS r2, 0.663631 AS r3
  UNION ALL SELECT 46110012 AS guid, 650718 AS id, -4822.371 AS x, -950.435 AS y, 432.664 AS z, 4.59292 AS o, 0.0 AS r0, 0.0 AS r1, -0.74806 AS r2, 0.663631 AS r3
  UNION ALL SELECT 46110013 AS guid, 650719 AS id, -4825.175 AS x, -997.324 AS y, 441.657 AS z, 1.9984 AS o, 0.0 AS r0, 0.0 AS r1, 0.841039 AS r2, 0.540975 AS r3
  UNION ALL SELECT 46110014 AS guid, 707346 AS id, -4854.999 AS x, -997.817 AS y, 455.355 AS z, 1.9984 AS o, 0.0 AS r0, 0.0 AS r1, 0.841039 AS r2, 0.540975 AS r3
) n WHERE NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`map` = 0 AND g.`id` = n.id
  AND POW(g.`position_x` - n.x, 2) + POW(g.`position_y` - n.y, 2) + POW(g.`position_z` - n.z, 2) < 25);

-- 3. NPCs live has that we never spawn: Deliana by the throne, and four of the six display mechanostriders at Milli Featherwhistle's
--    (we only had the green and the swift yellow one).
DELETE FROM `creature` WHERE `guid` BETWEEN 46110000 AND 46110004;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`,
  `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `ScriptName`, `VerifiedBuild`)
SELECT n.guid, n.id, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, n.x, n.y, n.z, n.o, 300, 0, 0, 100, 0, '', 70938 FROM (
  SELECT 46110000 AS guid, 230319 AS id, -4846.557 AS x, -1057.771 AS y, 502.194 AS z, 1.2915 AS o
  UNION ALL SELECT 46110001 AS guid, 267683 AS id, -5461.252 AS x, -619.557 AS y, 393.572 AS z, 0.0873 AS o
  UNION ALL SELECT 46110002 AS guid, 267687 AS id, -5458.483 AS x, -614.002 AS y, 394.008 AS z, 5.3582 AS o
  UNION ALL SELECT 46110003 AS guid, 267688 AS id, -5455.75 AS x, -612.917 AS y, 394.404 AS z, 5.0265 AS o
  UNION ALL SELECT 46110004 AS guid, 276734 AS id, -5452.318 AS x, -613.089 AS y, 394.51 AS z, 4.2935 AS o
) n WHERE EXISTS (SELECT 1 FROM `creature_template` t WHERE t.`entry` = n.id) AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`map` = 0 AND c.`id` = n.id
  AND POW(c.`position_x` - n.x, 2) + POW(c.`position_y` - n.y, 2) + POW(c.`position_z` - n.z, 2) < 25);

-- 4. NPCs that stand somewhere else live: the two display mechanostriders we have (5-6 yards off, in a straight row with the new
--    ones), and the Dun Morogh Mortar Team (Angus, Shorty, Riflemen Wheeler and Middlecamp about 35 yards west of ours, Spotter
--    Klemmy on the rise above them).
UPDATE `creature` SET `position_x` = -5460.408, `position_y` = -616.295, `position_z` = 393.851, `orientation` = 5.9167 WHERE `guid` = 9687046 AND `id` = 267684;
UPDATE `creature` SET `position_x` = -5447.829, `position_y` = -617.37, `position_z` = 394.511, `orientation` = 3.194 WHERE `guid` = 9953285 AND `id` = 276735;
UPDATE `creature` SET `position_x` = -6031.16, `position_y` = -230.264, `position_z` = 414.403, `orientation` = 2.8274 WHERE `guid` = 20000269 AND `id` = 10610;
UPDATE `creature` SET `position_x` = -6031.529, `position_y` = -227.909, `position_z` = 414.404, `orientation` = 2.8798 WHERE `guid` = 20000267 AND `id` = 10611;
UPDATE `creature` SET `position_x` = -6031.929, `position_y` = -221.088, `position_z` = 413.089, `orientation` = 4.7173 WHERE `guid` = 20000266 AND `id` = 10803;
UPDATE `creature` SET `position_x` = -6034.136, `position_y` = -223.333, `position_z` = 413.4, `orientation` = 2.9147 WHERE `guid` = 20000268 AND `id` = 10804;
UPDATE `creature` SET `position_x` = -6065.903, `position_y` = -202.298, `position_z` = 424.369, `orientation` = 3.8397 WHERE `guid` = 20000272 AND `id` = 10805;
