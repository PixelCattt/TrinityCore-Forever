-- WoW Forever live data from EG Link (Efficient Games), JIVESCORP/eg-link-output-wowf commit 06b4cc7, folder 1.60.1.70938
-- (collected to 17 Nov). Data from Efficient Games (https://efficient.games), licensed under CC BY 4.0
-- (https://creativecommons.org/licenses/by/4.0/). Changed: compared with our world and written as TrinityCore rows; only what the
-- 17 Nov file (2026_11_17_96) did not already take. Safe to run more than once.

-- 1. Quest XP as live's quest record gives it (difficulty and multiplier, the same check as 15 and 17 Nov).
UPDATE `quest_template` SET `RewardXPDifficulty`=0, `RewardXPMultiplier`=1 WHERE `ID`=1878; -- Water Pouch Bounty (repeatable)
UPDATE `quest_template` SET `RewardXPDifficulty`=5, `RewardXPMultiplier`=2 WHERE `ID`=8949; -- Falrin's Vendetta

-- 2. Control Four Bases (8114) is offered from level 50 on live (ours 60).
UPDATE `quest_classic_level` SET `MinLevel`=50 WHERE `ID`=8114 AND `MinLevel`=60;

-- 3. Naluk (261313) sells four more drinks and foods on live, for money: Moonberry Juice, Cured Ham Steak, Morning Glory Dew and
--    Roasted Quail.
DELETE FROM `npc_vendor` WHERE `entry`=261313 AND `ExtendedCost`=0 AND `type`=1 AND `item` IN (1645,4599,8766,8952);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(261313,3,1645,0,0,0,1,0,0,0),
(261313,4,4599,0,0,0,1,0,0,0),
(261313,5,8766,0,0,0,1,0,0,0),
(261313,6,8952,0,0,0,1,0,0,0);
