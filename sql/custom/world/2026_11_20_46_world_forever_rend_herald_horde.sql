-- Rend Blackhand's head for the Horde: the Herald of Thrall buffs the Crossroads and, as on live WoW Forever since 2026-11-12, the
-- Razor Hill guard tower too.
-- Thrall's turn-in of For The Horde! 4974 (his row 3 -> actionlist 950000230 -> 950000229) summons a Herald of Thrall (10719) at the
-- Crossroads for 30 s, then yells and casts Warchief's Blessing in Orgrimmar himself. The herald's own spawn script was lost in the
-- VMaNGOS conversion, so it stood at the Crossroads silent and buffed nobody. VMaNGOS generic_scripts 10719: unattackable, yells
-- broadcast text 6013 at 3 s and 6015 at 13 s, casts Warchief's Blessing (16609) at 15 s.
-- Razor Hill: a second herald on top of the guard tower (live: Durotar 49.8 40.3, Icy Veins sightings as Everlake turned them into
-- world coordinates). Safe to run again.

UPDATE `creature_template` SET `AIName` = 'SmartAI', `unit_flags` = `unit_flags` | 0x300 WHERE `entry` = 10719;

DELETE FROM `creature_text` WHERE `CreatureID` = 10719 AND `GroupID` IN (0, 1);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(10719, 0, 0, 'Honor your heroes! On this day, they have dealt a great blow against one of our most hated enemies! The false Warchief, Rend Blackhand, has fallen!', 14, 0, 100, 22, 0, 0, 6013, 0, 'Herald of Thrall - Rend turn-in'),
(10719, 1, 0, 'Be bathed in the power of the Warchief! Drink in his might! Battle for the glory of the Horde!', 14, 0, 100, 22, 0, 0, 6015, 0, 'Herald of Thrall - Rend turn-in');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 10719 AND `source_type` = 0) OR (`entryorguid` = 1071900 AND `source_type` = 9);
DELETE FROM `smart_scripts` WHERE `entryorguid` = 4949 AND `source_type` = 0 AND `id` = 7;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `Difficulties`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param_string`, `action_type`, `action_param1`, `action_param2`,
    `action_param3`, `action_param4`, `action_param5`, `action_param6`, `action_param7`, `action_param_string`, `target_type`, `target_param1`,
    `target_param2`, `target_param3`, `target_param4`, `target_param_string`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10719, 0, 0, 0, '', 54, 0, 100, 0, 0, 0, 0, 0, 0, '', 80, 1071900, 2, 0, 0, 0, 0, 0, '', 1, 0, 0, 0, 0, '', 0, 0, 0, 0, 'Herald of Thrall - On just summoned - Run Rend script'),
(1071900, 9, 0, 0, '', 0, 0, 100, 0, 3000, 3000, 0, 0, 0, '', 1, 0, 0, 0, 0, 0, 0, 0, '', 1, 0, 0, 0, 0, '', 0, 0, 0, 0, 'Herald of Thrall - Yell 6013'),
(1071900, 9, 1, 0, '', 0, 0, 100, 0, 10000, 10000, 0, 0, 0, '', 1, 1, 0, 0, 0, 0, 0, 0, '', 1, 0, 0, 0, 0, '', 0, 0, 0, 0, 'Herald of Thrall - Yell 6015'),
(1071900, 9, 2, 0, '', 0, 0, 100, 0, 2000, 2000, 0, 0, 0, '', 11, 16609, 2, 0, 0, 0, 0, 0, '', 1, 0, 0, 0, 0, '', 0, 0, 0, 0, 'Herald of Thrall - Cast Warchief''s Blessing'),
(4949, 0, 7, 0, '', 20, 0, 100, 0, 4974, 0, 0, 0, 0, '', 12, 10719, 3, 30000, 0, 0, 0, 0, '', 8, 0, 0, 0, 0, '', 386.7, -4596.2, 76.17, 1.6, 'Thrall - On quest 4974 rewarded - Summon Herald of Thrall on the Razor Hill tower');
