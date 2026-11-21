-- Duskwood, Raven Hill: Grant's Shield (281147) and Silvia's Sword (281145) dropped for every player (Discord, VoldemarGreed
-- "bugs 7", points 7, 9 and 10, 2026-11-18). Both items start a shaman quest (Grant's Shield 79362, Silvia's Sword 79363:
-- quest_template_addon AllowableClasses 64), but their loot rows from Wowhead Forever (2026_11_05_99, the spirits 272291 and
-- 272284, 100%) are not quest-gated, so every class looted an item that starts a quest it can never take. QuestRequired = 1
-- is not the fix: it would hide a quest-starting item from the shaman too, before the quest exists. The drop now needs a
-- shaman, the class the quest asks for. A shaman who already has or has done the quest is still filtered by the loot code
-- (Loot.cpp, start quest status), as before.
-- Safe to run again.
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 1 AND (`SourceGroup`, `SourceEntry`) IN ((272291, 281147), (272284, 281145));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`,
`ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(1, 272291, 281147, 0, 0, 15, 0, 64, 0, 0, 0, 'Grant''s Shield (starts shaman quest 79362) drops only for shamans'),
(1, 272284, 281145, 0, 0, 15, 0, 64, 0, 0, 0, 'Silvia''s Sword (starts shaman quest 79363) drops only for shamans');
