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

-- Two writ customers our world had not spawned (Bullets Bigblast 262379 takes 94288 and 94312; Kirala Fairgrass 262024 takes
-- 94323). Bullets' template where we lack it: EG Link 70959 creature details (name, title, type 7, class 1, display 143141 at
-- scale 1.15, creature difficulty 345676), level 53 and faction 35 (friendly to both sides, no reputation: QuestieDB's traces see
-- it friendly to both and no nearby NPC fits) as Everlake 2026_11_18_931 has them, core default speeds. Kirala has no open
-- record of her model, so she gets a spawn only where our world already has her template. One spawn each, only while the realm
-- has none, at Everlake's QuestieDB point (Kirala: player traces; Bullets: QuestieDB's point) with its map/vmap height.
-- Guids 920014000-920014001 are new.
INSERT INTO `creature_template` (`entry`,`KillCredit1`,`KillCredit2`,`name`,`femaleName`,`subname`,`TitleAlt`,`IconName`,`RequiredExpansion`,`VignetteID`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`Classification`,`dmgschool`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,`unit_flags`,`unit_flags2`,`unit_flags3`,`family`,`trainer_class`,`type`,`VehicleId`,`AIName`,`MovementType`,`ExperienceModifier`,`RacialLeader`,`movementId`,`WidgetSetID`,`WidgetSetUnitConditionID`,`RegenHealth`,`CreatureImmunitiesId`,`flags_extra`,`ScriptName`,`StringId`,`VerifiedBuild`)
SELECT 262379,0,0,'Bullets Bigblast',NULL,'Steamwheedle Construction Co.',NULL,NULL,0,0,35,2,1,1.14286,1,0,0,2000,2000,1,1,1,0,2048,0,0,0,7,0,'',0,1,0,0,0,0,1,0,0,'',NULL,0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `creature_template` WHERE `entry`=262379);
INSERT INTO `creature_template_difficulty` (`Entry`,`DifficultyID`,`LevelScalingDeltaMin`,`LevelScalingDeltaMax`,`ContentTuningID`,`HealthScalingExpansion`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`DamageModifier`,`CreatureDifficultyID`,`TypeFlags`,`TypeFlags2`,`TypeFlags3`,`LootID`,`PickPocketLootID`,`SkinLootID`,`GoldMin`,`GoldMax`,`StaticFlags1`,`StaticFlags2`,`StaticFlags3`,`StaticFlags4`,`StaticFlags5`,`StaticFlags6`,`StaticFlags7`,`StaticFlags8`,`VerifiedBuild`)
SELECT 262379,0,0,0,0,0,1,1,1,1,345676,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `creature_template_difficulty` WHERE `Entry`=262379 AND `DifficultyID`=0);
INSERT INTO `creature_template_model` (`CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild`)
SELECT 262379,0,143141,1.15,1,0 FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `creature_template_model` WHERE `CreatureID`=262379);
-- The core loads no creature whose display has no creature_model_info row. 143141 had none: INFERRED, the commonest values of
-- the displays on the same client model (831, goblin male) at scale 1.0, 254 of 279 (as Everlake 2026_11_18_931 counted).
INSERT INTO `creature_model_info` (`DisplayID`,`BoundingRadius`,`CombatReach`,`DisplayID_Other_Gender`,`VerifiedBuild`)
SELECT 143141,0.306,1.5,0,0 FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `creature_model_info` WHERE `DisplayID`=143141);
INSERT INTO `creature_classic_level` (`entry`,`level_min`,`level_max`)
SELECT 262379,53,53 FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry`=262379);
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`)
SELECT `s`.`guid`,`s`.`id`,0,0,0,'0',0,0,0,-1,0,0,`s`.`x`,`s`.`y`,`s`.`z`,0,300,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0
FROM (SELECT 920014000 AS `guid`,262379 AS `id`,-10256.97 AS `x`,-3823.95 AS `y`,18.23 AS `z`
      UNION ALL SELECT 920014001,262024,1843.03,-2144.84,67.52) `s`
WHERE EXISTS (SELECT 1 FROM `creature_template` `t` WHERE `t`.`entry`=`s`.`id`)
  AND NOT EXISTS (SELECT 1 FROM `creature` `c` WHERE `c`.`id`=`s`.`id`)
  AND NOT EXISTS (SELECT 1 FROM `creature` `c` WHERE `c`.`guid`=`s`.`guid`);


DROP TEMPORARY TABLE IF EXISTS `forever_writ_e`;
CREATE TEMPORARY TABLE `forever_writ_e` SELECT `id`,`quest` FROM `creature_questender` WHERE 0;
INSERT INTO `forever_writ_e` (`id`,`quest`) VALUES
(257281,94004),
(257296,94212),
(257315,94213),
(3134,94214),
(261928,94215),
(4201,94216),
(14508,94217),
(4720,94218),
(8305,94219),
(257296,94221),
(257316,94222),
(6626,94227),
(257282,94229),
(257304,94230),
(257317,94231),
(261932,94233),
(7853,94235),
(3134,94241),
(4201,94243),
(257282,94247),
(257304,94248),
(257316,94249),
(8305,94255),
(2921,94256),
(270919,94270),
(262072,94282),
(262379,94288),
(262072,94294),
(262379,94312),
(262024,94323),
(11705,94334),
(257673,94336),
(14437,94354);
DROP TEMPORARY TABLE IF EXISTS `forever_writ_g`;
CREATE TEMPORARY TABLE `forever_writ_g` SELECT `id`,`quest` FROM `gameobject_questender` WHERE 0;
INSERT INTO `forever_writ_g` (`id`,`quest`) VALUES
(642320,94223);
-- Only writs whose customer stands in our world, and only where the quest is not there yet (a second run adds nothing).
DROP TEMPORARY TABLE IF EXISTS `forever_writ_ok`;
CREATE TEMPORARY TABLE `forever_writ_ok` (`quest` INT UNSIGNED NOT NULL PRIMARY KEY);
INSERT IGNORE INTO `forever_writ_ok` (`quest`) SELECT `e`.`quest` FROM `forever_writ_e` `e` WHERE EXISTS (SELECT 1 FROM `creature` `c` WHERE `c`.`id`=`e`.`id`) AND NOT EXISTS (SELECT 1 FROM `quest_template` `t` WHERE `t`.`ID`=`e`.`quest`);
INSERT IGNORE INTO `forever_writ_ok` (`quest`) SELECT `e`.`quest` FROM `forever_writ_g` `e` WHERE EXISTS (SELECT 1 FROM `gameobject` `c` WHERE `c`.`id`=`e`.`id`) AND NOT EXISTS (SELECT 1 FROM `quest_template` `t` WHERE `t`.`ID`=`e`.`quest`);

