-- Call of Fire 94466 (dwarf shaman, Braldir Ashmantle 257808 in Loch Modan): "Bring 1 Fire Tar and 1 Reagent Pouch".
-- Discord 19 Nov (Blubu): the dwarf shaman Call of Fire does not work.
--
-- Cause: Fire Tar (5026) dropped only from the Razormane in the Barrens (3267, 3268, 3269, 3271, 3458), the Horde version
-- of the quest. On live it also drops from the Tunnel Rat Geomancer (1174, Loch Modan kobolds, level 12-13), next to the
-- Reagent Pouch from the Stonesplinter Seer (1166) that we already have, so a dwarf could never finish this step.
-- Source: Questie Forever data (Questie team, QuestieDB, GPLv3): item 5026 npcDrops 1174 and 3458.
-- Rate: not in the data; 25% quest drop, the same as the Razormane drop of the same item.
-- Safe to run again.
UPDATE `creature_template_difficulty` SET `LootID` = `Entry` WHERE `Entry` = 1174 AND `DifficultyID` = 0 AND `LootID` = 0;
DELETE FROM `creature_loot_template` WHERE `Entry` = 1174 AND `ItemType` = 0 AND `Item` = 5026;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(1174,0,5026,25,1,1,0,1,1,'Forever: Fire Tar for the dwarf shaman Call of Fire 94466 (Questie Forever)');
