-- WoW Forever: the rogue jobs of "C" at the Dead Drop near Pyrewood Village (Silverpine Forest), levels 20-35.
--   The Horn of Xelthos (78261) -> payment 78307 (Pyrewood Signet Ring), Goblin Lockpicks (78270, Veenix: Breaching Charge),
--   The Eye of Bhossca (78676) -> payment 78699 (Ruby-Adorned Blade).
-- Scripts: src/server/scripts/Custom/Classic/world/classic_rogue_dead_drop.cpp (letters in capitals, solo-only twins, keyed
-- chests, Graveyard benches, Breach Gate, Combine Half-Keys).
-- Sources: quest/NPC records from the live game (EG Link, CC BY 4.0, via the Everlake overlay), QuestieDB (GPL-3.0), Wowhead
-- (WoW Forever pages of the quests, items, objects and spells: object models, keys, the players' step lists).
-- ESTIMATED (marked below): the spots of Gemela, Gefell and the chests inside Shadowfang Keep and the Scarlet Monastery, the two
-- Graveyard benches, the Supply Locker height, the payment texts, the work order chances and 78699's experience. No source has
-- the live in-dungeon positions; they follow the players' room descriptions and the rooms' existing spawns.
-- Guarded: every insert skips a row that is already there, so this file and the Everlake build (950) can run in either order.

-- Quests 78261, 78270, 78676 as recorded on the live game (same rows as the Everlake build 950).
INSERT IGNORE INTO `quest_template` (`ID`, `QuestType`, `QuestPackageID`, `ContentTuningID`, `QuestSortID`, `QuestInfoID`, `SuggestedGroupNum`, `RewardNextQuest`, `RewardXPDifficulty`, `RewardXPMultiplier`, `RewardMoneyDifficulty`, `RewardMoneyMultiplier`, `RewardBonusMoney`, `RewardDisplaySpell1`, `RewardDisplaySpell2`, `RewardDisplaySpell3`, `RewardSpell`, `RewardHonor`, `RewardKillHonor`, `StartItem`, `RewardArtifactXPDifficulty`, `RewardArtifactXPMultiplier`, `RewardArtifactCategoryID`, `Flags`, `FlagsEx`, `FlagsEx2`, `FlagsEx3`, `RewardItem1`, `RewardAmount1`, `RewardItem2`, `RewardAmount2`, `RewardItem3`, `RewardAmount3`, `RewardItem4`, `RewardAmount4`, `ItemDrop1`, `ItemDropQuantity1`, `ItemDrop2`, `ItemDropQuantity2`, `ItemDrop3`, `ItemDropQuantity3`, `ItemDrop4`, `ItemDropQuantity4`, `RewardChoiceItemID1`, `RewardChoiceItemQuantity1`, `RewardChoiceItemDisplayID1`, `RewardChoiceItemID2`, `RewardChoiceItemQuantity2`, `RewardChoiceItemDisplayID2`, `RewardChoiceItemID3`, `RewardChoiceItemQuantity3`, `RewardChoiceItemDisplayID3`, `RewardChoiceItemID4`, `RewardChoiceItemQuantity4`, `RewardChoiceItemDisplayID4`, `RewardChoiceItemID5`, `RewardChoiceItemQuantity5`, `RewardChoiceItemDisplayID5`, `RewardChoiceItemID6`, `RewardChoiceItemQuantity6`, `RewardChoiceItemDisplayID6`, `POIContinent`, `POIx`, `POIy`, `POIPriority`, `RewardTitle`, `RewardArenaPoints`, `RewardSkillLineID`, `RewardNumSkillUps`, `PortraitGiver`, `PortraitGiverMount`, `PortraitGiverModelSceneID`, `PortraitTurnIn`, `RewardFactionID1`, `RewardFactionValue1`, `RewardFactionOverride1`, `RewardFactionCapIn1`, `RewardFactionID2`, `RewardFactionValue2`, `RewardFactionOverride2`, `RewardFactionCapIn2`, `RewardFactionID3`, `RewardFactionValue3`, `RewardFactionOverride3`, `RewardFactionCapIn3`, `RewardFactionID4`, `RewardFactionValue4`, `RewardFactionOverride4`, `RewardFactionCapIn4`, `RewardFactionID5`, `RewardFactionValue5`, `RewardFactionOverride5`, `RewardFactionCapIn5`, `RewardFactionFlags`, `RewardCurrencyID1`, `RewardCurrencyQty1`, `RewardCurrencyID2`, `RewardCurrencyQty2`, `RewardCurrencyID3`, `RewardCurrencyQty3`, `RewardCurrencyID4`, `RewardCurrencyQty4`, `AcceptedSoundKitID`, `CompleteSoundKitID`, `AreaGroupID`, `TimeAllowed`, `AllowableRaces`, `Expansion`, `ManagedWorldStateID`, `QuestSessionBonus`, `LogTitle`, `LogDescription`, `QuestDescription`, `AreaDescription`, `PortraitGiverText`, `PortraitGiverName`, `PortraitTurnInText`, `PortraitTurnInName`, `QuestCompletionLog`, `ResetByScheduler`, `VerifiedBuild`, `RewardFavor`) VALUES
(78261, 2, 0, 0, -162, 0, 0, 78307, 5, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 33554688, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 890, 878, 0, 0, 18446744073709551615, -2, 0, 0, 'The Horn of Xelthos', 'Find The Horn of Xelthos inside of Shadowfang Keep. Then, return it to C''s dead drop near Pyrewood Village. You must complete the job alone.', '<A note sits in the chest>\r\n\r\nHello, $n.\r\n\r\nI desire a treasure known as The Horn of Xelthos, which is somewhere within Shadowfang Keep.\r\n\r\nVenturing inside the keep usually calls for backup. However, for this job, a low profile is of utmost importance.\r\n\r\nYou must go alone.\r\n\r\nI have a contact, by the name of Veenix, in the Stonetalon Mountains. He should be able to help you get past the courtyard gate. The rest is up to you. \r\n\r\nReturn the horn here, and your payment will be sent soon after.\r\n\r\n- C', '', NULL, NULL, NULL, NULL, '', 0, 0, 0),
(78270, 0, 0, 0, -162, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 33554432, 0, 0, 0, 210186, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 890, 878, 0, 0, 18446744073709551615, -2, 0, 0, 'Goblin Lockpicks', 'Find The Horn of Xelthos inside of Shadowfang Keep. Then, return it to C''s dead drop near Pyrewood Village.', '<A note sits in the chest>\r\n\r\nHello again, $n.\r\n\r\nI desire a treasure known as The Horn of Xelthos, which is somewhere within Shadowfang Keep.\r\n\r\nVenturing inside the keep usually calls for backup. However, for this job, a low profile is of utmost importance.\r\n\r\nYou must go alone.\r\n\r\nI have a contact, by the name of Veenix, in the Stonetalon Mountains. He should be able to help you get past the courtyard gate. The rest is up to you. \r\n\r\nReturn the horn here, and your payment will be sent soon after.\r\n\r\n- C', '', NULL, NULL, NULL, NULL, '', 0, 0, 0),
(78676, 2, 0, 0, -162, 0, 0, 0, 6, 1, 0, 1, 0, 0, 0, 0, 427931, 0, 0, 0, 0, 1, 0, 35651584, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 890, 878, 0, 0, 18446744073709551615, -2, 0, 0, 'The Eye of Bhossca', 'Find The Eye of Bhossca inside of the Scarlet Monastery. Then, return it to C''s dead drop near Pyrewood Village. You must complete the job alone.', '<A note sits in the chest>\r\n\r\nGlad to have you back, $n.\r\n\r\nThe latest object of my desire is an artifact known as the Eye of Bhossca. My sources tell me the eye is somewhere within the Scarlet Monastery. As with Shadowfang Keep, you must infiltrate the monastery alone.\r\n\r\nIt may behoove you to find a disguise before going in. It will make getting around a touch easier. I''m sure you could find something on the monastery''s grounds.\r\n\r\nReturn the eye here, and payment will be delivered as before.\r\n\r\n- C', '', NULL, NULL, NULL, NULL, '', 0, 0, 0);
INSERT IGNORE INTO `quest_objectives` (`ID`, `QuestID`, `Type`, `Order`, `StorageIndex`, `ObjectID`, `Amount`, `ConditionalAmount`, `Flags`, `Flags2`, `ProgressBarWeight`, `ParentObjectiveID`, `Visible`, `Description`, `VerifiedBuild`) VALUES
(444187, 78261, 1, 0, 1, 210183, 1, 0, 32, 0, 0, 0, 1, '', 0),
(444216, 78270, 1, 0, 0, 210187, 1, 0, 32, 0, 0, 0, 1, '', 0),
(444792, 78676, 1, 0, 0, 210953, 1, 0, 32, 0, 0, 0, 1, '', 0),
(477011, 78261, 3, 1, 0, 4086, 1, 0, 32, 0, 0, 0, 1, 'Find Veenix', 0);
INSERT IGNORE INTO `quest_template_addon` (`ID`, `MaxLevel`, `AllowableClasses`, `SourceSpellID`, `PrevQuestID`, `NextQuestID`, `ExclusiveGroup`, `BreadcrumbForQuestId`, `RewardMailTemplateID`, `RewardMailDelay`, `RequiredSkillID`, `RequiredSkillPoints`, `RequiredMinRepFaction`, `RequiredMaxRepFaction`, `RequiredMinRepValue`, `RequiredMaxRepValue`, `ProvidedItemCount`, `SpecialFlags`, `ScriptName`) VALUES
(78261, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ''),
(78270, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ''),
(78676, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '');
INSERT IGNORE INTO `quest_classic_level` (`ID`, `QuestLevel`, `MinLevel`, `MaxLevel`) VALUES
(78261, 23, 1, 0),
(78270, 23, 1, 0),
(78676, 35, 25, 0);
INSERT IGNORE INTO `quest_template_classic_level` (`ID`, `LevelType`, `QuestLevel`) VALUES
(78261, 2, 23),
(78270, 2, 23),
(78676, 2, 35);
INSERT IGNORE INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(78261, 0, 0, 0, 0, 0, 0, 0, 0, '<You place The Horn of Xelthos into the chest>', 0),
(78270, 0, 0, 0, 0, 0, 0, 0, 0, 'Nice job, $N. I figure that was a cakewalk for someone in your line of work.$B$BAs promised, here''s the goods.', 0),
(78676, 0, 0, 0, 0, 0, 0, 0, 0, '<You place The Eye of Bhossca into the chest>', 0);
INSERT IGNORE INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(78261, 0, 0, 0, 0, '<The chest sits, empty.>', 0),
(78270, 0, 0, 0, 0, 'You said you''re breaking into Shadowfang...alone? You''ve got some guts!$B$BI can hook you up with explosives to get past the gate, but I''ll need a work order to make it look legit on the books. An employee around here''s likely carrying one. Probably someone who does a lot of tinkering or building.', 0),
(78676, 0, 0, 0, 0, '<The chest sits, empty.>', 0);
INSERT IGNORE INTO `gameobject_queststarter` (`id`, `quest`, `VerifiedBuild`) VALUES
(410369, 78261, 0),
(410369, 78676, 0);
INSERT IGNORE INTO `gameobject_questender` (`id`, `quest`, `VerifiedBuild`) VALUES
(410369, 78261, 0),
(410369, 78676, 0);
INSERT IGNORE INTO `creature_queststarter` (`id`, `quest`, `VerifiedBuild`) VALUES
(4086, 78270, 0);
INSERT IGNORE INTO `creature_questender` (`id`, `quest`, `VerifiedBuild`) VALUES
(4086, 78270, 0);

-- The payments: no giver; a capital visit puts them in the log, finished (classic_player_rogue_dead_drop), for the hand-in at
-- the Dead Drop. 78307: live record (EG Link 70959): level 23, 30 silver, Pyrewood Signet Ring 277210, experience 6 x3.
-- 78699: QuestieDB/Wowhead (level 35, min 25, Ruby-Adorned Blade 277246); its experience is ESTIMATED as 78307's, no money.
-- The live log texts are placeholders ("Description", "Log"): ours tell the player where to go.
INSERT IGNORE INTO `quest_template` (`ID`, `QuestType`, `QuestPackageID`, `ContentTuningID`, `QuestSortID`, `QuestInfoID`, `SuggestedGroupNum`, `RewardNextQuest`, `RewardXPDifficulty`, `RewardXPMultiplier`, `RewardMoneyDifficulty`, `RewardMoneyMultiplier`, `RewardBonusMoney`, `RewardDisplaySpell1`, `RewardDisplaySpell2`, `RewardDisplaySpell3`, `RewardSpell`, `RewardHonor`, `RewardKillHonor`, `StartItem`, `RewardArtifactXPDifficulty`, `RewardArtifactXPMultiplier`, `RewardArtifactCategoryID`, `Flags`, `FlagsEx`, `FlagsEx2`, `FlagsEx3`, `RewardItem1`, `RewardAmount1`, `RewardItem2`, `RewardAmount2`, `RewardItem3`, `RewardAmount3`, `RewardItem4`, `RewardAmount4`, `ItemDrop1`, `ItemDropQuantity1`, `ItemDrop2`, `ItemDropQuantity2`, `ItemDrop3`, `ItemDropQuantity3`, `ItemDrop4`, `ItemDropQuantity4`, `RewardChoiceItemID1`, `RewardChoiceItemQuantity1`, `RewardChoiceItemDisplayID1`, `RewardChoiceItemID2`, `RewardChoiceItemQuantity2`, `RewardChoiceItemDisplayID2`, `RewardChoiceItemID3`, `RewardChoiceItemQuantity3`, `RewardChoiceItemDisplayID3`, `RewardChoiceItemID4`, `RewardChoiceItemQuantity4`, `RewardChoiceItemDisplayID4`, `RewardChoiceItemID5`, `RewardChoiceItemQuantity5`, `RewardChoiceItemDisplayID5`, `RewardChoiceItemID6`, `RewardChoiceItemQuantity6`, `RewardChoiceItemDisplayID6`, `POIContinent`, `POIx`, `POIy`, `POIPriority`, `RewardTitle`, `RewardArenaPoints`, `RewardSkillLineID`, `RewardNumSkillUps`, `PortraitGiver`, `PortraitGiverMount`, `PortraitGiverModelSceneID`, `PortraitTurnIn`, `RewardFactionID1`, `RewardFactionValue1`, `RewardFactionOverride1`, `RewardFactionCapIn1`, `RewardFactionID2`, `RewardFactionValue2`, `RewardFactionOverride2`, `RewardFactionCapIn2`, `RewardFactionID3`, `RewardFactionValue3`, `RewardFactionOverride3`, `RewardFactionCapIn3`, `RewardFactionID4`, `RewardFactionValue4`, `RewardFactionOverride4`, `RewardFactionCapIn4`, `RewardFactionID5`, `RewardFactionValue5`, `RewardFactionOverride5`, `RewardFactionCapIn5`, `RewardFactionFlags`, `RewardCurrencyID1`, `RewardCurrencyQty1`, `RewardCurrencyID2`, `RewardCurrencyQty2`, `RewardCurrencyID3`, `RewardCurrencyQty3`, `RewardCurrencyID4`, `RewardCurrencyQty4`, `AcceptedSoundKitID`, `CompleteSoundKitID`, `AreaGroupID`, `TimeAllowed`, `AllowableRaces`, `Expansion`, `ManagedWorldStateID`, `QuestSessionBonus`, `LogTitle`, `LogDescription`, `QuestDescription`, `AreaDescription`, `PortraitGiverText`, `PortraitGiverName`, `PortraitTurnInText`, `PortraitTurnInName`, `QuestCompletionLog`, `ResetByScheduler`, `VerifiedBuild`, `RewardFavor`)
SELECT 78307, 2, `QuestPackageID`, `ContentTuningID`, `QuestSortID`, `QuestInfoID`, `SuggestedGroupNum`, 0, 6, 3, `RewardMoneyDifficulty`, `RewardMoneyMultiplier`, `RewardBonusMoney`, `RewardDisplaySpell1`, `RewardDisplaySpell2`, `RewardDisplaySpell3`, `RewardSpell`, `RewardHonor`, `RewardKillHonor`, `StartItem`, `RewardArtifactXPDifficulty`, `RewardArtifactXPMultiplier`, `RewardArtifactCategoryID`, `Flags`, `FlagsEx`, `FlagsEx2`, `FlagsEx3`, 277210, 1, `RewardItem2`, `RewardAmount2`, `RewardItem3`, `RewardAmount3`, `RewardItem4`, `RewardAmount4`, `ItemDrop1`, `ItemDropQuantity1`, `ItemDrop2`, `ItemDropQuantity2`, `ItemDrop3`, `ItemDropQuantity3`, `ItemDrop4`, `ItemDropQuantity4`, `RewardChoiceItemID1`, `RewardChoiceItemQuantity1`, `RewardChoiceItemDisplayID1`, `RewardChoiceItemID2`, `RewardChoiceItemQuantity2`, `RewardChoiceItemDisplayID2`, `RewardChoiceItemID3`, `RewardChoiceItemQuantity3`, `RewardChoiceItemDisplayID3`, `RewardChoiceItemID4`, `RewardChoiceItemQuantity4`, `RewardChoiceItemDisplayID4`, `RewardChoiceItemID5`, `RewardChoiceItemQuantity5`, `RewardChoiceItemDisplayID5`, `RewardChoiceItemID6`, `RewardChoiceItemQuantity6`, `RewardChoiceItemDisplayID6`, `POIContinent`, `POIx`, `POIy`, `POIPriority`, `RewardTitle`, `RewardArenaPoints`, `RewardSkillLineID`, `RewardNumSkillUps`, `PortraitGiver`, `PortraitGiverMount`, `PortraitGiverModelSceneID`, `PortraitTurnIn`, `RewardFactionID1`, `RewardFactionValue1`, `RewardFactionOverride1`, `RewardFactionCapIn1`, `RewardFactionID2`, `RewardFactionValue2`, `RewardFactionOverride2`, `RewardFactionCapIn2`, `RewardFactionID3`, `RewardFactionValue3`, `RewardFactionOverride3`, `RewardFactionCapIn3`, `RewardFactionID4`, `RewardFactionValue4`, `RewardFactionOverride4`, `RewardFactionCapIn4`, `RewardFactionID5`, `RewardFactionValue5`, `RewardFactionOverride5`, `RewardFactionCapIn5`, `RewardFactionFlags`, `RewardCurrencyID1`, `RewardCurrencyQty1`, `RewardCurrencyID2`, `RewardCurrencyQty2`, `RewardCurrencyID3`, `RewardCurrencyQty3`, `RewardCurrencyID4`, `RewardCurrencyQty4`, `AcceptedSoundKitID`, `CompleteSoundKitID`, `AreaGroupID`, `TimeAllowed`, `AllowableRaces`, `Expansion`, `ManagedWorldStateID`, `QuestSessionBonus`, 'The Horn of Xelthos', 'Return to C''s dead drop near Pyrewood Village to collect your payment.', 'Your payment for the Horn of Xelthos is waiting in C''s dead drop near Pyrewood Village.', `AreaDescription`, `PortraitGiverText`, `PortraitGiverName`, `PortraitTurnInText`, `PortraitTurnInName`, '', `ResetByScheduler`, `VerifiedBuild`, `RewardFavor`
FROM `quest_template` WHERE `ID` = 78261;
INSERT IGNORE INTO `quest_template` (`ID`, `QuestType`, `QuestPackageID`, `ContentTuningID`, `QuestSortID`, `QuestInfoID`, `SuggestedGroupNum`, `RewardNextQuest`, `RewardXPDifficulty`, `RewardXPMultiplier`, `RewardMoneyDifficulty`, `RewardMoneyMultiplier`, `RewardBonusMoney`, `RewardDisplaySpell1`, `RewardDisplaySpell2`, `RewardDisplaySpell3`, `RewardSpell`, `RewardHonor`, `RewardKillHonor`, `StartItem`, `RewardArtifactXPDifficulty`, `RewardArtifactXPMultiplier`, `RewardArtifactCategoryID`, `Flags`, `FlagsEx`, `FlagsEx2`, `FlagsEx3`, `RewardItem1`, `RewardAmount1`, `RewardItem2`, `RewardAmount2`, `RewardItem3`, `RewardAmount3`, `RewardItem4`, `RewardAmount4`, `ItemDrop1`, `ItemDropQuantity1`, `ItemDrop2`, `ItemDropQuantity2`, `ItemDrop3`, `ItemDropQuantity3`, `ItemDrop4`, `ItemDropQuantity4`, `RewardChoiceItemID1`, `RewardChoiceItemQuantity1`, `RewardChoiceItemDisplayID1`, `RewardChoiceItemID2`, `RewardChoiceItemQuantity2`, `RewardChoiceItemDisplayID2`, `RewardChoiceItemID3`, `RewardChoiceItemQuantity3`, `RewardChoiceItemDisplayID3`, `RewardChoiceItemID4`, `RewardChoiceItemQuantity4`, `RewardChoiceItemDisplayID4`, `RewardChoiceItemID5`, `RewardChoiceItemQuantity5`, `RewardChoiceItemDisplayID5`, `RewardChoiceItemID6`, `RewardChoiceItemQuantity6`, `RewardChoiceItemDisplayID6`, `POIContinent`, `POIx`, `POIy`, `POIPriority`, `RewardTitle`, `RewardArenaPoints`, `RewardSkillLineID`, `RewardNumSkillUps`, `PortraitGiver`, `PortraitGiverMount`, `PortraitGiverModelSceneID`, `PortraitTurnIn`, `RewardFactionID1`, `RewardFactionValue1`, `RewardFactionOverride1`, `RewardFactionCapIn1`, `RewardFactionID2`, `RewardFactionValue2`, `RewardFactionOverride2`, `RewardFactionCapIn2`, `RewardFactionID3`, `RewardFactionValue3`, `RewardFactionOverride3`, `RewardFactionCapIn3`, `RewardFactionID4`, `RewardFactionValue4`, `RewardFactionOverride4`, `RewardFactionCapIn4`, `RewardFactionID5`, `RewardFactionValue5`, `RewardFactionOverride5`, `RewardFactionCapIn5`, `RewardFactionFlags`, `RewardCurrencyID1`, `RewardCurrencyQty1`, `RewardCurrencyID2`, `RewardCurrencyQty2`, `RewardCurrencyID3`, `RewardCurrencyQty3`, `RewardCurrencyID4`, `RewardCurrencyQty4`, `AcceptedSoundKitID`, `CompleteSoundKitID`, `AreaGroupID`, `TimeAllowed`, `AllowableRaces`, `Expansion`, `ManagedWorldStateID`, `QuestSessionBonus`, `LogTitle`, `LogDescription`, `QuestDescription`, `AreaDescription`, `PortraitGiverText`, `PortraitGiverName`, `PortraitTurnInText`, `PortraitTurnInName`, `QuestCompletionLog`, `ResetByScheduler`, `VerifiedBuild`, `RewardFavor`)
SELECT 78699, 2, `QuestPackageID`, `ContentTuningID`, `QuestSortID`, `QuestInfoID`, `SuggestedGroupNum`, 0, 6, 3, `RewardMoneyDifficulty`, `RewardMoneyMultiplier`, `RewardBonusMoney`, `RewardDisplaySpell1`, `RewardDisplaySpell2`, `RewardDisplaySpell3`, 0, `RewardHonor`, `RewardKillHonor`, `StartItem`, `RewardArtifactXPDifficulty`, `RewardArtifactXPMultiplier`, `RewardArtifactCategoryID`, `Flags`, `FlagsEx`, `FlagsEx2`, `FlagsEx3`, 277246, 1, `RewardItem2`, `RewardAmount2`, `RewardItem3`, `RewardAmount3`, `RewardItem4`, `RewardAmount4`, `ItemDrop1`, `ItemDropQuantity1`, `ItemDrop2`, `ItemDropQuantity2`, `ItemDrop3`, `ItemDropQuantity3`, `ItemDrop4`, `ItemDropQuantity4`, `RewardChoiceItemID1`, `RewardChoiceItemQuantity1`, `RewardChoiceItemDisplayID1`, `RewardChoiceItemID2`, `RewardChoiceItemQuantity2`, `RewardChoiceItemDisplayID2`, `RewardChoiceItemID3`, `RewardChoiceItemQuantity3`, `RewardChoiceItemDisplayID3`, `RewardChoiceItemID4`, `RewardChoiceItemQuantity4`, `RewardChoiceItemDisplayID4`, `RewardChoiceItemID5`, `RewardChoiceItemQuantity5`, `RewardChoiceItemDisplayID5`, `RewardChoiceItemID6`, `RewardChoiceItemQuantity6`, `RewardChoiceItemDisplayID6`, `POIContinent`, `POIx`, `POIy`, `POIPriority`, `RewardTitle`, `RewardArenaPoints`, `RewardSkillLineID`, `RewardNumSkillUps`, `PortraitGiver`, `PortraitGiverMount`, `PortraitGiverModelSceneID`, `PortraitTurnIn`, `RewardFactionID1`, `RewardFactionValue1`, `RewardFactionOverride1`, `RewardFactionCapIn1`, `RewardFactionID2`, `RewardFactionValue2`, `RewardFactionOverride2`, `RewardFactionCapIn2`, `RewardFactionID3`, `RewardFactionValue3`, `RewardFactionOverride3`, `RewardFactionCapIn3`, `RewardFactionID4`, `RewardFactionValue4`, `RewardFactionOverride4`, `RewardFactionCapIn4`, `RewardFactionID5`, `RewardFactionValue5`, `RewardFactionOverride5`, `RewardFactionCapIn5`, `RewardFactionFlags`, `RewardCurrencyID1`, `RewardCurrencyQty1`, `RewardCurrencyID2`, `RewardCurrencyQty2`, `RewardCurrencyID3`, `RewardCurrencyQty3`, `RewardCurrencyID4`, `RewardCurrencyQty4`, `AcceptedSoundKitID`, `CompleteSoundKitID`, `AreaGroupID`, `TimeAllowed`, `AllowableRaces`, `Expansion`, `ManagedWorldStateID`, `QuestSessionBonus`, 'The Eye of Bhossca', 'Return to C''s dead drop near Pyrewood Village to collect your payment.', 'Your payment for the Eye of Bhossca is waiting in C''s dead drop near Pyrewood Village.', `AreaDescription`, `PortraitGiverText`, `PortraitGiverName`, `PortraitTurnInText`, `PortraitTurnInName`, '', `ResetByScheduler`, `VerifiedBuild`, `RewardFavor`
FROM `quest_template` WHERE `ID` = 78261;
INSERT IGNORE INTO `quest_template_addon` (`ID`, `AllowableClasses`, `PrevQuestID`) VALUES (78307, 8, 78261), (78699, 8, 78676);
INSERT IGNORE INTO `quest_classic_level` (`ID`, `QuestLevel`, `MinLevel`, `MaxLevel`) VALUES (78307, 23, 1, 0), (78699, 35, 25, 0);
INSERT IGNORE INTO `quest_template_classic_level` (`ID`, `LevelType`, `QuestLevel`) VALUES (78307, 2, 23), (78699, 2, 35);
INSERT IGNORE INTO `quest_classic_money` (`ID`, `RewardMoney`, `RewardMoneyMaxLevel`) VALUES (78307, 3000, 0);
INSERT IGNORE INTO `quest_offer_reward` (`ID`, `RewardText`, `VerifiedBuild`) VALUES
(78307, '<Your payment sits in the chest.>', 0),
(78699, '<Your payment sits in the chest.>', 0);
INSERT IGNORE INTO `gameobject_questender` (`id`, `quest`, `VerifiedBuild`) VALUES (410369, 78307, 0), (410369, 78699, 0);

-- The eye is the second job: the Dead Drop offers it once the ring is collected (Wowhead: "has to be completed before").
INSERT INTO `quest_template_addon` (`ID`, `AllowableClasses`, `PrevQuestID`) VALUES (78676, 8, 78307)
ON DUPLICATE KEY UPDATE `PrevQuestID` = 78307;
-- "Find Veenix" (477011) is one of two ways past the Courtyard Door (the prisoners are the other): it is optional.
UPDATE `quest_objectives` SET `Flags` = `Flags` | 4 WHERE `ID` = 477011;
-- Veenix is the giver of Goblin Lockpicks and the talk-to target of the horn.
UPDATE `creature_template` SET `npcflag` = `npcflag` | 3 WHERE `entry` = 4086;
-- Goblin Lockpicks is offered only while the horn is in the log (QuestieDB: child quest of 78261).
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 19 AND `SourceEntry` = 78270;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`,
`ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(19, 0, 78270, 0, 0, 9, 0, 78261, 0, 0, 0, 'Goblin Lockpicks: only with The Horn of Xelthos in the log');

-- Venture Co. Work Order 210187 (Windshear Crag, Venture Co. Deforester 3991): the old row was Wowhead's raw share of all kills
-- (6/26746), a quest-only item. Quest drop and pickpocket for rogues on Goblin Lockpicks; the chances are ESTIMATED.
UPDATE `creature_loot_template` SET `Chance` = 20, `QuestRequired` = 1 WHERE `Entry` = 3991 AND `Item` = 210187;
INSERT IGNORE INTO `pickpocketing_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(3991, 0, 210187, 100, 1, 1, 0, 1, 1, 'Venture Co. Deforester: Venture Co. Work Order (Goblin Lockpicks)');

-- The twins Gefell 211764 and Gemela 211765 (rare elite 21-22, Wowhead), shown only to a lone player (classic_npc_xelthos_twin).
UPDATE `creature_template` SET `ScriptName` = 'classic_npc_xelthos_twin' WHERE `entry` IN (211764, 211765);
UPDATE `creature_template_difficulty` SET `PickPocketLootID` = `Entry` WHERE `Entry` IN (211764, 211765) AND `PickPocketLootID` = 0;
INSERT IGNORE INTO `creature_classic_level` (`entry`, `level_min`, `level_max`) VALUES (211764, 21, 22), (211765, 21, 22);
-- ESTIMATED spots. Gemela: "in the dining hall where Baron Silverlaine is, just inside from the kitchen" (beside the Haunted
-- Servitor at -229.4 2272.6). Gefell: "up the stairs past Silverlaine, take the right instead of the normal route left, the
-- first room around the corner" (the Darksouls' floor, by -266.8 2314.6 95.9).
DELETE FROM `creature` WHERE `guid` IN (21176400, 21176500);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`,
`modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`,
`curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`) VALUES
(21176400, 211764, 33, 209, 0, '1', 0, 0, 0, -1, 0, 0, -262.5, 2314.0, 95.9, 0.49, 7200, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 0),
(21176500, 211765, 33, 209, 0, '1', 0, 0, 0, -1, 0, 0, -233.5, 2268.8, 75.1, 0.98, 7200, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 0);

