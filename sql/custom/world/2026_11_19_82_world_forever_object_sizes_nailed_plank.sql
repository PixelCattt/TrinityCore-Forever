-- Westfall: the Nailed Plank (424010) for Stepping Stones (79192) floated in the air, and 23 other quest objects had the wrong size
-- or model. On the WoW Forever live realm (client 70938) these objects have the size and model below; ours came from older data.
-- Object data from Efficient Games (https://efficient.games), licensed under CC BY 4.0.
-- The plank model (display 303) sits 5.5 to 6.5 yd above its own origin, so at our old size 1.0 it hung about 4.5 yd over the ground.
-- With the live size 0.5 it is 2.7 yd up; the spawn is lowered so the board rests on the ground (navmesh ground 41.82 next to it,
-- minus 0.5 * 5.486 = 39.08; INFERRED from the model box, live gives no height). The Barrens plank (417072) gets the same size;
-- its height follows after a ground check.
UPDATE `gameobject_template` SET `displayId` = 88106, `size` = 0.75 WHERE `entry` = 406918; -- Messenger Bag
UPDATE `gameobject_template` SET `displayId` = 84818, `size` = 1.0 WHERE `entry` = 409735; -- Spellbook
UPDATE `gameobject_template` SET `displayId` = 303, `size` = 0.5 WHERE `entry` = 417072; -- Nailed Plank
UPDATE `gameobject_template` SET `displayId` = 558, `size` = 1.0 WHERE `entry` = 423896; -- Manual
UPDATE `gameobject_template` SET `displayId` = 164, `size` = 1.5 WHERE `entry` = 423897; -- Scrolls
UPDATE `gameobject_template` SET `displayId` = 4431, `size` = 1.0 WHERE `entry` = 423898; -- Mysterious Book
UPDATE `gameobject_template` SET `displayId` = 190, `size` = 1.0 WHERE `entry` = 423899; -- Scrolls
UPDATE `gameobject_template` SET `displayId` = 254, `size` = 1.0 WHERE `entry` = 423900; -- Waterlogged Book
UPDATE `gameobject_template` SET `displayId` = 1209, `size` = 0.5 WHERE `entry` = 424005; -- Pocket Litter
UPDATE `gameobject_template` SET `displayId` = 5912, `size` = 2.0 WHERE `entry` = 424007; -- Carved Figurine
UPDATE `gameobject_template` SET `displayId` = 303, `size` = 0.5 WHERE `entry` = 424010; -- Nailed Plank
UPDATE `gameobject_template` SET `displayId` = 86801, `size` = 0.4 WHERE `entry` = 424082; -- Firepit
UPDATE `gameobject_template` SET `displayId` = 132656, `size` = 0.2 WHERE `entry` = 562103; -- Waterlogged Saw
UPDATE `gameobject_template` SET `displayId` = 15, `size` = 0.5 WHERE `entry` = 649051; -- Wanted: Incinerator Gar'im
UPDATE `gameobject_template` SET `displayId` = 126300, `size` = 1.5 WHERE `entry` = 656182; -- Raider's Shield
UPDATE `gameobject_template` SET `displayId` = 214, `size` = 1.0 WHERE `entry` = 659310; -- Roderick the Unbroken
UPDATE `gameobject_template` SET `displayId` = 214, `size` = 1.0 WHERE `entry` = 659313; -- Alden Amberhall
UPDATE `gameobject_template` SET `displayId` = 127503, `size` = 1.5 WHERE `entry` = 660930; -- Pile of Complicated Parts
UPDATE `gameobject_template` SET `displayId` = 129238, `size` = 1.0 WHERE `entry` = 672330; -- Dragonmaw Armaments
UPDATE `gameobject_template` SET `displayId` = 378, `size` = 1.0 WHERE `entry` = 673101; -- Tarantula Egg
UPDATE `gameobject_template` SET `displayId` = 127995, `size` = 0.8, `name` = 'Blackrock Supplies' WHERE `entry` = 673385; -- ours said Grain Sack; live and the ruRU name say Blackrock Supplies
UPDATE `gameobject_template` SET `displayId` = 130, `size` = 1.5 WHERE `entry` = 673390; -- Weapon Rack
UPDATE `gameobject_template` SET `displayId` = 88154, `size` = 1.5 WHERE `entry` = 673399; -- Stolen Weapon
UPDATE `gameobject_template` SET `displayId` = 132645, `size` = 0.8 WHERE `entry` = 694855; -- Overgrown Duskweed
UPDATE `gameobject` SET `position_z` = 39.08 WHERE `guid` = 42401000 AND `id` = 424010;
