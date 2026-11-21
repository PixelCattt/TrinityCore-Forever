-- WoW Forever, part 1: Blizzard's 70959 public hotfix file as of 2026-11-20 01:53Z (a player's cache of 11-20 has the same
-- pushes): new pushes 114231-114281 and one record added to push 114215. Item 279913 Ti'ik's Head, 212982 Squall-breakers Potion,
-- 243177 Ingenious Toy, spells 443278/443464/443469/443631/443678 (Seed of Renewal, Healing Blossom), quests 79365 and 81924,
-- creature display 145586, player condition 169168, records live hides or removes. Only tables our server loads, plus hide and
-- remove rows. Runs after 2026_11_19_77. hotfix_data ids 2105100-2105199.
-- Part 2: ten items that had no item data at all, from the live server's answers in the same cache: 18673 Avalanchion's Stony
-- Hide, 22343 Handguards of Savagery, 22345 Totem of Tides, 22401 Libram of Hope, 22472 Boots of Ferocity, 219343 Filcher's Cowl,
-- 284270 Ancient Giant's Gaze, 286641 Cannibal's Cleaver, 286644 Shattered Atal'ai Spear, 286645 Reforged Atal'ai Spear.
-- hotfix_data ids 2105200-2105299. Made with tools/full_forever/live_hotfix_sql.py. Safe to run again.
DELETE FROM `creature_display_info` WHERE `ID` IN (145586);
INSERT INTO `creature_display_info` (`ID`,`ModelID`,`SoundID`,`SizeClass`,`CreatureModelScale`,`CreatureModelAlpha`,`BloodID`,`ExtendedDisplayInfoID`,`NPCSoundID`,`ParticleColorID`,`PortraitCreatureDisplayInfoID`,`PortraitTextureFileDataID`,`ObjectEffectPackageID`,`AnimReplacementSetID`,`Flags`,`StateSpellVisualKitID`,`PlayerOverrideScale`,`PetInstanceScale`,`UnarmedWeaponType`,`MountPoofSpellVisualKitID`,`DissolveEffectID`,`Gender`,`DissolveOutEffectID`,`CreatureModelMinLod`,`ConditionalCreatureModelID`,`Unknown_1100_1`,`Unknown_1100_2`,`TextureVariationFileDataID1`,`TextureVariationFileDataID2`,`TextureVariationFileDataID3`,`TextureVariationFileDataID4`,`VerifiedBuild`) VALUES
(145586,7576,0,0,0.75,255,0,84,72,0,0,0,0,0,0,0,0,0.7,-1,0,0,1,0,0,0,45,0,0,0,0,0,70959);
DELETE FROM `item` WHERE `ID` IN (243177,279913);
INSERT INTO `item` (`ID`,`ClassID`,`SubclassID`,`Material`,`InventoryType`,`SheatheType`,`ItemPetFoodID`,`SoundOverrideSubclassID`,`IconFileDataID`,`ItemGroupSoundsID`,`ContentTuningID`,`ModifiedCraftingReagentItemID`,`Unknown1200`,`CraftingQualityID`,`ItemSquishEraID`,`RecraftReagentCountPercentage`,`OrderSource`,`VerifiedBuild`) VALUES
(243177,13,0,0,0,0,0,-1,237290,8,0,0,0,0,0,0,0,70959),
(279913,12,0,0,0,0,0,-1,134177,16,0,0,0,0,0,0,0,70959);
DELETE FROM `item_sparse` WHERE `ID` IN (243177,279913);
INSERT INTO `item_sparse` (`ID`,`Description`,`Display3`,`Display2`,`Display1`,`Display`,`ExpansionID`,`DmgVariance`,`LimitCategory`,`DurationInInventory`,`QualityModifier`,`BagFamily`,`StartQuestID`,`LanguageID`,`ItemRange`,`StatPercentageOfSocket1`,`StatPercentageOfSocket2`,`StatPercentageOfSocket3`,`StatPercentageOfSocket4`,`StatPercentageOfSocket5`,`StatPercentageOfSocket6`,`StatPercentageOfSocket7`,`StatPercentageOfSocket8`,`StatPercentageOfSocket9`,`StatPercentageOfSocket10`,`StatPercentEditor1`,`StatPercentEditor2`,`StatPercentEditor3`,`StatPercentEditor4`,`StatPercentEditor5`,`StatPercentEditor6`,`StatPercentEditor7`,`StatPercentEditor8`,`StatPercentEditor9`,`StatPercentEditor10`,`StatModifierBonusStat1`,`StatModifierBonusStat2`,`StatModifierBonusStat3`,`StatModifierBonusStat4`,`StatModifierBonusStat5`,`StatModifierBonusStat6`,`StatModifierBonusStat7`,`StatModifierBonusStat8`,`StatModifierBonusStat9`,`StatModifierBonusStat10`,`Stackable`,`MaxCount`,`MinReputation`,`RequiredAbility`,`AllowableRace1`,`AllowableRace2`,`SellPrice`,`BuyPrice`,`VendorStackCount`,`PriceVariance`,`PriceRandomValue`,`Flags1`,`Flags2`,`Flags3`,`Flags4`,`Flags5`,`FactionRelated`,`ModifiedCraftingReagentItemID`,`ContentTuningID`,`PlayerLevelToItemLevelCurveID`,`ItemLevelOffsetCurveID`,`ItemLevelOffsetItemLevel`,`ItemSquishEraID`,`ItemNameDescriptionID`,`RequiredTransmogHoliday`,`RequiredHoliday`,`GemProperties`,`SocketMatchEnchantmentId`,`TotemCategoryID`,`InstanceBound`,`ZoneBound1`,`ZoneBound2`,`ItemSet`,`LockID`,`PageID`,`ItemDelay`,`MinFactionID`,`RequiredSkillRank`,`RequiredSkill`,`ItemLevel`,`AllowableClass`,`ArtifactID`,`SpellWeight`,`SpellWeightCategory`,`SocketType1`,`SocketType2`,`SocketType3`,`SheatheType`,`Material`,`PageMaterialID`,`Bonding`,`DamageDamageType`,`ContainerSlots`,`RequiredPVPMedal`,`RequiredPVPRank`,`RequiredLevel`,`InventoryType`,`OverallQualityID`,`AmmunitionType`,`VerifiedBuild`) VALUES
(243177,'','','','','Ingenious Toy',0,0,0,0,0,256,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,1,1,0,0,-1,-1,17000,17000,1,1,0.976,2048,28676,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,3,0,70959),
(279913,'','','','','Ti''ik''s Head',0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,1,1,0,0,-1,-1,0,0,1,1,1.0073,2048,8196,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,49,-1,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,1,0,70959);
DELETE FROM `player_condition` WHERE `ID` IN (169168);
INSERT INTO `player_condition` (`ID`,`FailureDescription`,`MinLevel`,`MaxLevel`,`ClassMask`,`SkillLogic`,`LanguageID`,`MinLanguage`,`MaxLanguage`,`MaxFactionID`,`MaxReputation`,`ReputationLogic`,`CurrentPvpFaction`,`PvpMedal`,`PrevQuestLogic`,`CurrQuestLogic`,`CurrentCompletedQuestLogic`,`SpellLogic`,`ItemLogic`,`ItemFlags`,`AuraSpellLogic`,`WorldStateExpressionID`,`WeatherID`,`PartyStatus`,`LifetimeMaxPVPRank`,`AchievementLogic`,`Gender`,`NativeGender`,`AreaLogic`,`LfgLogic`,`CurrencyLogic`,`QuestKillID`,`QuestKillLogic`,`MinExpansionLevel`,`MaxExpansionLevel`,`MinAvgItemLevel`,`MaxAvgItemLevel`,`MinAvgEquippedItemLevel`,`MaxAvgEquippedItemLevel`,`PhaseUseFlags`,`PhaseID`,`PhaseGroupID`,`Flags`,`ChrSpecializationIndex`,`ChrSpecializationRole`,`ModifierTreeID`,`PowerType`,`PowerTypeComp`,`PowerTypeValue`,`MovementFlags`,`WeaponSubclassMask`,`MaxGuildLevel`,`MinGuildLevel`,`MaxExpansionTier`,`MinExpansionTier`,`MinPVPRank`,`MaxPVPRank`,`ContentTuningID`,`CovenantID`,`TraitNodeEntryLogic`,`SkillID1`,`SkillID2`,`SkillID3`,`SkillID4`,`MinSkill1`,`MinSkill2`,`MinSkill3`,`MinSkill4`,`MaxSkill1`,`MaxSkill2`,`MaxSkill3`,`MaxSkill4`,`MinFactionID1`,`MinFactionID2`,`MinFactionID3`,`MinReputation1`,`MinReputation2`,`MinReputation3`,`PrevQuestID1`,`PrevQuestID2`,`PrevQuestID3`,`PrevQuestID4`,`CurrQuestID1`,`CurrQuestID2`,`CurrQuestID3`,`CurrQuestID4`,`CurrentCompletedQuestID1`,`CurrentCompletedQuestID2`,`CurrentCompletedQuestID3`,`CurrentCompletedQuestID4`,`SpellID1`,`SpellID2`,`SpellID3`,`SpellID4`,`ItemID1`,`ItemID2`,`ItemID3`,`ItemID4`,`ItemCount1`,`ItemCount2`,`ItemCount3`,`ItemCount4`,`Explored1`,`Explored2`,`Time1`,`Time2`,`AuraSpellID1`,`AuraSpellID2`,`AuraSpellID3`,`AuraSpellID4`,`AuraStacks1`,`AuraStacks2`,`AuraStacks3`,`AuraStacks4`,`Achievement1`,`Achievement2`,`Achievement3`,`Achievement4`,`AreaID1`,`AreaID2`,`AreaID3`,`AreaID4`,`LfgStatus1`,`LfgStatus2`,`LfgStatus3`,`LfgStatus4`,`LfgCompare1`,`LfgCompare2`,`LfgCompare3`,`LfgCompare4`,`LfgValue1`,`LfgValue2`,`LfgValue3`,`LfgValue4`,`CurrencyID1`,`CurrencyID2`,`CurrencyID3`,`CurrencyID4`,`CurrencyCount1`,`CurrencyCount2`,`CurrencyCount3`,`CurrencyCount4`,`QuestKillMonster1`,`QuestKillMonster2`,`QuestKillMonster3`,`QuestKillMonster4`,`QuestKillMonster5`,`QuestKillMonster6`,`RaceMask1`,`RaceMask2`,`TraitNodeEntryID1`,`TraitNodeEntryID2`,`TraitNodeEntryID3`,`TraitNodeEntryID4`,`TraitNodeEntryMinRank1`,`TraitNodeEntryMinRank2`,`TraitNodeEntryMinRank3`,`TraitNodeEntryMinRank4`,`TraitNodeEntryMaxRank1`,`TraitNodeEntryMaxRank2`,`TraitNodeEntryMaxRank3`,`TraitNodeEntryMaxRank4`,`VerifiedBuild`) VALUES
(169168,'',0,0,1024,0,0,0,0,0,0,0,0,0,0,0,0,0,65536,1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,1,-1,-1,0,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,81924,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,219326,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70959);
DELETE FROM `quest_v2` WHERE `ID` IN (79365,81924);
INSERT INTO `quest_v2` (`ID`,`UniqueBitFlag`,`UiQuestDetailsTheme`,`VerifiedBuild`) VALUES
(79365,54954,0,70959),
(81924,57305,0,70959);
DELETE FROM `spell_effect` WHERE `ID` IN (1165701,1165702);
INSERT INTO `spell_effect` (`ID`,`EffectAura`,`DifficultyID`,`EffectIndex`,`Effect`,`EffectAmplitude`,`EffectAttributes`,`EffectAuraPeriod`,`EffectBonusCoefficient`,`EffectChainAmplitude`,`EffectChainTargets`,`EffectItemType`,`EffectMechanic`,`EffectPointsPerResource`,`EffectPosFacing`,`EffectRealPointsPerLevel`,`EffectTriggerSpell`,`BonusCoefficientFromAP`,`PvpMultiplier`,`Coefficient`,`Variance`,`ResourceCoefficient`,`GroupSizeBasePointsCoefficient`,`EffectBasePoints`,`ScalingClass`,`TargetNodeGraph`,`EffectMiscValue1`,`EffectMiscValue2`,`EffectRadiusIndex1`,`EffectRadiusIndex2`,`EffectSpellClassMask1`,`EffectSpellClassMask2`,`EffectSpellClassMask3`,`EffectSpellClassMask4`,`ImplicitTarget1`,`ImplicitTarget2`,`SpellID`,`VerifiedBuild`) VALUES
(1165701,0,0,0,2,0,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0.35,0,1,75,0,0,0,0,13,0,0,0,0,0,15,0,459164,70959),
(1165702,0,0,1,2,0,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0.35,0,1,175,0,0,0,0,0,0,0,0,0,0,1,0,459164,70959);
DELETE FROM `spell_misc` WHERE `ID` IN (752260,789854,874521,874773);
INSERT INTO `spell_misc` (`ID`,`Attributes1`,`Attributes2`,`Attributes3`,`Attributes4`,`Attributes5`,`Attributes6`,`Attributes7`,`Attributes8`,`Attributes9`,`Attributes10`,`Attributes11`,`Attributes12`,`Attributes13`,`Attributes14`,`Attributes15`,`Attributes16`,`Attributes17`,`DifficultyID`,`CastingTimeIndex`,`DurationIndex`,`PvPDurationIndex`,`RangeIndex`,`SchoolMask`,`Speed`,`LaunchDelay`,`MinDuration`,`SpellIconFileDataID`,`ActiveIconFileDataID`,`ContentTuningID`,`ShowFutureSpellPlayerConditionID`,`SpellVisualScript`,`ActiveSpellVisualScript`,`SpellID`,`VerifiedBuild`) VALUES
(752260,262160,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8192,0,0,16,1,0,36,1,0,0,0,132369,136116,0,0,0,0,459592,70959),
(789854,464,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8192,0,0,1,0,0,1,1,0,0,0,136185,0,0,0,0,0,1235316,70959),
(874521,262160,201326592,1048832,17039360,0,0,0,0,0,0,0,0,0,0,0,8192,0,0,1,0,0,2,1,0,0,0,132323,0,0,0,0,0,1329283,70959),
(874773,262160,201326592,1048832,17039360,0,0,0,0,0,0,0,0,0,0,0,8192,0,0,1,0,0,2,1,0,0,0,132323,0,0,0,0,0,1329549,70959);
DELETE FROM `spell_name` WHERE `ID` IN (443278,443464,443469,443631,443678);
INSERT INTO `spell_name` (`ID`,`Name`,`VerifiedBuild`) VALUES
(443278,'Seed of Renewal',70959),
(443464,'Healing Blossom',70959),
(443469,'[DNT] Grow Healing Blossom',70959),
(443631,'Seed of Renewal Effect',70959),
(443678,'Seed of Renewal',70959);
DELETE FROM `hotfix_blob` WHERE `locale`='enUS' AND (`TableHash`,`RecordId`) IN ((3776013982,443278),(3776013982,443464),(3776013982,443469),(3776013982,443631),(3776013982,443678));
INSERT INTO `hotfix_blob` (`TableHash`,`RecordId`,`locale`,`Blob`,`VerifiedBuild`) VALUES
(3776013982,443278,'enUS',0x004368616e636520746f20656d6265642061207365656420696e746f20656e656d792068756d616e6f6964732c206265617374732c206f7220647261676f6e6b696e2068697420627920796f7572206162696c6974696573206f72207370656c6c732e2049662074686520637265617475726520697320736c61696e2077697468696e203330207365636f6e6473206f66207468652073656564206265696e6720656d6265646465642c2061204865616c696e6720426c6f73736f6d2077696c6c2067726f772066726f6d2069747320636f727073652e0d0a004368616e636520746f20656d6265642061207365656420696e746f20656e656d792068756d616e6f6964732c206265617374732c206f7220647261676f6e6b696e2068697420627920796f7572206162696c6974696573206f72207370656c6c732e00,70959),
(3776013982,443464,'enUS',0x00004865616c732024733120657665727920247431207365636f6e64732e00,70959),
(3776013982,443469,'enUS',0x000000,70959),
(3776013982,443631,'enUS',0x0047726f77732061204865616c696e6720426c6f73736f6d20776974682066726f6d2074686520636f72707365206f6620612068756d616e6f6964206f7220626561737420666f722024642074686174206865616c732067726f7570206d656d626572732077697468696e2024343433343634613120796172647320666f722024343433343634733120657665727920243434333436347431207365636f6e64732e0000,70959),
(3776013982,443678,'enUS',0x000057696c6c2067726f772061204865616c696e6720426c6f73736f6d2066726f6d20636f72707365207768656e206b696c6c65642e00,70959);
DELETE FROM `hotfix_data` WHERE `Id` BETWEEN 2105100 AND 2105199;
DELETE FROM `hotfix_data` WHERE (`TableHash`,`RecordId`) IN ((3386291891,221104),(3386943305,261606),(3386943305,328798),(3218799089,145586),(1344507586,219326),(1344507586,243177),(1344507586,279913),(1073915313,237978),(428746933,219326),(428746933,243177),(428746933,279913),(2442913102,219326),(2442913102,243177),(2442913102,279913),(13330255,170101),(3465080266,219326),(3465080266,243177),(3465080266,279913),(3108775943,169168),(986198281,79365),(986198281,81924),(261693969,79365),(261693969,81924),(3776013982,443278),(3776013982,443464),(3776013982,443469),(3776013982,443631),(3776013982,443678),(4030871717,1165701),(4030871717,1165702),(3322146344,752260),(3322146344,789854),(3322146344,874521),(3322146344,874773),(1187407512,443278),(1187407512,443464),(1187407512,443469),(1187407512,443631),(1187407512,443678),(1163127287,95517),(1163127287,95873),(1163127287,103448),(1163127287,105993),(1163127287,105995),(1163127287,132015),(1163127287,133447),(1163127287,134436),(1163127287,134437),(1163127287,134438),(1163127287,136508),(1163127287,136510),(1163127287,136512),(1163127287,136531),(1163127287,136533),(1163127287,138517),(3764692828,327007),(3764692828,327055),(3764692828,327091),(3764692828,327104),(3037505077,219326),(3037505077,243177),(3037505077,279913),(1417785224,219326),(1417785224,243177),(1417785224,279913));
INSERT INTO `hotfix_data` (`Id`,`UniqueId`,`TableHash`,`RecordId`,`Status`,`VerifiedBuild`) VALUES
(2105100,1397825100,3386291891,221104,3,70959),
(2105101,1397825101,3386943305,261606,3,70959),
(2105102,1397825102,3386943305,328798,3,70959),
(2105103,1397825103,3218799089,145586,1,70959),
(2105104,1397825104,1344507586,219326,3,70959),
(2105105,1397825105,1344507586,243177,1,70959),
(2105106,1397825106,1344507586,279913,1,70959),
(2105107,1397825107,1073915313,237978,2,70959),
(2105108,1397825108,428746933,219326,3,70959),
(2105109,1397825109,428746933,243177,3,70959),
(2105110,1397825110,428746933,279913,3,70959),
(2105111,1397825111,2442913102,219326,3,70959),
(2105112,1397825112,2442913102,243177,1,70959),
(2105113,1397825113,2442913102,279913,1,70959),
(2105114,1397825114,13330255,170101,2,70959),
(2105115,1397825115,3465080266,219326,3,70959),
(2105116,1397825116,3465080266,243177,3,70959),
(2105117,1397825117,3465080266,279913,3,70959),
(2105118,1397825118,3108775943,169168,1,70959),
(2105119,1397825119,986198281,79365,1,70959),
(2105120,1397825120,986198281,81924,1,70959),
(2105121,1397825121,261693969,79365,3,70959),
(2105122,1397825122,261693969,81924,3,70959),
(2105123,1397825123,3776013982,443278,1,70959),
(2105124,1397825124,3776013982,443464,1,70959),
(2105125,1397825125,3776013982,443469,1,70959),
(2105126,1397825126,3776013982,443631,1,70959),
(2105127,1397825127,3776013982,443678,1,70959),
(2105128,1397825128,4030871717,1165701,1,70959),
(2105129,1397825129,4030871717,1165702,1,70959),
(2105130,1397825130,3322146344,752260,1,70959),
(2105131,1397825131,3322146344,789854,1,70959),
(2105132,1397825132,3322146344,874521,1,70959),
(2105133,1397825133,3322146344,874773,1,70959),
(2105134,1397825134,1187407512,443278,1,70959),
(2105135,1397825135,1187407512,443464,1,70959),
(2105136,1397825136,1187407512,443469,1,70959),
(2105137,1397825137,1187407512,443631,1,70959),
(2105138,1397825138,1187407512,443678,1,70959),
(2105139,1397825139,1163127287,95517,3,70959),
(2105140,1397825140,1163127287,95873,3,70959),
(2105141,1397825141,1163127287,103448,3,70959),
(2105142,1397825142,1163127287,105993,3,70959),
(2105143,1397825143,1163127287,105995,3,70959),
(2105144,1397825144,1163127287,132015,3,70959),
(2105145,1397825145,1163127287,133447,3,70959),
(2105146,1397825146,1163127287,134436,3,70959),
(2105147,1397825147,1163127287,134437,3,70959),
(2105148,1397825148,1163127287,134438,3,70959),
(2105149,1397825149,1163127287,136508,3,70959),
(2105150,1397825150,1163127287,136510,3,70959),
(2105151,1397825151,1163127287,136512,3,70959),
(2105152,1397825152,1163127287,136531,3,70959),
(2105153,1397825153,1163127287,136533,3,70959),
(2105154,1397825154,1163127287,138517,3,70959),
(2105155,1397825155,3764692828,327007,2,70959),
(2105156,1397825156,3764692828,327055,2,70959),
(2105157,1397825157,3764692828,327091,2,70959),
(2105158,1397825158,3764692828,327104,2,70959),
(2105159,1397825159,3037505077,219326,3,70959),
(2105160,1397825160,3037505077,243177,3,70959),
(2105161,1397825161,3037505077,279913,3,70959),
(2105162,1397825162,1417785224,219326,3,70959),
(2105163,1397825163,1417785224,243177,3,70959),
(2105164,1397825164,1417785224,279913,3,70959);