-- Pickpocketing: the half-keys from the twins, the Scryer's Key from a Scarlet Scryer 4293 (only for those on the job).
UPDATE `creature_template_difficulty` SET `PickPocketLootID` = 4293 WHERE `Entry` = 4293 AND `PickPocketLootID` = 0;
DELETE FROM `pickpocketing_loot_template` WHERE (`Entry` = 211764 AND `Item` = 210212) OR (`Entry` = 211765 AND `Item` = 210213) OR (`Entry` = 4293 AND `Item` = 210963);
INSERT INTO `pickpocketing_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(211764, 0, 210212, 100, 0, 1, 0, 1, 1, 'Gefell: Brother''s Half-Key'),
(211765, 0, 210213, 100, 0, 1, 0, 1, 1, 'Gemela: Sister''s Half-Key'),
(4293, 0, 210963, 100, 0, 1, 0, 1, 1, 'Scarlet Scryer: Scryer''s Key');
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 8 AND ((`SourceGroup` = 211764 AND `SourceEntry` = 210212) OR (`SourceGroup` = 211765 AND `SourceEntry` = 210213) OR (`SourceGroup` = 4293 AND `SourceEntry` = 210963));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`,
`ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(8, 211764, 210212, 0, 0, 9, 0, 78261, 0, 0, 0, 'Brother''s Half-Key: The Horn of Xelthos in the log'),
(8, 211764, 210212, 0, 0, 2, 0, 210209, 1, 0, 1, 'Brother''s Half-Key: not when the Twin Key is made'),
(8, 211764, 210212, 0, 0, 2, 0, 210183, 1, 0, 1, 'Brother''s Half-Key: not when the horn is found'),
(8, 211765, 210213, 0, 0, 9, 0, 78261, 0, 0, 0, 'Sister''s Half-Key: The Horn of Xelthos in the log'),
(8, 211765, 210213, 0, 0, 2, 0, 210209, 1, 0, 1, 'Sister''s Half-Key: not when the Twin Key is made'),
(8, 211765, 210213, 0, 0, 2, 0, 210183, 1, 0, 1, 'Sister''s Half-Key: not when the horn is found'),
(8, 4293, 210963, 0, 0, 9, 0, 78676, 0, 0, 0, 'Scryer''s Key: The Eye of Bhossca in the log'),
(8, 4293, 210963, 0, 0, 2, 0, 210967, 1, 0, 1, 'Scryer''s Key: not once the letterbox is opened'),
(8, 4293, 210963, 0, 0, 2, 0, 210953, 1, 0, 1, 'Scryer''s Key: not when the eye is found');

-- The chests (models from Wowhead's records: 410528 display 10, 412147 41, 412759 6396, 412198 1387, 412261 6502). Data1 = loot,
-- Data8 = the quest that makes them usable. Keyed ones: classic_go_dead_drop_keyed_chest (the key is used up). No lock: the live
-- Lock records are not known (Wowhead: "Requires skill 1").
DELETE FROM `gameobject_template` WHERE `entry` IN (410528, 412147, 412759, 412198, 412261) AND `VerifiedBuild` = -1121;
INSERT IGNORE INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`,
`Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`,
`Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`,
`Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`) VALUES
(410528, 3, 10, 'Ornamented Chest', '', '', '', 1, 0, 410528, 0, 0, 0, 0, 0, 0, 78261, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 'classic_go_dead_drop_keyed_chest', NULL, -1121),
(412147, 3, 41, 'Supply Locker', '', '', '', 1, 0, 412147, 0, 0, 0, 0, 0, 0, 78676, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, -1121),
(412759, 3, 6396, 'Personal Letterbox', '', '', '', 1, 0, 412759, 0, 0, 0, 0, 0, 0, 78676, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 'classic_go_dead_drop_keyed_chest', NULL, -1121),
(412198, 3, 1387, 'Stone Coffer', '', '', '', 1, 0, 412198, 0, 0, 0, 0, 0, 0, 78676, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, -1121),
(412261, 3, 6502, 'Padlocked Reliquary', '', '', '', 1, 0, 412261, 0, 0, 0, 0, 0, 0, 78676, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 'classic_go_dead_drop_keyed_chest', NULL, -1121);
-- (a template that was already there keeps its values; its script is set here)
UPDATE `gameobject_template` SET `ScriptName` = 'classic_go_dead_drop_keyed_chest' WHERE `entry` IN (410528, 412759, 412261);

