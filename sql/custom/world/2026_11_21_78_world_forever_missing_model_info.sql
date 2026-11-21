-- 28 spawned creatures (Neru is 2026_11_21_77) use displays with no `creature_model_info` row. Without it Creature::InitEntry finds
-- no model data and drops the spawn silently ("has invalid model N ... can't load"), so these creatures were never in the world:
-- Decrepit Pylon Protector (33 spawns), Corpsefeeder (24), Terrible Tulip (18), Veteran of the Third War (10), Converted Farmer (9),
-- Doomkin, Tainted Hyjal Bear (8 each) and more (PC sweep missing-model-info-1121.txt, dev world 11-21 02:13).
-- Sizes: no sniff has these displays yet, so each takes the size of a known creature of the same kind (`ref`, its first display
-- with a row; read before this insert adds any), else the given fallback (a human-sized 0.306 / 1.5 for people). A later sniff replaces them. Safe to run again.
DROP TEMPORARY TABLE IF EXISTS `tmp_model_size`;
CREATE TEMPORARY TABLE `tmp_model_size` (`DisplayID` INT UNSIGNED NOT NULL PRIMARY KEY, `ref` INT UNSIGNED NOT NULL,
    `br` FLOAT NOT NULL, `cr` FLOAT NOT NULL);
INSERT INTO `tmp_model_size` (`DisplayID`, `ref`, `br`, `cr`) VALUES
(114515,     36, 0.85, 2.00),   -- Harvest Golem V000-A 212252 (as Harvest Golem 36)
(116033,     38, 0.306, 1.5),   -- Dro'zem the Blasphemous 214456
(116412,     38, 0.306, 1.5),   -- Tokal 215643
(116415,     38, 0.306, 1.5),   -- Illari Duskfeather 215655
(117330,     38, 0.306, 1.5),   -- Aeonas the Vindicated 218160
(118567,     38, 0.306, 1.5),   -- Demented Fire Weaver 221175
(118584,      0, 0.50, 2.00),   -- Wyrmkin Terrorwalker 221200, Nightstalker 221259, Starhunter 221325 (dragonkin)
(118592,      0, 1.50, 4.50),   -- Vengeful Ancient 221263 (an ancient)
(118604,   2927, 0.75, 2.25),   -- Doomkin 221333 (owlbeast, as Vicious Owlbeast 2927)
(118686,     38, 0.306, 1.5),   -- Elrick 221575
(118930,     38, 0.306, 1.5),   -- Tyrisius 221985
(119313,      0, 1.50, 4.50),   -- The Giant 222789
(121693,     38, 0.306, 1.5),   -- Orthas 228619
(121859,     38, 0.306, 1.5),   -- Rotting Dwarf Corpse 229018
(148859,    822, 0.75, 2.25),   -- Tainted Hyjal Bear 244530 (as Young Forest Bear 822)
(137523,     36, 0.85, 2.00),   -- Decrepit Pylon Protector 252711 (a construct)
(137848,     38, 0.306, 1.5),   -- Corpsefeeder 253394
(138260, 254566, 0.50, 1.50),   -- Terrible Tulip 254567 display 0 (as its twin Rowdy Rose 254566, whose third display has a row)
(138261, 254566, 0.50, 1.50),   -- Terrible Tulip 254567 display 1
(138254, 254566, 0.50, 1.50),   -- Rowdy Rose 254566 display 0 (it spawned only with its other display)
(138258, 254566, 0.50, 1.50),   -- Rowdy Rose 254566 display 2
(138589,     38, 0.306, 1.5),   -- Gimashi 255003
(144574,     38, 0.306, 1.5),   -- Veteran of the Third War 255009
(145171,     38, 0.306, 1.5),   -- Executioner Morg 256891
(140431,     38, 0.306, 1.5),   -- Admiral Lamora 257861
(141425,     38, 0.306, 1.5),   -- Converted Farmer 259258
(145741,      0, 0.50, 2.00);   -- Mirrorscale 269057

INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `DisplayID_Other_Gender`, `VerifiedBuild`)
SELECT t.`DisplayID`,
    COALESCE((SELECT m.`BoundingRadius` FROM `creature_template_model` c JOIN `creature_model_info` m ON m.`DisplayID` = c.`CreatureDisplayID`
              WHERE c.`CreatureID` = t.`ref` ORDER BY c.`Idx` LIMIT 1), t.`br`),
    COALESCE((SELECT m.`CombatReach` FROM `creature_template_model` c JOIN `creature_model_info` m ON m.`DisplayID` = c.`CreatureDisplayID`
              WHERE c.`CreatureID` = t.`ref` ORDER BY c.`Idx` LIMIT 1), t.`cr`),
    0, 0
FROM `tmp_model_size` t;
DROP TEMPORARY TABLE `tmp_model_size`;
