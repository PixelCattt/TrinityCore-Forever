-- Kresh (Wailing Caverns), Old Serra'kis (Blackfathom Deeps) and Mana Wraith (City of Dalaran) only fought in melee: they
-- have no script and no SmartAI here. Abilities from Everlake (GPL-3.0), commit cf07dad, file 2026_11_19_971, which takes
-- them from Wowhead's WoW Forever NPC pages (www.wowhead.com/forever). cmangos classic-db has no spells for Kresh or
-- Old Serra'kis. Changed: checked against our world and our spell data and written as our own rows.
--   Kresh 3653: Bite 17256 on his target; Shell Shield 26064 (damage taken -50%, 12 s) below 50% health, every 3 minutes.
--   Old Serra'kis 4830: Leech Pulse 8433 (drains health from everyone around him).
--   Mana Wraith 246931: Reflection Field 1303458 (reflects spells, lasts until it dies) when the fight starts.
-- The timers and the 50% mark are guesses: Wowhead lists the abilities, not when they are used. Not checked in game.
-- Only goes in where the creature still has no script of its own (no AIName, no ScriptName, no SmartAI rows for the entry or
-- its spawns). Safe to run more than once.

DROP TEMPORARY TABLE IF EXISTS `forever_boss_ai`;
CREATE TEMPORARY TABLE `forever_boss_ai` SELECT `entryorguid`,`source_type`,`id`,`link`,`Difficulties`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`action_param7`,`action_param_string`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_param_string`,`target_x`,`target_y`,`target_z`,`target_o`,`comment` FROM `smart_scripts` WHERE 0;
INSERT INTO `forever_boss_ai` (`entryorguid`,`source_type`,`id`,`link`,`Difficulties`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`action_param7`,`action_param_string`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_param_string`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(3653,0,0,0,'',0,0,100,0,5000,8000,10000,12000,0,'',11,17256,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Kresh - In combat - Cast Bite on victim'),
(3653,0,1,0,'',2,0,100,0,0,50,180000,180000,0,'',11,26064,0,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'Kresh - Between 0-50% health - Cast Shell Shield on self'),
(4830,0,0,0,'',0,0,100,0,8000,12000,15000,20000,0,'',11,8433,0,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'Old Serra''kis - In combat - Cast Leech Pulse'),
(246931,0,0,0,'',4,0,100,0,0,0,0,0,0,'',11,1303458,0,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'Mana Wraith - On aggro - Cast Reflection Field on self');

-- creatures that already have a script of their own keep it
DELETE b FROM `forever_boss_ai` b JOIN `creature_template` c ON c.`entry` = b.`entryorguid` WHERE c.`ScriptName` <> '' OR (c.`AIName` <> '' AND c.`AIName` <> 'SmartAI');
DELETE b FROM `forever_boss_ai` b WHERE NOT EXISTS (SELECT 1 FROM `creature_template` c WHERE c.`entry` = b.`entryorguid`);
DELETE b FROM `forever_boss_ai` b WHERE EXISTS (SELECT 1 FROM `smart_scripts` s JOIN `creature` c ON s.`entryorguid` = -CAST(c.`guid` AS SIGNED) WHERE c.`id` = b.`entryorguid` AND s.`source_type` = 0);
-- (a second temporary table: MySQL cannot read one temporary table twice in a statement)
DROP TEMPORARY TABLE IF EXISTS `forever_boss_ai_ours`;
CREATE TEMPORARY TABLE `forever_boss_ai_ours` SELECT `entryorguid`,`id`,`comment` FROM `forever_boss_ai`;
DELETE b FROM `forever_boss_ai` b WHERE EXISTS (SELECT 1 FROM `smart_scripts` s WHERE s.`entryorguid` = b.`entryorguid` AND s.`source_type` = 0
  AND NOT EXISTS (SELECT 1 FROM `forever_boss_ai_ours` o WHERE o.`entryorguid` = s.`entryorguid` AND o.`id` = s.`id` AND o.`comment` = s.`comment`));
DROP TEMPORARY TABLE `forever_boss_ai_ours`;

INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`Difficulties`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`action_param7`,`action_param_string`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_param_string`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`)
SELECT b.* FROM `forever_boss_ai` b
WHERE NOT EXISTS (SELECT 1 FROM `smart_scripts` s WHERE s.`entryorguid` = b.`entryorguid` AND s.`source_type` = b.`source_type` AND s.`id` = b.`id` AND s.`link` = b.`link`);

UPDATE `creature_template` c JOIN (SELECT DISTINCT `entryorguid` FROM `forever_boss_ai`) b ON b.`entryorguid` = c.`entry`
SET c.`AIName` = 'SmartAI' WHERE c.`AIName` = '' AND c.`ScriptName` = '';

DROP TEMPORARY TABLE `forever_boss_ai`;
