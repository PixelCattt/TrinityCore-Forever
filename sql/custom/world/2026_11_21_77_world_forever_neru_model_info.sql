-- Neru (271458, Wetlands, quest Gleaning Our Future 98310) never spawned: its display 146665 (Wowhead Forever "View in 3D") has
-- no `creature_model_info` row, so Creature::InitEntry finds no model data and drops the spawn ("has invalid model 146665 defined
-- in table creature_template_model, can't load"). Its twin Modr (271460, display 473) has one and spawns. The sizes come from
-- Modr's model, the same golem kind of the same quest, until a sniff gives Neru's own. Safe to run again.
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `DisplayID_Other_Gender`, `VerifiedBuild`)
SELECT 146665, `BoundingRadius`, `CombatReach`, 0, 0 FROM `creature_model_info` WHERE `DisplayID` = 473;
