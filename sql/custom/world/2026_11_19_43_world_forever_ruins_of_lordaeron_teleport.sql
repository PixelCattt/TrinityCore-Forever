-- WoW Forever: .tele RuinsOfLordaeron (map 2999, the Ruins of Lordaeron dungeon) put a player at (1478.2, 33.8, -61.6), down in the
-- Undercity layout under the dungeon, 130 yd from the nearest of its 296 spawns, so the dungeon looked empty (Guard3259, RU forum,
-- through the admin addon's server teleport search). It now lands where the dungeon's own entrance does (world_safe_locs 1104100 of
-- 2026_10_11_00, the official server's entry point), with the dungeon's creatures in front. Safe to run again.
UPDATE `game_tele` SET `position_x` = 1804.15, `position_y` = 149.174, `position_z` = 70.399, `orientation` = 4.65
WHERE `name` = 'RuinsOfLordaeron' AND `map` = 2999;
