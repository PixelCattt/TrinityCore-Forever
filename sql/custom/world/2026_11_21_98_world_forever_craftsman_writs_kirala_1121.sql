-- WoW Forever: two more Craftsman's Writs after 2026_11_21_97 (run after it). 94323 (Kirala Fairgrass, who now gets her template
-- and spawn) and 94352 (Joy Ar'nareth 11707, from Wowhead's Forever quest page). 16 more writs have no customer on Wowhead or
-- any open source yet and stay out. Same rows and rules as 2026_11_21_97, described below.
--
-- WoW Forever: the Craftsman's Writs that did nothing when used (forum report: Craftsman's Writ: Lesser Mana Potion 264013 gives
-- no quest). The Merchant's Favor letters (2026_11_04_50) hand out 150 writs; each starts its own order quest, but only 88 of
-- those quests were in our world (2026_11_19_99) and 11 more come with 2026_11_21_91. This adds the rest whose customer stands
-- in our world (it runs after 2026_11_21_90, which spawns some of the customers).
-- Quest records: EG Link (Efficient Games, https://efficient.games, CC BY 4.0), eg-link-output-wowf 4e98f1f, build 70938: the
-- live client's own quest data (title, texts, flags, objectives, reputation, treasure picker). Who takes each writ in: Everlake's
-- world data (buildthehomelab/wow-everlake-world-data 3f4d7e4, GPL-3.0; from QuestieDB, Wowhead's Forever quest pages and live
-- captures). Turn-in and progress words: Everlake's Forge exports (Icy Veins). Written here as our own rows in the
-- shape of 2026_11_19_99: same rewards per tier as there and as the PC read on Wowhead for 94213 (Journeyman: Coin Pouch 284584
-- and 75 reputation with both trade factions; Expert: 284585 and 125; Artisan: 200 and the treasure picker only), daily, level 60.
-- A quest goes in only when its customer is spawned (else it could never be handed in). Each writ also joins its tier's world
-- drop list (reference loot 9500001-9500003 from 2026_11_19_99, every writ of a tier equally likely). Safe to run more than once.

-- Kirala Fairgrass (262024), the customer for 94323, had no template, so 2026_11_21_97 left her and her writ out. Wowhead's
-- Forever npc page (read 21 Nov): display 143048, title The Argent Dawn, level 60, Western Plaguelands 59.4,53.2. The rest as
-- Bullets Bigblast in 2026_11_21_97: faction 35 (friendly to both sides, no reputation), core default speeds, type 7 (humanoid),
-- class 1. One spawn at Everlake's QuestieDB trace point (1843.03,-2144.84,67.52; Western Plaguelands, as Wowhead), guid
-- 920014001, only while she has none. Model size INFERRED: the commonest of the displays on her client model 7300 at scale
-- 1.0, 330 of 372 (as Everlake 2026_11_18_931 counted).
INSERT INTO `creature_template` (`entry`,`KillCredit1`,`KillCredit2`,`name`,`femaleName`,`subname`,`TitleAlt`,`IconName`,`RequiredExpansion`,`VignetteID`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`Classification`,`dmgschool`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,`unit_flags`,`unit_flags2`,`unit_flags3`,`family`,`trainer_class`,`type`,`VehicleId`,`AIName`,`MovementType`,`ExperienceModifier`,`RacialLeader`,`movementId`,`WidgetSetID`,`WidgetSetUnitConditionID`,`RegenHealth`,`CreatureImmunitiesId`,`flags_extra`,`ScriptName`,`StringId`,`VerifiedBuild`)
SELECT 262024,0,0,'Kirala Fairgrass',NULL,'The Argent Dawn',NULL,NULL,0,0,35,2,1,1.14286,1,0,0,2000,2000,1,1,1,0,2048,0,0,0,7,0,'',0,1,0,0,0,0,1,0,0,'',NULL,0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `creature_template` WHERE `entry`=262024);
INSERT INTO `creature_template_difficulty` (`Entry`,`DifficultyID`,`LevelScalingDeltaMin`,`LevelScalingDeltaMax`,`ContentTuningID`,`HealthScalingExpansion`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`DamageModifier`,`CreatureDifficultyID`,`TypeFlags`,`TypeFlags2`,`TypeFlags3`,`LootID`,`PickPocketLootID`,`SkinLootID`,`GoldMin`,`GoldMax`,`StaticFlags1`,`StaticFlags2`,`StaticFlags3`,`StaticFlags4`,`StaticFlags5`,`StaticFlags6`,`StaticFlags7`,`StaticFlags8`,`VerifiedBuild`)
SELECT 262024,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `creature_template_difficulty` WHERE `Entry`=262024 AND `DifficultyID`=0);
INSERT INTO `creature_template_model` (`CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild`)
SELECT 262024,0,143048,1,1,0 FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `creature_template_model` WHERE `CreatureID`=262024);
INSERT INTO `creature_model_info` (`DisplayID`,`BoundingRadius`,`CombatReach`,`DisplayID_Other_Gender`,`VerifiedBuild`)
SELECT 143048,0.306,1.5,0,0 FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `creature_model_info` WHERE `DisplayID`=143048);
INSERT INTO `creature_classic_level` (`entry`,`level_min`,`level_max`)
SELECT 262024,60,60 FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry`=262024);
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`)
SELECT 920014001,262024,0,0,0,'0',0,0,0,-1,0,0,1843.03,-2144.84,67.52,0,300,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `creature` WHERE `id`=262024) AND NOT EXISTS (SELECT 1 FROM `creature` WHERE `guid`=920014001);


