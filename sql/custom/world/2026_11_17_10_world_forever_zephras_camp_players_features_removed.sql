-- Overlapping objects at Raan Wildwind's camp, Zephras Isle (map 2991; Discord 6_1_8_8_1 "Bugs 3" item 4, 2026-11-16: glowing Mana
-- Wells inside a chair and a crate). The Forever sniff of 10 Oct (2026_10_01_03) saved nine camp features standing round the camping
-- trainer's fire as world objects: three Mana Wells, a First Aid Kit, an Incense Candle, a Lodestone, a Faction Banner and two
-- Chairs. On live these are the features players place with the camping spells (Camp Chair 1307229, Mana Well 1307259, ...): one
-- player can have one Mana Well, yet three stood here, each turned a different way, one inside the First Aid Kit. They are the
-- sniffing players' own camps, not the trainer's. No other camp in the world has any of them; the other seven Basic Campfires stand
-- alone. They go; the trainer's campfire 21100460 stays. INFERRED from the above (no live view of an empty camp). Safe to run again.
DELETE FROM `gameobject` WHERE `map` = 2991 AND `guid` IN (21100559, 21100560, 21100561, 21100918, 21100919, 21100920, 21100921, 21100922, 21100923)
  AND `id` IN (612275, 612351, 651948, 651953, 651955, 651956);
