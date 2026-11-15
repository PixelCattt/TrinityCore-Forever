-- Kyle's Gone Missing! (99411): Kyle does nothing when the meat is put down (Discord, doctorsun, 2026-11-14, 0.1.36).
-- Tender Strider Meat (287505) casts Lunch for Kyle (1323075): effect 0 is a dummy on the nearest creature of an entry
-- (TARGET_UNIT_NEARBY_ENTRY), effect 1 drops the meat. The entry comes from a spell target condition, and there was none,
-- so the dummy went to whatever unit stood nearest (often one of your own bots) and Kyle the Frenzied (277154) never got
-- the spell hit that gives "Kyle Fed". Kyle is now the only target.
-- His spell hit also starts timed action list 27715400 ("Run eat script"), which did not exist. It is added here: Kyle runs
-- to the feeder, where the meat lies, eats, and walks back to his spawn spot. (INFERRED: no sniff of the live eat scene.)
-- Safe to run again.
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 1323075;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ConditionStringValue1`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 1323075, 0, 0, 31, 0, 3, 277154, 0, '', 0, 0, 0, '', 'Lunch for Kyle - effect 0 only on Kyle the Frenzied');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 27715400 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `Difficulties`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `action_param7`, `action_param_string`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_param_string`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27715400, 9, 0, 0, '', 0, 0, 100, 0, 0, 0, 0, 0, 0, '', 59, 1, 0, 0, 0, 0, 0, 0, '', 1, 0, 0, 0, 0, '', 0, 0, 0, 0, 'Kyle the Frenzied - eat script - Set run'),
(27715400, 9, 1, 0, '', 0, 0, 100, 0, 0, 0, 0, 0, 0, '', 69, 1, 0, 0, 1, 0, 0, 0, '', 7, 0, 0, 0, 0, '', 0, 0, 0, 0, 'Kyle the Frenzied - eat script - Run to the feeder'),
(27715400, 9, 2, 0, '', 0, 0, 100, 0, 4000, 4000, 0, 0, 0, '', 5, 7, 0, 0, 0, 0, 0, 0, '', 1, 0, 0, 0, 0, '', 0, 0, 0, 0, 'Kyle the Frenzied - eat script - Eat'),
(27715400, 9, 3, 0, '', 0, 0, 100, 0, 2500, 2500, 0, 0, 0, '', 5, 7, 0, 0, 0, 0, 0, 0, '', 1, 0, 0, 0, 0, '', 0, 0, 0, 0, 'Kyle the Frenzied - eat script - Eat'),
(27715400, 9, 4, 0, '', 0, 0, 100, 0, 2500, 2500, 0, 0, 0, '', 59, 0, 0, 0, 0, 0, 0, 0, '', 1, 0, 0, 0, 0, '', 0, 0, 0, 0, 'Kyle the Frenzied - eat script - Set walk'),
(27715400, 9, 5, 0, '', 0, 0, 100, 0, 0, 0, 0, 0, 0, '', 69, 2, 0, 0, 0, 0, 0, 0, '', 8, 0, 0, 0, 0, '', -2334.05, -474.833, -6.98, 0, 'Kyle the Frenzied - eat script - Walk back to his spot');
