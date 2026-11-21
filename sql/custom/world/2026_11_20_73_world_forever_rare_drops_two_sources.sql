-- WoW Forever: rarer live drops missing here, each seen by two independent witnesses: players' loot windows (EG Link) and
-- NorgannonDB's drop list for that creature. Only WoW Forever's own items and recipes (plans, patterns, recipes); grey and
-- common world drops are left out, and so are the world-drop families other work covers (Waylaid Crates, mage scrolls, writs).
-- Data from Efficient Games (https://efficient.games), licensed under CC BY 4.0 (https://creativecommons.org/licenses/by/4.0/),
-- github.com/JIVESCORP/eg-link-output-wowf loot datasets, builds 70205-70959; and NorgannonDB (github.com/zmarotrix/NorgannonDB,
-- GPL-3.0). Changed: picked and converted.
-- ESTIMATED: chance = drops / loot windows, kept between 1% and 20% because the samples are small. Safe to run again.

UPDATE `creature_template_difficulty` SET `LootID`=`Entry` WHERE `DifficultyID`=0 AND `LootID`=0 AND `Entry` IN (259981);
-- Witherbark Shadow Hunter: Witherbark Mallet
DELETE FROM `creature_loot_template` WHERE `Entry`=2557 AND `ItemType`=0 AND `Item`=216483;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES (2557,0,216483,14.29,0,1,0,1,1,'EG Link + NorgannonDB 1/7');
-- Boulderfist Ogre: Illegible Recipe
DELETE FROM `creature_loot_template` WHERE `Entry`=2562 AND `ItemType`=0 AND `Item`=213422;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES (2562,0,213422,4.35,1,1,0,1,1,'EG Link + NorgannonDB 1/23');
-- Windfury Wind Witch: Recipe: Minor Frenzy Potion
DELETE FROM `creature_loot_template` WHERE `Entry`=2963 AND `ItemType`=0 AND `Item`=250982;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES (2963,0,250982,10.0,0,1,0,1,1,'EG Link + NorgannonDB 1/10');
-- High Inquisitor Whitemane: Pattern: Fiery Cord
DELETE FROM `creature_loot_template` WHERE `Entry`=3977 AND `ItemType`=0 AND `Item`=254042;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES (3977,0,254042,20.0,0,1,0,1,1,'EG Link + NorgannonDB 0/4');
-- Scarlet Myrmidon: Tactician's Staff
DELETE FROM `creature_loot_template` WHERE `Entry`=4295 AND `ItemType`=0 AND `Item`=215375;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES (4295,0,215375,3.57,0,1,0,1,1,'EG Link + NorgannonDB 1/28');
-- Scarlet Wizard: Tactician's Staff
DELETE FROM `creature_loot_template` WHERE `Entry`=4300 AND `ItemType`=0 AND `Item`=215375;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES (4300,0,215375,5.26,0,1,0,1,1,'EG Link + NorgannonDB 1/19');
-- Scarlet Centurion: Crusader's Mace
DELETE FROM `creature_loot_template` WHERE `Entry`=4301 AND `ItemType`=0 AND `Item`=215376;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES (4301,0,215376,3.57,0,1,0,1,1,'EG Link + NorgannonDB 1/28');
-- Scarlet Abbot: Tactician's Staff
DELETE FROM `creature_loot_template` WHERE `Entry`=4303 AND `ItemType`=0 AND `Item`=215375;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES (4303,0,215375,10.0,0,1,0,1,1,'EG Link + NorgannonDB 1/10');
-- Overlord Ramtusk: Plans: Veteran's Chain Helm
DELETE FROM `creature_loot_template` WHERE `Entry`=4420 AND `ItemType`=0 AND `Item`=251350;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES (4420,0,251350,20.0,0,1,0,1,1,'EG Link + NorgannonDB 1/3');
-- Scarlet Monk: Tactician's Staff
DELETE FROM `creature_loot_template` WHERE `Entry`=4540 AND `ItemType`=0 AND `Item`=215375;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES (4540,0,215375,3.33,0,1,0,1,1,'EG Link + NorgannonDB 1/30');
-- Ironspine: Pattern: Filigreed Pristine Circlet
DELETE FROM `creature_loot_template` WHERE `Entry`=6489 AND `ItemType`=0 AND `Item`=253976;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES (6489,0,253976,20.0,0,1,0,1,1,'EG Link + NorgannonDB 1/1');
-- Plaguemaw the Rotting: Pattern: Frothing Cord
DELETE FROM `creature_loot_template` WHERE `Entry`=7356 AND `ItemType`=0 AND `Item`=254040;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES (7356,0,254040,20.0,0,1,0,1,1,'EG Link + NorgannonDB 0/2');
-- Grubbis: Pattern: Filigreed Shadow Circlet
DELETE FROM `creature_loot_template` WHERE `Entry`=7361 AND `ItemType`=0 AND `Item`=253982;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES (7361,0,253982,20.0,0,1,0,1,1,'EG Link + NorgannonDB 1/2');
-- Kolkar Ambusher: Carved Centaur Totem
DELETE FROM `creature_loot_template` WHERE `Entry`=12977 AND `ItemType`=0 AND `Item`=254432;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES (12977,0,254432,20.0,1,1,0,1,1,'EG Link + NorgannonDB 1/4');
-- Shrieking Banshee: Rotmender's Gloves
DELETE FROM `creature_loot_template` WHERE `Entry`=250620 AND `ItemType`=0 AND `Item`=286979;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES (250620,0,286979,20.0,0,1,0,1,1,'EG Link + NorgannonDB 1/5');
-- Ragged Ghoul: Rotmender's Sash
DELETE FROM `creature_loot_template` WHERE `Entry`=250622 AND `ItemType`=0 AND `Item`=286980;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES (250622,0,286980,4.0,0,1,0,1,1,'EG Link + NorgannonDB 1/25');
-- Mangled Cadaver: Rotmender's Gloves
DELETE FROM `creature_loot_template` WHERE `Entry`=250623 AND `ItemType`=0 AND `Item`=286979;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES (250623,0,286979,20.0,0,1,0,1,1,'EG Link + NorgannonDB 1/2');
-- Skeletal Soldier: Rotmender's Garb
DELETE FROM `creature_loot_template` WHERE `Entry`=250626 AND `ItemType`=0 AND `Item`=286978;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES (250626,0,286978,2.33,0,1,0,1,1,'EG Link + NorgannonDB 1/43');
-- Commander Cyclas: Fresh Gustberry Bread
DELETE FROM `creature_loot_template` WHERE `Entry`=251966 AND `ItemType`=0 AND `Item`=252028;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES (251966,0,252028,20.0,0,1,0,1,1,'EG Link + NorgannonDB 1/2');
-- Commander Cyclas: Galeswept Forestshroom
DELETE FROM `creature_loot_template` WHERE `Entry`=251966 AND `ItemType`=0 AND `Item`=267474;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES (251966,0,267474,20.0,0,1,0,1,1,'EG Link + NorgannonDB 1/2');
-- Al'Aketh Spiritcaller: Galestrider Jerky
DELETE FROM `creature_loot_template` WHERE `Entry`=252763 AND `ItemType`=0 AND `Item`=252022;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES (252763,0,252022,20.0,0,1,0,1,1,'EG Link + NorgannonDB 1/5');
-- Al'Aketh Spiritcaller: Airy Windseeker's Shirt
DELETE FROM `creature_loot_template` WHERE `Entry`=252763 AND `ItemType`=0 AND `Item`=273815;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES (252763,0,273815,20.0,0,1,0,1,1,'EG Link + NorgannonDB 2/5');
-- Al'Aketh Skypriest: Galestrider Jerky
DELETE FROM `creature_loot_template` WHERE `Entry`=252764 AND `ItemType`=0 AND `Item`=252022;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES (252764,0,252022,20.0,0,1,0,1,1,'EG Link + NorgannonDB 1/2');
-- Al'Aketh Skypriest: Windstone
DELETE FROM `creature_loot_template` WHERE `Entry`=252764 AND `ItemType`=0 AND `Item`=255663;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES (252764,0,255663,20.0,0,1,0,1,1,'EG Link + NorgannonDB 1/2');
-- Snargl: Stolen Ore
DELETE FROM `creature_loot_template` WHERE `Entry`=255906 AND `ItemType`=0 AND `Item`=265358;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES (255906,0,265358,20.0,1,1,0,1,1,'EG Link + NorgannonDB 1/2');
-- Fallen Necromancer: Rotmender's Garb
DELETE FROM `creature_loot_template` WHERE `Entry`=255964 AND `ItemType`=0 AND `Item`=286978;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES (255964,0,286978,20.0,0,1,0,1,1,'EG Link + NorgannonDB 2/10');
-- Saltseer Cultist: Voodoo-Infused Artifact
DELETE FROM `creature_loot_template` WHERE `Entry`=259981 AND `ItemType`=0 AND `Item`=270333;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES (259981,0,270333,20.0,1,1,0,1,1,'EG Link + NorgannonDB 2/4');
-- Deathless Marrow: Knucklebone Ring
DELETE FROM `creature_loot_template` WHERE `Entry`=260202 AND `ItemType`=0 AND `Item`=274614;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES (260202,0,274614,20.0,0,1,0,1,1,'EG Link + NorgannonDB 1/3');
-- Lost Stalker: Fading Echo
DELETE FROM `creature_loot_template` WHERE `Entry`=272260 AND `ItemType`=0 AND `Item`=275895;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES (272260,0,275895,20.0,0,1,0,1,1,'EG Link + NorgannonDB 1/3');
-- Lost Knight: Fading Echo
DELETE FROM `creature_loot_template` WHERE `Entry`=272291 AND `ItemType`=0 AND `Item`=275895;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES (272291,0,275895,20.0,0,1,0,1,1,'EG Link + NorgannonDB 1/2');
