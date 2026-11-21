-- WoW Forever: Upper Blackrock Spire, the stadium event could not be won, by players or bots. Warchief Rend Blackhand (10429) comes
-- off Gyth's back when Gyth is down to 20 % (Gyth's script casts Summon Rend, 16328), and the event is won, and the exit portcullis to
-- the Beast and General Drakkisath opens, when both are dead (classic_instance_blackrock_spire: the victory talk sets the stadium
-- DONE). The Rend that comes down uses the same creature template as the Rend on the balcony, the event's speaker, and the template is
-- immune to players and creatures (unit_flags 768), so the Rend who came down could not be attacked, never died, and the portcullis
-- stayed shut. When summoned he now takes off both immunities and joins the fight; the balcony Rend is not summoned and keeps them.
-- Safe to run again.

DELETE FROM `smart_scripts` WHERE `entryorguid`=10429 AND `source_type`=0 AND `id` IN (5,6,7);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`Difficulties`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`action_param7`,`action_param_string`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_param_string`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(10429,0,5,6,'',54,0,100,0,0,0,0,0,0,'',144,0,0,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'Warchief Rend Blackhand - On Just Summoned (off Gyth) - Set Immune To Players Off'),
(10429,0,6,7,'',61,0,100,0,0,0,0,0,0,'',145,0,0,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'Warchief Rend Blackhand - On Just Summoned (off Gyth) - Set Immune To Creatures Off'),
(10429,0,7,0,'',61,0,100,0,0,0,0,0,0,'',38,0,0,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'Warchief Rend Blackhand - On Just Summoned (off Gyth) - Set In Combat With Zone');
