-- Converted VMaNGOS "arrived at point" events that never fire (follow-up to 2026_11_12_35, Whitemane).
--
-- Six SmartAI rows from the VMaNGOS EventAI conversion wait for MOVEMENTINFORM with motion type 9. In this core 9 is
-- FLEEING_MOTION_TYPE; a MovePoint arrival (SMART_ACTION_MOVE_TO_POS, MotionMaster::MovePoint) reports type 8,
-- POINT_MOTION_TYPE, so none of them ever ran:
--   4444 Deathstalker Vincent (Shadowfang Keep): beaten, he walks off and should lie down as dead on arrival. His move also
--        used point 0 while the arrival row waits for point 1; the move now uses point 1.
--   5184 Theramore Sentry (The Missing Diplomat, 1324): after running off (point 1324, 2026_10_26_75) they should despawn.
--   9990 Lanti'gah (Counterattack!): emote on arrival at the west bunker (point 1, 2026_11_12_32).
--   9545 / 9547 / 9554 Grim / Guzzling / Hammered Patron (Blackrock Depths, Grim Guzzler): arrival at point 1 starts their
--        drunk scene (timed lists 950001261-950001263). Nothing in this core moves them to point 1 yet, so this row stays
--        idle until that mover is ported; the type is still corrected so it works then.
-- Safe to run again.
UPDATE `smart_scripts` SET `event_param1` = 8
WHERE `source_type` = 0 AND `event_type` = 34 AND `event_param1` = 9 AND `entryorguid` IN (4444, 5184, 9545, 9547, 9554, 9990);
UPDATE `smart_scripts` SET `action_param1` = 1
WHERE `entryorguid` = 4444 AND `source_type` = 0 AND `id` = 8 AND `action_type` = 69;
