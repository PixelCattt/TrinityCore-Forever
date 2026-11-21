-- Voldemar's "bugs 9" (Discord bug report, 2026-11-20), two more items.
-- 1. Brewer's Trade (98071, Brewmeister Bilger 2705, Southshore) could not be taken: our world had its Russian text, XP and the
--    credit NPC (2026_11_08_41, 2026_11_08_80, 2026_11_10_44) but never the quest itself, its objectives or the hops to loot.
--    Built from Wowhead Forever (quest, item 279388, object 670348; read 2026-11-20) and the client data (build 70685):
--    - provided item 279390 Case of Fallrook Varietal; its spell 1306695 gives the kill credit 270426 (objective 1) when used;
--    - objective 2: 279389 Sack of Homebrew Hops from the Homebrew Hops (670348, quest loot 142726, template from EG Link 2026_11_14_75);
--    - reward 279388 Brewer's Bracers (item in our hotfixes since 2026_10_01_02), 2,200 XP (difficulty 5 at level 27, 2026_11_08_80),
--      no money, not sharable, level 27, required 23, Alliance.
--    The case can be used only by the Dun Garok fireplace ("leave it with 'em by their gatherin' fireplace at the bottom of their
--    fort"): within 15 yd of its Dwarven Fire, the radius of the spell's own area effect. INFERRED: live may check this some other way.
--    Homebrew Hops: Wowhead pins 4 spots (71.8,81.7; 72,80.4; 72,80.5; 72.9,80.3), and players say it "can spawn in the side rooms
--    just before you go down the stairs" or "between the two staircases" behind the fireplace, so one sack at a time from 3 spots
--    (the two 72,80.x pins are one spot). Heights from the PC's ground heights on dev: the bottom floor (24.35) for the spot by the
--    fireplace and the floor above it (39.35) for the two side rooms (INFERRED which floor of the several there).
--    Hillsbrad pins to world: x = 400 - 21.3333 * y%, y = 1066.667 - 32 * x% (Bilger: 52.1,58.7 vs Wowhead 52,58.6).
--    Objective ids are ours (live ids unknown); reward text is a placeholder (VerifiedBuild -1), as for 98059.
-- 2. Eagle's Fist (79975) / This Must Be The Place (79976), Thandol Span, Arathi side: the Messenger Bag hung 0.30 yd above the
--    floor (90.71, floor 90.41 by the PC's ground height) and the Hastily Rolled-Up Satchel 0.12 yd (90.50, floor 90.38). Both
--    put on the floor. Their x,y stay: Wowhead pins both at 22.4-22.5, 24.2, the same room. (The live spots in the room are not
--    sniffed; the crates and the Burnt Page already stand on the floor.)
-- Safe to run again.
SET NAMES utf8mb4;

-- 1. Brewer's Trade
DELETE FROM `quest_template` WHERE `ID`=98071;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestPackageID`,`ContentTuningID`,`QuestSortID`,`QuestInfoID`,`SuggestedGroupNum`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardBonusMoney`,`RewardSpell`,`StartItem`,`Flags`,`AllowableRaces`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`RewardItem1`,`RewardAmount1`,`VerifiedBuild`) VALUES
(98071,2,0,0,267,0,0,0,5,1,0,1,0,0,279390,0,4294967373,'Brewer''s Trade','Deliver the bottles of Fallrook Varietal to Dun Garok in southeast Hillsbrad Foothills, and bring back a sack of their Homebrew Hops.','Worked a bit o'' a trade with the Dun Garok brew-kin. We''re not the only ones missin'' the vineyards of the Fallrook family, it seems! Most o'' the best bottled years are long since drank, but we do have cases of the wine still in the cellars.$B$BBring this case of Fallrook Varietal to Dun Garok in the southeast and leave it with ''em by their gatherin'' fireplace at the bottom of their fort.$B$BIn return, carry a sack o'' the Homebrew Hops back with ye.$B$BThat keep is the closest thing to home around here!','','',279388,1,-1);
DELETE FROM `quest_objectives` WHERE `QuestID`=98071;
DELETE FROM `quest_objectives` WHERE `ID` IN (9807100,9807101);
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(9807100,98071,0,0,0,270426,1,0,0,0,0,0,1,'Fallrook Varietal delivered to Dun Garok',-1),
(9807101,98071,1,1,1,279389,1,0,0,0,0,0,1,'',-1);
DELETE FROM `quest_template_addon` WHERE `ID`=98071;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`,`ProvidedItemCount`) VALUES (98071,0,0,0,1);
DELETE FROM `quest_request_items` WHERE `ID`=98071;
DELETE FROM `quest_offer_reward` WHERE `ID`=98071;
INSERT INTO `quest_offer_reward` (`ID`,`RewardText`,`VerifiedBuild`) VALUES (98071,'Well done, $n. Thank you.',-1);
DELETE FROM `quest_classic_money` WHERE `ID`=98071;
DELETE FROM `quest_classic_level` WHERE `ID`=98071;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (98071,27,23,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=98071;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (98071,2,27);
DELETE FROM `creature_queststarter` WHERE `quest`=98071;
DELETE FROM `creature_questender` WHERE `quest`=98071;
DELETE FROM `gameobject_queststarter` WHERE `quest`=98071;
DELETE FROM `gameobject_questender` WHERE `quest`=98071;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (2705,98071,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (2705,98071,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry`=2705;
-- Russian text: 2026_11_10_44 had it, but only writes a locale row where the quest exists
DELETE FROM `quest_template_locale` WHERE `ID`=98071 AND `locale`='ruRU';
INSERT INTO `quest_template_locale` (`ID`,`locale`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`PortraitGiverText`,`PortraitGiverName`,`PortraitTurnInText`,`PortraitTurnInName`,`QuestCompletionLog`,`VerifiedBuild`) VALUES
(98071,'ruRU','Промысел пивовара','Отнесите бутылки с фолрукским сортовым вином в Дун Гарок в юго-восточной части предгорий Хилсбрада и принесите назад мешок их домашнего хмеля.','Я немножко торгую с коллегами в Дун Гароке. Похоже, не только мы скучаем по виноградникам семьи Фолрук! Большую часть готового вина лучших годов уже выпили, но у нас еще есть несколько ящиков в погребах.\n\nОтнеси этот ящик фолрукского сортового в Дун Гарок на юго-востоке и оставь у их очага на месте сбора, что у подножия крепости.\n\nВзамен принеси назад мешок домашнего хмеля.\n\nЭта крепость – самое похожее на дом место в этих землях!','','','','','','',70862);

-- the case works only by the Dun Garok fireplace (any of its three Dwarven Fire objects, all at -1292.5 -1218.9 23.29)
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry`=1306695;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(17,0,1306695,0,0,30,0,61038,15,0,0,0,0,'','Case of Fallrook Varietal (1306695): only by the Dun Garok fireplace'),
(17,0,1306695,0,1,30,0,61037,15,0,0,0,0,'','Case of Fallrook Varietal (1306695): only by the Dun Garok fireplace'),
(17,0,1306695,0,2,30,0,61039,15,0,0,0,0,'','Case of Fallrook Varietal (1306695): only by the Dun Garok fireplace');

-- the hops: quest loot, and one sack at a time in one of 3 spots
DELETE FROM `gameobject_loot_template` WHERE `Entry`=142726 AND `Item`=279389;
INSERT INTO `gameobject_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(142726,0,279389,100,1,1,0,1,1,'Homebrew Hops - Sack of Homebrew Hops (Brewer''s Trade 98071)');
DELETE FROM `pool_members` WHERE `type`=1 AND `spawnId` IN (67034800,67034801,67034802);
DELETE FROM `gameobject` WHERE `guid` IN (67034800,67034801,67034802);
INSERT INTO `gameobject` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(67034800,670348,0,0,0,'0',0,0,0,-1,-1316.25,-1237.30,24.35,0,0,0,0,1,120,255,1,'',NULL,0),
(67034801,670348,0,0,0,'0',0,0,0,-1,-1342.90,-1231.00,39.35,0,0,0,0,1,120,255,1,'',NULL,0),
(67034802,670348,0,0,0,'0',0,0,0,-1,-1313.10,-1266.10,39.35,0,0,0,0,1,120,255,1,'',NULL,0);
DELETE FROM `pool_template` WHERE `entry`=6703480;
INSERT INTO `pool_template` (`entry`,`max_limit`,`description`) VALUES (6703480,1,'Homebrew Hops in Dun Garok (Brewer''s Trade 98071)');
INSERT INTO `pool_members` (`type`,`spawnId`,`poolSpawnId`,`chance`,`description`) VALUES
(1,67034800,6703480,0,'Homebrew Hops by the Dun Garok fireplace'),
(1,67034801,6703480,0,'Homebrew Hops in a Dun Garok side room'),
(1,67034802,6703480,0,'Homebrew Hops in a Dun Garok side room');

-- map markers (Hillsbrad Foothills, UiMap 1424): turn-in at Bilger, the fireplace, the hops spots (INFERRED shapes)
DELETE FROM `quest_poi` WHERE `QuestID`=98071;
INSERT INTO `quest_poi` (`QuestID`,`BlobIndex`,`Idx1`,`ObjectiveIndex`,`QuestObjectiveID`,`QuestObjectID`,`MapID`,`UiMapID`,`Priority`,`Flags`,`WorldEffectID`,`PlayerConditionID`,`NavigationPlayerConditionID`,`SpawnTrackingID`,`AlwaysAllowMergingBlobs`,`VerifiedBuild`) VALUES
(98071,0,0,-1,0,0,0,1424,0,0,0,0,0,0,0,0),
(98071,0,1,0,9807100,270426,0,1424,0,0,0,0,0,0,0,0),
(98071,0,2,1,9807101,279389,0,1424,0,0,0,0,0,0,0,0);
DELETE FROM `quest_poi_points` WHERE `QuestID`=98071;
INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`,`Idx2`,`X`,`Y`,`Z`,`VerifiedBuild`) VALUES
(98071,0,0,-853,-602,5,0),
(98071,1,0,-1282,-1219,26,0),(98071,1,1,-1292,-1209,26,0),(98071,1,2,-1303,-1219,26,0),(98071,1,3,-1292,-1229,26,0),
(98071,2,0,-1308,-1222,24,0),(98071,2,1,-1352,-1222,39,0),(98071,2,2,-1352,-1240,39,0),(98071,2,3,-1320,-1276,39,0),(98071,2,4,-1304,-1276,39,0),(98071,2,5,-1304,-1240,24,0);

-- 2. Eagle's Fist: the bag and the satchel on the floor
UPDATE `gameobject` SET `position_z`=90.41 WHERE `guid`=40691800 AND `id`=406918;
UPDATE `gameobject` SET `position_z`=90.38 WHERE `guid`=42400600 AND `id`=424006;