DROP TEMPORARY TABLE IF EXISTS `forever_writ_e`;
CREATE TEMPORARY TABLE `forever_writ_e` SELECT `id`,`quest` FROM `creature_questender` WHERE 0;
INSERT INTO `forever_writ_e` (`id`,`quest`) VALUES
(262024,94323),
(11707,94352);
DROP TEMPORARY TABLE IF EXISTS `forever_writ_g`;
CREATE TEMPORARY TABLE `forever_writ_g` SELECT `id`,`quest` FROM `gameobject_questender` WHERE 0;
-- Only writs whose customer stands in our world, and only where the quest is not there yet (a second run adds nothing).
DROP TEMPORARY TABLE IF EXISTS `forever_writ_ok`;
CREATE TEMPORARY TABLE `forever_writ_ok` (`quest` INT UNSIGNED NOT NULL PRIMARY KEY);
INSERT IGNORE INTO `forever_writ_ok` (`quest`) SELECT `e`.`quest` FROM `forever_writ_e` `e` WHERE EXISTS (SELECT 1 FROM `creature` `c` WHERE `c`.`id`=`e`.`id`) AND NOT EXISTS (SELECT 1 FROM `quest_template` `t` WHERE `t`.`ID`=`e`.`quest`);
INSERT IGNORE INTO `forever_writ_ok` (`quest`) SELECT `e`.`quest` FROM `forever_writ_g` `e` WHERE EXISTS (SELECT 1 FROM `gameobject` `c` WHERE `c`.`id`=`e`.`id`) AND NOT EXISTS (SELECT 1 FROM `quest_template` `t` WHERE `t`.`ID`=`e`.`quest`);

