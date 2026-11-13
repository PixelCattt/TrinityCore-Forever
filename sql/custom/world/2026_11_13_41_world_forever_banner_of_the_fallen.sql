-- Banner of the Fallen (86585, Forever, Loch Modan): "unable to accept the quest" (Discord "bugs 4", 2026-11-13). The quest was
-- not in the world database at all (PC step 104: no quest_template, objectives or giver rows), though its giver Mountaineer Ylva
-- (269153), the trogg Headsplitter (269185, two spawns beside her) and the client items are there (from 2026_11_05_99).
-- Built from EG Link (Efficient Games, https://efficient.games, CC BY 4.0): title, texts, level 17 / min 10, objectives with
-- their live ids (475904: hold the standard 253247, given on accept; 475960: kill Headsplitter), reward choice 281253 or
-- 281254, Ironforge reputation tier 5, XP and money difficulty 5. Giver Ylva and ender Captain Rugelfuss (1092) from Questie's
-- Forever traces (GPL-3). Every other field as Excavation Tools (86613), the Forever Loch Modan quest one level up.
-- INFERRED: no reward or progress text is known, so those stay empty; races Alliance (as 86613).
-- Raising the standard (spell 1303317) needs spell focus 2311 and sends event 105217; Headsplitter already stands there, so the
-- quest can be done without it. Safe to run again.
DELETE FROM `quest_template` WHERE `ID` = 86585;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestPackageID`,`ContentTuningID`,`QuestSortID`,`QuestInfoID`,`SuggestedGroupNum`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardBonusMoney`,`RewardDisplaySpell1`,`RewardDisplaySpell2`,`RewardDisplaySpell3`,`RewardSpell`,`RewardHonor`,`RewardKillHonor`,`StartItem`,`RewardArtifactXPDifficulty`,`RewardArtifactXPMultiplier`,`RewardArtifactCategoryID`,`Flags`,`FlagsEx`,`FlagsEx2`,`FlagsEx3`,`RewardItem1`,`RewardAmount1`,`RewardItem2`,`RewardAmount2`,`RewardItem3`,`RewardAmount3`,`RewardItem4`,`RewardAmount4`,`ItemDrop1`,`ItemDropQuantity1`,`ItemDrop2`,`ItemDropQuantity2`,`ItemDrop3`,`ItemDropQuantity3`,`ItemDrop4`,`ItemDropQuantity4`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemDisplayID1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemDisplayID2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardChoiceItemDisplayID3`,`RewardChoiceItemID4`,`RewardChoiceItemQuantity4`,`RewardChoiceItemDisplayID4`,`RewardChoiceItemID5`,`RewardChoiceItemQuantity5`,`RewardChoiceItemDisplayID5`,`RewardChoiceItemID6`,`RewardChoiceItemQuantity6`,`RewardChoiceItemDisplayID6`,`POIContinent`,`POIx`,`POIy`,`POIPriority`,`RewardTitle`,`RewardArenaPoints`,`RewardSkillLineID`,`RewardNumSkillUps`,`PortraitGiver`,`PortraitGiverMount`,`PortraitGiverModelSceneID`,`PortraitTurnIn`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`RewardFactionCapIn1`,`RewardFactionID2`,`RewardFactionValue2`,`RewardFactionOverride2`,`RewardFactionCapIn2`,`RewardFactionID3`,`RewardFactionValue3`,`RewardFactionOverride3`,`RewardFactionCapIn3`,`RewardFactionID4`,`RewardFactionValue4`,`RewardFactionOverride4`,`RewardFactionCapIn4`,`RewardFactionID5`,`RewardFactionValue5`,`RewardFactionOverride5`,`RewardFactionCapIn5`,`RewardFactionFlags`,`RewardCurrencyID1`,`RewardCurrencyQty1`,`RewardCurrencyID2`,`RewardCurrencyQty2`,`RewardCurrencyID3`,`RewardCurrencyQty3`,`RewardCurrencyID4`,`RewardCurrencyQty4`,`AcceptedSoundKitID`,`CompleteSoundKitID`,`AreaGroupID`,`TimeAllowed`,`AllowableRaces`,`Expansion`,`ManagedWorldStateID`,`QuestSessionBonus`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`PortraitGiverText`,`PortraitGiverName`,`PortraitTurnInText`,`PortraitTurnInName`,`QuestCompletionLog`,`ResetByScheduler`,`VerifiedBuild`,`RewardFavor`) VALUES
(86585,2,0,0,38,0,0,0,5,1.0e0,5,1.0e0,0,0,0,0,0,0,0,253247,0,1.0e0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,281253,1,0,281254,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.0e0,0.0e0,0,0,0,0,0,0,0,0,0,47,5,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,1,0,0,0,0,0,0,0,0,890,878,0,0,4294967373,0,0,0,'Banner of the Fallen','Raise the standard of Ironforge, call out the trogg Headsplitter and kill it, then report to Captain Rugelfuss.','The fallen mountaineer bears a standard of Ironforge. Perhaps she was scouting, or making a doomed charge. Either way, the standard has been cast down and trampled. The mountaineer was hit on the head so hard that her helm was knocked off and she was killed outright by a trogg, likely with a spiked club.$B$BThe trogg that killed her is probably still nearby, and likely remembers the banner. Raising the banner of Ironforge once more may call it out.','','','','','','',0,0,0);
DELETE FROM `quest_template_addon` WHERE `ID` = 86585;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`SourceSpellID`,`PrevQuestID`,`NextQuestID`,`ExclusiveGroup`,`BreadcrumbForQuestId`,`RewardMailTemplateID`,`RewardMailDelay`,`RequiredSkillID`,`RequiredSkillPoints`,`RequiredMinRepFaction`,`RequiredMaxRepFaction`,`RequiredMinRepValue`,`RequiredMaxRepValue`,`ProvidedItemCount`,`SpecialFlags`,`ScriptName`) VALUES
(86585,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,'');
DELETE FROM `quest_objectives` WHERE `QuestID` = 86585;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(475904,86585,1,0,0,253247,1,0,0,0,0,0,1,'',0),
(475960,86585,0,1,1,269185,1,0,0,0,0,0,1,'',0);
DELETE FROM `quest_classic_level` WHERE `ID` = 86585;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (86585,17,10,0);
DELETE FROM `quest_template_classic_level` WHERE `ID` = 86585;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (86585,2,17);
DELETE FROM `creature_queststarter` WHERE `quest` = 86585;
INSERT INTO `creature_queststarter` (`id`,`quest`) VALUES (269153,86585);
DELETE FROM `creature_questender` WHERE `quest` = 86585;
INSERT INTO `creature_questender` (`id`,`quest`) VALUES (1092,86585);
-- map areas: Headsplitter's two spawns (2026_11_05_99), turn-in at Rugelfuss's tower (vMaNGOS spawn 8201), Loch Modan UiMap 1432
DELETE FROM `quest_poi` WHERE `QuestID` = 86585;
INSERT INTO `quest_poi` (`QuestID`,`BlobIndex`,`Idx1`,`ObjectiveIndex`,`QuestObjectiveID`,`QuestObjectID`,`MapID`,`UiMapID`,`Priority`,`Flags`,`WorldEffectID`,`PlayerConditionID`,`NavigationPlayerConditionID`,`SpawnTrackingID`,`AlwaysAllowMergingBlobs`,`VerifiedBuild`) VALUES
(86585,0,0,-1,0,0,0,1432,0,0,0,0,0,0,0,0),
(86585,0,1,1,475960,269185,0,1432,0,0,0,0,0,0,0,0);
DELETE FROM `quest_poi_points` WHERE `QuestID` = 86585;
INSERT INTO `quest_poi_points` (`QuestID`,`Idx1`,`Idx2`,`X`,`Y`,`Z`,`VerifiedBuild`) VALUES
(86585,0,0,-5843,-2635,323,0),
(86585,1,0,-6047,-2845,413,0),(86585,1,1,-6077,-2840,413,0),(86585,1,2,-6106,-2957,401,0),(86585,1,3,-6077,-2962,401,0);
