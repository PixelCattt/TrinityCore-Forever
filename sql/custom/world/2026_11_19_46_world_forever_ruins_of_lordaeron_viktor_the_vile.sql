-- Classic 1.60 (WoW Forever): Ruins of Lordaeron (map 2999), Viktor the Vile. Lighting the Warm Kindling 616225 in the burned
-- house by the graveyard starts five waves of undead, then Viktor the Vile 256035 comes out at the fire (encounter 3411).
-- Data: EG Link (Efficient Games, CC BY 4.0, "Data from Efficient Games EG Link") has encounter 3411 with boss 256035 on map
-- 2999, killed 7 yards from the Warm Kindling, and Skeletons, Plague Ghouls, Skeletal Soldiers and Skeletal Mages fighting at
-- the fire with no standing spawn there. The dungeon guides (method.gg, wow.gg) say five waves, then the boss on the sixth,
-- with little time between waves. Which mobs come in which wave, from where and how fast is not in any open data yet: the
-- wave make-up, the two arrival points and the 40 s gap below are our own choice from those mobs and replace easily when a
-- sniff of the event turns up.
-- Before this Viktor stood under the floor (z -84, from the 5 Nov restore) and the fire had no script. Safe to run again.

-- Viktor only comes from the fire; he is undead (EG Link: creature type 6)
UPDATE `creature_template` SET `type` = 6 WHERE `entry` = 256035;
DELETE FROM `creature` WHERE `id` = 256035;
-- the wave mobs and Viktor run SmartAI (the engage lines of the wave mobs are the statue's, 2026_10_11_03)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (250618,250624,250626,250630,256035);
-- the instance script tracks Viktor as boss 5 (encounter 3411) by itself; the old SAI boss-state lines are dropped
DELETE FROM `smart_scripts` WHERE `entryorguid` = 256035 AND `source_type` = 0 AND `id` IN (50,90,91);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`Difficulties`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`action_param7`,`action_param_string`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_param_string`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(256035,0,50,0,'',38,0,100,0,2,1,0,0,0,'',38,0,0,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'Viktor the Vile - On Data Set 2 1 (summoned by the Warm Kindling) - Engage the instance');

-- the Warm Kindling (a button) runs the event
UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI', `ScriptName` = '' WHERE `entry` = 616225;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 616225 AND `source_type` = 1;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 61622500 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`Difficulties`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`action_param7`,`action_param_string`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_param_string`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(616225,1,0,0,'',1,0,100,1,0,0,0,0,0,'',22,1,0,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'Warm Kindling - On first update - Set Phase 1 (ready to light)'),
(616225,1,1,5,'',64,1,100,0,1,0,0,0,0,'',22,2,0,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'Warm Kindling - On Use - Set Phase 2 (event running)'),
(616225,1,5,0,'',61,0,100,0,0,0,0,0,0,'',80,61622500,0,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'Warm Kindling - On Use - Start the waves'),
(616225,1,2,0,'',82,2,100,0,256035,0,0,0,0,'',22,3,0,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'Warm Kindling - Viktor the Vile died - Set Phase 3 (done)'),
(616225,1,3,0,'',35,2,100,0,256035,0,0,0,0,'',22,1,0,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'Warm Kindling - Viktor despawned unkilled (wipe) - Set Phase 1'),
(616225,1,4,0,'',59,2,100,0,1,0,0,0,0,'',22,1,0,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'Warm Kindling - Not finished after 15 min - Set Phase 1'),
(61622500,9,0,0,'',0,0,100,0,0,0,0,0,0,'',67,1,900000,900000,0,0,100,0,'',1,0,0,0,0,'',0,0,0,0,'Warm Kindling - Lit - Re-arm in 15 min if Viktor is not killed'),
(61622500,9,1,0,'',0,0,100,0,0,0,0,0,0,'',12,250618,4,120000,1,0,3,0,'',8,0,0,0,0,'',1467.52,384.4,61.75,0.09,'Warm Kindling - Wave 1 - Summon 3 Skeleton (west)'),
(61622500,9,2,0,'',0,0,100,0,0,0,0,0,0,'',45,2,1,0,0,0,0,0,'',12,1,0,0,0,'',0,0,0,0,'Warm Kindling - Wave 1 - Skeleton engages (Set Data 2 1)'),
(61622500,9,3,0,'',0,0,100,0,40000,40000,0,0,0,'',12,250618,4,120000,1,0,3,0,'',8,0,0,0,0,'',1505.89,349.03,61.72,1.571,'Warm Kindling - Wave 2 - Summon 3 Skeleton (north)'),
(61622500,9,4,0,'',0,0,100,0,0,0,0,0,0,'',45,2,1,0,0,0,0,0,'',12,1,0,0,0,'',0,0,0,0,'Warm Kindling - Wave 2 - Skeleton engages (Set Data 2 1)'),
(61622500,9,5,0,'',0,0,100,0,40000,40000,0,0,0,'',12,250618,4,120000,1,0,2,0,'',8,0,0,0,0,'',1467.52,384.4,61.75,0.09,'Warm Kindling - Wave 3 - Summon 2 Skeleton (west)'),
(61622500,9,6,0,'',0,0,100,0,0,0,0,0,0,'',12,250630,4,120000,2,0,1,0,'',8,0,0,0,0,'',1505.89,349.03,61.72,1.571,'Warm Kindling - Wave 3 - Summon 1 Plague Ghoul (north)'),
(61622500,9,7,0,'',0,0,100,0,0,0,0,0,0,'',45,2,1,0,0,0,0,0,'',12,1,0,0,0,'',0,0,0,0,'Warm Kindling - Wave 3 - Skeleton engages (Set Data 2 1)'),
(61622500,9,8,0,'',0,0,100,0,0,0,0,0,0,'',45,2,1,0,0,0,0,0,'',12,2,0,0,0,'',0,0,0,0,'Warm Kindling - Wave 3 - Plague Ghoul engages (Set Data 2 1)'),
(61622500,9,9,0,'',0,0,100,0,40000,40000,0,0,0,'',12,250624,4,120000,1,0,1,0,'',8,0,0,0,0,'',1467.52,384.4,61.75,0.09,'Warm Kindling - Wave 4 - Summon 1 Skeletal Mage (west)'),
(61622500,9,10,0,'',0,0,100,0,0,0,0,0,0,'',12,250626,4,120000,2,0,1,0,'',8,0,0,0,0,'',1505.89,349.03,61.72,1.571,'Warm Kindling - Wave 4 - Summon 1 Skeletal Soldier (north)'),
(61622500,9,11,0,'',0,0,100,0,0,0,0,0,0,'',12,250618,4,120000,3,0,1,0,'',8,0,0,0,0,'',1505.89,349.03,61.72,1.571,'Warm Kindling - Wave 4 - Summon 1 Skeleton (north)'),
(61622500,9,12,0,'',0,0,100,0,0,0,0,0,0,'',45,2,1,0,0,0,0,0,'',12,1,0,0,0,'',0,0,0,0,'Warm Kindling - Wave 4 - Skeletal Mage engages (Set Data 2 1)'),
(61622500,9,13,0,'',0,0,100,0,0,0,0,0,0,'',45,2,1,0,0,0,0,0,'',12,2,0,0,0,'',0,0,0,0,'Warm Kindling - Wave 4 - Skeletal Soldier engages (Set Data 2 1)'),
(61622500,9,14,0,'',0,0,100,0,0,0,0,0,0,'',45,2,1,0,0,0,0,0,'',12,3,0,0,0,'',0,0,0,0,'Warm Kindling - Wave 4 - Skeleton engages (Set Data 2 1)'),
(61622500,9,15,0,'',0,0,100,0,40000,40000,0,0,0,'',12,250630,4,120000,1,0,1,0,'',8,0,0,0,0,'',1467.52,384.4,61.75,0.09,'Warm Kindling - Wave 5 - Summon 1 Plague Ghoul (west)'),
(61622500,9,16,0,'',0,0,100,0,0,0,0,0,0,'',12,250626,4,120000,2,0,1,0,'',8,0,0,0,0,'',1505.89,349.03,61.72,1.571,'Warm Kindling - Wave 5 - Summon 1 Skeletal Soldier (north)'),
(61622500,9,17,0,'',0,0,100,0,0,0,0,0,0,'',12,250624,4,120000,3,0,1,0,'',8,0,0,0,0,'',1505.89,349.03,61.72,1.571,'Warm Kindling - Wave 5 - Summon 1 Skeletal Mage (north)'),
(61622500,9,18,0,'',0,0,100,0,0,0,0,0,0,'',45,2,1,0,0,0,0,0,'',12,1,0,0,0,'',0,0,0,0,'Warm Kindling - Wave 5 - Plague Ghoul engages (Set Data 2 1)'),
(61622500,9,19,0,'',0,0,100,0,0,0,0,0,0,'',45,2,1,0,0,0,0,0,'',12,2,0,0,0,'',0,0,0,0,'Warm Kindling - Wave 5 - Skeletal Soldier engages (Set Data 2 1)'),
(61622500,9,20,0,'',0,0,100,0,0,0,0,0,0,'',45,2,1,0,0,0,0,0,'',12,3,0,0,0,'',0,0,0,0,'Warm Kindling - Wave 5 - Skeletal Mage engages (Set Data 2 1)'),
(61622500,9,21,0,'',0,0,100,0,40000,40000,0,0,0,'',12,256035,4,120000,1,0,1,0,'',8,0,0,0,0,'',1504.06,388.26,61.6,3.14,'Warm Kindling - Wave 6 - Summon Viktor the Vile at the fire'),
(61622500,9,22,0,'',0,0,100,0,0,0,0,0,0,'',45,2,1,0,0,0,0,0,'',12,1,0,0,0,'',0,0,0,0,'Warm Kindling - Wave 6 - Viktor the Vile engages (Set Data 2 1)');
-- once Viktor is dead in this instance (boss 5 DONE, kept over a restart) the fire does nothing
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 616225 AND `SourceId` = 1;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(22,2,616225,1,0,13,1,5,3,2,1,0,0,'','Warm Kindling - start only while Viktor the Vile (boss 5) is not done');
