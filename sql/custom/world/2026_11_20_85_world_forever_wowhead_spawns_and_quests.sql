-- WoW Forever: spawns for quest NPCs and quest objects from files 77 and 83 that had a Wowhead map spot but no known height.
-- Height read on the dev server from its own maps and vmaps (ground under the spot; where there are several floors, the one
-- nearest our other spawns there). Same spot rules as file 77; respawn 120 s (300 s and 5 yd wander for hostile mobs).
-- An NPC already spawned elsewhere (for example by Everlake) is not spawned twice. Safe to run again.
DELETE FROM `creature` WHERE `guid` BETWEEN 47600070 AND 47600199;
DELETE FROM `gameobject` WHERE `guid` BETWEEN 47500200 AND 47500299;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) SELECT 47600070,221471,0,0,0,'0',0,0,0,-1,0,0,-10638.30,-392.50,103.21,0,120,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,-1 FROM DUAL WHERE EXISTS (SELECT 1 FROM `creature_template` WHERE `entry`=221471) AND NOT EXISTS (SELECT 1 FROM `creature` WHERE `id`=221471 AND `guid` NOT BETWEEN 47600070 AND 47600199); -- Field Captain Palandar
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) SELECT 47600071,260271,1,0,0,'0',0,0,0,-1,0,0,-3517.20,-4303.40,6.37,0,120,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,-1 FROM DUAL WHERE EXISTS (SELECT 1 FROM `creature_template` WHERE `entry`=260271) AND NOT EXISTS (SELECT 1 FROM `creature` WHERE `id`=260271 AND `guid` NOT BETWEEN 47600070 AND 47600199); -- Sully McCleary
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) SELECT 47600072,236770,1,0,0,'0',0,0,0,-1,0,0,4618.20,-6472.20,115.98,0,120,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,-1 FROM DUAL WHERE EXISTS (SELECT 1 FROM `creature_template` WHERE `entry`=236770) AND NOT EXISTS (SELECT 1 FROM `creature` WHERE `id`=236770 AND `guid` NOT BETWEEN 47600070 AND 47600199); -- Korsa
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) SELECT 47600073,228619,0,0,0,'0',0,0,0,-1,0,0,2441.60,-2574.20,156.34,0,120,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,-1 FROM DUAL WHERE EXISTS (SELECT 1 FROM `creature_template` WHERE `entry`=228619) AND NOT EXISTS (SELECT 1 FROM `creature` WHERE `id`=228619 AND `guid` NOT BETWEEN 47600070 AND 47600199); -- Orthas
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) SELECT 47600074,218160,0,0,0,'0',0,0,0,-1,0,0,-8565.70,878.50,106.52,0,120,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,-1 FROM DUAL WHERE EXISTS (SELECT 1 FROM `creature_template` WHERE `entry`=218160) AND NOT EXISTS (SELECT 1 FROM `creature` WHERE `id`=218160 AND `guid` NOT BETWEEN 47600070 AND 47600199); -- Aeonas the Vindicated
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) SELECT 47600075,229018,0,0,0,'0',0,0,0,-1,0,0,1587.80,-3245.40,86.14,0,120,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,-1 FROM DUAL WHERE EXISTS (SELECT 1 FROM `creature_template` WHERE `entry`=229018) AND NOT EXISTS (SELECT 1 FROM `creature` WHERE `id`=229018 AND `guid` NOT BETWEEN 47600070 AND 47600199); -- Rotting Dwarf Corpse
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) SELECT 47600076,214529,0,0,0,'0',0,0,0,-1,0,0,-18.10,-1038.90,53.00,0,120,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,-1 FROM DUAL WHERE EXISTS (SELECT 1 FROM `creature_template` WHERE `entry`=214529) AND NOT EXISTS (SELECT 1 FROM `creature` WHERE `id`=214529 AND `guid` NOT BETWEEN 47600070 AND 47600199); -- Brave Stonetorch
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) SELECT 47600077,217957,0,0,0,'0',0,0,0,-1,0,0,-6331.50,1286.30,28.12,0,120,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,-1 FROM DUAL WHERE EXISTS (SELECT 1 FROM `creature_template` WHERE `entry`=217957) AND NOT EXISTS (SELECT 1 FROM `creature` WHERE `id`=217957 AND `guid` NOT BETWEEN 47600070 AND 47600199); -- Slain Scarlet Crusader
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) SELECT 47600078,221171,0,0,0,'0',0,0,0,-1,0,0,-11019.90,-662.50,34.22,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,-1 FROM DUAL WHERE EXISTS (SELECT 1 FROM `creature_template` WHERE `entry`=221171) AND NOT EXISTS (SELECT 1 FROM `creature` WHERE `id`=221171 AND `guid` NOT BETWEEN 47600070 AND 47600199); -- Nightmare Runner
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) SELECT 47600079,221176,0,0,0,'0',0,0,0,-1,0,0,-11001.90,-387.10,40.99,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,-1 FROM DUAL WHERE EXISTS (SELECT 1 FROM `creature_template` WHERE `entry`=221176) AND NOT EXISTS (SELECT 1 FROM `creature` WHERE `id`=221176 AND `guid` NOT BETWEEN 47600070 AND 47600199); -- Nightterror Whelp
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) SELECT 47600080,221263,1,0,0,'0',0,0,0,-1,0,0,2658.80,-3028.70,158.07,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,-1 FROM DUAL WHERE EXISTS (SELECT 1 FROM `creature_template` WHERE `entry`=221263) AND NOT EXISTS (SELECT 1 FROM `creature` WHERE `id`=221263 AND `guid` NOT BETWEEN 47600070 AND 47600199); -- Vengeful Ancient
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) SELECT 47600081,221268,1,0,0,'0',0,0,0,-1,0,0,3004.70,-3328.50,151.09,0,120,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,-1 FROM DUAL WHERE EXISTS (SELECT 1 FROM `creature_template` WHERE `entry`=221268) AND NOT EXISTS (SELECT 1 FROM `creature` WHERE `id`=221268 AND `guid` NOT BETWEEN 47600070 AND 47600199); -- Doran Dreambough
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) SELECT 47600082,221367,1,0,0,'0',0,0,0,-1,0,0,-3144.50,2162.80,32.23,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,-1 FROM DUAL WHERE EXISTS (SELECT 1 FROM `creature_template` WHERE `entry`=221367) AND NOT EXISTS (SELECT 1 FROM `creature` WHERE `id`=221367 AND `guid` NOT BETWEEN 47600070 AND 47600199); -- Wyrmkin Berserker
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) SELECT 47600083,221369,1,0,0,'0',0,0,0,-1,0,0,-3024.00,2260.20,45.34,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,-1 FROM DUAL WHERE EXISTS (SELECT 1 FROM `creature_template` WHERE `entry`=221369) AND NOT EXISTS (SELECT 1 FROM `creature` WHERE `id`=221369 AND `guid` NOT BETWEEN 47600070 AND 47600199); -- Frenzied Whelp
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) SELECT 47600084,221399,1,0,0,'0',0,0,0,-1,0,0,-2736.60,2635.80,67.34,0,120,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,-1 FROM DUAL WHERE EXISTS (SELECT 1 FROM `creature_template` WHERE `entry`=221399) AND NOT EXISTS (SELECT 1 FROM `creature` WHERE `id`=221399 AND `guid` NOT BETWEEN 47600070 AND 47600199); -- Jamniss Treemender
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) SELECT 47600085,221479,0,0,0,'0',0,0,0,-1,0,0,583.80,-3939.70,113.49,0,120,0,0,NULL,0,NULL,NULL,NULL,NULL,'',NULL,-1 FROM DUAL WHERE EXISTS (SELECT 1 FROM `creature_template` WHERE `entry`=221479) AND NOT EXISTS (SELECT 1 FROM `creature` WHERE `id`=221479 AND `guid` NOT BETWEEN 47600070 AND 47600199); -- Field Captain Korlian
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) SELECT 47600086,221933,0,0,0,'0',0,0,0,-1,0,0,106.40,-4124.30,172.25,0,300,5,0,NULL,1,NULL,NULL,NULL,NULL,'',NULL,-1 FROM DUAL WHERE EXISTS (SELECT 1 FROM `creature_template` WHERE `entry`=221933) AND NOT EXISTS (SELECT 1 FROM `creature` WHERE `id`=221933 AND `guid` NOT BETWEEN 47600070 AND 47600199); -- Moonkin Avatar
INSERT INTO `gameobject` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`,`ScriptName`,`StringId`,`VerifiedBuild`) SELECT 47500200,422911,0,0,0,'0',0,0,0,-1,-2149.30,-1633.50,-38.77,0,0,0,0,1,120,255,1,'',NULL,-1 FROM DUAL WHERE EXISTS (SELECT 1 FROM `gameobject_template` WHERE `entry`=422911); -- Sealed Barrel
INSERT INTO `gameobject` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`,`ScriptName`,`StringId`,`VerifiedBuild`) SELECT 47500201,524284,1,0,0,'0',0,0,0,-1,3472.00,-5756.80,11.65,0,0,0,0,1,120,255,1,'',NULL,-1 FROM DUAL WHERE EXISTS (SELECT 1 FROM `gameobject_template` WHERE `entry`=524284); -- Highborne Tablet
INSERT INTO `gameobject` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`,`ScriptName`,`StringId`,`VerifiedBuild`) SELECT 47500202,613761,1,0,0,'0',0,0,0,-1,-2639.40,1407.90,104.35,0,0,0,0,1,120,255,1,'',NULL,-1 FROM DUAL WHERE EXISTS (SELECT 1 FROM `gameobject_template` WHERE `entry`=613761); -- Spectral Iron Deposit
INSERT INTO `gameobject` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`,`ScriptName`,`StringId`,`VerifiedBuild`) SELECT 47500203,613764,1,0,0,'0',0,0,0,-1,-2907.20,1205.00,82.95,0,0,0,0,1,120,255,1,'',NULL,-1 FROM DUAL WHERE EXISTS (SELECT 1 FROM `gameobject_template` WHERE `entry`=613764); -- Spectral Iron Deposit
INSERT INTO `gameobject` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`,`ScriptName`,`StringId`,`VerifiedBuild`) SELECT 47500204,649094,0,0,0,'0',0,0,0,-1,-7275.00,-5053.90,63.85,0,0,0,0,1,120,255,1,'',NULL,-1 FROM DUAL WHERE EXISTS (SELECT 1 FROM `gameobject_template` WHERE `entry`=649094); -- Rock Pile

-- Quests these spawns unlock (formerly a separate file).
-- WoW Forever: quests players do on the live realm that our world did not have at all (and Everlake's open data does not
-- add either). Full live record: title, story, objective line, completion line, levels, races, flags, objectives with their
-- live ids, item/choice/reputation/money rewards, start item, next quest.
-- Quest record: Data from Efficient Games (https://efficient.games), licensed under CC BY 4.0
-- (https://creativecommons.org/licenses/by/4.0/). Source: github.com/JIVESCORP/eg-link-output-wowf quests.enUS (players' quest
-- caches) and npcs (who offered and took each quest), builds 70888-70959. Changed: picked and converted to our tables.
-- Givers, turn-ins, classes and the one previous quest also from NorgannonDB (zmarotrix/NorgannonDB, GPL-3.0, built from
-- QuestieDB GPL-3.0, pfQuest MIT and its Collector add-on).
-- Only quests whose giver (or start item), turn-in and every objective target exist and are spawned in our world are here;
-- the rest are listed in the kit's quests report with the reason they wait. Reward text is not in the data: none is set.
-- Safe to run again: every row is replaced by key.

-- 81730 Duskwood Mission I: Defeat Worgen (level 27, min 23, live build 1.60.1.70959, 2 player(s))
DELETE FROM `quest_template` WHERE `ID`=81730;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (81730,2,10,1,0,5,1.0,0,1.0,0,0,4352,0,0,0,18446744073709551615,2641,4,0,'Duskwood Mission I: Defeat Worgen','Defeat 10 Nightmare Runners and 10 Nightmare Weavers in the Duskwood Nightmare Incursion in the Rotting Orchard and return to Field Captain Palandar.','While these demons distract us here, the Emerald Dream is being corrupted into nightmare. Quick, travel through the Emerald Dream Portal in the Twilight Grove, and journey to the Nightmare Incursion in the Rotting Orchard. Defeat worgen there and return to me.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=81730;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (448713,81730,0,0,0,221171,10,0,1,NULL,70959),(448714,81730,0,1,5,221172,10,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=81730;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (81730,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=81730;
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES (81730,1700,0);
DELETE FROM `quest_classic_level` WHERE `ID`=81730;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (81730,27,23,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=81730;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (81730,2,27);
DELETE FROM `creature_queststarter` WHERE `quest`=81730;
DELETE FROM `gameobject_queststarter` WHERE `quest`=81730;
DELETE FROM `creature_questender` WHERE `quest`=81730;
DELETE FROM `gameobject_questender` WHERE `quest`=81730;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (221471,81730,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (221471,81730,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (221471);

-- 81731 Duskwood Mission II: Defeat Ogres (level 27, min 23, live build 1.60.1.70959, 2 player(s))
DELETE FROM `quest_template` WHERE `ID`=81731;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (81731,2,10,1,0,5,1.0,0,1.0,0,0,4352,0,0,0,18446744073709551615,2641,4,0,'Duskwood Mission II: Defeat Ogres','Defeat 3 Deranged Ogres and 3 Demented Fire Weavers in the Duskwood Nightmare Incursion at the Vul''gol Ogre Mound and return to Field Captain Palandar.','While these demons distract us here, the Emerald Dream is being corrupted into nightmare. Quick, travel through the Emerald Dream Portal in the Twilight Grove, and journey to the Nightmare Incursion at the Vul''gol Ogre Mound. Defeat ogres there and return to me.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=81731;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (448715,81731,0,0,1,221174,3,0,1,NULL,70959),(448716,81731,0,1,2,221175,3,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=81731;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (81731,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=81731;
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES (81731,1700,0);
DELETE FROM `quest_classic_level` WHERE `ID`=81731;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (81731,27,23,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=81731;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (81731,2,27);
DELETE FROM `creature_queststarter` WHERE `quest`=81731;
DELETE FROM `gameobject_queststarter` WHERE `quest`=81731;
DELETE FROM `creature_questender` WHERE `quest`=81731;
DELETE FROM `gameobject_questender` WHERE `quest`=81731;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (221471,81731,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (221471,81731,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (221471);

-- 81732 Duskwood Mission III: Defeat Dragonkin (level 27, min 23, live build 1.60.1.70938, 2 player(s))
DELETE FROM `quest_template` WHERE `ID`=81732;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (81732,2,10,1,0,5,1.0,0,1.0,0,0,4352,0,0,0,18446744073709551615,2641,4,0,'Duskwood Mission III: Defeat Dragonkin','Defeat 3 Wyrmkin Terrorwalkers and 10 Nightterror Whelps in the Duskwood Nightmare Incursion at the Yorgen Farmstead and return to Field Captain Palandar.','While these demons distract us here, the Emerald Dream is being corrupted into nightmare. Quick, travel through the Emerald Dream Portal in the Twilight Grove, and journey to the Nightmare Incursion at the Yorgen Farmstead. Defeat dragonkin there and return to me.','','',70938);
DELETE FROM `quest_objectives` WHERE `QuestID`=81732;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (448717,81732,0,0,0,221200,3,0,1,NULL,70938),(448718,81732,0,1,3,221176,10,0,1,NULL,70938);
DELETE FROM `quest_template_addon` WHERE `ID`=81732;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (81732,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=81732;
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES (81732,1700,0);
DELETE FROM `quest_classic_level` WHERE `ID`=81732;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (81732,27,23,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=81732;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (81732,2,27);
DELETE FROM `creature_queststarter` WHERE `quest`=81732;
DELETE FROM `gameobject_queststarter` WHERE `quest`=81732;
DELETE FROM `creature_questender` WHERE `quest`=81732;
DELETE FROM `gameobject_questender` WHERE `quest`=81732;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (221471,81732,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (221471,81732,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (221471);

-- 81745 Duskwood Mission XVI: Rescue Kroll Mountainshade (level 27, min 23, live build 1.60.1.70959, 1 player(s))
DELETE FROM `quest_template` WHERE `ID`=81745;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (81745,2,10,1,0,4,1.0,0,1.0,0,0,4352,0,0,0,18446744073709551615,2641,4,0,'Duskwood Mission XVI: Rescue Kroll Mountainshade','Rescue Kroll Mountainshade from the Duskwood Nightmare Incursion in the guest house at the Rotting Orchard and return to Field Captain Palandar.','While these demons distract us here, the Emerald Dream is being corrupted into nightmare. Quick, travel through the Emerald Dream Portal in the Twilight Grove, and journey to the Nightmare Incursion at the Rotting Orchard. Find the sleeping Druid of the Claw Kroll Mountainshade there and escort him to safety. Then return to me.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=81745;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (448737,81745,0,0,0,221210,1,0,1,'Rescue Kroll Mountainshade',70959);
DELETE FROM `quest_template_addon` WHERE `ID`=81745;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (81745,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=81745;
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES (81745,1700,0);
DELETE FROM `quest_classic_level` WHERE `ID`=81745;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (81745,27,23,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=81745;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (81745,2,27);
DELETE FROM `creature_queststarter` WHERE `quest`=81745;
DELETE FROM `gameobject_queststarter` WHERE `quest`=81745;
DELETE FROM `creature_questender` WHERE `quest`=81745;
DELETE FROM `gameobject_questender` WHERE `quest`=81745;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (221471,81745,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (221471,81745,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (221471);

-- 81746 Duskwood Mission XVII: Rescue Alara Grovemender (level 27, min 23, live build 1.60.1.70959, 2 player(s))
DELETE FROM `quest_template` WHERE `ID`=81746;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (81746,2,10,1,0,4,1.0,0,1.0,0,0,4352,0,0,0,18446744073709551615,2641,4,0,'Duskwood Mission XVII: Rescue Alara Grovemender','Rescue Alara Grovemender in the Duskwood Nightmare Incursion in the stable at the Yorgen Farmstead and return to Field Captain Palandar.','While these demons distract us here, the Emerald Dream is being corrupted into nightmare. Quick, travel through the Emerald Dream Portal in the Twilight Grove, and journey to the Nightmare Incursion at the Yorgen Darmstead. Find the sleeping Druid of the Claw Alara Grovemender there and escort her to safety. Then return to me.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=81746;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (448738,81746,0,0,1,221215,1,0,1,'Rescue Alara Grovemender',70959);
DELETE FROM `quest_template_addon` WHERE `ID`=81746;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (81746,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=81746;
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES (81746,1700,0);
DELETE FROM `quest_classic_level` WHERE `ID`=81746;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (81746,27,23,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=81746;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (81746,2,27);
DELETE FROM `creature_queststarter` WHERE `quest`=81746;
DELETE FROM `gameobject_queststarter` WHERE `quest`=81746;
DELETE FROM `creature_questender` WHERE `quest`=81746;
DELETE FROM `gameobject_questender` WHERE `quest`=81746;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (221471,81746,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (221471,81746,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (221471);

-- 81747 Duskwood Mission XVIII: Rescue Elenora Marshwalker (level 27, min 23, live build 1.60.1.70959, 3 player(s))
DELETE FROM `quest_template` WHERE `ID`=81747;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (81747,2,10,1,0,4,1.0,0,1.0,0,0,4352,0,0,0,18446744073709551615,2641,4,0,'Duskwood Mission XVIII: Rescue Elenora Marshwalker','Rescue Elenora Marshwalker in the Duskwood Nightmare Incursion in the ruins of a farmhouse near the Vul''gol Ogre Mound and return to Field Captain Palandar.','While these demons distract us here, the Emerald Dream is being corrupted into nightmare. Quick, travel through the Emerald Dream Portal in the Twilight Grove, and journey to the Nightmare Incursion at the Vul''gol Ogre Mound. Find the sleeping Druid of the Claw Elenora Marshwalker there and escort her to safety. Then return to me.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=81747;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (448739,81747,0,0,0,221216,1,0,1,'Rescue Elenora Marshwalker',70959);
DELETE FROM `quest_template_addon` WHERE `ID`=81747;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (81747,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=81747;
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES (81747,1700,0);
DELETE FROM `quest_classic_level` WHERE `ID`=81747;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (81747,27,23,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=81747;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (81747,2,27);
DELETE FROM `creature_queststarter` WHERE `quest`=81747;
DELETE FROM `gameobject_queststarter` WHERE `quest`=81747;
DELETE FROM `creature_questender` WHERE `quest`=81747;
DELETE FROM `gameobject_questender` WHERE `quest`=81747;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (221471,81747,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (221471,81747,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (221471);

-- 81762 Some Good News (level 50, min 45, live build 1.60.1.70959, 3 player(s))
DELETE FROM `quest_template` WHERE `ID`=81762;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (81762,2,-141,0,81764,3,1.0,0,1.0,0,0,0,0,0,0,6130900294268439629,'Some Good News','Speak with Katherine the Pure at the Cathedral of Light in Stormwind.','Greetings, $n. I have good news. I''ve made contact with my friend, and I am leaving soon to meet with him. What''s more, another orb has surfaced in Kalimdor.  I cannot be in two places at once so if you are willing, I''d like for you to go in my stead to follow up on this new orb. Speak with Katherine for further instructions.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=81762;
DELETE FROM `quest_template_addon` WHERE `ID`=81762;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (81762,0,2,0);
DELETE FROM `quest_classic_money` WHERE `ID`=81762;
DELETE FROM `quest_classic_level` WHERE `ID`=81762;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (81762,50,45,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=81762;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (81762,2,50);
DELETE FROM `creature_queststarter` WHERE `quest`=81762;
DELETE FROM `gameobject_queststarter` WHERE `quest`=81762;
DELETE FROM `creature_questender` WHERE `quest`=81762;
DELETE FROM `gameobject_questender` WHERE `quest`=81762;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (218160,81762,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (5492,81762,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (5492,218160);

-- 84318 Oi! (level 57, min 54, live build 1.60.1.70959, 2 player(s))
DELETE FROM `quest_template` WHERE `ID`=84318;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (84318,2,-141,0,84319,5,1.0,0,1.0,0,227687,0,0,0,0,18446744073709551615,'Oi!','Find Orthas'' missing hammer in Corrin''s Crossing.','Oi! $c! Yes, ye! Ye did me a solid by smashing up that depressin'' mess of a meatsuit I''ve been riding in all these years, but I dinnae feel much of a pull to move on. I''m expectin'' it''s because I got some "Unfinished Business" to get up to ''afore I can be on me way. Well dull-wit, ye just been conscripted to help!

I need ye to fetch me hammer. Should be somewhere in Corrin''s Crossing and it''ll be hard to miss. 

Oi, take this too. It''s me favorite gold tooth. Give it a rub when you''ve found me weapon.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=84318;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (452327,84318,1,0,0,227686,1,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=84318;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (84318,0,2,0);
DELETE FROM `quest_classic_money` WHERE `ID`=84318;
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES (84318,15750,0);
DELETE FROM `quest_classic_level` WHERE `ID`=84318;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (84318,57,54,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=84318;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (84318,2,57);
DELETE FROM `creature_queststarter` WHERE `quest`=84318;
DELETE FROM `gameobject_queststarter` WHERE `quest`=84318;
DELETE FROM `creature_questender` WHERE `quest`=84318;
DELETE FROM `gameobject_questender` WHERE `quest`=84318;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (228619,84318,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (228619,84318,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (228619);

-- 86777 Master Feardred (level 53, min 47, live build 1.60.1.70959, 2 player(s))
DELETE FROM `quest_template` WHERE `ID`=86777;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (86777,2,16,0,86797,5,1.0,0,1.0,0,0,36700168,0,0,0,18446744073709551615,259892,1,260166,1,260167,1,576,5,0,'Master Feardred','Kill Master Feardred, and bring his amulet to Korsa.','Many satyr corrupt Azshara, but none are as terrible as the Legashi. Led by Varrox Bleakhoof, their camps litter the northern peninsula. They have driven us from our homes, and I fear they will ransack Ursolan before long.

We must strike back if we are to have any chance of survival.

Master Feardred, a servant of Varrox, oversees a nearby camp to the south. You can see it from here. Feardred is a key target in weakening Varrox''s forces. Kill him, and bring me his amulet.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=86777;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (457386,86777,1,0,0,235334,1,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=86777;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (86777,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=86777;
DELETE FROM `quest_classic_level` WHERE `ID`=86777;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (86777,53,47,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=86777;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (86777,2,53);
DELETE FROM `creature_queststarter` WHERE `quest`=86777;
DELETE FROM `gameobject_queststarter` WHERE `quest`=86777;
DELETE FROM `creature_questender` WHERE `quest`=86777;
DELETE FROM `gameobject_questender` WHERE `quest`=86777;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (236770,86777,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (236770,86777,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (236770);

-- 88884 Highborne Tablets (level 52, min 47, live build 1.60.1.70959, 1 player(s))
DELETE FROM `quest_template` WHERE `ID`=88884;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (88884,2,16,0,89037,5,1.0,0,1.0,0,0,36700168,0,0,0,6130900294268439629,'Highborne Tablets','Find the three highborne tablets among the ruins of Southridge Beach, then bring them to Saria Fairmoon in Azshara.','Just south of here, along the beach, there are some tablets of highborne writing. They document the highborne''s investigations into the laws and powers of the arcane. 

The tablets are being kept in pagoda-like structures, guarded by naga, so I wouldn''t dare attempt to procure them myself.

Fortunately, I''ve found myself a new assistant! 

So, what do you say? Think you could be of further use in the pursuit of knowledge?','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=88884;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (459187,88884,1,0,0,238244,1,0,1,NULL,70959),(459188,88884,1,1,3,238245,1,0,1,NULL,70959),(459189,88884,1,2,4,238246,1,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=88884;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (88884,0,0,88917);
DELETE FROM `quest_classic_money` WHERE `ID`=88884;
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES (88884,10200,0);
DELETE FROM `quest_classic_level` WHERE `ID`=88884;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (88884,52,47,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=88884;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (88884,2,52);
DELETE FROM `creature_queststarter` WHERE `quest`=88884;
DELETE FROM `gameobject_queststarter` WHERE `quest`=88884;
DELETE FROM `creature_questender` WHERE `quest`=88884;
DELETE FROM `gameobject_questender` WHERE `quest`=88884;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (239831,88884,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (239831,88884,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (239831);

-- 95198 The Return of the King? (level 53, min 48, live build 1.60.1.70938, 3 player(s))
DELETE FROM `quest_template` WHERE `ID`=95198;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (95198,2,15,0,95262,2,1.0,0,1.0,1285371,269000,0,0,0,0,6130900294268439629,72,5,0,'The Return of the King?','Use the SI:7 Disguise Kit to eavesdrop on Jaina and her inner circle at the Theramore Mage Tower.','Take this. It''s a handy bit o'' glamour that the mages back home put together to make a quick disguise. It''ll make you look like a Kul Tiras Marine which should do nicely for this mission.

Sneak in to the tower and do yer best to listen for any mention of the man that washed up on the beach. I warn you though, do not get too close to Jaina. She will see right through this disguise. 

Come back and see me if you lose your disguise, I''ll set you up with a new one.','','',70938);
DELETE FROM `quest_objectives` WHERE `QuestID`=95198;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (470485,95198,0,0,0,260146,1,0,1,'Relieve Jaina''s guard and eavesdrop',70938),(470486,95198,1,1,1,269000,1,0,1,NULL,70938);
DELETE FROM `quest_template_addon` WHERE `ID`=95198;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (95198,0,0,95196);
DELETE FROM `quest_classic_money` WHERE `ID`=95198;
DELETE FROM `quest_classic_level` WHERE `ID`=95198;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (95198,53,48,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=95198;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (95198,2,53);
DELETE FROM `creature_queststarter` WHERE `quest`=95198;
DELETE FROM `gameobject_queststarter` WHERE `quest`=95198;
DELETE FROM `creature_questender` WHERE `quest`=95198;
DELETE FROM `gameobject_questender` WHERE `quest`=95198;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (260271,95198,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (260271,95198,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (260271);

-- 97270 Brawl at the Maul (level 60, min 55, live build 1.60.1.70959, 2 player(s))
DELETE FROM `quest_template` WHERE `ID`=97270;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (97270,2,3217,41,0,1,1.0,0,1.0,0,277556,0,1,0,0,18446744073709551615,'Brawl at the Maul','Speak with Griniblix the Spectator above the Maul in Dire Maul.','There must be more to the Maul than this!

Perhaps the loud Spectator who oversees the event at Dire Maul will know!','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=97270;
DELETE FROM `quest_template_addon` WHERE `ID`=97270;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (97270,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=97270;
DELETE FROM `quest_classic_level` WHERE `ID`=97270;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (97270,60,55,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=97270;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (97270,2,60);
DELETE FROM `creature_queststarter` WHERE `quest`=97270;
DELETE FROM `gameobject_queststarter` WHERE `quest`=97270;
DELETE FROM `creature_questender` WHERE `quest`=97270;
DELETE FROM `gameobject_questender` WHERE `quest`=97270;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (14395,97270,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (14395);

-- 97420 Reduce, Reuse, Reconcile (level 36, min 31, live build 1.60.1.70959, 1 player(s))
DELETE FROM `quest_template` WHERE `ID`=97420;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (97420,2,33,0,0,5,1.0,0,1.0,0,0,36700168,0,0,0,6130900294268439629,'Reduce, Reuse, Reconcile','Acquire $1oa Drums of Crude Oil from the Venture Co. operations at Lake Nazferiti, then return to Knaz Blunderflame in Stranglethorn Vale.','I have a favor to ask of someone, and you look helpful!

You see this baby here? Ain''t she a beaut? This is my newest racer, designed and built all by myself, because SOMEONE wouldn''t help. I plan on taking this to the races in Thousand Needles, but it needs a little extra kick.

Now, I''m too handsome to be a goblin, and I know better than to trust their tech, but I know the Venture Co struck liquid gold over at the lake. I''m sure they won''t mind if you, erm, borrowed some? They won''t even notice!','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=97420;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (475892,97420,1,0,0,277986,4,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=97420;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (97420,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=97420;
DELETE FROM `quest_classic_level` WHERE `ID`=97420;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (97420,36,31,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=97420;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (97420,2,36);
DELETE FROM `creature_queststarter` WHERE `quest`=97420;
DELETE FROM `gameobject_queststarter` WHERE `quest`=97420;
DELETE FROM `creature_questender` WHERE `quest`=97420;
DELETE FROM `gameobject_questender` WHERE `quest`=97420;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (2687,97420,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (2687,97420,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (2687);

-- 98462 Shroud of the Winter Wilds (level 60, min 55, live build 1.60.1.70938, 1 player(s))
DELETE FROM `quest_template` WHERE `ID`=98462;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardItem1`,`RewardAmount1`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (98462,2,618,0,0,0,1.0,0,1.0,0,0,0,0,0,0,18446744073709551615,281234,1,'Shroud of the Winter Wilds','Bring $1oa Chillwind Chimaera Fur and $2oa Winterspring Owl Feathers to Evie Whirlbrew.','Back for more, eh? You know the drill! Bring me some Chillwind Chimaera Fur and Winterspring Owl Feathers, and I''ll use the ingredients to mix up a shrouding potion that''ll help to conceal you from the eyes of the creatures living around here.','','',70938);
DELETE FROM `quest_objectives` WHERE `QuestID`=98462;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (477799,98462,1,0,0,281241,5,0,1,NULL,70938),(477800,98462,1,1,1,281242,5,0,1,NULL,70938);
DELETE FROM `quest_template_addon` WHERE `ID`=98462;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (98462,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=98462;
DELETE FROM `quest_classic_level` WHERE `ID`=98462;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (98462,60,55,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=98462;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (98462,2,60);
DELETE FROM `creature_queststarter` WHERE `quest`=98462;
DELETE FROM `gameobject_queststarter` WHERE `quest`=98462;
DELETE FROM `creature_questender` WHERE `quest`=98462;
DELETE FROM `gameobject_questender` WHERE `quest`=98462;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (11188,98462,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (11188,98462,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (11188);

-- 99233 Brawl at the Maul (level 60, min 55, live build 1.60.1.70959, 1 player(s))
DELETE FROM `quest_template` WHERE `ID`=99233;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (99233,2,3217,41,0,1,1.0,0,1.0,0,277557,0,1,0,0,18446744073709551615,'Brawl at the Maul','Speak with Griniblix the Spectator above the Maul in Dire Maul.','There must be more to the Maul than this!

Perhaps the loud Spectator who oversees the event at Dire Maul will know!','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=99233;
DELETE FROM `quest_template_addon` WHERE `ID`=99233;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (99233,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=99233;
DELETE FROM `quest_classic_level` WHERE `ID`=99233;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (99233,60,55,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=99233;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (99233,2,60);
DELETE FROM `creature_queststarter` WHERE `quest`=99233;
DELETE FROM `gameobject_queststarter` WHERE `quest`=99233;
DELETE FROM `creature_questender` WHERE `quest`=99233;
DELETE FROM `gameobject_questender` WHERE `quest`=99233;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (14395,99233,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (14395);

