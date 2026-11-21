-- WoW Forever: Alcaz Prison (map 2994, levels 50-55) made playable: instance, way in and out, trash and boss spawns,
-- trash abilities and boss loot. The fights are in classic_instance_alcaz_prison.cpp. Needs 2026_11_14_40 (the templates).
-- From Everlake's Forever dungeon work (github.com/buildthehomelab, GPL): Blazeroar's model (149885), level (55) and
-- disguise (Zarla Ober 255707, model 139053), the Molten Servitor (255366, model 1070), and who stands with which boss
-- (Strashaz Enchantresses with Ca'zass, Alcaz Chaplains with Katerina, Alcaz Jailers with the Questioner). Every spot
-- below is ours, on our navmesh.
-- No sniff or combat log of this dungeon exists yet. What is real data and what is a guess:
--  * real (70938 client files): the map and its navmesh (every spawn below sits on the one navmesh piece the whole
--    prison is on, and every boss can be walked to from the landing), the zone (Alcaz Prison 16620), the encounter list
--    and order (DungeonEncounter 3403 Overseer Wrex, 3410 Tidemistress Ca'zass, 3418 Katerina the Cleaner, 3415 The
--    Questioner, 3409 Blazeroar), the spells used (all in the client).
--  * real (players' caches, live realm): the boss and trash templates (2026_11_14_40), the boss loot items (276732-276746,
--    already in our hotfixes; item level splits them three to a boss: 52 Wrex, 52 Ca'zass, 54 Katerina, 53 Questioner,
--    55 Blazeroar) and the Alcaz trash items (287017-287026). Blazeroar's id (255702) is from the Alcaz Spelunker
--    achievement criteria.
--  * from the dungeon's quests (live quest records): Strashaz Soldiers and Enchantresses are in the prison (A Bit of Wet
--    Work asks for 15 and 8, so there are 16 and 9); Ca'zass carries her head, The Questioner the shackle key, the
--    human guards the Blood Red Bandanas, the dragon Zarla's journal; Mason Connery is held in a ball and chain and
--    speaks to you after the dragon; a Kor'kron commander is found inside. The quests are in 2026_11_14_42.
--  * INFERRED (our guesses, every row says so): which room holds which boss, every spawn spot and pack, Blazeroar's
--    health, drop chances, gold, trash ability
--    choice and timers, the entrance on Alcaz Island (Dustwallow 75, 15 from the public guides, turned into world
--    coordinates with the client's UiMapAssignment for Dustwallow), the landing and exit spots.
-- Replace the guesses with real data when someone records a run (a combat log and the Cache folder are planned).
-- Spawn guids 48120000-48120199, reference loot 2994000. Safe to run again.

-- the instance (entrance on Kalimdor)
DELETE FROM `instance_template` WHERE `map` = 2994;
INSERT INTO `instance_template` (`map`,`parent`,`script`) VALUES
(2994,1,'classic_instance_alcaz_prison');

-- Blazeroar: no cache has its template. Model 149885 and level 55 from Everlake (both checked: the model is in our
-- client); health x12 INFERRED (he heals in full at 30%, so the fight is about 1.7 times that). Zarla Ober (255707) is
-- never spawned: Blazeroar's Illusion spell (1267176) turns him into her, so only her look is needed (model 139053).
DELETE FROM `creature_template` WHERE `entry` IN (255702,255707,255366);
INSERT INTO `creature_template` (`entry`,`KillCredit1`,`KillCredit2`,`name`,`femaleName`,`subname`,`TitleAlt`,`IconName`,`RequiredExpansion`,`VignetteID`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`Classification`,`dmgschool`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,`unit_flags`,`unit_flags2`,`unit_flags3`,`family`,`trainer_class`,`type`,`VehicleId`,`AIName`,`MovementType`,`ExperienceModifier`,`RacialLeader`,`movementId`,`WidgetSetID`,`WidgetSetUnitConditionID`,`RegenHealth`,`CreatureImmunitiesId`,`flags_extra`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(255702,0,0,'Blazeroar',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,2,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(255707,0,0,'Zarla Ober',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,8,0,2048,0,0,0,7,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(255366,0,0,'Molten Servitor',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,2,0,2048,0,0,0,4,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0);
DELETE FROM `creature_template_difficulty` WHERE `Entry` IN (255702,255707,255366);
INSERT INTO `creature_template_difficulty` (`Entry`,`DifficultyID`,`LevelScalingDeltaMin`,`LevelScalingDeltaMax`,`ContentTuningID`,`HealthScalingExpansion`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`DamageModifier`,`CreatureDifficultyID`,`TypeFlags`,`TypeFlags2`,`TypeFlags3`,`LootID`,`PickPocketLootID`,`SkinLootID`,`GoldMin`,`GoldMax`,`StaticFlags1`,`StaticFlags2`,`StaticFlags3`,`StaticFlags4`,`StaticFlags5`,`StaticFlags6`,`StaticFlags7`,`StaticFlags8`,`VerifiedBuild`) VALUES
(255702,0,0,0,0,0,12.0,1.0,1.0,2.0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(255707,0,0,0,0,0,1.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(255366,0,0,0,0,0,2.5,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
DELETE FROM `creature_template_model` WHERE `CreatureID` IN (255702,255707,255366);
INSERT INTO `creature_template_model` (`CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild`) VALUES
(255702,0,149885,1.0,1.0,0),
(255707,0,139053,1.0,1.0,0),
(255366,0,1070,0.6,1.0,0);
DELETE FROM `creature_classic_level` WHERE `entry` IN (255702,255707,255366);
INSERT INTO `creature_classic_level` (`entry`,`level_min`,`level_max`) VALUES
(255702,55,55),
(255707,55,55),
(255366,50,52);

-- boss scripts
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_boss_alcaz_wrex' WHERE `entry` = 255391;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_boss_alcaz_cazass' WHERE `entry` = 255997;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_boss_alcaz_katerina' WHERE `entry` = 257016;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_boss_alcaz_questioner' WHERE `entry` = 256236;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_boss_alcaz_blazeroar' WHERE `entry` = 255702;

-- gold (INFERRED) and loot ids
UPDATE `creature_template_difficulty` SET `GoldMin` = 300, `GoldMax` = 900, `LootID` = `Entry` WHERE `DifficultyID` = 0 AND `Entry` IN (255262,255267,255271,255276,271780,255309,255364,255366,255367,255369,255373,255995,255377,271784,256284);
UPDATE `creature_template_difficulty` SET `GoldMin` = 3000, `GoldMax` = 6000, `LootID` = `Entry` WHERE `DifficultyID` = 0 AND `Entry` IN (255391,255997,257016,256236,255702);
-- the Alcaz trash items (287017-287026, bind on equip): one roll from the list (chances INFERRED)
DELETE FROM `reference_loot_template` WHERE `Entry` = 2994000;
INSERT INTO `reference_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(2994000,0,287017,0,0,1,1,1,1,'Alcaz Prison trash: Chaplain''s Mitre'),
(2994000,0,287018,0,0,1,1,1,1,'Alcaz Prison trash: Compound Gloves'),
(2994000,0,287019,0,0,1,1,1,1,'Alcaz Prison trash: Defias Enforcer''s Mask'),
(2994000,0,287020,0,0,1,1,1,1,'Alcaz Prison trash: Defias Enforcer''s Chest'),
(2994000,0,287021,0,0,1,1,1,1,'Alcaz Prison trash: Defias Enforcer''s Prowlers'),
(2994000,0,287022,0,0,1,1,1,1,'Alcaz Prison trash: Spaulders of Containment'),
(2994000,0,287023,0,0,1,1,1,1,'Alcaz Prison trash: Iron-Wrought Cuffs'),
(2994000,0,287024,0,0,1,1,1,1,'Alcaz Prison trash: Mark of Captivity'),
(2994000,0,287025,0,0,1,1,1,1,'Alcaz Prison trash: Enchantresses'' Spire'),
(2994000,0,287026,0,0,1,1,1,1,'Alcaz Prison trash: Escape Plan');
DELETE FROM `creature_loot_template` WHERE `Entry` IN (255391,255997,257016,256236,255702,255262,255267,255271,255276,271780,255309,255364,255366,255367,255369,255373,255995,255377,271784,256284);
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(255391,0,276732,33.3,0,1,1,1,1,'Overseer Wrex: Alcaz Willcrusher (one boss item each kill; chance INFERRED)'),
(255391,0,276733,33.3,0,1,1,1,1,'Overseer Wrex: Grips of Control (one boss item each kill; chance INFERRED)'),
(255391,0,276734,33.4,0,1,1,1,1,'Overseer Wrex: Wrex''s Pinky Ring (one boss item each kill; chance INFERRED)'),
(255997,0,276735,33.3,0,1,1,1,1,'Tidemistress Ca''zass: Tidesong Wand (one boss item each kill; chance INFERRED)'),
(255997,0,276736,33.3,0,1,1,1,1,'Tidemistress Ca''zass: Seascale Bracers (one boss item each kill; chance INFERRED)'),
(255997,0,276737,33.4,0,1,1,1,1,'Tidemistress Ca''zass: Cloak of the Tidemistress (one boss item each kill; chance INFERRED)'),
(257016,0,276738,33.3,0,1,1,1,1,'Katerina the Cleaner: Katerina''s Shanker (one boss item each kill; chance INFERRED)'),
(257016,0,276739,33.3,0,1,1,1,1,'Katerina the Cleaner: Cutthroat Chestguard (one boss item each kill; chance INFERRED)'),
(257016,0,276740,33.4,0,1,1,1,1,'Katerina the Cleaner: Sentimental Locket (one boss item each kill; chance INFERRED)'),
(256236,0,276741,33.3,0,1,1,1,1,'The Questioner: Defias Enforcer''s Shoulderpads (one boss item each kill; chance INFERRED)'),
(256236,0,276742,33.3,0,1,1,1,1,'The Questioner: Girdle of Extracted Answers (one boss item each kill; chance INFERRED)'),
(256236,0,276743,33.4,0,1,1,1,1,'The Questioner: Fingerbreaker Stamp (one boss item each kill; chance INFERRED)'),
(255702,0,276744,33.3,0,1,1,1,1,'Blazeroar: Zarla''s Snack Pouch (one boss item each kill; chance INFERRED)'),
(255702,0,276745,33.3,0,1,1,1,1,'Blazeroar: Beastbond Robe (one boss item each kill; chance INFERRED)'),
(255702,0,276746,33.4,0,1,1,1,1,'Blazeroar: Defias Enforcer''s Legguards (one boss item each kill; chance INFERRED)'),
(255997,0,273883,100,1,1,0,1,1,'Tidemistress Ca''zass: her head (A Bit of Wet Work / A Little Payback), quest drop (chance INFERRED)'),
(256236,0,274029,100,1,1,0,1,1,'The Questioner: Alcaz Shackle Key (The Man in the Iron Chains), quest drop (chance INFERRED)'),
(255702,0,276890,100,1,1,0,1,1,'Blazeroar: Zarla''s Journal (The Dragon''s Journal), quest drop (chance INFERRED)'),
(255271,0,274028,60,1,1,0,1,1,'Defias Truthfinder: Blood Red Bandana (Blood Red Bandanas), quest drop (chance INFERRED)'),
(255276,0,274028,60,1,1,0,1,1,'Defias Mercenary: Blood Red Bandana (Blood Red Bandanas), quest drop (chance INFERRED)'),
(271780,0,274028,60,1,1,0,1,1,'Defias Mercenary: Blood Red Bandana (Blood Red Bandanas), quest drop (chance INFERRED)'),
(255309,0,274028,60,1,1,0,1,1,'Defias Bounty Hunter: Blood Red Bandana (Blood Red Bandanas), quest drop (chance INFERRED)'),
(255377,0,274028,40,1,1,0,1,1,'Alcaz Jailer: Blood Red Bandana (Blood Red Bandanas), quest drop (chance INFERRED)'),
(271784,0,274028,40,1,1,0,1,1,'Alcaz Jailer: Blood Red Bandana (Blood Red Bandanas), quest drop (chance INFERRED)'),
(255262,1,2994000,3,0,1,0,1,1,'Alcaz Chaplain: Alcaz Prison trash item (chance INFERRED)'),
(255267,1,2994000,3,0,1,0,1,1,'Slavering Hound: Alcaz Prison trash item (chance INFERRED)'),
(255271,1,2994000,3,0,1,0,1,1,'Defias Truthfinder: Alcaz Prison trash item (chance INFERRED)'),
(255276,1,2994000,3,0,1,0,1,1,'Defias Mercenary: Alcaz Prison trash item (chance INFERRED)'),
(271780,1,2994000,3,0,1,0,1,1,'Defias Mercenary: Alcaz Prison trash item (chance INFERRED)'),
(255309,1,2994000,3,0,1,0,1,1,'Defias Bounty Hunter: Alcaz Prison trash item (chance INFERRED)'),
(255364,1,2994000,3,0,1,0,1,1,'Renegade Conjurer: Alcaz Prison trash item (chance INFERRED)'),
(255366,1,2994000,3,0,1,0,1,1,'Molten Servitor: Alcaz Prison trash item (chance INFERRED)'),
(255367,1,2994000,3,0,1,0,1,1,'Frozen Servitor: Alcaz Prison trash item (chance INFERRED)'),
(255369,1,2994000,3,0,1,0,1,1,'Arcane Servitor: Alcaz Prison trash item (chance INFERRED)'),
(255373,1,2994000,3,0,1,0,1,1,'Strashaz Enchantress: Alcaz Prison trash item (chance INFERRED)'),
(255995,1,2994000,3,0,1,0,1,1,'Strashaz Soldier: Alcaz Prison trash item (chance INFERRED)'),
(255377,1,2994000,3,0,1,0,1,1,'Alcaz Jailer: Alcaz Prison trash item (chance INFERRED)'),
(271784,1,2994000,3,0,1,0,1,1,'Alcaz Jailer: Alcaz Prison trash item (chance INFERRED)'),
(256284,1,2994000,3,0,1,0,1,1,'Prisoner: Alcaz Prison trash item (chance INFERRED)');

-- trash abilities (all spells are in the 70938 client; which mob uses which from its class and name, timers INFERRED;
-- Pummel and Gouge are cast triggered because these mobs have no rage or energy)
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` IN (255262,255267,255271,255276,271780,255309,255364,255366,255367,255369,255373,255995,255377,271784,256284);
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` IN (255262,255267,255271,255276,271780,255309,255364,255366,255367,255369,255373,255995,255377,271784,256284);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`Difficulties`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`action_param7`,`action_param_string`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_param_string`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(255262,0,0,0,'',14,0,100,0,1500,40,8000,12000,0,'',11,1283680,0,0,0,0,0,0,'',7,0,0,0,0,'',0,0,0,0,'Alcaz Chaplain - heal on an ally missing 1500 health (INFERRED timer)'),
(255262,0,1,0,'',0,0,100,0,0,1000,3500,5000,0,'',11,1283362,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Alcaz Chaplain - Shadow Bolt on victim (INFERRED timer)'),
(255267,0,0,0,'',0,0,100,0,3000,6000,8000,11000,0,'',11,1283405,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Slavering Hound - Muscle Tear on victim (INFERRED timer)'),
(255271,0,0,0,'',0,0,100,0,0,1000,3500,5000,0,'',11,1283362,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Defias Truthfinder - Shadow Bolt on victim (INFERRED timer)'),
(255271,0,1,0,'',0,0,100,0,3000,5000,15000,20000,0,'',11,589,0,0,0,0,0,0,'',6,0,0,0,0,'',0,0,0,0,'Defias Truthfinder - Shadow Word: Pain on a random player (INFERRED timer)'),
(255276,0,0,0,'',0,0,100,0,3000,6000,8000,12000,0,'',11,1283416,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Defias Mercenary - Poisonous Stab on victim (INFERRED timer)'),
(255276,0,1,0,'',0,0,100,0,8000,12000,16000,20000,0,'',11,1776,2,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Defias Mercenary - Gouge on victim (INFERRED timer)'),
(271780,0,0,0,'',0,0,100,0,3000,6000,8000,12000,0,'',11,1283416,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Defias Mercenary - Poisonous Stab on victim (INFERRED timer)'),
(271780,0,1,0,'',0,0,100,0,8000,12000,16000,20000,0,'',11,1776,2,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Defias Mercenary - Gouge on victim (INFERRED timer)'),
(255309,0,0,0,'',9,0,100,0,8,30,12000,16000,0,'',11,1283364,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Defias Bounty Hunter - Net on victim at range (INFERRED timer)'),
(255309,0,1,0,'',0,0,100,0,1000,2000,4000,6000,0,'',11,1283365,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Defias Bounty Hunter - Shadow Shot on victim (INFERRED timer)'),
(255364,0,0,0,'',0,0,100,0,0,1000,3500,5000,0,'',11,1283410,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Renegade Conjurer - Frostbolt on victim (INFERRED timer)'),
(255364,0,1,0,'',9,0,100,0,0,8,15000,20000,0,'',11,1300716,0,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'Renegade Conjurer - Frost Nova when a player is close (INFERRED timer)'),
(255366,0,0,0,'',0,0,100,0,1000,3000,5000,8000,0,'',11,9053,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Molten Servitor - Fireball on victim (spell and timer INFERRED)'),
(255367,0,0,0,'',0,0,100,0,1000,3000,5000,8000,0,'',11,1283410,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Frozen Servitor - Frostbolt on victim (INFERRED timer)'),
(255369,0,0,0,'',0,0,100,0,1000,3000,5000,8000,0,'',11,13748,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Arcane Servitor - Arcane Bolt on victim (INFERRED timer)'),
(255373,0,0,0,'',0,0,100,0,0,1000,3500,5000,0,'',11,1283421,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Strashaz Enchantress - Lightning Bolt on victim (INFERRED timer)'),
(255373,0,1,0,'',0,0,100,0,5000,8000,12000,16000,0,'',11,8056,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Strashaz Enchantress - Frost Shock on victim (INFERRED timer)'),
(255995,0,0,0,'',0,0,100,0,4000,6000,8000,11000,0,'',11,1283413,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Strashaz Soldier - Cleave on victim (INFERRED timer)'),
(255995,0,1,0,'',0,0,100,0,2000,4000,15000,18000,0,'',11,1283423,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Strashaz Soldier - Rend on victim (INFERRED timer)'),
(255377,0,0,0,'',0,0,100,0,4000,7000,8000,12000,0,'',11,1283390,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Alcaz Jailer - Sunder Armor on victim (INFERRED timer)'),
(255377,0,1,0,'',0,0,100,0,6000,9000,12000,16000,0,'',11,6552,2,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Alcaz Jailer - Pummel on victim (INFERRED timer)'),
(271784,0,0,0,'',0,0,100,0,4000,7000,8000,12000,0,'',11,1283390,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Alcaz Jailer - Sunder Armor on victim (INFERRED timer)'),
(271784,0,1,0,'',0,0,100,0,6000,9000,12000,16000,0,'',11,6552,2,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Alcaz Jailer - Pummel on victim (INFERRED timer)'),
(256284,0,0,0,'',0,0,100,0,3000,5000,6000,9000,0,'',11,1283076,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Prisoner - Strike on victim (INFERRED timer)');

-- spawns (spots INFERRED: rooms read off the navmesh, bosses in the order of the encounter list, trash packs on the way)
DELETE FROM `creature` WHERE `guid` BETWEEN 48120000 AND 48120199;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(48120000,255377,2994,0,0,'1,201',0,0,0,-1,0,0,-8798,2852,23.8,4.854,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* the stair down from the door */,
(48120001,271784,2994,0,0,'1,201',0,0,0,-1,0,0,-8794,2852,23.8,4.57,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* the stair down from the door */,
(48120002,255267,2994,0,0,'1,201',0,0,0,-1,0,0,-8796,2854,23.8,4.712,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* the stair down from the door */,
(48120003,255377,2994,0,0,'1,201',0,0,0,-1,0,0,-8798,2872,19.55,4.812,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* foot of the stair */,
(48120004,255267,2994,0,0,'1,201',0,0,0,-1,0,0,-8794,2871,19.55,4.608,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* foot of the stair */,
(48120005,255267,2994,0,0,'1,201',0,0,0,-1,0,0,-8794,2874,19.27,4.622,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* foot of the stair */,
(48120006,255391,2994,0,0,'1,201',0,0,0,-1,0,0,-8762,2852,14.02,1.571,86400,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Overseer Wrex and his hounds (they join his fight) */,
(48120007,255267,2994,0,0,'1,201',0,0,0,-1,0,0,-8765,2855,14.02,1.451,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Overseer Wrex and his hounds (they join his fight) */,
(48120008,255267,2994,0,0,'1,201',0,0,0,-1,0,0,-8759,2855,14.02,1.69,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Overseer Wrex and his hounds (they join his fight) */,
(48120009,255276,2994,0,0,'1,201',0,0,0,-1,0,0,-8784,2886,18.2,2.976,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* hall to the north wing */,
(48120010,255309,2994,0,0,'1,201',0,0,0,-1,0,0,-8784,2890,18.2,3.307,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* hall to the north wing */,
(48120011,255995,2994,0,0,'1,201',0,0,0,-1,0,0,-8732,2885,14.95,3.042,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* upper north hall (Strashaz) */,
(48120012,255995,2994,0,0,'1,201',0,0,0,-1,0,0,-8732,2891,14.95,3.241,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* upper north hall (Strashaz) */,
(48120013,255995,2994,0,0,'1,201',0,0,0,-1,0,0,-8729,2888,14.95,3.142,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* upper north hall (Strashaz) */,
(48120014,255995,2994,0,0,'1,201',0,0,0,-1,0,0,-8764,2912,10.64,4.829,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* north cross hall (Strashaz) */,
(48120015,255995,2994,0,0,'1,201',0,0,0,-1,0,0,-8760,2912,10.64,4.595,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* north cross hall (Strashaz) */,
(48120016,255995,2994,0,0,'1,201',0,0,0,-1,0,0,-8762,2915,8.91,4.712,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* north cross hall (Strashaz) */,
(48120017,255997,2994,0,0,'1,201',0,0,0,-1,0,0,-8728,2932,6.15,3.142,86400,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Tidemistress Ca'zass and her two Strashaz Enchantresses (they join her fight) */,
(48120018,255373,2994,0,0,'1,201',0,0,0,-1,0,0,-8731,2929,6.85,3.045,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Tidemistress Ca'zass and her two Strashaz Enchantresses (they join her fight) */,
(48120019,255373,2994,0,0,'1,201',0,0,0,-1,0,0,-8731,2935,6.85,3.238,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Tidemistress Ca'zass and her two Strashaz Enchantresses (they join her fight) */,
(48120020,255995,2994,0,0,'1,201',0,0,0,-1,0,0,-8764,2938,6.95,4.799,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* north cross hall, low end (Strashaz) */,
(48120021,255373,2994,0,0,'1,201',0,0,0,-1,0,0,-8760,2938,6.86,4.626,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* north cross hall, low end (Strashaz) */,
(48120022,255373,2994,0,0,'1,201',0,0,0,-1,0,0,-8762,2941,6.95,4.712,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* north cross hall, low end (Strashaz) */,
(48120023,255995,2994,0,0,'1,201',0,0,0,-1,0,0,-8780,2929,6.82,2.956,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* lower north hall (Strashaz) */,
(48120024,255995,2994,0,0,'1,201',0,0,0,-1,0,0,-8780,2935,6.82,3.327,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* lower north hall (Strashaz) */,
(48120025,255373,2994,0,0,'1,201',0,0,0,-1,0,0,-8777,2932,6.64,3.142,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* lower north hall (Strashaz) */,
(48120026,255995,2994,0,0,'1,201',0,0,0,-1,0,0,-8764,2963,19.35,3.006,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* west square (Strashaz) */,
(48120027,255995,2994,0,0,'1,201',0,0,0,-1,0,0,-8764,2969,19.06,3.277,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* west square (Strashaz) */,
(48120028,255373,2994,0,0,'1,201',0,0,0,-1,0,0,-8761,2966,18.69,3.142,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* west square (Strashaz) */,
(48120029,255995,2994,0,0,'1,201',0,0,0,-1,0,0,-8808,2942,7.42,5.588,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* lower hall (Strashaz) */,
(48120030,255995,2994,0,0,'1,201',0,0,0,-1,0,0,-8808,2948,7.22,5.356,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* lower hall (Strashaz) */,
(48120031,255373,2994,0,0,'1,201',0,0,0,-1,0,0,-8811,2945,8.02,5.569,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* lower hall (Strashaz) */,
(48120032,255995,2994,0,0,'1,201',0,0,0,-1,0,0,-8810,2915,7.54,1.471,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* lower hall (Strashaz) */,
(48120033,255995,2994,0,0,'1,201',0,0,0,-1,0,0,-8806,2915,7.54,1.67,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* lower hall (Strashaz) */,
(48120034,255373,2994,0,0,'1,201',0,0,0,-1,0,0,-8808,2912,7.54,1.571,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* lower hall (Strashaz) */,
(48120035,255995,2994,0,0,'1,201',0,0,0,-1,0,0,-8810,2876,7.4,1.466,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* lower hall (Strashaz) */,
(48120036,255373,2994,0,0,'1,201',0,0,0,-1,0,0,-8806,2876,7.4,1.676,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* lower hall (Strashaz) */,
(48120037,255271,2994,0,0,'1,201',0,0,0,-1,0,0,-8820,2886,15.93,0.1,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* cell block, north end of the aisle */,
(48120038,271780,2994,0,0,'1,201',0,0,0,-1,0,0,-8820,2890,15.93,6.184,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* cell block, north end of the aisle */,
(48120039,256284,2994,0,0,'1,201',0,0,0,-1,0,0,-8828,2906,13.98,4.712,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* cell block, west cells (rioting prisoners) */,
(48120040,256284,2994,0,0,'1,201',0,0,0,-1,0,0,-8828,2911,13.98,4.712,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* cell block, west cells (rioting prisoners) */,
(48120041,256284,2994,0,0,'1,201',0,0,0,-1,0,0,-8828,2868,13.62,1.571,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* cell block, east cells (rioting prisoners) */,
(48120042,256284,2994,0,0,'1,201',0,0,0,-1,0,0,-8828,2862,13.75,1.571,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* cell block, east cells (rioting prisoners) */,
(48120043,257016,2994,0,0,'1,201',0,0,0,-1,0,0,-8852,2888,14.02,0.0,86400,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Katerina the Cleaner and her two Alcaz Chaplains (they join her fight) */,
(48120044,255262,2994,0,0,'1,201',0,0,0,-1,0,0,-8849,2885,15.22,0.103,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Katerina the Cleaner and her two Alcaz Chaplains (they join her fight) */,
(48120045,255262,2994,0,0,'1,201',0,0,0,-1,0,0,-8849,2891,15.22,6.18,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Katerina the Cleaner and her two Alcaz Chaplains (they join her fight) */,
(48120046,255309,2994,0,0,'1,201',0,0,0,-1,0,0,-8852,2908,13.89,4.712,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* cell block, west cells */,
(48120047,255271,2994,0,0,'1,201',0,0,0,-1,0,0,-8852,2913,13.62,4.712,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* cell block, west cells */,
(48120048,271780,2994,0,0,'1,201',0,0,0,-1,0,0,-8852,2866,13.8,1.571,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* cell block, east cells */,
(48120049,255271,2994,0,0,'1,201',0,0,0,-1,0,0,-8852,2861,13.62,1.571,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* cell block, east cells */,
(48120050,255262,2994,0,0,'1,201',0,0,0,-1,0,0,-8864,2886,15.04,0.165,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* cell block, south end of the aisle */,
(48120051,255271,2994,0,0,'1,201',0,0,0,-1,0,0,-8864,2890,15.04,6.118,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* cell block, south end of the aisle */,
(48120052,256236,2994,0,0,'1,201',0,0,0,-1,0,0,-8888,2888,14.42,0.0,86400,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* The Questioner and two Alcaz Jailers (he has no adds; they only stand guard) */,
(48120053,255377,2994,0,0,'1,201',0,0,0,-1,0,0,-8885,2885,14.42,0.175,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* The Questioner and two Alcaz Jailers (he has no adds; they only stand guard) */,
(48120054,255377,2994,0,0,'1,201',0,0,0,-1,0,0,-8885,2891,14.42,6.109,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* The Questioner and two Alcaz Jailers (he has no adds; they only stand guard) */,
(48120055,255271,2994,0,0,'1,201',0,0,0,-1,0,0,-8888,2915,15.01,4.812,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* interrogation room, west wing */,
(48120056,255309,2994,0,0,'1,201',0,0,0,-1,0,0,-8884,2915,15.01,4.613,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* interrogation room, west wing */,
(48120057,271780,2994,0,0,'1,201',0,0,0,-1,0,0,-8888,2860,15.22,1.471,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* interrogation room, east wing */,
(48120058,255267,2994,0,0,'1,201',0,0,0,-1,0,0,-8884,2860,15.22,1.67,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* interrogation room, east wing */,
(48120059,255364,2994,0,0,'1,201',0,0,0,-1,0,0,-8796,2930,19.84,4.712,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* main hall west (renegade mages) */,
(48120060,255367,2994,0,0,'1,201',0,0,0,-1,0,0,-8798,2932,19.84,4.775,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* main hall west (renegade mages) */,
(48120061,255367,2994,0,0,'1,201',0,0,0,-1,0,0,-8794,2932,19.84,4.65,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* main hall west (renegade mages) */,
(48120062,255364,2994,0,0,'1,201',0,0,0,-1,0,0,-8792,2968,17.84,4.57,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* west round hall (renegade mages) */,
(48120063,255369,2994,0,0,'1,201',0,0,0,-1,0,0,-8795,2970,17.84,4.679,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* west round hall (renegade mages) */,
(48120064,255367,2994,0,0,'1,201',0,0,0,-1,0,0,-8789,2970,17.93,4.483,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* west round hall (renegade mages) */,
(48120065,255364,2994,0,0,'1,201',0,0,0,-1,0,0,-8796,3000,19.49,4.775,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* far west hall (renegade mages) */,
(48120066,255369,2994,0,0,'1,201',0,0,0,-1,0,0,-8796,3003,18.69,4.769,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* far west hall (renegade mages) */,
(48120080,255366,2994,0,0,'1,201',0,0,0,-1,0,0,-8799,3001,19.49,4.775,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* far west hall (renegade mages) */,
(48120081,255366,2994,0,0,'1,201',0,0,0,-1,0,0,-8838,2951,6.78,0.5,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* deep cell corridor */,
(48120067,255377,2994,0,0,'1,201',0,0,0,-1,0,0,-8814,2968,6.55,4.968,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* lower hall to the deep cells */,
(48120068,271784,2994,0,0,'1,201',0,0,0,-1,0,0,-8810,2968,6.55,4.799,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* lower hall to the deep cells */,
(48120069,255267,2994,0,0,'1,201',0,0,0,-1,0,0,-8812,2971,5.89,4.865,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* lower hall to the deep cells */,
(48120070,255377,2994,0,0,'1,201',0,0,0,-1,0,0,-8844,2948,6.78,0.488,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* deep cell corridor */,
(48120071,255364,2994,0,0,'1,201',0,0,0,-1,0,0,-8840,2948,6.78,0.546,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* deep cell corridor */,
(48120072,255369,2994,0,0,'1,201',0,0,0,-1,0,0,-8842,2951,6.78,0.437,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* deep cell corridor */,
(48120073,271784,2994,0,0,'1,201',0,0,0,-1,0,0,-8844,2985,6.63,4.792,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* deep cell corridor */,
(48120074,255377,2994,0,0,'1,201',0,0,0,-1,0,0,-8840,2985,6.63,4.633,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* deep cell corridor */,
(48120075,271784,2994,0,0,'1,201',0,0,0,-1,0,0,-8856,2964,7.38,0.142,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* before the deep chamber */,
(48120076,271784,2994,0,0,'1,201',0,0,0,-1,0,0,-8856,2968,7.75,6.141,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* before the deep chamber */,
(48120077,255702,2994,0,0,'1,201',0,0,0,-1,0,0,-8890,2966,5.89,0.0,86400,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Blazeroar in the deep chamber */,
(48120078,264770,2994,0,0,'1,201',0,0,0,-1,0,0,-8890,2990,6.2,4.712,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Mason Connery in his ball and chain, beyond the dragon */,
(48120079,260386,2994,0,0,'1,201',0,0,0,-1,0,0,-8916,2888,15.42,0.0,7200,0,0,100,0,NULL,768,NULL,NULL,'',NULL,0) /* Commander Folkar, the last Kor'kron in the cells */;

-- the way in: Alcaz Island, Dustwallow Marsh (map 1). Landing on the stair inside the door (the navmesh is cut at the
-- top step, so the landing is on the first piece a group can walk from); exit at the door (INFERRED spots).
DELETE FROM `world_safe_locs` WHERE `ID` IN (1104124,1104125);
INSERT INTO `world_safe_locs` (`ID`,`MapID`,`LocX`,`LocY`,`LocZ`,`Facing`,`Comment`) VALUES
(1104124,2994,-8796.8,2838.1,29.9,1.571,'Alcaz Prison (dungeon) - entrance inside, the stair below the door (INFERRED)'),
(1104125,1,-2566.0,-4905.0,32.5,2.36,'Alcaz Prison (dungeon) - exit outside, Alcaz Island (INFERRED)');
DELETE FROM `areatrigger_template` WHERE `IsCustom` = 1 AND `Id` IN (324,325);
INSERT INTO `areatrigger_template` (`Id`,`IsCustom`,`Flags`,`ActionSetId`,`ActionSetFlags`,`VerifiedBuild`) VALUES
(324,1,0,0,0,0),
(325,1,0,0,0,0);
DELETE FROM `areatrigger_template_actions` WHERE `IsCustom` = 1 AND `AreaTriggerId` IN (324,325);
INSERT INTO `areatrigger_template_actions` (`AreaTriggerId`,`IsCustom`,`ActionType`,`ActionParam`,`TargetType`) VALUES
(324,1,2,1104124,5),
(325,1,2,1104125,5);
DELETE FROM `areatrigger_create_properties` WHERE `IsCustom` = 1 AND `Id` IN (324,325);
INSERT INTO `areatrigger_create_properties` (`Id`,`IsCustom`,`AreaTriggerId`,`IsAreatriggerCustom`,`Flags`,`MoveCurveId`,`ScaleCurveId`,`MorphCurveId`,`FacingCurveId`,`AnimId`,`AnimKitId`,`DecalPropertiesId`,`SpellForVisuals`,`PositionalSoundKitId`,`TimeToTargetScale`,`Speed`,`SpeedIsTime`,`Shape`,`ShapeData0`,`ShapeData1`,`ShapeData2`,`ShapeData3`,`ShapeData4`,`ShapeData5`,`ShapeData6`,`ShapeData7`,`Roll`,`Pitch`,`Yaw`,`TargetRoll`,`TargetPitch`,`TargetYaw`,`ScriptName`,`VerifiedBuild`) VALUES
(324,1,324,1,0,0,0,0,0,-1,0,0,NULL,0,0,0,0,0,5,5,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,'',0),
(325,1,325,1,0,0,0,0,0,-1,0,0,NULL,0,0,0,0,0,4,4,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,'',0);
DELETE FROM `areatrigger` WHERE `SpawnId` IN (34,35);
INSERT INTO `areatrigger` (`SpawnId`,`AreaTriggerCreatePropertiesId`,`IsCustom`,`MapId`,`SpawnDifficulties`,`PosX`,`PosY`,`PosZ`,`Orientation`,`PhaseUseFlags`,`PhaseId`,`PhaseGroup`,`ScriptName`,`Comment`,`VerifiedBuild`) VALUES
(34,324,1,1,'0',-2558.3,-4912.5,33.0,0,1,0,0,'','Alcaz Prison - dungeon entrance (Alcaz Island, Dustwallow 75, 15; INFERRED spot)',0),
(35,325,1,2994,'1,201',-8798.0,2806.0,40.0,0,1,0,0,'','Alcaz Prison (dungeon) - exit (the door at the top of the stair, INFERRED spot)',0);

-- ghosts release to the Theramore Isle graveyard (the nearest one to Alcaz Island)
DELETE FROM `graveyard_zone` WHERE `GhostZone` = 16620;
INSERT INTO `graveyard_zone` (`ID`,`GhostZone`,`Comment`) VALUES
(189,16620,'Alcaz Prison (dungeon) - Dustwallow Marsh, Theramore Isle GY');

-- .tele
DELETE FROM `game_tele` WHERE `id` IN (2360,2361) OR `name` IN ('AlcazPrison','AlcazPrisonEntrance');
INSERT INTO `game_tele` (`id`,`position_x`,`position_y`,`position_z`,`orientation`,`map`,`name`) VALUES
(2360,-8796.8,2838.1,29.9,1.571,2994,'AlcazPrison'),
(2361,-2566.0,-4905.0,32.5,2.36,1,'AlcazPrisonEntrance');
