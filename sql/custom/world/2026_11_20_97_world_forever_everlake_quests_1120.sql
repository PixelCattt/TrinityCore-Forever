-- Seven WoW Forever quests our world lacked, in Shen'dralas and Riverglades, whose givers, enders, kill targets and quest
-- items are all in our world now (with 2026_11_20_96): Long-Term Solutions (93072), What They've Done to My Peonies (93362),
-- Unchecked Expansion (95122), Might Makes Right (95424), Death to the Executioner (95433), Indiscriminate Purge (95643) and
-- Mana Mania (99258).
-- Data from Everlake (GPL-3.0), commit 0ffaa3d, file 2026_11_19_980, which builds the quests from EG Link (Efficient Games,
-- https://efficient.games, CC BY 4.0: the live client's quest records, folder 70959) and QuestieDB (Questie team, GPL-3.0:
-- givers and enders). Changed: only quests whose NPCs and items our world has; checked against our world and written as our
-- own rows. The other 52 quests of that file wait for NPCs no allowed source describes yet.
-- Everything goes in only where missing. Safe to run more than once.


DROP TEMPORARY TABLE IF EXISTS `forever_bb_quest_template_1120`;
CREATE TEMPORARY TABLE `forever_bb_quest_template_1120` SELECT `ID`,`RewardItem1`,`RewardAmount1`,`ItemDrop1`,`ItemDropQuantity1`,`RewardItem2`,`RewardAmount2`,`ItemDrop2`,`ItemDropQuantity2`,`RewardItem3`,`RewardAmount3`,`ItemDrop3`,`ItemDropQuantity3`,`RewardItem4`,`RewardAmount4`,`ItemDrop4`,`ItemDropQuantity4`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`RewardChoiceItemID5`,`RewardChoiceItemQuantity5`,`RewardChoiceItemID6`,`RewardChoiceItemQuantity6`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`RewardFactionCapIn1`,`RewardFactionID2`,`RewardFactionValue2`,`RewardFactionOverride2`,`RewardFactionCapIn2`,`RewardFactionID3`,`RewardFactionValue3`,`RewardFactionOverride3`,`RewardFactionCapIn3`,`RewardFactionID4`,`RewardFactionValue4`,`RewardFactionOverride4`,`RewardFactionCapIn4`,`RewardFactionID5`,`RewardFactionValue5`,`RewardFactionOverride5`,`RewardFactionCapIn5`,`RewardCurrencyID1`,`RewardCurrencyQty1`,`RewardCurrencyID2`,`RewardCurrencyQty2`,`RewardCurrencyID3`,`RewardCurrencyQty3`,`RewardCurrencyID4`,`RewardCurrencyQty4`,`QuestType`,`QuestInfoID`,`RewardNextQuest`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`QuestSortID`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardSpell`,`AllowableRaces`,`AcceptedSoundKitID`,`CompleteSoundKitID`,`Expansion`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog` FROM `quest_template` WHERE 0;
INSERT INTO `forever_bb_quest_template_1120` (`ID`,`RewardItem1`,`RewardAmount1`,`ItemDrop1`,`ItemDropQuantity1`,`RewardItem2`,`RewardAmount2`,`ItemDrop2`,`ItemDropQuantity2`,`RewardItem3`,`RewardAmount3`,`ItemDrop3`,`ItemDropQuantity3`,`RewardItem4`,`RewardAmount4`,`ItemDrop4`,`ItemDropQuantity4`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`RewardChoiceItemID5`,`RewardChoiceItemQuantity5`,`RewardChoiceItemID6`,`RewardChoiceItemQuantity6`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`RewardFactionCapIn1`,`RewardFactionID2`,`RewardFactionValue2`,`RewardFactionOverride2`,`RewardFactionCapIn2`,`RewardFactionID3`,`RewardFactionValue3`,`RewardFactionOverride3`,`RewardFactionCapIn3`,`RewardFactionID4`,`RewardFactionValue4`,`RewardFactionOverride4`,`RewardFactionCapIn4`,`RewardFactionID5`,`RewardFactionValue5`,`RewardFactionOverride5`,`RewardFactionCapIn5`,`RewardCurrencyID1`,`RewardCurrencyQty1`,`RewardCurrencyID2`,`RewardCurrencyQty2`,`RewardCurrencyID3`,`RewardCurrencyQty3`,`RewardCurrencyID4`,`RewardCurrencyQty4`,`QuestType`,`QuestInfoID`,`RewardNextQuest`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`QuestSortID`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardSpell`,`AllowableRaces`,`AcceptedSoundKitID`,`CompleteSoundKitID`,`Expansion`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`) VALUES
(93072,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,93,0,50000,7,92,0,-250000,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,2,0,93188,0,3145736,0,0,0,16651,5,1.0,0,18446744073709551615,890,878,-2,'Long-Term Solutions','Maintain your reputation with the Magram clan and slay $1oa Outcast Scouts, $2oa Outcast Marauders, and $3oa Outcast Necromancers then return to Hagiak at the Magram Front.','There is a second centaur village out here, to the southwest. That one belongs to the Gelkis. You expect me to send you over just to spill some blood, right? Good. That had best be your first thought, else I would cast doubt on your allegiance to the Magram!\r\n\r\nWhat are you waiting for? Go! Kill!','',''),
(93362,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,2,0,0,0,36700168,0,0,0,16651,5,1.0,0,18446744073709551615,890,878,-2,'What They''ve Done to My Peonies','Cull plants in the Forlorn Garden and then return to Mithera at Shen''dralas.','Please spare the details of how the life may have been twisted there. My heart is broken enough with the loss of my necklace.\r\n\r\nBut while I weep, the plants suffer.\r\n\r\n$n, I would like you to go back to the garden and cull some of the angered flora. Please be swift and merciful; they can feel pain, and they have been hurt enough. If you intend to go hunting for my necklace as well, I would ask you to prioritize that before visiting the gardens again... in the unlikely chance you find it.','',''),
(95122,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2827,5,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,2,0,0,0,36700168,0,0,0,16591,5,1.0,0,18446744073709551615,890,878,-2,'Unchecked Expansion','Kill $1oa Eastsea Raiders and $2oa Eastsea Bombardiers for Wharfmaster Whizzbuzz.','Those Eastsea pirates you whacked, while dangerous, were just the small fries. They''ve got bigger, badder brothers in arms north of here. They ransacked Windstead--took all the plunder they could, then burned it to the ground.\r\n\r\nThey''ve gotta be stopped before their turf gets any farther inland. Thin out their ranks so that doesn''t happen.','',''),
(95424,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2782,5,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,2,0,95417,0,36700168,0,0,0,16591,5,1.0,0,12261800583900083122,890,878,-2,'Might Makes Right','Kill $1oa Twilight Maulers and $2oa Twilight Firecallers for Clugfist in Bolder''ok.','Here ogres value strength and blood.\r\n\r\nWeak ones leave Bolder''ok. Go back to Twilight''s Hammer.\r\n\r\nYou no big. Maybe you strong. Show Clugfist strength and smash weak ogres. If tiny creature can.','',''),
(95433,275011,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2782,6,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,2,1,95424,0,36700168,0,0,0,16591,6,1.0,0,12261800583900083122,890,878,-2,'Death to the Executioner','Collect the Executioner''s Mace from Executioner Morg in the Twilight Shroud for Clugfist in Bolder''ok.','When Clugfist leave Twilight, one ogre stand in way. Morg.\r\n\r\nMorg massive ogre. Nearly as massive as Clugfist. But not massivest. He need tinies to protect him. Clugfist never got fair fight. Now WE no fight fair.\r\n\r\nFind Morg. Bring many tinies with you. Kill him. Take mace back to Clugfist. Then Twilight know they challenge us no more!','','Return to Clugfist in Bolder''ok.'),
(95643,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2826,5,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,2,0,0,0,36700168,0,0,0,16591,5,1.0,0,6130900294268439629,890,878,-2,'Indiscriminate Purge','Kill $1oa Twilight Ritualists and $1oa Empowered Brutes within the caves underneath Sunnyglade.','As Lady Amberhall''s apprentice in the dark arts, I may not look it but I''m usually quite capable of handling things on my own. I did not, however, anticipate an entire cave of void-infused ogres.\r\n\r\nIf you managed to get all the way down here without being captured, you must be powerful yourself. I was not so lucky with those ogres and their masters roaming about. Do the world a favor and kill the hideous beasts. Nothing good comes from a fanatic with a purpose, empowered or otherwise.','',''),
(99258,0,0,286648,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,2,1,0,286648,36700160,0,0,0,16651,6,1.0,0,18446744073709551615,890,878,-2,'Mana Mania','Throw the Depleted Crystal Heart into an Unstable Mana Rift. Return to Historian Biraxas within the temple of Shen''dralas with proof of success or failure.','While sourcing the gems necessary to conjure the elementals is a challenge itself, the bigger concern is whether there is still enough loose mana in Shen''dralas to create them. With this heart, we can confirm once and for all whether we need to begin researching other means of defense.\r\n\r\nFor you, the task is simple. Simply toss this gem into one of those unstable rifts. If we''re lucky, you''ll have a fight on your hands. Don''t feel compelled to hold back, if it works once, it will work again.','','');
INSERT INTO `quest_template` (`ID`,`RewardItem1`,`RewardAmount1`,`ItemDrop1`,`ItemDropQuantity1`,`RewardItem2`,`RewardAmount2`,`ItemDrop2`,`ItemDropQuantity2`,`RewardItem3`,`RewardAmount3`,`ItemDrop3`,`ItemDropQuantity3`,`RewardItem4`,`RewardAmount4`,`ItemDrop4`,`ItemDropQuantity4`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`RewardChoiceItemID5`,`RewardChoiceItemQuantity5`,`RewardChoiceItemID6`,`RewardChoiceItemQuantity6`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`RewardFactionCapIn1`,`RewardFactionID2`,`RewardFactionValue2`,`RewardFactionOverride2`,`RewardFactionCapIn2`,`RewardFactionID3`,`RewardFactionValue3`,`RewardFactionOverride3`,`RewardFactionCapIn3`,`RewardFactionID4`,`RewardFactionValue4`,`RewardFactionOverride4`,`RewardFactionCapIn4`,`RewardFactionID5`,`RewardFactionValue5`,`RewardFactionOverride5`,`RewardFactionCapIn5`,`RewardCurrencyID1`,`RewardCurrencyQty1`,`RewardCurrencyID2`,`RewardCurrencyQty2`,`RewardCurrencyID3`,`RewardCurrencyQty3`,`RewardCurrencyID4`,`RewardCurrencyQty4`,`QuestType`,`QuestInfoID`,`RewardNextQuest`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`QuestSortID`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardSpell`,`AllowableRaces`,`AcceptedSoundKitID`,`CompleteSoundKitID`,`Expansion`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`) SELECT `s`.`ID`,`s`.`RewardItem1`,`s`.`RewardAmount1`,`s`.`ItemDrop1`,`s`.`ItemDropQuantity1`,`s`.`RewardItem2`,`s`.`RewardAmount2`,`s`.`ItemDrop2`,`s`.`ItemDropQuantity2`,`s`.`RewardItem3`,`s`.`RewardAmount3`,`s`.`ItemDrop3`,`s`.`ItemDropQuantity3`,`s`.`RewardItem4`,`s`.`RewardAmount4`,`s`.`ItemDrop4`,`s`.`ItemDropQuantity4`,`s`.`RewardChoiceItemID1`,`s`.`RewardChoiceItemQuantity1`,`s`.`RewardChoiceItemID2`,`s`.`RewardChoiceItemQuantity2`,`s`.`RewardChoiceItemID3`,`s`.`RewardChoiceItemQuantity3`,`s`.`RewardChoiceItemID4`,`s`.`RewardChoiceItemQuantity4`,`s`.`RewardChoiceItemID5`,`s`.`RewardChoiceItemQuantity5`,`s`.`RewardChoiceItemID6`,`s`.`RewardChoiceItemQuantity6`,`s`.`RewardFactionID1`,`s`.`RewardFactionValue1`,`s`.`RewardFactionOverride1`,`s`.`RewardFactionCapIn1`,`s`.`RewardFactionID2`,`s`.`RewardFactionValue2`,`s`.`RewardFactionOverride2`,`s`.`RewardFactionCapIn2`,`s`.`RewardFactionID3`,`s`.`RewardFactionValue3`,`s`.`RewardFactionOverride3`,`s`.`RewardFactionCapIn3`,`s`.`RewardFactionID4`,`s`.`RewardFactionValue4`,`s`.`RewardFactionOverride4`,`s`.`RewardFactionCapIn4`,`s`.`RewardFactionID5`,`s`.`RewardFactionValue5`,`s`.`RewardFactionOverride5`,`s`.`RewardFactionCapIn5`,`s`.`RewardCurrencyID1`,`s`.`RewardCurrencyQty1`,`s`.`RewardCurrencyID2`,`s`.`RewardCurrencyQty2`,`s`.`RewardCurrencyID3`,`s`.`RewardCurrencyQty3`,`s`.`RewardCurrencyID4`,`s`.`RewardCurrencyQty4`,`s`.`QuestType`,`s`.`QuestInfoID`,`s`.`RewardNextQuest`,`s`.`StartItem`,`s`.`Flags`,`s`.`FlagsEx`,`s`.`FlagsEx2`,`s`.`TimeAllowed`,`s`.`QuestSortID`,`s`.`RewardXPDifficulty`,`s`.`RewardXPMultiplier`,`s`.`RewardSpell`,`s`.`AllowableRaces`,`s`.`AcceptedSoundKitID`,`s`.`CompleteSoundKitID`,`s`.`Expansion`,`s`.`LogTitle`,`s`.`LogDescription`,`s`.`QuestDescription`,`s`.`AreaDescription`,`s`.`QuestCompletionLog` FROM `forever_bb_quest_template_1120` `s` WHERE NOT EXISTS (SELECT 1 FROM `quest_template` `x` WHERE `x`.`ID`=`s`.`ID`);
DROP TEMPORARY TABLE IF EXISTS `forever_bb_quest_template_1120`;

