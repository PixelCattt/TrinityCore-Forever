-- WoW Forever: 3 items that still had no name or stats in our data, from a player cache of 11-15 (client 1.60.1.70938,
-- Blizzard's live realm): Hardened Stone Band, Scepter of Interminable Focus, Hammer of Divine Might.
-- Item + ItemSparse records as Blizzard sends them. Made with tools/full_forever/live_hotfix_sql.py.
-- hotfix_data ids 2096000-2096999. Safe to run again.

DELETE FROM `item` WHERE `ID` IN (18674,22329,22333);
INSERT INTO `item` (`ID`,`ClassID`,`SubclassID`,`Material`,`InventoryType`,`SheatheType`,`ItemPetFoodID`,`SoundOverrideSubclassID`,`IconFileDataID`,`ItemGroupSoundsID`,`ContentTuningID`,`ModifiedCraftingReagentItemID`,`Unknown1200`,`CraftingQualityID`,`ItemSquishEraID`,`RecraftReagentCountPercentage`,`OrderSource`,`VerifiedBuild`) VALUES
(18674,4,0,1,11,0,0,-1,133356,14,0,0,0,0,0,0,0,70938),
(22329,4,0,8,23,3,0,-1,135469,19,0,0,0,0,0,0,0,70938),
(22333,2,5,6,17,1,0,-1,133041,9,0,0,0,0,0,0,0,70938);
DELETE FROM `item_sparse` WHERE `ID` IN (18674,22329,22333);
INSERT INTO `item_sparse` (`ID`,`Description`,`Display3`,`Display2`,`Display1`,`Display`,`ExpansionID`,`DmgVariance`,`LimitCategory`,`DurationInInventory`,`QualityModifier`,`BagFamily`,`StartQuestID`,`LanguageID`,`ItemRange`,`StatPercentageOfSocket1`,`StatPercentageOfSocket2`,`StatPercentageOfSocket3`,`StatPercentageOfSocket4`,`StatPercentageOfSocket5`,`StatPercentageOfSocket6`,`StatPercentageOfSocket7`,`StatPercentageOfSocket8`,`StatPercentageOfSocket9`,`StatPercentageOfSocket10`,`StatPercentEditor1`,`StatPercentEditor2`,`StatPercentEditor3`,`StatPercentEditor4`,`StatPercentEditor5`,`StatPercentEditor6`,`StatPercentEditor7`,`StatPercentEditor8`,`StatPercentEditor9`,`StatPercentEditor10`,`StatModifierBonusStat1`,`StatModifierBonusStat2`,`StatModifierBonusStat3`,`StatModifierBonusStat4`,`StatModifierBonusStat5`,`StatModifierBonusStat6`,`StatModifierBonusStat7`,`StatModifierBonusStat8`,`StatModifierBonusStat9`,`StatModifierBonusStat10`,`Stackable`,`MaxCount`,`MinReputation`,`RequiredAbility`,`AllowableRace1`,`AllowableRace2`,`SellPrice`,`BuyPrice`,`VendorStackCount`,`PriceVariance`,`PriceRandomValue`,`Flags1`,`Flags2`,`Flags3`,`Flags4`,`Flags5`,`FactionRelated`,`ModifiedCraftingReagentItemID`,`ContentTuningID`,`PlayerLevelToItemLevelCurveID`,`ItemLevelOffsetCurveID`,`ItemLevelOffsetItemLevel`,`ItemSquishEraID`,`ItemNameDescriptionID`,`RequiredTransmogHoliday`,`RequiredHoliday`,`GemProperties`,`SocketMatchEnchantmentId`,`TotemCategoryID`,`InstanceBound`,`ZoneBound1`,`ZoneBound2`,`ItemSet`,`LockID`,`PageID`,`ItemDelay`,`MinFactionID`,`RequiredSkillRank`,`RequiredSkill`,`ItemLevel`,`AllowableClass`,`ArtifactID`,`SpellWeight`,`SpellWeightCategory`,`SocketType1`,`SocketType2`,`SocketType3`,`SheatheType`,`Material`,`PageMaterialID`,`Bonding`,`DamageDamageType`,`ContainerSlots`,`RequiredPVPMedal`,`RequiredPVPRank`,`RequiredLevel`,`InventoryType`,`OverallQualityID`,`AmmunitionType`,`VerifiedBuild`) VALUES
(18674,'','','','','Hardened Stone Band',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5714,5714,2143,0,0,0,0,0,0,0,4,7,12,-1,-1,-1,-1,-1,-1,-1,1,0,0,0,-1,-1,22003,88014,1,1,1,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,60,-1,0,0,0,0,0,0,0,1,0,2,0,0,0,0,55,11,2,0,70938),
(22329,'','','','','Scepter of Interminable Focus',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4000,2500,7000,4000,0,0,0,0,0,0,5,31,32,6,-1,-1,-1,-1,-1,-1,1,0,0,0,-1,-1,34450,137801,1,1,1,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,63,-1,0,0,0,0,0,0,3,8,0,1,0,0,0,0,58,23,3,0,70938),
(22333,'','','','','Hammer of Divine Might',0,0.4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7222,5833,0,0,0,0,0,0,0,0,5,7,-1,-1,-1,-1,-1,-1,-1,-1,1,0,0,0,-1,-1,65383,326918,1,1,1,0,4,0,0,1280,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2100,0,0,0,62,-1,0,0,0,0,0,0,1,6,0,1,0,0,0,0,57,17,3,0,70938);
DELETE FROM `hotfix_data` WHERE `Id` BETWEEN 2096000 AND 2096999;
DELETE FROM `hotfix_data` WHERE (`TableHash`,`RecordId`) IN ((1344507586,18674),(1344507586,22329),(1344507586,22333),(2442913102,18674),(2442913102,22329),(2442913102,22333));
INSERT INTO `hotfix_data` (`Id`,`UniqueId`,`TableHash`,`RecordId`,`Status`,`VerifiedBuild`) VALUES
(2096000,1397816000,1344507586,18674,1,70938),
(2096001,1397816001,1344507586,22329,1,70938),
(2096002,1397816002,1344507586,22333,1,70938),
(2096003,1397816003,2442913102,18674,1,70938),
(2096004,1397816004,2442913102,22329,1,70938),
(2096005,1397816005,2442913102,22333,1,70938);