-- The writ quests, as the live client's quest records give them.
DROP TEMPORARY TABLE IF EXISTS `forever_writ_q`;
CREATE TEMPORARY TABLE `forever_writ_q` SELECT `ID`,`RewardItem1`,`RewardAmount1`,`ItemDrop1`,`ItemDropQuantity1`,`RewardItem2`,`RewardAmount2`,`ItemDrop2`,`ItemDropQuantity2`,`RewardItem3`,`RewardAmount3`,`ItemDrop3`,`ItemDropQuantity3`,`RewardItem4`,`RewardAmount4`,`ItemDrop4`,`ItemDropQuantity4`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`RewardChoiceItemID5`,`RewardChoiceItemQuantity5`,`RewardChoiceItemID6`,`RewardChoiceItemQuantity6`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`RewardFactionCapIn1`,`RewardFactionID2`,`RewardFactionValue2`,`RewardFactionOverride2`,`RewardFactionCapIn2`,`RewardFactionID3`,`RewardFactionValue3`,`RewardFactionOverride3`,`RewardFactionCapIn3`,`RewardFactionID4`,`RewardFactionValue4`,`RewardFactionOverride4`,`RewardFactionCapIn4`,`RewardFactionID5`,`RewardFactionValue5`,`RewardFactionOverride5`,`RewardFactionCapIn5`,`RewardCurrencyID1`,`RewardCurrencyQty1`,`RewardCurrencyID2`,`RewardCurrencyQty2`,`RewardCurrencyID3`,`RewardCurrencyQty3`,`RewardCurrencyID4`,`RewardCurrencyQty4`,`QuestType`,`QuestInfoID`,`RewardNextQuest`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`QuestSortID`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardSpell`,`AllowableRaces`,`AcceptedSoundKitID`,`CompleteSoundKitID`,`Expansion`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog` FROM `quest_template` WHERE 0;
INSERT INTO `forever_writ_q` (`ID`,`RewardItem1`,`RewardAmount1`,`ItemDrop1`,`ItemDropQuantity1`,`RewardItem2`,`RewardAmount2`,`ItemDrop2`,`ItemDropQuantity2`,`RewardItem3`,`RewardAmount3`,`ItemDrop3`,`ItemDropQuantity3`,`RewardItem4`,`RewardAmount4`,`ItemDrop4`,`ItemDropQuantity4`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`RewardChoiceItemID5`,`RewardChoiceItemQuantity5`,`RewardChoiceItemID6`,`RewardChoiceItemQuantity6`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`RewardFactionCapIn1`,`RewardFactionID2`,`RewardFactionValue2`,`RewardFactionOverride2`,`RewardFactionCapIn2`,`RewardFactionID3`,`RewardFactionValue3`,`RewardFactionOverride3`,`RewardFactionCapIn3`,`RewardFactionID4`,`RewardFactionValue4`,`RewardFactionOverride4`,`RewardFactionCapIn4`,`RewardFactionID5`,`RewardFactionValue5`,`RewardFactionOverride5`,`RewardFactionCapIn5`,`RewardCurrencyID1`,`RewardCurrencyQty1`,`RewardCurrencyID2`,`RewardCurrencyQty2`,`RewardCurrencyID3`,`RewardCurrencyQty3`,`RewardCurrencyID4`,`RewardCurrencyQty4`,`QuestType`,`QuestInfoID`,`RewardNextQuest`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`QuestSortID`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardSpell`,`AllowableRaces`,`AcceptedSoundKitID`,`CompleteSoundKitID`,`Expansion`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`) VALUES
(94323,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2586,0,20000,7,2587,0,20000,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,2,0,0,0,3149824,33281,268435456,0,16941,0,1.0,0,18446744073709551615,890,878,-2,'Craftsman''s Writ: Major Rejuvenation Potion','Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.','

<Penned in faded ink, the note is requesting $2oa Major Rejuvenation Potion, along with information about delivery location and payment. At the bottom appears text denoting this writ is transferable.>','',''),
(94352,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2586,0,20000,7,2587,0,20000,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,2,0,0,0,3149824,33281,268435456,0,16941,0,1.0,0,18446744073709551615,890,878,-2,'Craftsman''s Writ: Wizardweave Turban','Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.','<Penned in faded ink, the note is requesting $2oa Wizardweave Turban, along with information about delivery location and payment. At the bottom appears text denoting this writ is transferable.>','','');
INSERT INTO `quest_template` (`ID`,`RewardItem1`,`RewardAmount1`,`ItemDrop1`,`ItemDropQuantity1`,`RewardItem2`,`RewardAmount2`,`ItemDrop2`,`ItemDropQuantity2`,`RewardItem3`,`RewardAmount3`,`ItemDrop3`,`ItemDropQuantity3`,`RewardItem4`,`RewardAmount4`,`ItemDrop4`,`ItemDropQuantity4`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`RewardChoiceItemID5`,`RewardChoiceItemQuantity5`,`RewardChoiceItemID6`,`RewardChoiceItemQuantity6`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`RewardFactionCapIn1`,`RewardFactionID2`,`RewardFactionValue2`,`RewardFactionOverride2`,`RewardFactionCapIn2`,`RewardFactionID3`,`RewardFactionValue3`,`RewardFactionOverride3`,`RewardFactionCapIn3`,`RewardFactionID4`,`RewardFactionValue4`,`RewardFactionOverride4`,`RewardFactionCapIn4`,`RewardFactionID5`,`RewardFactionValue5`,`RewardFactionOverride5`,`RewardFactionCapIn5`,`RewardCurrencyID1`,`RewardCurrencyQty1`,`RewardCurrencyID2`,`RewardCurrencyQty2`,`RewardCurrencyID3`,`RewardCurrencyQty3`,`RewardCurrencyID4`,`RewardCurrencyQty4`,`QuestType`,`QuestInfoID`,`RewardNextQuest`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`QuestSortID`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardSpell`,`AllowableRaces`,`AcceptedSoundKitID`,`CompleteSoundKitID`,`Expansion`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`) SELECT `s`.`ID`,`s`.`RewardItem1`,`s`.`RewardAmount1`,`s`.`ItemDrop1`,`s`.`ItemDropQuantity1`,`s`.`RewardItem2`,`s`.`RewardAmount2`,`s`.`ItemDrop2`,`s`.`ItemDropQuantity2`,`s`.`RewardItem3`,`s`.`RewardAmount3`,`s`.`ItemDrop3`,`s`.`ItemDropQuantity3`,`s`.`RewardItem4`,`s`.`RewardAmount4`,`s`.`ItemDrop4`,`s`.`ItemDropQuantity4`,`s`.`RewardChoiceItemID1`,`s`.`RewardChoiceItemQuantity1`,`s`.`RewardChoiceItemID2`,`s`.`RewardChoiceItemQuantity2`,`s`.`RewardChoiceItemID3`,`s`.`RewardChoiceItemQuantity3`,`s`.`RewardChoiceItemID4`,`s`.`RewardChoiceItemQuantity4`,`s`.`RewardChoiceItemID5`,`s`.`RewardChoiceItemQuantity5`,`s`.`RewardChoiceItemID6`,`s`.`RewardChoiceItemQuantity6`,`s`.`RewardFactionID1`,`s`.`RewardFactionValue1`,`s`.`RewardFactionOverride1`,`s`.`RewardFactionCapIn1`,`s`.`RewardFactionID2`,`s`.`RewardFactionValue2`,`s`.`RewardFactionOverride2`,`s`.`RewardFactionCapIn2`,`s`.`RewardFactionID3`,`s`.`RewardFactionValue3`,`s`.`RewardFactionOverride3`,`s`.`RewardFactionCapIn3`,`s`.`RewardFactionID4`,`s`.`RewardFactionValue4`,`s`.`RewardFactionOverride4`,`s`.`RewardFactionCapIn4`,`s`.`RewardFactionID5`,`s`.`RewardFactionValue5`,`s`.`RewardFactionOverride5`,`s`.`RewardFactionCapIn5`,`s`.`RewardCurrencyID1`,`s`.`RewardCurrencyQty1`,`s`.`RewardCurrencyID2`,`s`.`RewardCurrencyQty2`,`s`.`RewardCurrencyID3`,`s`.`RewardCurrencyQty3`,`s`.`RewardCurrencyID4`,`s`.`RewardCurrencyQty4`,`s`.`QuestType`,`s`.`QuestInfoID`,`s`.`RewardNextQuest`,`s`.`StartItem`,`s`.`Flags`,`s`.`FlagsEx`,`s`.`FlagsEx2`,`s`.`TimeAllowed`,`s`.`QuestSortID`,`s`.`RewardXPDifficulty`,`s`.`RewardXPMultiplier`,`s`.`RewardSpell`,`s`.`AllowableRaces`,`s`.`AcceptedSoundKitID`,`s`.`CompleteSoundKitID`,`s`.`Expansion`,`s`.`LogTitle`,`s`.`LogDescription`,`s`.`QuestDescription`,`s`.`AreaDescription`,`s`.`QuestCompletionLog` FROM `forever_writ_q` `s` WHERE `s`.`ID` IN (SELECT `quest` FROM `forever_writ_ok`) AND NOT EXISTS (SELECT 1 FROM `quest_template` `x` WHERE `x`.`ID`=`s`.`ID`);
DROP TEMPORARY TABLE IF EXISTS `forever_writ_q`;

-- Their objectives: the writ itself and the crafted item it asks for.
DROP TEMPORARY TABLE IF EXISTS `forever_writ_o`;
CREATE TEMPORARY TABLE `forever_writ_o` SELECT `ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Description` FROM `quest_objectives` WHERE 0;
INSERT INTO `forever_writ_o` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Description`) VALUES
(468357,94323,1,0,0,264123,1,32,''),
(468358,94323,1,1,1,18253,1,32,''),
(468415,94352,1,0,0,264152,1,32,''),
(468416,94352,1,1,1,14130,1,32,'');
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Description`) SELECT `s`.`ID`,`s`.`QuestID`,`s`.`Type`,`s`.`Order`,`s`.`StorageIndex`,`s`.`ObjectID`,`s`.`Amount`,`s`.`Flags`,`s`.`Description` FROM `forever_writ_o` `s` WHERE `s`.`QuestID` IN (SELECT `quest` FROM `forever_writ_ok`) AND NOT EXISTS (SELECT 1 FROM `quest_objectives` `x` WHERE `x`.`ID`=`s`.`ID`);
DROP TEMPORARY TABLE IF EXISTS `forever_writ_o`;