DROP TEMPORARY TABLE IF EXISTS `forever_bb_quest_objectives_1120`;
CREATE TEMPORARY TABLE `forever_bb_quest_objectives_1120` SELECT `ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Description` FROM `quest_objectives` WHERE 0;
INSERT INTO `forever_bb_quest_objectives_1120` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Description`) VALUES
(466108,93072,0,0,0,254283,2,32,''),
(466109,93072,0,1,1,254284,6,32,''),
(466110,93072,0,2,2,11559,8,32,''),
(466495,93362,0,0,1,254566,4,32,''),
(466494,93362,0,1,0,254567,4,32,''),
(466496,93362,0,2,2,254572,20,32,''),
(469863,95122,0,0,2,257915,8,32,''),
(469864,95122,0,1,3,257916,8,32,''),
(470556,95424,0,0,1,260968,7,32,''),
(470557,95424,0,1,2,261497,7,32,''),
(470582,95433,1,0,1,269351,1,32,''),
(471123,95643,0,0,1,261711,5,32,''),
(471124,95643,0,1,2,262169,5,32,''),
(479767,99258,0,0,1,276401,1,32,'');
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Description`) SELECT `s`.`ID`,`s`.`QuestID`,`s`.`Type`,`s`.`Order`,`s`.`StorageIndex`,`s`.`ObjectID`,`s`.`Amount`,`s`.`Flags`,`s`.`Description` FROM `forever_bb_quest_objectives_1120` `s` WHERE NOT EXISTS (SELECT 1 FROM `quest_objectives` `x` WHERE `x`.`ID`=`s`.`ID`);
DROP TEMPORARY TABLE IF EXISTS `forever_bb_quest_objectives_1120`;

