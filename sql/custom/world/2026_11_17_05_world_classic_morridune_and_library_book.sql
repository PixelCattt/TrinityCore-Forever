-- Two Discord reports of 2026-11-17. Safe to run again.
--
-- 1) Morridune (Blackfathom Deeps, VoldemarGreed "bugs 6": "no NPC"). Aku'mai's death already summons him (VMaNGOS EventAI
--    482901, he says "Aku'mai is dead! At last, I can leave this wretched place."), but he had no npc flag and no script, so
--    he showed no chat window and "Please port me to Darnassus." (gossip 321) did nothing. Now he can be talked to and the
--    option casts Teleport: Darnassus 9268 on the player, as in TrinityCore 3.3.5 npc_morridune (GPL-2.0).
UPDATE `creature_template` SET `npcflag` = 1, `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 6729;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 6729 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`Difficulties`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,
  `event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,
  `action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`action_param7`,`action_param_string`,
  `target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_param_string`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(6729,0,0,1,'',62,0,100,0, 321,0,0,0,0,'', 72,0,0,0,0,0,0,0,'', 7,0,0,0,0,'',0,0,0,0,'Morridune - On Gossip Option 0 Selected - Close Gossip'),
(6729,0,1,0,'',61,0,100,0, 0,0,0,0,0,'', 11,9268,2,0,0,0,0,0,'', 7,0,0,0,0,'',0,0,0,0,'Morridune - Linked - Cast Teleport: Darnassus on the player');
--
-- 2) Archmage Theocritus' Research Journal (quest 79092, Library Book 386759) in the Tower of Azora, Elwynn (claushattedavs
--    "Library Books": "halfway up the tower, the left pile of books on a small bench ... not sparkling or clickable"). Our spawn
--    (from the AnoCore port) stood on the ground floor (z 64.55, under the floor at 64.78). It is moved to the middle floor
--    (90.45) on the same spot; z 91.0 = floor + a small bench. INFERRED height: check in game (PC steps).
--    The same port put a copy of Antonidas' autobiography (386691) in Ironforge 105 yards above the sniffed one (43000010,
--    build 70425, z 503.3): that copy (38669101, z 608.13) is removed.
UPDATE `gameobject` SET `position_z` = 91.0 WHERE `guid` = 38675900 AND `id` = 386759;
DELETE FROM `gameobject` WHERE `guid` = 38669101 AND `id` = 386691;
