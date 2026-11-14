-- WoW Forever: world rows from live players' EG Link data that our world lacked or had different: the build 1.60.1.70888
-- folder as of github.com/JIVESCORP/eg-link-output-wowf commit e0f8585 (collected 2026-11-10..2026-11-13, 5 players; the part
-- 2026_11_13_88 and 2026_11_13_90 did not take, they used commit 164bd1e2) and the first 1.60.1.70938 folder (2026-11-13, 1 player).
-- Data from Efficient Games (https://efficient.games), licensed under CC BY 4.0
-- (https://creativecommons.org/licenses/by/4.0/). Changed: picked and converted to our tables; only rows we lacked or had different
-- from live. Live trainer prices are not in this file. Safe to run again.

-- 1. Object templates our world lacks (template and quest loot list only, no spawns; 612130 Arcane Salvager is from the
--    70938 folder). Fill-only: rows we have stay.
INSERT IGNORE INTO `gameobject_template` (`entry`,`type`,`displayId`,`name`,`IconName`,`castBarCaption`,`unk1`,`size`,`Data0`,`Data1`,`Data2`,`Data3`,`Data4`,`Data5`,`Data6`,`Data7`,`Data8`,`Data9`,`Data10`,`Data11`,`Data12`,`Data13`,`Data14`,`Data15`,`Data16`,`Data17`,`Data18`,`Data19`,`Data20`,`Data21`,`Data22`,`Data23`,`Data24`,`Data25`,`Data26`,`Data27`,`Data28`,`Data29`,`Data30`,`Data31`,`Data32`,`Data33`,`Data34`,`ContentTuningId`,`RequiredLevel`,`VerifiedBuild`) VALUES
(423910,5,31,'Crate','','','',1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(424002,3,335,'Kurzen Supply Crate','','','',1.0,93,122215,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(424003,10,1787,'Cage','','','',1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,70888),
(424266,3,19,'Grave','','','',1.0,43,122169,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(425896,9,3871,'Archivists of the Monastery','','','',1.0,9198,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(425897,9,558,'Archivists of the Monastery','','','',1.0,9199,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(425899,9,2530,'Archivists of the Monastery','','','',1.0,9201,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(556645,8,216,'Cauldron','','','',1.0,4,10,2061,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(556653,3,189,'Weathered Bookcase','','','',0.91,43,1513,30,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(556660,8,216,'Cauldron','','','',1.0,4,10,2061,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(556678,8,216,'Cauldron','','','',0.8706,4,10,2066,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(630887,2,4032,'Venture Co. Ledger','','','',1.5,0,29564,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(650929,3,4431,'The Lost Magic of the Runemasters','','','',1.5,93,140820,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,160394,0,0,4104,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(656100,3,88154,'Blade of House Perenolde','','','',1.25,93,141437,0,0,0,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,4098,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(656101,3,522,'Royal Aegis of Perenolde','','','',1.25,93,141438,0,0,0,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,4098,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(657390,3,677,'Liferoot','','','',0.9,4522,1730,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,158458,0,0,4097,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(657572,0,441,'Secret Door','','','',1.0,0,85,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(657574,0,443,'High Inquisitor''s Door','','','',1.0,0,85,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(657575,0,1207,'Chapel Door','','','',1.0,0,299,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(657692,7,91,'Chair','','','',1.0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(657693,7,91,'Chair','','','',1.0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(657694,7,91,'Chair','','','',1.0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(657695,7,91,'Chair','','','',1.0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(657696,7,91,'Chair','','','',1.0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(657697,7,91,'Chair','','','',1.0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(657698,7,91,'Chair','','','',1.0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(657699,7,91,'Chair','','','',1.0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(657700,7,91,'Chair','','','',1.0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(657701,7,91,'Chair','','','',1.0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(657702,7,91,'Chair','','','',1.0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(657703,7,91,'Chair','','','',1.0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(657704,7,91,'Chair','','','',1.0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(657705,7,91,'Chair','','','',1.0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(657706,7,91,'Chair','','','',1.0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(657707,7,91,'Chair','','','',1.0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(657708,7,91,'Chair','','','',1.0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(657709,7,91,'Chair','','','',1.0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(657710,7,91,'Chair','','','',1.0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(657711,7,91,'Chair','','','',1.0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(657712,7,91,'Chair','','','',1.0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(657713,7,91,'Chair','','','',1.0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(657714,7,91,'Chair','','','',1.0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(657715,7,91,'Chair','','','',1.0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(657716,7,91,'Chair','','','',1.0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(657717,7,91,'Chair','','','',1.0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(657718,7,91,'Chair','','','',1.0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(657719,7,91,'Chair','','','',1.0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(657720,7,91,'Chair','','','',1.0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(657721,0,444,'Herod''s Door','','','',1.06,0,299,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(657722,1,295,'Lever','','','',1.0,0,0,196608,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(657723,7,91,'Fine Chair','','','',1.0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(657724,7,91,'Fine Chair','','','',1.0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(657725,7,91,'Fine Chair','','','',1.0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(657726,9,214,'Arellas Fireleaf','','','',1.0,2151,0,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(657727,9,214,'Admiral Barean Westwind','','','',1.0,2152,0,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(657728,9,214,'Dorgar Stoenbrow','','','',1.0,2153,0,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(657729,9,214,'Fellari Swiftarrow','','','',1.0,2171,0,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(657730,9,214,'Ferren Marcus','','','',1.0,2172,0,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(657731,9,214,'Harthal Truesight','','','',1.0,2173,0,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(657732,9,214,'Holia Sunshield','','','',1.0,2174,0,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(657733,9,214,'Invar One-Arm','','','',1.0,2175,0,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(657734,9,214,'Orman of Stromgarde','','','',1.0,2176,0,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(657735,9,214,'Valea Twinblades','','','',1.0,2177,0,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(657736,9,214,'Yana Bloodspear','','','',1.0,2178,0,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(665153,3,128240,'Drum of Crude Oil','','','',1.0,43,142337,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4097,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(670348,3,696,'Homebrew Hops','','','',0.6,43,142726,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4097,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(673054,5,6073,'Hanging Webs','','','',1.75,0,0,0,0,0,0,5793,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(673056,5,129430,'Webs','','','',2.0,0,0,0,0,0,0,5793,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(676051,3,130541,'Ancient Heirloom','','','',1.0,57,143575,1,0,1,1,0,0,0,0,0,0,0,0,0,0,0,162546,0,0,4096,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(707060,1,295,'Lever','','','',1.0,0,0,3000,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(708078,3,134820,'Fragmented Sentry','','','',1.4,0,145374,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,167240,0,0,4097,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(716736,5,211,'Rock','','','',1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888),
(612130,8,125481,'Arcane Salvager','','','',1.0,2256,10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70938);
INSERT IGNORE INTO `gameobject_questitem` (`GameObjectEntry`,`Idx`,`ItemId`,`VerifiedBuild`) VALUES
(424002,0,216617,70888),
(556653,0,3659,70888),
(650929,0,273169,70888),
(656100,0,275635,70888),
(656101,0,275636,70888),
(665153,0,277986,70888),
(670348,0,279389,70888),
(708078,0,275997,70888);

-- 2. Quest givers and turn-ins players used on live that our quests lack (the quests and NPCs/objects exist).
-- 79360 Elemental Aid
INSERT IGNORE INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (4722,79360,70888);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry`=4722;
-- 97287 Shrewd Negotiations
INSERT IGNORE INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (269127,97287,70888);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry`=269127;

-- 3. Quest objectives whose amount is different on live (same target).
UPDATE `quest_objectives` SET `Amount`=6 WHERE `ID`=90035050 AND `QuestID`=3505 AND `ObjectID`=6199; -- 3505 Betrayed: live 6, was 10
UPDATE `quest_objectives` SET `Amount`=6 WHERE `ID`=90035051 AND `QuestID`=3505 AND `ObjectID`=6198; -- 3505 Betrayed: live 6, was 10

-- 4. Quests whose story or objective line is different on live (not only a placeholder like $1oa or a line break).
-- 3505 Betrayed
UPDATE `quest_template` SET `QuestDescription`='This camp used to be a dozen warriors strong, $n. Now, they are all dead.\n\nThat mage, Rimtori, has slain them all. She played Belgrom like a lute; claiming Azshara would hold great riches... powerful items.\n\nBelgrom sent us to protect her, and said we would be rewarded. Well, look who''s the fool--we were slaughtered.\n\nThe blood elves are camped along the southern bluffs on the northern peninsula. Kill every one you see. Then, find the source of Rimtori''s power so we can exact our revenge.' WHERE `ID`=3505;
-- 3517 Stealing Knowledge
UPDATE `quest_template` SET `QuestDescription`='I admit, $n, I''ve made the most of my situation in Azshara. Belgrom''s punishment has had its share of benefits.\n\nBefore I left, I did some research and you would be surprised how many valuable items are lying around.\n\nThere are tablets throughout the Ruins of Eldarath to the east that I need. All four are named after highborne wizards. Get them for me and we''ll talk some more.', `LogDescription`='Find the Tablet of Beth''Amara, the Tablet of Jin''yael, the Tablet of Markri, and the Tablet of Sael''hai for Jediga in Valormok.' WHERE `ID`=3517;
-- 6403 The Great Masquerade
UPDATE `quest_template` SET `LogDescription`='Follow Reginald Windsor through Stormwind. Protect him from harm!\n\nSpeak to Squire Rowe if you need to contact Reginald Windsor again.' WHERE `ID`=6403;
-- 7790 River Ends
UPDATE `quest_template` SET `QuestDescription`='A grisly scene, these two elves appear to have died locked in combat to the end. What could have brought such viciousness to their normally reserved demeanor?\n\nTheir bags and equipment are strewn along the shore. Was it a deal gone bad? A rival''s ambush?\n\nSearch the source of the river for clues to the demise that was washed downstream.', `LogDescription`='Look for the cause of the Skyborne struggle along Thondroril River.' WHERE `ID`=7790;
-- 7873 Vanquish the Invaders!
UPDATE `quest_template` SET `QuestDescription`='Beyond this tunnel you will find a field of strife and turmoil, young $c. The Horde continue to decimate our sacred forest, cutting down the evergreen foliage to power their machines of war.\n\nEnter Warsong Gulch and defend Silverwing Hold. Push back the invading Horde forces!\n\nDo this, and earn a talisman of merit.  Bring me such a talisman, $n, and I shall reward you.' WHERE `ID`=7873;
-- 8080 Arathi Basin Resources!
UPDATE `quest_template` SET `QuestDescription`='War must be fought with soldiers, any soldier will tell you.  They''ll also say that a battle fought with poor gear or on an empty stomach is lost before it starts!\n\nThat is why Arathi Basin is important.  There are key areas in the basin that hold essential resources.  Metals, weapons, food, lumber - all are needed, and all can be gained there.\n\nThat is what I want from you, $n.  Enter Arathi Basin, win the battle by holding more bases than the enemy, and return to me with a crate of resources.', `LogDescription`='Win the battle for Arathi Basin, get an Arathi Resource Crate, and return it to Sergeant Maclear at Refuge Pointe.' WHERE `ID`=8080;
-- 8123 Cut Arathor Supply Lines
UPDATE `quest_template` SET `QuestDescription`='The League of Arathor is sparing no expense in their move to retake Arathi.  They, and all the races of the Alliance, now stream to this distant region, intent on expanding their hold from Refuge Pointe.  We must stop them, and the best means to stop them is to take their supplies.\n\nYou can help us, $n.  Enter Arathi Basin, known for its rich mines, fertile land and skilled craftsman.  Capture and control every base you can, win the battle, and return to me with the resources you gain.', `LogDescription`='Win the battle for Arathi Basin, get an Arathi Resource Crate, and return it to Deathstalker Mortis at Hammerfall.' WHERE `ID`=8123;
-- 8152 Rapid Escape
UPDATE `quest_template` SET `QuestDescription`='The volume of water flowing across the rocks below the falls makes it easy to lose your footing. Its source must be the violently coursing rapids pouring into the Plaguelands.\n\nDistinctly elvish regalia and equipment seem to be scattered amidst the watery death.\n\nYou take the silver-trimmed scrap of dark cloth and the broken elven weapon hilt in your pack. Somebody at Light''s Hope Chapel might know more about elf activity in these lands.', `LogDescription`='Travel to Light''s Hope Chapel and ask somebody about the waterlogged clues you found.' WHERE `ID`=8152;
-- 8160 Cut Arathor Supply Lines
UPDATE `quest_template` SET `QuestDescription`='The League of Arathor is sparing no expense in their move to retake Arathi.  They, and all the races of the Alliance, now stream to this distant region, intent on expanding their hold from Refuge Pointe.  We must stop them, and the best means to stop them is to take their supplies.\n\nYou can help us, $n.  Enter Arathi Basin, known for its rich mines, fertile land and skilled craftsman.  Capture and control every base you can, win the battle, and return to me with the resources you gain.', `LogDescription`='Win the battle for Arathi Basin, get an Arathi Resource Crate, and return it to Deathstalker Mortis at Hammerfall.' WHERE `ID`=8160;
-- 8367 For Great Honor
UPDATE `quest_template` SET `LogDescription`='Bring 3 Alterac Valley Marks of Honor, 3 Arathi Basin Marks of Honor, 3 Warsong Gulch Marks of Honor, and 3 Darkspear Islands Marks of Honor to a Horde Warbringer outside the battlegrounds.' WHERE `ID`=8367;
-- 8371 Concerted Efforts
UPDATE `quest_template` SET `LogDescription`='Bring 3 Alterac Valley Marks of Honor, 3 Arathi Basin Marks of Honor, 3 Warsong Gulch Marks of Honor, and 3 Darkspear Islands Marks of Honor to an Alliance Brigadier General outside the battlegrounds.' WHERE `ID`=8371;
-- 94413 A Magical Affront
UPDATE `quest_template` SET `QuestDescription`='The recent emergence of the leylines on the surface of Zephras has been profound for our order. We have more direct and tangible access to the energies that permeate this place and it has increased our understanding of said magic greatly.\n\nThe Windshapers, however, view these emergences as scars on the land that must be "healed". This is an affront to our order and is something we simply cannot abide.\n\nGo to the leyline in the forest to the southwest and drive off the Windshapers you find there.' WHERE `ID`=94413;

-- 5. Trainer spells live teaches at a different level (apprentice professions at 1, druid Primal Bite).
UPDATE `trainer_spell` SET `ReqLevel`=1 WHERE `TrainerId`=1002998 AND `SpellId`=2018; -- Apprentice Blacksmith, was 5
