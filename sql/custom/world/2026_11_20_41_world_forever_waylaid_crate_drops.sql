-- Classic 1.60 (Forever): Waylaid Crates can be found again (GitHub #351, wowiczek's report and his defaults, used as given).
-- 1) The unlabeled Waylaid Crate 248549 was in no loot table, so the Merchant's Favor crate loop never started. On live any creature
--    from about level 10 can drop it, rares and elites more often. Until live rates are known: every creature with loot whose
--    classic level is 10 or more, not a critter / totem / non-combat pet / gas cloud / wild pet (types 8, 11, 12, 13, 14):
--    2 % normal, 8 % elite or rare (Classification 1-4). One row per loot id (creatures can share one), the highest rate wins.
-- 2) Read Label gave all 30 labels, but only the Apprentice and Journeyman Sealed crates have a hand-in quest
--    (2026_11_09_30), so the 16 Expert / Artisan labels were a dead end: Read Label now gives the 14 Apprentice / Journeyman ones.
-- 3) A stocked crate came out blue 5 % of the time, and blue crates have no hand-in quest either: white 75 %, green 25 %.
-- Safe to run again.

-- 1) drops
DELETE FROM `creature_loot_template` WHERE `Item` = 248549 AND `ItemType` = 0;
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT d.`LootID`, 0, 248549, MAX(CASE WHEN t.`Classification` BETWEEN 1 AND 4 THEN 8 ELSE 2 END), 0, 1, 0, 1, 1, 'Waylaid Crate (GitHub #351 default until live rates)'
FROM `creature_template` t
JOIN `creature_template_difficulty` d ON d.`Entry` = t.`entry` AND d.`DifficultyID` = 0
JOIN `creature_classic_level` l ON l.`entry` = t.`entry`
WHERE d.`LootID` > 0
  AND l.`level_min` >= 10
  AND t.`type` NOT IN (8, 11, 12, 13, 14)
  AND EXISTS (SELECT 1 FROM `creature` c WHERE c.`id` = t.`entry`)
  AND EXISTS (SELECT 1 FROM `creature_loot_template` x WHERE x.`Entry` = d.`LootID`)
GROUP BY d.`LootID`;

-- 2) Read Label: Apprentice / Journeyman labels only
DELETE FROM `spell_loot_template` WHERE `Entry` = 1247168 AND `Item` IN
  (248690, 248691, 248692, 248693, 248694, 248695, 248696, 248697, 248698, 248699, 248708, 248709, 248710, 248711, 248712, 248713);

-- 3) Stock Crate: no blue Sealed crates, white 75 %
DELETE FROM `spell_loot_template` WHERE `Entry` BETWEEN 1247426 AND 1247457 AND `Item` BETWEEN 248775 AND 248779;
UPDATE `spell_loot_template` SET `Chance` = 75 WHERE `Entry` BETWEEN 1247426 AND 1247457 AND `Item` BETWEEN 248765 AND 248769;