-- The writ quests, as the live client's quest records give them.
DROP TEMPORARY TABLE IF EXISTS `forever_writ_q`;
CREATE TEMPORARY TABLE `forever_writ_q` SELECT `ID`,`RewardItem1`,`RewardAmount1`,`ItemDrop1`,`ItemDropQuantity1`,`RewardItem2`,`RewardAmount2`,`ItemDrop2`,`ItemDropQuantity2`,`RewardItem3`,`RewardAmount3`,`ItemDrop3`,`ItemDropQuantity3`,`RewardItem4`,`RewardAmount4`,`ItemDrop4`,`ItemDropQuantity4`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`RewardChoiceItemID5`,`RewardChoiceItemQuantity5`,`RewardChoiceItemID6`,`RewardChoiceItemQuantity6`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`RewardFactionCapIn1`,`RewardFactionID2`,`RewardFactionValue2`,`RewardFactionOverride2`,`RewardFactionCapIn2`,`RewardFactionID3`,`RewardFactionValue3`,`RewardFactionOverride3`,`RewardFactionCapIn3`,`RewardFactionID4`,`RewardFactionValue4`,`RewardFactionOverride4`,`RewardFactionCapIn4`,`RewardFactionID5`,`RewardFactionValue5`,`RewardFactionOverride5`,`RewardFactionCapIn5`,`RewardCurrencyID1`,`RewardCurrencyQty1`,`RewardCurrencyID2`,`RewardCurrencyQty2`,`RewardCurrencyID3`,`RewardCurrencyQty3`,`RewardCurrencyID4`,`RewardCurrencyQty4`,`QuestType`,`QuestInfoID`,`RewardNextQuest`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`QuestSortID`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardSpell`,`AllowableRaces`,`AcceptedSoundKitID`,`CompleteSoundKitID`,`Expansion`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog` FROM `quest_template` WHERE 0;
INSERT INTO `forever_writ_q` (`ID`,`RewardItem1`,`RewardAmount1`,`ItemDrop1`,`ItemDropQuantity1`,`RewardItem2`,`RewardAmount2`,`ItemDrop2`,`ItemDropQuantity2`,`RewardItem3`,`RewardAmount3`,`ItemDrop3`,`ItemDropQuantity3`,`RewardItem4`,`RewardAmount4`,`ItemDrop4`,`ItemDropQuantity4`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`RewardChoiceItemID5`,`RewardChoiceItemQuantity5`,`RewardChoiceItemID6`,`RewardChoiceItemQuantity6`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`RewardFactionCapIn1`,`RewardFactionID2`,`RewardFactionValue2`,`RewardFactionOverride2`,`RewardFactionCapIn2`,`RewardFactionID3`,`RewardFactionValue3`,`RewardFactionOverride3`,`RewardFactionCapIn3`,`RewardFactionID4`,`RewardFactionValue4`,`RewardFactionOverride4`,`RewardFactionCapIn4`,`RewardFactionID5`,`RewardFactionValue5`,`RewardFactionOverride5`,`RewardFactionCapIn5`,`RewardCurrencyID1`,`RewardCurrencyQty1`,`RewardCurrencyID2`,`RewardCurrencyQty2`,`RewardCurrencyID3`,`RewardCurrencyQty3`,`RewardCurrencyID4`,`RewardCurrencyQty4`,`QuestType`,`QuestInfoID`,`RewardNextQuest`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`QuestSortID`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardSpell`,`AllowableRaces`,`AcceptedSoundKitID`,`CompleteSoundKitID`,`Expansion`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`) VALUES
(94004,284584,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2586,0,7500,7,2587,0,7500,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,2,0,0,0,3149824,33281,268435456,0,16941,0,1.0,0,18446744073709551615,890,878,-2,'Craftsman''s Writ: Elixir of Ogre''s Strength','Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.','<Penned in faded ink, the note is requesting $2oa Elixir of Ogre''s Strength, along with information about delivery location and payment. At the bottom appears text denoting this writ is transferable.>','',''),
(94212,284584,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2586,0,7500,7,2587,0,7500,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,2,0,0,0,3149824,33281,268435456,0,16941,0,1.0,0,18446744073709551615,890,878,-2,'Craftsman''s Writ: Elixir of Wisdom','Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.','<Penned in faded ink, the note is requesting $2oa Elixir of Wisdom, along with information about delivery location and payment. At the bottom appears text denoting this writ is transferable.>','',''),
(94213,284584,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2586,0,7500,7,2587,0,7500,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,2,0,0,0,3149824,33281,268435456,0,16941,0,1.0,0,18446744073709551615,890,878,-2,'Craftsman''s Writ: Lesser Mana Potion','Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.','<Penned in faded ink, the note is requesting $2oa Lesser Mana Potion, along with information about delivery location and payment. At the bottom appears text denoting this writ is transferable.>','',''),
(94214,284584,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2586,0,7500,7,2587,0,7500,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,2,0,0,0,3149824,33281,268435456,0,16941,0,1.0,0,18446744073709551615,890,878,-2,'Craftsman''s Writ: Shadow Protection Potion','Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.','<Penned in faded ink, the note is requesting $2oa Shadow Protection Potion, along with information about delivery location and payment. At the bottom appears text denoting this writ is transferable.>','',''),
(94215,284584,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2586,0,7500,7,2587,0,7500,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,2,0,0,0,3149824,33281,268435456,0,16941,0,1.0,0,18446744073709551615,890,878,-2,'Craftsman''s Writ: Free Action Potion','Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.','<Penned in faded ink, the note is requesting $2oa Free Action Potion, along with information about delivery location and payment. At the bottom appears text denoting this writ is transferable.>','',''),
(94216,284584,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2586,0,7500,7,2587,0,7500,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,2,0,0,0,3149824,33281,268435456,0,16941,0,1.0,0,18446744073709551615,890,878,-2,'Craftsman''s Writ: Elixir of Lesser Agility','Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.','<Penned in faded ink, the note is requesting $2oa Elixir of Lesser Agility, along with information about delivery location and payment. At the bottom appears text denoting this writ is transferable.>','',''),
(94217,284584,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2586,0,7500,7,2587,0,7500,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,2,0,0,0,3149824,33281,268435456,0,16941,0,1.0,0,18446744073709551615,890,878,-2,'Craftsman''s Writ: Lesser Troll''s Blood Elixir','Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.','

<Penned in faded ink, the note is requesting $2oa Lesser Troll''s Blood Elixir, along with information about delivery location and payment. At the bottom appears text denoting this writ is transferable.>','',''),
(94218,284584,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2586,0,7500,7,2587,0,7500,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,2,0,0,0,3149824,33281,268435456,0,16941,0,1.0,0,18446744073709551615,890,878,-2,'Craftsman''s Writ: Elixir of Defense','Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.','

<Penned in faded ink, the note is requesting $2oa Elixir of Defense, along with information about delivery location and payment. At the bottom appears text denoting this writ is transferable.>','',''),
(94219,284584,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2586,0,7500,7,2587,0,7500,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,2,0,0,0,3149824,33281,268435456,0,16941,0,1.0,0,18446744073709551615,890,878,-2,'Craftsman''s Writ: Draught of Water Breathing','Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.','

<Penned in faded ink, the note is requesting $2oa Draught of Water Breathing, along with information about delivery location and payment. At the bottom appears text denoting this writ is transferable.>','',''),
(94221,284584,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2586,0,7500,7,2587,0,7500,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,2,0,0,0,3149824,33281,268435456,0,16941,0,1.0,0,18446744073709551615,890,878,-2,'Craftsman''s Writ: Golden Rod','Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.','<Penned in faded ink, the note is requesting $2oa Golden Rod, along with information about delivery location and payment. At the bottom appears text denoting this writ is transferable.>','',''),
(94222,284584,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2586,0,7500,7,2587,0,7500,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,2,0,0,0,3149824,33281,268435456,0,16941,0,1.0,0,18446744073709551615,890,878,-2,'Craftsman''s Writ: Iridescent Hammer','Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.','<Penned in faded ink, the note is requesting $2oa Iridescent Hammer, along with information about delivery location and payment. At the bottom appears text denoting this writ is transferable.>','',''),
(94223,284584,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2586,0,7500,7,2587,0,7500,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,2,0,0,0,3149824,33281,268435456,0,16941,0,1.0,0,18446744073709551615,890,878,-2,'Craftsman''s Writ: Silver Skeleton Key','Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.','<Penned in faded ink, the note is requesting $2oa Silver Skeleton Key, along with information about delivery location and payment. At the bottom appears text denoting this writ is transferable.>','',''),
(94227,284584,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2586,0,7500,7,2587,0,7500,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,2,0,0,0,3149824,33281,268435456,0,16941,0,1.0,0,18446744073709551615,890,878,-2,'Craftsman''s Writ: Big Bronze Knife','Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.','<Penned in faded ink, the note is requesting $2oa Big Bronze Knife, along with information about delivery location and payment. At the bottom appears text denoting this writ is transferable.>','',''),
(94229,284584,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2586,0,7500,7,2587,0,7500,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,2,0,0,0,3149824,33281,268435456,0,16941,0,1.0,0,18446744073709551615,890,878,-2,'Craftsman''s Writ: Ornate Spyglass','Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.','<Penned in faded ink, the note is requesting $2oa Ornate Spyglass, along with information about delivery location and payment. At the bottom appears text denoting this writ is transferable.>','',''),
(94230,284584,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2586,0,7500,7,2587,0,7500,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,2,0,0,0,3149824,33281,268435456,0,16941,0,1.0,0,18446744073709551615,890,878,-2,'Craftsman''s Writ: Explosive Sheep','Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.','<Penned in faded ink, the note is requesting $2oa Explosive Sheep, along with information about delivery location and payment. At the bottom appears text denoting this writ is transferable.>','',''),
(94231,284584,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2586,0,7500,7,2587,0,7500,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,2,0,0,0,3149824,33281,268435456,0,16941,0,1.0,0,18446744073709551615,890,878,-2,'Craftsman''s Writ: Moonsight Rifle','Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.','<Penned in faded ink, the note is requesting $2oa Moonsight Rifle, along with information about delivery location and payment. At the bottom appears text denoting this writ is transferable.>','',''),
(94233,284584,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2586,0,7500,7,2587,0,7500,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,2,0,0,0,3149824,33281,268435456,0,16941,0,1.0,0,18446744073709551615,890,878,-2,'Craftsman''s Writ: Practice Lock','Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.','<Penned in faded ink, the note is requesting $2oa Practice Lock, along with information about delivery location and payment. At the bottom appears text denoting this writ is transferable.>','',''),
(94235,284584,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2586,0,7500,7,2587,0,7500,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,2,0,0,0,3149824,33281,268435456,0,16941,0,1.0,0,18446744073709551615,890,878,-2,'Craftsman''s Writ: Gnomish Universal Remote','Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.','<Penned in faded ink, the note is requesting $2oa Gnomish Universal Remote, along with information about delivery location and payment. At the bottom appears text denoting this writ is transferable.>','',''),
(94241,284584,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2586,0,7500,7,2587,0,7500,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,2,0,0,0,3149824,33281,268435456,0,16941,0,1.0,0,18446744073709551615,890,878,-2,'Craftsman''s Writ: Dark Leather Tunic','Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.','<Penned in faded ink, the note is requesting $2oa Dark Leather Tunic, along with information about delivery location and payment. At the bottom appears text denoting this writ is transferable.>','',''),
(94243,284584,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2586,0,7500,7,2587,0,7500,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,2,0,0,0,3149824,33281,268435456,0,16941,0,1.0,0,18446744073709551615,890,878,-2,'Craftsman''s Writ: Heavy Quiver','Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.','<Penned in faded ink, the note is requesting $2oa Heavy Quiver, along with information about delivery location and payment. At the bottom appears text denoting this writ is transferable.>','',''),
(94247,284584,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2586,0,7500,7,2587,0,7500,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,2,0,0,0,3149824,33281,268435456,0,16941,0,1.0,0,18446744073709551615,890,878,-2,'Craftsman''s Writ: Lesser Wizard''s Robe','Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.','<Penned in faded ink, the note is requesting $2oa Lesser Wizard''s Robe, along with information about delivery location and payment. At the bottom appears text denoting this writ is transferable.>','',''),
(94248,284584,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2586,0,7500,7,2587,0,7500,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,2,0,0,0,3149824,33281,268435456,0,16941,0,1.0,0,18446744073709551615,890,878,-2,'Craftsman''s Writ: Blue Overalls','Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.','<Penned in faded ink, the note is requesting $2oa Blue Overalls, along with information about delivery location and payment. At the bottom appears text denoting this writ is transferable.>','',''),
(94249,284584,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2586,0,7500,7,2587,0,7500,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,2,0,0,0,3149824,33281,268435456,0,16941,0,1.0,0,18446744073709551615,890,878,-2,'Craftsman''s Writ: Azure Silk Hood','Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.','<Penned in faded ink, the note is requesting $2oa Azure Silk Hood, along with information about delivery location and payment. At the bottom appears text denoting this writ is transferable.>','',''),
(94255,284584,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2586,0,7500,7,2587,0,7500,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,2,0,0,0,3149824,33281,268435456,0,16941,0,1.0,0,18446744073709551615,890,878,-2,'Craftsman''s Writ: Spider Silk Slippers','Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.','<Penned in faded ink, the note is requesting $2oa Spider Silk Slippers, along with information about delivery location and payment. At the bottom appears text denoting this writ is transferable.>','',''),
(94256,284585,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2586,0,12500,7,2587,0,12500,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,2,0,0,0,3149824,33281,268435456,0,16941,0,1.0,0,18446744073709551615,890,878,-2,'Craftsman''s Writ: Frost Protection Potion','Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.','<Penned in faded ink, the note is requesting $2oa Frost Protection Potion, along with information about delivery location and payment. At the bottom appears text denoting this writ is transferable.>','',''),
(94270,284585,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2586,0,12500,7,2587,0,12500,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,2,0,0,0,3149824,33281,268435456,0,16941,0,1.0,0,18446744073709551615,890,878,-2,'Craftsman''s Writ: Steel Weapon Chain','Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.','<Penned in faded ink, the note is requesting $2oa Steel Weapon Chain, along with information about delivery location and payment. At the bottom appears text denoting this writ is transferable.>','',''),
(94282,284585,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2586,0,12500,7,2587,0,12500,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,2,0,0,0,3149824,33281,268435456,0,16941,0,1.0,0,18446744073709551615,890,878,-2,'Craftsman''s Writ: Craftsman''s Monocle','Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.','<Penned in faded ink, the note is requesting $2oa Craftsman''s Monocle, along with information about delivery location and payment. At the bottom appears text denoting this writ is transferable.>','',''),
(94288,284585,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2586,0,12500,7,2587,0,12500,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,2,0,0,0,3149824,33281,268435456,0,16941,0,1.0,0,18446744073709551615,890,878,-2,'Craftsman''s Writ: Mithril Frag Bomb','Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.','<Penned in faded ink, the note is requesting $2oa Mithril Frag Bomb, along with information about delivery location and payment. At the bottom appears text denoting this writ is transferable.>','',''),
(94294,284585,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2586,0,12500,7,2587,0,12500,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,2,0,0,0,3149824,33281,268435456,0,16941,0,1.0,0,18446744073709551615,890,878,-2,'Craftsman''s Writ: Dusky Bracers','Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.','<Penned in faded ink, the note is requesting $2oa Dusky Bracers, along with information about delivery location and payment. At the bottom appears text denoting this writ is transferable.>','',''),
(94312,284585,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2586,0,12500,7,2587,0,12500,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,2,0,0,0,3149824,33281,268435456,0,16941,0,1.0,0,18446744073709551615,890,878,-2,'Craftsman''s Writ: Orange Martial Shirt','Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.','<Penned in faded ink, the note is requesting $2oa Orange Martial Shirt, along with information about delivery location and payment. At the bottom appears text denoting this writ is transferable.>','',''),
(94323,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2586,0,20000,7,2587,0,20000,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,2,0,0,0,3149824,33281,268435456,0,16941,0,1.0,0,18446744073709551615,890,878,-2,'Craftsman''s Writ: Major Rejuvenation Potion','Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.','

<Penned in faded ink, the note is requesting $2oa Major Rejuvenation Potion, along with information about delivery location and payment. At the bottom appears text denoting this writ is transferable.>','',''),
(94334,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2586,0,20000,7,2587,0,20000,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,2,0,0,0,3149824,33281,268435456,0,16941,0,1.0,0,18446744073709551615,890,878,-2,'Craftsman''s Writ: Masterwork Target Dummy','Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.','<Penned in faded ink, the note is requesting $2oa Masterwork Target Dummy, along with information about delivery location and payment. At the bottom appears text denoting this writ is transferable.>','',''),
(94336,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2586,0,20000,7,2587,0,20000,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,2,0,0,0,3149824,33281,268435456,0,16941,0,1.0,0,18446744073709551615,890,878,-2,'Craftsman''s Writ: Lifelike Mechanical Toad','Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.','<Penned in faded ink, the note is requesting $2oa Lifelike Mechanical Toad, along with information about delivery location and payment. At the bottom appears text denoting this writ is transferable.>','',''),
(94354,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2586,0,20000,7,2587,0,20000,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,0,0,0,0,0,2,0,0,0,3149824,33281,268435456,0,16941,0,1.0,0,18446744073709551615,890,878,-2,'Craftsman''s Writ: Runecloth Boots','Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.','<Penned in faded ink, the note is requesting $2oa Runecloth Boots, along with information about delivery location and payment. At the bottom appears text denoting this writ is transferable.>','','');
INSERT INTO `quest_template` (`ID`,`RewardItem1`,`RewardAmount1`,`ItemDrop1`,`ItemDropQuantity1`,`RewardItem2`,`RewardAmount2`,`ItemDrop2`,`ItemDropQuantity2`,`RewardItem3`,`RewardAmount3`,`ItemDrop3`,`ItemDropQuantity3`,`RewardItem4`,`RewardAmount4`,`ItemDrop4`,`ItemDropQuantity4`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`RewardChoiceItemID5`,`RewardChoiceItemQuantity5`,`RewardChoiceItemID6`,`RewardChoiceItemQuantity6`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`RewardFactionCapIn1`,`RewardFactionID2`,`RewardFactionValue2`,`RewardFactionOverride2`,`RewardFactionCapIn2`,`RewardFactionID3`,`RewardFactionValue3`,`RewardFactionOverride3`,`RewardFactionCapIn3`,`RewardFactionID4`,`RewardFactionValue4`,`RewardFactionOverride4`,`RewardFactionCapIn4`,`RewardFactionID5`,`RewardFactionValue5`,`RewardFactionOverride5`,`RewardFactionCapIn5`,`RewardCurrencyID1`,`RewardCurrencyQty1`,`RewardCurrencyID2`,`RewardCurrencyQty2`,`RewardCurrencyID3`,`RewardCurrencyQty3`,`RewardCurrencyID4`,`RewardCurrencyQty4`,`QuestType`,`QuestInfoID`,`RewardNextQuest`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`QuestSortID`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardSpell`,`AllowableRaces`,`AcceptedSoundKitID`,`CompleteSoundKitID`,`Expansion`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`) SELECT `s`.`ID`,`s`.`RewardItem1`,`s`.`RewardAmount1`,`s`.`ItemDrop1`,`s`.`ItemDropQuantity1`,`s`.`RewardItem2`,`s`.`RewardAmount2`,`s`.`ItemDrop2`,`s`.`ItemDropQuantity2`,`s`.`RewardItem3`,`s`.`RewardAmount3`,`s`.`ItemDrop3`,`s`.`ItemDropQuantity3`,`s`.`RewardItem4`,`s`.`RewardAmount4`,`s`.`ItemDrop4`,`s`.`ItemDropQuantity4`,`s`.`RewardChoiceItemID1`,`s`.`RewardChoiceItemQuantity1`,`s`.`RewardChoiceItemID2`,`s`.`RewardChoiceItemQuantity2`,`s`.`RewardChoiceItemID3`,`s`.`RewardChoiceItemQuantity3`,`s`.`RewardChoiceItemID4`,`s`.`RewardChoiceItemQuantity4`,`s`.`RewardChoiceItemID5`,`s`.`RewardChoiceItemQuantity5`,`s`.`RewardChoiceItemID6`,`s`.`RewardChoiceItemQuantity6`,`s`.`RewardFactionID1`,`s`.`RewardFactionValue1`,`s`.`RewardFactionOverride1`,`s`.`RewardFactionCapIn1`,`s`.`RewardFactionID2`,`s`.`RewardFactionValue2`,`s`.`RewardFactionOverride2`,`s`.`RewardFactionCapIn2`,`s`.`RewardFactionID3`,`s`.`RewardFactionValue3`,`s`.`RewardFactionOverride3`,`s`.`RewardFactionCapIn3`,`s`.`RewardFactionID4`,`s`.`RewardFactionValue4`,`s`.`RewardFactionOverride4`,`s`.`RewardFactionCapIn4`,`s`.`RewardFactionID5`,`s`.`RewardFactionValue5`,`s`.`RewardFactionOverride5`,`s`.`RewardFactionCapIn5`,`s`.`RewardCurrencyID1`,`s`.`RewardCurrencyQty1`,`s`.`RewardCurrencyID2`,`s`.`RewardCurrencyQty2`,`s`.`RewardCurrencyID3`,`s`.`RewardCurrencyQty3`,`s`.`RewardCurrencyID4`,`s`.`RewardCurrencyQty4`,`s`.`QuestType`,`s`.`QuestInfoID`,`s`.`RewardNextQuest`,`s`.`StartItem`,`s`.`Flags`,`s`.`FlagsEx`,`s`.`FlagsEx2`,`s`.`TimeAllowed`,`s`.`QuestSortID`,`s`.`RewardXPDifficulty`,`s`.`RewardXPMultiplier`,`s`.`RewardSpell`,`s`.`AllowableRaces`,`s`.`AcceptedSoundKitID`,`s`.`CompleteSoundKitID`,`s`.`Expansion`,`s`.`LogTitle`,`s`.`LogDescription`,`s`.`QuestDescription`,`s`.`AreaDescription`,`s`.`QuestCompletionLog` FROM `forever_writ_q` `s` WHERE `s`.`ID` IN (SELECT `quest` FROM `forever_writ_ok`) AND NOT EXISTS (SELECT 1 FROM `quest_template` `x` WHERE `x`.`ID`=`s`.`ID`);
DROP TEMPORARY TABLE IF EXISTS `forever_writ_q`;

-- Their objectives: the writ itself and the crafted item it asks for.
DROP TEMPORARY TABLE IF EXISTS `forever_writ_o`;
CREATE TEMPORARY TABLE `forever_writ_o` SELECT `ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Description` FROM `quest_objectives` WHERE 0;
INSERT INTO `forever_writ_o` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Description`) VALUES
(468047,94004,1,0,2,264011,1,32,''),
(468048,94004,1,1,3,3391,1,32,''),
(468131,94212,1,0,0,264012,1,32,''),
(468132,94212,1,1,1,3383,1,32,''),
(468133,94213,1,0,0,264013,1,32,''),
(468134,94213,1,1,1,3385,1,32,''),
(468139,94214,1,0,0,264014,1,32,''),
(468140,94214,1,1,1,6048,1,32,''),
(468141,94215,1,0,0,264015,1,32,''),
(468142,94215,1,1,1,5634,1,32,''),
(468143,94216,1,0,0,264016,1,32,''),
(468144,94216,1,1,1,3390,1,32,''),
(468145,94217,1,0,0,264017,1,32,''),
(468146,94217,1,1,1,3388,1,32,''),
(468147,94218,1,0,0,264018,1,32,''),
(468148,94218,1,1,1,8951,1,32,''),
(468149,94219,1,0,0,264019,1,32,''),
(468150,94219,1,1,1,5996,1,32,''),
(468153,94221,1,0,0,264021,1,32,''),
(468154,94221,1,1,1,11128,1,32,''),
(468155,94222,1,0,0,264022,1,32,''),
(468156,94222,1,1,1,5541,1,32,''),
(468157,94223,1,0,0,264023,1,32,''),
(468158,94223,1,1,1,15869,1,32,''),
(468165,94227,1,0,0,264027,1,32,''),
(468166,94227,1,1,1,3848,1,32,''),
(468169,94229,1,0,0,264029,1,32,''),
(468170,94229,1,1,1,5507,1,32,''),
(468171,94230,1,0,0,264030,1,32,''),
(468172,94230,1,1,1,4384,1,32,''),
(468173,94231,1,0,0,264031,1,32,''),
(468174,94231,1,1,1,4383,1,32,''),
(468177,94233,1,0,0,264033,1,32,''),
(468178,94233,1,1,1,6712,1,32,''),
(468181,94235,1,0,0,264035,1,32,''),
(468182,94235,1,1,1,7506,1,32,''),
(468193,94241,1,0,0,264041,1,32,''),
(468194,94241,1,1,1,2317,1,32,''),
(468197,94243,1,0,0,264043,1,32,''),
(468198,94243,1,1,1,7371,1,32,''),
(468205,94247,1,0,0,264047,1,32,''),
(468206,94247,1,1,1,5766,1,32,''),
(468207,94248,1,0,0,264048,1,32,''),
(468208,94248,1,1,1,6263,1,32,''),
(468209,94249,1,0,0,264049,1,32,''),
(468210,94249,1,1,1,7048,1,32,''),
(468221,94255,1,0,0,264055,1,32,''),
(468222,94255,1,1,1,4321,1,32,''),
(468223,94256,1,0,0,264056,1,32,''),
(468224,94256,1,1,1,6050,1,32,''),
(468251,94270,1,0,0,264070,1,32,''),
(468252,94270,1,1,1,6041,1,32,''),
(468275,94282,1,0,0,264082,1,32,''),
(468276,94282,1,1,1,4393,1,32,''),
(468287,94288,1,0,0,264088,1,32,''),
(468288,94288,1,1,1,10514,1,32,''),
(468299,94294,1,0,0,264094,1,32,''),
(468300,94294,1,1,1,7378,1,32,''),
(468335,94312,1,0,0,264112,1,32,''),
(468336,94312,1,1,1,10052,1,32,''),
(468357,94323,1,0,0,264123,1,32,''),
(468358,94323,1,1,1,18253,1,32,''),
(468379,94334,1,0,0,264134,1,32,''),
(468380,94334,1,1,1,16023,1,32,''),
(468383,94336,1,0,0,264136,1,32,''),
(468384,94336,1,1,1,15996,1,32,''),
(468419,94354,1,0,0,264154,1,32,''),
(468420,94354,1,1,1,13864,1,32,'');
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Description`) SELECT `s`.`ID`,`s`.`QuestID`,`s`.`Type`,`s`.`Order`,`s`.`StorageIndex`,`s`.`ObjectID`,`s`.`Amount`,`s`.`Flags`,`s`.`Description` FROM `forever_writ_o` `s` WHERE `s`.`QuestID` IN (SELECT `quest` FROM `forever_writ_ok`) AND NOT EXISTS (SELECT 1 FROM `quest_objectives` `x` WHERE `x`.`ID`=`s`.`ID`);
DROP TEMPORARY TABLE IF EXISTS `forever_writ_o`;

DROP TEMPORARY TABLE IF EXISTS `forever_writ_x`;
CREATE TEMPORARY TABLE `forever_writ_x` SELECT `ID`,`QuestLevel`,`MinLevel`,`MaxLevel` FROM `quest_classic_level` WHERE 0;
INSERT INTO `forever_writ_x` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES
(94004,60,1,0),
(94212,60,1,0),
(94213,60,1,0),
(94214,60,1,0),
(94215,60,1,0),
(94216,60,1,0),
(94217,60,1,0),
(94218,60,1,0),
(94219,60,1,0),
(94221,60,1,0),
(94222,60,1,0),
(94223,60,1,0),
(94227,60,1,0),
(94229,60,1,0),
(94230,60,1,0),
(94231,60,1,0),
(94233,60,1,0),
(94235,60,1,0),
(94241,60,1,0),
(94243,60,1,0),
(94247,60,1,0),
(94248,60,1,0),
(94249,60,1,0),
(94255,60,1,0),
(94256,60,1,0),
(94270,60,1,0),
(94282,60,1,0),
(94288,60,1,0),
(94294,60,1,0),
(94312,60,1,0),
(94323,60,1,0),
(94334,60,1,0),
(94336,60,1,0),
(94354,60,1,0);
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) SELECT `s`.`ID`,`s`.`QuestLevel`,`s`.`MinLevel`,`s`.`MaxLevel` FROM `forever_writ_x` `s` WHERE `s`.`ID` IN (SELECT `quest` FROM `forever_writ_ok`) AND NOT EXISTS (SELECT 1 FROM `quest_classic_level` `x` WHERE `x`.`ID`=`s`.`ID`);
DROP TEMPORARY TABLE IF EXISTS `forever_writ_x`;

DROP TEMPORARY TABLE IF EXISTS `forever_writ_x`;
CREATE TEMPORARY TABLE `forever_writ_x` SELECT `ID`,`LevelType`,`QuestLevel` FROM `quest_template_classic_level` WHERE 0;
INSERT INTO `forever_writ_x` (`ID`,`LevelType`,`QuestLevel`) VALUES
(94004,2,60),
(94212,2,60),
(94213,2,60),
(94214,2,60),
(94215,2,60),
(94216,2,60),
(94217,2,60),
(94218,2,60),
(94219,2,60),
(94221,2,60),
(94222,2,60),
(94223,2,60),
(94227,2,60),
(94229,2,60),
(94230,2,60),
(94231,2,60),
(94233,2,60),
(94235,2,60),
(94241,2,60),
(94243,2,60),
(94247,2,60),
(94248,2,60),
(94249,2,60),
(94255,2,60),
(94256,2,60),
(94270,2,60),
(94282,2,60),
(94288,2,60),
(94294,2,60),
(94312,2,60),
(94323,2,60),
(94334,2,60),
(94336,2,60),
(94354,2,60);
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) SELECT `s`.`ID`,`s`.`LevelType`,`s`.`QuestLevel` FROM `forever_writ_x` `s` WHERE `s`.`ID` IN (SELECT `quest` FROM `forever_writ_ok`) AND NOT EXISTS (SELECT 1 FROM `quest_template_classic_level` `x` WHERE `x`.`ID`=`s`.`ID` AND `x`.`LevelType`=`s`.`LevelType`);
DROP TEMPORARY TABLE IF EXISTS `forever_writ_x`;

DROP TEMPORARY TABLE IF EXISTS `forever_writ_x`;
CREATE TEMPORARY TABLE `forever_writ_x` SELECT `QuestID`,`TreasurePickerID`,`OrderIndex` FROM `quest_treasure_pickers` WHERE 0;
INSERT INTO `forever_writ_x` (`QuestID`,`TreasurePickerID`,`OrderIndex`) VALUES
(94004,4817,0),
(94212,4817,0),
(94213,4817,0),
(94214,4817,0),
(94215,4817,0),
(94216,4817,0),
(94217,4817,0),
(94218,4817,0),
(94219,4817,0),
(94221,4817,0),
(94222,4817,0),
(94223,4817,0),
(94227,4817,0),
(94229,4817,0),
(94230,4817,0),
(94231,4817,0),
(94233,4817,0),
(94235,4817,0),
(94241,4817,0),
(94243,4817,0),
(94247,4817,0),
(94248,4817,0),
(94249,4817,0),
(94255,4817,0),
(94256,4818,0),
(94270,4818,0),
(94282,4818,0),
(94288,4818,0),
(94294,4818,0),
(94312,4818,0),
(94323,4819,0),
(94334,4819,0),
(94336,4819,0),
(94354,4819,0);
INSERT INTO `quest_treasure_pickers` (`QuestID`,`TreasurePickerID`,`OrderIndex`) SELECT `s`.`QuestID`,`s`.`TreasurePickerID`,`s`.`OrderIndex` FROM `forever_writ_x` `s` WHERE `s`.`QuestID` IN (SELECT `quest` FROM `forever_writ_ok`) AND NOT EXISTS (SELECT 1 FROM `quest_treasure_pickers` `x` WHERE `x`.`QuestID`=`s`.`QuestID` AND `x`.`TreasurePickerID`=`s`.`TreasurePickerID`);
DROP TEMPORARY TABLE IF EXISTS `forever_writ_x`;

-- What the customer says on hand-in and while you still lack the item.
DROP TEMPORARY TABLE IF EXISTS `forever_writ_x`;
CREATE TEMPORARY TABLE `forever_writ_x` SELECT `ID`,`RewardText` FROM `quest_offer_reward` WHERE 0;
INSERT INTO `forever_writ_x` (`ID`,`RewardText`) VALUES
(94212,'I will admit, I expected the treacherous winds of the highlands to tear that letter to shreds. I had not imagined that someone would see my humble request, let alone deliver it straight to me.$B$BYour efforts are kind and admirable, $R. I will use this to aid my meditation.$B$BFeel free to stay and share a tale or two of your travels. I enjoy the company.'),
(94213,'Ah, is this the potion I requested?$B$B<The elven woman respectfully takes the vial from you.>$B$BYour arrival is timely, and your generosity deeply appreciated. I accept this, and offer you a small token of my gratitude.$B$BThank you, may we meet again.'),
(94214,'Then again, when you''re fulfilling a rush order like this one, I can''t blame you for wanting to capitalize on your gains.$B$BHere you go, pal. Thanks for hooking a goblin up with some much-needed shadow protection potions. Have you SEEN the stuff that goes on out here?'),
(94215,'<You waste little time offering the wiggling mass the Free Action Potion that was requested. It seems either unaware of your presence, or unable to claim the item.$B$BA handful of coins are scattered just beside the cocoon. You may decide to leave the potion there, and take the coins for yourself. Nature will surely sort itself out, in that case.>'),
(94216,'<Ziz continues to talk in a hushed tone.>$B$BI''m not about to give you the whole spiel about how I got into this position, but here''s some advice for you.$B$BSometimes, all you gotta do to impress your new boss is take credit for someone else''s work. So you''re going to hand over the elixir, and I am gonna talk about how much blood, sweat, and tears I poured into making it.$B$BIt''s a new gig, okay? I need to make a good first impression!'),
(94217,'Exactly what Short John Mithril ordered!$B$BHere''s ye'' coin. I''d keep it clutched to your chest as ye'' scuttle out of here, the arena combatants thirst for riches as much as they thirst for blood!'),
(94219,'Water breathing draughts are a necessity if you plan to camp out here during the rainy nights. I tend to take my naps under that bridge over there, but sometimes the underside gets flooded.$B$BNow, I can sleep easy knowing my nightmares of drowning are only just nightmares.$B$BCome to think of it, I probably should have ordered some to resell...'),
(94221,'Ah, the Golden Rod I requested. I never expected it to arrive. I was considering going back to Ironforge to purchase one off the auction house. You saved me a trip, something these old feet greatly thank you for.$B$BI do not yet know how I can use this to commune with the Binding Stones, let alone if I even can, but I suspect this brings me one step closer.$B$BIn the worst case, well, I am happy to have a new cane.'),
(94229,'Oh. Oh! You''re the engineer? I suppose at the very least you are the delivery boy in any case.$B$BPlease hand over the spyglass. I have little time and many things to inspect.'),
(94230,'The Explosive Sheep? It''s a bit smaller than I had hoped but...$B$B<She reached out to claim it, but then cautiously took it out from your arms. It did not take long before she delicately placed it down.>$B$BI''m hoping this does enough damage to scare a few off...'),
(94235,'Seems we are in luck, the remote has arrived! Looks like you precalibrated it for us which, I''ll admit, isn''t ideal for this scenario.$B$BI should be able to reverse engineer it in no time. Then maybe, hopefully, I''ll be able to take a much needed break. Feels like I''ve been stuck fumbling with this teleporter''s controls for months on end!'),
(94247,'<Alan speaks in a whisper.>$B$BDon''t you think it is a little suspicious to be carrying elegant robes in broad daylight to a man garbed in dark leathers?$B$BWell, ahem, fortunately I am out here on behalf of the Kirin Tor, so there is no shady transaction about to take place. None at all.$B$BThe robe, please.'),
(94248,'The Blue Overalls! Thank goodness, I have a proper change of clothes.$B$BTake this, and please be on your way. I do not have time to chat, I must keep an eye on the farm and can''t risk more distractions.'),
(94249,'It da hood me order-er-ed!$B$BMe forgot why wanted in first place, but me take anyway.$B$BHere, take shiny coin. It fell out of slime monster. Lots and lots of them!'),
(94255,'Are these my new boots?$B$B<Kixxle looks very excited, but it fades immediately upon setting his eyes upon them.>$B$BAh. I thought I had cancelled the order for slippers once I realized how foolish it would be to trudge around a swamp with my toes hanging out. I ordered a new pair of proper boots too, but they still haven''t arrived yet.$B$BOh well, pleasure doing business with you. I''ll keep these for later!'),
(94270,'This weapon chain? This keep club in hand?$B$BUgbert thank you. Ugbert strongest ogre in all of Dustwallow!'),
(94282,'<Rather than question the current predicament, you carefully reach forward with the Craftsman''s Monocle in hand and place it vaguely where a monocle might be on an ordinary person.$B$BThe slime responds in kind, expelling out a handful of coins from elsewhere on its body. How disgusting.>'),
(94288,'Oh, you''re just the delivery boy, never mind on that offer. I doubt you''d survive.$B$BThese bombs though? Exactly what Bigblast ordered. I''m out here planning a possible new Steamwheedle-- actually, y''know what, I bet you aren''t interested, so I will keep my trap shut.'),
(94294,'<You aren''t quite sure where to put the bracers, so you begin to place them nearby on a pile of debris.$B$BThe slime leers forward, silently threatening to make you its next meal.$B$BInstead, you quickly toss the bracers haphazardly toward the creature. It devours its leathery meal, and spits out a few coins as payment. It no longer seems to have a hungering demeanor toward you, for now.>'),
(94312,'Huh? What''s this?$B$B<The goblin takes the shirt and examines it with an increasingly bewildered expression. Showing him the writ does not help your case.>$B$BWhat an ugly thing! I wouldn''t be caught DEAD wearing this! Sorry pal, but I think whoever wrote this got mixed up. I''m waitin'' for a delivery of parts, bombs, and the like. Not a shirt.$B$BI don''t want any bad blood though, you look scary enough as it is. Take some coin for your trouble.'),
(94323,'In fields wrought with death and sorrow, some old bones and broken crates are an ordinary sight.$B$BBut this little spot is different. Clearly someone was here before me, but I think nature tried to renew itself here, too. Clearly, it failed.$B$BI have been waiting for the potion you bring to arrive. I suspect nothing will come of it, but I intend to use it with the leftover herbs here in an attempt to breathe some fresh life in this corner of the plaguelands.'),
(94334,'I... What IS this? What use would I have for some flimsy, heavy crate?$B$B<Rayan skeptically listens to your description before eyeballing the compacted device.>$B$BI fail to believe that whatever is in here can withstand magical practice of our caliber, but I suppose I ought to show appreciation for your admirable efforts.$B$BHere you go. Don''t spend it all in one place.');
INSERT INTO `quest_offer_reward` (`ID`,`RewardText`) SELECT `s`.`ID`,`s`.`RewardText` FROM `forever_writ_x` `s` WHERE `s`.`ID` IN (SELECT `quest` FROM `forever_writ_ok`) AND NOT EXISTS (SELECT 1 FROM `quest_offer_reward` `x` WHERE `x`.`ID`=`s`.`ID`);
DROP TEMPORARY TABLE IF EXISTS `forever_writ_x`;

DROP TEMPORARY TABLE IF EXISTS `forever_writ_x`;
CREATE TEMPORARY TABLE `forever_writ_x` SELECT `ID`,`CompletionText` FROM `quest_request_items` WHERE 0;
INSERT INTO `forever_writ_x` (`ID`,`CompletionText`) VALUES
(94004,'Wut?'),
(94212,'Come, warm yourself by the fire.'),
(94213,'Good day, $R. I appreciate the company but my attention is elsewhere. If we do not have business, please be on your way.'),
(94214,'Heyo, for future reference, you shouldn''t come charging at full-speed toward a goblin with a bodyguard! You never know what might happen.'),
(94215,'<You approach a thrashing creature clearly trapped in spider silk, at the precise location the writ indicated.>'),
(94216,'Are you here about...$B$B<Ziz looks around his tiny hut suspiciously, and lowers his voice.>$B$BThe elixir?'),
(94217,'Yarr, you be bringin'' me my elixir?'),
(94218,'If YOU are the assassin that the crewmen keep warning me about, well, you had better think twice before charging at ME, buster!'),
(94222,'AHHH! Oh... Me thought you look like slime monster.'),
(94227,'<The chicken... clears its throat?>$B$BCluck, cluck.'),
(94229,'Whoa! I almost didn''t see you there. I might have seen you coming sooner if a damned engineer would at last deliver my order.'),
(94230,'<The distraught woman peers into the nearby farmstead. She notices you approach a moment before it might have startled her.>$B$BPlease tell me you are delivering one of my crafting orders!'),
(94231,'Hey, HEY, man, haven''t you heard of a little thing called "subtlety"? Spell it out with me, S-U-B...LETY. You''re going to blow my cover!'),
(94233,'I watched this whole place get burned to the ground and that keep toppled over. It was glorious.$B$BNever expected a group of bandits to try using this place as a base of operations.'),
(94235,'Careful where you walk, Gizmo! This thing likes to activate when you least expect it, and we don''t quite have a handle on where it can take you when we aren''t actively manning the controls.'),
(94241,'WHAT???'),
(94243,'Need some work?'),
(94247,'<The man stands at attention, peering over the mountainside toward Dalaran. He regards your presence with a subtle wave of a hand, beckoning you closer.>'),
(94248,'Oh! Please keep your voice down--we don''t need to draw any further attention to ourselves.$B$BDo you have something for me?'),
(94249,'AHHHH! Oh, it just a $R.$B$BHi $R!'),
(94256,'Hello, skyborne! That twinkle in your eye makes me guess you have a special delivery!'),
(94270,'Sometimes friend is foe, and try to steal Ugbert''s club.'),
(94282,'<The slime blurbles greedily.>'),
(94288,'Hey, can I interest you in a scouting mission?'),
(94294,'<The slime acknowledges your presence by drooling profusely.>'),
(94312,'Keep your feet out of the water if you know what''s good for you!'),
(94323,'I could not help but be drawn to this landmark as I was passing. It is so strange. Wouldn''t you agree?'),
(94334,'Are you aware that you are tracking mud with every step? If you can''t be bothered to wipe your soles on entry, consider taking off your shoes before storming through someone else''s domain.');
INSERT INTO `quest_request_items` (`ID`,`CompletionText`) SELECT `s`.`ID`,`s`.`CompletionText` FROM `forever_writ_x` `s` WHERE `s`.`ID` IN (SELECT `quest` FROM `forever_writ_ok`) AND NOT EXISTS (SELECT 1 FROM `quest_request_items` `x` WHERE `x`.`ID`=`s`.`ID`);
DROP TEMPORARY TABLE IF EXISTS `forever_writ_x`;

-- Who takes the writ in.
INSERT INTO `creature_questender` (`id`,`quest`) SELECT `s`.`id`,`s`.`quest` FROM `forever_writ_e` `s` WHERE `s`.`quest` IN (SELECT `quest` FROM `forever_writ_ok`) AND EXISTS (SELECT 1 FROM `creature` `c` WHERE `c`.`id`=`s`.`id`) AND NOT EXISTS (SELECT 1 FROM `creature_questender` `x` WHERE `x`.`id`=`s`.`id` AND `x`.`quest`=`s`.`quest`);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (2921,3134,4201,4720,6626,7853,8305,11705,14437,14508,257281,257282,257296,257304,257315,257316,257317,257673,261928,261932,262024,262072,262379,270919) AND (`npcflag`&2)=0 AND `entry` IN (SELECT `id` FROM `creature_questender` WHERE `quest` BETWEEN 94004 AND 94360);
INSERT INTO `gameobject_questender` (`id`,`quest`) SELECT `s`.`id`,`s`.`quest` FROM `forever_writ_g` `s` WHERE `s`.`quest` IN (SELECT `quest` FROM `forever_writ_ok`) AND EXISTS (SELECT 1 FROM `gameobject` `c` WHERE `c`.`id`=`s`.`id`) AND NOT EXISTS (SELECT 1 FROM `gameobject_questender` `x` WHERE `x`.`id`=`s`.`id` AND `x`.`quest`=`s`.`quest`);
DROP TEMPORARY TABLE IF EXISTS `forever_writ_e`;
DROP TEMPORARY TABLE IF EXISTS `forever_writ_g`;

-- The writs join their tier's world drop list.
DROP TEMPORARY TABLE IF EXISTS `forever_writ_r`;
CREATE TEMPORARY TABLE `forever_writ_r` SELECT `Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment` FROM `reference_loot_template` WHERE 0;
INSERT INTO `forever_writ_r` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(9500001,0,264011,0,0,1,1,1,1,'Craftsman''s Writ, Journeyman (quest 94004)'),
(9500001,0,264012,0,0,1,1,1,1,'Craftsman''s Writ, Journeyman (quest 94212)'),
(9500001,0,264013,0,0,1,1,1,1,'Craftsman''s Writ, Journeyman (quest 94213)'),
(9500001,0,264014,0,0,1,1,1,1,'Craftsman''s Writ, Journeyman (quest 94214)'),
(9500001,0,264015,0,0,1,1,1,1,'Craftsman''s Writ, Journeyman (quest 94215)'),
(9500001,0,264016,0,0,1,1,1,1,'Craftsman''s Writ, Journeyman (quest 94216)'),
(9500001,0,264017,0,0,1,1,1,1,'Craftsman''s Writ, Journeyman (quest 94217)'),
(9500001,0,264018,0,0,1,1,1,1,'Craftsman''s Writ, Journeyman (quest 94218)'),
(9500001,0,264019,0,0,1,1,1,1,'Craftsman''s Writ, Journeyman (quest 94219)'),
(9500001,0,264021,0,0,1,1,1,1,'Craftsman''s Writ, Journeyman (quest 94221)'),
(9500001,0,264022,0,0,1,1,1,1,'Craftsman''s Writ, Journeyman (quest 94222)'),
(9500001,0,264023,0,0,1,1,1,1,'Craftsman''s Writ, Journeyman (quest 94223)'),
(9500001,0,264027,0,0,1,1,1,1,'Craftsman''s Writ, Journeyman (quest 94227)'),
(9500001,0,264029,0,0,1,1,1,1,'Craftsman''s Writ, Journeyman (quest 94229)'),
(9500001,0,264030,0,0,1,1,1,1,'Craftsman''s Writ, Journeyman (quest 94230)'),
(9500001,0,264031,0,0,1,1,1,1,'Craftsman''s Writ, Journeyman (quest 94231)'),
(9500001,0,264033,0,0,1,1,1,1,'Craftsman''s Writ, Journeyman (quest 94233)'),
(9500001,0,264035,0,0,1,1,1,1,'Craftsman''s Writ, Journeyman (quest 94235)'),
(9500001,0,264041,0,0,1,1,1,1,'Craftsman''s Writ, Journeyman (quest 94241)'),
(9500001,0,264043,0,0,1,1,1,1,'Craftsman''s Writ, Journeyman (quest 94243)'),
(9500001,0,264047,0,0,1,1,1,1,'Craftsman''s Writ, Journeyman (quest 94247)'),
(9500001,0,264048,0,0,1,1,1,1,'Craftsman''s Writ, Journeyman (quest 94248)'),
(9500001,0,264049,0,0,1,1,1,1,'Craftsman''s Writ, Journeyman (quest 94249)'),
(9500001,0,264055,0,0,1,1,1,1,'Craftsman''s Writ, Journeyman (quest 94255)'),
(9500002,0,264056,0,0,1,1,1,1,'Craftsman''s Writ, Expert (quest 94256)'),
(9500002,0,264070,0,0,1,1,1,1,'Craftsman''s Writ, Expert (quest 94270)'),
(9500002,0,264082,0,0,1,1,1,1,'Craftsman''s Writ, Expert (quest 94282)'),
(9500002,0,264088,0,0,1,1,1,1,'Craftsman''s Writ, Expert (quest 94288)'),
(9500002,0,264094,0,0,1,1,1,1,'Craftsman''s Writ, Expert (quest 94294)'),
(9500002,0,264112,0,0,1,1,1,1,'Craftsman''s Writ, Expert (quest 94312)'),
(9500003,0,264123,0,0,1,1,1,1,'Craftsman''s Writ, Artisan (quest 94323)'),
(9500003,0,264134,0,0,1,1,1,1,'Craftsman''s Writ, Artisan (quest 94334)'),
(9500003,0,264136,0,0,1,1,1,1,'Craftsman''s Writ, Artisan (quest 94336)'),
(9500003,0,264154,0,0,1,1,1,1,'Craftsman''s Writ, Artisan (quest 94354)');
INSERT INTO `reference_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) SELECT `s`.`Entry`,`s`.`ItemType`,`s`.`Item`,`s`.`Chance`,`s`.`QuestRequired`,`s`.`LootMode`,`s`.`GroupId`,`s`.`MinCount`,`s`.`MaxCount`,`s`.`Comment` FROM `forever_writ_r` `s` WHERE CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(`s`.`Comment`,'quest ',-1),')',1) AS UNSIGNED) IN (SELECT `quest` FROM `forever_writ_ok`) AND NOT EXISTS (SELECT 1 FROM `reference_loot_template` `x` WHERE `x`.`Entry`=`s`.`Entry` AND `x`.`ItemType`=`s`.`ItemType` AND `x`.`Item`=`s`.`Item`);
DROP TEMPORARY TABLE IF EXISTS `forever_writ_r`;

DROP TEMPORARY TABLE IF EXISTS `forever_writ_ok`;
