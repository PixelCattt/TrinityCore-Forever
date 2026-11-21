-- WoW Forever: vendor items from the live vendor pages on Wowhead (WoW Forever section, read 11-20/11-21).
-- 1) items live vendors sell that ours do not (money only; items with a currency or item cost are in 2026_11_21_56),
-- 2) items live sells in limited stock that ours sold without limit. Restock time is not shown on Wowhead: 2.5 h
-- (ESTIMATED, the same as 2026_11_20_90). Rows are replaced by key. Safe to run again.
-- Adarien (252691)
DELETE FROM `npc_vendor` WHERE `entry`=252691 AND `item`=159 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (252691,0,159,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=252691 AND `item`=1179 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (252691,1,1179,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=252691 AND `item`=1205 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (252691,2,1205,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=252691 AND `item`=1645 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (252691,3,1645,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=252691 AND `item`=1708 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (252691,4,1708,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=252691 AND `item`=4536 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (252691,5,4536,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=252691 AND `item`=4537 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (252691,6,4537,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=252691 AND `item`=4538 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (252691,7,4538,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=252691 AND `item`=4539 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (252691,8,4539,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=252691 AND `item`=4602 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (252691,9,4602,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=252691 AND `item`=8766 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (252691,10,8766,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=252691 AND `item`=8953 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (252691,11,8953,0,0,0,1,NULL,0,0,0);
-- Arondel (255704)
DELETE FROM `npc_vendor` WHERE `entry`=255704 AND `item`=159 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (255704,0,159,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=255704 AND `item`=1179 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (255704,1,1179,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=255704 AND `item`=1205 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (255704,2,1205,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=255704 AND `item`=1645 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (255704,3,1645,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=255704 AND `item`=1708 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (255704,4,1708,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=255704 AND `item`=8766 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (255704,5,8766,0,0,0,1,NULL,0,0,0);
-- Mister Graphed (263384)
DELETE FROM `npc_vendor` WHERE `entry`=263384 AND `item`=12363 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (263384,1,12363,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=263384 AND `item`=13468 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (263384,2,13468,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=263384 AND `item`=248819 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (263384,3,248819,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=263384 AND `item`=248820 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (263384,4,248820,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=263384 AND `item`=248822 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (263384,5,248822,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=263384 AND `item`=249274 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (263384,6,249274,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=263384 AND `item`=249391 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (263384,7,249391,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=263384 AND `item`=249399 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (263384,8,249399,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=263384 AND `item`=249424 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (263384,9,249424,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=263384 AND `item`=249425 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (263384,10,249425,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=263384 AND `item`=249426 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (263384,11,249426,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=263384 AND `item`=249427 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (263384,12,249427,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=263384 AND `item`=249428 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (263384,13,249428,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=263384 AND `item`=249429 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (263384,14,249429,0,0,0,1,NULL,0,0,0);
-- Hamur (263440)
DELETE FROM `npc_vendor` WHERE `entry`=263440 AND `item`=2527 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (263440,2,2527,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=263440 AND `item`=251460 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (263440,3,251460,0,0,0,1,NULL,0,0,0);
-- Bryanna Embreeze (263569)
DELETE FROM `npc_vendor` WHERE `entry`=263569 AND `item`=271903 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (263569,35,271903,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=263569 AND `item`=271904 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (263569,36,271904,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=263569 AND `item`=271905 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (263569,37,271905,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=263569 AND `item`=271906 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (263569,38,271906,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=263569 AND `item`=271908 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (263569,39,271908,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=263569 AND `item`=271909 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (263569,40,271909,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=263569 AND `item`=271910 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (263569,41,271910,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=263569 AND `item`=271913 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (263569,42,271913,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=263569 AND `item`=271914 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (263569,43,271914,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=263569 AND `item`=271915 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (263569,44,271915,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=263569 AND `item`=271917 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (263569,45,271917,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=263569 AND `item`=271918 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (263569,46,271918,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=263569 AND `item`=271919 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (263569,47,271919,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=263569 AND `item`=271940 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (263569,48,271940,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=263569 AND `item`=271941 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (263569,49,271941,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=263569 AND `item`=271945 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (263569,50,271945,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=263569 AND `item`=271946 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (263569,51,271946,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=263569 AND `item`=271955 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (263569,52,271955,0,0,0,1,NULL,0,0,0);
-- Goren Grayfellow (272435)
DELETE FROM `npc_vendor` WHERE `entry`=272435 AND `item`=2417 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (272435,1,2417,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=272435 AND `item`=2418 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (272435,2,2418,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=272435 AND `item`=2419 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (272435,3,2419,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=272435 AND `item`=2420 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (272435,4,2420,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=272435 AND `item`=2421 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (272435,5,2421,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=272435 AND `item`=2422 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (272435,6,2422,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=272435 AND `item`=2429 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (272435,7,2429,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=272435 AND `item`=2431 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (272435,8,2431,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=272435 AND `item`=2432 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (272435,9,2432,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=272435 AND `item`=2434 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (272435,10,2434,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=272435 AND `item`=2448 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (272435,11,2448,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=272435 AND `item`=2463 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (272435,12,2463,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=272435 AND `item`=2464 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (272435,13,2464,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=272435 AND `item`=2465 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (272435,14,2465,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=272435 AND `item`=2467 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (272435,15,2467,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=272435 AND `item`=2468 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (272435,16,2468,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=272435 AND `item`=2469 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (272435,17,2469,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=272435 AND `item`=3593 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (272435,18,3593,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=272435 AND `item`=3594 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (272435,19,3594,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=272435 AND `item`=3889 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (272435,20,3889,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=272435 AND `item`=3890 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (272435,21,3890,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=272435 AND `item`=3891 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (272435,22,3891,0,0,0,1,NULL,0,0,0);
-- Glop (257057)
DELETE FROM `npc_vendor` WHERE `entry`=257057 AND `item`=4599 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (257057,2,4599,0,0,0,1,NULL,0,0,0);
DELETE FROM `npc_vendor` WHERE `entry`=257057 AND `item`=8952 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (257057,3,8952,0,0,0,1,NULL,0,0,0);
-- Fimbo Greasemitz (259962)
DELETE FROM `npc_vendor` WHERE `entry`=259962 AND `item`=274972 AND `ExtendedCost`=0 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (259962,1,274972,0,0,0,1,NULL,0,0,0);
-- limited stock
-- Fizzlefuse (240654)
UPDATE `npc_vendor` SET `maxcount`=4, `incrtime`=9000 WHERE `entry`=240654 AND `item`=4357 AND `ExtendedCost`=0 AND `type`=1 AND `maxcount`=0;
UPDATE `npc_vendor` SET `maxcount`=2, `incrtime`=9000 WHERE `entry`=240654 AND `item`=4361 AND `ExtendedCost`=0 AND `type`=1 AND `maxcount`=0;
UPDATE `npc_vendor` SET `maxcount`=2, `incrtime`=9000 WHERE `entry`=240654 AND `item`=4363 AND `ExtendedCost`=0 AND `type`=1 AND `maxcount`=0;
UPDATE `npc_vendor` SET `maxcount`=4, `incrtime`=9000 WHERE `entry`=240654 AND `item`=4364 AND `ExtendedCost`=0 AND `type`=1 AND `maxcount`=0;
UPDATE `npc_vendor` SET `maxcount`=2, `incrtime`=9000 WHERE `entry`=240654 AND `item`=4371 AND `ExtendedCost`=0 AND `type`=1 AND `maxcount`=0;
UPDATE `npc_vendor` SET `maxcount`=1, `incrtime`=9000 WHERE `entry`=240654 AND `item`=4382 AND `ExtendedCost`=0 AND `type`=1 AND `maxcount`=0;
UPDATE `npc_vendor` SET `maxcount`=1, `incrtime`=9000 WHERE `entry`=240654 AND `item`=4389 AND `ExtendedCost`=0 AND `type`=1 AND `maxcount`=0;
UPDATE `npc_vendor` SET `maxcount`=3, `incrtime`=9000 WHERE `entry`=240654 AND `item`=4404 AND `ExtendedCost`=0 AND `type`=1 AND `maxcount`=0;
-- Gritta Chumwater (260487)
UPDATE `npc_vendor` SET `maxcount`=5, `incrtime`=9000 WHERE `entry`=260487 AND `item`=4603 AND `ExtendedCost`=0 AND `type`=1 AND `maxcount`=0;
UPDATE `npc_vendor` SET `maxcount`=5, `incrtime`=9000 WHERE `entry`=260487 AND `item`=6289 AND `ExtendedCost`=0 AND `type`=1 AND `maxcount`=0;
UPDATE `npc_vendor` SET `maxcount`=5, `incrtime`=9000 WHERE `entry`=260487 AND `item`=6303 AND `ExtendedCost`=0 AND `type`=1 AND `maxcount`=0;
UPDATE `npc_vendor` SET `maxcount`=5, `incrtime`=9000 WHERE `entry`=260487 AND `item`=6308 AND `ExtendedCost`=0 AND `type`=1 AND `maxcount`=0;
UPDATE `npc_vendor` SET `maxcount`=5, `incrtime`=9000 WHERE `entry`=260487 AND `item`=6362 AND `ExtendedCost`=0 AND `type`=1 AND `maxcount`=0;
UPDATE `npc_vendor` SET `maxcount`=1, `incrtime`=9000 WHERE `entry`=260487 AND `item`=6365 AND `ExtendedCost`=0 AND `type`=1 AND `maxcount`=0;
UPDATE `npc_vendor` SET `maxcount`=2, `incrtime`=9000 WHERE `entry`=260487 AND `item`=6533 AND `ExtendedCost`=0 AND `type`=1 AND `maxcount`=0;
UPDATE `npc_vendor` SET `maxcount`=5, `incrtime`=9000 WHERE `entry`=260487 AND `item`=8959 AND `ExtendedCost`=0 AND `type`=1 AND `maxcount`=0;
-- Kor'gar (260565)
UPDATE `npc_vendor` SET `maxcount`=4, `incrtime`=9000 WHERE `entry`=260565 AND `item`=4357 AND `ExtendedCost`=0 AND `type`=1 AND `maxcount`=0;
UPDATE `npc_vendor` SET `maxcount`=2, `incrtime`=9000 WHERE `entry`=260565 AND `item`=4361 AND `ExtendedCost`=0 AND `type`=1 AND `maxcount`=0;
UPDATE `npc_vendor` SET `maxcount`=2, `incrtime`=9000 WHERE `entry`=260565 AND `item`=4363 AND `ExtendedCost`=0 AND `type`=1 AND `maxcount`=0;
UPDATE `npc_vendor` SET `maxcount`=4, `incrtime`=9000 WHERE `entry`=260565 AND `item`=4364 AND `ExtendedCost`=0 AND `type`=1 AND `maxcount`=0;
UPDATE `npc_vendor` SET `maxcount`=2, `incrtime`=9000 WHERE `entry`=260565 AND `item`=4371 AND `ExtendedCost`=0 AND `type`=1 AND `maxcount`=0;
UPDATE `npc_vendor` SET `maxcount`=1, `incrtime`=9000 WHERE `entry`=260565 AND `item`=4382 AND `ExtendedCost`=0 AND `type`=1 AND `maxcount`=0;
UPDATE `npc_vendor` SET `maxcount`=1, `incrtime`=9000 WHERE `entry`=260565 AND `item`=4389 AND `ExtendedCost`=0 AND `type`=1 AND `maxcount`=0;
UPDATE `npc_vendor` SET `maxcount`=3, `incrtime`=9000 WHERE `entry`=260565 AND `item`=4404 AND `ExtendedCost`=0 AND `type`=1 AND `maxcount`=0;
-- Justine Kai (270570)
UPDATE `npc_vendor` SET `maxcount`=2, `incrtime`=9000 WHERE `entry`=270570 AND `item`=4817 AND `ExtendedCost`=0 AND `type`=1 AND `maxcount`=0;
UPDATE `npc_vendor` SET `maxcount`=2, `incrtime`=9000 WHERE `entry`=270570 AND `item`=4818 AND `ExtendedCost`=0 AND `type`=1 AND `maxcount`=0;
-- Barracks Master Harlan (257595)
UPDATE `npc_vendor` SET `maxcount`=5, `incrtime`=9000 WHERE `entry`=257595 AND `item`=4603 AND `ExtendedCost`=0 AND `type`=1 AND `maxcount`=0;
UPDATE `npc_vendor` SET `maxcount`=5, `incrtime`=9000 WHERE `entry`=257595 AND `item`=6289 AND `ExtendedCost`=0 AND `type`=1 AND `maxcount`=0;
UPDATE `npc_vendor` SET `maxcount`=5, `incrtime`=9000 WHERE `entry`=257595 AND `item`=6303 AND `ExtendedCost`=0 AND `type`=1 AND `maxcount`=0;
UPDATE `npc_vendor` SET `maxcount`=5, `incrtime`=9000 WHERE `entry`=257595 AND `item`=6308 AND `ExtendedCost`=0 AND `type`=1 AND `maxcount`=0;
UPDATE `npc_vendor` SET `maxcount`=5, `incrtime`=9000 WHERE `entry`=257595 AND `item`=6362 AND `ExtendedCost`=0 AND `type`=1 AND `maxcount`=0;
UPDATE `npc_vendor` SET `maxcount`=5, `incrtime`=9000 WHERE `entry`=257595 AND `item`=8959 AND `ExtendedCost`=0 AND `type`=1 AND `maxcount`=0;
-- Dorb (263230)
UPDATE `npc_vendor` SET `maxcount`=3, `incrtime`=9000 WHERE `entry`=263230 AND `item`=3827 AND `ExtendedCost`=0 AND `type`=1 AND `maxcount`=0;
UPDATE `npc_vendor` SET `maxcount`=1, `incrtime`=9000 WHERE `entry`=263230 AND `item`=271646 AND `ExtendedCost`=0 AND `type`=1 AND `maxcount`=0;
UPDATE `npc_vendor` SET `maxcount`=1, `incrtime`=9000 WHERE `entry`=263230 AND `item`=271647 AND `ExtendedCost`=0 AND `type`=1 AND `maxcount`=0;
UPDATE `npc_vendor` SET `maxcount`=1, `incrtime`=9000 WHERE `entry`=263230 AND `item`=271648 AND `ExtendedCost`=0 AND `type`=1 AND `maxcount`=0;
-- Aurian Highgrove (265346)
UPDATE `npc_vendor` SET `maxcount`=2, `incrtime`=9000 WHERE `entry`=265346 AND `item`=2595 AND `ExtendedCost`=0 AND `type`=1 AND `maxcount`=0;
UPDATE `npc_vendor` SET `maxcount`=4, `incrtime`=9000 WHERE `entry`=265346 AND `item`=19221 AND `ExtendedCost`=0 AND `type`=1 AND `maxcount`=0;
UPDATE `npc_vendor` SET `maxcount`=1, `incrtime`=9000 WHERE `entry`=265346 AND `item`=275892 AND `ExtendedCost`=0 AND `type`=1 AND `maxcount`=0;
-- Kenneth "Kirby" Millstead (270545)
UPDATE `npc_vendor` SET `maxcount`=5, `incrtime`=9000 WHERE `entry`=270545 AND `item`=4603 AND `ExtendedCost`=0 AND `type`=1 AND `maxcount`=0;
UPDATE `npc_vendor` SET `maxcount`=5, `incrtime`=9000 WHERE `entry`=270545 AND `item`=6289 AND `ExtendedCost`=0 AND `type`=1 AND `maxcount`=0;
UPDATE `npc_vendor` SET `maxcount`=5, `incrtime`=9000 WHERE `entry`=270545 AND `item`=6303 AND `ExtendedCost`=0 AND `type`=1 AND `maxcount`=0;
UPDATE `npc_vendor` SET `maxcount`=5, `incrtime`=9000 WHERE `entry`=270545 AND `item`=6308 AND `ExtendedCost`=0 AND `type`=1 AND `maxcount`=0;
UPDATE `npc_vendor` SET `maxcount`=5, `incrtime`=9000 WHERE `entry`=270545 AND `item`=6362 AND `ExtendedCost`=0 AND `type`=1 AND `maxcount`=0;
UPDATE `npc_vendor` SET `maxcount`=1, `incrtime`=9000 WHERE `entry`=270545 AND `item`=6365 AND `ExtendedCost`=0 AND `type`=1 AND `maxcount`=0;
UPDATE `npc_vendor` SET `maxcount`=2, `incrtime`=9000 WHERE `entry`=270545 AND `item`=6533 AND `ExtendedCost`=0 AND `type`=1 AND `maxcount`=0;
UPDATE `npc_vendor` SET `maxcount`=5, `incrtime`=9000 WHERE `entry`=270545 AND `item`=8959 AND `ExtendedCost`=0 AND `type`=1 AND `maxcount`=0;
-- Corrected stock
UPDATE `npc_vendor` SET `maxcount`=4 WHERE `entry`=257004 AND `item`=10940 AND `ExtendedCost`=0 AND `type`=1 AND `maxcount`=2;
