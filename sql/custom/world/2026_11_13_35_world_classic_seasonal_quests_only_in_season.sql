-- World event quests could be taken all year (Discord "bugs 3", 2026-11-13: Children's Week (1468), "the whistle isn't
-- working"). The whistle's summon spells 23012/23013 only work while Children's Week (event 10) runs (conditions source 17), so
-- a player who took the quest in November had a whistle that did nothing.
-- Cause: 2026_10_17_51 put the vMaNGOS event quests (vMaNGOS game_event_quest, where a quest is only offered while its event
-- runs) into game_event_seasonal_questrelation. In this core that table only says which event a quest belongs to, for the
-- once-per-event reset (Quest::GetEventIdForQuest); it never hides the quest. The quest giver relations stayed in
-- creature_queststarter and gameobject_queststarter, which are always on.
-- Fix: the starter relation of every quest in game_event_seasonal_questrelation moves to game_event_creature_quest or
-- game_event_gameobject_quest under the same event, which the game event manager adds when the event starts and removes when it
-- stops. Quest enders stay, so a player who already has such a quest can still turn it in. The seasonal rows stay (reset).
-- Safe to run again: the second run finds no starter rows left to move.
INSERT IGNORE INTO `game_event_creature_quest` (`eventEntry`, `id`, `quest`)
SELECT s.`eventEntry`, q.`id`, q.`quest` FROM `creature_queststarter` q
  JOIN `game_event_seasonal_questrelation` s ON s.`questId` = q.`quest`
 WHERE s.`eventEntry` BETWEEN 1 AND 255;
DELETE q FROM `creature_queststarter` q
  JOIN `game_event_creature_quest` e ON e.`id` = q.`id` AND e.`quest` = q.`quest`
  JOIN `game_event_seasonal_questrelation` s ON s.`questId` = q.`quest` AND s.`eventEntry` = e.`eventEntry`;

INSERT IGNORE INTO `game_event_gameobject_quest` (`eventEntry`, `id`, `quest`)
SELECT s.`eventEntry`, q.`id`, q.`quest` FROM `gameobject_queststarter` q
  JOIN `game_event_seasonal_questrelation` s ON s.`questId` = q.`quest`
 WHERE s.`eventEntry` BETWEEN 1 AND 255;
DELETE q FROM `gameobject_queststarter` q
  JOIN `game_event_gameobject_quest` e ON e.`id` = q.`id` AND e.`quest` = q.`quest`
  JOIN `game_event_seasonal_questrelation` s ON s.`questId` = q.`quest` AND s.`eventEntry` = e.`eventEntry`;
