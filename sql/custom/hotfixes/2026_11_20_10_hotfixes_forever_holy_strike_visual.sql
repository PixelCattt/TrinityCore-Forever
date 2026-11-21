-- Holy Strike (all 8 ranks) had no SpellXSpellVisual row, so the server sent visual 0 and the strike showed no effect
-- (visualprobe 2026-11-20). Live pushes no visual rows for it. Visual 39 is the one of Blizzard's own NPC Holy Strike 13953 (also 17284, 457848) and every Crusader Strike rank (2537 ...).
-- spell_x_spell_visual ids 990000-990007, hotfix_data ids 2190000-2190007 (TableHash 666345498 = SpellXSpellVisual). Safe to run again.
DELETE FROM `spell_x_spell_visual` WHERE `ID` BETWEEN 990000 AND 990007;
INSERT INTO `spell_x_spell_visual` (`ID`,`DifficultyID`,`SpellVisualID`,`Probability`,`Flags`,`Priority`,`SpellIconFileID`,`ActiveIconFileID`,`ViewerUnitConditionID`,`ViewerPlayerConditionID`,`CasterUnitConditionID`,`CasterPlayerConditionID`,`SpellID`,`VerifiedBuild`) VALUES
(990000,0,39,1,0,1,0,0,0,0,0,0,678,70959),
(990001,0,39,1,0,1,0,0,0,0,0,0,679,70959),
(990002,0,39,1,0,1,0,0,0,0,0,0,680,70959),
(990003,0,39,1,0,1,0,0,0,0,0,0,1866,70959),
(990004,0,39,1,0,1,0,0,0,0,0,0,2495,70959),
(990005,0,39,1,0,1,0,0,0,0,0,0,5569,70959),
(990006,0,39,1,0,1,0,0,0,0,0,0,10332,70959),
(990007,0,39,1,0,1,0,0,0,0,0,0,10333,70959);
DELETE FROM `hotfix_data` WHERE `Id` BETWEEN 2190000 AND 2190007;
INSERT INTO `hotfix_data` (`Id`,`UniqueId`,`TableHash`,`RecordId`,`Status`,`VerifiedBuild`) VALUES
(2190000,1397910000,666345498,990000,1,70959),
(2190001,1397910001,666345498,990001,1,70959),
(2190002,1397910002,666345498,990002,1,70959),
(2190003,1397910003,666345498,990003,1,70959),
(2190004,1397910004,666345498,990004,1,70959),
(2190005,1397910005,666345498,990005,1,70959),
(2190006,1397910006,666345498,990006,1,70959),
(2190007,1397910007,666345498,990007,1,70959);