DELETE FROM `item` WHERE `ID` IN (18673,22343,22345,22401,22472,219343,284270,286641,286644,286645);
INSERT INTO `item` (`ID`,`ClassID`,`SubclassID`,`Material`,`InventoryType`,`SheatheType`,`ItemPetFoodID`,`SoundOverrideSubclassID`,`IconFileDataID`,`ItemGroupSoundsID`,`ContentTuningID`,`ModifiedCraftingReagentItemID`,`Unknown1200`,`CraftingQualityID`,`ItemSquishEraID`,`RecraftReagentCountPercentage`,`OrderSource`,`VerifiedBuild`) VALUES
(18673,4,6,1,14,4,0,-1,134949,9,0,0,0,0,0,0,0,70959),
(22343,4,3,5,10,0,0,-1,132945,10,0,0,0,0,0,0,0,70959),
(22345,4,9,2,28,0,0,-1,134920,12,0,0,0,0,0,0,0,70959),
(22401,4,7,2,28,0,0,-1,134916,19,0,0,0,0,0,0,0,70959),
(22472,4,2,8,8,0,0,-1,132542,7,0,0,0,0,0,0,0,70959),
(219343,4,1,8,16,0,0,-1,133754,7,0,0,0,0,0,0,0,70959),
(284270,4,4,6,1,0,0,-1,0,11,0,0,0,0,0,0,0,70959),
(286641,2,1,1,17,1,0,-1,132395,9,0,0,0,0,0,0,0,70959),
(286644,7,11,1,0,0,0,-1,135131,8,0,0,0,0,0,0,0,70959),
(286645,2,6,1,17,2,0,-1,135131,9,0,0,0,0,0,0,0,70959);
DELETE FROM `item_sparse` WHERE `ID` IN (18673,22343,22345,22401,22472,219343,284270,286641,286644,286645);
INSERT INTO `item_sparse` (`ID`,`Description`,`Display3`,`Display2`,`Display1`,`Display`,`ExpansionID`,`DmgVariance`,`LimitCategory`,`DurationInInventory`,`QualityModifier`,`BagFamily`,`StartQuestID`,`LanguageID`,`ItemRange`,`StatPercentageOfSocket1`,`StatPercentageOfSocket2`,`StatPercentageOfSocket3`,`StatPercentageOfSocket4`,`StatPercentageOfSocket5`,`StatPercentageOfSocket6`,`StatPercentageOfSocket7`,`StatPercentageOfSocket8`,`StatPercentageOfSocket9`,`StatPercentageOfSocket10`,`StatPercentEditor1`,`StatPercentEditor2`,`StatPercentEditor3`,`StatPercentEditor4`,`StatPercentEditor5`,`StatPercentEditor6`,`StatPercentEditor7`,`StatPercentEditor8`,`StatPercentEditor9`,`StatPercentEditor10`,`StatModifierBonusStat1`,`StatModifierBonusStat2`,`StatModifierBonusStat3`,`StatModifierBonusStat4`,`StatModifierBonusStat5`,`StatModifierBonusStat6`,`StatModifierBonusStat7`,`StatModifierBonusStat8`,`StatModifierBonusStat9`,`StatModifierBonusStat10`,`Stackable`,`MaxCount`,`MinReputation`,`RequiredAbility`,`AllowableRace1`,`AllowableRace2`,`SellPrice`,`BuyPrice`,`VendorStackCount`,`PriceVariance`,`PriceRandomValue`,`Flags1`,`Flags2`,`Flags3`,`Flags4`,`Flags5`,`FactionRelated`,`ModifiedCraftingReagentItemID`,`ContentTuningID`,`PlayerLevelToItemLevelCurveID`,`ItemLevelOffsetCurveID`,`ItemLevelOffsetItemLevel`,`ItemSquishEraID`,`ItemNameDescriptionID`,`RequiredTransmogHoliday`,`RequiredHoliday`,`GemProperties`,`SocketMatchEnchantmentId`,`TotemCategoryID`,`InstanceBound`,`ZoneBound1`,`ZoneBound2`,`ItemSet`,`LockID`,`PageID`,`ItemDelay`,`MinFactionID`,`RequiredSkillRank`,`RequiredSkill`,`ItemLevel`,`AllowableClass`,`ArtifactID`,`SpellWeight`,`SpellWeightCategory`,`SocketType1`,`SocketType2`,`SocketType3`,`SheatheType`,`Material`,`PageMaterialID`,`Bonding`,`DamageDamageType`,`ContainerSlots`,`RequiredPVPMedal`,`RequiredPVPRank`,`RequiredLevel`,`InventoryType`,`OverallQualityID`,`AmmunitionType`,`VerifiedBuild`) VALUES
(18673,'','','','','Avalanchion''s Stony Hide',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8421,6315,0,0,0,0,0,0,0,0,7,48,-1,-1,-1,-1,-1,-1,-1,-1,1,0,0,0,-1,-1,28918,144591,1,1,1,0,16388,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,60,-1,0,0,0,0,0,0,4,1,0,2,0,0,0,0,55,14,3,0,70959),
(22343,'','','','','Handguards of Savagery',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4814,3703,13333,0,0,0,0,0,0,0,7,5,38,-1,-1,-1,-1,-1,-1,-1,1,0,0,0,-1,-1,16476,82383,1,1,1,0,4,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,63,-1,0,0,0,0,0,0,0,5,0,1,0,0,0,0,58,10,3,0,70959),
(22345,'','','','','Totem of Tides',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,1,0,0,0,-1,-1,15680,78402,1,1,1,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,62,32767,0,0,0,0,0,0,0,2,0,1,0,0,0,0,57,28,3,0,70959),
(22401,'','','','','Libram of Hope',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,1,0,0,0,-1,-1,17078,85394,1,1,1,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,62,32767,0,0,0,0,0,0,0,2,0,1,0,0,0,0,57,28,3,0,70959),
(22472,'','','','','Boots of Ferocity',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3461,5000,4615,2307,0,0,0,0,0,0,3,7,4,12,-1,-1,-1,-1,-1,-1,1,0,0,0,-1,-1,20193,100965,1,1,1,0,4,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,61,-1,0,0,0,0,0,0,0,8,0,1,0,0,0,0,56,8,3,0,70959),
(219343,'','','','','Filcher''s Cowl',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6875,4375,0,0,0,0,0,0,0,0,3,6,-1,-1,-1,-1,-1,-1,-1,-1,1,0,0,0,-1,-1,0,0,1,1,0.9504,32768,16388,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,-1,0,0,0,0,0,0,0,8,0,1,0,0,0,0,50,16,3,0,70959),
(284270,'','','','','Ancient Giant''s Gaze',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6667,5067,33770,0,0,0,0,0,0,0,4,7,50,-1,-1,-1,-1,-1,-1,-1,1,0,0,0,-1,-1,14087,70437,1,1,0.9708,0,16388,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,56,-1,0,0,0,0,0,0,0,6,0,1,0,0,0,0,51,1,3,0,70959),
(286641,'','','','','Cannibal''s Cleaver',0,0.4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6667,357,5948,8922,0,0,0,0,0,0,7,93,38,125,-1,-1,-1,-1,-1,-1,1,0,0,0,-1,-1,2,14,1,1,0.9899,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3600,0,0,0,50,-1,0,0,0,0,0,0,1,1,0,1,0,0,0,0,45,17,3,0,70959),
(286644,'','','','','Shattered Atal''ai Spear',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,1,0,0,0,-1,-1,15000,25000,1,1,1.0009,1088,16388,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2200,0,225,164,50,-1,0,0,0,0,0,0,0,1,0,1,0,0,0,0,45,0,3,0,70959),
(286645,'Countless entered, few left.','','','','Reforged Atal''ai Spear',0,0.4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6667,5067,5067,0,0,0,0,0,0,0,4,7,32,-1,-1,-1,-1,-1,-1,-1,1,0,0,0,-1,-1,2,14,1,1,1.0046,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3800,0,0,0,50,-1,0,0,0,0,0,0,2,1,0,1,0,0,0,0,45,17,3,0,70959);
DELETE FROM `hotfix_data` WHERE `Id` BETWEEN 2105200 AND 2105299;
DELETE FROM `hotfix_data` WHERE (`TableHash`,`RecordId`) IN ((1344507586,18673),(1344507586,22343),(1344507586,22345),(1344507586,22401),(1344507586,22472),(1344507586,219343),(1344507586,284270),(1344507586,286641),(1344507586,286644),(1344507586,286645),(2442913102,18673),(2442913102,22343),(2442913102,22345),(2442913102,22401),(2442913102,22472),(2442913102,219343),(2442913102,284270),(2442913102,286641),(2442913102,286644),(2442913102,286645));
INSERT INTO `hotfix_data` (`Id`,`UniqueId`,`TableHash`,`RecordId`,`Status`,`VerifiedBuild`) VALUES
(2105200,1397825200,1344507586,18673,1,70959),
(2105201,1397825201,1344507586,22343,1,70959),
(2105202,1397825202,1344507586,22345,1,70959),
(2105203,1397825203,1344507586,22401,1,70959),
(2105204,1397825204,1344507586,22472,1,70959),
(2105205,1397825205,1344507586,219343,1,70959),
(2105206,1397825206,1344507586,284270,1,70959),
(2105207,1397825207,1344507586,286641,1,70959),
(2105208,1397825208,1344507586,286644,1,70959),
(2105209,1397825209,1344507586,286645,1,70959),
(2105210,1397825210,2442913102,18673,1,70959),
(2105211,1397825211,2442913102,22343,1,70959),
(2105212,1397825212,2442913102,22345,1,70959),
(2105213,1397825213,2442913102,22401,1,70959),
(2105214,1397825214,2442913102,22472,1,70959),
(2105215,1397825215,2442913102,219343,1,70959),
(2105216,1397825216,2442913102,284270,1,70959),
(2105217,1397825217,2442913102,286641,1,70959),
(2105218,1397825218,2442913102,286644,1,70959),
(2105219,1397825219,2442913102,286645,1,70959);
