-- WoW Forever: the rest of Blizzard's 70959 public hotfix file (mirror of 2026-11-19 08:57Z, pushes to 114206) that
-- 2026_11_17_75 and 2026_11_17_76 do not hold: Sap (2070, 6770, 11297) loses SpellAttr7 0x4 (aura no longer turned off while
-- the caster is dead) in push 114190, spell 1312870's effect 1343948 in push 114202, and item 268810 Ruzzgot's Shipment
-- (push 114183). Every other server-table record of pushes 114103-114206 is already in those two files, value for value.
-- Only tables our server loads; client-only records and the per-item shop pushes (16 million and up) are left out. Every
-- record decodes byte-exact with our current layouts. Made with tools/full_forever/live_hotfix_sql.py.
-- hotfix_data ids 2102000-2102999. Safe to run again.

DELETE FROM `item` WHERE `ID` IN (268810);
INSERT INTO `item` (`ID`,`ClassID`,`SubclassID`,`Material`,`InventoryType`,`SheatheType`,`ItemPetFoodID`,`SoundOverrideSubclassID`,`IconFileDataID`,`ItemGroupSoundsID`,`ContentTuningID`,`ModifiedCraftingReagentItemID`,`Unknown1200`,`CraftingQualityID`,`ItemSquishEraID`,`RecraftReagentCountPercentage`,`OrderSource`,`VerifiedBuild`) VALUES
(268810,12,0,0,0,0,0,-1,986485,11,0,0,0,0,0,0,0,70959);
DELETE FROM `item_sparse` WHERE `ID` IN (268810);
INSERT INTO `item_sparse` (`ID`,`Description`,`Display3`,`Display2`,`Display1`,`Display`,`ExpansionID`,`DmgVariance`,`LimitCategory`,`DurationInInventory`,`QualityModifier`,`BagFamily`,`StartQuestID`,`LanguageID`,`ItemRange`,`StatPercentageOfSocket1`,`StatPercentageOfSocket2`,`StatPercentageOfSocket3`,`StatPercentageOfSocket4`,`StatPercentageOfSocket5`,`StatPercentageOfSocket6`,`StatPercentageOfSocket7`,`StatPercentageOfSocket8`,`StatPercentageOfSocket9`,`StatPercentageOfSocket10`,`StatPercentEditor1`,`StatPercentEditor2`,`StatPercentEditor3`,`StatPercentEditor4`,`StatPercentEditor5`,`StatPercentEditor6`,`StatPercentEditor7`,`StatPercentEditor8`,`StatPercentEditor9`,`StatPercentEditor10`,`StatModifierBonusStat1`,`StatModifierBonusStat2`,`StatModifierBonusStat3`,`StatModifierBonusStat4`,`StatModifierBonusStat5`,`StatModifierBonusStat6`,`StatModifierBonusStat7`,`StatModifierBonusStat8`,`StatModifierBonusStat9`,`StatModifierBonusStat10`,`Stackable`,`MaxCount`,`MinReputation`,`RequiredAbility`,`AllowableRace1`,`AllowableRace2`,`SellPrice`,`BuyPrice`,`VendorStackCount`,`PriceVariance`,`PriceRandomValue`,`Flags1`,`Flags2`,`Flags3`,`Flags4`,`Flags5`,`FactionRelated`,`ModifiedCraftingReagentItemID`,`ContentTuningID`,`PlayerLevelToItemLevelCurveID`,`ItemLevelOffsetCurveID`,`ItemLevelOffsetItemLevel`,`ItemSquishEraID`,`ItemNameDescriptionID`,`RequiredTransmogHoliday`,`RequiredHoliday`,`GemProperties`,`SocketMatchEnchantmentId`,`TotemCategoryID`,`InstanceBound`,`ZoneBound1`,`ZoneBound2`,`ItemSet`,`LockID`,`PageID`,`ItemDelay`,`MinFactionID`,`RequiredSkillRank`,`RequiredSkill`,`ItemLevel`,`AllowableClass`,`ArtifactID`,`SpellWeight`,`SpellWeightCategory`,`SocketType1`,`SocketType2`,`SocketType3`,`SheatheType`,`Material`,`PageMaterialID`,`Bonding`,`DamageDamageType`,`ContainerSlots`,`RequiredPVPMedal`,`RequiredPVPRank`,`RequiredLevel`,`InventoryType`,`OverallQualityID`,`AmmunitionType`,`VerifiedBuild`) VALUES
(268810,'','','','','Ruzzgot''s Shipment',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,20,0,0,0,-1,-1,0,0,1,1,0.9686,2048,24580,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-1,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,1,0,70959);
DELETE FROM `spell_effect` WHERE `ID` IN (1343948);
INSERT INTO `spell_effect` (`ID`,`EffectAura`,`DifficultyID`,`EffectIndex`,`Effect`,`EffectAmplitude`,`EffectAttributes`,`EffectAuraPeriod`,`EffectBonusCoefficient`,`EffectChainAmplitude`,`EffectChainTargets`,`EffectItemType`,`EffectMechanic`,`EffectPointsPerResource`,`EffectPosFacing`,`EffectRealPointsPerLevel`,`EffectTriggerSpell`,`BonusCoefficientFromAP`,`PvpMultiplier`,`Coefficient`,`Variance`,`ResourceCoefficient`,`GroupSizeBasePointsCoefficient`,`EffectBasePoints`,`ScalingClass`,`TargetNodeGraph`,`EffectMiscValue1`,`EffectMiscValue2`,`EffectRadiusIndex1`,`EffectRadiusIndex2`,`EffectSpellClassMask1`,`EffectSpellClassMask2`,`EffectSpellClassMask3`,`EffectSpellClassMask4`,`ImplicitTarget1`,`ImplicitTarget2`,`SpellID`,`VerifiedBuild`) VALUES
(1343948,0,0,0,2,0,0,0,1,1,0,0,0,0,0,0,0,0,1,0,0.25,0,1,55,0,0,0,0,0,13,0,0,0,0,53,16,1312870,70959);
DELETE FROM `spell_misc` WHERE `ID` IN (316193,319142,324065);
INSERT INTO `spell_misc` (`ID`,`Attributes1`,`Attributes2`,`Attributes3`,`Attributes4`,`Attributes5`,`Attributes6`,`Attributes7`,`Attributes8`,`Attributes9`,`Attributes10`,`Attributes11`,`Attributes12`,`Attributes13`,`Attributes14`,`Attributes15`,`Attributes16`,`Attributes17`,`DifficultyID`,`CastingTimeIndex`,`DurationIndex`,`PvPDurationIndex`,`RangeIndex`,`SchoolMask`,`Speed`,`LaunchDelay`,`MinDuration`,`SpellIconFileDataID`,`ActiveIconFileDataID`,`ContentTuningID`,`ShowFutureSpellPlayerConditionID`,`SpellVisualScript`,`ActiveSpellVisualScript`,`SpellID`,`VerifiedBuild`) VALUES
(316193,1077346320,134481184,268435456,196609,8388608,0,2097152,0,0,0,0,0,0,128,64,8192,0,0,1,125,0,2,1,0,0,0,132310,0,0,0,0,0,2070,70959),
(319142,1077346320,134481184,268435456,196609,8388608,0,2097152,0,0,0,0,0,0,128,64,8192,0,0,1,63,0,2,1,0,0,0,132310,0,0,0,0,0,6770,70959),
(324065,1077346320,134481184,268435456,196609,8388608,0,2097152,0,0,0,0,0,0,128,64,8192,0,0,1,22,0,2,1,0,0,0,132310,0,0,0,0,0,11297,70959);
DELETE FROM `hotfix_data` WHERE `Id` BETWEEN 2102000 AND 2102999;
DELETE FROM `hotfix_data` WHERE (`TableHash`,`RecordId`) IN ((1344507586,268810),(428746933,268810),(2442913102,268810),(4030871717,1343948),(3322146344,316193),(3322146344,319142),(3322146344,324065));
INSERT INTO `hotfix_data` (`Id`,`UniqueId`,`TableHash`,`RecordId`,`Status`,`VerifiedBuild`) VALUES
(2102000,1397822000,1344507586,268810,1,70959),
(2102001,1397822001,428746933,268810,3,70959),
(2102002,1397822002,2442913102,268810,1,70959),
(2102003,1397822003,4030871717,1343948,1,70959),
(2102004,1397822004,3322146344,316193,1,70959),
(2102005,1397822005,3322146344,319142,1,70959),
(2102006,1397822006,3322146344,324065,1,70959);
