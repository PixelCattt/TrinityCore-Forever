-- Quest drops: six creatures that drop a quest item on live never dropped it here. Evidence: live loot windows, builds
-- 70205-70959 (EG Link loot data, Efficient Games, CC BY 4.0), checked against the dev world DB on 2026-11-18.
-- Two of them had no loot table at all (LootID 0), so they dropped nothing; they get their own, the way
-- 2026_11_11_74 did for their kin. The others had a loot table without the item. Every one of these creatures is
-- spawned, and each chance follows its kin that already drop the item. No loot row of another creature is changed.
-- Safe to run again.
UPDATE `creature_template_difficulty` SET `LootID` = `Entry` WHERE `DifficultyID` = 0 AND `LootID` = 0 AND `Entry` IN (255774,259981);

-- 265358 Stolen Ore from 255774 Redridge Scout, quest 94535: live 6 of 9 kills on the quest. Kin 255769/255770/255772.
DELETE FROM `creature_loot_template` WHERE `Entry`=(SELECT `LootID` FROM `creature_template_difficulty` WHERE `Entry`=255774 AND `DifficultyID`=0) AND `ItemType`=0 AND `Item`=265358;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) SELECT `LootID`,0,265358,60,1,1,0,1,1,'Redridge Scout - quest 94535 (live 6 of 9 kills)' FROM `creature_template_difficulty` WHERE `Entry`=255774 AND `DifficultyID`=0 AND `LootID`>0;
-- 270333 Voodoo-Infused Artifact from 259981 Saltseer Cultist (The Drowned City): live 1 of 2 kills. Kin 259979/259987/260353 at 35.
DELETE FROM `creature_loot_template` WHERE `Entry`=(SELECT `LootID` FROM `creature_template_difficulty` WHERE `Entry`=259981 AND `DifficultyID`=0) AND `ItemType`=0 AND `Item`=270333;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) SELECT `LootID`,0,270333,35,1,1,0,1,1,'Saltseer Cultist: Voodoo-Infused Artifact (live 1 of 2 kills, chance as its kin)' FROM `creature_template_difficulty` WHERE `Entry`=259981 AND `DifficultyID`=0 AND `LootID`>0;
-- 247834 Nibbled-On Book (starts 91741) from 257 Kobold Worker, Northshire: live 3 of 4 kills before the quest. Same 25 % as
-- Kobold Vermin 6 (2026_10_28_01); a starter item, so not quest-required.
DELETE FROM `creature_loot_template` WHERE `Entry`=(SELECT `LootID` FROM `creature_template_difficulty` WHERE `Entry`=257 AND `DifficultyID`=0) AND `ItemType`=0 AND `Item`=247834;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) SELECT `LootID`,0,247834,25,0,1,0,1,1,'Kobold Worker: Nibbled-On Book, starts 91741' FROM `creature_template_difficulty` WHERE `Entry`=257 AND `DifficultyID`=0 AND `LootID`>0;
-- 251961 from 246020 Shade of the Archmage, quests 92458/92459/96984/97287: live 2 of 2 kills. Same 100 % as 250657.
DELETE FROM `creature_loot_template` WHERE `Entry`=(SELECT `LootID` FROM `creature_template_difficulty` WHERE `Entry`=246020 AND `DifficultyID`=0) AND `ItemType`=0 AND `Item`=251961;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) SELECT `LootID`,0,251961,100,1,1,0,1,1,'Shade of the Archmage - quests 92458 92459 96984 97287 (live 2 of 2 kills)' FROM `creature_template_difficulty` WHERE `Entry`=246020 AND `DifficultyID`=0 AND `LootID`>0;
-- 268344 from 255899 Murloc Tideskimmer, quest 95121: live 5 of 12 kills. Kin 255898 (33) and 256801 (45), counted the same way.
DELETE FROM `creature_loot_template` WHERE `Entry`=(SELECT `LootID` FROM `creature_template_difficulty` WHERE `Entry`=255899 AND `DifficultyID`=0) AND `ItemType`=0 AND `Item`=268344;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) SELECT `LootID`,0,268344,42,1,1,0,1,1,'Murloc Tideskimmer - quest 95121 (live 5 of 12 kills)' FROM `creature_template_difficulty` WHERE `Entry`=255899 AND `DifficultyID`=0 AND `LootID`>0;
-- 286259 from 260432 Shadowvale Mystic (the second Mystic entry), quest 99152: live 4 of 5 kills. Kin 260428/260430 at 40.
DELETE FROM `creature_loot_template` WHERE `Entry`=(SELECT `LootID` FROM `creature_template_difficulty` WHERE `Entry`=260432 AND `DifficultyID`=0) AND `ItemType`=0 AND `Item`=286259;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) SELECT `LootID`,0,286259,40,1,1,0,1,1,'Shadowvale Mystic - quest 99152 (live 4 of 5 kills, chance as its kin)' FROM `creature_template_difficulty` WHERE `Entry`=260432 AND `DifficultyID`=0 AND `LootID`>0;
