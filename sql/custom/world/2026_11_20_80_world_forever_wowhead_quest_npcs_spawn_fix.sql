-- WoW Forever: fixes for 2026_11_20_77 (Wowhead quest NPCs, spawns 47600000-47600069). Safe to run again.
-- 1. Those spawn rows set npcflag, unit_flags* and curHealthPct to 0/100. On this core a non-NULL spawn value replaces the
--    template's, so quest givers lost their quest markers and the invisible kill-credit helpers lost "not selectable".
--    NULL means "use the template".
UPDATE `creature` SET `npcflag`=NULL,`unit_flags`=NULL,`unit_flags2`=NULL,`unit_flags3`=NULL,`curHealthPct`=NULL WHERE `guid` BETWEEN 47600000 AND 47600069;
-- 2. Faction: five friendly NPCs got a stock faction from Wowhead's reaction; our world has a same-name NPC with its real faction.
--    Cross-checked with Everlake world-data (GPL-3.0) file 988, which picks the same five.
UPDATE `creature_template` SET `faction`=124  WHERE `entry`=222478 AND `VerifiedBuild`=-1; -- Sentinel Keldara Sunblade
UPDATE `creature_template` SET `faction`=133  WHERE `entry`=254357 AND `VerifiedBuild`=-1; -- Khan Jehn
UPDATE `creature_template` SET `faction`=15   WHERE `entry`=260271 AND `VerifiedBuild`=-1; -- Sully McCleary
UPDATE `creature_template` SET `faction`=1630 WHERE `entry`=266593 AND `VerifiedBuild`=-1; -- Sergeant Danneth
UPDATE `creature_template` SET `faction`=474  WHERE `entry`=270727 AND `VerifiedBuild`=-1; -- Gizzix Grimegurgle
-- 3. No double NPCs: where Everlake file 988 (guids 920012000-920012999) already spawned the same NPC, drop our spawn.
DELETE c FROM `creature` c JOIN `creature` e ON e.`id`=c.`id` AND e.`guid` BETWEEN 920012000 AND 920012999
WHERE c.`guid` BETWEEN 47600000 AND 47600069;
