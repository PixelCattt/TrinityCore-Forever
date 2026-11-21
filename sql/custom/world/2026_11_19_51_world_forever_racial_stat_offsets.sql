-- Racial base stat offsets as on live WoW Forever since its 21 October racial stat fix: the vanilla offsets again.
-- The start sniff 2026_10_06_00 was taken on the beta before that fix and replaced the vanilla rows of 2026_10_01_06 with the modern
-- offsets (no racial Spirit, Tauren +2 Strength, Night Elf +2 Agility, Orc +1 Stamina). Races 1-8 are the vanilla rows again (VMaNGOS
-- player_levelstats split into race offset and class stats: a level 1 warrior is 20 in each stat plus the race's, so Human Spirit 21,
-- Orc 23, Undead 25 as in vanilla). Found through Everlake (GPL, PR 81 and its 2026_11_17_45, forever-bugs #414).
-- The two Skyborne races have their own offsets, read from level 1 naked character sheets on 6 November, after the fix: High Order
-- Skyborne -3/+4/-1/+4/-3, Windshaper Skyborne -4/+3/0/-1/+3 (wowsims/forever, MIT, docs/evidence EV-0093). Both had the beta's shared
-- -1/+1/-1/+1/0. Safe to run again.
DELETE FROM `player_racestats` WHERE `race` IN (1, 2, 3, 4, 5, 6, 7, 8, 95, 96);
INSERT INTO `player_racestats` (`race`, `str`, `agi`, `sta`, `inte`, `spi`) VALUES
(1,  0,  0,  0,  0,  1),    -- Human
(2,  3, -3,  2, -3,  3),    -- Orc
(3,  2, -4,  3, -1, -1),    -- Dwarf
(4, -3,  5, -1,  0,  0),    -- Night Elf
(5, -1, -2,  1, -2,  5),    -- Undead
(6,  5, -5,  2, -5,  2),    -- Tauren
(7, -5,  3, -1,  4,  0),    -- Gnome
(8,  1,  2,  1, -4,  1),    -- Troll
(95, -3, 4, -1,  4, -3),    -- High Order Skyborne (Alliance)
(96, -4, 3,  0, -1,  3);    -- Windshaper Skyborne (Horde)
