-- Six more WoW Forever quests our world lacked: Toil and Trouble (86925), A Lost Memento (92070), Bait the Beast (93444),
-- Partially Digested Collar (93568), Twilight No More! (95427) and An Earnest Proposition (97411). 2026_11_21_91 left them
-- out because an item or NPC they need was not in our world yet; the quest-item drops and NPC spawns of 2026_11_20_81 and
-- 2026_11_20_93 now give them (every giver, ender, kill target and item checked again). Also Icy Veins' turn-in and
-- progress words for quests our world has without them (most came in with the 2026_11_20 and 2026_11_21 EG Link quests).
-- Data from Everlake (GPL-3.0), commit cf07dad, files 2026_11_19_984, 986, 989, 991, 994 and 996 (quests: EG Link's record of
-- the live client's quest records, Efficient Games, https://efficient.games, CC BY 4.0, folder 70959; givers and enders from
-- QuestieDB, Questie team, GPL-3.0, and Wowhead's and Icy Veins' WoW Forever databases) and its Forge imports 196, 200, 206 and
-- 210 (texts from Icy Veins' WoW Forever database, db.icy-veins.com/wow-forever). Changed: only quests our world can run, checked
-- against our world and written as our own rows. Not checked in game.
-- Everything goes in only where missing. Safe to run more than once.

DROP TEMPORARY TABLE IF EXISTS `forever_q52_quest_template`;
CREATE TEMPORARY TABLE `forever_q52_quest_template` SELECT `ID`,`RewardItem1`,`RewardAmount1`,`ItemDrop1`,`ItemDropQuantity1`,`RewardItem2`,`RewardAmount2`,`ItemDrop2`,`ItemDropQuantity2`,`RewardItem3`,`RewardAmount3`,`ItemDrop3`,`ItemDropQuantity3`,`RewardItem4`,`RewardAmount4`,`ItemDrop4`,`ItemDropQuantity4`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`RewardChoiceItemID5`,`RewardChoiceItemQuantity5`,`RewardChoiceItemID6`,`RewardChoiceItemQuantity6`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`RewardFactionCapIn1`,`RewardFactionID2`,`RewardFactionValue2`,`RewardFactionOverride2`,`RewardFactionCapIn2`,`RewardFactionID3`,`RewardFactionValue3`,`RewardFactionOverride3`,`RewardFactionCapIn3`,`RewardFactionID4`,`RewardFactionValue4`,`RewardFactionOverride4`,`RewardFactionCapIn4`,`RewardFactionID5`,`RewardFactionValue5`,`RewardFactionOverride5`,`RewardFactionCapIn5`,`RewardCurrencyID1`,`RewardCurrencyQty1`,`RewardCurrencyID2`,`RewardCurrencyQty2`,`RewardCurrencyID3`,`RewardCurrencyQty3`,`RewardCurrencyID4`,`RewardCurrencyQty4`,`QuestType`,`QuestInfoID`,`RewardNextQuest`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`QuestSortID`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardSpell`,`AllowableRaces`,`AcceptedSoundKitID`,`CompleteSoundKitID`,`Expansion`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog` FROM `quest_template` WHERE 0;
INSERT INTO `forever_q52_quest_template` (`ID`,`RewardItem1`,`RewardAmount1`,`ItemDrop1`,`ItemDropQuantity1`,`RewardItem2`,`RewardAmount2`,`ItemDrop2`,`ItemDropQuantity2`,`RewardItem3`,`RewardAmount3`,`ItemDrop3`,`ItemDropQuantity3`,`RewardItem4`,`RewardAmount4`,`ItemDrop4`,`ItemDropQuantity4`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`RewardChoiceItemID5`,`RewardChoiceItemQuantity5`,`RewardChoiceItemID6`,`RewardChoiceItemQuantity6`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`RewardFactionCapIn1`,`RewardFactionID2`,`RewardFactionValue2`,`RewardFactionOverride2`,`RewardFactionCapIn2`,`RewardFactionID3`,`RewardFactionValue3`,`RewardFactionOverride3`,`RewardFactionCapIn3`,`RewardFactionID4`,`RewardFactionValue4`,`RewardFactionOverride4`,`RewardFactionCapIn4`,`RewardFactionID5`,`RewardFactionValue5`,`RewardFactionOverride5`,`RewardFactionCapIn5`,`RewardCurrencyID1`,`RewardCurrencyQty1`,`RewardCurrencyID2`,`RewardCurrencyQty2`,`RewardCurrencyID3`,`RewardCurrencyQty3`,`RewardCurrencyID4`,`RewardCurrencyQty4`,`QuestType`,`QuestInfoID`,`RewardNextQuest`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`QuestSortID`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardSpell`,`AllowableRaces`,`AcceptedSoundKitID`,`CompleteSoundKitID`,`Expansion`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`) VALUES
(95427,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2782,5,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,2,1,95418,0,36700168,0,0,0,16591,5,1.0,0,12261800583900083122,890,878,-2,'Twilight No More!','Kill Chogg''Zac in the Sunnyglade cave and collect their heads for Clubtoe.','Clubtoe friends... dead? Why?\r\n\r\nThis Chogg''Zac fault! Dey say they make ogres strong! They lie!!\r\n\r\nNo more smashing rocks! Tiny creature help Clubtoe smash Chogg''zac stupid heads instead!','',''),
(97411,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,226985,1,226977,1,226970,1,0,0,0,0,0,0,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,2,81,0,0,264,0,0,0,1637,5,2.0,0,12261800583900083122,890,878,-2,'An Earnest Proposition','Acquire 15 Silithus Venom Samples and 20 gold and bring them along with a set of Lightforge Bracers to Mokvar in Orgrimmar.','Hail, $c! I can tell by your demeanor that you''ve seen and done much in this world.  Yet I''m willing to wager you haven''t seen a piece of armor like this.$B$BPerform a small favor for me and I''ll be willing to trade it to you for an ordinary set of bracers.$B$BI''m in need of a sizeable sample of venom drawn from the spiders and scorpions that inhabit Silithus.  Bring this to me along with a few gold coins and I''ll perform the exchange.','',''),
(93444,0,0,274151,1,0,0,0,0,0,0,0,0,0,0,0,0,275708,1,275711,1,0,0,0,0,0,0,0,0,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,2,1,0,0,131080,0,0,0,616,6,1.0,0,18446744073709551615,890,878,-2,'Bait the Beast','Kill a Nightsaber Guardian, then bait out and kill Ghansurok using the Nightsaber Guardian haunch on the northern ridge of the summit.\r\n\r\nReturn with the heart of the chimaera.','The most vicious fel chimaera of Hyjal is known as Ghansurok. It likes to swoop in and prey on wildlife caught out of their burrows. Not only that, it''s making hippogryph travel in and out of Hyjal more stressful than usual!\r\n\r\nFirst, hunt down one of the Nightsabers hiding in the Summit''s shadows. Next, place meat from the fallen cat somewhere on the northern ridge where chimaeras feed.\r\n\r\nLure Ghansurok towards it. Slay the beast and return with its heart. Marn will study it to help heal Hyjal.','',''),
(93568,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,2,0,0,0,36700160,0,0,0,16651,5,1.0,0,18446744073709551615,890,878,-2,'Partially Digested Collar','Return the Partially Digested Collar to someone who knows about it. Presumably, they can be found in or near Shen''dralas in Desolace.','<You hold a grimy collar retrieved from the belly of a slain creature. The material is of a high-quality leather, clearly stitched with care.\r\n\r\nA tag dangles from a corroded buckle. You swipe away the gunk and can see Thalassian text, though the letters are stylized beyond readability, perhaps even to those familiar with the language.\r\n\r\nNow, you are presented with a choice. Do you disregard this and move on with your life, or do you attempt the impossible and seek to bring closure to its owner?>','',''),
(92070,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,279893,1,0,0,0,0,0,0,0,0,0,0,576,5,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,2,81,0,0,36700416,0,0,0,16554,5,2.0,0,18446744073709551615,890,878,-2,'A Lost Memento','Find the owner of the Feathered Charm Necklace.','The necklace is adorned with miscellaneous charms: scraps of feathers, acorn shells, and colorful pebbles. Its leather strap is torn. The ornamentation suggests it belonged to a Furbolg, while its small size and rough quality indicate a child''s handiwork.\r\n\r\nThere''s a chance the necklace is of some sentimental value to one of the Blackmaw. It may be good to find the owner and return it.','',''),
(86925,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,576,5,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,2,0,86926,0,36700424,0,0,0,16,5,1.0,0,18446744073709551615,890,878,-2,'Toil and Trouble','Find a Legashi Firewater Recipe from satyr in the Legashi Encampment.','It appears this cauldron could be used to brew the firewater that Elder Bramblesnap is after.\r\n\r\nIf only you knew how. Surely, one of the satyr in the Legashi Encampment must carry a recipe.','','');
INSERT INTO `quest_template` (`ID`,`RewardItem1`,`RewardAmount1`,`ItemDrop1`,`ItemDropQuantity1`,`RewardItem2`,`RewardAmount2`,`ItemDrop2`,`ItemDropQuantity2`,`RewardItem3`,`RewardAmount3`,`ItemDrop3`,`ItemDropQuantity3`,`RewardItem4`,`RewardAmount4`,`ItemDrop4`,`ItemDropQuantity4`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`RewardChoiceItemID5`,`RewardChoiceItemQuantity5`,`RewardChoiceItemID6`,`RewardChoiceItemQuantity6`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`RewardFactionCapIn1`,`RewardFactionID2`,`RewardFactionValue2`,`RewardFactionOverride2`,`RewardFactionCapIn2`,`RewardFactionID3`,`RewardFactionValue3`,`RewardFactionOverride3`,`RewardFactionCapIn3`,`RewardFactionID4`,`RewardFactionValue4`,`RewardFactionOverride4`,`RewardFactionCapIn4`,`RewardFactionID5`,`RewardFactionValue5`,`RewardFactionOverride5`,`RewardFactionCapIn5`,`RewardCurrencyID1`,`RewardCurrencyQty1`,`RewardCurrencyID2`,`RewardCurrencyQty2`,`RewardCurrencyID3`,`RewardCurrencyQty3`,`RewardCurrencyID4`,`RewardCurrencyQty4`,`QuestType`,`QuestInfoID`,`RewardNextQuest`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`QuestSortID`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardSpell`,`AllowableRaces`,`AcceptedSoundKitID`,`CompleteSoundKitID`,`Expansion`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`) SELECT `s`.`ID`,`s`.`RewardItem1`,`s`.`RewardAmount1`,`s`.`ItemDrop1`,`s`.`ItemDropQuantity1`,`s`.`RewardItem2`,`s`.`RewardAmount2`,`s`.`ItemDrop2`,`s`.`ItemDropQuantity2`,`s`.`RewardItem3`,`s`.`RewardAmount3`,`s`.`ItemDrop3`,`s`.`ItemDropQuantity3`,`s`.`RewardItem4`,`s`.`RewardAmount4`,`s`.`ItemDrop4`,`s`.`ItemDropQuantity4`,`s`.`RewardChoiceItemID1`,`s`.`RewardChoiceItemQuantity1`,`s`.`RewardChoiceItemID2`,`s`.`RewardChoiceItemQuantity2`,`s`.`RewardChoiceItemID3`,`s`.`RewardChoiceItemQuantity3`,`s`.`RewardChoiceItemID4`,`s`.`RewardChoiceItemQuantity4`,`s`.`RewardChoiceItemID5`,`s`.`RewardChoiceItemQuantity5`,`s`.`RewardChoiceItemID6`,`s`.`RewardChoiceItemQuantity6`,`s`.`RewardFactionID1`,`s`.`RewardFactionValue1`,`s`.`RewardFactionOverride1`,`s`.`RewardFactionCapIn1`,`s`.`RewardFactionID2`,`s`.`RewardFactionValue2`,`s`.`RewardFactionOverride2`,`s`.`RewardFactionCapIn2`,`s`.`RewardFactionID3`,`s`.`RewardFactionValue3`,`s`.`RewardFactionOverride3`,`s`.`RewardFactionCapIn3`,`s`.`RewardFactionID4`,`s`.`RewardFactionValue4`,`s`.`RewardFactionOverride4`,`s`.`RewardFactionCapIn4`,`s`.`RewardFactionID5`,`s`.`RewardFactionValue5`,`s`.`RewardFactionOverride5`,`s`.`RewardFactionCapIn5`,`s`.`RewardCurrencyID1`,`s`.`RewardCurrencyQty1`,`s`.`RewardCurrencyID2`,`s`.`RewardCurrencyQty2`,`s`.`RewardCurrencyID3`,`s`.`RewardCurrencyQty3`,`s`.`RewardCurrencyID4`,`s`.`RewardCurrencyQty4`,`s`.`QuestType`,`s`.`QuestInfoID`,`s`.`RewardNextQuest`,`s`.`StartItem`,`s`.`Flags`,`s`.`FlagsEx`,`s`.`FlagsEx2`,`s`.`TimeAllowed`,`s`.`QuestSortID`,`s`.`RewardXPDifficulty`,`s`.`RewardXPMultiplier`,`s`.`RewardSpell`,`s`.`AllowableRaces`,`s`.`AcceptedSoundKitID`,`s`.`CompleteSoundKitID`,`s`.`Expansion`,`s`.`LogTitle`,`s`.`LogDescription`,`s`.`QuestDescription`,`s`.`AreaDescription`,`s`.`QuestCompletionLog` FROM `forever_q52_quest_template` `s` WHERE NOT EXISTS (SELECT 1 FROM `quest_template` `x` WHERE `x`.`ID`=`s`.`ID`);
DROP TEMPORARY TABLE IF EXISTS `forever_q52_quest_template`;

DROP TEMPORARY TABLE IF EXISTS `forever_q52_quest_objectives`;
CREATE TEMPORARY TABLE `forever_q52_quest_objectives` SELECT `ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Description` FROM `quest_objectives` WHERE 0;
INSERT INTO `forever_q52_quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Description`) VALUES
(470886,95427,1,0,0,265750,1,32,''),
(470887,95427,1,1,1,265751,1,32,''),
(475882,97411,1,0,2,22381,15,32,''),
(475883,97411,1,1,3,16722,1,32,''),
(475884,97411,8,2,-1,0,200000,32,''),
(472989,93444,0,0,0,264867,1,32,'Ghansurok baited with Nightsaber meat'),
(473078,93444,1,1,1,274162,1,32,''),
(466758,93568,1,0,0,259461,1,32,''),
(464121,92070,1,0,0,249698,1,32,''),
(457571,86925,1,0,0,235645,1,32,'');
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Description`) SELECT `s`.`ID`,`s`.`QuestID`,`s`.`Type`,`s`.`Order`,`s`.`StorageIndex`,`s`.`ObjectID`,`s`.`Amount`,`s`.`Flags`,`s`.`Description` FROM `forever_q52_quest_objectives` `s` WHERE NOT EXISTS (SELECT 1 FROM `quest_objectives` `x` WHERE `x`.`ID`=`s`.`ID`);
DROP TEMPORARY TABLE IF EXISTS `forever_q52_quest_objectives`;

DROP TEMPORARY TABLE IF EXISTS `forever_q52_quest_classic_level`;
CREATE TEMPORARY TABLE `forever_q52_quest_classic_level` SELECT `ID`,`QuestLevel`,`MinLevel`,`MaxLevel` FROM `quest_classic_level` WHERE 0;
INSERT INTO `forever_q52_quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES
(95427,41,36,0),
(97411,60,58,0),
(93444,60,56,0),
(93568,45,35,0),
(92070,55,47,0),
(86925,53,47,0);
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) SELECT `s`.`ID`,`s`.`QuestLevel`,`s`.`MinLevel`,`s`.`MaxLevel` FROM `forever_q52_quest_classic_level` `s` WHERE NOT EXISTS (SELECT 1 FROM `quest_classic_level` `x` WHERE `x`.`ID`=`s`.`ID`);
DROP TEMPORARY TABLE IF EXISTS `forever_q52_quest_classic_level`;

