-- WoW Forever: warrior ability threat as measured in Forever logs (wowsims/forever, MIT, tools/database/overrides/spell_overrides.go and
-- sim/warrior/*.go; evidence notes named per line). Replaces the VMaNGOS 1.12 rows of 2026_10_25_35 for these spells. flatMod is added once
-- per cast (split over the targets) and pctMod scales the damage's threat, both times the stance; apPctMod adds that share of attack power.
-- Safe to run again.
DELETE FROM `spell_threat` WHERE `entry` IN (78,284,285,1608,11564,11565,11566,11567,25286, 845,7369,11608,11609,20569, 23922,23923,23924,23925, 7386,7405,8380,11596,11597,
  6572,6574,7379,11600,11601,25288, 7384,7887,11584,11585, 72,1671,1672, 1715,7372,7373, 12809, 6343,8198,8204,8205,11580,11581);
INSERT INTO `spell_threat` (`entry`, `flatMod`, `pctMod`, `apPctMod`) VALUES
-- Heroic Strike: damage + 17 / 28 / 40 / 60, then 2.5 a spell level (EV-0043, EV-0004, EV-0048); vanilla 20 / 39 / 59 / 78 ... 175
(78, 17, 1, 0), (284, 28, 1, 0), (285, 40, 1, 0), (1608, 60, 1, 0), (11564, 80, 1, 0), (11565, 100, 1, 0), (11566, 120, 1, 0), (11567, 140, 1, 0), (25286, 150, 1, 0),
-- Cleave: damage + 30 / 46 / 60 / 80 / 96, split over the targets (EV-0045, EV-0042, EV-0050); vanilla 10 / 40 / 60 / 70 / 100
(845, 30, 1, 0), (7369, 46, 1, 0), (11608, 60, 1, 0), (11609, 80, 1, 0), (20569, 96, 1, 0),
-- Shield Slam: damage + 178 / 203 / 229 / 255 (EV-0004, EV-0050); vanilla Rank 4 254
(23922, 178, 1, 0), (23923, 203, 1, 0), (23924, 229, 1, 0), (23925, 255, 1, 0),
-- Sunder Armor: the client's own threat effect (34, 75, 117 ...) plus 5% of attack power (EV-0042, EV-0048); the vanilla flat 45 ... 261
-- came on top of that effect
(7386, 0, 1, 0.05), (7405, 0, 1, 0.05), (8380, 0, 1, 0.05), (11596, 0, 1, 0.05), (11597, 0, 1, 0.05),
-- Revenge: 2.25 x damage, no flat (EV-0048, EV-0043); vanilla added 63 ... 270
(6572, 0, 2.25, 0), (6574, 0, 2.25, 0), (7379, 0, 2.25, 0), (11600, 0, 2.25, 0), (11601, 0, 2.25, 0), (25288, 0, 2.25, 0),
-- Overpower: 0.75 x damage (EV-0043); only Rank 1 had a row
(7384, 0, 0.75, 0), (7887, 0, 0.75, 0), (11584, 0, 0.75, 0), (11585, 0, 0.75, 0),
-- Shield Bash: 1.5 x damage, no flat (a Rank 1 crit for 8 reads 12; EV-0044); vanilla added 36 / 96 / 156
(72, 0, 1.5, 0), (1671, 0, 1.5, 0), (1672, 0, 1.5, 0),
-- Hamstring: 1.25 x damage, no flat (EV-0043); vanilla added 20 / 80 / 135
(1715, 0, 1.25, 0), (7372, 0, 1.25, 0), (7373, 0, 1.25, 0),
-- Concussion Blow: no threat (EV-0048); no row before, so the core added the spell level
(12809, 0, 0, 0),
-- Thunder Clap: 1 x damage, no flat (EV-0048); vanilla Rank 1 2.5 x, the other ranks the spell level on top
(6343, 0, 1, 0), (8198, 0, 1, 0), (8204, 0, 1, 0), (8205, 0, 1, 0), (11580, 0, 1, 0), (11581, 0, 1, 0);
