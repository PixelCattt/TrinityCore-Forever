-- WoW Forever live quest data from Questie (Questie team, Questie/QuestieDB, GPL-3.0), commit 4f628e83: its Forever corrections.
-- Checked against EG Link's quest prerequisite scan (Efficient Games, JIVESCORP/eg-link-output-wowf commit 30c3bb9, folder
-- 1.60.1.70959, CC BY 4.0). Changed: compared with our world and written as our own rows, only where ours was wrong.
-- Safe to run more than once.

-- The Adventurer (96627, Marshal McBride in Northshire, the Human start of the Camping 101 chain) needed The Big Picture (91752, a
-- Mining quest) because of an old sniff, so a Human without that quest could never get it. On live it follows Skirmish at Echo
-- Ridge (21): Questie gives 21, and every character EG Link saw take 96627 had done 21 and not 91752. The other six starts of
-- the chain already match live.
-- Another 19 Nov prerequisite fix (file 67) clears it to 0 and sorts first, so both old values are matched.
UPDATE `quest_template_addon` SET `PrevQuestID`=21 WHERE `ID`=96627 AND `PrevQuestID` IN (0,91752);