DROP TEMPORARY TABLE IF EXISTS `forever_writ_x`;
CREATE TEMPORARY TABLE `forever_writ_x` SELECT `ID`,`QuestLevel`,`MinLevel`,`MaxLevel` FROM `quest_classic_level` WHERE 0;
INSERT INTO `forever_writ_x` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES
(94323,60,1,0),
(94352,60,1,0);
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) SELECT `s`.`ID`,`s`.`QuestLevel`,`s`.`MinLevel`,`s`.`MaxLevel` FROM `forever_writ_x` `s` WHERE `s`.`ID` IN (SELECT `quest` FROM `forever_writ_ok`) AND NOT EXISTS (SELECT 1 FROM `quest_classic_level` `x` WHERE `x`.`ID`=`s`.`ID`);
DROP TEMPORARY TABLE IF EXISTS `forever_writ_x`;

DROP TEMPORARY TABLE IF EXISTS `forever_writ_x`;
CREATE TEMPORARY TABLE `forever_writ_x` SELECT `ID`,`LevelType`,`QuestLevel` FROM `quest_template_classic_level` WHERE 0;
INSERT INTO `forever_writ_x` (`ID`,`LevelType`,`QuestLevel`) VALUES
(94323,2,60),
(94352,2,60);
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) SELECT `s`.`ID`,`s`.`LevelType`,`s`.`QuestLevel` FROM `forever_writ_x` `s` WHERE `s`.`ID` IN (SELECT `quest` FROM `forever_writ_ok`) AND NOT EXISTS (SELECT 1 FROM `quest_template_classic_level` `x` WHERE `x`.`ID`=`s`.`ID` AND `x`.`LevelType`=`s`.`LevelType`);
DROP TEMPORARY TABLE IF EXISTS `forever_writ_x`;

