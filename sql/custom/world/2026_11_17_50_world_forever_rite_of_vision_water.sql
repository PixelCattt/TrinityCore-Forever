-- Rite of Vision (772, Mulgore) could not be handed in after doing what the quest says (Russian forum report, 2026-11-14, 0.1.36).
-- The live quest data of 2026_11_12_14 added objective 480587: carry 1 Water of the Seers (4823). The quest itself hands you that
-- water (StartItem 4823) and tells you to drink it at the fire. Drinking casts 4981 (summon The Plains Vision 2983), and the client
-- data gives the item one charge that deletes it (ItemEffect 98275, Charges -1). So after drinking, the objective went back to 0/1
-- and Seer Wildmane would not take the quest; only abandoning and handing it in without drinking worked.
-- The objective is removed again, as it was up to 0.1.35: the quest is done once taken, and the vision leads you to Wildmane.
-- Players who already drank: abandon the quest and take it again from Zarlman Two-Moons.
-- Safe to run again.
DELETE FROM `quest_objectives` WHERE `ID` = 480587 AND `QuestID` = 772;