DROP TEMPORARY TABLE IF EXISTS `forever_q52_quest_template_classic`;
CREATE TEMPORARY TABLE `forever_q52_quest_template_classic` SELECT `ID`,`LevelType`,`QuestLevel` FROM `quest_template_classic_level` WHERE 0;
INSERT INTO `forever_q52_quest_template_classic` (`ID`,`LevelType`,`QuestLevel`) VALUES
(95427,2,41),
(97411,2,60),
(93444,2,60),
(93568,2,45),
(92070,2,55),
(86925,2,53);
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) SELECT `s`.`ID`,`s`.`LevelType`,`s`.`QuestLevel` FROM `forever_q52_quest_template_classic` `s` WHERE NOT EXISTS (SELECT 1 FROM `quest_template_classic_level` `x` WHERE `x`.`ID`=`s`.`ID`);
DROP TEMPORARY TABLE IF EXISTS `forever_q52_quest_template_classic`;

DROP TEMPORARY TABLE IF EXISTS `forever_q52_quest_classic_money`;
CREATE TEMPORARY TABLE `forever_q52_quest_classic_money` SELECT `ID`,`RewardMoney`,`RewardMoneyMaxLevel` FROM `quest_classic_money` WHERE 0;
INSERT INTO `forever_q52_quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES
(95427,2500,0),
(97411,-200000,0),
(86925,11156,0);
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) SELECT `s`.`ID`,`s`.`RewardMoney`,`s`.`RewardMoneyMaxLevel` FROM `forever_q52_quest_classic_money` `s` WHERE NOT EXISTS (SELECT 1 FROM `quest_classic_money` `x` WHERE `x`.`ID`=`s`.`ID`);
DROP TEMPORARY TABLE IF EXISTS `forever_q52_quest_classic_money`;

DROP TEMPORARY TABLE IF EXISTS `forever_q52_quest_offer_reward`;
CREATE TEMPORARY TABLE `forever_q52_quest_offer_reward` SELECT `ID`,`RewardText` FROM `quest_offer_reward` WHERE 0;
INSERT INTO `forever_q52_quest_offer_reward` (`ID`,`RewardText`) VALUES
(95427,'Tiny skyborne kill Chogg''Zac?$B$B<Clubtoe lets out a triumphant bellow that echoes through the caves.>$B$BClubtoe done smashing rock for tinies! Clubtoe done losing friends! Me Twilight no more!');
INSERT INTO `quest_offer_reward` (`ID`,`RewardText`) SELECT `s`.`ID`,`s`.`RewardText` FROM `forever_q52_quest_offer_reward` `s` WHERE NOT EXISTS (SELECT 1 FROM `quest_offer_reward` `x` WHERE `x`.`ID`=`s`.`ID`);
DROP TEMPORARY TABLE IF EXISTS `forever_q52_quest_offer_reward`;

DROP TEMPORARY TABLE IF EXISTS `forever_q52_quest_request_items`;
CREATE TEMPORARY TABLE `forever_q52_quest_request_items` SELECT `ID`,`CompletionText` FROM `quest_request_items` WHERE 0;
INSERT INTO `forever_q52_quest_request_items` (`ID`,`CompletionText`) VALUES
(95427,'No more kill friends! Chogg''Zac die today!');
INSERT INTO `quest_request_items` (`ID`,`CompletionText`) SELECT `s`.`ID`,`s`.`CompletionText` FROM `forever_q52_quest_request_items` `s` WHERE NOT EXISTS (SELECT 1 FROM `quest_request_items` `x` WHERE `x`.`ID`=`s`.`ID`);
DROP TEMPORARY TABLE IF EXISTS `forever_q52_quest_request_items`;

DROP TEMPORARY TABLE IF EXISTS `forever_q52_creature_queststarter`;
CREATE TEMPORARY TABLE `forever_q52_creature_queststarter` SELECT `id`,`quest` FROM `creature_queststarter` WHERE 0;
INSERT INTO `forever_q52_creature_queststarter` (`id`,`quest`) VALUES
(260931,95427),
(230317,97411),
(41861,93444);
INSERT INTO `creature_queststarter` (`id`,`quest`) SELECT `s`.`id`,`s`.`quest` FROM `forever_q52_creature_queststarter` `s` WHERE NOT EXISTS (SELECT 1 FROM `creature_queststarter` `x` WHERE `x`.`id`=`s`.`id` AND `x`.`quest`=`s`.`quest`);
DROP TEMPORARY TABLE IF EXISTS `forever_q52_creature_queststarter`;

DROP TEMPORARY TABLE IF EXISTS `forever_q52_creature_questender`;
CREATE TEMPORARY TABLE `forever_q52_creature_questender` SELECT `id`,`quest` FROM `creature_questender` WHERE 0;
INSERT INTO `forever_q52_creature_questender` (`id`,`quest`) VALUES
(260931,95427),
(230317,97411),
(41861,93444),
(255385,93568),
(249855,92070);
INSERT INTO `creature_questender` (`id`,`quest`) SELECT `s`.`id`,`s`.`quest` FROM `forever_q52_creature_questender` `s` WHERE NOT EXISTS (SELECT 1 FROM `creature_questender` `x` WHERE `x`.`id`=`s`.`id` AND `x`.`quest`=`s`.`quest`);
DROP TEMPORARY TABLE IF EXISTS `forever_q52_creature_questender`;

DROP TEMPORARY TABLE IF EXISTS `forever_q52_gameobject_queststarte`;
CREATE TEMPORARY TABLE `forever_q52_gameobject_queststarte` SELECT `id`,`quest` FROM `gameobject_queststarter` WHERE 0;
INSERT INTO `forever_q52_gameobject_queststarte` (`id`,`quest`) VALUES
(506307,86925);
INSERT INTO `gameobject_queststarter` (`id`,`quest`) SELECT `s`.`id`,`s`.`quest` FROM `forever_q52_gameobject_queststarte` `s` WHERE NOT EXISTS (SELECT 1 FROM `gameobject_queststarter` `x` WHERE `x`.`id`=`s`.`id` AND `x`.`quest`=`s`.`quest`);
DROP TEMPORARY TABLE IF EXISTS `forever_q52_gameobject_queststarte`;

DROP TEMPORARY TABLE IF EXISTS `forever_q52_gameobject_questender`;
CREATE TEMPORARY TABLE `forever_q52_gameobject_questender` SELECT `id`,`quest` FROM `gameobject_questender` WHERE 0;
INSERT INTO `forever_q52_gameobject_questender` (`id`,`quest`) VALUES
(506307,86925);
INSERT INTO `gameobject_questender` (`id`,`quest`) SELECT `s`.`id`,`s`.`quest` FROM `forever_q52_gameobject_questender` `s` WHERE NOT EXISTS (SELECT 1 FROM `gameobject_questender` `x` WHERE `x`.`id`=`s`.`id` AND `x`.`quest`=`s`.`quest`);
DROP TEMPORARY TABLE IF EXISTS `forever_q52_gameobject_questender`;

-- Quest givers and enders show their marker; "talk to" targets open a window (gossip), so their objective counts.
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (41861,230317,249855,255385,260931) AND (`npcflag`&2)=0;

-- Turn-in and progress words from Icy Veins' WoW Forever database (db.icy-veins.com/wow-forever), as Everlake's Forge
-- imports 196, 200, 206 and 210 give them: only for quests our world has (or gets above) and has no text for.
DROP TEMPORARY TABLE IF EXISTS `forever_tx52_offer_reward`;
CREATE TEMPORARY TABLE `forever_tx52_offer_reward` SELECT `ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`RewardText`,`VerifiedBuild` FROM `quest_offer_reward` WHERE 0;
INSERT INTO `forever_tx52_offer_reward` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`RewardText`,`VerifiedBuild`) VALUES
(93444,0,0,0,0,0,0,0,0,'The skies and hills will be much safer now. Thank you, $N. We''ve been suffering that poisonous venom for too long.',0),
(92070,0,0,0,0,0,0,0,0,'<The furbolg snatches the necklace, barely acknowledging you. Cradling it in one paw, she runs her other paw over each charm and begins muttering.>$B$BOh...no. No. No! Nama would never have lost her necklace. It was her favorite. She must have...must have...no.$B$B<Before her words nearly devolve into sobs, she composes herself.>$B$BThank you, $R. Better to know the truth of my cub''s fate, I suppose. But please, leave me now. I''d like to be alone.',0),
(93568,0,0,0,0,0,0,0,0,'This belonged to Dahlia, my best friend and favorite feline. Dahlia... I never was creative with names. It fit her though, she was a vibrant, blooming flower in my life.$B$BThe origin of it isn''t very exciting. I was passing by some dahlia flowers in the garden when this little kitten leapt out at me! So playfully menacing. She followed me back to the temple and... that was that!$B$BNo need to stick around while I reminisce. Here''s something for your trouble, thank you for resurfacing some old memories.',0),
(86925,0,0,0,0,0,0,0,0,'Paper in hand, peering over the cauldron, you begin to make sense of the satyr''s scrawled instructions.',0);
INSERT INTO `quest_offer_reward` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`RewardText`,`VerifiedBuild`) SELECT `s`.`ID`,`s`.`Emote1`,`s`.`Emote2`,`s`.`Emote3`,`s`.`Emote4`,`s`.`EmoteDelay1`,`s`.`EmoteDelay2`,`s`.`EmoteDelay3`,`s`.`EmoteDelay4`,`s`.`RewardText`,`s`.`VerifiedBuild` FROM `forever_tx52_offer_reward` `s` WHERE EXISTS (SELECT 1 FROM `quest_template` `q` WHERE `q`.`ID`=`s`.`ID`)
  AND NOT EXISTS (SELECT 1 FROM `quest_offer_reward` `x` WHERE `x`.`ID`=`s`.`ID`);
