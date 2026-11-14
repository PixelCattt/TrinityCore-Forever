-- Shadowfang Keep: after Fenrus the Devourer dies, the door to Wolf Master Nandos never opens (Discord, voldemargreed "bugs 5",
-- 2026-11-14). The door (18972) opens when four of Arugal's Voidwalkers (4627) have died (classic_instance_shadowfang_keep,
-- instance data 6), and neither half of that worked:
-- 1. The voidwalkers never came. Fenrus' death (VMaNGOS EventAI 427403) summons Archmage Arugal for 14 s and then calls the
--    timed action list 950001184 (VMaNGOS generic script 9536: four voidwalkers after 14 s) on Fenrus himself. A dead creature's
--    SmartAI is not updated (SmartAI::UpdateAI returns when the owner is dead), so the list never ran. The list now runs on the
--    Arugal that Fenrus summons (On Just Summoned), which is alive for those 14 s; the voidwalkers come at 12 s instead of 14,
--    while he is still there.
-- 2. The voidwalkers had no script of ours: VMaNGOS EventAI 4627 (Dark Offering on hurt friends, instance data 6 on aggro /
--    evade / death) was never converted, so even killed voidwalkers counted nothing. Ported here.
-- Safe to run again.
UPDATE `smart_scripts` SET `link` = 0 WHERE `entryorguid` = 4274 AND `source_type` = 0 AND `id` = 2;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 4274 AND `source_type` = 0 AND `id` = 3;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 4275 AND `source_type` = 0 AND `id` = 20;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(4275,0,20,0,54,0,100,0,0,0,0,0,80,950001184,2,0,0,0,0,1,0,0,0,0,0,0,0,'Archmage Arugal - On Just Summoned (Fenrus event) - Summon Arugal''s Voidwalkers (VMaNGOS generic_scripts 9536)');
UPDATE `smart_scripts` SET `event_param1` = 12000, `event_param2` = 12000
WHERE `entryorguid` = 950001184 AND `source_type` = 9 AND `id` = 0;

UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 4627;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 4627 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(4627,0,0,0,74,0,100,0,0,90,7000,7000,11,7154,0,0,0,0,0,9,4627,0,10,0,0,0,0,'Arugal''s Voidwalker - Friendly Voidwalker Hurt - Cast Dark Offering (VMaNGOS EventAI 462701)'),
(4627,0,1,0,4,0,100,0,0,0,0,0,34,6,1,0,0,0,0,1,0,0,0,0,0,0,0,'Arugal''s Voidwalker - On Aggro - Set Instance Data 6 to IN_PROGRESS (VMaNGOS EventAI 462702)'),
(4627,0,2,0,7,0,100,0,0,0,0,0,34,6,2,0,0,0,0,1,0,0,0,0,0,0,0,'Arugal''s Voidwalker - On Evade - Set Instance Data 6 to FAIL (VMaNGOS EventAI 462703)'),
(4627,0,3,0,6,0,100,0,0,0,0,0,34,6,3,0,0,0,0,1,0,0,0,0,0,0,0,'Arugal''s Voidwalker - On Death - Set Instance Data 6 to DONE (VMaNGOS EventAI 462704)');
