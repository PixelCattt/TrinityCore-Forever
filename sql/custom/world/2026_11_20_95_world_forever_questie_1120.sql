-- WoW Forever quest chain fix from Questie (Questie team, Questie/QuestieDB, GPL-3.0), commit 48ce570e: its Forever corrections.
-- Changed: compared with our world and written as our own rows, only where ours was wrong. Safe to run more than once.

-- Friend of the Kirin Tor (92459) follows either Heart of Disruption: 92458 (from An Alarming Request) or 96984 (from Blood in
-- the Streets). The two are one exclusive group, so a player can only ever do one of them, but ours asked for 92458 alone, and
-- the chain ended for everyone who came through Blood in the Streets. Questie gives "92458 or 96984". On this core that is
-- written as both quests leading to 92459 (NextQuestID) with no single PrevQuestID.
UPDATE `quest_template_addon` SET `PrevQuestID`=0 WHERE `ID`=92459 AND `PrevQuestID`=92458;
UPDATE `quest_template_addon` SET `NextQuestID`=92459 WHERE `ID` IN (92458,96984) AND `NextQuestID`=0;
