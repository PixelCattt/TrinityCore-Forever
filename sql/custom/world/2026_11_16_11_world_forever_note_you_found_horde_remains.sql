-- "... and that note you found" (Cozy Sleeping Bag chain): a Skyborne Horde shaman standing at the Burned-Out Remains saw no quest
-- marker (Discord, 6_1_8_8_1 "Bugs" 2.1, 2026-11-14). Quest, race mask, level and spot all check out (Barrens remains at 46.4,73.9
-- as on live). What stops it: the restored Forever data gave all four objects of the chain start the Stormwind faction (12), and
-- the client does not offer quests on an object of a hostile faction (stock data does the same on purpose: Alliance-only quest
-- objects carry Alliance factions, Horde ones Horde factions). INFERRED from that pattern; no sniff of these objects.
--   415106 Burned-Out Remains (Horde quest 79007, Barrens and Westfall)   faction 12 -> 0, seen only by the Horde
--   415107 Burned-Out Remains (Alliance quest 79008, Westfall)            faction 12 kept, seen only by the Alliance
--   417072 / 424010 Nailed Plank (Stepping Stones 79192, both sides)     faction 12 -> 0
-- In Westfall the two remains stand on the same spot (one per faction, as on live where both sides can start there); each player
-- now sees only their own, so the pair no longer shows as two overlapping objects. Safe to run again.

UPDATE `gameobject_template_addon` SET `faction` = 0 WHERE `entry` IN (415106,417072,424010);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 32 AND `SourceGroup` = 8 AND `SourceEntry` IN (415106,415107);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(32, 8, 415106, 0, 0, 6, 0, 67, 0, 0, 0, 0, 0, '', 'Burned-Out Remains (Horde, 79007) - seen only by the Horde'),
(32, 8, 415107, 0, 0, 6, 0, 469, 0, 0, 0, 0, 0, '', 'Burned-Out Remains (Alliance, 79008) - seen only by the Alliance');
