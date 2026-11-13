-- Resupplying the Excavation (273, Loch Modan) could never be completed (Discord "bugs 4", 2026-11-13: "no marker on the map").
-- 2026_11_06_50 took its area trigger 171 away (gone from the 1.60 client) and gave the quest a Huldar objective instead, but a
-- second, catch-all area trigger objective (90002730, ObjectID -1) stayed; it is in no sql file of ours and comes with the
-- shipped world database. With no trigger left that names the quest it can never be filled, so the quest never completes.
-- Only this one goes: 14 other go-there quests carry the same catch-all objective next to their real trigger objective, but
-- there both share storage index 0, so the one trigger entry fills both (PC step 104).
-- Safe to run again.
DELETE FROM `quest_objectives` WHERE `ID` = 90002730 AND `QuestID` = 273 AND `Type` = 10 AND `ObjectID` = -1;
