-- WoW Forever: 9 items that still had no name or stats in our data, from "Cache 3.zip" (client 1.60.1.70938, Blizzard's live
-- realm): Sash of the Windreaver, Zephyr Cloak, Fel Hardened Bracers, Xorothian Firestick, Diabolic Mantle, Belt of the Trickster,
-- Blade of Necromancy, Lord Valthalak's Staff of Command, Rune Band of Wizardry. Item + ItemSparse records as Blizzard sends them.
-- Made with tools/full_forever/live_hotfix_sql.py. hotfix_data ids 2094000-2094999. Safe to run again.

DELETE FROM `item` WHERE `ID` IN (18676,18677,18754,18755,18757,22325,22332,22335,22339);
INSERT INTO `item` (`ID`,`ClassID`,`SubclassID`,`Material`,`InventoryType`,`SheatheType`,`ItemPetFoodID`,`SoundOverrideSubclassID`,`IconFileDataID`,`ItemGroupSoundsID`,`ContentTuningID`,`ModifiedCraftingReagentItemID`,`Unknown1200`,`CraftingQualityID`,`ItemSquishEraID`,`RecraftReagentCountPercentage`,`OrderSource`,`VerifiedBuild`) VALUES
(18676,4,3,5,6,0,0,-1,132520,10,0,0,0,0,0,0,0,70938),
(18677,4,1,7,16,0,0,-1,133765,7,0,0,0,0,0,0,0,70938),
(18754,4,4,6,9,0,0,-1,132614,11,0,0,0,0,0,0,0,70938),
(18755,2,3,2,26,0,0,-1,135612,12,0,0,3,0,0,0,0,70938),
(18757,4,1,7,3,0,0,-1,135056,7,0,0,0,0,0,0,0,70938),
(22325,4,2,8,6,0,0,-1,132515,7,0,0,0,0,0,0,0,70938),
(22332,2,7,1,21,3,0,-1,135326,8,0,0,0,0,0,0,0,70938),
(22335,2,10,2,17,2,0,-1,135144,13,0,0,0,0,0,0,0,70938),
(22339,4,0,5,11,0,0,-1,133377,14,0,0,0,0,0,0,0,70938);
DELETE FROM `item_sparse` WHERE `ID` IN (18676,18677,18754,18755,18757,22325,22332,22335,22339);
INSERT INTO `item_sparse` (`ID`,`Description`,`Display3`,`Display2`,`Display1`,`Display`,`ExpansionID`,`DmgVariance`,`LimitCategory`,`DurationInInventory`,`QualityModifier`,`BagFamily`,`StartQuestID`,`LanguageID`,`ItemRange`,`StatPercentageOfSocket1`,`StatPercentageOfSocket2`,`StatPercentageOfSocket3`,`StatPercentageOfSocket4`,`StatPercentageOfSocket5`,`StatPercentageOfSocket6`,`StatPercentageOfSocket7`,`StatPercentageOfSocket8`,`StatPercentageOfSocket9`,`StatPercentageOfSocket10`,`StatPercentEditor1`,`StatPercentEditor2`,`StatPercentEditor3`,`StatPercentEditor4`,`StatPercentEditor5`,`StatPercentEditor6`,`StatPercentEditor7`,`StatPercentEditor8`,`StatPercentEditor9`,`StatPercentEditor10`,`StatModifierBonusStat1`,`StatModifierBonusStat2`,`StatModifierBonusStat3`,`StatModifierBonusStat4`,`StatModifierBonusStat5`,`StatModifierBonusStat6`,`StatModifierBonusStat7`,`StatModifierBonusStat8`,`StatModifierBonusStat9`,`StatModifierBonusStat10`,`Stackable`,`MaxCount`,`MinReputation`,`RequiredAbility`,`AllowableRace1`,`AllowableRace2`,`SellPrice`,`BuyPrice`,`VendorStackCount`,`PriceVariance`,`PriceRandomValue`,`Flags1`,`Flags2`,`Flags3`,`Flags4`,`Flags5`,`FactionRelated`,`ModifiedCraftingReagentItemID`,`ContentTuningID`,`PlayerLevelToItemLevelCurveID`,`ItemLevelOffsetCurveID`,`ItemLevelOffsetItemLevel`,`ItemSquishEraID`,`ItemNameDescriptionID`,`RequiredTransmogHoliday`,`RequiredHoliday`,`GemProperties`,`SocketMatchEnchantmentId`,`TotemCategoryID`,`InstanceBound`,`ZoneBound1`,`ZoneBound2`,`ItemSet`,`LockID`,`PageID`,`ItemDelay`,`MinFactionID`,`RequiredSkillRank`,`RequiredSkill`,`ItemLevel`,`AllowableClass`,`ArtifactID`,`SpellWeight`,`SpellWeightCategory`,`SocketType1`,`SocketType2`,`SocketType3`,`SheatheType`,`Material`,`PageMaterialID`,`Bonding`,`DamageDamageType`,`ContainerSlots`,`RequiredPVPMedal`,`RequiredPVPRank`,`RequiredLevel`,`InventoryType`,`OverallQualityID`,`AmmunitionType`,`VerifiedBuild`) VALUES
(18676,'','','','','Sash of the Windreaver',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2692,2692,2308,11154,0,0,0,0,0,0,5,6,7,86,-1,-1,-1,-1,-1,-1,1,0,0,0,-1,-1,16080,80404,1,1,1,0,16388,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,62,-1,0,0,0,0,0,0,0,5,0,2,0,0,0,0,57,6,3,0,70938),
(18677,'','','','','Zephyr Cloak',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10000,0,0,0,0,0,0,0,0,0,55,-1,-1,-1,-1,-1,-1,-1,-1,-1,1,0,0,0,-1,-1,12487,62439,1,1,1,0,16388,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,62,-1,0,0,0,0,0,0,0,7,0,2,0,0,0,0,57,16,2,0,70938),
(18754,'','','','','Fel Hardened Bracers',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6000,6000,1500,0,0,0,0,0,0,0,4,7,12,-1,-1,-1,-1,-1,-1,-1,1,0,0,0,-1,-1,10461,52306,1,1,1,0,4,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,62,-1,0,0,0,0,0,0,0,6,0,1,0,0,0,0,57,9,3,0,70938),
(18755,'','','','','Xorothian Firestick',0,0.6,0,0,0,0,0,0,100,0,0,0,0,0,0,0,0,0,0,3636,3636,3636,0,0,0,0,0,0,0,54,3,7,-1,-1,-1,-1,-1,-1,-1,1,0,0,0,-1,-1,43129,215646,1,1,1,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2600,0,0,0,62,-1,0,0,0,0,0,0,0,2,0,1,0,0,0,0,57,26,3,3,70938),
(18757,'','','','','Diabolic Mantle',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5926,1851,6296,0,0,0,0,0,0,0,7,43,85,-1,-1,-1,-1,-1,-1,-1,1,0,0,0,-1,-1,16162,80813,1,1,1,0,4,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,62,-1,0,0,0,0,0,0,0,7,0,1,0,0,0,0,57,3,3,0,70938),
(22325,'','','','','Belt of the Trickster',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8462,3462,0,0,0,0,0,0,0,0,3,7,-1,-1,-1,-1,-1,-1,-1,-1,1,0,0,0,-1,-1,12446,62230,1,1,1,0,4,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,61,-1,0,0,0,0,0,0,0,8,0,1,0,0,0,0,56,6,3,0,70938),
(22332,'','','','','Blade of Necromancy',0,0.6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,1,0,0,0,-1,-1,53683,268417,1,1,1,0,4,0,0,768,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1500,0,0,0,62,32767,0,0,0,0,0,0,3,1,0,1,0,0,0,0,57,21,3,0,70938),
(22335,'','','','','Lord Valthalak''s Staff of Command',0,0.4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5833,5833,0,2778,0,0,0,0,0,0,7,5,-1,31,-1,-1,-1,-1,-1,-1,1,0,0,0,-1,-1,71251,356256,1,1,1,0,4,0,0,768,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2100,0,0,0,63,-1,0,0,0,0,0,0,2,2,0,1,0,0,0,0,58,17,3,0,70938),
(22339,'','','','','Rune Band of Wizardry',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3500,5000,6500,3500,0,0,0,0,0,0,7,31,45,56,-1,-1,-1,-1,-1,-1,1,0,0,0,-1,-1,15282,61130,1,1,1,524288,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,63,-1,0,0,0,0,0,0,0,5,0,1,0,0,0,0,58,11,3,0,70938);
DELETE FROM `hotfix_data` WHERE `Id` BETWEEN 2094000 AND 2094999;
DELETE FROM `hotfix_data` WHERE (`TableHash`,`RecordId`) IN ((1344507586,18676),(1344507586,18677),(1344507586,18754),(1344507586,18755),(1344507586,18757),(1344507586,22325),(1344507586,22332),(1344507586,22335),(1344507586,22339),(2442913102,18676),(2442913102,18677),(2442913102,18754),(2442913102,18755),(2442913102,18757),(2442913102,22325),(2442913102,22332),(2442913102,22335),(2442913102,22339));
INSERT INTO `hotfix_data` (`Id`,`UniqueId`,`TableHash`,`RecordId`,`Status`,`VerifiedBuild`) VALUES
(2094000,1397814000,1344507586,18676,1,70938),
(2094001,1397814001,1344507586,18677,1,70938),
(2094002,1397814002,1344507586,18754,1,70938),
(2094003,1397814003,1344507586,18755,1,70938),
(2094004,1397814004,1344507586,18757,1,70938),
(2094005,1397814005,1344507586,22325,1,70938),
(2094006,1397814006,1344507586,22332,1,70938),
(2094007,1397814007,1344507586,22335,1,70938),
(2094008,1397814008,1344507586,22339,1,70938),
(2094009,1397814009,2442913102,18676,1,70938),
(2094010,1397814010,2442913102,18677,1,70938),
(2094011,1397814011,2442913102,18754,1,70938),
(2094012,1397814012,2442913102,18755,1,70938),
(2094013,1397814013,2442913102,18757,1,70938),
(2094014,1397814014,2442913102,22325,1,70938),
(2094015,1397814015,2442913102,22332,1,70938),
(2094016,1397814016,2442913102,22335,1,70938),
(2094017,1397814017,2442913102,22339,1,70938);
