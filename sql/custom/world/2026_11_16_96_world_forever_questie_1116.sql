-- WoW Forever live quest data from Questie (QuestieDB c0718536, GPL-3.0), picked on 16 Nov: only what ours had wrong.
-- Not their files: their values were compared with ours and only the differences are written here. Safe to run more than once.

-- Blacksmithing skill that two quests from Tormus Deepforge (6031, Ironforge) need on live:
-- 1578 Supplying the Front: Blacksmithing 25 (ours asked for no skill); 1618 Gearing Redridge: Blacksmithing 35 (ours 60).
INSERT INTO `quest_template_addon` (`ID`,`RequiredSkillID`,`RequiredSkillPoints`) VALUES (1578,164,25),(1618,164,35)
ON DUPLICATE KEY UPDATE `RequiredSkillID`=VALUES(`RequiredSkillID`),`RequiredSkillPoints`=VALUES(`RequiredSkillPoints`);
