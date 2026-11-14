-- WoW Forever live realm: dump_1.60.1.70938_2026-11-13_22-59-59.pkt (Russian client; Darkshore, Auberdine, Rut'theran Village,
-- Darnassus). Only what our data lacks: its 28 quests, quest givers, drops and other vendors match ours. Comes after
-- 2026_11_13_62. Safe to run more than once.

-- 1. Talaelar (4221), the Darnassus fish vendor, sells six raw fish in stacks of 5 that restock, like Laird in Auberdine
--    (2026_11_13_61). The restock time (15 min) is INFERRED. Rows we have and live did not show stay.
DELETE FROM `npc_vendor` WHERE (`entry`,`item`) IN ((4221,6303),(4221,6289),(4221,6308),(4221,6362),(4221,4603),(4221,8959));
INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `type`, `BonusListIDs`, `PlayerConditionID`, `IgnoreFiltering`, `VerifiedBuild`) VALUES
(4221, 7, 6303, 5, 900, 0, 1, NULL, 0, 0, 70938),
(4221, 8, 6289, 5, 900, 0, 1, NULL, 0, 0, 70938),
(4221, 9, 6308, 5, 900, 0, 1, NULL, 0, 0, 70938),
(4221, 10, 6362, 5, 900, 0, 1, NULL, 0, 0, 70938),
(4221, 11, 4603, 5, 900, 0, 1, NULL, 0, 0, 70938),
(4221, 12, 8959, 5, 900, 0, 1, NULL, 0, 0, 70938);

-- 2. Three more capture-player names typed into our Russian quest texts in place of $n: "Wrestlecake" (103 hand-in texts),
--    "Rainon" (22) and "Makky" (9), plus 42 progress texts. Live sends $n here (quests 1138, 2138, 4763 in this capture). None of
--    them is an NPC name. Quest 1002 also gets live's female word form.
UPDATE `quest_offer_reward_locale` SET `RewardText` = REPLACE(REPLACE(REPLACE(`RewardText`, 'Wrestlecake', '$n'), 'Rainon', '$n'), 'Makky', '$n')
  WHERE `locale` = 'ruRU' AND REGEXP_LIKE(`RewardText`, 'Wrestlecake|Rainon|Makky', 'c');
UPDATE `quest_request_items_locale` SET `CompletionText` = REPLACE(REPLACE(REPLACE(`CompletionText`, 'Wrestlecake', '$n'), 'Rainon', '$n'), 'Makky', '$n')
  WHERE `locale` = 'ruRU' AND REGEXP_LIKE(`CompletionText`, 'Wrestlecake|Rainon|Makky', 'c');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(1002, 'ruRU', 'Неожидано Жужжалка начинает работать, и вы отчетливо слышите, как клыки перемалываются внутри машины в муку.$B$B"Так шшшо, ты это $gшшшделал:шшшделала;! Отлишшшные новосшшшти... И шшшо жшшше... ты не уходишшшь? А! Можшшшет, хочешшшь ешшше поработать?"', 70938)
ON DUPLICATE KEY UPDATE `RewardText` = VALUES(`RewardText`), `VerifiedBuild` = VALUES(`VerifiedBuild`);

-- 3. From dump_1.60.1.70938_2026-11-13_23-55-13.pkt (Zephras Isle): Skypriest Aanders (256966) dropped two items ours lacks
--    (1 kill, chance INFERRED).
DELETE FROM `creature_loot_template` WHERE `Comment` LIKE 'Forever live drop 2026-11-13c (%';
INSERT IGNORE INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(256966, 0, 1419, 3, 0, 1, 0, 1, 1, 'Forever live drop 2026-11-13c (Skypriest Aanders, 1 of 1 kills)'),
(256966, 0, 252032, 3, 0, 1, 0, 1, 1, 'Forever live drop 2026-11-13c (Skypriest Aanders, 1 of 1 kills)');
