-- Skinning: more starting-zone beasts that had no skinning loot, so they could not be skinned (the same gap as
-- 2026_11_04_92_world_classic_starting_beasts_skinning.sql). Unlike that batch these were not skinnable in vanilla 1.12, but
-- they are in WoW Forever: Wowhead Forever lists a Skinning tab with Ruined Leather Scraps (2934) for every one of them
-- (skins recorded / scraps): Timber Wolf 11285/11284, Young Wolf 32634/32632, Ragged Young Wolf 28408/28408, Ragged Timber
-- Wolf 1762/1762, Small Crag Boar 23973/23973, Mountain Cougar 15486/15486, Battleboar 13361/13361, Young Nightsaber
-- 11899/11899, Mangy Nightsaber 9457/9457, Ragged Scavenger 2297/2297. Only the original vanilla entries. Safe to run again.
UPDATE `creature_template_difficulty` SET `SkinLootID` = `Entry` WHERE `Entry` IN (69, 299, 704, 705, 708, 1509, 2031, 2032, 2961, 2966) AND `DifficultyID` = 0;
DELETE FROM `skinning_loot_template` WHERE `Entry` IN (69, 299, 704, 705, 708, 1509, 2031, 2032, 2961, 2966);
INSERT INTO `skinning_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(69, 0, 2934, 100, 0, 1, 0, 1, 1, 'Timber Wolf - Ruined Leather Scraps'),
(299, 0, 2934, 100, 0, 1, 0, 1, 1, 'Young Wolf - Ruined Leather Scraps'),
(704, 0, 2934, 100, 0, 1, 0, 1, 1, 'Ragged Timber Wolf - Ruined Leather Scraps'),
(705, 0, 2934, 100, 0, 1, 0, 1, 1, 'Ragged Young Wolf - Ruined Leather Scraps'),
(708, 0, 2934, 100, 0, 1, 0, 1, 1, 'Small Crag Boar - Ruined Leather Scraps'),
(1509, 0, 2934, 100, 0, 1, 0, 1, 1, 'Ragged Scavenger - Ruined Leather Scraps'),
(2031, 0, 2934, 100, 0, 1, 0, 1, 1, 'Young Nightsaber - Ruined Leather Scraps'),
(2032, 0, 2934, 100, 0, 1, 0, 1, 1, 'Mangy Nightsaber - Ruined Leather Scraps'),
(2961, 0, 2934, 100, 0, 1, 0, 1, 1, 'Mountain Cougar - Ruined Leather Scraps'),
(2966, 0, 2934, 100, 0, 1, 0, 1, 1, 'Battleboar - Ruined Leather Scraps');
