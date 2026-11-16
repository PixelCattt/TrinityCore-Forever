-- VMaNGOS creature AI that the conversion (2026_09_28_15) left out, for creatures that have no AI of ours at all (F4 follow-up,
-- inventory in discord-bugs-1110b/F4-VMANGOS-AI-GAPS-1116.md). Taken from VMaNGOS creature_ai_events / creature_ai_scripts as
-- their migrations leave them (2021-2025). Event mapping as in the conversion: aggro 4, HP 2 (min, max), OOC timer 1, spawned 63,
-- leaving combat 7, spell hit 8, death 6; a VMaNGOS event without the repeatable flag is not repeatable here; talk uses the
-- client's BroadcastText (classic_broadcast_text_type: 0 say, 2 emote); two random talk scripts become one weighted group.
--   1946 Lillith Nefara: her line on aggro. (Marzon the Silent Blade 1755 says his in classic_npc_marzon_the_silent_blade, The
--   Attack! 434; he is only listed below so that rows an earlier draft of this file gave him are removed.)
--   1981 Dark Iron Ambusher, 7805 Wastewander Scofflaw: flee for help at 15% health.
--   2434 Shadowy Assassin: turns hostile (faction 97) when attacked.
--   4196 Silithid Swarm: despawns when it leaves combat.
--   4264 Deepmoss Matriarch: her emote when she appears.
--   11296 Darrowshire Poltergeist: talks out of combat every 30-60 s.
--   11636 Servant of Weldon Barov, 11637 Servant of Alexi Barov: 20% chance of a line on aggro.
--   11875 / 12385 Mortar Team (Advanced) Target Dummy: Quiet Suicide when hit by Mortar Shot (16786).
--   12904 Spirit of Redemption: the body despawns at once on death (its spawn visuals 20721 / 20723 are not in this client).
--   14081 Demon Portal: passive, never moves or swings; despawns when the Felguard's spawn spell hits it.
--   14101 Enraged Felguard: fights the area on spawn and casts its spawn spell, despawns after 5 min out of combat, enrages at 30%.
--   15917 Lunar Festival Reveler: cheers every 30-45 s.
-- Left for later (VMaNGOS conditions or patch-gated): Sul'lithuz Warder, Scourge Summoning Crystal (Araj before patch 1.7),
-- Lunar Festival Herald / Emissary / Vendor, the Midsummer bonfires and Flamekeeper, Lordaeron Commander / Veteran.
-- A creature with a C++ ScriptName keeps it. Safe to run again.
-- These rows only add to what a creature already has: event ids from 100 and text group 20, and only rows with a
-- 'VMaNGOS EventAI' comment are removed, so the creature's own SmartAI and texts (Marzon's lines in Lord Gregor Lescovar's
-- scene, for one) stay as they are. Also safe on a world DB where an earlier draft of this file ran up to the texts.

UPDATE `creature_template` SET `AIName` = 'SmartAI'
WHERE `entry` IN (1946, 1981, 2434, 4196, 4264, 7805, 11296, 11636, 11637, 11875, 12385, 12904, 14081, 14101, 15917) AND `ScriptName` = ''
AND `AIName` IN ('', 'SmartAI');

DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `comment` LIKE 'VMaNGOS EventAI %'
AND `entryorguid` IN (1755, 1946, 1981, 2434, 4196, 4264, 7805, 11296, 11636, 11637, 11875, 12385, 12904, 14081, 14101, 15917);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`Difficulties`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`action_param7`,`action_param_string`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_param_string`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(1946,0,100,0,'',4,0,100,1,0,0,0,0,0,'',1,20,0,1,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'VMaNGOS EventAI 194601'),
(1981,0,100,0,'',2,0,100,1,0,15,0,0,0,'',25,0,0,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'VMaNGOS EventAI 198101'),
(7805,0,100,0,'',2,0,100,1,0,15,0,0,0,'',25,0,0,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'VMaNGOS EventAI 780501'),
(2434,0,100,0,'',4,0,100,1,0,0,0,0,0,'',2,97,0,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'VMaNGOS EventAI 243401'),
(4196,0,100,0,'',7,0,100,1,0,0,0,0,0,'',41,0,0,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'VMaNGOS EventAI 419601'),
(4264,0,100,0,'',63,0,100,1,0,0,0,0,0,'',1,20,0,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'VMaNGOS EventAI 426401'),
(11296,0,100,0,'',1,0,100,0,10000,30000,30000,60000,0,'',1,20,0,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'VMaNGOS EventAI 1129601'),
(11636,0,100,0,'',4,0,20,1,0,0,0,0,0,'',1,20,0,1,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'VMaNGOS EventAI 1163601'),
(11637,0,100,0,'',4,0,20,1,0,0,0,0,0,'',1,20,0,1,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'VMaNGOS EventAI 1163701'),
(11875,0,100,0,'',8,0,100,1,16786,0,0,0,0,'',11,3617,2,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'VMaNGOS EventAI 1187501'),
(12385,0,100,0,'',8,0,100,1,16786,0,0,0,0,'',11,3617,2,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'VMaNGOS EventAI 1238501'),
(12904,0,100,0,'',6,0,100,1,0,0,0,0,0,'',41,0,0,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'VMaNGOS EventAI 1290402'),
(14081,0,100,101,'',63,0,100,1,0,0,0,0,0,'',8,0,0,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'VMaNGOS EventAI 1408101'),
(14081,0,101,102,'',61,0,100,0,0,0,0,0,0,'',21,0,0,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'VMaNGOS EventAI 1408101'),
(14081,0,102,0,'',61,0,100,0,0,0,0,0,0,'',20,0,0,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'VMaNGOS EventAI 1408101'),
(14081,0,103,0,'',8,0,100,1,22393,0,0,0,0,'',41,0,0,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'VMaNGOS EventAI 1408102'),
(14101,0,100,101,'',63,0,100,1,0,0,0,0,0,'',38,0,0,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'VMaNGOS EventAI 1410101'),
(14101,0,101,0,'',61,0,100,0,0,0,0,0,0,'',11,22393,2,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'VMaNGOS EventAI 1410101'),
(14101,0,102,0,'',1,0,100,1,300000,300000,0,0,0,'',41,0,0,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'VMaNGOS EventAI 1410102'),
(14101,0,103,0,'',2,0,100,0,1,30,5000,5000,0,'',11,8269,34,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'VMaNGOS EventAI 1410103'),
(15917,0,100,0,'',1,0,100,0,30000,45000,30000,45000,0,'',5,71,0,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'VMaNGOS EventAI 1591701');

DELETE FROM `creature_text` WHERE `CreatureID` IN (1755, 1946, 4264, 11296, 11636, 11637) AND `comment` = 'VMaNGOS EventAI';
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`SoundPlayType`,`BroadcastTextId`,`TextRange`,`comment`) VALUES
(1946,20,0,'(BroadcastText 427)',12,0,100,0,0,0,0,427,0,'VMaNGOS EventAI'),
(4264,20,0,'(BroadcastText 1415)',16,0,100,0,0,0,0,1415,0,'VMaNGOS EventAI'),
(11296,20,0,'(BroadcastText 7205)',12,0,12.5,0,0,0,0,7205,0,'VMaNGOS EventAI'),
(11296,20,1,'(BroadcastText 7206)',12,0,12.5,0,0,0,0,7206,0,'VMaNGOS EventAI'),
(11296,20,2,'(BroadcastText 7207)',12,0,12.5,0,0,0,0,7207,0,'VMaNGOS EventAI'),
(11296,20,3,'(BroadcastText 7208)',12,0,12.5,0,0,0,0,7208,0,'VMaNGOS EventAI'),
(11296,20,4,'(BroadcastText 7209)',12,0,12.5,0,0,0,0,7209,0,'VMaNGOS EventAI'),
(11296,20,5,'(BroadcastText 7210)',12,0,12.5,0,0,0,0,7210,0,'VMaNGOS EventAI'),
(11296,20,6,'(BroadcastText 7211)',12,0,12.5,0,0,0,0,7211,0,'VMaNGOS EventAI'),
(11296,20,7,'(BroadcastText 7212)',12,0,12.5,0,0,0,0,7212,0,'VMaNGOS EventAI'),
(11636,20,0,'(BroadcastText 7150)',12,0,12.5,0,0,0,0,7150,0,'VMaNGOS EventAI'),
(11636,20,1,'(BroadcastText 7151)',12,0,25,0,0,0,0,7151,0,'VMaNGOS EventAI'),
(11636,20,2,'(BroadcastText 7152)',12,0,25,0,0,0,0,7152,0,'VMaNGOS EventAI'),
(11636,20,3,'(BroadcastText 7153)',12,0,25,0,0,0,0,7153,0,'VMaNGOS EventAI'),
(11636,20,4,'(BroadcastText 7154)',12,0,12.5,0,0,0,0,7154,0,'VMaNGOS EventAI'),
(11637,20,0,'(BroadcastText 7150)',12,0,12.5,0,0,0,0,7150,0,'VMaNGOS EventAI'),
(11637,20,1,'(BroadcastText 7151)',12,0,25,0,0,0,0,7151,0,'VMaNGOS EventAI'),
(11637,20,2,'(BroadcastText 7152)',12,0,25,0,0,0,0,7152,0,'VMaNGOS EventAI'),
(11637,20,3,'(BroadcastText 7153)',12,0,25,0,0,0,0,7153,0,'VMaNGOS EventAI'),
(11637,20,4,'(BroadcastText 7154)',12,0,12.5,0,0,0,0,7154,0,'VMaNGOS EventAI');
