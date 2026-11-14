-- WoW Forever: 7 items that still had no name or stats in our data, from the "Cache_enUS_1411.rar" cache folder (client
-- 1.60.1.70938, Blizzard's live realm): The Jaw Breaker, Amulet of the Redeemed, Legplates of Vigilance, Band of Mending, Vile
-- Concoction, Scarlet Hearthstone (284163, 284164). Ward of the Dead (217727) comes with the live pushes in 2026_11_14_55.
-- Item + ItemSparse records as Blizzard sends them. Made with tools/full_forever/live_hotfix_sql.py.
-- hotfix_data ids 2092000-2092999. Safe to run again.

DELETE FROM `item` WHERE `ID` IN (22322,22327,22328,22334,217716,284163,284164);
INSERT INTO `item` (`ID`,`ClassID`,`SubclassID`,`Material`,`InventoryType`,`SheatheType`,`ItemPetFoodID`,`SoundOverrideSubclassID`,`IconFileDataID`,`ItemGroupSoundsID`,`ContentTuningID`,`ModifiedCraftingReagentItemID`,`Unknown1200`,`CraftingQualityID`,`ItemSquishEraID`,`RecraftReagentCountPercentage`,`OrderSource`,`VerifiedBuild`) VALUES
(22322,2,4,2,13,3,0,-1,133490,8,0,0,0,0,0,0,0,70938),
(22327,4,0,3,2,0,0,-1,133295,14,0,0,0,0,0,0,0,70938),
(22328,4,4,6,7,0,0,-1,134584,11,0,0,0,0,0,0,0,70938),
(22334,4,0,5,11,0,0,-1,133347,14,0,0,0,0,0,0,0,70938),
(217716,0,8,0,0,0,0,-1,134799,16,0,0,0,0,0,0,0,70938),
(284163,15,0,0,0,0,0,-1,451164,24,0,0,0,0,0,0,0,70938),
(284164,15,4,5,0,0,0,-1,451164,7,0,0,0,0,0,0,0,70938);
DELETE FROM `item_sparse` WHERE `ID` IN (22322,22327,22328,22334,217716,284163,284164);
INSERT INTO `item_sparse` (`ID`,`Description`,`Display3`,`Display2`,`Display1`,`Display`,`ExpansionID`,`DmgVariance`,`LimitCategory`,`DurationInInventory`,`QualityModifier`,`BagFamily`,`StartQuestID`,`LanguageID`,`ItemRange`,`StatPercentageOfSocket1`,`StatPercentageOfSocket2`,`StatPercentageOfSocket3`,`StatPercentageOfSocket4`,`StatPercentageOfSocket5`,`StatPercentageOfSocket6`,`StatPercentageOfSocket7`,`StatPercentageOfSocket8`,`StatPercentageOfSocket9`,`StatPercentageOfSocket10`,`StatPercentEditor1`,`StatPercentEditor2`,`StatPercentEditor3`,`StatPercentEditor4`,`StatPercentEditor5`,`StatPercentEditor6`,`StatPercentEditor7`,`StatPercentEditor8`,`StatPercentEditor9`,`StatPercentEditor10`,`StatModifierBonusStat1`,`StatModifierBonusStat2`,`StatModifierBonusStat3`,`StatModifierBonusStat4`,`StatModifierBonusStat5`,`StatModifierBonusStat6`,`StatModifierBonusStat7`,`StatModifierBonusStat8`,`StatModifierBonusStat9`,`StatModifierBonusStat10`,`Stackable`,`MaxCount`,`MinReputation`,`RequiredAbility`,`AllowableRace1`,`AllowableRace2`,`SellPrice`,`BuyPrice`,`VendorStackCount`,`PriceVariance`,`PriceRandomValue`,`Flags1`,`Flags2`,`Flags3`,`Flags4`,`Flags5`,`FactionRelated`,`ModifiedCraftingReagentItemID`,`ContentTuningID`,`PlayerLevelToItemLevelCurveID`,`ItemLevelOffsetCurveID`,`ItemLevelOffsetItemLevel`,`ItemSquishEraID`,`ItemNameDescriptionID`,`RequiredTransmogHoliday`,`RequiredHoliday`,`GemProperties`,`SocketMatchEnchantmentId`,`TotemCategoryID`,`InstanceBound`,`ZoneBound1`,`ZoneBound2`,`ItemSet`,`LockID`,`PageID`,`ItemDelay`,`MinFactionID`,`RequiredSkillRank`,`RequiredSkill`,`ItemLevel`,`AllowableClass`,`ArtifactID`,`SpellWeight`,`SpellWeightCategory`,`SocketType1`,`SocketType2`,`SocketType3`,`SheatheType`,`Material`,`PageMaterialID`,`Bonding`,`DamageDamageType`,`ContainerSlots`,`RequiredPVPMedal`,`RequiredPVPRank`,`RequiredLevel`,`InventoryType`,`OverallQualityID`,`AmmunitionType`,`VerifiedBuild`) VALUES
(22322,'Not edible','','','','The Jaw Breaker',0,0.6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,9333,4000,4000,0,0,0,0,0,0,0,32,125,38,-1,-1,-1,-1,-1,-1,-1,1,0,0,0,-1,-1,53054,265271,1,1,1,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1600,0,0,0,61,-1,0,0,0,0,0,0,3,2,0,1,0,0,0,0,56,13,3,0,70938),
(22327,'','','','','Amulet of the Redeemed',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5000,4500,4000,7500,2500,0,0,0,0,0,5,7,6,41,42,-1,-1,-1,-1,-1,1,0,0,0,-1,-1,2535,10140,1,1,1,64,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,63,-1,0,0,0,0,0,0,0,3,0,1,0,0,0,0,58,2,3,0,70938),
(22328,'','','','','Legplates of Vigilance',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6111,4167,2777,0,0,0,0,0,0,0,7,12,31,-1,-1,-1,-1,-1,-1,-1,1,0,0,0,-1,-1,22208,111042,1,1,1,0,4,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,63,-1,0,0,0,0,0,0,0,6,0,1,0,0,0,0,58,7,3,0,70938),
(22334,'','','','','Band of Mending',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3500,3500,3000,15500,5000,0,0,0,0,0,7,5,6,41,42,-1,-1,-1,-1,-1,1,0,0,0,-1,-1,13782,55130,1,1,1,524288,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,62,-1,0,0,0,0,0,0,0,5,0,1,0,0,0,0,57,11,3,0,70938),
(217716,'','','','','Vile Concoction',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,5,0,0,0,-1,-1,0,0,1,1,1.0059,66624,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,70938),
(284163,'','','','','Scarlet Hearthstone',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,1,1,0,0,-1,-1,0,0,1,1,0.9928,163904,20484,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,70938),
(284164,'','','','','Scarlet Hearthstone',0,0,0,0,0,524288,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,1,1,0,0,-1,-1,0,14341,1,1,0.9965,32832,16388,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,35,-1,0,0,0,0,0,0,0,5,0,1,0,0,0,0,0,0,3,0,70938);
DELETE FROM `hotfix_data` WHERE `Id` BETWEEN 2092000 AND 2092999;
DELETE FROM `hotfix_data` WHERE (`TableHash`,`RecordId`) IN ((1344507586,22322),(1344507586,22327),(1344507586,22328),(1344507586,22334),(1344507586,217716),(1344507586,284163),(1344507586,284164),(2442913102,22322),(2442913102,22327),(2442913102,22328),(2442913102,22334),(2442913102,217716),(2442913102,284163),(2442913102,284164));
INSERT INTO `hotfix_data` (`Id`,`UniqueId`,`TableHash`,`RecordId`,`Status`,`VerifiedBuild`) VALUES
(2092000,1397812000,1344507586,22322,1,70938),
(2092001,1397812001,1344507586,22327,1,70938),
(2092002,1397812002,1344507586,22328,1,70938),
(2092003,1397812003,1344507586,22334,1,70938),
(2092004,1397812004,1344507586,217716,1,70938),
(2092005,1397812005,1344507586,284163,1,70938),
(2092006,1397812006,1344507586,284164,1,70938),
(2092007,1397812007,2442913102,22322,1,70938),
(2092008,1397812008,2442913102,22327,1,70938),
(2092009,1397812009,2442913102,22328,1,70938),
(2092010,1397812010,2442913102,22334,1,70938),
(2092011,1397812011,2442913102,217716,1,70938),
(2092012,1397812012,2442913102,284163,1,70938),
(2092013,1397812013,2442913102,284164,1,70938);
