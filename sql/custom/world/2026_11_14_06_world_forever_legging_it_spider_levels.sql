-- Legging It (96821, Durotar): the Ridgeshade Creepers (266850) and Ridgeshade Lurkers (266849) are level 1 (Discord, noobiru,
-- 2026-11-14). The 10-01 sniff gave them ContentTuningID 0 and no classic level, so they fell to level 1. Live shows the Creeper
-- at level 5-6 (Wowhead Forever tooltip in the report); the quest is level 6. The Lurker gets the same range (INFERRED, its live
-- level is not in our data). Safe to run again.
DELETE FROM `creature_classic_level` WHERE `entry` IN (266849,266850);
INSERT INTO `creature_classic_level` (`entry`,`level_min`,`level_max`) VALUES (266849,5,6),(266850,5,6);
