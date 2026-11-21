-- Rend Blackhand's head for the Alliance, as on live WoW Forever (since 2026-11-12):
--   Head of Rend Blackhand (227911, Rend drops it every kill) starts End of the Dark Horde 84377: bring it to Master Mathias Shaw (332).
--   Shaw then gives End of the Dark Horde 97883 with the head (278836): bring it to Major Mattingly (14394) at the city gates.
--   Mattingly casts Might of Stormwind (460939, the Alliance copy of Warchief's Blessing) on the allies around him, and Stormwind
--   Criers (269863) ride out to Goldshire, Lakeshire and Sentinel Hill and cast it there.
-- Quest data: Efficient Games (EG Link, CC BY 4.0) and QuestieDB traces (GPL-3.0) as imported by Everlake's world data
-- (buildthehomelab/wow-everlake-world-data, GPL-3.0); crier places: Icy Veins live sightings as Everlake turned them into world
-- coordinates. Written fresh here. Safe to run again.

-- ---- End of the Dark Horde 84377 (Alliance, item started, to Shaw) ----
DELETE FROM `quest_template` WHERE `ID` = 84377;
INSERT INTO `quest_template` (`ID`, `QuestType`, `QuestSortID`, `Flags`, `AllowableRaces`, `RewardXPDifficulty`, `RewardXPMultiplier`,
    `RewardFactionID1`, `RewardFactionOverride1`, `LogTitle`, `LogDescription`, `QuestDescription`, `VerifiedBuild`) VALUES
(84377, 2, 1519, 268435456, 6130900294268439629, 7, 1, 72, 20000, 'End of the Dark Horde',
 'Take the Head of Rend Blackhand to Master Mathias Shaw in Stormwind.',
 'The deed is done. Dal''rend Blackhand, Warchief of the Dark Horde, lies dead at your feet.$B$BTake his head and present it to Master Shaw.', 70938);
DELETE FROM `quest_objectives` WHERE `ID` = 452467;
INSERT INTO `quest_objectives` (`ID`, `QuestID`, `Type`, `Order`, `StorageIndex`, `ObjectID`, `Amount`, `Flags`, `Flags2`, `VerifiedBuild`) VALUES
(452467, 84377, 1, 0, 1, 227911, 1, 32, 0, 70938);
DELETE FROM `quest_request_items` WHERE `ID` = 84377;
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(84377, 0, 0, 0, 0, 'I''m well aware of your recent whereabouts, $N.$B$BDo you have something to show me?', 70938);
DELETE FROM `quest_offer_reward` WHERE `ID` = 84377;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(84377, 0, 0, 0, 0, 0, 0, 0, 0, 'The Warchief of the Dark Horde is dead at last...$B$BThis is the end of an era of terror in our lands. And, perhaps, a boon in our efforts against the Horde as well.$B$BWe must let all of Stormwind know of your victory!', 70938);
DELETE FROM `creature_questender` WHERE `quest` = 84377;
INSERT INTO `creature_questender` (`id`, `quest`, `VerifiedBuild`) VALUES (332, 84377, 70938);

-- ---- End of the Dark Horde 97883 (Shaw gives the head back, to Mattingly) ----
DELETE FROM `quest_template` WHERE `ID` = 97883;
INSERT INTO `quest_template` (`ID`, `QuestType`, `QuestSortID`, `Flags`, `AllowableRaces`, `RewardXPDifficulty`, `RewardXPMultiplier`,
    `RewardFactionID1`, `RewardFactionValue1`, `StartItem`, `LogTitle`, `LogDescription`, `QuestDescription`, `VerifiedBuild`) VALUES
(97883, 2, 1519, 268435456, 6130900294268439629, 1, 1, 72, 1, 278836, 'End of the Dark Horde',
 'Bring the Head of Rend Blackhand to Major Mattingly in Stormwind.',
 'Bring Blackhand''s head to Major Mattingly at the city gates. He and his men will proclaim the great victory you have achieved this day, so that the rest of the Alliance may be inspired by it.$B$BYou''ve done a great justice this day, $n. One that all will remember--including our enemies.', 70938);
DELETE FROM `quest_objectives` WHERE `ID` = 476433;
INSERT INTO `quest_objectives` (`ID`, `QuestID`, `Type`, `Order`, `StorageIndex`, `ObjectID`, `Amount`, `Flags`, `Flags2`, `VerifiedBuild`) VALUES
(476433, 97883, 1, 0, 0, 278836, 1, 32, 0, 70938);
-- only after 84377: without it any Alliance character could take the head from Shaw and buff the town
DELETE FROM `quest_template_addon` WHERE `ID` = 97883;
INSERT INTO `quest_template_addon` (`ID`, `PrevQuestID`) VALUES (97883, 84377);
DELETE FROM `creature_queststarter` WHERE `quest` = 97883;
INSERT INTO `creature_queststarter` (`id`, `quest`, `VerifiedBuild`) VALUES (332, 97883, 70938);
DELETE FROM `creature_questender` WHERE `quest` = 97883;
INSERT INTO `creature_questender` (`id`, `quest`, `VerifiedBuild`) VALUES (14394, 97883, 70938);
UPDATE `creature_template` SET `npcflag` = `npcflag` | 2 WHERE `entry` IN (332, 14394);

-- ---- Classic level and money rows (both quests level 60, min level 60) ----
DELETE FROM `quest_classic_level` WHERE `ID` IN (84377, 97883);
INSERT INTO `quest_classic_level` (`ID`, `QuestLevel`, `MinLevel`, `MaxLevel`) VALUES (84377, 60, 60, 0), (97883, 60, 60, 0);
DELETE FROM `quest_template_classic_level` WHERE `ID` IN (84377, 97883);
INSERT INTO `quest_template_classic_level` (`ID`, `LevelType`, `QuestLevel`) VALUES (84377, 2, 60), (97883, 2, 60);
DELETE FROM `quest_classic_money` WHERE `ID` IN (84377, 97883);
INSERT INTO `quest_classic_money` (`ID`, `RewardMoney`, `RewardMoneyMaxLevel`) VALUES (84377, 27000, 0), (97883, 900, 0);

-- ---- Mattingly: Might of Stormwind on the turn-in, and the three town criers ----
-- (his rows 0 and 1 are the VMaNGOS spell list and Onyxia's head 7496; these are new rows 2 to 5)
DELETE FROM `smart_scripts` WHERE `entryorguid` = 14394 AND `source_type` = 0 AND `id` IN (2, 3, 4, 5);
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 269863 AND `source_type` = 0) OR (`entryorguid` = 26986300 AND `source_type` = 9);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `Difficulties`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
    `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param_string`, `action_type`, `action_param1`, `action_param2`,
    `action_param3`, `action_param4`, `action_param5`, `action_param6`, `action_param7`, `action_param_string`, `target_type`, `target_param1`,
    `target_param2`, `target_param3`, `target_param4`, `target_param_string`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(14394, 0, 2, 0, '', 20, 0, 100, 0, 97883, 0, 0, 0, 0, '', 11, 460939, 2, 0, 0, 0, 0, 0, '', 1, 0, 0, 0, 0, '', 0, 0, 0, 0, 'Major Mattingly - On quest 97883 rewarded - Cast Might of Stormwind'),
(14394, 0, 3, 0, '', 20, 0, 100, 0, 97883, 0, 0, 0, 0, '', 12, 269863, 3, 30000, 0, 0, 0, 0, '', 8, 0, 0, 0, 0, '', -9451.9, 60.3, 57.0, 0, 'Major Mattingly - On quest 97883 rewarded - Summon Stormwind Crier in Goldshire'),
(14394, 0, 4, 0, '', 20, 0, 100, 0, 97883, 0, 0, 0, 0, '', 12, 269863, 3, 30000, 0, 0, 0, 0, '', 8, 0, 0, 0, 0, '', -9275.5, -2251.5, 63.6, 0, 'Major Mattingly - On quest 97883 rewarded - Summon Stormwind Crier in Lakeshire'),
(14394, 0, 5, 0, '', 20, 0, 100, 0, 97883, 0, 0, 0, 0, '', 12, 269863, 3, 30000, 0, 0, 0, 0, '', 8, 0, 0, 0, 0, '', -10631.3, 1039.5, 34.3, 0, 'Major Mattingly - On quest 97883 rewarded - Summon Stormwind Crier in Sentinel Hill'),
(269863, 0, 0, 0, '', 54, 0, 100, 0, 0, 0, 0, 0, 0, '', 80, 26986300, 2, 0, 0, 0, 0, 0, '', 1, 0, 0, 0, 0, '', 0, 0, 0, 0, 'Stormwind Crier - On just summoned - Run Rend script'),
(26986300, 9, 0, 0, '', 0, 0, 100, 0, 5000, 5000, 0, 0, 0, '', 11, 460939, 2, 0, 0, 0, 0, 0, '', 1, 0, 0, 0, 0, '', 0, 0, 0, 0, 'Stormwind Crier - Cast Might of Stormwind');
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (14394, 269863);
-- the crier is a herald, not a target
UPDATE `creature_template` SET `unit_flags` = `unit_flags` | 0x300 WHERE `entry` = 269863;

-- ---- Might of Stormwind counts as a boss celebration buff (Legacy perks Conquering Hero / Second Chance) ----
DELETE FROM `spell_script_names` WHERE `spell_id` IN (460939, 460940, 1304678) AND `ScriptName` = 'classic_spell_legacy_boss_celebration_buff';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(460939, 'classic_spell_legacy_boss_celebration_buff'),
(460940, 'classic_spell_legacy_boss_celebration_buff'),
(1304678, 'classic_spell_legacy_boss_celebration_buff');
