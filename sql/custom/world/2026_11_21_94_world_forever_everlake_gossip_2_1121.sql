-- The last 22 gossip choices that could not fire, and the conversations they end: Thrall (What the Wind Carries), Loramus
-- Thalipedes, Ragged John (The True Masters) and Magistrate Marduke get their missing steps; Eitrigg's and Rabine Saturna's
-- conversations are put in order; Old Ironbark only turns into Ironbark the Redeemed once Zevrim Thornhoof is dead and opens
-- the door from his own menu; Raene Wolfrunner, Rexxar, the Fallen Hero of the Horde, Regthar Deathgate, the Orphan
-- Matrons, Falrin Treeshaper, Bodley, Mux Manascrambler and Itharius get the options their choices wait on, and item gifts
-- are cast by the player on themselves.
-- Data from Everlake (GPL-3.0), commit cf07dad, files 2026_11_19_935, 967 and 968, built from VMaNGOS's world data (menus,
-- options, conditions; AzerothCore's for Bodley and Itharius) and the client's text for each option. Changed: checked
-- against our world (missing rows missing, old rows exactly as expected, every text, spell, item, quest and creature
-- present, the Dire Maul instance data ids match our script) and written as our own rows. Not taken: Everlake's removal
-- of unused Cataclysm gossip rows, and the Beaten Corpse change (ours is already right). Not checked in game.
-- New rows only where missing; conditions only where the option or event has none yet; changed rows only while they are
-- still the old ones. Safe to run more than once.

-- 1. Conversation steps our world lacks (their texts are in npc_text)
DROP TEMPORARY TABLE IF EXISTS `forever_gossip_menu`;
CREATE TEMPORARY TABLE `forever_gossip_menu` SELECT `MenuID`,`TextID` FROM `gossip_menu` WHERE 0;
INSERT INTO `forever_gossip_menu` (`MenuID`,`TextID`) VALUES
(3668,5736), -- Thrall
(3669,5737), -- Thrall
(3670,5738), -- Thrall
(1184,1816), -- Loramus Thalipedes
(1185,1817), -- Loramus Thalipedes
(2071,2717), -- Ragged John
(2070,2718), -- Ragged John
(2069,2719), -- Ragged John
(2068,2720), -- Ragged John
(2067,2721), -- Ragged John
(2066,2722), -- Ragged John
(2065,2723), -- Ragged John
(2064,2725); -- Ragged John
INSERT INTO `gossip_menu` (`MenuID`,`TextID`,`VerifiedBuild`) SELECT m.`MenuID`,m.`TextID`,0 FROM `forever_gossip_menu` m
WHERE NOT EXISTS (SELECT 1 FROM `gossip_menu` g WHERE g.`MenuID` = m.`MenuID`);
DROP TEMPORARY TABLE `forever_gossip_menu`;

