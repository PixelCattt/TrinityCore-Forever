-- Elwynn Forest: Ormin Pelford (248265, quest Downstream 91733) stood inside a fence east of Goldshire (bug-report forum
-- 2026-11-18, Gremloc, "Ormin Pelford (In Elwynn Forest) Spawned in fencing").
-- His spawn came back with the Forever quest data (2026_11_05_99) at -9606.08, -1116.3, about 3 yd off the live spot.
-- Live spot from EG Link (Efficient Games, https://efficient.games, CC BY 4.0), npcs.json build 1.60.1.70938 (seen 2026-11-16):
-- uiMap 1429 at 0.7648, 0.7204 = world -9607.0, -1119.2. Height: walkable navmesh point at that spot (mmap_probe on the test realm).
-- Each row checks guid and entry, so it only moves our own spawn. Safe to run again.
UPDATE `creature` SET `position_x` = -9607.0, `position_y` = -1119.2, `position_z` = 42.406 WHERE `guid` = 24826500 AND `id` = 248265;
