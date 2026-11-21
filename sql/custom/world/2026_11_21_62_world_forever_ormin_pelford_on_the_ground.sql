-- Elwynn Forest: Ormin Pelford (248265) stood 1.35 yd above the ground beside the fence east of Goldshire after
-- 2026_11_19_80 (dev check 2026-11-21: z 43.86, ground 42.51 at -9607.0, -1119.2). Put him on the ground.
-- Checks guid and entry, so it only moves our own spawn. Safe to run again.
UPDATE `creature` SET `position_z` = 42.51 WHERE `guid` = 24826500 AND `id` = 248265;
