-- WoW Forever: six 1.10 dungeon-set boss drops that had no item data at all (not in the client files, not in our hotfixes), so
-- players saw them as unknown items: Hammer of Revitalization 22315 (Isalien), Tome of Divine Right 22319 and Idol of
-- Rejuvenation 22398 (Mor Grayhoof), Amalgam's Band 22326 and Band of the Steadfast Hero 22331 (Kormok), Draconian Aegis of the
-- Legion 22336 (Lord Valthalak). Records are the live server's answers in a player's 70938 cache (pushes 16799531-16799614).
-- 22326, 22331 and 22398 have no ItemModifiedAppearance in the client files, so their icon may still be missing.
-- Made with tools/full_forever/live_hotfix_sql.py. hotfix_data ids 2105000-2105099. Safe to run again.
DELETE FROM `item` WHERE `ID` IN (22315,22319,22326,22331,22336,22398);
INSERT INTO `item` (`ID`,`ClassID`,`SubclassID`,`Material`,`InventoryType`,`SheatheType`,`ItemPetFoodID`,`SoundOverrideSubclassID`,`IconFileDataID`,`ItemGroupSoundsID`,`ContentTuningID`,`ModifiedCraftingReagentItemID`,`Unknown1200`,`CraftingQualityID`,`ItemSquishEraID`,`RecraftReagentCountPercentage`,`OrderSource`,`VerifiedBuild`) VALUES
(22315,2,4,2,21,3,0,-1,133039,8,0,0,0,0,0,0,0,70938),
(22319,4,0,7,23,3,0,-1,133739,19,0,0,0,0,0,0,0,70938),
(22326,4,0,5,11,0,0,-1,133361,14,0,0,0,0,0,0,0,70938),
(22331,4,0,3,11,0,0,-1,133375,14,0,0,0,0,0,0,0,70938),
(22336,4,6,1,14,4,0,-1,134948,9,0,0,0,0,0,0,0,70938),
(22398,4,8,2,28,0,0,-1,134914,12,0,0,0,0,0,0,0,70938);
DELETE FROM `item_sparse` WHERE `ID` IN (22315,22319,22326,22331,22336,22398);
INSERT INTO `item_sparse` (`ID`,`Description`,`Display3`,`Display2`,`Display1`,`Display`,`ExpansionID`,`DmgVariance`,`LimitCategory`,`DurationInInventory`,`QualityModifier`,`BagFamily`,`StartQuestID`,`LanguageID`,`ItemRange`,`StatPercentageOfSocket1`,`StatPercentageOfSocket2`,`StatPercentageOfSocket3`,`StatPercentageOfSocket4`,`StatPercentageOfSocket5`,`StatPercentageOfSocket6`,`StatPercentageOfSocket7`,`StatPercentageOfSocket8`,`StatPercentageOfSocket9`,`StatPercentageOfSocket10`,`StatPercentEditor1`,`StatPercentEditor2`,`StatPercentEditor3`,`StatPercentEditor4`,`StatPercentEditor5`,`StatPercentEditor6`,`StatPercentEditor7`,`StatPercentEditor8`,`StatPercentEditor9`,`StatPercentEditor10`,`StatModifierBonusStat1`,`StatModifierBonusStat2`,`StatModifierBonusStat3`,`StatModifierBonusStat4`,`StatModifierBonusStat5`,`StatModifierBonusStat6`,`StatModifierBonusStat7`,`StatModifierBonusStat8`,`StatModifierBonusStat9`,`StatModifierBonusStat10`,`Stackable`,`MaxCount`,`MinReputation`,`RequiredAbility`,`AllowableRace1`,`AllowableRace2`,`SellPrice`,`BuyPrice`,`VendorStackCount`,`PriceVariance`,`PriceRandomValue`,`Flags1`,`Flags2`,`Flags3`,`Flags4`,`Flags5`,`FactionRelated`,`ModifiedCraftingReagentItemID`,`ContentTuningID`,`PlayerLevelToItemLevelCurveID`,`ItemLevelOffsetCurveID`,`ItemLevelOffsetItemLevel`,`ItemSquishEraID`,`ItemNameDescriptionID`,`RequiredTransmogHoliday`,`RequiredHoliday`,`GemProperties`,`SocketMatchEnchantmentId`,`TotemCategoryID`,`InstanceBound`,`ZoneBound1`,`ZoneBound2`,`ItemSet`,`LockID`,`PageID`,`ItemDelay`,`MinFactionID`,`RequiredSkillRank`,`RequiredSkill`,`ItemLevel`,`AllowableClass`,`ArtifactID`,`SpellWeight`,`SpellWeightCategory`,`SocketType1`,`SocketType2`,`SocketType3`,`SheatheType`,`Material`,`PageMaterialID`,`Bonding`,`DamageDamageType`,`ContainerSlots`,`RequiredPVPMedal`,`RequiredPVPRank`,`RequiredLevel`,`InventoryType`,`OverallQualityID`,`AmmunitionType`,`VerifiedBuild`) VALUES
(22315,'','','','','Hammer of Revitalization',0,0.6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3333,3333,0,0,0,0,0,0,0,0,7,43,-1,-1,-1,-1,-1,-1,-1,-1,1,0,0,0,-1,-1,49816,249080,1,1,1,0,4,0,0,1280,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2700,0,0,0,61,-1,0,0,0,0,0,0,3,2,0,1,0,0,0,0,56,21,3,0,70938),
(22319,'','','','','Tome of Divine Right',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3000,3000,13000,2000,4500,0,0,0,0,0,5,7,41,43,42,-1,-1,-1,-1,-1,1,0,0,0,-1,-1,38664,154658,1,1,1,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,61,-1,0,0,0,0,0,0,3,7,0,1,0,0,0,0,56,23,3,0,70938),
(22326,'','','','','Amalgam''s Band',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3000,2500,7000,1500,0,0,0,0,0,0,5,7,32,43,-1,-1,-1,-1,-1,-1,1,0,0,0,-1,-1,15282,61130,1,1,1,524288,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,63,-1,0,0,0,0,0,0,0,5,0,1,0,0,0,0,58,11,3,0,70938),
(22331,'','','','','Band of the Steadfast Hero',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3500,6000,3500,0,0,0,0,0,0,0,4,7,12,-1,-1,-1,-1,-1,-1,-1,1,0,0,0,-1,-1,36253,145013,1,1,1,524288,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,62,-1,0,0,0,0,0,0,0,3,0,1,0,0,0,0,57,11,3,0,70938),
(22336,'','','','','Draconian Aegis of the Legion',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3500,9000,4500,0,0,0,0,0,0,0,7,45,137,-1,-1,-1,-1,-1,-1,-1,1,0,0,0,-1,-1,35150,175751,1,1,1,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,63,-1,0,0,0,0,0,0,4,1,0,1,0,0,0,0,58,14,3,0,70938),
(22398,'','','','','Idol of Rejuvenation',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,1,0,0,0,-1,-1,16898,84490,1,1,1,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,62,32767,0,0,0,0,0,0,0,2,0,1,0,0,0,0,57,28,3,0,70938);
DELETE FROM `hotfix_data` WHERE `Id` BETWEEN 2105000 AND 2105099;
DELETE FROM `hotfix_data` WHERE (`TableHash`,`RecordId`) IN ((1344507586,22315),(1344507586,22319),(1344507586,22326),(1344507586,22331),(1344507586,22336),(1344507586,22398),(2442913102,22315),(2442913102,22319),(2442913102,22326),(2442913102,22331),(2442913102,22336),(2442913102,22398));
INSERT INTO `hotfix_data` (`Id`,`UniqueId`,`TableHash`,`RecordId`,`Status`,`VerifiedBuild`) VALUES
(2105000,1397825000,1344507586,22315,1,70938),
(2105001,1397825001,1344507586,22319,1,70938),
(2105002,1397825002,1344507586,22326,1,70938),
(2105003,1397825003,1344507586,22331,1,70938),
(2105004,1397825004,1344507586,22336,1,70938),
(2105005,1397825005,1344507586,22398,1,70938),
(2105006,1397825006,2442913102,22315,1,70938),
(2105007,1397825007,2442913102,22319,1,70938),
(2105008,1397825008,2442913102,22326,1,70938),
(2105009,1397825009,2442913102,22331,1,70938),
(2105010,1397825010,2442913102,22336,1,70938),
(2105011,1397825011,2442913102,22398,1,70938);
