-- Dire Maul: the Warpwood Crusher (13021) is drawn three and a half times too big (fix pack idea from SIN, #team-members
-- 2026-11-14, "Reduced the Warpwood Crusher's display scale from 3.5 to 1.0"), written again here. Its one model 12929 had
-- DisplayScale 3.5 from the shipped world database; the client already sizes the model itself, so 1.0 draws it at its own size.
-- INFERRED: no live record of 13021 is in hand (not in the 70888 player cache); the PC step reads model 12929's scale from the
-- client's CreatureDisplayInfo. Only while the shipped 3.5 is still there. Safe to run again.
UPDATE `creature_template_model` SET `DisplayScale` = 1
WHERE `CreatureID` = 13021 AND `CreatureDisplayID` = 12929 AND ABS(`DisplayScale` - 3.5) < 0.001;
