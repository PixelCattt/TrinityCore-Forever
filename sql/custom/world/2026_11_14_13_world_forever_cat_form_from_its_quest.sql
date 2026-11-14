-- Druids could buy Cat Form at the trainer at level 20 before doing its quest (Discord, 6_1_8_8_1, 2026-11-14, 0.1.36).
-- On Forever, Cat Form, Prowl, Claw and Rip (rank 1) come only from the Great Cat Spirit chain: To Darnassus (98397) and To Thunder
-- Bluff (98362) reward spell 1309050, which teaches 768, 5215, 1082 and 1079. No live druid trainer sells any of the four
-- (EG Link trainers 70790-70862: the trainers start at Claw 3029 and Rip 9492, level 28; data from Efficient Games
-- (https://efficient.games), licensed under CC BY 4.0). 2026_10_16_08 had put them on the shared druid list 17.
-- Druids who already bought them keep them. Bots learn class quest spells from the quest data, so they still get them.
-- Safe to run again.
DELETE FROM `trainer_spell` WHERE `SpellId` IN (768, 5215, 1082, 1079);
