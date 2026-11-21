-- The Shaper's Terrace (map 3001): the third Ironhide Ravasaur pack (261786, guids 48140079-48140081, an INFERRED spot from
-- 2026_11_19_72) stood 4-5 yards from the Tar Pits (liquid type 1284, which burns). Its fight spilled into the tar, and in the
-- shapers_full test of 20 Nov a rogue chasing one of them died there. The pack moves to dry ground north of the landing:
-- 40 yards and more from any tar or water on our mesh, 64 yards from the next pack, 52 yards off the bot route, on the same
-- walkable ground as the landing. Still an inferred spot. Safe to run again.
UPDATE `creature` SET `position_x` = -5800.65, `position_y` = -1196.98, `position_z` = -5.96 WHERE `guid` = 48140079 AND `id` = 261786;
UPDATE `creature` SET `position_x` = -5798.75, `position_y` = -1199.92, `position_z` = -6.00 WHERE `guid` = 48140080 AND `id` = 261786;
UPDATE `creature` SET `position_x` = -5799.02, `position_y` = -1193.88, `position_z` = -5.78 WHERE `guid` = 48140081 AND `id` = 261786;
