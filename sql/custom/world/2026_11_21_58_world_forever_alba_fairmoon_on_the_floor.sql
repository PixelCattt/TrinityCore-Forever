-- Westfall: Alba Fairmoon (253092) in the Sentinel Hill inn stood about 0.5 yd above the floorboards. 2026_11_13_31 put her at
-- 35.28 (navmesh height); the floor there is 34.77 (dev check 2026-11-21, .playerbot groundz 0 -10636.7 1182.67: surfaces 45.16
-- and 34.77). Checks guid and entry, so it only moves our own spawn. Safe to run again.
UPDATE `creature` SET `position_z` = 34.77 WHERE `guid` = 25309200 AND `id` = 253092;
