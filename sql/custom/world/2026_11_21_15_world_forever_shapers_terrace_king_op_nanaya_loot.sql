-- WoW Forever: The Shaper's Terrace (map 3001) boss drops that were missing, from the live realm's drop counts (seen 2026-11-20):
--  * King Op (261993) had no drop list (2026_11_19_72 listed no boss item for him), so he dropped gold only. Live: 280026 Albinofur
--    Grips 3 of 6 kills and 280027 Crownroar Chestplate 3 of 6: one of the two each kill.
--  * Nanaya (261809) also drops 273116 Blueprint: Arcane Forge (7 of 227 kills, 3.1%) and 273128 Maker's Spark (216 of 227, 95%; a
--    stack of 1, 2 or 3 about equally often). Both are in the client's item data. These were held in 2026_11_19_72 as not in our
--    hotfixes; they need none.
-- Her boss item roll (group 1) stays as it is. Safe to run again.

DELETE FROM `creature_loot_template` WHERE `Entry`=261993 AND `Item` IN (280026,280027);
DELETE FROM `creature_loot_template` WHERE `Entry`=261809 AND `Item` IN (273116,273128);
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(261993,0,280026,50,0,1,1,1,1,'King Op: Albinofur Grips, one of his two items each kill (live: 3 of 6)'),
(261993,0,280027,50,0,1,1,1,1,'King Op: Crownroar Chestplate, one of his two items each kill (live: 3 of 6)'),
(261809,0,273116,3.1,0,1,0,1,1,'Nanaya: Blueprint: Arcane Forge (live: 7 of 227)'),
(261809,0,273128,95,0,1,0,1,3,'Nanaya: Maker''s Spark, 1-3 (live: 216 of 227)');