-- 2. The missing options
DROP TEMPORARY TABLE IF EXISTS `forever_gossip_opt`;
CREATE TEMPORARY TABLE `forever_gossip_opt` SELECT `MenuID`,`GossipOptionID`,`OptionID`,`OptionText`,`OptionBroadcastTextID`,`ActionMenuID` FROM `gossip_menu_option` WHERE 0;
INSERT INTO `forever_gossip_opt` (`MenuID`,`GossipOptionID`,`OptionID`,`OptionText`,`OptionBroadcastTextID`,`ActionMenuID`) VALUES
(3668,-939008,0,'I... I did not think of it that way, Warchief.',8316,3669), -- Thrall
(3669,-939264,0,'I live only to serve, Warchief! My life is empty and meaningless without your guidance.',8318,3670), -- Thrall
(3670,-939520,0,'Of course, Warchief!',8320,0), -- Thrall
(1184,-303104,0,'I will do this with or without your help, Loramus.\n',4254,1185), -- Loramus Thalipedes
(1185,-303360,0,'Yes.\n',4256,0), -- Loramus Thalipedes
(2071,-530176,0,'Interesting... continue, John.',5017,2070), -- Ragged John
(2070,-529920,0,'So that''s how Windsor died...',5019,2069), -- Ragged John
(2069,-529664,0,'So how did he die?',5021,2068), -- Ragged John
(2068,-529408,0,'Ok, so where the hell is he? Wait a minute! Are you drunk?',5024,2067), -- Ragged John
(2067,-529152,0,'WHY is he in Blackrock Depths?',5027,2066), -- Ragged John
(2066,-528896,0,'300? So the Dark Irons killed him and dragged him into the Depths?',5030,2065), -- Ragged John
(2065,-528640,0,'Ahhh... Ironfoe.\n',5034,2064), -- Ragged John
(2064,-528384,0,'Thanks, Ragged John. Your story was very uplifting and informative. ',5038,0), -- Ragged John
(3368,-862208,0,'What is this plan?',6850,3367), -- Magistrate Marduke
(3367,-861952,0,'Ras Frostwhat? Who is that?',6852,3366), -- Magistrate Marduke
(3366,-861696,0,'Continue, please.\n',6854,3365), -- Magistrate Marduke
(3365,-861440,0,'Yes I do.',6856,3364), -- Magistrate Marduke
(3364,-861184,0,'Yes I am.',6858,0), -- Magistrate Marduke
(5502,-1408512,0,'Raene, I lost Dartol''s Rod of Transformation.',9025,5501), -- Raene Wolfrunner
(840,-215042,2,'Hero, I have urgent business with Corporal Splithoof.',3763,0), -- Fallen Hero of the Horde
(1882,-481792,0,'Where is Warlord Krom''zar?',4793,1883), -- Regthar Deathgate
(5481,-1403136,0,'Rexxar, I have lost the Drakefire Amulet. Could another be created?',0,0), -- Rexxar
(5849,-1497345,1,'Children''s Week is not yet over... may I have another Orphan Whistle?',9672,0), -- Orphan Matron Nightingale
(5848,-1497089,1,'Children''s Week is not yet over... may I have another Orphan Whistle?',9672,0), -- Orphan Matron Battlewail
(7084,-1813504,0,'I believe I misplaced that banner you enchanted for me, Falrin.',11910,0), -- Falrin Treeshaper
(7044,-1803264,0,'I lost Lord Valthalak''s Amulet!',11773,57014), -- Bodley
(7044,-1803265,1,'I lost a piece of Lord Valthalak''s Amulet!',11776,57015), -- Bodley
(7044,-1803266,2,'I''ve misplaced the Brazier of Beckoning!',11784,57018); -- Bodley
INSERT INTO `gossip_menu_option` (`MenuID`,`GossipOptionID`,`OptionID`,`OptionNpc`,`OptionText`,`OptionBroadcastTextID`,`Language`,`Flags`,`ActionMenuID`,`ActionPoiID`,`GossipNpcOptionID`,`BoxCoded`,`BoxMoney`,`BoxText`,`BoxBroadcastTextID`,`SpellID`,`OverrideIconID`,`VerifiedBuild`)
SELECT o.`MenuID`,o.`GossipOptionID`,o.`OptionID`,0,o.`OptionText`,o.`OptionBroadcastTextID`,0,0,o.`ActionMenuID`,0,NULL,0,0,'',0,NULL,NULL,0 FROM `forever_gossip_opt` o
WHERE NOT EXISTS (SELECT 1 FROM `gossip_menu_option` g WHERE g.`MenuID` = o.`MenuID` AND g.`OptionID` = o.`OptionID`)
  AND NOT EXISTS (SELECT 1 FROM `gossip_menu_option` g WHERE g.`GossipOptionID` = o.`GossipOptionID`);
DROP TEMPORARY TABLE `forever_gossip_opt`;

