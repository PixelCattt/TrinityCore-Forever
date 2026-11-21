-- WoW Forever: vendors that sell less here than on the live realm. Only items the vendor's newest live visit still showed, and
-- only vendors whose goods we already have the prices for (money only; items sold for tokens or reputation are left out).
-- Data from Efficient Games (https://efficient.games), licensed under CC BY 4.0
-- (https://creativecommons.org/licenses/by/4.0/). Source: github.com/JIVESCORP/eg-link-output-wowf, vendors.json and npcs.json of
-- builds 1.60.1.70790-70959, compared with the dev world DB on 2026-11-18. Changed: picked and converted to our npc_vendor rows.
-- Safe to run again.

-- 1. Basket of Textile Supplies (256575, The Barrens): spawned with the vendor flag but sold nothing here. Live (70862) sells 19 items.
DELETE FROM `npc_vendor` WHERE `entry` = 256575 AND `type` = 1 AND `item` IN
(2320,2321,2324,2325,2604,2605,4289,4291,4340,4341,4342,6260,6261,7005,8343,10290,14341,253665,253668);
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(256575, 0,  2320,0,0,0,1,NULL,0,0,70862), -- Coarse Thread
(256575, 1,  2321,0,0,0,1,NULL,0,0,70862), -- Fine Thread
(256575, 2,  4291,0,0,0,1,NULL,0,0,70862), -- Silken Thread
(256575, 3,  8343,0,0,0,1,NULL,0,0,70862), -- Heavy Silken Thread
(256575, 4, 14341,0,0,0,1,NULL,0,0,70862), -- Rune Thread
(256575, 5,  2324,0,0,0,1,NULL,0,0,70862), -- Bleach
(256575, 6,  2604,0,0,0,1,NULL,0,0,70862), -- Red Dye
(256575, 7,  2605,0,0,0,1,NULL,0,0,70862), -- Green Dye
(256575, 8,  6260,0,0,0,1,NULL,0,0,70862), -- Blue Dye
(256575, 9,  4340,0,0,0,1,NULL,0,0,70862), -- Gray Dye
(256575,10,  4341,0,0,0,1,NULL,0,0,70862), -- Yellow Dye
(256575,11,  6261,0,0,0,1,NULL,0,0,70862), -- Orange Dye
(256575,12,  2325,0,0,0,1,NULL,0,0,70862), -- Black Dye
(256575,13,  4342,0,0,0,1,NULL,0,0,70862), -- Purple Dye
(256575,14, 10290,0,0,0,1,NULL,0,0,70862), -- Pink Dye
(256575,15,  4289,0,0,0,1,NULL,0,0,70862), -- Salt
(256575,16,  7005,0,0,0,1,NULL,0,0,70862), -- Skinning Knife
(256575,17,253665,0,0,0,1,NULL,0,0,70862), -- Pattern: Linen Reagent Bag
(256575,18,253668,0,0,0,1,NULL,0,0,70862); -- Pattern: Woolen Reagent Bag

-- 2. Items a vendor sells on live and not here (each seen on the vendor's newest live visit). New rows go after the vendor's own.
DELETE FROM `npc_vendor` WHERE `type` = 1 AND (`entry`,`item`) IN
((3158,2901),(3158,7005),(3187,4536),(2401,11291),(6807,4603),(6807,6289),(6807,6303),(6807,6308),(6807,6362));
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(3158,100, 2901,0,0,0,1,NULL,0,0,70840),    -- Duokna (Razor Hill): Mining Pick
(3158,101, 7005,0,0,0,1,NULL,0,0,70840),    -- Duokna: Skinning Knife
(3187,100, 4536,0,0,0,1,NULL,0,0,70840),    -- Tai'tasi (Razor Hill): Shiny Red Apple
(2401,100,11291,0,0,0,1,NULL,0,0,70790),    -- Kayren Soothallow (Hillsbrad Foothills): Star Wood
-- Innkeeper Skindle (Booty Bay): raw fish in limited stock (5 each), the same as Innkeeper Wiley's in 2026_11_11_12.
(6807,100, 4603,5,7200,0,1,NULL,0,0,70959), -- Raw Spotted Yellowtail
(6807,101, 6289,5,7200,0,1,NULL,0,0,70959), -- Raw Longjaw Mud Snapper
(6807,102, 6303,5,7200,0,1,NULL,0,0,70959), -- Raw Slitherskin Mackerel
(6807,103, 6308,5,7200,0,1,NULL,0,0,70959), -- Raw Bristle Whisker Catfish
(6807,104, 6362,5,7200,0,1,NULL,0,0,70959); -- Raw Rockscale Cod
