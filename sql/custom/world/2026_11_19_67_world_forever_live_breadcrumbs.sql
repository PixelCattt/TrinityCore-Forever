-- Quests we locked behind a breadcrumb. EG Link quest_prerequisites (builds 70790-70959): live characters took these quests without
-- the quest we asked for, so on Forever the earlier quest only points the way. It becomes a breadcrumb (gone once the quest is taken
-- or done), the quest itself needs nothing.
-- Data from Efficient Games (https://efficient.games), licensed under CC BY 4.0 (https://creativecommons.org/licenses/by/4.0/)
--   429 Wild Hearts (Rane Yorick): needed 428 Lost Deathstalkers (High Executor Hadrec), which sends you to Rane
--   1131 Steelsnap (Melor Stonehoof): needed 1130 Melor Sends Word (Thunder Bluff), which sends you to Melor
--   96627 The Adventurer (Marshal McBride, a breadcrumb itself, min level 4): needed 91752 The Big Picture
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE `ID` = 429 AND `PrevQuestID` = 428;
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE `ID` = 1131 AND `PrevQuestID` = 1130;
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE `ID` = 96627 AND `PrevQuestID` = 91752;
INSERT INTO `quest_template_addon` (`ID`, `BreadcrumbForQuestId`) VALUES (428, 429), (1130, 1131)
ON DUPLICATE KEY UPDATE `BreadcrumbForQuestId` = VALUES(`BreadcrumbForQuestId`);
-- A NextQuestID on the earlier quest would make it required again (Player::SatisfyQuestDependentPreviousQuests)
UPDATE `quest_template_addon` SET `NextQuestID` = 0 WHERE (`ID` = 428 AND `NextQuestID` = 429) OR (`ID` = 1130 AND `NextQuestID` = 1131) OR (`ID` = 91752 AND `NextQuestID` = 96627);
