-- Gossip choices that could never fire: the option the choice waits on was missing from the menu, so players never saw it.
-- 132 choices on 24 NPCs get their option: replacement insignia, Zul'Gurub talismans and armor, Anachronos's rings, the
-- AQ20 rewards, Duke Hydraxis's quintessence, Celebras's scepter, the Deathly Usher and others. Item gifts are now cast by
-- the player on themselves (an item from a spell the creature casts never reaches the player's bags).
-- Data from Everlake (GPL-3.0), commit cf07dad, file 2026_11_19_933, built from VMaNGOS's world data (menu, option, text id,
-- conditions) and the client's text for each option. Changed: checked against our world (every option missing, every menu
-- and next menu present, every choice row and every spell, item, quest and creature present, the actionlists replaced only
-- cast that one spell) and written as our own rows. Not checked in game.
-- Options only where missing; conditions only on options that have none yet; choice rows only while they are still the
-- imported ones. Safe to run more than once.

-- 1. The missing options
DROP TEMPORARY TABLE IF EXISTS `forever_gossip_opt`;
CREATE TEMPORARY TABLE `forever_gossip_opt` SELECT `MenuID`,`GossipOptionID`,`OptionID`,`OptionText`,`OptionBroadcastTextID`,`ActionMenuID` FROM `gossip_menu_option` WHERE 0;
INSERT INTO `forever_gossip_opt` (`MenuID`,`GossipOptionID`,`OptionID`,`OptionText`,`OptionBroadcastTextID`,`ActionMenuID`) VALUES
(1541,-394496,0,'I wish to face the Defiler.',4592,0), -- Deathly Usher (8816)
(2184,-559107,3,'I lost my Crystal Pylon User''s Manual and need another one.',5191,2205), -- J.D. Collie (9117)
(1842,-471552,0,'I am ready!',4759,0), -- Cyrus Therepentous (9459)
(2208,-565248,0,'I need a Cenarion beacon.',5243,0), -- Arathandris Silversky (9528)
(2207,-564992,0,'I need a Cenarion beacon.',5243,0), -- Maybess Riverbreeze (9529)
(2703,-691970,2,'I lost the Cache of Mau''ari. What can I do?',5758,50300), -- Witch Doctor Mau'ari (10307)
(5482,-1403392,0,'Haleh, I have lost the Drakefire Amulet. Could you fashion another?',9016,0), -- Haleh (10929)
(3228,-826368,0,'I need a vitreous focuser.',6531,0), -- Alchemist Arbington (11056)
(3223,-825088,0,'I need a vitreous focuser.',6531,0), -- Apothecary Dithers (11057)
(3801,-973057,1,'Myranda, do you have enough eyeballs to make another amulet? I have lost the old one.',8324,0), -- Myranda the Hag (11872)
(5065,-1296640,0,'I require a vial of aqual quintessence, Hydraxis, for I go to the Molten Core to extinguish a rune of the Firelords.',8666,0), -- Duke Hydraxis (13278)
(5065,-1296641,1,'I desire this eternal quintessence, Duke Hydraxis.',12363,0), -- Duke Hydraxis (13278)
(5349,-1369344,0,'Celebras, I lost my Scepter...',8928,5350), -- Celebras the Redeemed (13716)
(5441,-1392896,0,'Warmaster, I have lost my insignia. Could you supply me with a replacement?',9001,0), -- Warmaster Laggrond (13840)
(5441,-1392897,1,'Warmaster, I have lost my insignia. Could you supply me with a replacement?',9001,0), -- Warmaster Laggrond (13840)
(5441,-1392898,2,'Warmaster, I have lost my insignia. Could you supply me with a replacement?',9001,0), -- Warmaster Laggrond (13840)
(5441,-1392899,3,'Warmaster, I have lost my insignia. Could you supply me with a replacement?',9001,0), -- Warmaster Laggrond (13840)
(5441,-1392900,4,'Warmaster, I have lost my insignia. Could you supply me with a replacement?',9001,0), -- Warmaster Laggrond (13840)
(5441,-1392901,5,'Warmaster, I have lost my insignia. Could you supply me with a replacement?',9001,0), -- Warmaster Laggrond (13840)
(5442,-1393152,0,'Lieutenant, I have lost my insignia. Could you please supply me with a replacement?',9003,0), -- Lieutenant Haggerdin (13841)
(5442,-1393153,1,'Lieutenant, I have lost my insignia. Could you please supply me with a replacement?',9003,0), -- Lieutenant Haggerdin (13841)
(5442,-1393154,2,'Lieutenant, I have lost my insignia. Could you please supply me with a replacement?',9003,0), -- Lieutenant Haggerdin (13841)
(5442,-1393155,3,'Lieutenant, I have lost my insignia. Could you please supply me with a replacement?',9003,0), -- Lieutenant Haggerdin (13841)
(5442,-1393156,4,'Lieutenant, I have lost my insignia. Could you please supply me with a replacement?',9003,0), -- Lieutenant Haggerdin (13841)
(5442,-1393157,5,'Lieutenant, I have lost my insignia. Could you please supply me with a replacement?',9003,0), -- Lieutenant Haggerdin (13841)
(5675,-1452801,1,'Summon forth your cowardly master, fool! Let him face me!',9574,50001), -- Highlord Demitrian (14347)
(6321,-1618176,0,'I have lost my talisman and require a new one, Jin''rokh.',10380,0), -- Jin'rokh the Breaker (14902)
(6321,-1618177,1,'I have lost my talisman and require a new one, Jin''rokh.',10380,0), -- Jin'rokh the Breaker (14902)
(6321,-1618178,2,'I have lost my talisman and require a new one, Jin''rokh.',10380,0), -- Jin'rokh the Breaker (14902)
(6321,-1618179,3,'I have lost my talisman and require a new one, Jin''rokh.',10380,0), -- Jin'rokh the Breaker (14902)
(6321,-1618180,4,'I have lost my talisman and require a new one, Jin''rokh.',10380,0), -- Jin'rokh the Breaker (14902)
(6321,-1618181,5,'I have lost my talisman and require a new one, Jin''rokh.',10380,0), -- Jin'rokh the Breaker (14902)
(6321,-1618182,6,'I have lost my talisman and require a new one, Jin''rokh.',10380,0), -- Jin'rokh the Breaker (14902)
(6321,-1618183,7,'I have lost my talisman and require a new one, Jin''rokh.',10380,0), -- Jin'rokh the Breaker (14902)
(6321,-1618184,8,'Jin''rokh, I fear I''ve lost my Zandalar Vindicator''s Breastplate. Can you supply me with a replacement?',12640,0), -- Jin'rokh the Breaker (14902)
(6321,-1618185,9,'I think I''ve lost my  Zandalar Vindicator''s Belt. Can you help?',12642,0), -- Jin'rokh the Breaker (14902)
(6321,-1618186,10,'Jin''rokh, my Zandalar Vindicator''s Armguards have gone missing. Do you have a spare set?',12643,0), -- Jin'rokh the Breaker (14902)
(6321,-1618187,11,'Jin''rokh, I fear I''ve lost my Zandalar Freethinker''s Breastplate. Can you supply me with a replacement?',12644,0), -- Jin'rokh the Breaker (14902)
(6321,-1618188,12,'Jin''rokh, I have lost my Zandalar Freethinker''s Belt. Can you help?',12645,0), -- Jin'rokh the Breaker (14902)
(6321,-1618189,13,'Jin''rokh, I am missing my Zandalar Freethinker''s Armguards. Can you replace them?',12646,0), -- Jin'rokh the Breaker (14902)
(6322,-1618432,0,'I have lost the talisman and require a new one, Al''tabim.',10384,0), -- Al'tabim the All-Seeing (14903)
(6322,-1618433,1,'I have lost the talisman and require a new one, Al''tabim.',10384,0), -- Al'tabim the All-Seeing (14903)
(6322,-1618434,2,'I have lost the talisman and require a new one, Al''tabim.',10384,0), -- Al'tabim the All-Seeing (14903)
(6322,-1618435,3,'I have lost the talisman and require a new one, Al''tabim.',10384,0), -- Al'tabim the All-Seeing (14903)
(6322,-1618436,4,'I have lost the talisman and require a new one, Al''tabim.',10384,0), -- Al'tabim the All-Seeing (14903)
(6322,-1618437,5,'I have lost the talisman and require a new one, Al''tabim.',10384,0), -- Al'tabim the All-Seeing (14903)
(6322,-1618438,6,'I have lost the talisman and require a new one, Al''tabim.',10384,0), -- Al'tabim the All-Seeing (14903)
(6322,-1618439,7,'I have lost the talisman and require a new one, Al''tabim.',10384,0), -- Al'tabim the All-Seeing (14903)
(6322,-1618440,8,'I have lost the talisman and require a new one, Al''tabim.',10384,0), -- Al'tabim the All-Seeing (14903)
(6322,-1618441,9,'I have lost the talisman and require a new one, Al''tabim.',10384,0), -- Al'tabim the All-Seeing (14903)
(6322,-1618442,10,'I have lost the talisman and require a new one, Al''tabim.',10384,0), -- Al'tabim the All-Seeing (14903)
(6322,-1618443,11,'I have lost the talisman and require a new one, Al''tabim.',10384,0), -- Al'tabim the All-Seeing (14903)
(6322,-1618444,12,'I have lost my Confessor''s Mantle and require a replacement, Al''tabim.',12674,0), -- Al'tabim the All-Seeing (14903)
(6322,-1618445,13,'I no longer possess my Zandalar Confessor''s Bindings. Can you provide a replacement?',12675,0), -- Al'tabim the All-Seeing (14903)
(6322,-1618446,14,'Al''tabim, my Zandalar Confessor''s Wraps have gone missing. Can you replace them?',12676,0), -- Al'tabim the All-Seeing (14903)
(6322,-1618447,15,'I have lost my Zandalar Illusionist''s Robe and need a new one, Al''tabim.',12677,0), -- Al'tabim the All-Seeing (14903)
(6322,-1618448,16,'Al''tabim, I seem to have misplaced my Zandalar Illusionist''s Mantle. Can you supply me with a replacement?',12678,0), -- Al'tabim the All-Seeing (14903)
(6322,-1618449,17,'I no longer have my Zandalar Illusionist''s Wraps and require a new pair.',12679,0), -- Al'tabim the All-Seeing (14903)
(6322,-1618450,18,'I no longer have my Zandalar Demoniac''s Robe. Can you provide a replacement?',12680,0), -- Al'tabim the All-Seeing (14903)
(6322,-1618451,19,'Al''tabim, I have lost my Zandalar Demoniac''s Mantle. Can you help?',12681,0), -- Al'tabim the All-Seeing (14903)
(6322,-1618452,20,'My Zandalar Demoniac''s Wraps have gone missing. Can you provide me with another set?',12682,0), -- Al'tabim the All-Seeing (14903)
(6341,-1623296,0,'Maywiki, I''ve lost my talisman and require a replacement.',10427,0), -- Maywiki of Zuldazar (14904)
(6341,-1623297,1,'Maywiki, I''ve lost my talisman and require a replacement.',10427,0), -- Maywiki of Zuldazar (14904)
(6341,-1623298,2,'Maywiki, I''ve lost my talisman and require a replacement.',10427,0), -- Maywiki of Zuldazar (14904)
(6341,-1623299,3,'Maywiki, I''ve lost my talisman and require a replacement.',10427,0), -- Maywiki of Zuldazar (14904)
(6341,-1623300,4,'Maywiki, I''ve lost my talisman and require a replacement.',10427,0), -- Maywiki of Zuldazar (14904)
(6341,-1623301,5,'Maywiki, I''ve lost my talisman and require a replacement.',10427,0), -- Maywiki of Zuldazar (14904)
(6341,-1623302,6,'Maywiki, I''ve lost my talisman and require a replacement.',10427,0), -- Maywiki of Zuldazar (14904)
(6341,-1623303,7,'Maywiki, I''ve lost my talisman and require a replacement.',10427,0), -- Maywiki of Zuldazar (14904)
(6341,-1623304,8,'Maywiki, I''ve lost my Zandalar Augur''s Hauberk and need a new one.',12664,0), -- Maywiki of Zuldazar (14904)
(6341,-1623305,9,'Maywiki, a dastardly little gnome made off with my Zandalar Augur''s Belt. Can you provide a replacement?',12665,0), -- Maywiki of Zuldazar (14904)
(6341,-1623306,10,'I have misplaced my Zandalar Augur''s Bracers and require another pair.',12666,0), -- Maywiki of Zuldazar (14904)
(6341,-1623307,11,'I have lost my Zandalar Haruspex''s Tunic, Maywiki. Do you have a replacement?',12667,0), -- Maywiki of Zuldazar (14904)
(6341,-1623308,12,'Maywiki, I no longer have my Zandalar Haruspex''s Belt. Can you help?',12668,0), -- Maywiki of Zuldazar (14904)
(6341,-1623309,13,'I''ve misplaced my Zandalar Haruspex''s Bracers and require another pair.',12669,0), -- Maywiki of Zuldazar (14904)
(6363,-1628928,0,'I have lost the talisman, Falthir. I require a replacement.',10439,0), -- Falthir the Sightless (14905)
(6363,-1628929,1,'I have lost the talisman, Falthir. I require a replacement.',10439,0), -- Falthir the Sightless (14905)
(6363,-1628930,2,'I have lost the talisman, Falthir. I require a replacement.',10439,0), -- Falthir the Sightless (14905)
(6363,-1628931,3,'I have lost the talisman, Falthir. I require a replacement.',10439,0), -- Falthir the Sightless (14905)
(6363,-1628932,4,'I have lost the talisman, Falthir. I require a replacement.',10439,0), -- Falthir the Sightless (14905)
(6363,-1628933,5,'I have lost the talisman, Falthir. I require a replacement.',10439,0), -- Falthir the Sightless (14905)
(6363,-1628934,6,'I have lost the talisman, Falthir. I require a replacement.',10439,0), -- Falthir the Sightless (14905)
(6363,-1628935,7,'I have lost the talisman, Falthir. I require a replacement.',10439,0), -- Falthir the Sightless (14905)
(6363,-1628936,8,'I''ve lost my Zandalar Madcap''s Tunic and require a new one, Falthir.',12655,0), -- Falthir the Sightless (14905)
(6363,-1628937,9,'Falthir, I have lost my Zandalar Madcap''s Mantle. Do you have a replacement?',12656,0), -- Falthir the Sightless (14905)
(6363,-1628938,10,'I seem to have misplaced my Zandalar Madap''s Bracers. Can you help?',12657,0), -- Falthir the Sightless (14905)
(6363,-1628939,11,'Falthir, I have lost my Zandalar Predator''s Mantle and need a replacement.',12658,0), -- Falthir the Sightless (14905)
(6363,-1628940,12,'My Zandalar Predator''s Belt has gone missing. Can you help, Falthir?',12659,0), -- Falthir the Sightless (14905)
(6363,-1628941,13,'Falthir, I no longer have my Zandalar Predator''s Bracers. Can you provide a new pair?',12660,0), -- Falthir the Sightless (14905)
(6539,-1673984,0,'Anachronos, I have lost the signet ring. Could you supply me with a replacement?',11348,0), -- Anachronos (15192)
(6539,-1673985,1,'Anachronos, I have lost the signet ring. Could you supply me with a replacement?',11348,0), -- Anachronos (15192)
(6539,-1673986,2,'Anachronos, I have lost the signet ring. Could you supply me with a replacement?',11348,0), -- Anachronos (15192)
(6539,-1673987,3,'Anachronos, I have lost the signet ring. Could you supply me with a replacement?',11348,0), -- Anachronos (15192)
(6539,-1673988,4,'Anachronos, I have lost the signet ring. Could you supply me with a replacement?',11348,0), -- Anachronos (15192)
(6539,-1673989,5,'Anachronos, I have lost the signet ring. Could you supply me with a replacement?',11348,0), -- Anachronos (15192)
(6539,-1673990,6,'Anachronos, I have lost the signet ring. Could you supply me with a replacement?',11348,0), -- Anachronos (15192)
(6539,-1673991,7,'Anachronos, I have lost the signet ring. Could you supply me with a replacement?',11348,0), -- Anachronos (15192)
(6539,-1673992,8,'Anachronos, I have lost the signet ring. Could you supply me with a replacement?',11348,0), -- Anachronos (15192)
(6539,-1673993,9,'Anachronos, I have lost the signet ring. Could you supply me with a replacement?',11348,0), -- Anachronos (15192)
(6539,-1673994,10,'Anachronos, I have lost the signet ring. Could you supply me with a replacement?',11348,0), -- Anachronos (15192)
(6539,-1673995,11,'Anachronos, I have lost the signet ring. Could you supply me with a replacement?',11348,0), -- Anachronos (15192)
(6539,-1673996,12,'Anachronos, I have lost the signet ring. Could you supply me with a replacement?',11348,0), -- Anachronos (15192)
(6539,-1673997,13,'Anachronos, I have lost the signet ring. Could you supply me with a replacement?',11348,0), -- Anachronos (15192)
(6539,-1673998,14,'Anachronos, I have lost the signet ring. Could you supply me with a replacement?',11348,0), -- Anachronos (15192)
(6928,-1773568,0,'I have lost my Band of Unending Life. Are you able to replace it for me?',12718,0), -- Windcaller Yessendra (15498)
(6928,-1773569,1,'I have lost my Signet of the Unseen Path. Are you able to replace it for me?',12719,0), -- Windcaller Yessendra (15498)
(6928,-1773570,2,'I have lost my Band of Vaulted Secrets. Are you able to replace it for me?',12720,0), -- Windcaller Yessendra (15498)
(6928,-1773571,3,'I have lost my Ring of Eternal Justice. Are you able to replace it for me?',12721,0), -- Windcaller Yessendra (15498)
(6928,-1773572,4,'I have lost my Ring of Infinite Wisdom. Are you able to replace it for me?',12722,0), -- Windcaller Yessendra (15498)
(6928,-1773573,5,'I have lost my Band of Veiled Shadows. Are you able to replace it for me?',12723,0), -- Windcaller Yessendra (15498)
(6928,-1773574,6,'I have lost my Ring of the Gathering Storm. Are you able to replace it for me?',12724,0), -- Windcaller Yessendra (15498)
(6928,-1773575,7,'I have lost my Ring of Unspoken Names. Are you able to replace it for me?',12725,0), -- Windcaller Yessendra (15498)
(6928,-1773576,8,'I have lost my Signet of Unyielding Strength. Are you able to replace it for me?',12727,0), -- Windcaller Yessendra (15498)
(6925,-1772800,0,'I have lost my Mace of Unending Life. Are you able to replace it for me?',12693,0), -- Warden Haro (15499)
(6925,-1772801,1,'I have lost my Scythe of the Unseen Path. Are you able to replace it for me?',12694,0), -- Warden Haro (15499)
(6925,-1772802,2,'I have lost my Blade of Vaulted Secrets. Are you able to replace it for me?',12695,0), -- Warden Haro (15499)
(6925,-1772803,3,'I have lost my Blade of Eternal Justice. Are you able to replace it for me?',12696,0), -- Warden Haro (15499)
(6925,-1772804,4,'I have lost my Gavel of Infinite Wisdom. Are you able to replace it for me?',12697,0), -- Warden Haro (15499)
(6925,-1772805,5,'I have lost my Dagger of Veiled Shadows. Are you able to replace it for me?',12699,0), -- Warden Haro (15499)
(6925,-1772806,6,'I have lost my Hammer of the Gathering Storm. Are you able to replace it for me?',12701,0), -- Warden Haro (15499)
(6925,-1772807,7,'I have lost my Kris of Unspoken Names. Are you able to replace it for me?',12702,0), -- Warden Haro (15499)
(6925,-1772808,8,'I have lost my Sickle of Unyielding Strength. Are you able to replace it for me?',12705,0), -- Warden Haro (15499)
(6927,-1773312,0,'I have lost my Cloak of Unending Life. Are you able to replace it for me?',12708,0), -- Keyl Swiftclaw (15500)
(6927,-1773313,1,'I have lost my Cloak of the Unseen Path. Are you able to replace it for me?',12710,0), -- Keyl Swiftclaw (15500)
(6927,-1773314,2,'I have lost my Drape of Vaulted Secrets. Are you able to replace it for me?',12711,0), -- Keyl Swiftclaw (15500)
(6927,-1773315,3,'I have lost my Cape of Eternal Justice. Are you able to replace it for me?',12712,0), -- Keyl Swiftclaw (15500)
(6927,-1773316,4,'I have lost my Shroud of Infinite Wisdom. Are you able to replace it for me?',12713,0), -- Keyl Swiftclaw (15500)
(6927,-1773317,5,'I have lost my Cloak of Veiled Shadows. Are you able to replace it for me?',12714,0), -- Keyl Swiftclaw (15500)
(6927,-1773318,6,'I have lost my Cloak of the Gathering Storm. Are you able to replace it for me?',12715,0), -- Keyl Swiftclaw (15500)
(6927,-1773319,7,'I have lost my Shroud of Unspoken Names. Are you able to replace it for me?',12716,0), -- Keyl Swiftclaw (15500)
(6927,-1773320,8,'I have lost my Drape of Unyielding Strength. Are you able to replace it for me?',12717,0), -- Keyl Swiftclaw (15500)
(126,-32256,0,'You''re Astor Hadren, right?',2589,125); -- Astor Hadren (6497)
INSERT INTO `gossip_menu_option` (`MenuID`,`GossipOptionID`,`OptionID`,`OptionNpc`,`OptionText`,`OptionBroadcastTextID`,`Language`,`Flags`,`ActionMenuID`,`ActionPoiID`,`GossipNpcOptionID`,`BoxCoded`,`BoxMoney`,`BoxText`,`BoxBroadcastTextID`,`SpellID`,`OverrideIconID`,`VerifiedBuild`)
SELECT o.`MenuID`,o.`GossipOptionID`,o.`OptionID`,0,o.`OptionText`,o.`OptionBroadcastTextID`,0,0,o.`ActionMenuID`,0,NULL,0,0,'',0,NULL,NULL,0 FROM `forever_gossip_opt` o
WHERE NOT EXISTS (SELECT 1 FROM `gossip_menu_option` g WHERE g.`MenuID` = o.`MenuID` AND g.`OptionID` = o.`OptionID`)
  AND NOT EXISTS (SELECT 1 FROM `gossip_menu_option` g WHERE g.`GossipOptionID` = o.`GossipOptionID`);