DELETE FROM `gameobject_loot_template` WHERE `Entry` IN (410528, 412147, 412759, 412198, 412261);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(410528, 0, 210183, 100, 1, 1, 0, 1, 1, 'Ornamented Chest: Horn of Xelthos'),
(412147, 0, 210955, 100, 0, 1, 0, 1, 1, 'Supply Locker: Scarlet Initiate''s Uniform'),
(412759, 0, 210967, 100, 0, 1, 0, 1, 1, 'Personal Letterbox: Confidential Message'),
(412198, 0, 210968, 100, 0, 1, 0, 1, 1, 'Stone Coffer: Reliquary Key'),
(412261, 0, 210953, 100, 1, 1, 0, 1, 1, 'Padlocked Reliquary: Eye of Bhossca');
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 4 AND `SourceGroup` IN (412147, 412759, 412198);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`,
`ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(4, 412147, 210955, 0, 0, 9, 0, 78676, 0, 0, 0, 'Scarlet Initiate''s Uniform: The Eye of Bhossca in the log'),
(4, 412759, 210967, 0, 0, 9, 0, 78676, 0, 0, 0, 'Confidential Message: The Eye of Bhossca in the log'),
(4, 412198, 210968, 0, 0, 9, 0, 78676, 0, 0, 0, 'Reliquary Key: The Eye of Bhossca in the log');

