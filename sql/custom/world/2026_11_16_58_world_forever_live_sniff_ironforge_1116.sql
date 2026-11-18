-- WoW Forever live realm: English capture from 2026-11-16 (client 70938): Ironforge and Elwynn. Only what our data lacks
-- or has wrong. Safe to run more than once. No new spawns.

-- 1. Factions live sends that differ from ours.
UPDATE `creature_template` SET `faction` = 3634 WHERE `entry` = 263643;   -- Sean Guardoff (same as 263349 and 263644 next to him)
UPDATE `creature_template` SET `faction` = 57 WHERE `entry` = 274935;   -- Ironforge Protector

-- 2. Models live. New displays get their creature_model_info row (size as live sends it, scale 1), or the creature won't spawn.
DELETE FROM `creature_model_info` WHERE `DisplayID` IN (143349, 147850);
INSERT INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `DisplayID_Other_Gender`, `VerifiedBuild`) VALUES (143349, 0.3672, 1.8, 0, 70938), (147850, 0.347, 1.5, 0, 70938);
-- High Tinker Mekkatorque 7937: new model 143349 at scale 1 (ours old 7006 at 1.38); Snowshoe Rabbit 7560; White Kitten 7386.
DELETE FROM `creature_template_model` WHERE `CreatureID` = 7937;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES (7937, 0, 143349, 1, 100, 70938);
DELETE FROM `creature_template_model` WHERE `CreatureID` = 7560;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES (7560, 0, 6302, 1, 1, 70938);
DELETE FROM `creature_template_model` WHERE `CreatureID` = 7386;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES (7386, 0, 9989, 1, 1, 70938);
-- Ironforge Protector 274935: live picks from 147846, 147847, 147848 and 147850. Only 147846 and 147850 were seen in this
-- capture, so only those two have a size we can back; the other two are left out.
DELETE FROM `creature_template_model` WHERE `CreatureID` = 274935;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES (274935, 0, 147846, 1, 1, 70938), (274935, 1, 147850, 1, 1, 70938);

-- 3. Weapons live NPCs carry and ours don't (ours had no equipment row).
DELETE FROM `creature_equip_template` WHERE `ID` = 1 AND `CreatureID` IN (274917, 273127, 263643, 274781, 274873, 274935);
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `AppearanceModID1`, `ItemVisual1`, `ItemID2`, `AppearanceModID2`, `ItemVisual2`, `ItemID3`, `AppearanceModID3`, `ItemVisual3`, `VerifiedBuild`) VALUES (274917, 1, 1911, 0, 0, 0, 0, 0, 0, 0, 0, 70938), (273127, 1, 5287, 0, 0, 0, 0, 0, 0, 0, 0, 70938), (263643, 1, 5598, 0, 0, 0, 0, 0, 0, 0, 0, 70938), (274781, 1, 284597, 0, 0, 6254, 0, 0, 2552, 0, 0, 70938), (274873, 1, 2182, 0, 0, 12980, 0, 0, 0, 0, 0, 70938), (274935, 1, 5286, 0, 0, 6254, 0, 0, 2552, 0, 0, 70938);
-- Their spawns had equipment_id 0 (no weapons); 1 uses the row above.
UPDATE `creature` SET `equipment_id` = 1 WHERE `equipment_id` = 0 AND `id` IN (274917, 273127, 263643, 274781, 274873, 274935);

-- 4. Misplaced Packages 660964: live sends Data1 = 30202.
UPDATE `gameobject_template` SET `Data1` = 30202 WHERE `entry` = 660964;
