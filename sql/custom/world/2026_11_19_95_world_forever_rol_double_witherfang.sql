-- Ruins of Lordaeron (map 2999): Witherfang (250483) stood in the dungeon twice. The official sniff spawn (21300000) walks a
-- patrol path; 2026_10_27_70 (Azeroth project sniffs) added a second Witherfang (43000408) 56 yards away, a spot on that
-- same patrol, which 2026_11_07_95's 20 yard double-spawn check did not catch. One boss, one spawn: the added copy goes, the
-- official spawn stays. Safe to run again.
DELETE FROM `creature_addon` WHERE `guid` = 43000408;
DELETE FROM `creature` WHERE `guid` = 43000408 AND `id` = 250483;