-- Spawns (the Stone Coffer is summoned by the benches). ESTIMATED spots, heights from the rooms' spawns:
--   Ornamented Chest: SFK stables, "the far back right corner behind the hay" (the Fel Steeds stand at -234.1 2236.3 79.9).
--   Supply Locker: Tirisfal 81.1,32.1 (Wowhead), "an empty stable left of the monastery entrance"; height of the Scarlet patrol there.
--   Personal Letterbox: Library, "past the Gallery of Treasures, in the hallway, built into the wall to your left as you enter".
--   Padlocked Reliquary: Library, "the small room on the left with three monks, between two podiums" (monks at 243/263/265 -304..-312).
DELETE FROM `gameobject` WHERE `guid` BETWEEN 47501150 AND 47501153;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`,
`position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`,
`ScriptName`, `StringId`, `VerifiedBuild`) VALUES
(47501150, 410528, 33, 209, 0, '1', 0, 0, 0, -1, -238.0, 2232.5, 79.9, 0.30, 0, 0, 0.149438, 0.988771, 7200, 255, 1, '', NULL, 0),
(47501151, 412147, 0, 85, 0, '0', 0, 0, 0, -1, 2870.5, -631.4, 137.9, 1.57, 0, 0, 0.706825, 0.707388, 30, 255, 1, '', NULL, 0),
(47501152, 412759, 189, 796, 0, '1', 0, 0, 0, -1, 220.0, -339.0, 18.6, 1.57, 0, 0, 0.706825, 0.707388, 7200, 255, 1, '', NULL, 0),
(47501153, 412261, 189, 796, 0, '1', 0, 0, 0, -1, 252.0, -301.0, 20.2, 4.71, 0, 0, -0.708340, 0.705871, 7200, 255, 1, '', NULL, 0);

-- The two Graveyard benches "between the pair of statues on either side" (ESTIMATED: the two sides of the Forlorn Cloister),
-- 8 yd server-side area triggers (classic_at_bhossca_bench). The Stone Coffer spot is in the script (1852.0 1345.5 18.5,
-- the northern mausoleum, behind the guard spot at 1849 1344).
DELETE FROM `areatrigger_template` WHERE `Id` = 78676 AND `IsCustom` = 1;
INSERT INTO `areatrigger_template` (`Id`, `IsCustom`, `Flags`, `ActionSetId`, `ActionSetFlags`, `VerifiedBuild`) VALUES (78676, 1, 1, 0, 0, 0);
DELETE FROM `areatrigger_create_properties` WHERE `Id` = 78676 AND `IsCustom` = 1;
INSERT INTO `areatrigger_create_properties` (`Id`, `IsCustom`, `AreaTriggerId`, `IsAreatriggerCustom`, `Flags`, `MoveCurveId`,
`ScaleCurveId`, `MorphCurveId`, `FacingCurveId`, `AnimId`, `AnimKitId`, `DecalPropertiesId`, `SpellForVisuals`, `PositionalSoundKitId`,
`TimeToTargetScale`, `Speed`, `SpeedIsTime`, `Shape`, `ShapeData0`, `ShapeData1`, `ShapeData2`, `ShapeData3`, `ShapeData4`,
`ShapeData5`, `ShapeData6`, `ShapeData7`, `Roll`, `Pitch`, `Yaw`, `TargetRoll`, `TargetPitch`, `TargetYaw`, `ScriptName`,
`VerifiedBuild`) VALUES
(78676, 1, 78676, 1, 0, 0, 0, 0, 0, -1, -1, 0, NULL, 0, 0, 0, 0, 0, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'classic_at_bhossca_bench', 0);
DELETE FROM `areatrigger` WHERE `SpawnId` IN (78676001, 78676002);
INSERT INTO `areatrigger` (`SpawnId`, `AreaTriggerCreatePropertiesId`, `IsCustom`, `MapId`, `SpawnDifficulties`, `PosX`, `PosY`, `PosZ`, `Orientation`,
`PhaseUseFlags`, `PhaseId`, `PhaseGroup`, `ScriptName`, `Comment`, `VerifiedBuild`) VALUES
(78676001, 78676, 1, 189, '1', 1757.0, 1280.0, 18.2, 0, 0, 0, 0, 'classic_at_bhossca_bench', 'Scarlet Monastery Graveyard - west bench (The Eye of Bhossca)', 0),
(78676002, 78676, 1, 189, '1', 1833.0, 1280.0, 18.2, 0, 0, 0, 0, 'classic_at_bhossca_bench', 'Scarlet Monastery Graveyard - east bench (The Eye of Bhossca)', 0);

-- Spells of the quest items.
DELETE FROM `spell_script_names` WHERE `spell_id` IN (425067, 425094);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(425067, 'classic_spell_breach_gate'),
(425094, 'classic_spell_combine_half_keys');
