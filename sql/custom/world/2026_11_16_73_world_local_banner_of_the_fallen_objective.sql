-- Banner of the Fallen (86585): SIN's quest rows (Quest and World Fixes for 0.1.36, his 2026_11_14_01, Karrz 2026-11-16: put
-- them in as he wrote them). His statements, unchanged. On our data the quest, its addon, level, giver and ender already exist
-- (2026_11_13_41), so those inserts change nothing; the one new row is his kill objective 99086585 (Headsplitter 269185,
-- StorageIndex 0), next to our live objectives 475904 (the banner, StorageIndex 0) and 475960 (Headsplitter, StorageIndex 1).
-- Ylva is a questgiver in the shipped creature data. Both reward items, the
-- banner, the target and the recipient exist, but the quest itself is absent.
INSERT INTO quest_template
    (ID,QuestSortID,StartItem,LogTitle,LogDescription,QuestDescription,
     RewardXPDifficulty,RewardChoiceItemID1,RewardChoiceItemQuantity1,
     RewardChoiceItemID2,RewardChoiceItemQuantity2,RewardFactionID1,
     RewardFactionOverride1,RewardFactionCapIn1,RewardFactionFlags,AllowableRaces)
VALUES (86585,38,253247,'Banner of the Fallen',
    'Raise the banner, defeat Headsplitter, and return to Captain Rugelfuss.',
    'The fallen mountaineer still bears an Ironforge banner. Raise it near her to challenge the trogg responsible.',
    5,281253,1,281254,1,47,100,7,1,4294967373)
ON DUPLICATE KEY UPDATE ID=VALUES(ID);
INSERT INTO quest_template_addon (ID,ProvidedItemCount) VALUES (86585,1)
ON DUPLICATE KEY UPDATE ID=VALUES(ID);
INSERT INTO quest_template_classic_level (ID,LevelType,QuestLevel) VALUES (86585,2,17)
ON DUPLICATE KEY UPDATE ID=VALUES(ID);
INSERT INTO quest_objectives (ID,QuestID,Type,StorageIndex,ObjectID,Amount)
VALUES (99086585,86585,0,0,269185,1) ON DUPLICATE KEY UPDATE ID=VALUES(ID);
INSERT INTO creature_queststarter (id,quest) VALUES (269153,86585)
ON DUPLICATE KEY UPDATE quest=VALUES(quest);
INSERT INTO creature_questender (id,quest) VALUES (1092,86585)
ON DUPLICATE KEY UPDATE quest=VALUES(quest);