DROP TEMPORARY TABLE IF EXISTS `forever_bb_quest_classic_level_1120`;
CREATE TEMPORARY TABLE `forever_bb_quest_classic_level_1120` SELECT `ID`,`QuestLevel`,`MinLevel`,`MaxLevel` FROM `quest_classic_level` WHERE 0;
INSERT INTO `forever_bb_quest_classic_level_1120` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES
(93072,43,35,0),
(93362,43,35,0),
(95122,44,38,0),
(95424,41,36,0),
(95433,46,36,0),
(95643,40,36,0),
(99258,43,35,0);
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) SELECT `s`.`ID`,`s`.`QuestLevel`,`s`.`MinLevel`,`s`.`MaxLevel` FROM `forever_bb_quest_classic_level_1120` `s` WHERE NOT EXISTS (SELECT 1 FROM `quest_classic_level` `x` WHERE `x`.`ID`=`s`.`ID`);
DROP TEMPORARY TABLE IF EXISTS `forever_bb_quest_classic_level_1120`;

DROP TEMPORARY TABLE IF EXISTS `forever_bb_quest_template_class_1120`;
CREATE TEMPORARY TABLE `forever_bb_quest_template_class_1120` SELECT `ID`,`LevelType`,`QuestLevel` FROM `quest_template_classic_level` WHERE 0;
INSERT INTO `forever_bb_quest_template_class_1120` (`ID`,`LevelType`,`QuestLevel`) VALUES
(93072,2,43),
(93362,2,43),
(95122,2,44),
(95424,2,41),
(95433,2,46),
(95643,2,40),
(99258,2,43);
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) SELECT `s`.`ID`,`s`.`LevelType`,`s`.`QuestLevel` FROM `forever_bb_quest_template_class_1120` `s` WHERE NOT EXISTS (SELECT 1 FROM `quest_template_classic_level` `x` WHERE `x`.`ID`=`s`.`ID`);
DROP TEMPORARY TABLE IF EXISTS `forever_bb_quest_template_class_1120`;

