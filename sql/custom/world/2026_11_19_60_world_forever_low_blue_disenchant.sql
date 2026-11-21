-- WoW Forever: blue (rare) weapons and armour of item level 5-20 disenchant into an empty loot window.
-- The Forever client's ItemDisenchantLoot gives low rare items their own ids, new in Forever:
--   335 armour 5-15, 336 armour 16-20, 337 weapons 16-20, 338 weapons 5-15.
-- The world database has no disenchant_loot_template rows for them, so the cast works and nothing drops
-- (about 90 items: Blackened Defias Leggings, Cavedweller Bracers, Robe of Evocation, Magefist Gloves ...).
-- Loot: Small Glimmering Shard (10978), 100%, 1, the same as the next band up (rare item level 21-25, ids 9 and 10)
-- and what Classic gave for low blues. No source lists Forever's own rows for 335-338, so this follows those rows.
-- Found by Everlake (buildthehomelab/wow-trinitycore-everlake, GPL). Safe to run again.
DELETE FROM `disenchant_loot_template` WHERE `Entry` IN (335,336,337,338);
INSERT INTO `disenchant_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(335,0,10978,100,0,1,1,1,1,'Rare armour, item level 5-15 - Small Glimmering Shard'),
(336,0,10978,100,0,1,1,1,1,'Rare armour, item level 16-20 - Small Glimmering Shard'),
(337,0,10978,100,0,1,1,1,1,'Rare weapon, item level 16-20 - Small Glimmering Shard'),
(338,0,10978,100,0,1,1,1,1,'Rare weapon, item level 5-15 - Small Glimmering Shard');