-- 3. Eitrigg: our menus 2902-2904 held an older copy of the first steps that nothing reached; they become the last steps
-- 4. Rabine Saturna: menus 5767 and 5768 had their texts and choices the wrong way round
UPDATE `gossip_menu` SET `TextID` = 3580 WHERE `MenuID` = 2902 AND `TextID` = 3574 AND NOT EXISTS (SELECT 1 FROM (SELECT `MenuID` FROM `gossip_menu` WHERE `MenuID` = 2902 AND `TextID` = 3580) x);
UPDATE `gossip_menu` SET `TextID` = 3579 WHERE `MenuID` = 2903 AND `TextID` = 3575 AND NOT EXISTS (SELECT 1 FROM (SELECT `MenuID` FROM `gossip_menu` WHERE `MenuID` = 2903 AND `TextID` = 3579) x);
UPDATE `gossip_menu` SET `TextID` = 3578 WHERE `MenuID` = 2904 AND `TextID` = 3576 AND NOT EXISTS (SELECT 1 FROM (SELECT `MenuID` FROM `gossip_menu` WHERE `MenuID` = 2904 AND `TextID` = 3578) x);
UPDATE `gossip_menu_option` SET `OptionText` = 'I will take you up on that offer, Eitrigg.', `OptionBroadcastTextID` = 5998, `ActionMenuID` = 2904 WHERE `MenuID` = 2905 AND `OptionID` = 0 AND `OptionBroadcastTextID` = 5998 AND `ActionMenuID` = 2906;
UPDATE `gossip_menu_option` SET `OptionText` = 'Ah, so that is how they pushed the Dark Iron to the lower parts of the Spire.', `OptionBroadcastTextID` = 6000, `ActionMenuID` = 2903 WHERE `MenuID` = 2904 AND `OptionID` = 0 AND `OptionBroadcastTextID` = 5996 AND `ActionMenuID` = 2905;
UPDATE `gossip_menu_option` SET `OptionText` = 'Perhaps there exists a way?', `OptionBroadcastTextID` = 6002, `ActionMenuID` = 2902 WHERE `MenuID` = 2903 AND `OptionID` = 0 AND `OptionBroadcastTextID` = 5994 AND `ActionMenuID` = 2904;
UPDATE `gossip_menu_option` SET `OptionText` = 'As you wish, Eitrigg.', `OptionBroadcastTextID` = 6004, `ActionMenuID` = 0 WHERE `MenuID` = 2902 AND `OptionID` = 0 AND `OptionBroadcastTextID` = 5992 AND `ActionMenuID` = 2903;
UPDATE `gossip_menu` SET `TextID` = 6953 WHERE `MenuID` = 5767 AND `TextID` = 6952 AND NOT EXISTS (SELECT 1 FROM (SELECT `MenuID` FROM `gossip_menu` WHERE `MenuID` = 5767 AND `TextID` = 6953) x);
UPDATE `gossip_menu` SET `TextID` = 6952 WHERE `MenuID` = 5768 AND `TextID` = 6953 AND NOT EXISTS (SELECT 1 FROM (SELECT `MenuID` FROM `gossip_menu` WHERE `MenuID` = 5768 AND `TextID` = 6952) x);
UPDATE `gossip_menu_option` SET `OptionText` = 'What would happen if the Fruit of Fertility - or the Felvine - was allowed to be fully corrupted?', `OptionBroadcastTextID` = 9542, `ActionMenuID` = 5767 WHERE `MenuID` = 5768 AND `OptionID` = 0 AND `OptionBroadcastTextID` = 6089 AND `ActionMenuID` = 0;
UPDATE `gossip_menu_option` SET `OptionText` = 'What would you have me do, Rabine?', `OptionBroadcastTextID` = 9544, `ActionMenuID` = 0 WHERE `MenuID` = 5767 AND `OptionID` = 0 AND `OptionBroadcastTextID` = 9542 AND `ActionMenuID` = 5768;