DROP TEMPORARY TABLE IF EXISTS `forever_writ_x`;
CREATE TEMPORARY TABLE `forever_writ_x` SELECT `QuestID`,`TreasurePickerID`,`OrderIndex` FROM `quest_treasure_pickers` WHERE 0;
INSERT INTO `forever_writ_x` (`QuestID`,`TreasurePickerID`,`OrderIndex`) VALUES
(94323,4819,0),
(94352,4819,0);
INSERT INTO `quest_treasure_pickers` (`QuestID`,`TreasurePickerID`,`OrderIndex`) SELECT `s`.`QuestID`,`s`.`TreasurePickerID`,`s`.`OrderIndex` FROM `forever_writ_x` `s` WHERE `s`.`QuestID` IN (SELECT `quest` FROM `forever_writ_ok`) AND NOT EXISTS (SELECT 1 FROM `quest_treasure_pickers` `x` WHERE `x`.`QuestID`=`s`.`QuestID` AND `x`.`TreasurePickerID`=`s`.`TreasurePickerID`);
DROP TEMPORARY TABLE IF EXISTS `forever_writ_x`;

-- What the customer says on hand-in and while you still lack the item.
DROP TEMPORARY TABLE IF EXISTS `forever_writ_x`;
CREATE TEMPORARY TABLE `forever_writ_x` SELECT `ID`,`RewardText` FROM `quest_offer_reward` WHERE 0;
INSERT INTO `forever_writ_x` (`ID`,`RewardText`) VALUES
(94323,'In fields wrought with death and sorrow, some old bones and broken crates are an ordinary sight.$B$BBut this little spot is different. Clearly someone was here before me, but I think nature tried to renew itself here, too. Clearly, it failed.$B$BI have been waiting for the potion you bring to arrive. I suspect nothing will come of it, but I intend to use it with the leftover herbs here in an attempt to breathe some fresh life in this corner of the plaguelands.');
INSERT INTO `quest_offer_reward` (`ID`,`RewardText`) SELECT `s`.`ID`,`s`.`RewardText` FROM `forever_writ_x` `s` WHERE `s`.`ID` IN (SELECT `quest` FROM `forever_writ_ok`) AND NOT EXISTS (SELECT 1 FROM `quest_offer_reward` `x` WHERE `x`.`ID`=`s`.`ID`);
DROP TEMPORARY TABLE IF EXISTS `forever_writ_x`;

