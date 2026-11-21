-- Classic items outside the raids that a loot table, item or mail hands out but that had no item row (the WoW
-- Forever client blanks them): Fairy's Embrace and Entwined Opaline Talisman (inside Bloated Redgill and Bloated
-- Glossy Mightfish), Weighted Cloak and Glowing Black Orb (Bag of Spoils, Silithus), Fish Scale, the Goblin and
-- Gnome Engineer's Renewal Gift mails and the Winter Veil Disguise Kit mail. Classic stats, flags, sell prices, use spell.
DELETE FROM `item_sparse` WHERE `ID` IN (7549,7551,20693,20694,6987,11422,11423,17712);
INSERT INTO `item_sparse` (`ID`,`Description`,`Display3`,`Display2`,`Display1`,`Display`,`ExpansionID`,`DmgVariance`,`LimitCategory`,`DurationInInventory`,`QualityModifier`,`BagFamily`,`StartQuestID`,`LanguageID`,`ItemRange`,`StatPercentageOfSocket1`,`StatPercentageOfSocket2`,`StatPercentageOfSocket3`,`StatPercentageOfSocket4`,`StatPercentageOfSocket5`,`StatPercentageOfSocket6`,`StatPercentageOfSocket7`,`StatPercentageOfSocket8`,`StatPercentageOfSocket9`,`StatPercentageOfSocket10`,`StatPercentEditor1`,`StatPercentEditor2`,`StatPercentEditor3`,`StatPercentEditor4`,`StatPercentEditor5`,`StatPercentEditor6`,`StatPercentEditor7`,`StatPercentEditor8`,`StatPercentEditor9`,`StatPercentEditor10`,`StatModifierBonusStat1`,`StatModifierBonusStat2`,`StatModifierBonusStat3`,`StatModifierBonusStat4`,`StatModifierBonusStat5`,`StatModifierBonusStat6`,`StatModifierBonusStat7`,`StatModifierBonusStat8`,`StatModifierBonusStat9`,`StatModifierBonusStat10`,`Stackable`,`MaxCount`,`MinReputation`,`RequiredAbility`,`AllowableRace1`,`AllowableRace2`,`SellPrice`,`BuyPrice`,`VendorStackCount`,`PriceVariance`,`PriceRandomValue`,`Flags1`,`Flags2`,`Flags3`,`Flags4`,`Flags5`,`FactionRelated`,`ModifiedCraftingReagentItemID`,`ContentTuningID`,`PlayerLevelToItemLevelCurveID`,`ItemLevelOffsetCurveID`,`ItemLevelOffsetItemLevel`,`ItemSquishEraID`,`ItemNameDescriptionID`,`RequiredTransmogHoliday`,`RequiredHoliday`,`GemProperties`,`SocketMatchEnchantmentId`,`TotemCategoryID`,`InstanceBound`,`ZoneBound1`,`ZoneBound2`,`ItemSet`,`LockID`,`PageID`,`ItemDelay`,`MinFactionID`,`RequiredSkillRank`,`RequiredSkill`,`ItemLevel`,`AllowableClass`,`ArtifactID`,`SpellWeight`,`SpellWeightCategory`,`SocketType1`,`SocketType2`,`SocketType3`,`SheatheType`,`Material`,`PageMaterialID`,`Bonding`,`DamageDamageType`,`ContainerSlots`,`RequiredPVPMedal`,`RequiredPVPRank`,`RequiredLevel`,`InventoryType`,`OverallQualityID`,`AmmunitionType`,`VerifiedBuild`) VALUES
(7549,'','','','','Fairy''s Embrace',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1818,4545,4545,0,0,0,0,0,0,0,7,5,6,-1,-1,-1,-1,-1,-1,-1,1,0,0,0,-1,-1,6420,25680,1,1,1,0,24580,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,47,-1,0,0,0,0,0,0,0,0,0,2,0,0,0,0,42,2,2,0,70959),
(7551,'','','','','Entwined Opaline Talisman',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2727,9091,0,0,0,0,0,0,0,0,3,7,-1,-1,-1,-1,-1,-1,-1,-1,1,0,0,0,-1,-1,7145,28580,1,1,1,0,24580,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,47,-1,0,0,0,0,0,0,0,0,0,2,0,0,0,0,42,2,2,0,70959),
(20693,'','','','','Weighted Cloak',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5333,5333,40000,0,0,0,0,0,0,0,4,7,50,-1,-1,-1,-1,-1,-1,-1,1,0,0,0,-1,-1,11860,47440,1,1,1,0,24580,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,60,-1,0,0,0,0,0,0,0,7,0,2,0,0,0,0,55,16,2,0,70959),
(20694,'','','','','Glowing Black Orb',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6667,0,0,0,0,0,0,0,0,0,5,-1,-1,-1,-1,-1,-1,-1,-1,-1,1,0,0,0,-1,-1,17828,71312,1,1,1,0,24580,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,60,-1,0,0,0,0,0,0,0,0,0,2,0,0,0,0,55,23,2,0,70959),
(6987,'','','','','Fish Scale',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,10,0,0,0,-1,-1,13,52,1,1,1,0,24580,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,70959),
(11422,'','','','','Goblin Engineer''s Renewal Gift',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,1,0,0,0,-1,-1,0,0,1,1,1,4,24580,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,70959),
(11423,'','','','','Gnome Engineer''s Renewal Gift',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,1,0,0,0,-1,-1,0,0,1,1,1,4,24580,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,70959),
(17712,'"For when the weather outside is frightful..."','','','','Winter Veil Disguise Kit',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,1,1,0,0,-1,-1,0,0,1,1,1,0,24580,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,70959);
DELETE FROM `item_effect` WHERE `ID` BETWEEN 9900891 AND 9900892;
INSERT INTO `item_effect` (`ID`,`LegacySlotIndex`,`TriggerType`,`Charges`,`CoolDownMSec`,`CategoryCoolDownMSec`,`SpellCategoryID`,`SpellID`,`ChrSpecializationID`,`PlayerConditionID`,`VerifiedBuild`) VALUES
(9900891,0,1,0,-1,-1,0,9417,0,0,70959),
(9900892,0,0,0,-1,-1,0,21848,0,0,70959);
DELETE FROM `item_x_item_effect` WHERE `ID` BETWEEN 9900891 AND 9900892;
INSERT INTO `item_x_item_effect` (`ID`,`ItemEffectID`,`ItemID`,`VerifiedBuild`) VALUES
(9900891,9900891,20694,70959),
(9900892,9900892,17712,70959);
DELETE FROM `hotfix_data` WHERE `Id` BETWEEN 26113825 AND 26113836;
INSERT INTO `hotfix_data` (`Id`,`UniqueId`,`TableHash`,`RecordId`,`Status`,`VerifiedBuild`) VALUES
(26113825,1197781148,2442913102,7549,1,70959),
(26113826,1352927727,2442913102,7551,1,70959),
(26113827,1746312808,2442913102,20693,1,70959),
(26113828,1987185611,2442913102,20694,1,70959),
(26113829,1036995734,2442913102,6987,1,70959),
(26113830,8240878,2442913102,11422,1,70959),
(26113831,2004520568,2442913102,11423,1,70959),
(26113832,209521832,2442913102,17712,1,70959),
(26113833,961547927,1073915313,9900891,1,70959),
(26113834,542727981,1073915313,9900892,1,70959),
(26113835,1435698389,13330255,9900891,1,70959),
(26113836,1285182831,13330255,9900892,1,70959);
