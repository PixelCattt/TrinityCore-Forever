-- Forever: weapon chance-on-hit rates measured on the live Forever realms. wowsims/forever (MIT, https://github.com/wowsims/forever,
-- tools/database/overrides/weapon_procs.go) counted procs per minute from combat logs for these weapons (their evidence notes
-- EV-0003, EV-0021, EV-0022, EV-0024, EV-0050, EV-0119 to EV-0122). The game files give these weapons no rate: the spell has no proc
-- row, or its chance reads the 100 / 101 sentinel, so Player::CastItemCombatSpell fell back to the weapon speed rate (about 1 per
-- minute) or to the VMaNGOS vanilla rate of 2026_10_11_25_world_classic_item_proc_ppm.sql (Flurry Axe 1.8, Skullforge Reaver 2).
-- Their rows marked as vanilla carry-overs (Felstriker 0.6 among them, noted there as an unverified Season of Discovery figure) are not
-- taken: those keep our VMaNGOS rates. Safe to run again.
INSERT INTO `item_template_addon` (`Id`,`SpellPPMChance`) VALUES
(871,1.65), -- Flurry Axe
(6220,1.55), -- Meteor Shard
(6472,1.75), -- Stinging Viper
(6904,1.45), -- Bite of Serra'kis
(7717,1), -- Ravager
(9418,1.95), -- Stoneslayer
(9453,1.8), -- Toxic Revenger
(9478,2), -- Ripsaw
(9639,2), -- The Hand of Antu'sul
(10750,1.5), -- Lifeforce Dirk
(10847,4.5), -- Dragon's Call
(11086,2.9), -- Jang'thraze the Protector
(11744,3.2), -- Bloodfist
(11803,2), -- Force of Magma
(12463,1.5), -- Drakefang Butcher
(12582,1.7), -- Keris of Zul'Serak
(12969,0.9), -- Seeping Willow
(12974,0.6), -- The Black Knight
(13040,2.7), -- Heartseeking Crossbow
(13183,1.7), -- Venomspitter
(13348,1.1), -- Demonshear
(13361,1.95), -- Skullforge Reaver
(13983,1.9), -- Gravestone War Axe
(17705,1), -- Thrash Blade
(17730,1.2), -- Gatorbite Axe
(17753,3.5), -- Verdant Keeper's Aim
(17766,1.8), -- Princess Theradras' Scepter
(17943,3.2), -- Fist of Stone
(18388,1.7), -- Stoneshatter
(274270,1.1), -- Weed Whacker
(274425,3.75), -- White Obsidian Wand
(274963,1.45), -- Rot-Covered Harpoon
(275441,2.3), -- Cremation Longbow
(276419,3.6), -- Lightcrest Hammer
(279480,1.5), -- Bigger Rock on Bigger Stick
(279852,1.85), -- Rock on Stick
(287005,0.6) -- Sword of Dismemberment
ON DUPLICATE KEY UPDATE `SpellPPMChance` = VALUES(`SpellPPMChance`);
