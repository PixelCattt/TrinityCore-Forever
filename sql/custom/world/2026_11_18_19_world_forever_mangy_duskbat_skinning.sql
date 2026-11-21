-- Skinning: the Mangy Duskbat (1513, Tirisfal Glades) had no skinning loot, so it could not be skinned. Live skins it for
-- Ruined Leather Scraps (2934) every time (EG Link loot data, Efficient Games, CC BY 4.0: 4 skinning windows, scraps in all 4),
-- like the Duskbat (1512) next to it. Goes with 2026_11_18_00_world_forever_starting_beasts_skinning.sql (PR #349), which
-- covers the other starting beasts. Safe to run again.
UPDATE `creature_template_difficulty` SET `SkinLootID` = `Entry` WHERE `Entry` = 1513 AND `DifficultyID` = 0;
DELETE FROM `skinning_loot_template` WHERE `Entry` = 1513;
INSERT INTO `skinning_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1513, 0, 2934, 100, 0, 1, 0, 1, 1, 'Mangy Duskbat - Ruined Leather Scraps');
