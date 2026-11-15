-- Server crash and map 0 hang at the Duskwood crossroads (Discord, zeroyka and baskerville0356, 2026-11-14, 0.1.36). Watcher
-- Dodds (888) at the crossroads was listed as quest giver of quest 236, which in this world DB is the Wintergrasp quest Fueling
-- the Demolishers (defenders), offered only while the Alliance holds Wintergrasp (conditions, condition_is_wintergrasp_alliance).
-- Its speech bubble check ran that Wintergrasp script in Duskwood, where it crashed (fixed in the script itself). Watcher Dodds
-- has no Wintergrasp quest: EG Link saw no quest 236 on Forever, so the stray starter and ender rows go. Safe to run again.
-- (Data from Efficient Games (https://efficient.games), licensed under CC BY 4.0.)
DELETE FROM `creature_queststarter` WHERE `id` = 888 AND `quest` = 236;
DELETE FROM `creature_questender` WHERE `id` = 888 AND `quest` = 236;
