-- Skyborne start zone (map 2991): "Vulgara the Insatiable does not drop its head" (Discord bug-report 2026-11-20, Blubu,
-- post 1573336753987653682). Vulgara's Head 257942 (WANTED: Vulgara the Insatiable 93318, needs 1) came from the 70124
-- sniff at 66.67 % ("2 of 3 kills"), and Shriekling Matriarch's Head 257107 (The Missing Scholar 92850, needs 1) at 50 %
-- ("1 of 2 kills"). Both are the one quest item of a single named creature (one spawn each); a kill by a sniffer without
-- the quest shows no quest drop, which is what the small counts mean. A player on the quest gets the head every kill.
-- Only these two rows: the other sniff quest drops below 100 % come from common mobs with real drop rates.
-- Safe to run again.

UPDATE `creature_loot_template` SET `Chance` = 100, `Comment` = 'quest head, every kill on the quest (sniff: 2 of 3 kills)'
WHERE `Entry` = 254589 AND `Item` = 257942 AND `QuestRequired` = 1;

UPDATE `creature_loot_template` SET `Chance` = 100, `Comment` = 'quest head, every kill on the quest (sniff: 1 of 2 kills)'
WHERE `Entry` = 253283 AND `Item` = 257107 AND `QuestRequired` = 1;