DROP TEMPORARY TABLE `forever_gossip_opt`;

-- 2. Who may see each option (quest done or taken, item held, reputation, a creature nearby, not in a group)
DROP TEMPORARY TABLE IF EXISTS `forever_gossip_cond`;
CREATE TEMPORARY TABLE `forever_gossip_cond` SELECT `SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`Comment` FROM `conditions` WHERE 0;
INSERT INTO `forever_gossip_cond` (`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`Comment`) VALUES
(1541,0,0,8,3628,0,0,1,'Deathly Usher - option 1541/0 - not quest rewarded 3628'),
(1541,0,0,2,10757,1,0,0,'Deathly Usher - option 1541/0 - has item 10757'),
(1541,0,0,60,0,0,0,0,'Deathly Usher - option 1541/0 - group status 0'),
(2184,3,0,2,11482,1,1,1,'J.D. Collie - option 2184/3 - not has item 11482'),
(2184,3,0,8,4321,0,0,0,'J.D. Collie - option 2184/3 - quest rewarded 4321'),
(1842,0,0,29,9461,500,0,1,'Cyrus Therepentous - option 1842/0 - not creature near 9461'),
(2208,0,0,8,4101,0,0,0,'Arathandris Silversky - option 2208/0 - quest rewarded 4101'),
(2208,0,0,2,11511,1,1,1,'Arathandris Silversky - option 2208/0 - not has item 11511'),
(2207,0,0,8,4102,0,0,0,'Maybess Riverbreeze - option 2207/0 - quest rewarded 4102'),
(2207,0,0,2,11511,1,1,1,'Maybess Riverbreeze - option 2207/0 - not has item 11511'),
(2703,2,0,8,975,0,0,0,'Witch Doctor Mau''ari - option 2703/2 - quest rewarded 975'),
(2703,2,0,2,12384,1,1,1,'Witch Doctor Mau''ari - option 2703/2 - not has item 12384'),
(5482,0,0,8,6502,0,0,0,'Haleh - option 5482/0 - quest rewarded 6502'),
(5482,0,0,2,16309,1,1,1,'Haleh - option 5482/0 - not has item 16309'),
(3228,0,0,2,13370,1,1,1,'Alchemist Arbington - option 3228/0 - not has item 13370'),
(3228,0,0,8,5237,0,0,0,'Alchemist Arbington - option 3228/0 - quest rewarded 5237'),
(3223,0,0,2,13370,1,1,1,'Apothecary Dithers - option 3223/0 - not has item 13370'),
(3223,0,0,8,5238,0,0,0,'Apothecary Dithers - option 3223/0 - quest rewarded 5238'),
(3801,1,0,9,6570,0,0,0,'Myranda the Hag - option 3801/1 - quest taken 6570'),
(3801,1,0,2,16787,1,1,1,'Myranda the Hag - option 3801/1 - not has item 16787'),
(5065,0,0,2,17333,1,1,1,'Duke Hydraxis - option 5065/0 - not has item 17333'),
(5065,0,0,8,6824,0,0,0,'Duke Hydraxis - option 5065/0 - quest rewarded 6824'),
(5065,0,0,5,749,224,0,0,'Duke Hydraxis - option 5065/0 - reputation 749'),
(5065,1,0,5,749,192,0,0,'Duke Hydraxis - option 5065/1 - reputation 749'),
(5065,1,0,8,6824,0,0,0,'Duke Hydraxis - option 5065/1 - quest rewarded 6824'),
(5065,1,0,2,22754,1,1,1,'Duke Hydraxis - option 5065/1 - not has item 22754'),
(5349,0,0,8,7046,0,0,0,'Celebras the Redeemed - option 5349/0 - quest rewarded 7046'),
(5349,0,0,2,17191,1,1,1,'Celebras the Redeemed - option 5349/0 - not has item 17191'),
(5441,0,0,8,7163,0,0,1,'Warmaster Laggrond - option 5441/0 - not quest rewarded 7163'),
(5441,0,0,2,17690,1,1,1,'Warmaster Laggrond - option 5441/0 - not has item 17690'),
(5441,0,0,8,7161,0,0,0,'Warmaster Laggrond - option 5441/0 - quest rewarded 7161'),
(5441,1,0,8,7164,0,0,1,'Warmaster Laggrond - option 5441/1 - not quest rewarded 7164'),
(5441,1,0,2,17905,1,1,1,'Warmaster Laggrond - option 5441/1 - not has item 17905'),
(5441,1,0,8,7163,0,0,0,'Warmaster Laggrond - option 5441/1 - quest rewarded 7163'),
(5441,2,0,8,7165,0,0,1,'Warmaster Laggrond - option 5441/2 - not quest rewarded 7165'),
(5441,2,0,2,17906,1,1,1,'Warmaster Laggrond - option 5441/2 - not has item 17906'),
(5441,2,0,8,7164,0,0,0,'Warmaster Laggrond - option 5441/2 - quest rewarded 7164'),
(5441,3,0,8,7166,0,0,1,'Warmaster Laggrond - option 5441/3 - not quest rewarded 7166'),
(5441,3,0,2,17907,1,1,1,'Warmaster Laggrond - option 5441/3 - not has item 17907'),
(5441,3,0,8,7165,0,0,0,'Warmaster Laggrond - option 5441/3 - quest rewarded 7165'),
(5441,4,0,8,7167,0,0,1,'Warmaster Laggrond - option 5441/4 - not quest rewarded 7167'),
(5441,4,0,2,17908,1,1,1,'Warmaster Laggrond - option 5441/4 - not has item 17908'),
(5441,4,0,8,7166,0,0,0,'Warmaster Laggrond - option 5441/4 - quest rewarded 7166'),
(5441,5,0,2,17909,1,1,1,'Warmaster Laggrond - option 5441/5 - not has item 17909'),
(5441,5,0,8,7167,0,0,0,'Warmaster Laggrond - option 5441/5 - quest rewarded 7167'),
(5442,0,0,8,7168,0,0,1,'Lieutenant Haggerdin - option 5442/0 - not quest rewarded 7168'),
(5442,0,0,2,17691,1,1,1,'Lieutenant Haggerdin - option 5442/0 - not has item 17691'),
(5442,0,0,8,7162,0,0,0,'Lieutenant Haggerdin - option 5442/0 - quest rewarded 7162'),
(5442,1,0,8,7169,0,0,1,'Lieutenant Haggerdin - option 5442/1 - not quest rewarded 7169'),
(5442,1,0,2,17900,1,1,1,'Lieutenant Haggerdin - option 5442/1 - not has item 17900'),
(5442,1,0,8,7168,0,0,0,'Lieutenant Haggerdin - option 5442/1 - quest rewarded 7168'),
(5442,2,0,8,7170,0,0,1,'Lieutenant Haggerdin - option 5442/2 - not quest rewarded 7170'),
(5442,2,0,2,17901,1,1,1,'Lieutenant Haggerdin - option 5442/2 - not has item 17901'),
(5442,2,0,8,7169,0,0,0,'Lieutenant Haggerdin - option 5442/2 - quest rewarded 7169'),
(5442,3,0,8,7171,0,0,1,'Lieutenant Haggerdin - option 5442/3 - not quest rewarded 7171'),
(5442,3,0,2,17902,1,1,1,'Lieutenant Haggerdin - option 5442/3 - not has item 17902'),
(5442,3,0,8,7170,0,0,0,'Lieutenant Haggerdin - option 5442/3 - quest rewarded 7170'),
(5442,4,0,8,7172,0,0,1,'Lieutenant Haggerdin - option 5442/4 - not quest rewarded 7172'),
(5442,4,0,2,17903,1,1,1,'Lieutenant Haggerdin - option 5442/4 - not has item 17903'),
(5442,4,0,8,7171,0,0,0,'Lieutenant Haggerdin - option 5442/4 - quest rewarded 7171'),
(5442,5,0,2,17904,1,1,1,'Lieutenant Haggerdin - option 5442/5 - not has item 17904'),
(5442,5,0,8,7172,0,0,0,'Lieutenant Haggerdin - option 5442/5 - quest rewarded 7172'),
(5675,1,0,8,7786,0,0,0,'Highlord Demitrian - option 5675/1 - quest rewarded 7786'),
(5675,1,0,29,14435,200,1,1,'Highlord Demitrian - option 5675/1 - not creature near 14435'),
(5675,1,0,29,14435,200,0,1,'Highlord Demitrian - option 5675/1 - not creature near 14435'),
(5675,1,0,14,7787,0,0,0,'Highlord Demitrian - option 5675/1 - quest not taken or done 7787'),
(5675,1,0,2,19018,1,1,1,'Highlord Demitrian - option 5675/1 - not has item 19018'),
(6321,0,0,8,8042,0,0,1,'Jin''rokh the Breaker - option 6321/0 - not quest rewarded 8042'),
(6321,0,0,2,19574,1,1,1,'Jin''rokh the Breaker - option 6321/0 - not has item 19574'),
(6321,0,0,8,8041,0,0,0,'Jin''rokh the Breaker - option 6321/0 - quest rewarded 8041'),
(6321,1,0,8,8043,0,0,1,'Jin''rokh the Breaker - option 6321/1 - not quest rewarded 8043'),
(6321,1,0,2,19575,1,1,1,'Jin''rokh the Breaker - option 6321/1 - not has item 19575'),
(6321,1,0,8,8042,0,0,0,'Jin''rokh the Breaker - option 6321/1 - quest rewarded 8042'),
(6321,2,0,8,8044,0,0,1,'Jin''rokh the Breaker - option 6321/2 - not quest rewarded 8044'),
(6321,2,0,2,19576,1,1,1,'Jin''rokh the Breaker - option 6321/2 - not has item 19576'),
(6321,2,0,8,8043,0,0,0,'Jin''rokh the Breaker - option 6321/2 - quest rewarded 8043'),
(6321,3,0,2,19577,1,1,1,'Jin''rokh the Breaker - option 6321/3 - not has item 19577'),
(6321,3,0,8,8044,0,0,0,'Jin''rokh the Breaker - option 6321/3 - quest rewarded 8044'),
(6321,4,0,8,8046,0,0,1,'Jin''rokh the Breaker - option 6321/4 - not quest rewarded 8046'),
(6321,4,0,2,19579,1,1,1,'Jin''rokh the Breaker - option 6321/4 - not has item 19579'),
(6321,4,0,8,8045,0,0,0,'Jin''rokh the Breaker - option 6321/4 - quest rewarded 8045'),
(6321,5,0,8,8047,0,0,1,'Jin''rokh the Breaker - option 6321/5 - not quest rewarded 8047'),
(6321,5,0,2,19585,1,1,1,'Jin''rokh the Breaker - option 6321/5 - not has item 19585'),
(6321,5,0,8,8046,0,0,0,'Jin''rokh the Breaker - option 6321/5 - quest rewarded 8046'),
(6321,6,0,8,8048,0,0,1,'Jin''rokh the Breaker - option 6321/6 - not quest rewarded 8048'),
(6321,6,0,2,19586,1,1,1,'Jin''rokh the Breaker - option 6321/6 - not has item 19586'),
(6321,6,0,8,8047,0,0,0,'Jin''rokh the Breaker - option 6321/6 - quest rewarded 8047'),
(6321,7,0,2,19588,1,1,1,'Jin''rokh the Breaker - option 6321/7 - not has item 19588'),
(6321,7,0,8,8048,0,0,0,'Jin''rokh the Breaker - option 6321/7 - quest rewarded 8048'),
(6321,8,0,2,19822,1,1,1,'Jin''rokh the Breaker - option 6321/8 - not has item 19822'),
(6321,8,0,8,8079,0,0,0,'Jin''rokh the Breaker - option 6321/8 - quest rewarded 8079'),
(6321,9,0,2,19823,1,1,1,'Jin''rokh the Breaker - option 6321/9 - not has item 19823'),
(6321,9,0,8,8078,0,0,0,'Jin''rokh the Breaker - option 6321/9 - quest rewarded 8078'),
(6321,10,0,2,19824,1,1,1,'Jin''rokh the Breaker - option 6321/10 - not has item 19824'),
(6321,10,0,8,8058,0,0,0,'Jin''rokh the Breaker - option 6321/10 - quest rewarded 8058'),
(6321,11,0,2,19825,1,1,1,'Jin''rokh the Breaker - option 6321/11 - not has item 19825'),
(6321,11,0,8,8055,0,0,0,'Jin''rokh the Breaker - option 6321/11 - quest rewarded 8055'),
(6321,12,0,2,19826,1,1,1,'Jin''rokh the Breaker - option 6321/12 - not has item 19826'),
(6321,12,0,8,8054,0,0,0,'Jin''rokh the Breaker - option 6321/12 - quest rewarded 8054'),
(6321,13,0,2,19827,1,1,1,'Jin''rokh the Breaker - option 6321/13 - not has item 19827'),
(6321,13,0,8,8053,0,0,0,'Jin''rokh the Breaker - option 6321/13 - quest rewarded 8053'),
(6322,0,0,8,8102,0,0,1,'Al''tabim the All-Seeing - option 6322/0 - not quest rewarded 8102'),
(6322,0,0,2,19598,1,1,1,'Al''tabim the All-Seeing - option 6322/0 - not has item 19598'),
(6322,0,0,8,8101,0,0,0,'Al''tabim the All-Seeing - option 6322/0 - quest rewarded 8101'),
(6322,1,0,8,8103,0,0,1,'Al''tabim the All-Seeing - option 6322/1 - not quest rewarded 8103'),
(6322,1,0,2,19599,1,1,1,'Al''tabim the All-Seeing - option 6322/1 - not has item 19599'),
(6322,1,0,8,8102,0,0,0,'Al''tabim the All-Seeing - option 6322/1 - quest rewarded 8102'),
(6322,2,0,8,8104,0,0,1,'Al''tabim the All-Seeing - option 6322/2 - not quest rewarded 8104'),
(6322,2,0,2,19600,1,1,1,'Al''tabim the All-Seeing - option 6322/2 - not has item 19600'),
(6322,2,0,8,8103,0,0,0,'Al''tabim the All-Seeing - option 6322/2 - quest rewarded 8103'),
(6322,3,0,2,19601,1,1,1,'Al''tabim the All-Seeing - option 6322/3 - not has item 19601'),
(6322,3,0,8,8104,0,0,0,'Al''tabim the All-Seeing - option 6322/3 - quest rewarded 8104'),
(6322,4,0,8,8107,0,0,1,'Al''tabim the All-Seeing - option 6322/4 - not quest rewarded 8107'),
(6322,4,0,2,19602,1,1,1,'Al''tabim the All-Seeing - option 6322/4 - not has item 19602'),
(6322,4,0,8,8106,0,0,0,'Al''tabim the All-Seeing - option 6322/4 - quest rewarded 8106'),
(6322,5,0,8,8108,0,0,1,'Al''tabim the All-Seeing - option 6322/5 - not quest rewarded 8108'),
(6322,5,0,2,19603,1,1,1,'Al''tabim the All-Seeing - option 6322/5 - not has item 19603'),
(6322,5,0,8,8107,0,0,0,'Al''tabim the All-Seeing - option 6322/5 - quest rewarded 8107'),
(6322,6,0,8,8109,0,0,1,'Al''tabim the All-Seeing - option 6322/6 - not quest rewarded 8109'),
(6322,6,0,2,19604,1,1,1,'Al''tabim the All-Seeing - option 6322/6 - not has item 19604'),
(6322,6,0,8,8108,0,0,0,'Al''tabim the All-Seeing - option 6322/6 - quest rewarded 8108'),
(6322,7,0,2,19605,1,1,1,'Al''tabim the All-Seeing - option 6322/7 - not has item 19605'),
(6322,7,0,8,8109,0,0,0,'Al''tabim the All-Seeing - option 6322/7 - quest rewarded 8109'),
(6322,8,0,8,8050,0,0,1,'Al''tabim the All-Seeing - option 6322/8 - not quest rewarded 8050'),
(6322,8,0,2,19591,1,1,1,'Al''tabim the All-Seeing - option 6322/8 - not has item 19591'),
(6322,8,0,8,8049,0,0,0,'Al''tabim the All-Seeing - option 6322/8 - quest rewarded 8049'),
(6322,9,0,8,8051,0,0,1,'Al''tabim the All-Seeing - option 6322/9 - not quest rewarded 8051'),
(6322,9,0,2,19592,1,1,1,'Al''tabim the All-Seeing - option 6322/9 - not has item 19592'),
(6322,9,0,8,8050,0,0,0,'Al''tabim the All-Seeing - option 6322/9 - quest rewarded 8050'),
(6322,10,0,8,8052,0,0,1,'Al''tabim the All-Seeing - option 6322/10 - not quest rewarded 8052'),
(6322,10,0,2,19593,1,1,1,'Al''tabim the All-Seeing - option 6322/10 - not has item 19593'),
(6322,10,0,8,8051,0,0,0,'Al''tabim the All-Seeing - option 6322/10 - quest rewarded 8051'),
(6322,11,0,2,19594,1,1,1,'Al''tabim the All-Seeing - option 6322/11 - not has item 19594'),
(6322,11,0,8,8052,0,0,0,'Al''tabim the All-Seeing - option 6322/11 - quest rewarded 8052'),
(6322,12,0,2,19841,1,1,1,'Al''tabim the All-Seeing - option 6322/12 - not has item 19841'),
(6322,12,0,8,8071,0,0,0,'Al''tabim the All-Seeing - option 6322/12 - quest rewarded 8071'),
(6322,13,0,2,19842,1,1,1,'Al''tabim the All-Seeing - option 6322/13 - not has item 19842'),
(6322,13,0,8,8070,0,0,0,'Al''tabim the All-Seeing - option 6322/13 - quest rewarded 8070'),
(6322,14,0,2,19843,1,1,1,'Al''tabim the All-Seeing - option 6322/14 - not has item 19843'),
(6322,14,0,8,8061,0,0,0,'Al''tabim the All-Seeing - option 6322/14 - quest rewarded 8061'),
(6322,15,0,2,20034,1,1,1,'Al''tabim the All-Seeing - option 6322/15 - not has item 20034'),
(6322,15,0,8,8069,0,0,0,'Al''tabim the All-Seeing - option 6322/15 - quest rewarded 8069'),
(6322,16,0,2,19845,1,1,1,'Al''tabim the All-Seeing - option 6322/16 - not has item 19845'),
(6322,16,0,8,8068,0,0,0,'Al''tabim the All-Seeing - option 6322/16 - quest rewarded 8068'),
(6322,17,0,2,19846,1,1,1,'Al''tabim the All-Seeing - option 6322/17 - not has item 19846'),
(6322,17,0,8,8060,0,0,0,'Al''tabim the All-Seeing - option 6322/17 - quest rewarded 8060'),
(6322,18,0,2,20033,1,1,1,'Al''tabim the All-Seeing - option 6322/18 - not has item 20033'),
(6322,18,0,8,8077,0,0,0,'Al''tabim the All-Seeing - option 6322/18 - quest rewarded 8077'),
(6322,19,0,2,19849,1,1,1,'Al''tabim the All-Seeing - option 6322/19 - not has item 19849'),
(6322,19,0,8,8076,0,0,0,'Al''tabim the All-Seeing - option 6322/19 - quest rewarded 8076'),
(6322,20,0,2,19848,1,1,1,'Al''tabim the All-Seeing - option 6322/20 - not has item 19848'),
(6322,20,0,8,8059,0,0,0,'Al''tabim the All-Seeing - option 6322/20 - quest rewarded 8059'),
(6341,0,0,8,8111,0,0,1,'Maywiki of Zuldazar - option 6341/0 - not quest rewarded 8111'),
(6341,0,0,2,19610,1,1,1,'Maywiki of Zuldazar - option 6341/0 - not has item 19610'),
(6341,0,0,8,8110,0,0,0,'Maywiki of Zuldazar - option 6341/0 - quest rewarded 8110'),
(6341,1,0,8,8112,0,0,1,'Maywiki of Zuldazar - option 6341/1 - not quest rewarded 8112'),
(6341,1,0,2,19611,1,1,1,'Maywiki of Zuldazar - option 6341/1 - not has item 19611'),
(6341,1,0,8,8111,0,0,0,'Maywiki of Zuldazar - option 6341/1 - quest rewarded 8111'),
(6341,2,0,8,8113,0,0,1,'Maywiki of Zuldazar - option 6341/2 - not quest rewarded 8113'),
(6341,2,0,2,19612,1,1,1,'Maywiki of Zuldazar - option 6341/2 - not has item 19612'),
(6341,2,0,8,8112,0,0,0,'Maywiki of Zuldazar - option 6341/2 - quest rewarded 8112'),
(6341,3,0,2,19613,1,1,1,'Maywiki of Zuldazar - option 6341/3 - not has item 19613'),
(6341,3,0,8,8113,0,0,0,'Maywiki of Zuldazar - option 6341/3 - quest rewarded 8113'),
(6341,4,0,8,8117,0,0,1,'Maywiki of Zuldazar - option 6341/4 - not quest rewarded 8117'),
(6341,4,0,2,19606,1,1,1,'Maywiki of Zuldazar - option 6341/4 - not has item 19606'),
(6341,4,0,8,8116,0,0,0,'Maywiki of Zuldazar - option 6341/4 - quest rewarded 8116'),
(6341,5,0,8,8118,0,0,1,'Maywiki of Zuldazar - option 6341/5 - not quest rewarded 8118'),
(6341,5,0,2,19607,1,1,1,'Maywiki of Zuldazar - option 6341/5 - not has item 19607'),
(6341,5,0,8,8117,0,0,0,'Maywiki of Zuldazar - option 6341/5 - quest rewarded 8117'),
(6341,6,0,8,8119,0,0,1,'Maywiki of Zuldazar - option 6341/6 - not quest rewarded 8119'),
(6341,6,0,2,19608,1,1,1,'Maywiki of Zuldazar - option 6341/6 - not has item 19608'),
(6341,6,0,8,8118,0,0,0,'Maywiki of Zuldazar - option 6341/6 - quest rewarded 8118'),
(6341,7,0,2,19609,1,1,1,'Maywiki of Zuldazar - option 6341/7 - not has item 19609'),
(6341,7,0,8,8119,0,0,0,'Maywiki of Zuldazar - option 6341/7 - quest rewarded 8119'),
(6341,8,0,2,19828,1,1,1,'Maywiki of Zuldazar - option 6341/8 - not has item 19828'),
(6341,8,0,8,8075,0,0,0,'Maywiki of Zuldazar - option 6341/8 - quest rewarded 8075'),
(6341,9,0,2,19829,1,1,1,'Maywiki of Zuldazar - option 6341/9 - not has item 19829'),
(6341,9,0,8,8074,0,0,0,'Maywiki of Zuldazar - option 6341/9 - quest rewarded 8074'),
(6341,10,0,2,19830,1,1,1,'Maywiki of Zuldazar - option 6341/10 - not has item 19830'),
(6341,10,0,8,8056,0,0,0,'Maywiki of Zuldazar - option 6341/10 - quest rewarded 8056'),
(6341,11,0,2,19838,1,1,1,'Maywiki of Zuldazar - option 6341/11 - not has item 19838'),
(6341,11,0,8,8065,0,0,0,'Maywiki of Zuldazar - option 6341/11 - quest rewarded 8065'),
(6341,12,0,2,19839,1,1,1,'Maywiki of Zuldazar - option 6341/12 - not has item 19839'),
(6341,12,0,8,8064,0,0,0,'Maywiki of Zuldazar - option 6341/12 - quest rewarded 8064'),
(6341,13,0,2,19840,1,1,1,'Maywiki of Zuldazar - option 6341/13 - not has item 19840'),
(6341,13,0,8,8057,0,0,0,'Maywiki of Zuldazar - option 6341/13 - quest rewarded 8057'),
(6363,0,0,8,8146,0,0,1,'Falthir the Sightless - option 6363/0 - not quest rewarded 8146'),
(6363,0,0,2,19618,1,1,1,'Falthir the Sightless - option 6363/0 - not has item 19618'),
(6363,0,0,8,8145,0,0,0,'Falthir the Sightless - option 6363/0 - quest rewarded 8145'),
(6363,1,0,8,8147,0,0,1,'Falthir the Sightless - option 6363/1 - not quest rewarded 8147'),
(6363,1,0,2,19619,1,1,1,'Falthir the Sightless - option 6363/1 - not has item 19619'),
(6363,1,0,8,8146,0,0,0,'Falthir the Sightless - option 6363/1 - quest rewarded 8146'),
(6363,2,0,8,8148,0,0,1,'Falthir the Sightless - option 6363/2 - not quest rewarded 8148'),
(6363,2,0,2,19620,1,1,1,'Falthir the Sightless - option 6363/2 - not has item 19620'),
(6363,2,0,8,8147,0,0,0,'Falthir the Sightless - option 6363/2 - quest rewarded 8147'),
(6363,3,0,2,19621,1,1,1,'Falthir the Sightless - option 6363/3 - not has item 19621'),
(6363,3,0,8,8148,0,0,0,'Falthir the Sightless - option 6363/3 - quest rewarded 8148'),
(6363,4,0,8,8142,0,0,1,'Falthir the Sightless - option 6363/4 - not quest rewarded 8142'),
(6363,4,0,2,19614,1,1,1,'Falthir the Sightless - option 6363/4 - not has item 19614'),
(6363,4,0,8,8141,0,0,0,'Falthir the Sightless - option 6363/4 - quest rewarded 8141'),
(6363,5,0,8,8143,0,0,1,'Falthir the Sightless - option 6363/5 - not quest rewarded 8143'),
(6363,5,0,2,19615,1,1,1,'Falthir the Sightless - option 6363/5 - not has item 19615'),
(6363,5,0,8,8142,0,0,0,'Falthir the Sightless - option 6363/5 - quest rewarded 8142'),
(6363,6,0,8,8144,0,0,1,'Falthir the Sightless - option 6363/6 - not quest rewarded 8144'),
(6363,6,0,2,19616,1,1,1,'Falthir the Sightless - option 6363/6 - not has item 19616'),
(6363,6,0,8,8143,0,0,0,'Falthir the Sightless - option 6363/6 - quest rewarded 8143'),
(6363,7,0,2,19617,1,1,1,'Falthir the Sightless - option 6363/7 - not has item 19617'),
(6363,7,0,8,8144,0,0,0,'Falthir the Sightless - option 6363/7 - quest rewarded 8144'),
(6363,8,0,2,19834,1,1,1,'Falthir the Sightless - option 6363/8 - not has item 19834'),
(6363,8,0,8,8073,0,0,0,'Falthir the Sightless - option 6363/8 - quest rewarded 8073'),
(6363,9,0,2,19835,1,1,1,'Falthir the Sightless - option 6363/9 - not has item 19835'),
(6363,9,0,8,8072,0,0,0,'Falthir the Sightless - option 6363/9 - quest rewarded 8072'),
(6363,10,0,2,19836,1,1,1,'Falthir the Sightless - option 6363/10 - not has item 19836'),
(6363,10,0,8,8063,0,0,0,'Falthir the Sightless - option 6363/10 - quest rewarded 8063'),
(6363,11,0,2,19831,1,1,1,'Falthir the Sightless - option 6363/11 - not has item 19831'),
(6363,11,0,8,8067,0,0,0,'Falthir the Sightless - option 6363/11 - quest rewarded 8067'),
(6363,12,0,2,19832,1,1,1,'Falthir the Sightless - option 6363/12 - not has item 19832'),
(6363,12,0,8,8066,0,0,0,'Falthir the Sightless - option 6363/12 - quest rewarded 8066'),
(6363,13,0,2,19833,1,1,1,'Falthir the Sightless - option 6363/13 - not has item 19833'),
(6363,13,0,8,8062,0,0,0,'Falthir the Sightless - option 6363/13 - quest rewarded 8062'),
(6539,0,0,8,8753,0,0,1,'Anachronos - option 6539/0 - not quest rewarded 8753'),
(6539,0,0,2,21201,1,1,1,'Anachronos - option 6539/0 - not has item 21201'),
(6539,0,0,8,8752,0,0,0,'Anachronos - option 6539/0 - quest rewarded 8752'),
(6539,1,0,8,8754,0,0,1,'Anachronos - option 6539/1 - not quest rewarded 8754'),
(6539,1,0,2,21202,1,1,1,'Anachronos - option 6539/1 - not has item 21202'),
(6539,1,0,8,8753,0,0,0,'Anachronos - option 6539/1 - quest rewarded 8753'),
(6539,2,0,8,8755,0,0,1,'Anachronos - option 6539/2 - not quest rewarded 8755'),
(6539,2,0,2,21203,1,1,1,'Anachronos - option 6539/2 - not has item 21203'),
(6539,2,0,8,8754,0,0,0,'Anachronos - option 6539/2 - quest rewarded 8754'),
(6539,3,0,8,8756,0,0,1,'Anachronos - option 6539/3 - not quest rewarded 8756'),
(6539,3,0,2,21204,1,1,1,'Anachronos - option 6539/3 - not has item 21204'),
(6539,3,0,8,8755,0,0,0,'Anachronos - option 6539/3 - quest rewarded 8755'),
(6539,4,0,8,8756,0,0,0,'Anachronos - option 6539/4 - quest rewarded 8756'),
(6539,4,0,2,21210,1,1,1,'Anachronos - option 6539/4 - not has item 21210'),
(6539,4,0,2,21205,1,1,1,'Anachronos - option 6539/4 - not has item 21205'),
(6539,4,0,2,21200,1,1,1,'Anachronos - option 6539/4 - not has item 21200'),
(6539,5,0,8,8758,0,0,1,'Anachronos - option 6539/5 - not quest rewarded 8758'),
(6539,5,0,2,21206,1,1,1,'Anachronos - option 6539/5 - not has item 21206'),
(6539,5,0,8,8757,0,0,0,'Anachronos - option 6539/5 - quest rewarded 8757'),
(6539,6,0,8,8759,0,0,1,'Anachronos - option 6539/6 - not quest rewarded 8759'),
(6539,6,0,2,21207,1,1,1,'Anachronos - option 6539/6 - not has item 21207'),
(6539,6,0,8,8758,0,0,0,'Anachronos - option 6539/6 - quest rewarded 8758'),
(6539,7,0,8,8760,0,0,1,'Anachronos - option 6539/7 - not quest rewarded 8760'),
(6539,7,0,2,21208,1,1,1,'Anachronos - option 6539/7 - not has item 21208'),
(6539,7,0,8,8759,0,0,0,'Anachronos - option 6539/7 - quest rewarded 8759'),
(6539,8,0,8,8761,0,0,1,'Anachronos - option 6539/8 - not quest rewarded 8761'),
(6539,8,0,2,21209,1,1,1,'Anachronos - option 6539/8 - not has item 21209'),
(6539,8,0,8,8760,0,0,0,'Anachronos - option 6539/8 - quest rewarded 8760'),
(6539,9,0,8,8761,0,0,0,'Anachronos - option 6539/9 - quest rewarded 8761'),
(6539,9,0,2,21210,1,1,1,'Anachronos - option 6539/9 - not has item 21210'),
(6539,9,0,2,21205,1,1,1,'Anachronos - option 6539/9 - not has item 21205'),
(6539,9,0,2,21200,1,1,1,'Anachronos - option 6539/9 - not has item 21200'),
(6539,10,0,8,8748,0,0,1,'Anachronos - option 6539/10 - not quest rewarded 8748'),
(6539,10,0,2,21196,1,1,1,'Anachronos - option 6539/10 - not has item 21196'),
(6539,10,0,8,8747,0,0,0,'Anachronos - option 6539/10 - quest rewarded 8747'),
(6539,11,0,8,8749,0,0,1,'Anachronos - option 6539/11 - not quest rewarded 8749'),
(6539,11,0,2,21197,1,1,1,'Anachronos - option 6539/11 - not has item 21197'),
(6539,11,0,8,8748,0,0,0,'Anachronos - option 6539/11 - quest rewarded 8748'),
(6539,12,0,8,8750,0,0,1,'Anachronos - option 6539/12 - not quest rewarded 8750'),
(6539,12,0,2,21198,1,1,1,'Anachronos - option 6539/12 - not has item 21198'),
(6539,12,0,8,8749,0,0,0,'Anachronos - option 6539/12 - quest rewarded 8749'),
(6539,13,0,8,8751,0,0,1,'Anachronos - option 6539/13 - not quest rewarded 8751'),
(6539,13,0,2,21199,1,1,1,'Anachronos - option 6539/13 - not has item 21199'),
(6539,13,0,8,8750,0,0,0,'Anachronos - option 6539/13 - quest rewarded 8750'),
(6539,14,0,8,8751,0,0,0,'Anachronos - option 6539/14 - quest rewarded 8751'),
(6539,14,0,2,21210,1,1,1,'Anachronos - option 6539/14 - not has item 21210'),
(6539,14,0,2,21205,1,1,1,'Anachronos - option 6539/14 - not has item 21205'),
(6539,14,0,2,21200,1,1,1,'Anachronos - option 6539/14 - not has item 21200'),
(6928,0,0,2,21408,1,1,1,'Windcaller Yessendra - option 6928/0 - not has item 21408'),
(6928,0,0,8,8700,0,0,0,'Windcaller Yessendra - option 6928/0 - quest rewarded 8700'),
(6928,1,0,2,21402,1,1,1,'Windcaller Yessendra - option 6928/1 - not has item 21402'),
(6928,1,0,8,8704,0,0,0,'Windcaller Yessendra - option 6928/1 - quest rewarded 8704'),
(6928,2,0,2,21414,1,1,1,'Windcaller Yessendra - option 6928/2 - not has item 21414'),
(6928,2,0,8,8699,0,0,0,'Windcaller Yessendra - option 6928/2 - quest rewarded 8699'),
(6928,3,0,2,21396,1,1,1,'Windcaller Yessendra - option 6928/3 - not has item 21396'),
(6928,3,0,8,8703,0,0,0,'Windcaller Yessendra - option 6928/3 - quest rewarded 8703'),
(6928,4,0,2,21411,1,1,1,'Windcaller Yessendra - option 6928/4 - not has item 21411'),
(6928,4,0,8,8697,0,0,0,'Windcaller Yessendra - option 6928/4 - quest rewarded 8697'),
(6928,5,0,2,21405,1,1,1,'Windcaller Yessendra - option 6928/5 - not has item 21405'),
(6928,5,0,8,8701,0,0,0,'Windcaller Yessendra - option 6928/5 - quest rewarded 8701'),
(6928,6,0,2,21399,1,1,1,'Windcaller Yessendra - option 6928/6 - not has item 21399'),
(6928,6,0,8,8698,0,0,0,'Windcaller Yessendra - option 6928/6 - quest rewarded 8698'),
(6928,7,0,2,21417,1,1,1,'Windcaller Yessendra - option 6928/7 - not has item 21417'),
(6928,7,0,8,8702,0,0,0,'Windcaller Yessendra - option 6928/7 - quest rewarded 8702'),
(6928,8,0,2,21393,1,1,1,'Windcaller Yessendra - option 6928/8 - not has item 21393'),
(6928,8,0,8,8556,0,0,0,'Windcaller Yessendra - option 6928/8 - quest rewarded 8556'),
(6925,0,0,2,21407,1,1,1,'Warden Haro - option 6925/0 - not has item 21407'),
(6925,0,0,8,8708,0,0,0,'Warden Haro - option 6925/0 - quest rewarded 8708'),
(6925,1,0,2,21401,1,1,1,'Warden Haro - option 6925/1 - not has item 21401'),
(6925,1,0,8,8712,0,0,0,'Warden Haro - option 6925/1 - quest rewarded 8712'),
(6925,2,0,2,21413,1,1,1,'Warden Haro - option 6925/2 - not has item 21413'),
(6925,2,0,8,8707,0,0,0,'Warden Haro - option 6925/2 - quest rewarded 8707'),
(6925,3,0,2,21395,1,1,1,'Warden Haro - option 6925/3 - not has item 21395'),
(6925,3,0,8,8711,0,0,0,'Warden Haro - option 6925/3 - quest rewarded 8711'),
(6925,4,0,2,21410,1,1,1,'Warden Haro - option 6925/4 - not has item 21410'),
(6925,4,0,8,8705,0,0,0,'Warden Haro - option 6925/4 - quest rewarded 8705'),
(6925,5,0,2,21404,1,1,1,'Warden Haro - option 6925/5 - not has item 21404'),
(6925,5,0,8,8709,0,0,0,'Warden Haro - option 6925/5 - quest rewarded 8709'),
(6925,6,0,2,21398,1,1,1,'Warden Haro - option 6925/6 - not has item 21398'),
(6925,6,0,8,8706,0,0,0,'Warden Haro - option 6925/6 - quest rewarded 8706'),
(6925,7,0,2,21416,1,1,1,'Warden Haro - option 6925/7 - not has item 21416'),
(6925,7,0,8,8710,0,0,0,'Warden Haro - option 6925/7 - quest rewarded 8710'),
(6925,8,0,2,21392,1,1,1,'Warden Haro - option 6925/8 - not has item 21392'),
(6925,8,0,8,8558,0,0,0,'Warden Haro - option 6925/8 - quest rewarded 8558'),
(6927,0,0,2,21409,1,1,1,'Keyl Swiftclaw - option 6927/0 - not has item 21409'),
(6927,0,0,8,8692,0,0,0,'Keyl Swiftclaw - option 6927/0 - quest rewarded 8692'),
(6927,1,0,2,21403,1,1,1,'Keyl Swiftclaw - option 6927/1 - not has item 21403'),
(6927,1,0,8,8696,0,0,0,'Keyl Swiftclaw - option 6927/1 - quest rewarded 8696'),
(6927,2,0,2,21415,1,1,1,'Keyl Swiftclaw - option 6927/2 - not has item 21415'),
(6927,2,0,8,8691,0,0,0,'Keyl Swiftclaw - option 6927/2 - quest rewarded 8691'),
(6927,3,0,2,21397,1,1,1,'Keyl Swiftclaw - option 6927/3 - not has item 21397'),
(6927,3,0,8,8695,0,0,0,'Keyl Swiftclaw - option 6927/3 - quest rewarded 8695'),
(6927,4,0,2,21412,1,1,1,'Keyl Swiftclaw - option 6927/4 - not has item 21412'),
(6927,4,0,8,8689,0,0,0,'Keyl Swiftclaw - option 6927/4 - quest rewarded 8689'),
(6927,5,0,2,21406,1,1,1,'Keyl Swiftclaw - option 6927/5 - not has item 21406'),
(6927,5,0,8,8693,0,0,0,'Keyl Swiftclaw - option 6927/5 - quest rewarded 8693'),
(6927,6,0,2,21400,1,1,1,'Keyl Swiftclaw - option 6927/6 - not has item 21400'),
(6927,6,0,8,8690,0,0,0,'Keyl Swiftclaw - option 6927/6 - quest rewarded 8690'),
(6927,7,0,2,21418,1,1,1,'Keyl Swiftclaw - option 6927/7 - not has item 21418'),
(6927,7,0,8,8694,0,0,0,'Keyl Swiftclaw - option 6927/7 - quest rewarded 8694'),
(6927,8,0,2,21394,1,1,1,'Keyl Swiftclaw - option 6927/8 - not has item 21394'),
(6927,8,0,8,8557,0,0,0,'Keyl Swiftclaw - option 6927/8 - quest rewarded 8557'),
(126,0,0,9,1886,0,0,0,'Astor Hadren - option 126/0 - quest taken 1886'),
(126,0,0,2,7231,1,1,1,'Astor Hadren - option 126/0 - not has item 7231');
-- options that already have conditions of their own keep them
DROP TEMPORARY TABLE IF EXISTS `forever_gossip_cond_skip`;
CREATE TEMPORARY TABLE `forever_gossip_cond_skip` SELECT DISTINCT c.`SourceGroup`,c.`SourceEntry` FROM `conditions` c
WHERE c.`SourceTypeOrReferenceId` = 15 AND EXISTS (SELECT 1 FROM `forever_gossip_cond` f WHERE f.`SourceGroup` = c.`SourceGroup` AND f.`SourceEntry` = c.`SourceEntry`);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ConditionStringValue1`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`)
SELECT 15,f.`SourceGroup`,f.`SourceEntry`,0,f.`ElseGroup`,f.`ConditionTypeOrReference`,0,f.`ConditionValue1`,f.`ConditionValue2`,f.`ConditionValue3`,'',f.`NegativeCondition`,0,0,'',f.`Comment` FROM `forever_gossip_cond` f
WHERE NOT EXISTS (SELECT 1 FROM `forever_gossip_cond_skip` k WHERE k.`SourceGroup` = f.`SourceGroup` AND k.`SourceEntry` = f.`SourceEntry`);
DROP TEMPORARY TABLE `forever_gossip_cond_skip`;
DROP TEMPORARY TABLE `forever_gossip_cond`;

