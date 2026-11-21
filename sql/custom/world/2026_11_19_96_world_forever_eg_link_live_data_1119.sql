-- WoW Forever live data from EG Link (Efficient Games), JIVESCORP/eg-link-output-wowf commit 30c3bb9, folder 1.60.1.70959
-- (collected 18 Nov). Data from Efficient Games (https://efficient.games), licensed under CC BY 4.0
-- (https://creativecommons.org/licenses/by/4.0/). Changed: compared with our world and written as TrinityCore rows; only what the
-- new folder shows that the 15, 17 and 18 Nov files (2026_11_15_96, 2026_11_17_96, 2026_11_18_96) did not already take.
-- Safe to run more than once.

-- 1. Paragons of Power: The Madcap's Bracers (8063) asks for Friendly with the Zandalar Tribe on live (hidden objective, like the
--    other Paragons of Power quests of 14 and 17 Nov).
DELETE FROM `quest_objectives` WHERE `ID`=382862;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(382862,8063,6,1,1,270,3000,0,0,0,0,0,1,NULL,70959);

-- 2. Quest XP as live's quest record gives it: three An Earnest Proposition quests have multiplier 2, like the other five of 17 Nov.
UPDATE `quest_template` SET `RewardXPMultiplier`=2 WHERE `ID` IN (8910,8912,8920) AND `RewardXPDifficulty`=5;

-- 3. The Battle of Alterac (7141), The Battle for Alterac (7142) and Hero of the Frostwolf (8272) are offered from level 58 on
--    live (ours 51).
UPDATE `quest_classic_level` SET `MinLevel`=58 WHERE `ID` IN (7141,7142,8272) AND `MinLevel`=51;

-- 4. I See Alcaz Island In Your Future... (8970): live's reward spell is 364156 (Divining Trance), ours used 5017 (the other
--    Divining Trance), the same kind of change as 5306 and 5307 on 15 and 17 Nov.
UPDATE `quest_template` SET `RewardSpell`=364156 WHERE `ID`=8970 AND `RewardSpell`=5017;
