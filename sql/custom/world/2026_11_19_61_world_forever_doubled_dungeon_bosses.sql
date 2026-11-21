-- Two dungeon bosses that could stand twice.
--
-- Witherfang 250483 (Ruins of Lordaeron, first boss): the sniff spawn 21300000 (2026_10_11_01) walks patrol path 213000000.
-- 2026_10_27_70 added 43000408, the same boss caught mid-patrol at 1688.9, 54.9 (on that path, 56 yd from the sniff spawn,
-- so the import's distance checks missed it). Both stood in the dungeon and only the first kill gave loot, because that kill
-- ends the encounter. The import's copy goes.
--
-- Deathsworn Captain 3872 (Shadowfang Keep): two pools on one spot each rolled Captain or Tormented Officer 3873, so some
-- runs had two Captains. TrinityCore's pool 1601 (Captain 30%, Officer 70%) stays; the VMaNGOS inline pool 1018183 from
-- 2026_09_27_00 (spawns 20018183 and 25072732, both at -185.5, 2140.0) goes.
--
-- Found by Everlake (buildthehomelab/wow-trinitycore-everlake, GPL). Safe to run again.
DELETE FROM `creature_addon` WHERE `guid` IN (43000408, 20018183, 25072732);
DELETE FROM `creature` WHERE `guid` = 43000408 AND `id` = 250483 AND `map` = 2999;
DELETE FROM `creature` WHERE `guid` = 20018183 AND `id` = 3872 AND `map` = 33;
DELETE FROM `creature` WHERE `guid` = 25072732 AND `id` = 3873 AND `map` = 33;
DELETE FROM `pool_members` WHERE `type` = 0 AND `spawnId` IN (20018183, 25072732) AND `poolSpawnId` = 1018183;
DELETE FROM `pool_template` WHERE `entry` = 1018183;