DROP TEMPORARY TABLE IF EXISTS `forever_tx52_offer_reward`;

DROP TEMPORARY TABLE IF EXISTS `forever_tx52_request_items`;
CREATE TEMPORARY TABLE `forever_tx52_request_items` SELECT `ID`,`EmoteOnComplete`,`EmoteOnIncomplete`,`EmoteOnCompleteDelay`,`EmoteOnIncompleteDelay`,`CompletionText`,`VerifiedBuild` FROM `quest_request_items` WHERE 0;
INSERT INTO `forever_tx52_request_items` (`ID`,`EmoteOnComplete`,`EmoteOnIncomplete`,`EmoteOnCompleteDelay`,`EmoteOnIncompleteDelay`,`CompletionText`,`VerifiedBuild`) VALUES
(93444,0,0,0,0,'Ghansurok is as noxious as it is ferocious. You must not hesitate.',0),
(92070,0,0,0,0,'Do you know where my cub is? Please, tell me something! Anything!',0),
(93568,0,0,0,0,'<Liranne takes the collar and inspects it. She gently cradles the metal tag in her other hand, and flashes a brief smile upon reading it.>',0),
(86925,0,0,0,0,'I need to find that recipe.',0);
INSERT INTO `quest_request_items` (`ID`,`EmoteOnComplete`,`EmoteOnIncomplete`,`EmoteOnCompleteDelay`,`EmoteOnIncompleteDelay`,`CompletionText`,`VerifiedBuild`) SELECT `s`.`ID`,`s`.`EmoteOnComplete`,`s`.`EmoteOnIncomplete`,`s`.`EmoteOnCompleteDelay`,`s`.`EmoteOnIncompleteDelay`,`s`.`CompletionText`,`s`.`VerifiedBuild` FROM `forever_tx52_request_items` `s` WHERE EXISTS (SELECT 1 FROM `quest_template` `q` WHERE `q`.`ID`=`s`.`ID`)
  AND NOT EXISTS (SELECT 1 FROM `quest_request_items` `x` WHERE `x`.`ID`=`s`.`ID`);
DROP TEMPORARY TABLE IF EXISTS `forever_tx52_request_items`;
