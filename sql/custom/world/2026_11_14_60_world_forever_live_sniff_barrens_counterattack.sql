-- WoW Forever live realm: dump_1.60.1.70862_2026-11-07_12-13-01.pkt (The Barrens, Crossroads to Northwatch, the Counterattack!
-- event of quest 4021). Live summons Warlord Krom'zar (9456) about 19 seconds into the event, together with the Kolkar waves.
-- He yells "I am here!  Your rule of this land is over!" (BroadcastText 4920), and on death casts Create Krom'zar's Banner, the
-- quest item. Our port of the event (timed list 950000215) summons the 35 defenders and Kolkar but never Krom'zar, and no other
-- spawn or script has him, so Counterattack! could not be completed. Safe to run more than once.

-- 1. Summon Krom'zar 16 s after the last wave row (19 s after the start, as live). Position: where live first shows him
--    (INFERRED: his spawn point is within his 5-yard wander of it). He despawns 2 minutes after leaving combat (INFERRED).
DELETE FROM `smart_scripts` WHERE `entryorguid` = 950000215 AND `source_type` = 9 AND `id` = 36;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
  `event_param1`, `event_param2`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `target_type`,
  `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(950000215, 9, 36, 0, 0, 0, 100, 0, 16000, 16000, 12, 9456, 4, 120000, 8, -289.13, -1858.67, 92.47, 1.57,
 'Counterattack! - summon Warlord Krom''zar (live 70862)');

-- 2. His arrival yell is BroadcastText 4920 on live; our only line (4917) stays as group 0.
DELETE FROM `creature_text` WHERE `CreatureID` = 9456 AND `GroupID` = 1;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`,
  `SoundPlayType`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(9456, 1, 0, 'I am here!  Your rule of this land is over!', 14, 0, 100, 0, 0, 0, 0, 4920, 0, 'Warlord Krom''zar: arrival (live 70862)');
UPDATE `smart_scripts` SET `action_param1` = 1 WHERE `entryorguid` = 9456 AND `source_type` = 0 AND `id` = 5 AND `action_type` = 1;
