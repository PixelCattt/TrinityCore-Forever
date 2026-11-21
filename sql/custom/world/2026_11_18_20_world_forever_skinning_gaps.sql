-- Skinning: 20 creatures that live skins had no skinning loot here (SkinLootID 0 from the Forever data restore and the
-- sniff imports, or a retail id with no rows), so they could not be skinned. Evidence: skinning windows recorded on live,
-- builds 70205-70959 (EG Link loot data, Efficient Games, CC BY 4.0), count per creature below.
-- Each gets the vanilla skinning table of a beast of its level (the same leather the live windows showed), the way
-- 2026_10_05_00 gave the Zephras beasts table 118: 1765/3100 (level 9-10), 3244 (11-12), 3255 (15), 13360001 (25-29,
-- from 2026_11_05_99), 4124 (28), 2408 (30), 772 (37-38), 2729 (38-40), 1087 (41-42). No skinning table is changed.
-- Safe to run again.
UPDATE `creature_template_difficulty` SET `SkinLootID` = CASE `Entry`
    WHEN 260157 THEN 1765       -- Elder Snow Leopard (9-10), Dun Morogh: 4 windows
    WHEN 268530 THEN 3100       -- Bloodtalon Matriarch (9), Durotar: 5
    WHEN 276189 THEN 1765       -- Matriarch Bristlefur (10), Elwynn Forest: 1
    WHEN 266852 THEN 3244       -- Halikor (12): 1
    WHEN 277882 THEN 3244       -- Foothills Duskbat (12): 1
    WHEN 270693 THEN 3255       -- Daggerfang (15), Westfall: 1
    WHEN 260796 THEN 13360001   -- Marsh Crocolisk (25-28): 7
    WHEN 260810 THEN 13360001   -- Highland Snapper (25-28): 2
    WHEN 271732 THEN 13360001   -- Thicket Stalker (25-28): 1
    WHEN 260325 THEN 13360001   -- Shadetooth (29): 1
    WHEN 10882  THEN 4124       -- Arikara (28), Thousand Needles: 1
    WHEN 270094 THEN 2408       -- Stormheart (30): 2
    WHEN 257017 THEN 772        -- Twilight Worg (37-38): 2
    WHEN 263343 THEN 772        -- Low Plains Buzzard (37-38): 19
    WHEN 263348 THEN 772        -- Roving Tallstrider (37-38): 13
    WHEN 259046 THEN 2729       -- Freshwater Crocolisk (38-39): 4
    WHEN 259269 THEN 2729       -- High Plains Buzzard (38-39): 2
    WHEN 262473 THEN 2729       -- Cinderscale Whelp (39-40): 10
    WHEN 262477 THEN 1087       -- Cinderscale Warrior (41-42): 6
    WHEN 263380 THEN 1087       -- Ghostmaw (42): 1
    ELSE `SkinLootID` END
WHERE `DifficultyID` = 0 AND `Entry` IN (260157,268530,276189,266852,277882,270693,260796,260810,271732,260325,10882,270094,
    257017,263343,263348,259046,259269,262473,262477,263380);
