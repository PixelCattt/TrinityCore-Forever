-- Herb and mining nodes that hang in the air or sit under the ground, Eastern Kingdoms and Kalimdor (Discord, VoldemarGreed "bugs 7",
-- point 6, 2026-11-18: the check that found the Duskwood ore of 2026_11_19_41, run over both continents).
-- Measured on the dev server with .playerbot nodeheights (terrain .map plus VMap, searched from 30 yd above the spawn to 60 yd
-- below it). A spot moves here when its nearest standing surface is at most 15 yd off and every other surface found is at least
-- 10 yd further away; it gets that surface's height.
-- Left alone: spots with no surface found, spots more than 15 yd off (likely on a rock the VMap does not hold), and spots with two
-- surfaces close together (bridges, caves, ledges: which one is meant needs a look in game).
-- The id check keeps a row from being moved if a later update reuses the guid. Safe to run again.
-- 62 nodes at 52 spots.
-- map 0 zone 3 (-7271.19, -3498.73): Wild Steelbloom, z 324.51, ground 317.42 (7.1 yd in the air)
UPDATE `gameobject` SET `position_z` = 317.42 WHERE `guid` IN (30056128) AND `id` IN (1623) AND `map` = 0;
-- map 0 zone 8 (-9818.33, -3718.11): Goldthorn, z 34.28, ground 47.88 (13.6 yd under the ground)
UPDATE `gameobject` SET `position_z` = 47.88 WHERE `guid` IN (30042216) AND `id` IN (2046) AND `map` = 0;
-- map 0 zone 10 (-10338.80, -1492.60): Wild Steelbloom, z 99.78, ground 93.78 (6.0 yd in the air)
UPDATE `gameobject` SET `position_z` = 93.78 WHERE `guid` IN (30004209) AND `id` IN (1623) AND `map` = 0;
-- map 0 zone 10 (-10311.20, -1427.56): Briarthorn, z 90.25, ground 82.92 (7.3 yd in the air)
UPDATE `gameobject` SET `position_z` = 82.92 WHERE `guid` IN (30018569) AND `id` IN (1621) AND `map` = 0;
-- map 0 zone 11 (-4250.16, -3066.69): Silver Vein, Tin Vein, z 8.75, ground 12.69 (3.9 yd under the ground)
UPDATE `gameobject` SET `position_z` = 12.69 WHERE `guid` IN (30022837, 30022876) AND `id` IN (1732, 1733) AND `map` = 0;
-- map 0 zone 11 (-4189.18, -3100.81): Bruiseweed, z 26.23, ground 23.20 (3.0 yd in the air)
UPDATE `gameobject` SET `position_z` = 23.20 WHERE `guid` IN (30033397) AND `id` IN (1622) AND `map` = 0;
-- map 0 zone 11 (-3612.66, -620.55): Stranglekelp, z -13.83, ground -22.26 (8.4 yd in the air)
UPDATE `gameobject` SET `position_z` = -22.26 WHERE `guid` IN (30007524) AND `id` IN (2045) AND `map` = 0;
-- map 0 zone 11 (-3526.34, -678.78): Stranglekelp, z -12.13, ground -18.04 (5.9 yd in the air)
UPDATE `gameobject` SET `position_z` = -18.04 WHERE `guid` IN (30050495) AND `id` IN (2045) AND `map` = 0;
-- map 0 zone 11 (-3481.24, -625.55): Stranglekelp, z -13.80, ground -21.15 (7.3 yd in the air)
UPDATE `gameobject` SET `position_z` = -21.15 WHERE `guid` IN (30050522) AND `id` IN (2045) AND `map` = 0;
-- map 0 zone 11 (-3463.25, -700.85): Stranglekelp, z -11.99, ground -16.85 (4.9 yd in the air)
UPDATE `gameobject` SET `position_z` = -16.85 WHERE `guid` IN (30050523) AND `id` IN (2045) AND `map` = 0;
-- map 0 zone 33 (-12503.60, 231.24): Stranglekelp, z -11.82, ground -16.93 (5.1 yd in the air)
UPDATE `gameobject` SET `position_z` = -16.93 WHERE `guid` IN (30050577) AND `id` IN (2045) AND `map` = 0;
-- map 0 zone 36 (55.56, -50.39): Kingsblood, z 99.19, ground 103.73 (4.5 yd under the ground)
UPDATE `gameobject` SET `position_z` = 103.73 WHERE `guid` IN (30003938) AND `id` IN (1624) AND `map` = 0;
-- map 0 zone 36 (184.22, 42.83): Kingsblood, z 55.95, ground 59.92 (4.0 yd under the ground)
UPDATE `gameobject` SET `position_z` = 59.92 WHERE `guid` IN (30004354) AND `id` IN (1624) AND `map` = 0;
-- map 0 zone 36 (341.97, -20.40): Kingsblood, z 142.46, ground 133.85 (8.6 yd in the air)
UPDATE `gameobject` SET `position_z` = 133.85 WHERE `guid` IN (30043469) AND `id` IN (1624) AND `map` = 0;
-- map 0 zone 36 (461.66, 202.05): Bruiseweed, z 42.44, ground 48.06 (5.6 yd under the ground)
UPDATE `gameobject` SET `position_z` = 48.06 WHERE `guid` IN (30003853) AND `id` IN (1622) AND `map` = 0;
-- map 0 zone 85 (2267.10, 972.92): Gloom Weed, z 57.58, ground 44.42 (13.2 yd in the air)
UPDATE `gameobject` SET `position_z` = 44.42 WHERE `guid` IN (30001082) AND `id` IN (175566) AND `map` = 0;
-- map 0 zone 130 (-744.93, 1409.78): Earthroot, z 38.38, ground 33.20 (5.2 yd in the air)
UPDATE `gameobject` SET `position_z` = 33.20 WHERE `guid` IN (30068575) AND `id` IN (1619) AND `map` = 0;
-- map 0 zone 130 (-744.47, 1409.05): Copper Vein, z 38.17, ground 33.22 (5.0 yd in the air)
UPDATE `gameobject` SET `position_z` = 33.22 WHERE `guid` IN (30014489) AND `id` IN (1731) AND `map` = 0;
-- map 0 zone 130 (-643.30, 789.86): Copper Vein, z 128.13, ground 121.62 (6.5 yd in the air)
UPDATE `gameobject` SET `position_z` = 121.62 WHERE `guid` IN (30042054) AND `id` IN (1731) AND `map` = 0;
-- map 0 zone 130 (-616.29, 1354.73): Mageroyal, z 36.35, ground 31.74 (4.6 yd in the air)
UPDATE `gameobject` SET `position_z` = 31.74 WHERE `guid` IN (30042052) AND `id` IN (1620) AND `map` = 0;
-- map 0 zone 130 (-606.56, 899.66): Earthroot, z 108.86, ground 105.52 (3.3 yd in the air)
UPDATE `gameobject` SET `position_z` = 105.52 WHERE `guid` IN (30068572) AND `id` IN (1619) AND `map` = 0;
-- map 0 zone 130 (-577.72, 1709.77): Copper Vein, z 22.06, ground 16.60 (5.5 yd in the air)
UPDATE `gameobject` SET `position_z` = 16.60 WHERE `guid` IN (30041915) AND `id` IN (1731) AND `map` = 0;
-- map 0 zone 130 (-577.12, 1550.49): Mageroyal, z 10.08, ground 19.22 (9.1 yd under the ground)
UPDATE `gameobject` SET `position_z` = 19.22 WHERE `guid` IN (30058562) AND `id` IN (1620) AND `map` = 0;
-- map 0 zone 130 (-573.70, 1325.55): Briarthorn, z 48.52, ground 38.31 (10.2 yd in the air)
UPDATE `gameobject` SET `position_z` = 38.31 WHERE `guid` IN (30042051) AND `id` IN (1621) AND `map` = 0;
-- map 0 zone 130 (-567.79, 1509.00): Briarthorn, z 10.77, ground 20.84 (10.1 yd under the ground)
UPDATE `gameobject` SET `position_z` = 20.84 WHERE `guid` IN (30068375) AND `id` IN (1621) AND `map` = 0;
-- map 0 zone 130 (-522.01, 1252.89): Copper Vein, z 68.45, ground 55.66 (12.8 yd in the air)
UPDATE `gameobject` SET `position_z` = 55.66 WHERE `guid` IN (30005289) AND `id` IN (1731) AND `map` = 0;
-- map 0 zone 130 (-519.84, 1466.36): Mageroyal, z 19.12, ground 10.70 (8.4 yd in the air)
UPDATE `gameobject` SET `position_z` = 10.70 WHERE `guid` IN (30040406) AND `id` IN (1620) AND `map` = 0;
-- map 0 zone 130 (-504.00, 1519.03): Briarthorn, z 16.77, ground 10.40 (6.4 yd in the air)
UPDATE `gameobject` SET `position_z` = 10.40 WHERE `guid` IN (30002764) AND `id` IN (1621) AND `map` = 0;
-- map 0 zone 130 (-473.58, 1463.86): Copper Vein, z 27.11, ground 17.81 (9.3 yd in the air)
UPDATE `gameobject` SET `position_z` = 17.81 WHERE `guid` IN (30042956) AND `id` IN (1731) AND `map` = 0;
-- map 0 zone 130 (-16.55, 463.37): Silver Vein, Tin Vein, z 53.63, ground 48.37 (5.3 yd in the air)
UPDATE `gameobject` SET `position_z` = 48.37 WHERE `guid` IN (30002406, 30031523) AND `id` IN (1732, 1733) AND `map` = 0;
-- map 0 zone 130 (192.60, 601.97): Silver Vein, Tin Vein, z 50.12, ground 54.26 (4.1 yd under the ground)
UPDATE `gameobject` SET `position_z` = 54.26 WHERE `guid` IN (30009687, 30016857) AND `id` IN (1732, 1733) AND `map` = 0;
-- map 0 zone 130 (368.11, 604.43): Silver Vein, Tin Vein, z 48.35, ground 44.45 (3.9 yd in the air)
UPDATE `gameobject` SET `position_z` = 44.45 WHERE `guid` IN (30016819, 30016830) AND `id` IN (1732, 1733) AND `map` = 0;
-- map 0 zone 267 (-1324.20, -610.36): Stranglekelp, z -42.90, ground -31.22 (11.7 yd under the ground)
UPDATE `gameobject` SET `position_z` = -31.22 WHERE `guid` IN (30050663) AND `id` IN (2045) AND `map` = 0;
-- map 0 zone 279 (-99.00, 244.97): Bruiseweed, z 53.28, ground 56.99 (3.7 yd under the ground)
UPDATE `gameobject` SET `position_z` = 56.99 WHERE `guid` IN (30002917) AND `id` IN (1622) AND `map` = 0;
-- map 0 zone 279 (-56.54, 293.34): Bruiseweed, z 53.31, ground 59.20 (5.9 yd under the ground)
UPDATE `gameobject` SET `position_z` = 59.20 WHERE `guid` IN (30024198) AND `id` IN (1622) AND `map` = 0;
-- map 0 zone 279 (-38.96, 192.55): Fadeleaf, z 50.71, ground 56.91 (6.2 yd under the ground)
UPDATE `gameobject` SET `position_z` = 56.91 WHERE `guid` IN (30028980) AND `id` IN (2042) AND `map` = 0;
-- map 0 zone 279 (465.74, 531.19): Liferoot, z 41.12, ground 37.73 (3.4 yd in the air)
UPDATE `gameobject` SET `position_z` = 37.73 WHERE `guid` IN (30032182) AND `id` IN (2041) AND `map` = 0;
-- map 0 zone 279 (473.58, 409.18): Liferoot, z 33.17, ground 36.98 (3.8 yd under the ground)
UPDATE `gameobject` SET `position_z` = 36.98 WHERE `guid` IN (30058659) AND `id` IN (2041) AND `map` = 0;
-- map 0 zone 279 (511.41, 316.15): Liferoot, z 33.60, ground 41.28 (7.7 yd under the ground)
UPDATE `gameobject` SET `position_z` = 41.28 WHERE `guid` IN (30374532) AND `id` IN (2041) AND `map` = 0;
-- map 1 zone 215 (-2253.30, -1152.76): Peacebloom, z -0.72, ground 4.94 (5.7 yd under the ground)
UPDATE `gameobject` SET `position_z` = 4.94 WHERE `guid` IN (30043933) AND `id` IN (1618) AND `map` = 1;
-- map 1 zone 215 (-2244.55, -1276.81): Silverleaf, z 28.80, ground 25.42 (3.4 yd in the air)
UPDATE `gameobject` SET `position_z` = 25.42 WHERE `guid` IN (30000759) AND `id` IN (1617) AND `map` = 1;
-- map 1 zone 215 (-441.69, 35.26): Earthroot, z 68.45, ground 73.20 (4.8 yd under the ground)
UPDATE `gameobject` SET `position_z` = 73.20 WHERE `guid` IN (30068591) AND `id` IN (1619) AND `map` = 1;
-- map 1 zone 357 (-4014.75, 1942.18): Gold Vein, Mithril Deposit, Truesilver Deposit, z 104.73, ground 116.52 (11.8 yd under the ground)
UPDATE `gameobject` SET `position_z` = 116.52 WHERE `guid` IN (30094604, 30094674, 30094639) AND `id` IN (1734, 2040, 2047) AND `map` = 1;
-- map 1 zone 357 (-4001.88, 1937.13): Goldthorn, z 105.72, ground 116.43 (10.7 yd under the ground)
UPDATE `gameobject` SET `position_z` = 116.43 WHERE `guid` IN (30050240) AND `id` IN (2046) AND `map` = 1;
-- map 1 zone 357 (-3823.00, 1222.52): Purple Lotus, z 150.90, ground 154.99 (4.1 yd under the ground)
UPDATE `gameobject` SET `position_z` = 154.99 WHERE `guid` IN (30029445) AND `id` IN (142140) AND `map` = 1;
-- map 1 zone 357 (-3624.59, 958.02): Purple Lotus, z 147.89, ground 152.09 (4.2 yd under the ground)
UPDATE `gameobject` SET `position_z` = 152.09 WHERE `guid` IN (30066969) AND `id` IN (142140) AND `map` = 1;
-- map 1 zone 405 (-668.33, 581.86): Silver Vein, Tin Vein, z 148.28, ground 154.44 (6.2 yd under the ground)
UPDATE `gameobject` SET `position_z` = 154.44 WHERE `guid` IN (30003818, 30003826) AND `id` IN (1732, 1733) AND `map` = 1;
-- map 1 zone 406 (1813.42, 629.74): Bruiseweed, z 218.03, ground 229.24 (11.2 yd under the ground)
UPDATE `gameobject` SET `position_z` = 229.24 WHERE `guid` IN (30068482) AND `id` IN (1622) AND `map` = 1;
-- map 1 zone 406 (2738.14, 1455.01): Wild Steelbloom, z 258.38, ground 254.71 (3.7 yd in the air)
UPDATE `gameobject` SET `position_z` = 254.71 WHERE `guid` IN (30056274) AND `id` IN (1623) AND `map` = 1;
-- map 1 zone 16651 (-2288.90, 1347.40): Silver Vein, Tin Vein, z 66.21, ground 71.69 (5.5 yd under the ground)
UPDATE `gameobject` SET `position_z` = 71.69 WHERE `guid` IN (30051223, 30051256) AND `id` IN (1732, 1733) AND `map` = 1;
-- map 1 zone 16651 (-2265.49, 1326.23): Grave Moss, z 63.67, ground 72.09 (8.4 yd under the ground)
UPDATE `gameobject` SET `position_z` = 72.09 WHERE `guid` IN (30029143) AND `id` IN (1628) AND `map` = 1;
-- map 1 zone 16651 (-2248.52, 1271.64): Gold Vein, Iron Deposit, Silver Vein, z 85.59, ground 88.73 (3.1 yd under the ground)
UPDATE `gameobject` SET `position_z` = 88.73 WHERE `guid` IN (30052849, 30052898, 30052947) AND `id` IN (1733, 1734, 1735) AND `map` = 1;