DROP TEMPORARY TABLE IF EXISTS `forever_writ_x`;
CREATE TEMPORARY TABLE `forever_writ_x` SELECT `ID`,`CompletionText` FROM `quest_request_items` WHERE 0;
INSERT INTO `forever_writ_x` (`ID`,`CompletionText`) VALUES
(94323,'I could not help but be drawn to this landmark as I was passing. It is so strange. Wouldn''t you agree?');
INSERT INTO `quest_request_items` (`ID`,`CompletionText`) SELECT `s`.`ID`,`s`.`CompletionText` FROM `forever_writ_x` `s` WHERE `s`.`ID` IN (SELECT `quest` FROM `forever_writ_ok`) AND NOT EXISTS (SELECT 1 FROM `quest_request_items` `x` WHERE `x`.`ID`=`s`.`ID`);
DROP TEMPORARY TABLE IF EXISTS `forever_writ_x`;

-- Who takes the writ in.
INSERT INTO `creature_questender` (`id`,`quest`) SELECT `s`.`id`,`s`.`quest` FROM `forever_writ_e` `s` WHERE `s`.`quest` IN (SELECT `quest` FROM `forever_writ_ok`) AND EXISTS (SELECT 1 FROM `creature` `c` WHERE `c`.`id`=`s`.`id`) AND NOT EXISTS (SELECT 1 FROM `creature_questender` `x` WHERE `x`.`id`=`s`.`id` AND `x`.`quest`=`s`.`quest`);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (11707,262024) AND (`npcflag`&2)=0 AND `entry` IN (SELECT `id` FROM `creature_questender` WHERE `quest` BETWEEN 94004 AND 94360);
INSERT INTO `gameobject_questender` (`id`,`quest`) SELECT `s`.`id`,`s`.`quest` FROM `forever_writ_g` `s` WHERE `s`.`quest` IN (SELECT `quest` FROM `forever_writ_ok`) AND EXISTS (SELECT 1 FROM `gameobject` `c` WHERE `c`.`id`=`s`.`id`) AND NOT EXISTS (SELECT 1 FROM `gameobject_questender` `x` WHERE `x`.`id`=`s`.`id` AND `x`.`quest`=`s`.`quest`);
DROP TEMPORARY TABLE IF EXISTS `forever_writ_e`;
DROP TEMPORARY TABLE IF EXISTS `forever_writ_g`;

-- The writs join their tier's world drop list.
DROP TEMPORARY TABLE IF EXISTS `forever_writ_r`;
CREATE TEMPORARY TABLE `forever_writ_r` SELECT `Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment` FROM `reference_loot_template` WHERE 0;
INSERT INTO `forever_writ_r` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(9500003,0,264123,0,0,1,1,1,1,'Craftsman''s Writ, Artisan (quest 94323)'),
(9500003,0,264152,0,0,1,1,1,1,'Craftsman''s Writ, Artisan (quest 94352)');
INSERT INTO `reference_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) SELECT `s`.`Entry`,`s`.`ItemType`,`s`.`Item`,`s`.`Chance`,`s`.`QuestRequired`,`s`.`LootMode`,`s`.`GroupId`,`s`.`MinCount`,`s`.`MaxCount`,`s`.`Comment` FROM `forever_writ_r` `s` WHERE CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(`s`.`Comment`,'quest ',-1),')',1) AS UNSIGNED) IN (SELECT `quest` FROM `forever_writ_ok`) AND NOT EXISTS (SELECT 1 FROM `reference_loot_template` `x` WHERE `x`.`Entry`=`s`.`Entry` AND `x`.`ItemType`=`s`.`ItemType` AND `x`.`Item`=`s`.`Item`);
DROP TEMPORARY TABLE IF EXISTS `forever_writ_r`;

DROP TEMPORARY TABLE IF EXISTS `forever_writ_ok`;