DROP TEMPORARY TABLE IF EXISTS `forever_bb_quest_classic_money_1120`;
CREATE TEMPORARY TABLE `forever_bb_quest_classic_money_1120` SELECT `ID`,`RewardMoney`,`RewardMoneyMaxLevel` FROM `quest_classic_money` WHERE 0;
INSERT INTO `forever_bb_quest_classic_money_1120` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES
(93072,3000,0),
(95122,3000,0),
(95424,5500,0);
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) SELECT `s`.`ID`,`s`.`RewardMoney`,`s`.`RewardMoneyMaxLevel` FROM `forever_bb_quest_classic_money_1120` `s` WHERE NOT EXISTS (SELECT 1 FROM `quest_classic_money` `x` WHERE `x`.`ID`=`s`.`ID`);
DROP TEMPORARY TABLE IF EXISTS `forever_bb_quest_classic_money_1120`;

DROP TEMPORARY TABLE IF EXISTS `forever_bb_creature_queststarte_1120`;
CREATE TEMPORARY TABLE `forever_bb_creature_queststarte_1120` SELECT `id`,`quest` FROM `creature_queststarter` WHERE 0;
INSERT INTO `forever_bb_creature_queststarte_1120` (`id`,`quest`) VALUES
(253851,93072),
(254578,93362),
(255486,99258),
(255829,95424),
(256831,95643),
(259961,95122),
(260993,95433);
INSERT INTO `creature_queststarter` (`id`,`quest`) SELECT `s`.`id`,`s`.`quest` FROM `forever_bb_creature_queststarte_1120` `s` WHERE NOT EXISTS (SELECT 1 FROM `creature_queststarter` `x` WHERE `x`.`id`=`s`.`id` AND `x`.`quest`=`s`.`quest`);
DROP TEMPORARY TABLE IF EXISTS `forever_bb_creature_queststarte_1120`;

DROP TEMPORARY TABLE IF EXISTS `forever_bb_creature_questender_1120`;
CREATE TEMPORARY TABLE `forever_bb_creature_questender_1120` SELECT `id`,`quest` FROM `creature_questender` WHERE 0;
INSERT INTO `forever_bb_creature_questender_1120` (`id`,`quest`) VALUES
(253851,93072),
(254578,93362),
(255486,99258),
(255829,95424),
(255829,95433),
(256831,95643),
(259961,95122);
INSERT INTO `creature_questender` (`id`,`quest`) SELECT `s`.`id`,`s`.`quest` FROM `forever_bb_creature_questender_1120` `s` WHERE NOT EXISTS (SELECT 1 FROM `creature_questender` `x` WHERE `x`.`id`=`s`.`id` AND `x`.`quest`=`s`.`quest`);
DROP TEMPORARY TABLE IF EXISTS `forever_bb_creature_questender_1120`;

-- Quest givers and enders show the quest marker.
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (253851,254578,255486,255829,256831,259961,260993) AND (`npcflag`&2)=0;
