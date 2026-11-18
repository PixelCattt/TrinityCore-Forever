-- Classic 1.60 (WoW Forever): Scourge Invasion scripts, saved world states and gossip text.
-- Script code: src/server/scripts/Custom/Classic/world/classic_world_event_scourge_invasion.cpp (port of VMaNGOS
-- scourge_invasion.cpp and the ScourgeInvasionEvent part of HardcodedEvents.cpp, GPL-2).

-- realm wide world states (no map ids), saved in characters.world_state_value
-- 2219 battles won and 2259-2264 / 2279-2284 (zone invaded / necropolises left) are the client's own world states
-- 17000000+ are internal to the script (next attack times, last attacked zone, GM switch), the client ignores them
DELETE FROM `world_state` WHERE `ID` IN (2219,2259,2260,2261,2262,2263,2264,2279,2280,2281,2282,2283,2284,
    17000001,17000002,17000004,17000016,17000046,17000139,17000440,17000618,17101497,17101519);
INSERT INTO `world_state` (`ID`,`DefaultValue`,`MapIDs`,`AreaIDs`,`ScriptName`,`Comment`) VALUES
(2219,0,NULL,NULL,'','Scourge Invasion: battles won'),
(2259,0,NULL,NULL,'','Scourge Invasion: Winterspring invaded'),
(2260,0,NULL,NULL,'','Scourge Invasion: Azshara invaded'),
(2261,0,NULL,NULL,'','Scourge Invasion: Blasted Lands invaded'),
(2262,0,NULL,NULL,'','Scourge Invasion: Burning Steppes invaded'),
(2263,0,NULL,NULL,'','Scourge Invasion: Tanaris invaded'),
(2264,0,NULL,NULL,'','Scourge Invasion: Eastern Plaguelands invaded'),
(2279,0,NULL,NULL,'','Scourge Invasion: Azshara necropolises left'),
(2280,0,NULL,NULL,'','Scourge Invasion: Blasted Lands necropolises left'),
(2281,0,NULL,NULL,'','Scourge Invasion: Burning Steppes necropolises left'),
(2282,0,NULL,NULL,'','Scourge Invasion: Eastern Plaguelands necropolises left'),
(2283,0,NULL,NULL,'','Scourge Invasion: Tanaris necropolises left'),
(2284,0,NULL,NULL,'','Scourge Invasion: Winterspring necropolises left'),
(17000001,0,NULL,NULL,'','Scourge Invasion (script): last zone won'),
(17000002,0,NULL,NULL,'','Scourge Invasion (script): .scourge on/off switch, 0 = config, 1 = on, 2 = off'),
(17000004,0,NULL,NULL,'','Scourge Invasion (script): next attack time, Blasted Lands'),
(17000016,0,NULL,NULL,'','Scourge Invasion (script): next attack time, Azshara'),
(17000046,0,NULL,NULL,'','Scourge Invasion (script): next attack time, Burning Steppes'),
(17000139,0,NULL,NULL,'','Scourge Invasion (script): next attack time, Eastern Plaguelands'),
(17000440,0,NULL,NULL,'','Scourge Invasion (script): next attack time, Tanaris'),
(17000618,0,NULL,NULL,'','Scourge Invasion (script): next attack time, Winterspring'),
(17101497,0,NULL,NULL,'','Scourge Invasion (script): next attack time, Undercity'),
(17101519,0,NULL,NULL,'','Scourge Invasion (script): next attack time, Stormwind');

-- creature scripts
UPDATE `creature_template` SET `ScriptName` = 'classic_si_mouth' WHERE `entry` = 16995;
UPDATE `creature_template` SET `ScriptName` = 'classic_si_necropolis' WHERE `entry` IN (16401,16398,16386);
UPDATE `creature_template` SET `ScriptName` = 'classic_si_necropolis_health' WHERE `entry` = 16421;
UPDATE `creature_template` SET `ScriptName` = 'classic_si_necrotic_shard' WHERE `entry` IN (16136,16172);
UPDATE `creature_template` SET `ScriptName` = 'classic_si_cultist_engineer' WHERE `entry` = 16230;
UPDATE `creature_template` SET `ScriptName` = 'classic_si_minion' WHERE `entry` IN (16141,16298,16299,14697,16379,16380,16143,16383);
UPDATE `creature_template` SET `ScriptName` = 'classic_si_argent_emissary' WHERE `entry` = 16285;
UPDATE `creature_template` SET `ScriptName` = 'classic_si_pallid_horror' WHERE `entry` IN (16394,16382);
-- the cultist (8 runes) and the emissary are talked to
UPDATE `creature_template` SET `npcflag` = `npcflag` | 1 WHERE `entry` IN (16230,16285);

-- object scripts
UPDATE `gameobject_template` SET `ScriptName` = 'classic_si_go_circle' WHERE `entry` = 181136;
UPDATE `gameobject_template` SET `ScriptName` = 'classic_si_go_necropolis' WHERE `entry` IN (181154,181373,181374,181215,181223,181172);

-- gossip text (VMaNGOS npc_text id = BroadcastText id). INSERT IGNORE keeps a row dev already has.
-- 8481 is not in our VMaNGOS extract: 12200 is the id between its neighbours (8480 = 12199, 8482 = 12202), check in game.
INSERT IGNORE INTO `npc_text` (`ID`,`Probability0`,`BroadcastTextID0`,`VerifiedBuild`) VALUES
(8434,1,12109,0),
(8436,1,12111,0),
(8471,1,12180,0),
(8486,1,12209,0),
(8573,1,12435,0),
(8480,1,12199,0),
(8481,1,12200,0),
(8482,1,12202,0),
(8483,1,12204,0),
(8484,1,12206,0),
(8593,1,12474,0),
(8594,1,12475,0),
(8551,1,12399,0),
(8554,1,12402,0),
(8555,1,12403,0),
(8525,1,12299,0),
(8526,1,12300,0),
(8527,1,12301,0);