-- 3. The choices: the player casts the item spell on themselves (triggered); each row changes only while it is the imported one
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 12885, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Deathly Usher - On gossip 1541/0 - Invoker casts 12885' WHERE `entryorguid` = 8816 AND `source_type` = 0 AND `id` = 1 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000381;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 15211, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'J.D. Collie - On gossip 2184/3 - Invoker casts 15211' WHERE `entryorguid` = 9117 AND `source_type` = 0 AND `id` = 3 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000389;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param2` = `action_param2` | 2, `comment` = 'VMaNGOS gossip 2208/0 - invoker casts 15120' WHERE `entryorguid` = 950000394 AND `source_type` = 9 AND `id` = 0 AND `action_type` = 11 AND `action_param1` = 15120 AND `target_type` = 7;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param2` = `action_param2` | 2, `comment` = 'VMaNGOS gossip 2207/0 - invoker casts 15120' WHERE `entryorguid` = 950000395 AND `source_type` = 9 AND `id` = 0 AND `action_type` = 11 AND `action_param1` = 15120 AND `target_type` = 7;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 16351, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Witch Doctor Mau''ari - On gossip 2703/2 - Invoker casts 16351' WHERE `entryorguid` = 10307 AND `source_type` = 0 AND `id` = 2 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000403;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 22207, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Haleh - On gossip 5482/0 - Invoker casts 22207' WHERE `entryorguid` = 10929 AND `source_type` = 0 AND `id` = 1 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000409;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 17529, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Alchemist Arbington - On gossip 3228/0 - Invoker casts 17529' WHERE `entryorguid` = 11056 AND `source_type` = 0 AND `id` = 2 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000411;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 17529, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Apothecary Dithers - On gossip 3223/0 - Invoker casts 17529' WHERE `entryorguid` = 11057 AND `source_type` = 0 AND `id` = 2 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000412;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 20693, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Myranda the Hag - On gossip 3801/1 - Invoker casts 20693' WHERE `entryorguid` = 11872 AND `source_type` = 0 AND `id` = 3 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000431;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 21357, `action_param2` = 3, `action_param3` = 0, `target_type` = 7, `comment` = 'Duke Hydraxis - On gossip 5065/0 - Invoker casts 21357' WHERE `entryorguid` = 13278 AND `source_type` = 0 AND `id` = 1 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000436;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 28439, `action_param2` = 3, `action_param3` = 0, `target_type` = 7, `comment` = 'Duke Hydraxis - On gossip 5065/1 - Invoker casts 28439' WHERE `entryorguid` = 13278 AND `source_type` = 0 AND `id` = 3 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000437;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 21939, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Celebras the Redeemed - On gossip 5349/0 - Invoker casts 21939' WHERE `entryorguid` = 13716 AND `source_type` = 0 AND `id` = 1 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000449;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 22108, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Warmaster Laggrond - On gossip 5441/0 - Invoker casts 22108' WHERE `entryorguid` = 13840 AND `source_type` = 0 AND `id` = 2 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000440;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 22109, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Warmaster Laggrond - On gossip 5441/1 - Invoker casts 22109' WHERE `entryorguid` = 13840 AND `source_type` = 0 AND `id` = 4 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000441;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 22110, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Warmaster Laggrond - On gossip 5441/2 - Invoker casts 22110' WHERE `entryorguid` = 13840 AND `source_type` = 0 AND `id` = 6 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000442;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 22111, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Warmaster Laggrond - On gossip 5441/3 - Invoker casts 22111' WHERE `entryorguid` = 13840 AND `source_type` = 0 AND `id` = 8 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000443;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 22112, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Warmaster Laggrond - On gossip 5441/4 - Invoker casts 22112' WHERE `entryorguid` = 13840 AND `source_type` = 0 AND `id` = 10 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000444;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 22113, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Warmaster Laggrond - On gossip 5441/5 - Invoker casts 22113' WHERE `entryorguid` = 13840 AND `source_type` = 0 AND `id` = 12 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000445;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 22114, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Lieutenant Haggerdin - On gossip 5442/0 - Invoker casts 22114' WHERE `entryorguid` = 13841 AND `source_type` = 0 AND `id` = 3 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000446;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 22115, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Lieutenant Haggerdin - On gossip 5442/1 - Invoker casts 22115' WHERE `entryorguid` = 13841 AND `source_type` = 0 AND `id` = 5 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000447;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 22116, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Lieutenant Haggerdin - On gossip 5442/2 - Invoker casts 22116' WHERE `entryorguid` = 13841 AND `source_type` = 0 AND `id` = 7 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000448;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 22117, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Lieutenant Haggerdin - On gossip 5442/3 - Invoker casts 22117' WHERE `entryorguid` = 13841 AND `source_type` = 0 AND `id` = 9 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000449;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 22118, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Lieutenant Haggerdin - On gossip 5442/4 - Invoker casts 22118' WHERE `entryorguid` = 13841 AND `source_type` = 0 AND `id` = 11 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000450;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 22119, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Lieutenant Haggerdin - On gossip 5442/5 - Invoker casts 22119' WHERE `entryorguid` = 13841 AND `source_type` = 0 AND `id` = 13 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000451;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 23998, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Jin''rokh the Breaker - On gossip 6321/0 - Invoker casts 23998' WHERE `entryorguid` = 14902 AND `source_type` = 0 AND `id` = 1 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000458;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 23999, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Jin''rokh the Breaker - On gossip 6321/1 - Invoker casts 23999' WHERE `entryorguid` = 14902 AND `source_type` = 0 AND `id` = 3 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000459;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 24000, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Jin''rokh the Breaker - On gossip 6321/2 - Invoker casts 24000' WHERE `entryorguid` = 14902 AND `source_type` = 0 AND `id` = 5 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000460;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 24001, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Jin''rokh the Breaker - On gossip 6321/3 - Invoker casts 24001' WHERE `entryorguid` = 14902 AND `source_type` = 0 AND `id` = 7 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000461;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 24007, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Jin''rokh the Breaker - On gossip 6321/4 - Invoker casts 24007' WHERE `entryorguid` = 14902 AND `source_type` = 0 AND `id` = 9 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000462;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 24008, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Jin''rokh the Breaker - On gossip 6321/5 - Invoker casts 24008' WHERE `entryorguid` = 14902 AND `source_type` = 0 AND `id` = 11 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000463;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 24009, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Jin''rokh the Breaker - On gossip 6321/6 - Invoker casts 24009' WHERE `entryorguid` = 14902 AND `source_type` = 0 AND `id` = 13 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000464;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 24010, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Jin''rokh the Breaker - On gossip 6321/7 - Invoker casts 24010' WHERE `entryorguid` = 14902 AND `source_type` = 0 AND `id` = 15 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000465;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 28885, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Jin''rokh the Breaker - On gossip 6321/8 - Invoker casts 28885' WHERE `entryorguid` = 14902 AND `source_type` = 0 AND `id` = 17 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000466;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 28886, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Jin''rokh the Breaker - On gossip 6321/9 - Invoker casts 28886' WHERE `entryorguid` = 14902 AND `source_type` = 0 AND `id` = 19 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000467;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 28908, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Jin''rokh the Breaker - On gossip 6321/10 - Invoker casts 28908' WHERE `entryorguid` = 14902 AND `source_type` = 0 AND `id` = 21 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000468;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 28909, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Jin''rokh the Breaker - On gossip 6321/11 - Invoker casts 28909' WHERE `entryorguid` = 14902 AND `source_type` = 0 AND `id` = 23 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000469;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 28919, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Jin''rokh the Breaker - On gossip 6321/12 - Invoker casts 28919' WHERE `entryorguid` = 14902 AND `source_type` = 0 AND `id` = 25 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000470;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 28920, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Jin''rokh the Breaker - On gossip 6321/13 - Invoker casts 28920' WHERE `entryorguid` = 14902 AND `source_type` = 0 AND `id` = 27 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000471;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 24038, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Al''tabim the All-Seeing - On gossip 6322/0 - Invoker casts 24038' WHERE `entryorguid` = 14903 AND `source_type` = 0 AND `id` = 41 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000492;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 24039, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Al''tabim the All-Seeing - On gossip 6322/1 - Invoker casts 24039' WHERE `entryorguid` = 14903 AND `source_type` = 0 AND `id` = 39 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000491;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 24040, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Al''tabim the All-Seeing - On gossip 6322/2 - Invoker casts 24040' WHERE `entryorguid` = 14903 AND `source_type` = 0 AND `id` = 37 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000490;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 24041, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Al''tabim the All-Seeing - On gossip 6322/3 - Invoker casts 24041' WHERE `entryorguid` = 14903 AND `source_type` = 0 AND `id` = 35 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000489;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 24044, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Al''tabim the All-Seeing - On gossip 6322/4 - Invoker casts 24044' WHERE `entryorguid` = 14903 AND `source_type` = 0 AND `id` = 31 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000487;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 24045, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Al''tabim the All-Seeing - On gossip 6322/5 - Invoker casts 24045' WHERE `entryorguid` = 14903 AND `source_type` = 0 AND `id` = 33 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000488;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 24046, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Al''tabim the All-Seeing - On gossip 6322/6 - Invoker casts 24046' WHERE `entryorguid` = 14903 AND `source_type` = 0 AND `id` = 29 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000486;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 24047, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Al''tabim the All-Seeing - On gossip 6322/7 - Invoker casts 24047' WHERE `entryorguid` = 14903 AND `source_type` = 0 AND `id` = 27 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000485;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 24012, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Al''tabim the All-Seeing - On gossip 6322/8 - Invoker casts 24012' WHERE `entryorguid` = 14903 AND `source_type` = 0 AND `id` = 25 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000484;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 24013, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Al''tabim the All-Seeing - On gossip 6322/9 - Invoker casts 24013' WHERE `entryorguid` = 14903 AND `source_type` = 0 AND `id` = 23 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000483;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 24014, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Al''tabim the All-Seeing - On gossip 6322/10 - Invoker casts 24014' WHERE `entryorguid` = 14903 AND `source_type` = 0 AND `id` = 21 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000482;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 24015, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Al''tabim the All-Seeing - On gossip 6322/11 - Invoker casts 24015' WHERE `entryorguid` = 14903 AND `source_type` = 0 AND `id` = 19 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000481;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 28943, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Al''tabim the All-Seeing - On gossip 6322/12 - Invoker casts 28943' WHERE `entryorguid` = 14903 AND `source_type` = 0 AND `id` = 17 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000480;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 28945, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Al''tabim the All-Seeing - On gossip 6322/13 - Invoker casts 28945' WHERE `entryorguid` = 14903 AND `source_type` = 0 AND `id` = 15 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000479;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 28946, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Al''tabim the All-Seeing - On gossip 6322/14 - Invoker casts 28946' WHERE `entryorguid` = 14903 AND `source_type` = 0 AND `id` = 13 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000478;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 28949, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Al''tabim the All-Seeing - On gossip 6322/15 - Invoker casts 28949' WHERE `entryorguid` = 14903 AND `source_type` = 0 AND `id` = 11 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000477;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 28951, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Al''tabim the All-Seeing - On gossip 6322/16 - Invoker casts 28951' WHERE `entryorguid` = 14903 AND `source_type` = 0 AND `id` = 9 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000476;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 28952, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Al''tabim the All-Seeing - On gossip 6322/17 - Invoker casts 28952' WHERE `entryorguid` = 14903 AND `source_type` = 0 AND `id` = 5 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000474;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 28954, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Al''tabim the All-Seeing - On gossip 6322/18 - Invoker casts 28954' WHERE `entryorguid` = 14903 AND `source_type` = 0 AND `id` = 7 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000475;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 28956, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Al''tabim the All-Seeing - On gossip 6322/19 - Invoker casts 28956' WHERE `entryorguid` = 14903 AND `source_type` = 0 AND `id` = 3 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000473;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 28958, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Al''tabim the All-Seeing - On gossip 6322/20 - Invoker casts 28958' WHERE `entryorguid` = 14903 AND `source_type` = 0 AND `id` = 1 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000472;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 24055, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Maywiki of Zuldazar - On gossip 6341/0 - Invoker casts 24055' WHERE `entryorguid` = 14904 AND `source_type` = 0 AND `id` = 1 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000493;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 24056, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Maywiki of Zuldazar - On gossip 6341/1 - Invoker casts 24056' WHERE `entryorguid` = 14904 AND `source_type` = 0 AND `id` = 3 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000494;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 24059, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Maywiki of Zuldazar - On gossip 6341/2 - Invoker casts 24059' WHERE `entryorguid` = 14904 AND `source_type` = 0 AND `id` = 5 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000495;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 24060, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Maywiki of Zuldazar - On gossip 6341/3 - Invoker casts 24060' WHERE `entryorguid` = 14904 AND `source_type` = 0 AND `id` = 7 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000496;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 24067, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Maywiki of Zuldazar - On gossip 6341/4 - Invoker casts 24067' WHERE `entryorguid` = 14904 AND `source_type` = 0 AND `id` = 9 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000497;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 24068, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Maywiki of Zuldazar - On gossip 6341/5 - Invoker casts 24068' WHERE `entryorguid` = 14904 AND `source_type` = 0 AND `id` = 11 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000498;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 24069, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Maywiki of Zuldazar - On gossip 6341/6 - Invoker casts 24069' WHERE `entryorguid` = 14904 AND `source_type` = 0 AND `id` = 13 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000499;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 24070, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Maywiki of Zuldazar - On gossip 6341/7 - Invoker casts 24070' WHERE `entryorguid` = 14904 AND `source_type` = 0 AND `id` = 15 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000500;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 28959, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Maywiki of Zuldazar - On gossip 6341/8 - Invoker casts 28959' WHERE `entryorguid` = 14904 AND `source_type` = 0 AND `id` = 17 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000501;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 28923, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Maywiki of Zuldazar - On gossip 6341/9 - Invoker casts 28923' WHERE `entryorguid` = 14904 AND `source_type` = 0 AND `id` = 19 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000502;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 28926, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Maywiki of Zuldazar - On gossip 6341/10 - Invoker casts 28926' WHERE `entryorguid` = 14904 AND `source_type` = 0 AND `id` = 21 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000503;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 28940, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Maywiki of Zuldazar - On gossip 6341/11 - Invoker casts 28940' WHERE `entryorguid` = 14904 AND `source_type` = 0 AND `id` = 23 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000504;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 28941, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Maywiki of Zuldazar - On gossip 6341/12 - Invoker casts 28941' WHERE `entryorguid` = 14904 AND `source_type` = 0 AND `id` = 25 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000505;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 28942, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Maywiki of Zuldazar - On gossip 6341/13 - Invoker casts 28942' WHERE `entryorguid` = 14904 AND `source_type` = 0 AND `id` = 27 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000506;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 24076, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Falthir the Sightless - On gossip 6363/0 - Invoker casts 24076' WHERE `entryorguid` = 14905 AND `source_type` = 0 AND `id` = 1 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000507;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 24077, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Falthir the Sightless - On gossip 6363/1 - Invoker casts 24077' WHERE `entryorguid` = 14905 AND `source_type` = 0 AND `id` = 3 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000508;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 24078, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Falthir the Sightless - On gossip 6363/2 - Invoker casts 24078' WHERE `entryorguid` = 14905 AND `source_type` = 0 AND `id` = 5 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000509;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 24079, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Falthir the Sightless - On gossip 6363/3 - Invoker casts 24079' WHERE `entryorguid` = 14905 AND `source_type` = 0 AND `id` = 7 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000510;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 24072, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Falthir the Sightless - On gossip 6363/4 - Invoker casts 24072' WHERE `entryorguid` = 14905 AND `source_type` = 0 AND `id` = 9 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000511;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 24073, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Falthir the Sightless - On gossip 6363/5 - Invoker casts 24073' WHERE `entryorguid` = 14905 AND `source_type` = 0 AND `id` = 11 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000512;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 24074, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Falthir the Sightless - On gossip 6363/6 - Invoker casts 24074' WHERE `entryorguid` = 14905 AND `source_type` = 0 AND `id` = 13 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000513;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 24075, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Falthir the Sightless - On gossip 6363/7 - Invoker casts 24075' WHERE `entryorguid` = 14905 AND `source_type` = 0 AND `id` = 15 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000514;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 28935, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Falthir the Sightless - On gossip 6363/8 - Invoker casts 28935' WHERE `entryorguid` = 14905 AND `source_type` = 0 AND `id` = 17 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000515;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 28937, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Falthir the Sightless - On gossip 6363/9 - Invoker casts 28937' WHERE `entryorguid` = 14905 AND `source_type` = 0 AND `id` = 19 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000516;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 28939, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Falthir the Sightless - On gossip 6363/10 - Invoker casts 28939' WHERE `entryorguid` = 14905 AND `source_type` = 0 AND `id` = 21 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000517;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 28921, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Falthir the Sightless - On gossip 6363/11 - Invoker casts 28921' WHERE `entryorguid` = 14905 AND `source_type` = 0 AND `id` = 23 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000518;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 28929, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Falthir the Sightless - On gossip 6363/12 - Invoker casts 28929' WHERE `entryorguid` = 14905 AND `source_type` = 0 AND `id` = 25 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000519;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 28930, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Falthir the Sightless - On gossip 6363/13 - Invoker casts 28930' WHERE `entryorguid` = 14905 AND `source_type` = 0 AND `id` = 27 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000520;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 25927, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Anachronos - On gossip 6539/0 - Invoker casts 25927' WHERE `entryorguid` = 15192 AND `source_type` = 0 AND `id` = 4 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000524;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 25928, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Anachronos - On gossip 6539/1 - Invoker casts 25928' WHERE `entryorguid` = 15192 AND `source_type` = 0 AND `id` = 6 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000525;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 25929, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Anachronos - On gossip 6539/2 - Invoker casts 25929' WHERE `entryorguid` = 15192 AND `source_type` = 0 AND `id` = 8 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000526;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 25930, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Anachronos - On gossip 6539/3 - Invoker casts 25930' WHERE `entryorguid` = 15192 AND `source_type` = 0 AND `id` = 10 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000527;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 25931, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Anachronos - On gossip 6539/4 - Invoker casts 25931' WHERE `entryorguid` = 15192 AND `source_type` = 0 AND `id` = 12 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000528;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 25921, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Anachronos - On gossip 6539/5 - Invoker casts 25921' WHERE `entryorguid` = 15192 AND `source_type` = 0 AND `id` = 14 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000529;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 25922, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Anachronos - On gossip 6539/6 - Invoker casts 25922' WHERE `entryorguid` = 15192 AND `source_type` = 0 AND `id` = 16 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000530;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 25923, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Anachronos - On gossip 6539/7 - Invoker casts 25923' WHERE `entryorguid` = 15192 AND `source_type` = 0 AND `id` = 18 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000531;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 25924, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Anachronos - On gossip 6539/8 - Invoker casts 25924' WHERE `entryorguid` = 15192 AND `source_type` = 0 AND `id` = 20 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000532;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 25925, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Anachronos - On gossip 6539/9 - Invoker casts 25925' WHERE `entryorguid` = 15192 AND `source_type` = 0 AND `id` = 22 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000533;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 25932, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Anachronos - On gossip 6539/10 - Invoker casts 25932' WHERE `entryorguid` = 15192 AND `source_type` = 0 AND `id` = 24 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000534;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 25933, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Anachronos - On gossip 6539/11 - Invoker casts 25933' WHERE `entryorguid` = 15192 AND `source_type` = 0 AND `id` = 26 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000535;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 25934, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Anachronos - On gossip 6539/12 - Invoker casts 25934' WHERE `entryorguid` = 15192 AND `source_type` = 0 AND `id` = 28 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000536;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 25935, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Anachronos - On gossip 6539/13 - Invoker casts 25935' WHERE `entryorguid` = 15192 AND `source_type` = 0 AND `id` = 30 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000537;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 25936, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Anachronos - On gossip 6539/14 - Invoker casts 25936' WHERE `entryorguid` = 15192 AND `source_type` = 0 AND `id` = 32 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000538;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 29011, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Windcaller Yessendra - On gossip 6928/0 - Invoker casts 29011' WHERE `entryorguid` = 15498 AND `source_type` = 0 AND `id` = 1 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000540;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 29014, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Windcaller Yessendra - On gossip 6928/1 - Invoker casts 29014' WHERE `entryorguid` = 15498 AND `source_type` = 0 AND `id` = 3 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000541;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 29017, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Windcaller Yessendra - On gossip 6928/2 - Invoker casts 29017' WHERE `entryorguid` = 15498 AND `source_type` = 0 AND `id` = 5 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000542;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 29020, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Windcaller Yessendra - On gossip 6928/3 - Invoker casts 29020' WHERE `entryorguid` = 15498 AND `source_type` = 0 AND `id` = 7 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000543;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 29023, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Windcaller Yessendra - On gossip 6928/4 - Invoker casts 29023' WHERE `entryorguid` = 15498 AND `source_type` = 0 AND `id` = 9 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000544;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 29026, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Windcaller Yessendra - On gossip 6928/5 - Invoker casts 29026' WHERE `entryorguid` = 15498 AND `source_type` = 0 AND `id` = 11 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000545;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 29030, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Windcaller Yessendra - On gossip 6928/6 - Invoker casts 29030' WHERE `entryorguid` = 15498 AND `source_type` = 0 AND `id` = 13 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000546;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 29033, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Windcaller Yessendra - On gossip 6928/7 - Invoker casts 29033' WHERE `entryorguid` = 15498 AND `source_type` = 0 AND `id` = 15 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000547;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 29037, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Windcaller Yessendra - On gossip 6928/8 - Invoker casts 29037' WHERE `entryorguid` = 15498 AND `source_type` = 0 AND `id` = 17 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000548;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 29009, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Warden Haro - On gossip 6925/0 - Invoker casts 29009' WHERE `entryorguid` = 15499 AND `source_type` = 0 AND `id` = 1 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000549;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 29012, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Warden Haro - On gossip 6925/1 - Invoker casts 29012' WHERE `entryorguid` = 15499 AND `source_type` = 0 AND `id` = 3 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000550;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 29015, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Warden Haro - On gossip 6925/2 - Invoker casts 29015' WHERE `entryorguid` = 15499 AND `source_type` = 0 AND `id` = 5 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000551;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 29018, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Warden Haro - On gossip 6925/3 - Invoker casts 29018' WHERE `entryorguid` = 15499 AND `source_type` = 0 AND `id` = 7 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000552;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 29021, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Warden Haro - On gossip 6925/4 - Invoker casts 29021' WHERE `entryorguid` = 15499 AND `source_type` = 0 AND `id` = 9 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000553;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 29024, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Warden Haro - On gossip 6925/5 - Invoker casts 29024' WHERE `entryorguid` = 15499 AND `source_type` = 0 AND `id` = 11 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000554;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 29027, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Warden Haro - On gossip 6925/6 - Invoker casts 29027' WHERE `entryorguid` = 15499 AND `source_type` = 0 AND `id` = 13 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000555;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 29031, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Warden Haro - On gossip 6925/7 - Invoker casts 29031' WHERE `entryorguid` = 15499 AND `source_type` = 0 AND `id` = 15 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000556;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 29034, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Warden Haro - On gossip 6925/8 - Invoker casts 29034' WHERE `entryorguid` = 15499 AND `source_type` = 0 AND `id` = 17 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000557;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 29010, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Keyl Swiftclaw - On gossip 6927/0 - Invoker casts 29010' WHERE `entryorguid` = 15500 AND `source_type` = 0 AND `id` = 1 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000558;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 29013, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Keyl Swiftclaw - On gossip 6927/1 - Invoker casts 29013' WHERE `entryorguid` = 15500 AND `source_type` = 0 AND `id` = 3 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000559;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 29016, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Keyl Swiftclaw - On gossip 6927/2 - Invoker casts 29016' WHERE `entryorguid` = 15500 AND `source_type` = 0 AND `id` = 5 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000560;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 29019, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Keyl Swiftclaw - On gossip 6927/3 - Invoker casts 29019' WHERE `entryorguid` = 15500 AND `source_type` = 0 AND `id` = 7 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000561;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 29022, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Keyl Swiftclaw - On gossip 6927/4 - Invoker casts 29022' WHERE `entryorguid` = 15500 AND `source_type` = 0 AND `id` = 9 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000562;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 29025, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Keyl Swiftclaw - On gossip 6927/5 - Invoker casts 29025' WHERE `entryorguid` = 15500 AND `source_type` = 0 AND `id` = 11 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000563;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 29028, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Keyl Swiftclaw - On gossip 6927/6 - Invoker casts 29028' WHERE `entryorguid` = 15500 AND `source_type` = 0 AND `id` = 13 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000564;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 29032, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Keyl Swiftclaw - On gossip 6927/7 - Invoker casts 29032' WHERE `entryorguid` = 15500 AND `source_type` = 0 AND `id` = 15 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000565;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 29036, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Keyl Swiftclaw - On gossip 6927/8 - Invoker casts 29036' WHERE `entryorguid` = 15500 AND `source_type` = 0 AND `id` = 17 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000566;
