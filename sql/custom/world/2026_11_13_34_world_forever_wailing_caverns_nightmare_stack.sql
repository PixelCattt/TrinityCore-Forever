-- Wailing Caverns (map 43): fifteen Deviate Nightmares (5914) stood on one spot in the cave, eleven of them within 6 yards
-- of each other at 111, 242 (Discord "bugs 3", 2026-11-13: "should there really be such a huge crowd of mobs here?").
-- They came in with the AnoCore port in 2026_11_05_99 (guids 591400-591414, the only map 43 rows of that file). Deviate
-- Nightmares are not standing spawns: neither the base world nor vMaNGOS (June 2021 world dump, 0 rows for 5914 on map 43)
-- spawns one, so the fifteen go. Every other Wailing Caverns count matches vMaNGOS (checked creature by creature, PC step 102).
-- The 2026_11_05_99 rows only have creature rows (no addon, pool or group rows). Safe to run again.
DELETE FROM `creature` WHERE `guid` BETWEEN 591400 AND 591414 AND `id` = 5914 AND `map` = 43;
