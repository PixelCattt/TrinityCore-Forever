-- VMaNGOS creature AI events that the conversion (2026_09_28_15) dropped from creatures it did convert (F4 follow-up, second
-- part; the creatures with no AI at all are in 2026_11_16_02). Taken from VMaNGOS creature_ai_events / creature_ai_scripts.
--   Deadwood furbolgs (Felwood): when a Den Watcher (7156), Avenger (7157) or Shaman (7158) dies, the closest living Deadwood
--     Avenger within 10 yards enrages (8599) with its emote (BroadcastText 1151). VMaNGOS sends a script event to it; here the
--     dying furbolg sets data 7157 on it.
--   Twilight cultists (Silithus): when a Twilight Avenger (11880), Geolord (11881) or Overlord (15213) dies, the closest living
--     Twilight Avenger within 10 yards casts Vengeance (8602) with the same emote. Data 11880.
--   Hederine Slayer (7463, Felwood): Execute (7160) on a victim below 20% health, checked every 30 s (VMaNGOS target-HP event).
--     The core has no target-health event, so this is a melee range event on the victim with a CONDITION_HP_PCT check; Execute
--     itself also needs the target under 20%.
-- Not here: creatures whose AI is not the converted one (the conversion kept their own AI on purpose), creatures with a C++
-- script (Obsidian Destroyer, Blackwing Warlock, Isalien and others), stealth-alert talk (no such event in this core), and Mogh
-- the Undying's despawn of his Kurzen Mindslave on evade (a Mindslave is also spawned next to him in the world data, so this
-- needs its own look). A VMaNGOS event without the repeatable flag is not repeatable here. Safe to run again.

DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND ((`entryorguid` = 7156 AND `id` = 2) OR (`entryorguid` = 7157 AND `id` IN (1, 2, 3))
OR (`entryorguid` = 7158 AND `id` = 4) OR (`entryorguid` = 7463 AND `id` = 1) OR (`entryorguid` = 11880 AND `id` IN (3, 4, 5))
OR (`entryorguid` = 11881 AND `id` = 3) OR (`entryorguid` = 15213 AND `id` = 6));
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`Difficulties`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`action_param7`,`action_param_string`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_param_string`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(7156,0,2,0,'',6,0,100,1,0,0,0,0,0,'',45,7157,7157,0,0,0,0,0,'',19,7157,10,0,0,'',0,0,0,0,'VMaNGOS EventAI 715601'),
(7157,0,1,0,'',6,0,100,1,0,0,0,0,0,'',45,7157,7157,0,0,0,0,0,'',19,7157,10,0,0,'',0,0,0,0,'VMaNGOS EventAI 715701'),
(7157,0,2,3,'',38,0,100,1,7157,7157,0,0,0,'',11,8599,1,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'VMaNGOS EventAI 715702'),
(7157,0,3,0,'',61,0,100,0,0,0,0,0,0,'',1,0,0,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'VMaNGOS EventAI 715702'),
(7158,0,4,0,'',6,0,100,1,0,0,0,0,0,'',45,7157,7157,0,0,0,0,0,'',19,7157,10,0,0,'',0,0,0,0,'VMaNGOS EventAI 715802'),
(11880,0,3,0,'',6,0,100,1,0,0,0,0,0,'',45,11880,11880,0,0,0,0,0,'',19,11880,10,0,0,'',0,0,0,0,'VMaNGOS EventAI 1188003'),
(11880,0,4,5,'',38,0,100,1,11880,11880,0,0,0,'',11,8602,1,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'VMaNGOS EventAI 1188002'),
(11880,0,5,0,'',61,0,100,0,0,0,0,0,0,'',1,1,0,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'VMaNGOS EventAI 1188002'),
(11881,0,3,0,'',6,0,100,1,0,0,0,0,0,'',45,11880,11880,0,0,0,0,0,'',19,11880,10,0,0,'',0,0,0,0,'VMaNGOS EventAI 1188102'),
(15213,0,6,0,'',6,0,100,1,0,0,0,0,0,'',45,11880,11880,0,0,0,0,0,'',19,11880,10,0,0,'',0,0,0,0,'VMaNGOS EventAI 1521304'),
(7463,0,1,0,'',9,0,100,0,0,5,30000,30000,0,'',11,7160,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'VMaNGOS EventAI 746301');

-- Hederine Slayer: the Execute line only runs while the victim (the event's invoker) is below 20% health.
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceGroup` = 2 AND `SourceEntry` = 7463 AND `SourceId` = 0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ConditionStringValue1`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(22,2,7463,0,0,38,0,20,2,0,'',0,0,0,'','Hederine Slayer - Execute only on a victim below 20% health');

DELETE FROM `creature_text` WHERE (`CreatureID` = 7157 AND `GroupID` = 0 AND `ID` = 0) OR (`CreatureID` = 11880 AND `GroupID` = 1 AND `ID` = 0);
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`SoundPlayType`,`BroadcastTextId`,`TextRange`,`comment`) VALUES
(7157,0,0,'(BroadcastText 1151)',16,0,100,0,0,0,0,1151,0,'VMaNGOS EventAI'),
(11880,1,0,'(BroadcastText 1151)',16,0,100,0,0,0,0,1151,0,'VMaNGOS EventAI');
