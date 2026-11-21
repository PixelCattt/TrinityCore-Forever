-- Duskwood and Wetlands quest fixes from Voldemar's list (bugs 8). Safe to run more than once.
--
-- 1. Digging Through the Dirt (254) can be repeated while Bride of the Embalmer (253) is active, so a player whose
--    Eliza got away can call her again. But every turn-in at Eliza's Grave Dirt (51708) summoned another Eliza, even
--    with one already out, so the quest could stack Eliza after Eliza, each calling her guards. Eliza now rises only
--    when no living Eliza (314) is within 100 yd of the grave (same pattern as the Ulag check on 30044766).
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceGroup` = 1 AND `SourceEntry` = 51708 AND `SourceId` = 1;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`,
 `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ConditionStringValue1`, `NegativeCondition`, `ErrorType`,
 `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 1, 51708, 1, 0, 29, 1, 314, 100, 0, '', 1, 0, 0, '', 'Eliza''s Grave Dirt: summon Eliza only when no living Eliza is near');
--
-- 2. Lightforge Ingots (526) and The Lost Ingots (324) are two ways to the same step: The Lost Ingots starts at the
--    waterlogged chest, Lightforge Ingots at Glorin Steelbrow after Lightforge Iron (321). On live both lead to
--    Blessed Arm (322) (nextQuestId 322 on both). Ours had 526 after 324, so a player could take and do both.
--    Now they share exclusive group 324 (taking one closes the other), 526 follows 321 like 324 does, and Blessed Arm
--    opens after either of them. Source: Questie (exclusiveTo, preQuestSingle 321, nextQuestInChain 322) and the live
--    quest data from Efficient Games (CC BY 4.0).
UPDATE `quest_template_addon` SET `PrevQuestID` = 321, `NextQuestID` = 322, `ExclusiveGroup` = 324 WHERE `ID` = 526;
UPDATE `quest_template_addon` SET `NextQuestID` = 322, `ExclusiveGroup` = 324 WHERE `ID` = 324;
UPDATE `quest_template_addon` SET `PrevQuestID` = 0 WHERE `ID` = 322 AND `PrevQuestID` = 324;
