-- Riverglades, Turner's Logging Camp: graveyard 1101203 and its spirit healer 47220003 (2026_11_10_70, ESTIMATED heights) lay 4 yards
-- under the ground: .playerbot graveyardscan 0 on dev (PC confirm run B2, 17 Nov) found the terrain at 25.7 under the graveyard's
-- 21.6, so a ghost released there came up inside the hill. Both go onto the ground (the scan's 0.5 yards above the terrain).
UPDATE `world_safe_locs` SET `LocZ` = 26.24 WHERE `ID` = 1101203 AND ABS(`LocZ` - 21.6) < 0.05;
UPDATE `creature` SET `position_z` = 26.24 WHERE `guid` = 47220003 AND `id` = 6491 AND ABS(`position_z` - 21.6) < 0.05;
