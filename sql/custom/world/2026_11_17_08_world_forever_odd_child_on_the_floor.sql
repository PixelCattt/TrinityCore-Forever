-- Odd Child (249713, Westfall 41,79, Discord "bugs 3": "stuck in the floor" of the dark stone room). The ground probe (PC step 151p)
-- puts the floor under spawn 24971300 at 42.84, a quarter yard above it (42.583, from the AnoCore port). Raised onto the floor.
-- Safe to run again.
UPDATE `creature` SET `position_z` = 42.85 WHERE `guid` = 24971300 AND `id` = 249713 AND ABS(`position_z` - 42.583) < 0.01;
