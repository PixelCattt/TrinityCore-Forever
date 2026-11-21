-- WoW Forever: vendor items whose live price is currency 3402 or other items (Wowhead WoW Forever vendor pages, read
-- 11-20/11-21). Ours sold some of them for gold (cost id 0) and missed others. Cost ids from the client's ItemExtendedCost
-- (build 70959): where several ids carry the same price, the one our other vendors use for that item, else the lowest.
-- Rows are replaced by key. Safe to run again.
-- Fizzlefuse (240654)
DELETE FROM `npc_vendor` WHERE `entry`=240654 AND `item`=15997 AND `ExtendedCost` IN (0,10420) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (240654,0,15997,0,0,10420,1,NULL,0,0,0); -- it18042x100
DELETE FROM `npc_vendor` WHERE `entry`=240654 AND `item`=18042 AND `ExtendedCost` IN (0,10390) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (240654,0,18042,0,0,10390,1,NULL,0,0,0); -- it15997x100
-- Fizzlefuse (248200)
DELETE FROM `npc_vendor` WHERE `entry`=248200 AND `item`=264221 AND `ExtendedCost` IN (0,11862) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (248200,0,264221,0,0,11862,1,NULL,0,0,0); -- cur3402x270
DELETE FROM `npc_vendor` WHERE `entry`=248200 AND `item`=264222 AND `ExtendedCost` IN (0,11862) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (248200,0,264222,0,0,11862,1,NULL,0,0,0); -- cur3402x270
-- Kurvelk Shadowhoof (256672)
DELETE FROM `npc_vendor` WHERE `entry`=256672 AND `item`=262896 AND `ExtendedCost` IN (0,11047) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (256672,0,262896,0,0,11047,1,NULL,0,0,0); -- cur3402x15
DELETE FROM `npc_vendor` WHERE `entry`=256672 AND `item`=262902 AND `ExtendedCost` IN (0,11047) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (256672,1,262902,0,0,11047,1,NULL,0,0,0); -- cur3402x15
-- Stondry Darkhammer (256730)
DELETE FROM `npc_vendor` WHERE `entry`=256730 AND `item`=285289 AND `ExtendedCost` IN (0,11844) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (256730,1,285289,0,0,11844,1,NULL,0,0,0); -- cur3402x30
DELETE FROM `npc_vendor` WHERE `entry`=256730 AND `item`=285290 AND `ExtendedCost` IN (0,11846) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (256730,2,285290,0,0,11846,1,NULL,0,0,0); -- cur3402x60
DELETE FROM `npc_vendor` WHERE `entry`=256730 AND `item`=285291 AND `ExtendedCost` IN (0,11847) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (256730,3,285291,0,0,11847,1,NULL,0,0,0); -- cur3402x90
-- Dianne Softstep (256742)
DELETE FROM `npc_vendor` WHERE `entry`=256742 AND `item`=262896 AND `ExtendedCost` IN (0,11047) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (256742,0,262896,0,0,11047,1,NULL,0,0,0); -- cur3402x15
DELETE FROM `npc_vendor` WHERE `entry`=256742 AND `item`=262902 AND `ExtendedCost` IN (0,11047) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (256742,1,262902,0,0,11047,1,NULL,0,0,0); -- cur3402x15
-- Aisarra Nightmeadow (264797)
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=273952 AND `ExtendedCost` IN (0,11548) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,273952,0,0,11548,1,NULL,0,0,0); -- it274030x8
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=273953 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,273953,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=273954 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,273954,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=273955 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,273955,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=273956 AND `ExtendedCost` IN (0,11548) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,273956,0,0,11548,1,NULL,0,0,0); -- it274030x8
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=273957 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,273957,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=273958 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,273958,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=273959 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,273959,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=273960 AND `ExtendedCost` IN (0,11548) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,273960,0,0,11548,1,NULL,0,0,0); -- it274030x8
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=273961 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,273961,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=273962 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,273962,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=273963 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,273963,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=273964 AND `ExtendedCost` IN (0,11548) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,273964,0,0,11548,1,NULL,0,0,0); -- it274030x8
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=273965 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,273965,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=273966 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,273966,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=273967 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,273967,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=273968 AND `ExtendedCost` IN (0,11548) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,273968,0,0,11548,1,NULL,0,0,0); -- it274030x8
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=273969 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,273969,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=273970 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,273970,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=273971 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,273971,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=273972 AND `ExtendedCost` IN (0,11548) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,273972,0,0,11548,1,NULL,0,0,0); -- it274030x8
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=273973 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,273973,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=273974 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,273974,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=273975 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,273975,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=273976 AND `ExtendedCost` IN (0,11548) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,273976,0,0,11548,1,NULL,0,0,0); -- it274030x8
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=273977 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,273977,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=273978 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,273978,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=273979 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,273979,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=273980 AND `ExtendedCost` IN (0,11548) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,273980,0,0,11548,1,NULL,0,0,0); -- it274030x8
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=273981 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,273981,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=273982 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,273982,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=273983 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,273983,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=273984 AND `ExtendedCost` IN (0,11548) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,273984,0,0,11548,1,NULL,0,0,0); -- it274030x8
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=273985 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,273985,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=273986 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,273986,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=273987 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,273987,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=273988 AND `ExtendedCost` IN (0,11548) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,273988,0,0,11548,1,NULL,0,0,0); -- it274030x8
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=273989 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,273989,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=273990 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,273990,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=273991 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,273991,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=273992 AND `ExtendedCost` IN (0,11548) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,273992,0,0,11548,1,NULL,0,0,0); -- it274030x8
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=273993 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,273993,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=273994 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,273994,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=273995 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,273995,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=273996 AND `ExtendedCost` IN (0,11548) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,273996,0,0,11548,1,NULL,0,0,0); -- it274030x8
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=273997 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,273997,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=273998 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,273998,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=273999 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,273999,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=274000 AND `ExtendedCost` IN (0,11548) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,274000,0,0,11548,1,NULL,0,0,0); -- it274030x8
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=274001 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,274001,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=274002 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,274002,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=274003 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,274003,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=274004 AND `ExtendedCost` IN (0,11548) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,274004,0,0,11548,1,NULL,0,0,0); -- it274030x8
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=274005 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,274005,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=274006 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,274006,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=274007 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,274007,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=274008 AND `ExtendedCost` IN (0,11548) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,274008,0,0,11548,1,NULL,0,0,0); -- it274030x8
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=274009 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,274009,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=274010 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,274010,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=274011 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,274011,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=274012 AND `ExtendedCost` IN (0,11548) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,274012,0,0,11548,1,NULL,0,0,0); -- it274030x8
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=274013 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,274013,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=274014 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,274014,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=274015 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,274015,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=274016 AND `ExtendedCost` IN (0,11548) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,274016,0,0,11548,1,NULL,0,0,0); -- it274030x8
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=274017 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,274017,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=274018 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,274018,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=274019 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,274019,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=276542 AND `ExtendedCost` IN (0,11548) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,276542,0,0,11548,1,NULL,0,0,0); -- it274030x8
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=276543 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,276543,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=276544 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,276544,0,0,11549,1,NULL,0,0,0); -- it274030x6
DELETE FROM `npc_vendor` WHERE `entry`=264797 AND `item`=276545 AND `ExtendedCost` IN (0,11549) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (264797,0,276545,0,0,11549,1,NULL,0,0,0); -- it274030x6
-- Gishah (256384)
DELETE FROM `npc_vendor` WHERE `entry`=256384 AND `item`=262764 AND `ExtendedCost` IN (0,11041) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (256384,0,262764,0,0,11041,1,NULL,0,0,0); -- cur3402x200
DELETE FROM `npc_vendor` WHERE `entry`=256384 AND `item`=270887 AND `ExtendedCost` IN (0,11517) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (256384,0,270887,0,0,11517,1,NULL,0,0,0); -- cur3402x1200
DELETE FROM `npc_vendor` WHERE `entry`=256384 AND `item`=284664 AND `ExtendedCost` IN (0,11879) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES (256384,0,284664,0,0,11879,1,NULL,0,0,0); -- cur3402x1500
