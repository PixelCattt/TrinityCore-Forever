-- Two Classic quests that could not be finished: the creature to kill or to hand in to never appeared.
-- Found by the quest health sweep (tools/quest_health).
--
-- 1) Ulag the Cleaver (1819, Tirisfal Glades): Ulag 6390 was not spawned and nothing summoned him. Using the Mausoleum
--    Trigger (104593, and 706178 from the Forever sniff at the same spot) with the quest in the log now opens the
--    mausoleum door (176594) and summons Ulag at the door, who attacks the player. Quest-gated by the trigger itself
--    (Data1 = 1819) and by the condition below; one Ulag at a time. Position and 5 minute timer from TrinityCore 3.3.5
--    go_mausoleum_door / go_mausoleum_trigger (GPL-2.0).
--    The two triggers stand on the same spot (our VMaNGOS conversion 30044766 and the Forever sniff 21202145); the
--    converted copy is removed so players see one lever, as on Forever.
-- 2) The Ancient Leaf (7632, hunter, Felwood): the ender Vartrus the Ancient 14524 (and Stoma the Ancient 14525, A Proper
--    String 7635) were never spawned. Entering area trigger 3587 (Irontree Woods) as a hunter now calls Vartrus and
--    Stoma for 10 minutes, as VMaNGOS at_irontree_wood (GPL-2.0, same positions). Hastat the Ancient is already a fixed
--    spawn (2026_11_05_62). VMaNGOS only calls them while 7632 is done but not handed in; the chain after it (7633, 7635,
--    7636) also needs Vartrus and Stoma, so they also come while 7632 is rewarded and 7636 is not yet rewarded.
-- Safe to run again.

-- 1) Ulag the Cleaver
DELETE FROM `gameobject` WHERE `guid` = 30044766 AND `id` = 104593;

UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` IN (104593, 706178) AND `ScriptName` = '';

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (104593, 706178) AND `source_type` = 1;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`Difficulties`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,
  `event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,
  `action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`action_param7`,`action_param_string`,
  `target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_param_string`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(104593,1,0,1,'',64,0,100,0, 1,0,0,0,0,'', 9,0,0,0,0,0,0,0,'', 15,176594,30,0,0,'',0,0,0,0,'Mausoleum Trigger - On Use - Open Mausoleum Door (quest 1819)'),
(104593,1,1,0,'',61,0,100,0, 0,0,0,0,0,'', 12,6390,1,300000,0,4,0,0,'', 8,0,0,0,0,'',2390.26,336.47,40.01,2.26,'Mausoleum Trigger - Linked - Summon Ulag the Cleaver (attacks the player)'),
(706178,1,0,1,'',64,0,100,0, 1,0,0,0,0,'', 9,0,0,0,0,0,0,0,'', 15,176594,30,0,0,'',0,0,0,0,'Mausoleum Trigger - On Use - Open Mausoleum Door (quest 1819)'),
(706178,1,1,0,'',61,0,100,0, 0,0,0,0,0,'', 12,6390,1,300000,0,4,0,0,'', 8,0,0,0,0,'',2390.26,336.47,40.01,2.26,'Mausoleum Trigger - Linked - Summon Ulag the Cleaver (attacks the player)');

-- only with Ulag the Cleaver in the log, and not while an Ulag is already out
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceGroup` = 1 AND `SourceEntry` IN (104593, 706178) AND `SourceId` = 1;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,
  `ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ConditionStringValue1`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(22,1,104593,1,0,47,0,1819,8,0,'',0,0,0,'','Mausoleum Trigger: Ulag the Cleaver in progress'),
(22,1,104593,1,0,29,1,6390,60,0,'',1,0,0,'','Mausoleum Trigger: no Ulag the Cleaver out already'),
(22,1,706178,1,0,47,0,1819,8,0,'',0,0,0,'','Mausoleum Trigger: Ulag the Cleaver in progress'),
(22,1,706178,1,0,29,1,6390,60,0,'',1,0,0,'','Mausoleum Trigger: no Ulag the Cleaver out already');

-- 2) The Ancient Leaf
DELETE FROM `areatrigger_scripts` WHERE `entry` = 3587;
INSERT INTO `areatrigger_scripts` (`entry`,`ScriptName`) VALUES (3587,'SmartTrigger');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 3587 AND `source_type` = 2;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`Difficulties`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,
  `event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,
  `action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`action_param7`,`action_param_string`,
  `target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_param_string`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(3587,2,0,1,'',46,0,100,0, 0,0,0,0,0,'', 12,14524,3,600000,0,0,0,0,'', 8,0,0,0,0,'',6194.55,-1176.35,369.056,1.1098,'Irontree Woods - On Trigger - Summon Vartrus the Ancient (The Ancient Leaf)'),
(3587,2,1,0,'',61,0,100,0, 0,0,0,0,0,'', 12,14525,3,600000,0,0,0,0,'', 8,0,0,0,0,'',6197.12,-1135.42,366.31,5.28025,'Irontree Woods - Linked - Summon Stoma the Ancient');

-- a hunter with 7632 done but not handed in (else group 0), or with 7632 handed in and Stave of the Ancients 7636 not yet
-- (else group 1); in both cases only when no Vartrus is near
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceGroup` = 1 AND `SourceEntry` = 3587 AND `SourceId` = 2;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,
  `ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ConditionStringValue1`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(22,1,3587,2,0,15,0,4,0,0,'',0,0,0,'','Irontree Woods: hunter'),
(22,1,3587,2,0,47,0,7632,2,0,'',0,0,0,'','Irontree Woods: The Ancient Leaf done, not handed in'),
(22,1,3587,2,0,29,0,14524,100,0,'',1,0,0,'','Irontree Woods: no Vartrus the Ancient near'),
(22,1,3587,2,1,15,0,4,0,0,'',0,0,0,'','Irontree Woods: hunter'),
(22,1,3587,2,1,47,0,7632,64,0,'',0,0,0,'','Irontree Woods: The Ancient Leaf handed in'),
(22,1,3587,2,1,47,0,7636,43,0,'',0,0,0,'','Irontree Woods: Stave of the Ancients not handed in'),
(22,1,3587,2,1,29,0,14524,100,0,'',1,0,0,'','Irontree Woods: no Vartrus the Ancient near');
