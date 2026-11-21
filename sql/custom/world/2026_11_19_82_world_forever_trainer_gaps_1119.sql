-- WoW Forever: class trainer gaps against live (19 Nov). Only the full class lists every class trainer of that class uses
-- (2026_10_15_00): paladin 29, druid 17, rogue 26.
--   Druid (live trainer Naeluna Swiftmend 254081, client 1.60.1.70959):
--     Shred rank 1 (5221) at level 20 (ours 22; ranks 2 and 3 at 30 and 38 already match).
--     Poised (1328829, passive) at level 32 for 6000 copper: live's trainer teaches it, ours did not.
--   Paladin (live trainer Shari Stilwell 246152, client 1.60.1.70959):
--     Holy Shield rank 4 (1239570) at level 60 for 29000, after rank 3 (20928). Rank 1 is the talent, so only paladins who took it
--     can buy it, as ranks 2 and 3. (Seal of Fury 26, Holy Shield 40/50 are in 2026_11_17_81; Righteous Fury 10 in 2026_11_11_91.)
--   Rogue (Everlake's trainer ranks file 922: live's rogue trainers teach these):
--     Death Mark ranks 2-4 (1325756-1325758) at levels 48, 56, 60 for 43000, 48000, 51000, each after the rank before
--     (rank 1 1316709 is the Subtlety talent). Shank rank 2 (1329549) at level 44 for 23000, after rank 1 (1329283).
--     Costs are Everlake's listed costs without the 5% Friendly discount they include (30526 for Holy Shield 4 is live's 29000).
-- Data from Efficient Games (https://efficient.games), licensed under CC BY 4.0
-- (https://creativecommons.org/licenses/by/4.0/). Source: github.com/JIVESCORP/eg-link-output-wowf 30c3bb9, build 1.60.1.70959,
-- trainers.json. Changed: only these rows were picked and converted to our trainer_spell rows.
-- Rogue rows from Everlake's world data (buildthehomelab/wow-everlake-world-data 831178c, GPL-3.0), file
-- 2026_11_18_922_world_everlake_trainer_ranks.sql: its spell, level and cost list, written here as our own rows.
-- Not taken: Ghost Wolf 1238640 (live's shaman trainer lists it, but the client still has no SkillLineAbility row for it and live
-- sends none; see 2026_11_15_80).
-- Safe to run again.

UPDATE `trainer_spell` SET `ReqLevel` = 20 WHERE `TrainerId` = 17 AND `SpellId` = 5221 AND `ReqLevel` = 22; -- Shred rank 1, was 22

INSERT IGNORE INTO `trainer_spell` (`TrainerId`, `SpellId`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqAbility1`, `ReqAbility2`, `ReqAbility3`, `ReqLevel`, `VerifiedBuild`) VALUES
(17, 1328829, 6000, 0, 0, 0, 0, 0, 32, 70959),       -- Poised
(29, 1239570, 29000, 0, 0, 20928, 0, 0, 60, 70959),  -- Holy Shield rank 4
(26, 1325756, 43000, 0, 0, 1316709, 0, 0, 48, 0),    -- Death Mark rank 2
(26, 1325757, 48000, 0, 0, 1325756, 0, 0, 56, 0),    -- Death Mark rank 3
(26, 1325758, 51000, 0, 0, 1325757, 0, 0, 60, 0),    -- Death Mark rank 4
(26, 1329549, 23000, 0, 0, 1329283, 0, 0, 44, 0);    -- Shank rank 2
