-- Forever trainers that teach the wrong list, or nothing: what Wowhead's WoW Forever database (www.wowhead.com/forever, the
-- "Teaches" tab of each trainer's page) shows live trainers teach, compared with our world. Changed: written as our own rows.
--   Linzy Blackbolt (246795) and Patricia Egan (275322) teach live up to Viridian Dye (skill 215) but had our first alchemy
--     list (353), so 12 recipes were missing (Mana Potion, Lesser Invisibility Potion, Elixir of Agility and Defense, Greater
--     Mana Potion, Oil of Immolation, Catseye Draught, Greater Water Breathing, Expert Alchemy, the two dyes ...).
--   Charles Worth (251972) teaches live up to Mageweave Bag (skill 190) but had list 388: 7 patterns and Expert Tailoring missing.
--   Vanessa Sellers (251978) teaches live up to Enchant Boots - Minor Speed (skill 225): 20 formulas and Expert Enchanting missing.
--   Ortak Lomgok (244512) and Paige (267000) teach cooking live but had no trainer list (and no trainer flag), so they could not.
--   Each gets its own list (1000000 + its entry, as the other per-trainer lists): live's spells with live's price, skill and
--   level; the other fields as our rows for the same spell elsewhere. Spells of the old list that live shows under another id
--   (Apprentice Alchemist 2275, Apprentice and Journeyman Tailoring, Enchant Bracer - Minor Deflect) are kept.
--   Rogue trainers (our list 26, every rogue trainer): live teaches Death Mark (1325756, 1325757, 1325758 at 48, 56 and 60) and
--     Poisons (2842, free at 20); we had neither.
-- Not here: pet trainer Growl 1 and 2 (live's page shows no price for pet skills), and spells the client has no data for.
-- Everything only where missing or still as before. Safe to run more than once.

INSERT INTO `trainer` (`Id`,`Type`,`Greeting`,`VerifiedBuild`) SELECT 1246795,`Type`,`Greeting`,0 FROM `trainer` WHERE `Id` = 353
  AND NOT EXISTS (SELECT 1 FROM `trainer` WHERE `Id` = 1246795);  -- Linzy Blackbolt
INSERT INTO `trainer` (`Id`,`Type`,`Greeting`,`VerifiedBuild`) SELECT 1275322,`Type`,`Greeting`,0 FROM `trainer` WHERE `Id` = 353
  AND NOT EXISTS (SELECT 1 FROM `trainer` WHERE `Id` = 1275322);  -- Patricia Egan
INSERT INTO `trainer` (`Id`,`Type`,`Greeting`,`VerifiedBuild`) SELECT 1251972,`Type`,`Greeting`,0 FROM `trainer` WHERE `Id` = 388
  AND NOT EXISTS (SELECT 1 FROM `trainer` WHERE `Id` = 1251972);  -- Charles Worth
INSERT INTO `trainer` (`Id`,`Type`,`Greeting`,`VerifiedBuild`) SELECT 1251978,`Type`,`Greeting`,0 FROM `trainer` WHERE `Id` = 1001317
  AND NOT EXISTS (SELECT 1 FROM `trainer` WHERE `Id` = 1251978);  -- Vanessa Sellers
INSERT INTO `trainer` (`Id`,`Type`,`Greeting`,`VerifiedBuild`) SELECT 1244512,`Type`,`Greeting`,0 FROM `trainer` WHERE `Id` = 36
  AND NOT EXISTS (SELECT 1 FROM `trainer` WHERE `Id` = 1244512);  -- Ortak Lomgok
INSERT INTO `trainer` (`Id`,`Type`,`Greeting`,`VerifiedBuild`) SELECT 1267000,`Type`,`Greeting`,0 FROM `trainer` WHERE `Id` = 36
  AND NOT EXISTS (SELECT 1 FROM `trainer` WHERE `Id` = 1267000);  -- Paige

DROP TEMPORARY TABLE IF EXISTS `forever_trainer_1121`;
CREATE TEMPORARY TABLE `forever_trainer_1121` (`TrainerId` INT UNSIGNED NOT NULL, `SpellId` INT UNSIGNED NOT NULL,
  `MoneyCost` INT UNSIGNED NOT NULL, `ReqSkillLine` INT UNSIGNED NOT NULL, `ReqSkillRank` INT UNSIGNED NOT NULL, `ReqAbility1` INT UNSIGNED NOT NULL,
  `ReqAbility2` INT UNSIGNED NOT NULL, `ReqAbility3` INT UNSIGNED NOT NULL, `ReqLevel` TINYINT UNSIGNED NOT NULL, PRIMARY KEY (`TrainerId`,`SpellId`));
INSERT INTO `forever_trainer_1121` (`TrainerId`,`SpellId`,`MoneyCost`,`ReqSkillLine`,`ReqSkillRank`,`ReqAbility1`,`ReqAbility2`,`ReqAbility3`,`ReqLevel`) VALUES
(1246795,2275,10,0,0,0,0,0,1),                  -- Linzy Blackbolt: Apprentice Alchemist
(1246795,2329,52,171,15,0,0,0,0),               -- Linzy Blackbolt: Elixir of Minor Strength
(1246795,2331,100,171,25,0,0,0,0),              -- Linzy Blackbolt: Minor Mana Potion
(1246795,2332,150,171,40,0,0,0,0),              -- Linzy Blackbolt: Minor Rejuvenation Potion
(1246795,2334,250,171,50,0,0,0,0),              -- Linzy Blackbolt: Elixir of Minor Fortitude
(1246795,3101,500,171,50,0,0,0,10),             -- Linzy Blackbolt: Alchemy
(1246795,3170,50,171,15,0,0,0,0),               -- Linzy Blackbolt: Minor Troll's Blood Elixir
(1246795,3171,500,171,90,0,0,0,0),              -- Linzy Blackbolt: Elixir of Wisdom
(1246795,3173,1500,171,120,0,0,0,0),            -- Linzy Blackbolt: Lesser Mana Potion
(1246795,3176,1500,171,125,0,0,0,0),            -- Linzy Blackbolt: Lesser Troll's Blood Elixir
(1246795,3177,2000,171,130,0,0,0,0),            -- Linzy Blackbolt: Elixir of Lesser Defense
(1246795,3448,5000,171,165,0,0,0,0),            -- Linzy Blackbolt: Lesser Invisibility Potion
(1246795,3450,6000,171,175,0,0,0,0),            -- Linzy Blackbolt: Elixir of Lesser Fortitude
(1246795,3452,5000,171,160,0,0,0,0),            -- Linzy Blackbolt: Mana Potion
(1246795,3464,5000,171,125,0,0,0,20),           -- Linzy Blackbolt: Alchemy
(1246795,7179,450,171,90,0,0,0,0),              -- Linzy Blackbolt: Draught of Water Breathing
(1246795,7836,250,171,80,0,0,0,0),              -- Linzy Blackbolt: Blackmouth Oil
(1246795,7837,1000,171,130,0,0,0,0),            -- Linzy Blackbolt: Fire Oil
(1246795,7841,1000,171,100,0,0,0,0),            -- Linzy Blackbolt: Swim Speed Potion
(1246795,7845,3000,171,140,0,0,0,0),            -- Linzy Blackbolt: Elixir of Fire Power
(1246795,11448,9000,171,205,0,0,0,0),           -- Linzy Blackbolt: Greater Mana Potion
(1246795,11449,6500,171,185,0,0,0,0),           -- Linzy Blackbolt: Elixir of Agility
(1246795,11450,7500,171,195,0,0,0,0),           -- Linzy Blackbolt: Elixir of Defense
(1246795,11451,8000,171,205,0,0,0,0),           -- Linzy Blackbolt: Oil of Immolation
(1246795,12609,8000,171,200,0,0,0,0),           -- Linzy Blackbolt: Catseye Draught
(1246795,22808,10000,171,215,0,0,0,0),          -- Linzy Blackbolt: Draught of Greater Water Breathing
(1246795,1230564,105,171,20,0,0,0,0),           -- Linzy Blackbolt: Mana Well
(1246795,1249630,157,171,40,0,0,0,0),           -- Linzy Blackbolt: Cerulean Dye
(1246795,1249631,1578,171,120,0,0,0,0),         -- Linzy Blackbolt: Magenta Dye
(1246795,1249632,10000,171,215,0,0,0,0),        -- Linzy Blackbolt: Viridian Dye
(1246795,1249633,157,171,40,0,0,0,0),           -- Linzy Blackbolt: Sulfuric Acid
(1275322,2275,10,0,0,0,0,0,1),                  -- Patricia Egan: Apprentice Alchemist
(1275322,2329,52,171,15,0,0,0,0),               -- Patricia Egan: Elixir of Minor Strength
(1275322,2331,100,171,25,0,0,0,0),              -- Patricia Egan: Minor Mana Potion
(1275322,2332,150,171,40,0,0,0,0),              -- Patricia Egan: Minor Rejuvenation Potion
(1275322,2334,250,171,50,0,0,0,0),              -- Patricia Egan: Elixir of Minor Fortitude
(1275322,3101,500,171,50,0,0,0,10),             -- Patricia Egan: Alchemy
(1275322,3170,50,171,15,0,0,0,0),               -- Patricia Egan: Minor Troll's Blood Elixir
(1275322,3171,500,171,90,0,0,0,0),              -- Patricia Egan: Elixir of Wisdom
(1275322,3173,1500,171,120,0,0,0,0),            -- Patricia Egan: Lesser Mana Potion
(1275322,3176,1500,171,125,0,0,0,0),            -- Patricia Egan: Lesser Troll's Blood Elixir
(1275322,3177,2000,171,130,0,0,0,0),            -- Patricia Egan: Elixir of Lesser Defense
(1275322,3448,5000,171,165,0,0,0,0),            -- Patricia Egan: Lesser Invisibility Potion
(1275322,3450,6000,171,175,0,0,0,0),            -- Patricia Egan: Elixir of Lesser Fortitude
(1275322,3452,5000,171,160,0,0,0,0),            -- Patricia Egan: Mana Potion
(1275322,3464,5000,171,125,0,0,0,20),           -- Patricia Egan: Alchemy
(1275322,7179,450,171,90,0,0,0,0),              -- Patricia Egan: Draught of Water Breathing
(1275322,7836,250,171,80,0,0,0,0),              -- Patricia Egan: Blackmouth Oil
(1275322,7837,1000,171,130,0,0,0,0),            -- Patricia Egan: Fire Oil
(1275322,7841,1000,171,100,0,0,0,0),            -- Patricia Egan: Swim Speed Potion
(1275322,7845,3000,171,140,0,0,0,0),            -- Patricia Egan: Elixir of Fire Power
(1275322,11448,9000,171,205,0,0,0,0),           -- Patricia Egan: Greater Mana Potion
(1275322,11449,6500,171,185,0,0,0,0),           -- Patricia Egan: Elixir of Agility
(1275322,11450,7500,171,195,0,0,0,0),           -- Patricia Egan: Elixir of Defense
(1275322,11451,8000,171,205,0,0,0,0),           -- Patricia Egan: Oil of Immolation
(1275322,12609,8000,171,200,0,0,0,0),           -- Patricia Egan: Catseye Draught
(1275322,22808,10000,171,215,0,0,0,0),          -- Patricia Egan: Draught of Greater Water Breathing
(1275322,1230564,105,171,20,0,0,0,0),           -- Patricia Egan: Mana Well
(1275322,1249630,157,171,40,0,0,0,0),           -- Patricia Egan: Cerulean Dye
(1275322,1249631,1578,171,120,0,0,0,0),         -- Patricia Egan: Magenta Dye
(1275322,1249632,10000,171,215,0,0,0,0),        -- Patricia Egan: Viridian Dye
(1275322,1249633,157,171,40,0,0,0,0),           -- Patricia Egan: Sulfuric Acid
(1251972,2385,50,197,10,0,0,0,0),               -- Charles Worth: Brown Linen Vest
(1251972,2386,200,197,40,0,0,0,0),              -- Charles Worth: Linen Boots
(1251972,2392,50,197,25,0,0,0,0),               -- Charles Worth: Red Linen Shirt
(1251972,2393,26,197,1,0,0,0,0),                -- Charles Worth: White Linen Shirt
(1251972,2394,50,197,25,0,0,0,0),               -- Charles Worth: Blue Linen Shirt
(1251972,2395,300,197,40,0,0,0,0),              -- Charles Worth: Barbaric Linen Vest
(1251972,2396,200,197,40,0,0,0,0),              -- Charles Worth: Green Linen Shirt
(1251972,2397,200,197,35,0,0,0,0),              -- Charles Worth: Reinforced Linen Cape
(1251972,2399,300,197,60,0,0,0,0),              -- Charles Worth: Green Woolen Vest
(1251972,2401,300,197,70,0,0,0,0),              -- Charles Worth: Woolen Boots
(1251972,2402,250,197,55,0,0,0,0),              -- Charles Worth: Woolen Cape
(1251972,2406,200,197,80,0,0,0,0),              -- Charles Worth: Gray Woolen Shirt
(1251972,2964,100,197,55,0,0,0,0),              -- Charles Worth: Bolt of Woolen Cloth
(1251972,3755,100,197,5,0,0,0,0),               -- Charles Worth: Linen Bag
(1251972,3757,200,197,50,0,0,0,0),              -- Charles Worth: Woolen Bag
(1251972,3813,800,197,125,0,0,0,0),             -- Charles Worth: Small Silk Pack
(1251972,3839,500,197,100,0,0,0,0),             -- Charles Worth: Bolt of Silk Cloth
(1251972,3840,100,197,25,0,0,0,0),              -- Charles Worth: Heavy Linen Gloves
(1251972,3841,200,197,35,0,0,0,0),              -- Charles Worth: Green Linen Bracers
(1251972,3842,300,197,45,0,0,0,0),              -- Charles Worth: Handstitched Linen Britches
(1251972,3843,400,197,60,0,0,0,0),              -- Charles Worth: Heavy Woolen Gloves
(1251972,3845,300,197,55,0,0,0,0),              -- Charles Worth: Soft-soled Linen Boots
(1251972,3848,500,197,85,0,0,0,0),              -- Charles Worth: Double-stitched Woolen Shoulders
(1251972,3850,500,197,85,0,0,0,0),              -- Charles Worth: Heavy Woolen Pants
(1251972,3852,750,197,105,0,0,0,0),             -- Charles Worth: Gloves of Meditation
(1251972,3855,750,197,100,0,0,0,0),             -- Charles Worth: Spidersilk Boots
(1251972,3859,750,197,125,0,0,0,0),             -- Charles Worth: Azure Silk Vest
(1251972,3861,1000,197,150,0,0,0,0),            -- Charles Worth: Long Silken Cloak
(1251972,3865,1000,197,140,0,0,0,0),            -- Charles Worth: Bolt of Mageweave
(1251972,3866,250,197,85,0,0,0,0),              -- Charles Worth: Stylish Red Shirt
(1251972,3871,500,197,135,0,0,0,0),             -- Charles Worth: Formal White Shirt
(1251972,3910,5000,197,125,0,0,0,20),           -- Charles Worth: Tailoring
(1251972,3911,10,0,0,0,0,0,1),                  -- Charles Worth: Apprentice Tailoring
(1251972,3912,500,197,50,0,0,0,10),             -- Charles Worth: Journeyman Tailoring
(1251972,3914,50,197,25,0,0,0,0),               -- Charles Worth: Brown Linen Pants
(1251972,6521,400,197,70,0,0,0,0),              -- Charles Worth: Pearl-clasped Cloak
(1251972,6690,1000,197,110,0,0,0,0),            -- Charles Worth: Lesser Wizard's Robe
(1251972,7623,50,197,25,0,0,0,0),               -- Charles Worth: Brown Linen Robe
(1251972,7624,50,197,25,0,0,0,0),               -- Charles Worth: White Linen Robe
(1251972,8465,50,197,25,0,0,0,0),               -- Charles Worth: Simple Dress
(1251972,8467,250,197,85,0,0,0,0),              -- Charles Worth: White Woolen Dress
(1251972,8483,500,197,125,0,0,0,0),             -- Charles Worth: White Swashbuckler's Shirt
(1251972,8489,750,197,140,0,0,0,0),             -- Charles Worth: Red Swashbuckler's Shirt
(1251972,8758,600,197,115,0,0,0,0),             -- Charles Worth: Azure Silk Pants
(1251972,8760,600,197,120,0,0,0,0),             -- Charles Worth: Azure Silk Hood
(1251972,8762,750,197,125,0,0,0,0),             -- Charles Worth: Silk Headband
(1251972,8764,900,197,135,0,0,0,0),             -- Charles Worth: Earthen Vest
(1251972,8766,1000,197,140,0,0,0,0),            -- Charles Worth: Azure Silk Belt
(1251972,8770,1000,197,155,0,0,0,0),            -- Charles Worth: Robe of Power
(1251972,8772,1000,197,140,0,0,0,0),            -- Charles Worth: Crimson Silk Belt
(1251972,8774,1000,197,145,0,0,0,0),            -- Charles Worth: Green Silken Shoulders
(1251972,8776,50,197,15,0,0,0,0),               -- Charles Worth: Linen Belt
(1251972,8791,2500,197,150,0,0,0,0),            -- Charles Worth: Crimson Silk Vest
(1251972,8799,3000,197,160,0,0,0,0),            -- Charles Worth: Crimson Silk Pantaloons
(1251972,8804,5000,197,175,0,0,0,0),            -- Charles Worth: Crimson Silk Gloves
(1251972,12045,50,197,20,0,0,0,0),              -- Charles Worth: Simple Linen Boots
(1251972,12046,300,197,50,0,0,0,0),             -- Charles Worth: Simple Kilt
(1251972,12048,4000,197,170,0,0,0,0),           -- Charles Worth: Black Mageweave Vest
(1251972,12049,4000,197,170,0,0,0,0),           -- Charles Worth: Black Mageweave Leggings
(1251972,12050,4000,197,175,0,0,0,0),           -- Charles Worth: Black Mageweave Robe
(1251972,12053,5000,197,180,0,0,0,0),           -- Charles Worth: Black Mageweave Gloves
(1251972,12061,2500,197,180,0,0,0,0),           -- Charles Worth: Orange Mageweave Shirt
(1251972,12065,5000,197,190,0,0,0,0),           -- Charles Worth: Mageweave Bag
(1251972,12067,5000,197,190,0,0,0,0),           -- Charles Worth: Dreamweave Gloves
(1251972,12069,5000,197,190,0,0,0,0),           -- Charles Worth: Cindercloth Robe
(1251972,12070,5000,197,190,0,0,0,0),           -- Charles Worth: Dreamweave Vest
(1251972,1229504,105,197,20,0,0,0,0),           -- Charles Worth: Faction Banner
(1251972,1257368,526,197,35,0,0,0,0),           -- Charles Worth: Novice Arcanist's Sash
(1251972,1257369,526,197,35,0,0,0,0),           -- Charles Worth: Novice Ardent's Sash
(1251972,1257426,1450,197,150,0,0,0,0),         -- Charles Worth: Gilded Slippers
(1251972,1257427,1450,197,150,0,0,0,0),         -- Charles Worth: Frothing Slippers
(1251972,1257428,1450,197,150,0,0,0,0),         -- Charles Worth: Fiery Slippers
(1251972,1257429,1450,197,150,0,0,0,0),         -- Charles Worth: Black Slippers
(1251972,1257430,1450,197,150,0,0,0,0),         -- Charles Worth: Golden Slippers
(1251972,1257431,1450,197,150,0,0,0,0),         -- Charles Worth: Radiant Slippers
(1251972,1263425,105,197,20,0,0,0,0),           -- Charles Worth: Faction Banner
(1251978,7411,10,0,0,0,0,0,1),                  -- Vanessa Sellers: Enchanting
(1251978,7412,500,333,50,0,0,0,10),             -- Vanessa Sellers: Enchanting
(1251978,7413,5000,333,125,0,0,0,20),           -- Vanessa Sellers: Enchanting
(1251978,7420,50,333,15,0,0,0,0),               -- Vanessa Sellers: Enchant Chest - Inferior Stamina
(1251978,7426,100,333,40,0,0,0,0),              -- Vanessa Sellers: Enchant Chest - Minor Absorption
(1251978,7428,100,333,20,0,0,0,0),              -- Vanessa Sellers: Enchant Bracer - Minor Deflect
(1251978,7454,100,333,45,0,0,0,0),              -- Vanessa Sellers: Enchant Cloak - Minor Resistance
(1251978,7457,250,333,50,0,0,0,0),              -- Vanessa Sellers: Enchant Bracer - Minor Stamina
(1251978,7745,500,333,100,0,0,0,0),             -- Vanessa Sellers: Enchant 2H Weapon - Minor Impact
(1251978,7748,250,333,60,0,0,0,0),              -- Vanessa Sellers: Enchant Chest - Lesser Stamina
(1251978,7771,200,333,70,0,0,0,0),              -- Vanessa Sellers: Enchant Cloak - Minor Protection
(1251978,7779,400,333,80,0,0,0,0),              -- Vanessa Sellers: Enchant Bracer - Minor Agility
(1251978,7788,500,333,90,0,0,0,0),              -- Vanessa Sellers: Enchant Weapon - Minor Striking
(1251978,7795,1000,333,100,0,0,0,0),            -- Vanessa Sellers: Runed Silver Rod
(1251978,7857,1000,333,120,0,0,0,0),            -- Vanessa Sellers: Enchant Chest - Stamina
(1251978,7861,1250,333,125,0,0,0,0),            -- Vanessa Sellers: Enchant Cloak - Lesser Fire Resistance
(1251978,7863,1400,333,125,0,0,0,0),            -- Vanessa Sellers: Enchant Boots - Minor Stamina
(1251978,13378,600,333,105,0,0,0,0),            -- Vanessa Sellers: Enchant Shield - Minor Stamina
(1251978,13421,800,333,115,0,0,0,0),            -- Vanessa Sellers: Enchant Cloak - Lesser Protection
(1251978,13485,1500,333,130,0,0,0,0),           -- Vanessa Sellers: Enchant Shield - Lesser Spirit
(1251978,13501,1500,333,130,0,0,0,0),           -- Vanessa Sellers: Enchant Bracer - Lesser Stamina
(1251978,13503,2000,333,140,0,0,0,0),           -- Vanessa Sellers: Enchant Weapon - Lesser Striking
(1251978,13529,2400,333,145,0,0,0,0),           -- Vanessa Sellers: Enchant 2H Weapon - Lesser Impact
(1251978,13538,2500,333,140,0,0,0,0),           -- Vanessa Sellers: Enchant Chest - Lesser Absorption
(1251978,13607,2400,333,145,0,0,0,0),           -- Vanessa Sellers: Enchant Chest - Intellect
(1251978,13622,2500,333,150,0,0,0,0),           -- Vanessa Sellers: Enchant Bracer - Lesser Intellect
(1251978,13626,2500,333,150,0,0,0,0),           -- Vanessa Sellers: Enchant Chest - Minor Stats
(1251978,13628,2500,333,150,0,0,0,0),           -- Vanessa Sellers: Runed Golden Rod
(1251978,13631,2600,333,155,0,0,0,0),           -- Vanessa Sellers: Enchant Shield - Lesser Stamina
(1251978,13635,2600,333,155,0,0,0,0),           -- Vanessa Sellers: Enchant Cloak - Defense
(1251978,13637,2800,333,160,0,0,0,0),           -- Vanessa Sellers: Enchant Boots - Lesser Agility
(1251978,13640,2700,333,160,0,0,0,0),           -- Vanessa Sellers: Enchant Chest - Greater Stamina
(1251978,13642,2800,333,165,0,0,0,0),           -- Vanessa Sellers: Enchant Bracer - Spirit
(1251978,13644,2800,333,170,0,0,0,0),           -- Vanessa Sellers: Enchant Boots - Lesser Stamina
(1251978,13648,2800,333,170,0,0,0,0),           -- Vanessa Sellers: Enchant Bracer - Stamina
(1251978,13657,3000,333,175,0,0,0,0),           -- Vanessa Sellers: Enchant Cloak - Fire Resistance
(1251978,13659,3200,333,180,0,0,0,0),           -- Vanessa Sellers: Enchant Shield - Spirit
(1251978,13661,3600,333,180,0,0,0,0),           -- Vanessa Sellers: Enchant Bracer - Strength
(1251978,13663,3800,333,185,0,0,0,0),           -- Vanessa Sellers: Enchant Chest - Greater Intellect
(1251978,13693,4000,333,195,0,0,0,0),           -- Vanessa Sellers: Enchant Weapon - Striking
(1251978,13695,4000,333,200,0,0,0,0),           -- Vanessa Sellers: Enchant 2H Weapon - Impact
(1251978,13700,4000,333,200,0,0,0,0),           -- Vanessa Sellers: Enchant Chest - Lesser Stats
(1251978,13702,4000,333,200,0,0,0,0),           -- Vanessa Sellers: Runed Truesilver Rod
(1251978,13746,4200,333,205,0,0,0,0),           -- Vanessa Sellers: Enchant Cloak - Greater Defense
(1251978,13794,4200,333,205,0,0,0,0),           -- Vanessa Sellers: Enchant Cloak - Resistance
(1251978,13815,4400,333,210,0,0,0,0),           -- Vanessa Sellers: Enchant Gloves - Agility
(1251978,13822,4400,333,210,0,0,0,0),           -- Vanessa Sellers: Enchant Bracer - Intellect
(1251978,13836,4600,333,215,0,0,0,0),           -- Vanessa Sellers: Enchant Boots - Stamina
(1251978,13858,4800,333,220,0,0,0,0),           -- Vanessa Sellers: Enchant Chest - Superior Stamina
(1251978,13887,5000,333,225,0,0,0,0),           -- Vanessa Sellers: Enchant Gloves - Strength
(1251978,13890,5000,333,225,0,0,0,0),           -- Vanessa Sellers: Enchant Boots - Minor Speed
(1251978,14293,50,333,10,0,0,0,0),              -- Vanessa Sellers: Lesser Magic Wand
(1251978,14807,200,333,70,0,0,0,0),             -- Vanessa Sellers: Greater Magic Wand
(1251978,14809,2600,333,155,0,0,0,0),           -- Vanessa Sellers: Lesser Mystic Wand
(1251978,14810,3000,333,175,0,0,0,0),           -- Vanessa Sellers: Greater Mystic Wand
(1251978,1230643,105,333,20,0,0,0,0),           -- Vanessa Sellers: Enchanted Lute
(1244512,2539,52,185,10,0,0,0,0),               -- Ortak Lomgok: Spiced Wolf Meat
(1244512,2541,105,185,50,0,0,0,0),              -- Ortak Lomgok: Coyote Steak
(1244512,2544,210,185,75,0,0,0,0),              -- Ortak Lomgok: Crab Cake
(1244512,2546,157,185,80,0,0,0,0),              -- Ortak Lomgok: Dry Pork Ribs
(1244512,2550,100,0,0,0,0,0,0),                 -- Ortak Lomgok: Cooking
(1244512,3102,500,185,50,0,0,0,10),             -- Ortak Lomgok: Cooking
(1244512,6499,105,185,50,0,0,0,0),              -- Ortak Lomgok: Boiled Clams
(1244512,6500,315,185,125,0,0,0,0),             -- Ortak Lomgok: Goblin Deviled Clams
(1244512,21175,4210,185,200,0,0,0,0),           -- Ortak Lomgok: Spider Sausage
(1244512,1229737,105,185,20,0,0,0,0),           -- Ortak Lomgok: Basic Campfire
(1267000,2539,52,185,10,0,0,0,0),               -- Paige: Spiced Wolf Meat
(1267000,2541,105,185,50,0,0,0,0),              -- Paige: Coyote Steak
(1267000,2544,210,185,75,0,0,0,0),              -- Paige: Crab Cake
(1267000,2546,157,185,80,0,0,0,0),              -- Paige: Dry Pork Ribs
(1267000,2550,100,0,0,0,0,0,0),                 -- Paige: Cooking
(1267000,3102,500,185,50,0,0,0,10),             -- Paige: Cooking
(1267000,6499,105,185,50,0,0,0,0),              -- Paige: Boiled Clams
(1267000,6500,315,185,125,0,0,0,0),             -- Paige: Goblin Deviled Clams
(1267000,21175,4210,185,200,0,0,0,0),           -- Paige: Spider Sausage
(1267000,1229737,105,185,20,0,0,0,0),           -- Paige: Basic Campfire
(26,1325756,45263,0,0,0,0,0,48),                -- rogue: Death Mark
(26,1325757,50526,0,0,1325756,0,0,56),          -- rogue: Death Mark
(26,1325758,53684,0,0,1325757,0,0,60),          -- rogue: Death Mark
(26,2842,0,0,0,0,0,0,20);                       -- rogue: Poisons
INSERT INTO `trainer_spell` (`TrainerId`,`SpellId`,`MoneyCost`,`ReqSkillLine`,`ReqSkillRank`,`ReqAbility1`,`ReqAbility2`,`ReqAbility3`,`ReqLevel`,`VerifiedBuild`)
SELECT t.`TrainerId`,t.`SpellId`,t.`MoneyCost`,t.`ReqSkillLine`,t.`ReqSkillRank`,t.`ReqAbility1`,t.`ReqAbility2`,t.`ReqAbility3`,t.`ReqLevel`,0
FROM `forever_trainer_1121` t
WHERE EXISTS (SELECT 1 FROM `trainer` r WHERE r.`Id` = t.`TrainerId`)
  AND NOT EXISTS (SELECT 1 FROM `trainer_spell` s WHERE s.`TrainerId` = t.`TrainerId` AND s.`SpellId` = t.`SpellId`);
DROP TEMPORARY TABLE IF EXISTS `forever_trainer_1121`;

UPDATE `creature_trainer` SET `TrainerID` = 1246795 WHERE `CreatureID` = 246795 AND `TrainerID` = 353
  AND EXISTS (SELECT 1 FROM `trainer` WHERE `Id` = 1246795);  -- Linzy Blackbolt
UPDATE `creature_trainer` SET `TrainerID` = 1275322 WHERE `CreatureID` = 275322 AND `TrainerID` = 353
  AND EXISTS (SELECT 1 FROM `trainer` WHERE `Id` = 1275322);  -- Patricia Egan
UPDATE `creature_trainer` SET `TrainerID` = 1251972 WHERE `CreatureID` = 251972 AND `TrainerID` = 388
  AND EXISTS (SELECT 1 FROM `trainer` WHERE `Id` = 1251972);  -- Charles Worth
UPDATE `creature_trainer` SET `TrainerID` = 1251978 WHERE `CreatureID` = 251978 AND `TrainerID` = 1001317
  AND EXISTS (SELECT 1 FROM `trainer` WHERE `Id` = 1251978);  -- Vanessa Sellers
UPDATE `creature_template` SET `npcflag` = `npcflag` | 80 WHERE `entry` = 244512 AND (`npcflag` & 80) <> 80
  AND EXISTS (SELECT 1 FROM `trainer` WHERE `Id` = 1244512);  -- Ortak Lomgok
INSERT INTO `creature_trainer` (`CreatureID`,`TrainerID`,`MenuID`,`OptionID`) SELECT 244512,1244512,0,0 FROM DUAL
  WHERE EXISTS (SELECT 1 FROM `trainer` WHERE `Id` = 1244512) AND NOT EXISTS (SELECT 1 FROM `creature_trainer` WHERE `CreatureID` = 244512);
UPDATE `creature_template` SET `npcflag` = `npcflag` | 80 WHERE `entry` = 267000 AND (`npcflag` & 80) <> 80
  AND EXISTS (SELECT 1 FROM `trainer` WHERE `Id` = 1267000);  -- Paige
INSERT INTO `creature_trainer` (`CreatureID`,`TrainerID`,`MenuID`,`OptionID`) SELECT 267000,1267000,0,0 FROM DUAL
  WHERE EXISTS (SELECT 1 FROM `trainer` WHERE `Id` = 1267000) AND NOT EXISTS (SELECT 1 FROM `creature_trainer` WHERE `CreatureID` = 267000);
