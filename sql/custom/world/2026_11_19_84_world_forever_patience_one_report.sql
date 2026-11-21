-- Classic 1.60 (WoW Forever): Patience (99141). Each "I need a report for Executor Zygand." option handed out two reports:
-- the option's own SpellID is cast by Player::OnGossipSelect (2026_10_06_01), and the 2026_11_05_99 restore added a SmartAI
-- gossip-select row that self-casts the same create spell. The gossip SpellID is the sniffed source (70124), so the
-- duplicate SmartAI rows go. Safe to run again.

DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `event_type` = 62 AND `action_type` = 85 AND (
    (`entryorguid` = 10666  AND `event_param1` = 44993 AND `event_param2` = 0 AND `action_param1` = 1319508) OR
    (`entryorguid` = 1496   AND `event_param1` = 44990 AND `event_param2` = 6 AND `action_param1` = 1319468) OR
    (`entryorguid` = 251001 AND `event_param1` = 44991 AND `event_param2` = 6 AND `action_param1` = 1319489));

-- Dillinger and Kristof had no other SmartAI rows: leave them without an AI script instead of an empty SmartAI
UPDATE `creature_template` SET `AIName` = '' WHERE `entry` IN (1496, 251001) AND `AIName` = 'SmartAI'
    AND NOT EXISTS (SELECT 1 FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = `creature_template`.`entry`);
