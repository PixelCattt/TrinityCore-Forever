-- Thendal Village (Skyborne start, map 2991): the Minor Manifestation of Earth (251166), who starts the shaman's Call of Earth (92468),
-- stood inside a rock (Discord, 6_1_8_8_1 "Bugs 3" 2, 2026-11-16). Ground probe (PC step 146f, 2026-11-16): the spawn at 1024.76 is
-- 1.2 yd under the top of the rock it stands in (collision surface 1025.991; terrain 1023.795 under the rock). It goes onto the
-- rock top, the surface the server itself finds from just above the spawn. INFERRED: no sniff of this spawn.
-- Moves only while it still has the old height. Safe to run again.
UPDATE `creature` SET `position_z` = 1025.991 WHERE `guid` = 25116600 AND `id` = 251166 AND ABS(`position_z` - 1024.76) < 0.01;
