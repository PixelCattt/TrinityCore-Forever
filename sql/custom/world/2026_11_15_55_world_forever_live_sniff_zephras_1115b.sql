-- WoW Forever live realm: dump_1.60.1.70938_2026-11-15_09-40-16.pkt (Zephras Isle only). Only what our data lacks. Comes after
-- 2026_11_15_54. Chances are INFERRED from small samples: 3 for an item seen once. Safe to run more than once.
-- Quests, quest givers, quest texts and the two vendors seen all match ours already.

-- Drops live gave that our mobs never drop (corpse windows only; skinning windows are not counted).
DELETE FROM `creature_loot_template` WHERE `Comment` LIKE 'Forever live drop 2026-11-15b (%';
INSERT IGNORE INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(250928, 0, 117, 3, 0, 1, 0, 1, 1, 'Forever live drop 2026-11-15b (Highlands Ursera, 1 of 1 kills)'),
(250928, 0, 4775, 3, 0, 1, 0, 1, 1, 'Forever live drop 2026-11-15b (Highlands Ursera, 1 of 1 kills)'),
(250928, 0, 6889, 3, 0, 1, 0, 1, 1, 'Forever live drop 2026-11-15b (Highlands Ursera, 1 of 1 kills)'),
(251662, 0, 2773, 3, 0, 1, 0, 1, 1, 'Forever live drop 2026-11-15b (Living Lightning, 1 of 6 kills)'),
(251662, 0, 255663, 3, 0, 1, 0, 1, 1, 'Forever live drop 2026-11-15b (Living Lightning, 1 of 6 kills)'),
(251966, 0, 1431, 3, 0, 1, 0, 1, 1, 'Forever live drop 2026-11-15b (Commander Cyclas, 1 of 1 kills)'),
(252068, 0, 1181, 3, 0, 1, 0, 1, 1, 'Forever live drop 2026-11-15b (Al''Aketh Stormcaller, 1 of 16 kills)'),
(252068, 0, 1415, 3, 0, 1, 0, 1, 1, 'Forever live drop 2026-11-15b (Al''Aketh Stormcaller, 1 of 16 kills)'),
(252068, 0, 2646, 3, 0, 1, 0, 1, 1, 'Forever live drop 2026-11-15b (Al''Aketh Stormcaller, 1 of 16 kills)');
