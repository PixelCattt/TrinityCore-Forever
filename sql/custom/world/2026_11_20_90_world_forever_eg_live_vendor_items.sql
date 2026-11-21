-- WoW Forever: items live vendors sell that ours do not, from what players saw in vendor windows (latest build each vendor
-- was seen in). Data from Efficient Games (https://efficient.games), licensed under CC BY 4.0
-- (https://creativecommons.org/licenses/by/4.0/). Source: github.com/JIVESCORP/eg-link-output-wowf vendors, builds 70205-70959.
-- Changed: picked and converted. Only items sold for money (items that cost other items or currency need a cost id: left out).
-- Limited stock items keep live's stock, restock 2.5 h (ESTIMATED). Rows are replaced by key. Safe to run again.
DELETE FROM `npc_vendor` WHERE `entry`=2401 AND `item`=11291 AND `type`=1;
DELETE FROM `npc_vendor` WHERE `entry`=2519 AND `item`=270312 AND `type`=1;
DELETE FROM `npc_vendor` WHERE `entry`=2519 AND `item`=270313 AND `type`=1;
DELETE FROM `npc_vendor` WHERE `entry`=2672 AND `item`=253665 AND `type`=1;
DELETE FROM `npc_vendor` WHERE `entry`=2672 AND `item`=253668 AND `type`=1;
DELETE FROM `npc_vendor` WHERE `entry`=3158 AND `item`=2901 AND `type`=1;
DELETE FROM `npc_vendor` WHERE `entry`=3158 AND `item`=7005 AND `type`=1;
DELETE FROM `npc_vendor` WHERE `entry`=3187 AND `item`=4536 AND `type`=1;
DELETE FROM `npc_vendor` WHERE `entry`=3962 AND `item`=11291 AND `type`=1;
DELETE FROM `npc_vendor` WHERE `entry`=5814 AND `item`=4603 AND `type`=1;
DELETE FROM `npc_vendor` WHERE `entry`=5814 AND `item`=6289 AND `type`=1;
DELETE FROM `npc_vendor` WHERE `entry`=5814 AND `item`=6303 AND `type`=1;
DELETE FROM `npc_vendor` WHERE `entry`=5814 AND `item`=6308 AND `type`=1;
DELETE FROM `npc_vendor` WHERE `entry`=5814 AND `item`=6362 AND `type`=1;
DELETE FROM `npc_vendor` WHERE `entry`=5814 AND `item`=8959 AND `type`=1;
DELETE FROM `npc_vendor` WHERE `entry`=6807 AND `item`=4603 AND `type`=1;
DELETE FROM `npc_vendor` WHERE `entry`=6807 AND `item`=6289 AND `type`=1;
DELETE FROM `npc_vendor` WHERE `entry`=6807 AND `item`=6303 AND `type`=1;
DELETE FROM `npc_vendor` WHERE `entry`=6807 AND `item`=6308 AND `type`=1;
DELETE FROM `npc_vendor` WHERE `entry`=6807 AND `item`=6362 AND `type`=1;
DELETE FROM `npc_vendor` WHERE `entry`=256575 AND `item`=10290 AND `type`=1;
DELETE FROM `npc_vendor` WHERE `entry`=256575 AND `item`=14341 AND `type`=1;
DELETE FROM `npc_vendor` WHERE `entry`=256575 AND `item`=2320 AND `type`=1;
DELETE FROM `npc_vendor` WHERE `entry`=256575 AND `item`=2321 AND `type`=1;
DELETE FROM `npc_vendor` WHERE `entry`=256575 AND `item`=2324 AND `type`=1;
DELETE FROM `npc_vendor` WHERE `entry`=256575 AND `item`=2325 AND `type`=1;
DELETE FROM `npc_vendor` WHERE `entry`=256575 AND `item`=253665 AND `type`=1;
DELETE FROM `npc_vendor` WHERE `entry`=256575 AND `item`=253668 AND `type`=1;
DELETE FROM `npc_vendor` WHERE `entry`=256575 AND `item`=2604 AND `type`=1;
DELETE FROM `npc_vendor` WHERE `entry`=256575 AND `item`=2605 AND `type`=1;
DELETE FROM `npc_vendor` WHERE `entry`=256575 AND `item`=4289 AND `type`=1;
DELETE FROM `npc_vendor` WHERE `entry`=256575 AND `item`=4291 AND `type`=1;
DELETE FROM `npc_vendor` WHERE `entry`=256575 AND `item`=4340 AND `type`=1;
DELETE FROM `npc_vendor` WHERE `entry`=256575 AND `item`=4341 AND `type`=1;
DELETE FROM `npc_vendor` WHERE `entry`=256575 AND `item`=4342 AND `type`=1;
DELETE FROM `npc_vendor` WHERE `entry`=256575 AND `item`=6260 AND `type`=1;
DELETE FROM `npc_vendor` WHERE `entry`=256575 AND `item`=6261 AND `type`=1;
DELETE FROM `npc_vendor` WHERE `entry`=256575 AND `item`=7005 AND `type`=1;
DELETE FROM `npc_vendor` WHERE `entry`=256575 AND `item`=8343 AND `type`=1;
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`) VALUES
(2401,22,11291,0,0,0,1,'',0,0,70888), -- Kayren Soothallow: Star Wood
(2519,0,270312,0,0,0,1,'',0,0,70938), -- Kin'weelay: Translated Tale of I'lalai
(2519,1,270313,0,0,0,1,'',0,0,70938), -- Kin'weelay: Tale of I'lalai in Zandali
(2672,23,253665,0,0,0,1,'',0,0,70959), -- Cowardly Crosby: Pattern: Linen Reagent Bag
(2672,24,253668,0,0,0,1,'',0,0,70959), -- Cowardly Crosby: Pattern: Woolen Reagent Bag
(3158,12,2901,0,0,0,1,'',0,0,70840), -- Duokna: Mining Pick
(3158,13,7005,0,0,0,1,'',0,0,70840), -- Duokna: Skinning Knife
(3187,1018,4536,0,0,0,1,'',0,0,70840), -- Tai'tasi: Shiny Red Apple
(3962,16,11291,0,0,0,1,'',0,0,70959), -- Haljan Oakheart: Star Wood
(5814,101,4603,5,9000,0,1,'',0,0,70938), -- Innkeeper Thulbek: Raw Spotted Yellowtail
(5814,102,6289,5,9000,0,1,'',0,0,70938), -- Innkeeper Thulbek: Raw Longjaw Mud Snapper
(5814,103,6303,5,9000,0,1,'',0,0,70938), -- Innkeeper Thulbek: Raw Slitherskin Mackerel
(5814,104,6308,5,9000,0,1,'',0,0,70938), -- Innkeeper Thulbek: Raw Bristle Whisker Catfish
(5814,105,6362,5,9000,0,1,'',0,0,70938), -- Innkeeper Thulbek: Raw Rockscale Cod
(5814,106,8959,5,9000,0,1,'',0,0,70938), -- Innkeeper Thulbek: Raw Spinefin Halibut
(6807,13,4603,5,9000,0,1,'',0,0,70959), -- Innkeeper Skindle: Raw Spotted Yellowtail
(6807,14,6289,5,9000,0,1,'',0,0,70959), -- Innkeeper Skindle: Raw Longjaw Mud Snapper
(6807,15,6303,5,9000,0,1,'',0,0,70959), -- Innkeeper Skindle: Raw Slitherskin Mackerel
(6807,16,6308,5,9000,0,1,'',0,0,70959), -- Innkeeper Skindle: Raw Bristle Whisker Catfish
(6807,17,6362,5,9000,0,1,'',0,0,70959), -- Innkeeper Skindle: Raw Rockscale Cod
(256575,0,10290,0,0,0,1,'',0,0,70862), -- Basket of Textile Supplies: Pink Dye
(256575,1,14341,0,0,0,1,'',0,0,70862), -- Basket of Textile Supplies: Rune Thread
(256575,2,2320,0,0,0,1,'',0,0,70862), -- Basket of Textile Supplies: Coarse Thread
(256575,3,2321,0,0,0,1,'',0,0,70862), -- Basket of Textile Supplies: Fine Thread
(256575,4,2324,0,0,0,1,'',0,0,70862), -- Basket of Textile Supplies: Bleach
(256575,5,2325,0,0,0,1,'',0,0,70862), -- Basket of Textile Supplies: Black Dye
(256575,6,253665,0,0,0,1,'',0,0,70862), -- Basket of Textile Supplies: Pattern: Linen Reagent Bag
(256575,7,253668,0,0,0,1,'',0,0,70862), -- Basket of Textile Supplies: Pattern: Woolen Reagent Bag
(256575,8,2604,0,0,0,1,'',0,0,70862), -- Basket of Textile Supplies: Red Dye
(256575,9,2605,0,0,0,1,'',0,0,70862), -- Basket of Textile Supplies: Green Dye
(256575,10,4289,0,0,0,1,'',0,0,70862), -- Basket of Textile Supplies: Salt
(256575,11,4291,0,0,0,1,'',0,0,70862), -- Basket of Textile Supplies: Silken Thread
(256575,12,4340,0,0,0,1,'',0,0,70862), -- Basket of Textile Supplies: Gray Dye
(256575,13,4341,0,0,0,1,'',0,0,70862), -- Basket of Textile Supplies: Yellow Dye
(256575,14,4342,0,0,0,1,'',0,0,70862), -- Basket of Textile Supplies: Purple Dye
(256575,15,6260,0,0,0,1,'',0,0,70862), -- Basket of Textile Supplies: Blue Dye
(256575,16,6261,0,0,0,1,'',0,0,70862), -- Basket of Textile Supplies: Orange Dye
(256575,17,7005,0,0,0,1,'',0,0,70862), -- Basket of Textile Supplies: Skinning Knife
(256575,18,8343,0,0,0,1,'',0,0,70862); -- Basket of Textile Supplies: Heavy Silken Thread
UPDATE `creature_template` SET `npcflag`=`npcflag`|128 WHERE `entry` IN (2519);
