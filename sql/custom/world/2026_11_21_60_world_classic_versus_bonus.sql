-- Classic 1.60 (WoW Forever): item effects stronger against one kind of enemy, which only the tooltip names (src/server/game/Spells/ClassicVersusBonus.h).
-- spell_versus_bonus: spell_id is the spell whose damage (kind 0, direct and periodic), proc chance (kind 1) or triggered restore (kind 2) the factor
-- scales; the factor is the base points of effect source_effect of source_spell, or `factor` when that is above 0. The enemies are those in
-- versus_groups (creature_versus_group, a troll / orc / dwarf player by race) or of a creature type in versus_types (1 << (type - 1)).
-- Groups: Troll 1, Orc 2, Dwarf 4, Plant 8, Aquatic 16, EarthElemental 32, Golem 64, TitanForged 128, FireElemental 256, MountainGiant 512,
-- Naga 1024, Satyr 2048, Dinosaur 4096, Serpentine 8192. Factors and groups from the client spell data and tooltips (build 70532), checked
-- against wowsims/forever (MIT) tools/database/overrides/spell_overrides.go VersusBonuses.
CREATE TABLE IF NOT EXISTS `spell_versus_bonus` (
  `spell_id` int unsigned NOT NULL,
  `kind` tinyint unsigned NOT NULL DEFAULT 0 COMMENT '0 damage, 1 proc chance, 2 restore',
  `source_spell` int unsigned NOT NULL,
  `source_effect` tinyint unsigned NOT NULL,
  `factor` float NOT NULL DEFAULT 0 COMMENT 'above 0: the factor; 0: the base points of source_effect',
  `versus_groups` int unsigned NOT NULL DEFAULT 0,
  `versus_types` int unsigned NOT NULL DEFAULT 0,
  `comment` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`spell_id`, `kind`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `creature_versus_group` (
  `entry` int unsigned NOT NULL,
  `groups` int unsigned NOT NULL,
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DELETE FROM `spell_versus_bonus` WHERE `spell_id` IN
(1294339,1294431,1300783,27655,15600,1301046,1293518,1293568,12278,17283,1295270,1302344,1302354,3742,1295744,1302166,12731,1302279,1294794,1317432,1322218,
 1265634,1295039);
INSERT INTO `spell_versus_bonus` (`spell_id`, `kind`, `source_spell`, `source_effect`, `factor`, `versus_groups`, `versus_types`, `comment`) VALUES
-- Trolls, Orcs
(1294339, 0, 1294339, 1, 0, 1, 0, 'The Chief''s Enforcer 9477, Farraki Enforcement: Trolls take $s2 times as much damage'),
(1294431, 0, 1294430, 4, 0, 1, 0, 'Sul''thraze the Lasher 9372, Shadow Lash: the additional Shadow damage of Rage of Sul''thraze deals $s5 times as much to Trolls'),
(1300783, 0, 1300783, 1, 0, 3, 0, 'Angerforge''s Battle Axe 11816, Slaughter: Trolls and Orcs take $s2 times as much damage'),
(27655, 0, 27656, 1, 0, 2, 0, 'Heart of Wyrmthalak 22321, Flame Lash: $s2 (of 27656) times as much damage to Orcs'),
(1301046, 1, 1301046, 1, 0, 2, 0, 'Ironfoe 11684, Fury of Forgewright: attacks against Orcs are $s2 times as likely to activate this effect'),
(15600, 1, 15600, 1, 0, 4, 0, 'Hand of Justice 11815: attacks against Dwarves are $s2 times as likely to activate this effect'),
-- Plants
(1293518, 0, 1293518, 1, 0, 8, 0, 'Brush Cutter 274265, Deadhead Blade 274271, Grass Killer: $s2 times as much damage to Plants'),
(1293568, 0, 1293568, 1, 0, 8, 0, 'Weed Whacker 274270, Grass Killer: $s2 times as much damage to Plants'),
(12278, 0, 12257, 1, 0, 8, 0, 'Thunderbrew''s Boot Flask 744, Breath of Fire: $s2 (of 12257) times as much damage to Plants'),
(17283, 0, 17283, 1, 0, 8, 0, 'Smokey''s Lighter 13171: $s2 times as much damage to Plants'),
(1295270, 0, 1295270, 1, 0, 8, 0, 'Everlook Pathcarver 274759, Prototype Pathcarver: $s2 times as much damage to Plants'),
(1302344, 0, 1302344, 1, 0, 8, 0, 'Hedgecutter 18498: $s2 times as much damage to Plants'),
(1302354, 0, 1302354, 1, 0, 8, 0, 'Treant''s Bane 18538, Treant Slayer: $s2 times as much damage to Plants'),
-- Aquatic
(3742, 0, 3742, 1, 0, 16, 0, 'Gahz''rilla Fang 9467: $s2 times as much damage to Aquatic enemies'),
(1295744, 0, 1295744, 1, 0, 16, 0, 'Rot-Covered Harpoon 274963, Rot: $s2 times as much damage (per tick) to Aquatic enemies'),
(1302166, 0, 1302166, 1, 0, 16, 0, 'Waveslicer 18324: $s2 times as much damage to Aquatic enemies'),
-- Earth Elementals, Golems, Titan-forged, Fire Elementals, Mountain Giants
(12731, 0, 12731, 1, 0, 224, 0, 'Stoneslayer 9418, Strength of Stone: $s2 times as much damage to Earth Elementals, Golems, and Titan-forged'),
(1302279, 0, 1302279, 1, 0, 224, 0, 'Stoneshatter 18388: $s2 times as much damage to Earth Elementals, Golems, and Titan-forged'),
(1294794, 2, 1294794, 0, 0, 224, 0, 'Fist of Stone 17943: restores (21951) $s1 times as much if attacking an Earth Elemental, Golem, or Titan-forged enemy'),
(1317432, 0, 1317432, 1, 0, 800, 0, 'Hammer of Expertise 8708, Forging Strike: $s2 times as much damage to Earth Elementals, Fire Elementals, and Mountain Giants'),
(1322218, 0, 1322218, 1, 0, 288, 0, 'Verigan''s Fist 6953, Holy Forgefire: $s2 times as much damage to Fire Elementals and Earth Elementals'),
-- Naga, Satyrs
(1265634, 0, 1318159, 0, 0, 3072, 0, 'Highborne Research Tablet 260205, Ancient Power: $s1 (of 1318159) times as much damage to Naga and Satyrs'),
-- Beasts (creature type 1) and Serpentine
(1295039, 0, 1295039, 2, 0, 8192, 1, 'Serpentbane Crown 274609: $s3 times as much damage (hit and burn) to Beast and Serpentine targets');
