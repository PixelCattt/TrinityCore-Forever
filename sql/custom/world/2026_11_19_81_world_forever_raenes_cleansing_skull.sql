-- Ashenvale, Raene's Cleansing 1045 and 1046 (bug-report forum 2026-11-18, VoldemarGreed, "bugs 7" items 4 and 5).
-- 2026_11_12_14 gave 1045 live's objective "Ran Bloodtooth's Skull" (5388, objective 381127) in place of our old "kill Ran
-- Bloodtooth" (90010450). Two things still followed the old quest:
-- 1. The map area for that objective still named the deleted objective, so the skull had no marker. Ran drops the skull, so it is
--    the same area (Ran Bloodtooth 3696 stands at 1612.5, -1457.1; the area's point is 1613, -1457): it now names the skull.
-- 2. Turning in 1045 now takes the skull, and 1046 asks for it again (with Dartol's Rod). Live hands a new skull when 1046 is taken
--    (EG Link, Efficient Games, https://efficient.games, CC BY 4.0: quests.enUS.json 1.60.1.70938, 1046 startItemId 5388); ours gave
--    none, so 1046 could not be finished. Players who already hold 1046: abandon it and take it again from Krolg.
-- Safe to run again.
UPDATE `quest_poi` SET `ObjectiveIndex` = 0, `QuestObjectiveID` = 381127, `QuestObjectID` = 5388
 WHERE `QuestID` = 1045 AND `BlobIndex` = 0 AND `Idx1` = 0 AND `QuestObjectiveID` = 90010450;
UPDATE `quest_template` SET `StartItem` = 5388 WHERE `ID` = 1046 AND `StartItem` = 0;