-- 5. Who may see each option, and Old Ironbark's change only after Zevrim Thornhoof (Dire Maul instance data 4 = DONE)
DROP TEMPORARY TABLE IF EXISTS `forever_gossip_cond`;
CREATE TEMPORARY TABLE `forever_gossip_cond` SELECT `SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`Comment` FROM `conditions` WHERE 0;
INSERT INTO `forever_gossip_cond` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`Comment`) VALUES
(15,5502,0,0,0,8,0,1030,0,0,0,'Raene Wolfrunner - option 5502/0 - quest rewarded 1030'),
(15,5502,0,0,0,14,0,1045,0,0,0,'Raene Wolfrunner - option 5502/0 - quest not taken or done 1045'),
(15,5502,0,0,0,2,0,5462,1,1,1,'Raene Wolfrunner - option 5502/0 - not has item 5462'),
(15,840,2,0,0,29,0,7750,50,0,1,'Fallen Hero of the Horde - option 840/2 - not creature near 7750'),
(15,840,2,0,0,14,0,2701,0,0,0,'Fallen Hero of the Horde - option 840/2 - quest not taken or done 2701'),
(15,840,2,0,0,8,0,2702,0,0,0,'Fallen Hero of the Horde - option 840/2 - quest rewarded 2702'),
(15,840,2,0,1,29,0,7750,50,0,1,'Fallen Hero of the Horde - option 840/2 - not creature near 7750'),
(15,840,2,0,1,9,0,2702,0,0,0,'Fallen Hero of the Horde - option 840/2 - quest taken 2702'),
(15,840,2,0,2,29,0,7750,50,0,1,'Fallen Hero of the Horde - option 840/2 - not creature near 7750'),
(15,840,2,0,2,9,0,2701,0,0,0,'Fallen Hero of the Horde - option 840/2 - quest taken 2701'),
(15,1882,0,0,0,9,0,4021,0,0,0,'Regthar Deathgate - option 1882/0 - quest taken 4021'),
(15,1882,0,0,0,2,0,11227,1,1,1,'Regthar Deathgate - option 1882/0 - not has item 11227'),
(15,1882,0,0,0,29,0,9524,200,0,1,'Regthar Deathgate - option 1882/0 - no Kolkar Invader alive within 200'),
(15,1882,0,0,0,29,0,9523,200,0,1,'Regthar Deathgate - option 1882/0 - no Kolkar Stormseer alive within 200'),
(15,5481,0,0,0,8,0,6602,0,0,0,'Rexxar - option 5481/0 - quest rewarded 6602'),
(15,5481,0,0,0,2,0,16309,1,1,1,'Rexxar - option 5481/0 - not has item 16309'),
(22,1,11491,0,0,13,1,4,3,0,0,'Old Ironbark - update entry - only when Zevrim Thornhoof is dead (instance data 4 = 3)'),
(15,5602,0,0,0,13,0,5,3,0,1,'Ironbark the Redeemed - option 5602/0 - door not opened yet (instance data 5 <> 3)'),
(15,5849,1,0,0,12,0,10,0,0,0,'Orphan Matron Nightingale - option 5849/1 - Children''s Week running'),
(15,5849,1,0,0,2,0,18598,1,1,1,'Orphan Matron Nightingale - option 5849/1 - not has item 18598'),
(15,5848,1,0,0,12,0,10,0,0,0,'Orphan Matron Battlewail - option 5848/1 - Children''s Week running'),
(15,5848,1,0,0,2,0,18597,1,1,1,'Orphan Matron Battlewail - option 5848/1 - not has item 18597'),
(15,7084,0,0,0,9,0,9015,0,0,0,'Falrin Treeshaper - option 7084/0 - quest taken 9015'),
(15,7084,0,0,0,2,0,21986,1,1,1,'Falrin Treeshaper - option 7084/0 - not has item 21986'),
(15,7044,0,0,0,2,0,22048,1,0,1,'Bodley - option 7044/0 - not has item 22048'),
(15,7044,0,0,0,8,0,8994,0,0,0,'Bodley - option 7044/0 - quest rewarded 8994'),
(15,7044,0,0,0,8,0,8995,0,0,1,'Bodley - option 7044/0 - quest not rewarded 8995'),
(15,7044,1,0,0,2,0,21984,1,0,1,'Bodley - option 7044/1 - not has item 21984'),
(15,7044,1,0,0,8,0,8966,0,0,0,'Bodley - option 7044/1 - quest rewarded 8966'),
(15,7044,1,0,0,8,0,8995,0,0,1,'Bodley - option 7044/1 - quest not rewarded 8995'),
(15,7044,1,0,1,2,0,21984,1,0,1,'Bodley - option 7044/1 - not has item 21984'),
(15,7044,1,0,1,8,0,8967,0,0,0,'Bodley - option 7044/1 - quest rewarded 8967'),
(15,7044,1,0,1,8,0,8995,0,0,1,'Bodley - option 7044/1 - quest not rewarded 8995'),
(15,7044,1,0,2,2,0,21984,1,0,1,'Bodley - option 7044/1 - not has item 21984'),
(15,7044,1,0,2,8,0,8968,0,0,0,'Bodley - option 7044/1 - quest rewarded 8968'),
(15,7044,1,0,2,8,0,8995,0,0,1,'Bodley - option 7044/1 - quest not rewarded 8995'),
(15,7044,1,0,3,2,0,21984,1,0,1,'Bodley - option 7044/1 - not has item 21984'),
(15,7044,1,0,3,8,0,8969,0,0,0,'Bodley - option 7044/1 - quest rewarded 8969'),
(15,7044,1,0,3,8,0,8995,0,0,1,'Bodley - option 7044/1 - quest not rewarded 8995'),
(15,7044,1,0,4,2,0,22047,1,0,1,'Bodley - option 7044/1 - not has item 22047'),
(15,7044,1,0,4,8,0,8995,0,0,1,'Bodley - option 7044/1 - quest not rewarded 8995'),
(15,7044,1,0,4,8,0,9015,0,0,0,'Bodley - option 7044/1 - quest rewarded 9015'),
(15,7044,2,0,0,2,0,22056,1,0,1,'Bodley - option 7044/2 - not has item 22056'),
(15,7044,2,0,0,8,0,8995,0,0,0,'Bodley - option 7044/2 - quest rewarded 8995'),
(15,7044,2,0,0,8,0,8996,0,0,1,'Bodley - option 7044/2 - quest not rewarded 8996');
DROP TEMPORARY TABLE IF EXISTS `forever_gossip_cond_skip`;
CREATE TEMPORARY TABLE `forever_gossip_cond_skip` SELECT DISTINCT c.`SourceTypeOrReferenceId`,c.`SourceGroup`,c.`SourceEntry`,c.`SourceId` FROM `conditions` c
WHERE EXISTS (SELECT 1 FROM `forever_gossip_cond` f WHERE f.`SourceTypeOrReferenceId` = c.`SourceTypeOrReferenceId` AND f.`SourceGroup` = c.`SourceGroup` AND f.`SourceEntry` = c.`SourceEntry` AND f.`SourceId` = c.`SourceId`);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ConditionStringValue1`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`)
SELECT f.`SourceTypeOrReferenceId`,f.`SourceGroup`,f.`SourceEntry`,f.`SourceId`,f.`ElseGroup`,f.`ConditionTypeOrReference`,f.`ConditionTarget`,f.`ConditionValue1`,f.`ConditionValue2`,f.`ConditionValue3`,'',f.`NegativeCondition`,0,0,'',f.`Comment` FROM `forever_gossip_cond` f
WHERE NOT EXISTS (SELECT 1 FROM `forever_gossip_cond_skip` k WHERE k.`SourceTypeOrReferenceId` = f.`SourceTypeOrReferenceId` AND k.`SourceGroup` = f.`SourceGroup` AND k.`SourceEntry` = f.`SourceEntry` AND k.`SourceId` = f.`SourceId`);
DROP TEMPORARY TABLE `forever_gossip_cond_skip`;
DROP TEMPORARY TABLE `forever_gossip_cond`;

-- 6. The choices; each row changes only while it is the old one
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 22227, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Raene Wolfrunner - On gossip 5502/0 - Invoker casts Create Dartol''s Rod' WHERE `entryorguid` = 3691 AND `source_type` = 0 AND `id` = 7 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000304;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 22207, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Rexxar - On gossip 5481/0 - Invoker casts Create Drakefire Amulet' WHERE `entryorguid` = 10182 AND `source_type` = 0 AND `id` = 6 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000400;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 17681, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Magistrate Marduke - On gossip 3364/0 - Invoker casts Reputation - Caer Darrow' WHERE `entryorguid` = 11286 AND `source_type` = 0 AND `id` = 1 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000426;
UPDATE `smart_scripts` SET `event_param1` = 5602, `comment` = 'Old Ironbark - On gossip 5602/0 (as Ironbark the Redeemed) - Close gossip' WHERE `entryorguid` = 11491 AND `source_type` = 0 AND `id` = 2 AND `event_type` = 62 AND `event_param1` = 5601 AND `event_param2` = 0;
-- Rabine Saturna: the cast of 33006 (VMaNGOS's own aura, not in the client) goes; his line stays
DELETE FROM `smart_scripts` WHERE `entryorguid` = 950000429 AND `source_type` = 9 AND `id` = 0 AND `action_type` = 11 AND `action_param1` = 33006;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param2` = 2, `target_type` = 7, `comment` = 'Orphan Matron Nightingale - On gossip 5849/1 - Invoker casts Human Orphan Whistle' WHERE `entryorguid` = 14450 AND `source_type` = 0 AND `id` = 1 AND `event_type` = 62 AND `event_param1` = 5849 AND `event_param2` = 1 AND `action_type` = 11 AND `action_param1` = 23124;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param2` = 2, `target_type` = 7, `comment` = 'Orphan Matron Battlewail - On gossip 5848/1 - Invoker casts Orcish Orphan Whistle' WHERE `entryorguid` = 14451 AND `source_type` = 0 AND `id` = 1 AND `event_type` = 62 AND `event_param1` = 5848 AND `event_param2` = 1 AND `action_type` = 11 AND `action_param1` = 23125;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param2` = 2, `target_type` = 7, `comment` = 'Bodley - On gossip 57015/0 - Invoker casts Create Replacement Top Piece of Lord Valthalak''s Amulet' WHERE `entryorguid` = 16033 AND `source_type` = 0 AND `id` = 0 AND `event_type` = 62 AND `event_param1` = 57015 AND `event_param2` = 0 AND `action_type` = 11 AND `action_param1` = 27542;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param2` = 2, `target_type` = 7, `comment` = 'Bodley - On gossip 57015/1 - Invoker casts Create Replacement Left Piece of Lord Valthalak''s Amulet' WHERE `entryorguid` = 16033 AND `source_type` = 0 AND `id` = 1 AND `event_type` = 62 AND `event_param1` = 57015 AND `event_param2` = 1 AND `action_type` = 11 AND `action_param1` = 27544;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param2` = 2, `target_type` = 7, `comment` = 'Bodley - On gossip 57018/0 - Invoker casts Create Replacement Brazier of Beckoning' WHERE `entryorguid` = 16033 AND `source_type` = 0 AND `id` = 2 AND `event_type` = 62 AND `event_param1` = 57018 AND `event_param2` = 0 AND `action_type` = 11 AND `action_param1` = 27566;
UPDATE `smart_scripts` SET `event_param1` = 7044, `event_param2` = 0, `action_type` = 85, `action_param2` = 2, `target_type` = 7, `comment` = 'Bodley - On gossip 7044/0 - Invoker casts Create Replacement Lord Valthalak''s Amulet' WHERE `entryorguid` = 16033 AND `source_type` = 0 AND `id` = 3 AND `event_type` = 62 AND `event_param1` = 57006 AND `event_param2` = 3 AND `action_type` = 11 AND `action_param1` = 27537;
UPDATE `smart_scripts` SET `link` = 3, `event_param1` = 16035, `target_type` = 7, `comment` = 'Itharius - On gossip 16035/0 - Say line 0' WHERE `entryorguid` = 5353 AND `source_type` = 0 AND `id` = 2 AND `event_type` = 62 AND `event_param1` = 1364 AND `event_param2` = 0 AND `action_type` = 1;
UPDATE `smart_scripts` SET `event_param2` = 2, `action_type` = 85, `action_param1` = 27754, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Mux Manascrambler - On gossip 7083/2 - Invoker casts Create Extra-Dimensional Ghost Revealer' WHERE `entryorguid` = 16014 AND `source_type` = 0 AND `id` = 0 AND `event_type` = 62 AND `event_param1` = 7083 AND `event_param2` = 0 AND `action_type` = 56 AND `action_param1` = 22115;
UPDATE `smart_scripts` SET `event_param1` = 7084, `action_type` = 85, `action_param1` = 27755, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Falrin Treeshaper - On gossip 7084/0 - Invoker casts Create Banner of Provocation' WHERE `entryorguid` = 16032 AND `source_type` = 0 AND `id` = 0 AND `event_type` = 62 AND `event_param1` = 7073 AND `event_param2` = 0 AND `action_type` = 56 AND `action_param1` = 21986;
-- Itharius: after his line, the player gets the Oathstone of Ysera's Dragonflight
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`Difficulties`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`action_param7`,`action_param_string`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_param_string`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`)
SELECT 5353,0,3,0,'',61,0,100,0,0,0,0,0,0,'',85,12578,2,0,0,0,0,0,'',7,0,0,0,0,'',0,0,0,0,'Itharius - Linked - Invoker casts Create Oathstone of Ysera''s Dragonflight' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `smart_scripts` WHERE `entryorguid` = 5353 AND `source_type` = 0 AND `id` = 3)
  AND EXISTS (SELECT 1 FROM `smart_scripts` WHERE `entryorguid` = 5353 AND `source_type` = 0 AND `id` = 2 AND `link` = 3);
