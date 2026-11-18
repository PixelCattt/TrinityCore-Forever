-- Deep Pool Threshfin (4827, Blackfathom Deeps; VoldemarGreed "bugs 6", 2026-11-17: "stuck in the rock on the walkway by the
-- waterfall"). The ground probe (PC steps 151p and 151q) shows spawn 20027411 swimming in the pocket under the walkway: the walkway's
-- underside (-33.50) and top (-29.68) stand over it everywhere within 8 yards, so players see it inside the rock and cannot reach it.
-- Moved 12 yards north to the nearest open water (no surface over it within 16 yards; pool floor -36.09), at the same height above
-- the floor as the other Threshfin (0.08). Its 3 yard wander stays in the open (the probe points 4 to 6 yards around it are open too).
-- The other Threshfin are clear: 20027405 lies on a ledge beside open water. Safe to run again.
UPDATE `creature` SET `position_x` = -818.60, `position_y` = -42.69, `position_z` = -36.0
  WHERE `guid` = 20027411 AND `id` = 4827 AND ABS(`position_x` + 818.598) < 0.01 AND ABS(`position_y` + 54.6887) < 0.01;
