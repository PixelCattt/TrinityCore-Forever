-- WoW Forever: Blackmaw Hold (map 2974, zone 16554, levels 55-60) made playable: instance, way in and out, creature
-- templates, trash and boss spawns, trash abilities and loot. The fights are in classic_instance_blackmaw_hold.cpp.
-- No sniff, combat log or player cache of this dungeon has its creatures yet. What is real data and what is a guess:
--  * from Everlake's Forever dungeon work (github.com/buildthehomelab, GPL): the 38 creatures (names, ranks, types, models,
--    levels), which boss drops which items, the way in (the furbolg tunnel in Azshara, where three public guides agree),
--    which area holds which outer boss, and 81 of the spawn spots below (each one checked on our navmesh: on the walkable
--    mesh joined to the landing, at the floor's height).
--  * real (70938 client and our hotfixes): the map, its navmesh, the boss items 280056-280082/280085/280086 and the trash
--    items 287028-287036 (all already in our hotfixes), every spell used.
--  * ours, INFERRED (every row says so): the other 30 spawn spots (Everlake's were off the mesh or off the floor: the
--    Behemoth, Bloodmane and his Devotees, the Unbound Spirit, Varrox and the packs of the main cave are placed in the
--    rooms the guides describe, on the mesh), health and damage multipliers, unit classes of the casters, gold, drop
--    chances, which rare drops which items (by the items' names), the trash abilities and their timers.
--  * Varrox's own cave under the pool (z -100) is not joined to the rest of the navmesh, so he stands in the low south
--    end of the east cave, past the Behemoth, until a run shows how players get down there.
-- Held: the quest items off the bosses (249692-249697, 276893, 286415) wait for the dungeon's quests; 273050 and 274964
-- (dropped by every boss) and 280083/280084 wait until we know what they are for.
-- Spawn guids 48130000-48130199, reference loot 2974000. Safe to run again.

-- the instance (entrance on Kalimdor)
DELETE FROM `instance_template` WHERE `map` = 2974;
INSERT INTO `instance_template` (`map`,`parent`,`script`) VALUES
(2974,1,'classic_instance_blackmaw_hold');

-- templates (names, ranks, types, models and levels from Everlake; the rest INFERRED)
DELETE FROM `creature_template` WHERE `entry` IN (247195,247198,247206,247207,247209,247231,247234,247235,247237,247248,247249,247412,247432,247996,248216,248765,249061,249064,249065,250023,250027,250034,255247,255347,255394,258152,258264,258329,258508,258516,258668,268834,268864,268865,268878,269104,269111,277474);
INSERT INTO `creature_template` (`entry`,`KillCredit1`,`KillCredit2`,`name`,`femaleName`,`subname`,`TitleAlt`,`IconName`,`RequiredExpansion`,`VignetteID`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`Classification`,`dmgschool`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,`unit_flags`,`unit_flags2`,`unit_flags3`,`family`,`trainer_class`,`type`,`VehicleId`,`AIName`,`MovementType`,`ExperienceModifier`,`RacialLeader`,`movementId`,`WidgetSetID`,`WidgetSetUnitConditionID`,`RegenHealth`,`CreatureImmunitiesId`,`flags_extra`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(247195,0,0,'Withermaw',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,1,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(247198,0,0,'Bonesnout the Unbroken',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,6,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(247206,0,0,'Impaan the Imprisoner',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,8,0,2048,0,0,0,3,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(247207,0,0,'Blackmaw Behemoth',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,1,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(247209,0,0,'Elder Shaman Bloodmane',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,2,0,2048,0,0,0,1,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(247231,0,0,'Unbound Spirit',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,8,0,2048,0,0,0,4,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(247234,0,0,'Varrox Bleakhoof',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,8,0,2048,0,0,0,3,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(247235,0,0,'Legashi Subjugator',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,8,0,2048,0,0,0,3,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(247237,0,0,'Blackmaw Berserker',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,7,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(247248,0,0,'Legashi Summoner',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,8,0,2048,0,0,0,3,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(247249,0,0,'Felfire Imp',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,3,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(247412,0,0,'Mopes',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,2,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,3,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(247432,0,0,'Imp',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,0,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,3,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(247996,0,0,'Clawbert',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,2,0,2048,0,0,0,7,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(248216,0,0,'Feral Spirit',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,4,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(248765,0,0,'Elder Bramblesnap',NULL,NULL,NULL,NULL,0,0,35,1,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,7,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(249061,0,0,'Ethereal Wolf',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,0,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,4,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(249064,0,0,'Ethereal Spider',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,0,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,4,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(249065,0,0,'Ethereal Bear',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,4,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(250023,0,0,'Blackmaw Thrall',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,7,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(250027,0,0,'Blackmaw Headhunter',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,7,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(250034,0,0,'Tunnelweb Matriarch',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,2,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,1,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(255247,0,0,'Swarming Imp',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,0,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,3,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(255347,0,0,'Legashi Slayer',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,3,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(255394,0,0,'Blackmaw Champion',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,7,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(258152,0,0,'Blackmaw Spearfisher',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,7,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(258264,0,0,'Depraved Owlbeast',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,1,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(258329,0,0,'Bloated Grizzly',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,1,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(258508,0,0,'Blackmaw Shaman',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,2,0,2048,0,0,0,7,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(258516,0,0,'Blackmaw Druid',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,2,0,2048,0,0,0,7,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(258668,0,0,'Legashi Ritualist',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,8,0,2048,0,0,0,3,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(268834,0,0,'Bloodstarved Frenzy',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,1,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(268864,0,0,'Legashi Plaguebringer',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,1,0,2000,2000,1.0,1.0,8,0,2048,0,0,0,3,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(268865,0,0,'Festering Swarmer',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,0,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,1,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(268878,0,0,'Flesh Maggot',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,0,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,1,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(269104,0,0,'Moontouched Wanderer',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,2,0,2000,2000,1.0,1.0,1,0,2048,0,0,0,1,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(269111,0,0,'Gortek the Apprentice',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,2,0,2000,2000,1.0,1.0,8,0,2048,0,0,0,1,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0),
(277474,0,0,'Blackmaw Devotee',NULL,NULL,NULL,NULL,0,0,16,0,1.0,1.14286,1.0,0,0,2000,2000,1.0,1.0,2,0,2048,0,0,0,7,0,'',0,1.0,0,0,0,0,1,0,0,'',NULL,0);
DELETE FROM `creature_template_difficulty` WHERE `Entry` IN (247195,247198,247206,247207,247209,247231,247234,247235,247237,247248,247249,247412,247432,247996,248216,248765,249061,249064,249065,250023,250027,250034,255247,255347,255394,258152,258264,258329,258508,258516,258668,268834,268864,268865,268878,269104,269111,277474);
INSERT INTO `creature_template_difficulty` (`Entry`,`DifficultyID`,`LevelScalingDeltaMin`,`LevelScalingDeltaMax`,`ContentTuningID`,`HealthScalingExpansion`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`DamageModifier`,`CreatureDifficultyID`,`TypeFlags`,`TypeFlags2`,`TypeFlags3`,`LootID`,`PickPocketLootID`,`SkinLootID`,`GoldMin`,`GoldMax`,`StaticFlags1`,`StaticFlags2`,`StaticFlags3`,`StaticFlags4`,`StaticFlags5`,`StaticFlags6`,`StaticFlags7`,`StaticFlags8`,`VerifiedBuild`) VALUES
(247195,0,0,0,0,0,10.0,1.0,1.0,2.0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(247198,0,0,0,0,0,10.0,1.0,1.0,2.0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(247206,0,0,0,0,0,10.0,1.0,1.0,2.0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(247207,0,0,0,0,0,10.0,1.0,1.0,2.0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(247209,0,0,0,0,0,10.0,1.0,1.0,2.0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(247231,0,0,0,0,0,10.0,1.0,1.0,2.0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(247234,0,0,0,0,0,12.0,1.0,1.0,2.0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(247235,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(247237,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(247248,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(247249,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(247412,0,0,0,0,0,4.0,1.0,1.0,1.5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(247432,0,0,0,0,0,1.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(247996,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(248216,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(248765,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(249061,0,0,0,0,0,1.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(249064,0,0,0,0,0,1.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(249065,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(250023,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(250027,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(250034,0,0,0,0,0,4.0,1.0,1.0,1.5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(255247,0,0,0,0,0,1.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(255347,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(255394,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(258152,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(258264,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(258329,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(258508,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(258516,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(258668,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(268834,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(268864,0,0,0,0,0,3.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(268865,0,0,0,0,0,1.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(268878,0,0,0,0,0,1.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(269104,0,0,0,0,0,4.0,1.0,1.0,1.5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(269111,0,0,0,0,0,4.0,1.0,1.0,1.5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
(277474,0,0,0,0,0,1.0,1.0,1.0,1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
DELETE FROM `creature_template_model` WHERE `CreatureID` IN (247195,247198,247206,247207,247209,247231,247234,247235,247237,247248,247249,247412,247432,247996,248216,248765,249061,249064,249065,250023,250027,250034,255247,255347,255394,258152,258264,258329,258508,258516,258668,268834,268864,268865,268878,269104,269111,277474);
INSERT INTO `creature_template_model` (`CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild`) VALUES
(247195,0,140708,1.0,1.0,0),
(247198,0,130427,1.0,1.0,0),
(247206,0,130432,1.0,1.0,0),
(247207,0,130436,1.0,1.0,0),
(247209,0,130440,1.0,1.0,0),
(247231,0,131644,1.0,1.0,0),
(247234,0,130447,1.0,1.0,0),
(247235,0,2011,1.0,1.0,0),
(247237,0,5851,1.0,1.0,0),
(247248,0,2875,1.0,1.0,0),
(247249,0,121882,1.0,1.0,0),
(247412,0,130499,1.0,1.0,0),
(247432,0,130530,1.0,1.0,0),
(247996,0,131321,1.0,1.0,0),
(248216,0,148909,1.0,1.0,0),
(248765,0,146761,1.0,1.0,0),
(249061,0,148905,1.0,1.0,0),
(249064,0,148904,1.0,1.0,0),
(249065,0,148903,1.0,1.0,0),
(250023,0,897,1.0,1.0,0),
(250027,0,6800,1.0,1.0,0),
(250034,0,2424,1.0,1.0,0),
(255247,0,4449,1.0,1.0,0),
(255347,0,2007,1.0,1.0,0),
(255394,0,1010,1.0,1.0,0),
(258152,0,1997,1.0,1.0,0),
(258264,0,12238,1.0,1.0,0),
(258329,0,140709,1.0,1.0,0),
(258508,0,6820,1.0,1.0,0),
(258516,0,3024,1.0,1.0,0),
(258668,0,2010,1.0,1.0,0),
(268834,0,15101,1.0,1.0,0),
(268864,0,11345,1.0,1.0,0),
(268865,0,1141,1.0,1.0,0),
(268878,0,7899,1.0,1.0,0),
(269104,0,12235,1.0,1.0,0),
(269111,0,145808,1.0,1.0,0),
(277474,0,6820,1.0,1.0,0);
DELETE FROM `creature_classic_level` WHERE `entry` IN (247195,247198,247206,247207,247209,247231,247234,247235,247237,247248,247249,247412,247432,247996,248216,248765,249061,249064,249065,250023,250027,250034,255247,255347,255394,258152,258264,258329,258508,258516,258668,268834,268864,268865,268878,269104,269111,277474);
INSERT INTO `creature_classic_level` (`entry`,`level_min`,`level_max`) VALUES
(247195,58,58),
(247198,58,58),
(247206,58,58),
(247207,58,58),
(247209,58,58),
(247231,58,58),
(247234,60,60),
(247235,55,57),
(247237,55,57),
(247248,55,57),
(247249,55,57),
(247412,55,57),
(247432,55,57),
(247996,55,57),
(248216,55,57),
(248765,55,57),
(249061,55,57),
(249064,55,57),
(249065,55,57),
(250023,55,57),
(250027,55,57),
(250034,55,57),
(255247,55,56),
(255347,55,57),
(255394,55,57),
(258152,55,57),
(258264,55,57),
(258329,55,57),
(258508,55,57),
(258516,55,57),
(258668,55,57),
(268834,55,57),
(268864,55,57),
(268865,55,57),
(268878,55,57),
(269104,55,57),
(269111,55,57),
(277474,55,57);

-- boss scripts, and the two helpers that take part in a fight
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_boss_blackmaw_withermaw' WHERE `entry` = 247195;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_boss_blackmaw_bonesnout' WHERE `entry` = 247198;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_boss_blackmaw_impaan' WHERE `entry` = 247206;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_boss_blackmaw_behemoth' WHERE `entry` = 247207;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_boss_blackmaw_bloodmane' WHERE `entry` = 247209;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_boss_blackmaw_unbound_spirit' WHERE `entry` = 247231;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_boss_blackmaw_varrox' WHERE `entry` = 247234;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_npc_blackmaw_clawbert' WHERE `entry` = 247996;
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_npc_blackmaw_bramblesnap' WHERE `entry` = 248765;

-- gold (INFERRED) and loot ids; summoned adds drop nothing
UPDATE `creature_template_difficulty` SET `GoldMin` = 400, `GoldMax` = 1100, `LootID` = `Entry` WHERE `DifficultyID` = 0 AND `Entry` IN (247235,247237,247248,250023,250027,255347,255394,258152,258264,258329,258508,258516,258668,268834,268864,277474);
UPDATE `creature_template_difficulty` SET `GoldMin` = 2000, `GoldMax` = 4000, `LootID` = `Entry` WHERE `DifficultyID` = 0 AND `Entry` IN (247412,250034,269104,269111);
UPDATE `creature_template_difficulty` SET `GoldMin` = 4000, `GoldMax` = 8000, `LootID` = `Entry` WHERE `DifficultyID` = 0 AND `Entry` IN (247195,247198,247206,247207,247209,247231,247234);

-- the Blackmaw trash items (287028-287036, bind on equip; which items are this dungeon's is read from their names): one roll from the list (chances INFERRED)
DELETE FROM `reference_loot_template` WHERE `Entry` = 2974000;
INSERT INTO `reference_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(2974000,0,287028,0,0,1,1,1,1,'Blackmaw Hold trash item: Tormented Cuffs'),
(2974000,0,287029,0,0,1,1,1,1,'Blackmaw Hold trash item: Nature Guardian''s Legguards'),
(2974000,0,287030,0,0,1,1,1,1,'Blackmaw Hold trash item: Blackmaw Bindings'),
(2974000,0,287031,0,0,1,1,1,1,'Blackmaw Hold trash item: Spearfisher''s Waders'),
(2974000,0,287032,0,0,1,1,1,1,'Blackmaw Hold trash item: Den Champion''s Binding'),
(2974000,0,287033,0,0,1,1,1,1,'Blackmaw Hold trash item: Furbolg Berserker''s Boots'),
(2974000,0,287034,0,0,1,1,1,1,'Blackmaw Hold trash item: Legashi Subjugator''s item'),
(2974000,0,287035,0,0,1,1,1,1,'Blackmaw Hold trash item: Demon Worshipper''s Necklace'),
(2974000,0,287036,0,0,1,1,1,1,'Blackmaw Hold trash item: Satyr''s Touch');
DELETE FROM `creature_loot_template` WHERE `Entry` IN (247195,247198,247206,247207,247209,247231,247234,247412,250034,269104,269111,247235,247237,247248,250023,250027,255347,255394,258152,258264,258329,258508,258516,258668,268834,268864,277474);
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(247206,0,280056,33.3,0,1,1,1,1,'Impaan the Imprisoner: boss item, one each kill (which boss: Everlake; chance INFERRED)'),
(247206,0,280057,33.3,0,1,1,1,1,'Impaan the Imprisoner: boss item, one each kill (which boss: Everlake; chance INFERRED)'),
(247206,0,280058,33.4,0,1,1,1,1,'Impaan the Imprisoner: boss item, one each kill (which boss: Everlake; chance INFERRED)'),
(247198,0,280059,33.3,0,1,1,1,1,'Bonesnout the Unbroken: boss item, one each kill (which boss: Everlake; chance INFERRED)'),
(247198,0,280060,33.3,0,1,1,1,1,'Bonesnout the Unbroken: boss item, one each kill (which boss: Everlake; chance INFERRED)'),
(247198,0,280061,33.4,0,1,1,1,1,'Bonesnout the Unbroken: boss item, one each kill (which boss: Everlake; chance INFERRED)'),
(247195,0,280062,33.3,0,1,1,1,1,'Withermaw: boss item, one each kill (which boss: Everlake; chance INFERRED)'),
(247195,0,280063,33.3,0,1,1,1,1,'Withermaw: boss item, one each kill (which boss: Everlake; chance INFERRED)'),
(247195,0,280064,33.4,0,1,1,1,1,'Withermaw: boss item, one each kill (which boss: Everlake; chance INFERRED)'),
(247207,0,280065,33.3,0,1,1,1,1,'Blackmaw Behemoth: boss item, one each kill (which boss: Everlake; chance INFERRED)'),
(247207,0,280066,33.3,0,1,1,1,1,'Blackmaw Behemoth: boss item, one each kill (which boss: Everlake; chance INFERRED)'),
(247207,0,280067,33.4,0,1,1,1,1,'Blackmaw Behemoth: boss item, one each kill (which boss: Everlake; chance INFERRED)'),
(247209,0,280068,33.3,0,1,1,1,1,'Elder Shaman Bloodmane: boss item, one each kill (which boss: Everlake; chance INFERRED)'),
(247209,0,280069,33.3,0,1,1,1,1,'Elder Shaman Bloodmane: boss item, one each kill (which boss: Everlake; chance INFERRED)'),
(247209,0,280070,33.4,0,1,1,1,1,'Elder Shaman Bloodmane: boss item, one each kill (which boss: Everlake; chance INFERRED)'),
(247231,0,280071,33.3,0,1,1,1,1,'Unbound Spirit: boss item, one each kill (which boss: Everlake; chance INFERRED)'),
(247231,0,280072,33.3,0,1,1,1,1,'Unbound Spirit: boss item, one each kill (which boss: Everlake; chance INFERRED)'),
(247231,0,280073,33.4,0,1,1,1,1,'Unbound Spirit: boss item, one each kill (which boss: Everlake; chance INFERRED)'),
(247234,0,280074,33.3,0,1,1,1,1,'Varrox Bleakhoof: boss item, one each kill (which boss: Everlake; chance INFERRED)'),
(247234,0,280075,33.3,0,1,1,1,1,'Varrox Bleakhoof: boss item, one each kill (which boss: Everlake; chance INFERRED)'),
(247234,0,280076,33.4,0,1,1,1,1,'Varrox Bleakhoof: boss item, one each kill (which boss: Everlake; chance INFERRED)'),
(269111,0,280077,50,0,1,1,1,1,'Gortek the Apprentice: one of two rare items each kill (which rare: INFERRED from the item names)'),
(269111,0,280078,50,0,1,1,1,1,'Gortek the Apprentice: one of two rare items each kill (which rare: INFERRED from the item names)'),
(269104,0,280079,50,0,1,1,1,1,'Moontouched Wanderer: one of two rare items each kill (which rare: INFERRED from the item names)'),
(269104,0,280080,50,0,1,1,1,1,'Moontouched Wanderer: one of two rare items each kill (which rare: INFERRED from the item names)'),
(247412,0,280081,50,0,1,1,1,1,'Mopes: one of two rare items each kill (which rare: INFERRED from the item names)'),
(247412,0,280082,50,0,1,1,1,1,'Mopes: one of two rare items each kill (which rare: INFERRED from the item names)'),
(250034,0,280085,50,0,1,1,1,1,'Tunnelweb Matriarch: one of two rare items each kill (which rare: INFERRED from the item names)'),
(250034,0,280086,50,0,1,1,1,1,'Tunnelweb Matriarch: one of two rare items each kill (which rare: INFERRED from the item names)'),
(247235,1,2974000,3,0,1,0,1,1,'Legashi Subjugator: Blackmaw Hold trash item (chance INFERRED)'),
(247237,1,2974000,3,0,1,0,1,1,'Blackmaw Berserker: Blackmaw Hold trash item (chance INFERRED)'),
(247248,1,2974000,3,0,1,0,1,1,'Legashi Summoner: Blackmaw Hold trash item (chance INFERRED)'),
(250023,1,2974000,3,0,1,0,1,1,'Blackmaw Thrall: Blackmaw Hold trash item (chance INFERRED)'),
(250027,1,2974000,3,0,1,0,1,1,'Blackmaw Headhunter: Blackmaw Hold trash item (chance INFERRED)'),
(255347,1,2974000,3,0,1,0,1,1,'Legashi Slayer: Blackmaw Hold trash item (chance INFERRED)'),
(255394,1,2974000,3,0,1,0,1,1,'Blackmaw Champion: Blackmaw Hold trash item (chance INFERRED)'),
(258152,1,2974000,3,0,1,0,1,1,'Blackmaw Spearfisher: Blackmaw Hold trash item (chance INFERRED)'),
(258264,1,2974000,3,0,1,0,1,1,'Depraved Owlbeast: Blackmaw Hold trash item (chance INFERRED)'),
(258329,1,2974000,3,0,1,0,1,1,'Bloated Grizzly: Blackmaw Hold trash item (chance INFERRED)'),
(258508,1,2974000,3,0,1,0,1,1,'Blackmaw Shaman: Blackmaw Hold trash item (chance INFERRED)'),
(258516,1,2974000,3,0,1,0,1,1,'Blackmaw Druid: Blackmaw Hold trash item (chance INFERRED)'),
(258668,1,2974000,3,0,1,0,1,1,'Legashi Ritualist: Blackmaw Hold trash item (chance INFERRED)'),
(268834,1,2974000,3,0,1,0,1,1,'Bloodstarved Frenzy: Blackmaw Hold trash item (chance INFERRED)'),
(268864,1,2974000,3,0,1,0,1,1,'Legashi Plaguebringer: Blackmaw Hold trash item (chance INFERRED)'),
(277474,1,2974000,3,0,1,0,1,1,'Blackmaw Devotee: Blackmaw Hold trash item (chance INFERRED)');

-- trash and rare abilities (all spells are in the 70938 client; which mob uses which from its name and kind, timers INFERRED)
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` IN (247235,247237,247248,247412,250023,250027,250034,255347,255394,258152,258264,258329,258508,258516,258668,268834,268864,269104,269111,277474);
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` IN (247235,247237,247248,247412,250023,250027,250034,255347,255394,258152,258264,258329,258508,258516,258668,268834,268864,269104,269111,277474);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`Difficulties`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param_string`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`action_param7`,`action_param_string`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_param_string`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(247235,0,0,0,'',0,0,100,0,0,1000,3500,5000,0,'',11,1283362,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Legashi Subjugator - Shadow Bolt on victim (INFERRED timer)'),
(247235,0,1,0,'',0,0,100,0,6000,9000,15000,20000,0,'',11,1283361,0,0,0,0,0,0,'',6,0,0,0,0,'',0,0,0,0,'Legashi Subjugator - Curse of Weakness on a random player (INFERRED timer)'),
(247237,0,0,0,'',0,0,100,0,4000,6000,8000,11000,0,'',11,1283413,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Blackmaw Berserker - Cleave on victim (INFERRED timer)'),
(247237,0,1,0,'',0,0,100,0,7000,10000,14000,18000,0,'',11,1283405,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Blackmaw Berserker - Muscle Tear on victim (INFERRED timer)'),
(247248,0,0,0,'',0,0,100,0,0,1000,3500,5000,0,'',11,1283362,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Legashi Summoner - Shadow Bolt on victim (INFERRED timer)'),
(247412,0,0,0,'',0,0,100,0,0,1000,3500,5000,0,'',11,1283362,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Mopes - Shadow Bolt on victim (INFERRED timer)'),
(247412,0,1,0,'',0,0,100,0,6000,9000,15000,20000,0,'',11,1283361,0,0,0,0,0,0,'',6,0,0,0,0,'',0,0,0,0,'Mopes - Curse of Weakness on a random player (INFERRED timer)'),
(250023,0,0,0,'',0,0,100,0,3000,5000,12000,15000,0,'',11,1283423,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Blackmaw Thrall - Rend on victim (INFERRED timer)'),
(250027,0,0,0,'',9,0,100,0,8,30,12000,16000,0,'',11,1283364,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Blackmaw Headhunter - Net on victim at range (INFERRED timer)'),
(250027,0,1,0,'',0,0,100,0,1000,2000,4000,6000,0,'',11,1283365,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Blackmaw Headhunter - Shadow Shot on victim (INFERRED timer)'),
(250034,0,0,0,'',0,0,100,0,4000,6000,12000,16000,0,'',11,745,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Tunnelweb Matriarch - Web on victim (INFERRED timer)'),
(255347,0,0,0,'',0,0,100,0,5000,7000,9000,12000,0,'',11,1283414,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Legashi Slayer - Mortal Strike on victim (INFERRED timer)'),
(255394,0,0,0,'',0,0,100,0,3000,5000,10000,14000,0,'',11,1283390,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Blackmaw Champion - Sunder Armor on victim (INFERRED timer)'),
(255394,0,1,0,'',9,0,100,0,8,25,15000,20000,0,'',11,1283407,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Blackmaw Champion - Shield Charge on victim at range (INFERRED timer)'),
(258152,0,0,0,'',9,0,100,0,8,30,12000,16000,0,'',11,1283364,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Blackmaw Spearfisher - Net on victim at range (INFERRED timer)'),
(258264,0,0,0,'',0,0,100,0,6000,9000,12000,16000,0,'',11,1283424,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Depraved Owlbeast - Knock Away on victim (INFERRED timer)'),
(258329,0,0,0,'',0,0,100,0,6000,9000,15000,20000,0,'',11,1283425,0,0,0,0,0,0,'',1,0,0,0,0,'',0,0,0,0,'Bloated Grizzly - War Stomp around itself (INFERRED timer)'),
(258508,0,0,0,'',0,0,100,0,0,1000,3500,5000,0,'',11,1283421,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Blackmaw Shaman - Lightning Bolt on victim (INFERRED timer)'),
(258508,0,1,0,'',14,0,100,0,1500,40,8000,12000,0,'',11,1283422,0,0,0,0,0,0,'',7,0,0,0,0,'',0,0,0,0,'Blackmaw Shaman - Healing Wave on an ally missing 1500 health (INFERRED timer)'),
(258516,0,0,0,'',0,0,100,0,0,1000,3500,5000,0,'',11,9739,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Blackmaw Druid - Wrath on victim (INFERRED timer)'),
(258516,0,1,0,'',14,0,100,0,1500,40,8000,12000,0,'',11,1283422,0,0,0,0,0,0,'',7,0,0,0,0,'',0,0,0,0,'Blackmaw Druid - Healing Wave on an ally missing 1500 health (INFERRED timer)'),
(258668,0,0,0,'',0,0,100,0,0,1000,3500,5000,0,'',11,1283362,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Legashi Ritualist - Shadow Bolt on victim (INFERRED timer)'),
(268834,0,0,0,'',0,0,100,0,3000,5000,12000,15000,0,'',11,1283423,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Bloodstarved Frenzy - Rend on victim (INFERRED timer)'),
(268864,0,0,0,'',0,0,100,0,0,1000,3500,5000,0,'',11,1283362,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Legashi Plaguebringer - Shadow Bolt on victim (INFERRED timer)'),
(268864,0,1,0,'',0,0,100,0,6000,9000,15000,20000,0,'',11,1283361,0,0,0,0,0,0,'',6,0,0,0,0,'',0,0,0,0,'Legashi Plaguebringer - Curse of Weakness on a random player (INFERRED timer)'),
(269104,0,0,0,'',0,0,100,0,6000,9000,12000,16000,0,'',11,1283424,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Moontouched Wanderer - Knock Away on victim (INFERRED timer)'),
(269104,0,1,0,'',0,0,100,0,0,1000,3500,5000,0,'',11,9739,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Moontouched Wanderer - Wrath on victim (INFERRED timer)'),
(269111,0,0,0,'',0,0,100,0,0,1000,3500,5000,0,'',11,1283420,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Gortek the Apprentice - Frostbolt on victim (INFERRED timer)'),
(277474,0,0,0,'',0,0,100,0,0,1000,3500,5000,0,'',11,1283421,0,0,0,0,0,0,'',2,0,0,0,0,'',0,0,0,0,'Blackmaw Devotee - Lightning Bolt on victim (INFERRED timer)'),
(277474,0,1,0,'',14,0,100,0,1500,40,8000,12000,0,'',11,1283422,0,0,0,0,0,0,'',7,0,0,0,0,'',0,0,0,0,'Blackmaw Devotee - Healing Wave on an ally missing 1500 health (INFERRED timer)');

-- spawns: Everlake's spot where it is on our walkable mesh at the floor's height, else ours in the room the guides
-- describe (INFERRED). All of them are on the one navmesh piece the landing is on.
DELETE FROM `creature` WHERE `guid` BETWEEN 48130000 AND 48130199;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(48130000,247195,2974,0,0,'1,201',0,0,0,-1,0,0,3694.70,3428.00,302.40,3.274,86400,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Withermaw: Withermaw in the Festering Grotto (spot from Everlake, on our mesh) */,
(48130001,247198,2974,0,0,'1,201',0,0,0,-1,0,0,3386.70,3370.70,249.98,6.044,86400,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Bonesnout the Unbroken: Bonesnout in Bonesnout's Thicket (spot from Everlake, on our mesh) */,
(48130002,247206,2974,0,0,'1,201',0,0,0,-1,0,0,3320.00,3578.70,343.74,0.263,86400,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Impaan the Imprisoner: Impaan on the Defiled Peak (spot from Everlake, on our mesh) */,
(48130003,247235,2974,0,0,'1,201',0,0,0,-1,0,0,3337.30,3394.70,250.36,5.844,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Legashi Subjugator: Bonesnout's Thicket pack (spot from Everlake, on our mesh) */,
(48130004,247235,2974,0,0,'1,201',0,0,0,-1,0,0,3328.00,3394.70,250.71,5.903,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Legashi Subjugator: Bonesnout's Thicket pack (spot from Everlake, on our mesh) */,
(48130005,247235,2974,0,0,'1,201',0,0,0,-1,0,0,3386.70,3320.00,250.78,1.503,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Legashi Subjugator: Bonesnout's Thicket pack (spot from Everlake, on our mesh) */,
(48130006,247235,2974,0,0,'1,201',0,0,0,-1,0,0,3386.70,3328.00,250.77,1.490,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Legashi Subjugator: Bonesnout's Thicket pack (spot from Everlake, on our mesh) */,
(48130007,247237,2974,0,0,'1,201',0,0,0,-1,0,0,3445.30,3578.70,300.57,1.028,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Blackmaw Berserker: Blackmaw Grove pack (spot from Everlake, on our mesh) */,
(48130008,247237,2974,0,0,'1,201',0,0,0,-1,0,0,3445.30,3586.70,301.04,0.873,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Blackmaw Berserker: Blackmaw Grove pack (spot from Everlake, on our mesh) */,
(48130009,247237,2974,0,0,'1,201',0,0,0,-1,0,0,3470.70,3637.30,299.72,4.447,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Blackmaw Berserker: Blackmaw Grove pack (spot from Everlake, on our mesh) */,
(48130010,247237,2974,0,0,'1,201',0,0,0,-1,0,0,3478.70,3637.30,299.64,4.219,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Blackmaw Berserker: Blackmaw Grove pack (spot from Everlake, on our mesh) */,
(48130011,247248,2974,0,0,'1,201',0,0,0,-1,0,0,3328.00,3320.00,262.41,0.677,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Legashi Summoner: Bonesnout's Thicket pack (spot from Everlake, on our mesh) */,
(48130012,247248,2974,0,0,'1,201',0,0,0,-1,0,0,3320.00,3320.00,262.29,0.619,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Legashi Summoner: Bonesnout's Thicket pack (spot from Everlake, on our mesh) */,
(48130013,247248,2974,0,0,'1,201',0,0,0,-1,0,0,3445.30,3386.70,253.31,3.437,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Legashi Summoner: Bonesnout's Thicket pack (spot from Everlake, on our mesh) */,
(48130014,247248,2974,0,0,'1,201',0,0,0,-1,0,0,3437.30,3386.70,253.71,3.484,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Legashi Summoner: Bonesnout's Thicket pack (spot from Everlake, on our mesh) */,
(48130015,247412,2974,0,0,'1,201',0,0,0,-1,0,0,3312.00,3612.00,343.45,5.087,86400,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Mopes: Defiled Peak (spot from Everlake, on our mesh) */,
(48130016,250023,2974,0,0,'1,201',0,0,0,-1,0,0,3494.70,3604.00,296.67,3.041,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Blackmaw Thrall: Blackmaw Grove pack (spot from Everlake, on our mesh) */,
(48130017,250023,2974,0,0,'1,201',0,0,0,-1,0,0,3486.70,3604.00,297.17,3.007,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Blackmaw Thrall: Blackmaw Grove pack (spot from Everlake, on our mesh) */,
(48130018,250023,2974,0,0,'1,201',0,0,0,-1,0,0,3445.30,3620.00,302.33,5.647,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Blackmaw Thrall: Blackmaw Grove pack (spot from Everlake, on our mesh) */,
(48130019,250023,2974,0,0,'1,201',0,0,0,-1,0,0,3445.30,3628.00,302.38,5.406,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Blackmaw Thrall: Blackmaw Grove pack (spot from Everlake, on our mesh) */,
(48130020,250027,2974,0,0,'1,201',0,0,0,-1,0,0,3478.70,3570.70,295.18,1.987,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Blackmaw Headhunter: Blackmaw Grove pack (spot from Everlake, on our mesh) */,
(48130021,250027,2974,0,0,'1,201',0,0,0,-1,0,0,3478.70,3561.30,293.91,1.909,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Blackmaw Headhunter: Blackmaw Grove pack (spot from Everlake, on our mesh) */,
(48130022,250027,2974,0,0,'1,201',0,0,0,-1,0,0,3428.00,3670.70,302.90,5.211,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Blackmaw Headhunter: Blackmaw Grove pack (spot from Everlake, on our mesh) */,
(48130023,250027,2974,0,0,'1,201',0,0,0,-1,0,0,3420.00,3670.70,303.70,5.303,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Blackmaw Headhunter: Blackmaw Grove pack (spot from Everlake, on our mesh) */,
(48130024,255347,2974,0,0,'1,201',0,0,0,-1,0,0,3328.00,3361.30,255.44,0.137,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Legashi Slayer: Bonesnout's Thicket pack (spot from Everlake, on our mesh) */,
(48130025,255347,2974,0,0,'1,201',0,0,0,-1,0,0,3328.00,3370.70,254.03,6.270,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Legashi Slayer: Bonesnout's Thicket pack (spot from Everlake, on our mesh) */,
(48130026,255347,2974,0,0,'1,201',0,0,0,-1,0,0,3337.30,3428.00,256.64,5.450,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Legashi Slayer: Bonesnout's Thicket pack (spot from Everlake, on our mesh) */,
(48130027,255347,2974,0,0,'1,201',0,0,0,-1,0,0,3337.30,3420.00,254.29,5.524,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Legashi Slayer: Bonesnout's Thicket pack (spot from Everlake, on our mesh) */,
(48130028,255394,2974,0,0,'1,201',0,0,0,-1,0,0,3445.30,3545.30,298.46,1.299,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Blackmaw Champion: Blackmaw Grove pack (spot from Everlake, on our mesh) */,
(48130029,255394,2974,0,0,'1,201',0,0,0,-1,0,0,3437.30,3545.30,299.52,1.184,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Blackmaw Champion: Blackmaw Grove pack (spot from Everlake, on our mesh) */,
(48130030,255394,2974,0,0,'1,201',0,0,0,-1,0,0,3512.00,3561.30,297.05,2.393,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Blackmaw Champion: Blackmaw Grove pack (spot from Everlake, on our mesh) */,
(48130031,255394,2974,0,0,'1,201',0,0,0,-1,0,0,3504.00,3561.30,296.05,2.305,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Blackmaw Champion: Blackmaw Grove pack (spot from Everlake, on our mesh) */,
(48130032,258152,2974,0,0,'1,201',0,0,0,-1,0,0,3512.00,3586.70,296.01,5.940,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Blackmaw Spearfisher: by the lake of Blackmaw Stillwater (spot from Everlake, on our mesh) */,
(48130033,258152,2974,0,0,'1,201',0,0,0,-1,0,0,3553.30,3570.70,296.04,2.749,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Blackmaw Spearfisher: by the lake of Blackmaw Stillwater (spot from Everlake, on our mesh) */,
(48130034,258152,2974,0,0,'1,201',0,0,0,-1,0,0,3578.70,3570.70,298.25,2.951,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Blackmaw Spearfisher: by the lake of Blackmaw Stillwater (our spot, INFERRED) */,
(48130035,258264,2974,0,0,'1,201',0,0,0,-1,0,0,3720.00,3394.70,285.68,2.406,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Depraved Owlbeast: Festering Grotto pack (spot from Everlake, on our mesh) */,
(48130036,258264,2974,0,0,'1,201',0,0,0,-1,0,0,3720.00,3386.70,284.17,2.295,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Depraved Owlbeast: Festering Grotto pack (spot from Everlake, on our mesh) */,
(48130037,258264,2974,0,0,'1,201',0,0,0,-1,0,0,3670.70,3353.30,290.45,1.382,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Depraved Owlbeast: Festering Grotto pack (spot from Everlake, on our mesh) */,
(48130038,258264,2974,0,0,'1,201',0,0,0,-1,0,0,3678.70,3353.30,289.59,1.489,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Depraved Owlbeast: Festering Grotto pack (spot from Everlake, on our mesh) */,
(48130039,258264,2974,0,0,'1,201',0,0,0,-1,0,0,3661.30,3478.70,292.25,5.135,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Depraved Owlbeast: Festering Grotto pack (spot from Everlake, on our mesh) */,
(48130040,258264,2974,0,0,'1,201',0,0,0,-1,0,0,3670.70,3478.70,291.77,4.975,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Depraved Owlbeast: Festering Grotto pack (spot from Everlake, on our mesh) */,
(48130041,258329,2974,0,0,'1,201',0,0,0,-1,0,0,3661.30,3437.30,292.23,5.856,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Bloated Grizzly: Festering Grotto pack (spot from Everlake, on our mesh) */,
(48130042,258329,2974,0,0,'1,201',0,0,0,-1,0,0,3653.30,3437.30,292.03,5.956,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Bloated Grizzly: Festering Grotto pack (spot from Everlake, on our mesh) */,
(48130043,258329,2974,0,0,'1,201',0,0,0,-1,0,0,3670.70,3404.00,290.28,1.018,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Bloated Grizzly: Festering Grotto pack (spot from Everlake, on our mesh) */,
(48130044,258329,2974,0,0,'1,201',0,0,0,-1,0,0,3670.70,3412.00,290.68,0.809,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Bloated Grizzly: Festering Grotto pack (spot from Everlake, on our mesh) */,
(48130045,258329,2974,0,0,'1,201',0,0,0,-1,0,0,3728.00,3361.30,284.41,2.156,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Bloated Grizzly: Festering Grotto pack (spot from Everlake, on our mesh) */,
(48130046,258329,2974,0,0,'1,201',0,0,0,-1,0,0,3737.30,3361.30,285.01,2.249,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Bloated Grizzly: Festering Grotto pack (spot from Everlake, on our mesh) */,
(48130047,258508,2974,0,0,'1,201',0,0,0,-1,0,0,3470.70,3528.00,295.57,1.673,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Blackmaw Shaman: Blackmaw Grove pack (spot from Everlake, on our mesh) */,
(48130048,258508,2974,0,0,'1,201',0,0,0,-1,0,0,3470.70,3537.30,295.11,1.687,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Blackmaw Shaman: Blackmaw Grove pack (spot from Everlake, on our mesh) */,
(48130049,258508,2974,0,0,'1,201',0,0,0,-1,0,0,3420.00,3712.00,302.21,5.098,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Blackmaw Shaman: Blackmaw Grove pack (spot from Everlake, on our mesh) */,
(48130050,258508,2974,0,0,'1,201',0,0,0,-1,0,0,3420.00,3704.00,301.76,5.127,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Blackmaw Shaman: Blackmaw Grove pack (spot from Everlake, on our mesh) */,
(48130051,258516,2974,0,0,'1,201',0,0,0,-1,0,0,3561.30,3545.30,295.13,2.581,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Blackmaw Druid: Blackmaw Grove pack (spot from Everlake, on our mesh) */,
(48130052,258516,2974,0,0,'1,201',0,0,0,-1,0,0,3553.30,3545.30,294.49,2.543,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Blackmaw Druid: Blackmaw Grove pack (spot from Everlake, on our mesh) */,
(48130053,258516,2974,0,0,'1,201',0,0,0,-1,0,0,3528.00,3520.00,289.67,2.214,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Blackmaw Druid: Blackmaw Grove pack (spot from Everlake, on our mesh) */,
(48130054,258516,2974,0,0,'1,201',0,0,0,-1,0,0,3537.30,3520.00,290.49,2.279,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Blackmaw Druid: Blackmaw Grove pack (spot from Everlake, on our mesh) */,
(48130055,258668,2974,0,0,'1,201',0,0,0,-1,0,0,3370.70,3378.70,250.63,5.820,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Legashi Ritualist: a Legashi Ritualist shielding Bonesnout (spot from Everlake, on our mesh) */,
(48130056,258668,2974,0,0,'1,201',0,0,0,-1,0,0,3370.70,3361.30,250.14,0.531,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Legashi Ritualist: a Legashi Ritualist shielding Bonesnout (spot from Everlake, on our mesh) */,
(48130057,258668,2974,0,0,'1,201',0,0,0,-1,0,0,3386.70,3353.30,249.54,1.571,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Legashi Ritualist: a Legashi Ritualist shielding Bonesnout (spot from Everlake, on our mesh) */,
(48130058,258668,2974,0,0,'1,201',0,0,0,-1,0,0,3404.00,3370.70,251.21,3.142,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Legashi Ritualist: a Legashi Ritualist shielding Bonesnout (spot from Everlake, on our mesh) */,
(48130059,268834,2974,0,0,'1,201',0,0,0,-1,0,0,3728.00,3453.30,302.96,3.693,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Bloodstarved Frenzy: Festering Grotto pack (spot from Everlake, on our mesh) */,
(48130060,268834,2974,0,0,'1,201',0,0,0,-1,0,0,3720.00,3453.30,302.75,3.788,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Bloodstarved Frenzy: Festering Grotto pack (spot from Everlake, on our mesh) */,
(48130061,268834,2974,0,0,'1,201',0,0,0,-1,0,0,3745.30,3420.00,301.41,3.032,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Bloodstarved Frenzy: Festering Grotto pack (spot from Everlake, on our mesh) */,
(48130062,268834,2974,0,0,'1,201',0,0,0,-1,0,0,3737.30,3420.00,300.26,3.016,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Bloodstarved Frenzy: Festering Grotto pack (spot from Everlake, on our mesh) */,
(48130063,268864,2974,0,0,'1,201',0,0,0,-1,0,0,3337.30,3612.00,343.00,4.335,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Legashi Plaguebringer: Defiled Peak pack (spot from Everlake, on our mesh) */,
(48130064,268864,2974,0,0,'1,201',0,0,0,-1,0,0,3337.30,3620.00,343.68,4.405,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Legashi Plaguebringer: Defiled Peak pack (spot from Everlake, on our mesh) */,
(48130065,268864,2974,0,0,'1,201',0,0,0,-1,0,0,3294.70,3561.30,342.87,0.557,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Legashi Plaguebringer: Defiled Peak pack (spot from Everlake, on our mesh) */,
(48130066,268864,2974,0,0,'1,201',0,0,0,-1,0,0,3286.70,3561.30,342.87,0.457,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Legashi Plaguebringer: Defiled Peak pack (spot from Everlake, on our mesh) */,
(48130067,268864,2974,0,0,'1,201',0,0,0,-1,0,0,3378.70,3537.30,359.91,2.474,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Legashi Plaguebringer: Defiled Peak pack (spot from Everlake, on our mesh) */,
(48130068,268864,2974,0,0,'1,201',0,0,0,-1,0,0,3378.70,3545.30,360.64,2.572,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Legashi Plaguebringer: Defiled Peak pack (spot from Everlake, on our mesh) */,
(48130069,269104,2974,0,0,'1,201',0,0,0,-1,0,0,3306.31,3295.91,263.82,0.718,86400,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Moontouched Wanderer: the Thicket's south-east corner (the guides' rare spot) (our spot, INFERRED) */,
(48130070,247207,2974,0,0,'1,201',0,0,0,-1,0,0,3665.00,2905.00,172.26,2.078,86400,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Blackmaw Behemoth: the Behemoth in the room past the ramp (our spot, INFERRED) */,
(48130071,247209,2974,0,0,'1,201',0,0,0,-1,0,0,3484.98,2968.62,138.75,3.221,86400,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Elder Shaman Bloodmane: Bloodmane in the wide low chamber (our spot, INFERRED) */,
(48130072,247231,2974,0,0,'1,201',0,0,0,-1,0,0,3265.00,2920.00,205.09,2.103,86400,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Unbound Spirit: the Unbound Spirit in its clearing (the west room down the south passage) (our spot, INFERRED) */,
(48130073,247234,2974,0,0,'1,201',0,0,0,-1,0,0,3556.27,2819.47,175.98,5.387,86400,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Varrox Bleakhoof: Varrox in the cave under the pool (our spot, INFERRED) */,
(48130074,247235,2974,0,0,'1,201',0,0,0,-1,0,0,3400.00,2885.00,201.05,0.576,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Legashi Subjugator: a pack in the main cave (our spot, INFERRED) */,
(48130075,247235,2974,0,0,'1,201',0,0,0,-1,0,0,3395.80,2879.07,200.39,0.592,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Legashi Subjugator: a pack in the main cave (our spot, INFERRED) */,
(48130076,247235,2974,0,0,'1,201',0,0,0,-1,0,0,3439.73,2847.82,193.95,1.197,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Legashi Subjugator: a pack in the main cave (our spot, INFERRED) */,
(48130077,247235,2974,0,0,'1,201',0,0,0,-1,0,0,3500.00,3040.00,146.65,4.460,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Legashi Subjugator: a pack in the main cave (spot from Everlake, on our mesh) */,
(48130078,247237,2974,0,0,'1,201',0,0,0,-1,0,0,3300.00,2895.00,206.72,0.211,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Blackmaw Berserker: a pack in the main cave (spot from Everlake, on our mesh) */,
(48130079,247237,2974,0,0,'1,201',0,0,0,-1,0,0,3295.00,2900.00,206.25,0.178,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Blackmaw Berserker: a pack in the main cave (spot from Everlake, on our mesh) */,
(48130080,247237,2974,0,0,'1,201',0,0,0,-1,0,0,3310.00,2935.00,205.32,6.264,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Blackmaw Berserker: a pack in the main cave (spot from Everlake, on our mesh) */,
(48130081,247237,2974,0,0,'1,201',0,0,0,-1,0,0,3305.00,2930.00,205.32,0.011,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Blackmaw Berserker: a pack in the main cave (spot from Everlake, on our mesh) */,
(48130082,247248,2974,0,0,'1,201',0,0,0,-1,0,0,3402.49,2842.22,197.59,0.913,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Legashi Summoner: a pack in the main cave (our spot, INFERRED) */,
(48130083,247248,2974,0,0,'1,201',0,0,0,-1,0,0,3410.00,2840.00,196.24,0.976,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Legashi Summoner: a pack in the main cave (our spot, INFERRED) */,
(48130084,247248,2974,0,0,'1,201',0,0,0,-1,0,0,3465.00,3060.00,165.03,4.768,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Legashi Summoner: a pack in the main cave (spot from Everlake, on our mesh) */,
(48130085,247248,2974,0,0,'1,201',0,0,0,-1,0,0,3470.00,3065.00,165.61,4.729,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Legashi Summoner: a pack in the main cave (spot from Everlake, on our mesh) */,
(48130086,247996,2974,0,0,'1,201',0,0,0,-1,0,0,3660.00,2905.00,172.26,0.423,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Clawbert: Clawbert beside the Behemoth (our spot, INFERRED) */,
(48130087,248765,2974,0,0,'1,201',0,0,0,-1,0,0,3255.00,2910.00,204.34,0.874,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Elder Bramblesnap: Elder Bramblesnap at the clearing, to start the ritual (our spot, INFERRED) */,
(48130088,250034,2974,0,0,'1,201',0,0,0,-1,0,0,3412.32,3054.13,241.35,5.147,86400,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Tunnelweb Matriarch: Tunnelweb Matriarch in the main cave (our spot, INFERRED) */,
(48130089,255347,2974,0,0,'1,201',0,0,0,-1,0,0,3550.00,2985.00,145.18,3.740,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Legashi Slayer: a pack in the main cave (spot from Everlake, on our mesh) */,
(48130090,255347,2974,0,0,'1,201',0,0,0,-1,0,0,3448.44,2835.20,203.55,1.992,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Legashi Slayer: a pack in the main cave (our spot, INFERRED) */,
(48130091,255347,2974,0,0,'1,201',0,0,0,-1,0,0,3340.00,2880.00,207.36,0.374,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Legashi Slayer: a pack in the main cave (spot from Everlake, on our mesh) */,
(48130092,255347,2974,0,0,'1,201',0,0,0,-1,0,0,3335.00,2885.00,207.03,0.329,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Legashi Slayer: a pack in the main cave (spot from Everlake, on our mesh) */,
(48130093,255394,2974,0,0,'1,201',0,0,0,-1,0,0,3619.38,2892.98,172.26,2.897,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Blackmaw Champion: a pack in the main cave (our spot, INFERRED) */,
(48130094,255394,2974,0,0,'1,201',0,0,0,-1,0,0,3625.00,2890.00,172.26,2.874,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Blackmaw Champion: a pack in the main cave (spot from Everlake, on our mesh) */,
(48130095,255394,2974,0,0,'1,201',0,0,0,-1,0,0,3345.00,2985.00,217.52,5.888,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Blackmaw Champion: a pack in the main cave (our spot, INFERRED) */,
(48130096,255394,2974,0,0,'1,201',0,0,0,-1,0,0,3340.00,2990.00,218.18,5.869,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Blackmaw Champion: a pack in the main cave (our spot, INFERRED) */,
(48130097,258508,2974,0,0,'1,201',0,0,0,-1,0,0,3618.00,3076.00,300.34,3.875,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Blackmaw Shaman: a pack in the main cave (our spot, INFERRED) */,
(48130098,258508,2974,0,0,'1,201',0,0,0,-1,0,0,3621.17,3073.51,299.91,3.876,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Blackmaw Shaman: a pack in the main cave (our spot, INFERRED) */,
(48130099,258508,2974,0,0,'1,201',0,0,0,-1,0,0,3560.00,3120.00,171.79,4.275,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Blackmaw Shaman: a pack in the main cave (our spot, INFERRED) */,
(48130100,258508,2974,0,0,'1,201',0,0,0,-1,0,0,3566.53,3127.47,172.14,4.264,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Blackmaw Shaman: a pack in the main cave (our spot, INFERRED) */,
(48130101,268864,2974,0,0,'1,201',0,0,0,-1,0,0,3660.00,2865.00,172.26,2.799,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Legashi Plaguebringer: a pack in the main cave (spot from Everlake, on our mesh) */,
(48130102,268864,2974,0,0,'1,201',0,0,0,-1,0,0,3655.00,2870.00,172.26,2.815,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Legashi Plaguebringer: a pack in the main cave (spot from Everlake, on our mesh) */,
(48130103,268864,2974,0,0,'1,201',0,0,0,-1,0,0,3690.00,2945.00,174.01,3.202,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Legashi Plaguebringer: a pack in the main cave (our spot, INFERRED) */,
(48130104,269111,2974,0,0,'1,201',0,0,0,-1,0,0,3585.78,2928.62,160.17,3.301,86400,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Gortek the Apprentice: Gortek, near the way down to the Behemoth (our spot, INFERRED) */,
(48130105,277474,2974,0,0,'1,201',0,0,0,-1,0,0,3488.53,2966.84,138.75,2.909,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Blackmaw Devotee: Blackmaw Devotees around Bloodmane (the guides: kill them first) (our spot, INFERRED) */,
(48130106,277474,2974,0,0,'1,201',0,0,0,-1,0,0,3493.60,2968.80,139.90,3.170,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Blackmaw Devotee: Blackmaw Devotees around Bloodmane (the guides: kill them first) (our spot, INFERRED) */,
(48130107,277474,2974,0,0,'1,201',0,0,0,-1,0,0,3467.00,2957.00,136.09,0.951,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Blackmaw Devotee: Blackmaw Devotees around Bloodmane (the guides: kill them first) (our spot, INFERRED) */,
(48130108,277474,2974,0,0,'1,201',0,0,0,-1,0,0,3500.44,2961.51,139.64,2.990,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Blackmaw Devotee: Blackmaw Devotees around Bloodmane (the guides: kill them first) (our spot, INFERRED) */,
(48130109,277474,2974,0,0,'1,201',0,0,0,-1,0,0,3502.00,2972.00,142.69,3.339,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Blackmaw Devotee: Blackmaw Devotees around Bloodmane (the guides: kill them first) (our spot, INFERRED) */,
(48130110,277474,2974,0,0,'1,201',0,0,0,-1,0,0,3504.37,2963.09,141.06,3.162,7200,0,0,100,0,NULL,NULL,NULL,NULL,'',NULL,0) /* Blackmaw Devotee: Blackmaw Devotees around Bloodmane (the guides: kill them first) (our spot, INFERRED) */;

-- the way in: the inner end of the furbolg tunnel in Azshara (map 1), where three public guides put the portal (Everlake's
-- spot and height); landing in Blackmaw Grove by the lake, exit 12 y from it (INFERRED spots, on our mesh).
DELETE FROM `world_safe_locs` WHERE `ID` IN (1104126,1104127);
INSERT INTO `world_safe_locs` (`ID`,`MapID`,`LocX`,`LocY`,`LocZ`,`Facing`,`Comment`) VALUES
(1104126,2974,3470.0,3690.0,301.9,1.571,'Blackmaw Hold (dungeon) - entrance inside, Blackmaw Grove (INFERRED)'),
(1104127,1,4525.0,-5058.0,164.55,3.666,'Blackmaw Hold (dungeon) - exit outside, the furbolg tunnel in Azshara (INFERRED)');
DELETE FROM `areatrigger_template` WHERE `IsCustom` = 1 AND `Id` IN (326,327);
INSERT INTO `areatrigger_template` (`Id`,`IsCustom`,`Flags`,`ActionSetId`,`ActionSetFlags`,`VerifiedBuild`) VALUES
(326,1,0,0,0,0),
(327,1,0,0,0,0);
DELETE FROM `areatrigger_template_actions` WHERE `IsCustom` = 1 AND `AreaTriggerId` IN (326,327);
INSERT INTO `areatrigger_template_actions` (`AreaTriggerId`,`IsCustom`,`ActionType`,`ActionParam`,`TargetType`) VALUES
(326,1,2,1104126,5),
(327,1,2,1104127,5);
DELETE FROM `areatrigger_create_properties` WHERE `IsCustom` = 1 AND `Id` IN (326,327);
INSERT INTO `areatrigger_create_properties` (`Id`,`IsCustom`,`AreaTriggerId`,`IsAreatriggerCustom`,`Flags`,`MoveCurveId`,`ScaleCurveId`,`MorphCurveId`,`FacingCurveId`,`AnimId`,`AnimKitId`,`DecalPropertiesId`,`SpellForVisuals`,`PositionalSoundKitId`,`TimeToTargetScale`,`Speed`,`SpeedIsTime`,`Shape`,`ShapeData0`,`ShapeData1`,`ShapeData2`,`ShapeData3`,`ShapeData4`,`ShapeData5`,`ShapeData6`,`ShapeData7`,`Roll`,`Pitch`,`Yaw`,`TargetRoll`,`TargetPitch`,`TargetYaw`,`ScriptName`,`VerifiedBuild`) VALUES
(326,1,326,1,0,0,0,0,0,-1,0,0,NULL,0,0,0,0,0,5,5,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,'',0),
(327,1,327,1,0,0,0,0,0,-1,0,0,NULL,0,0,0,0,0,4,4,0,0,0,0,0,0,0,0,0,NULL,NULL,NULL,'',0);
DELETE FROM `areatrigger` WHERE `SpawnId` IN (36,37);
INSERT INTO `areatrigger` (`SpawnId`,`AreaTriggerCreatePropertiesId`,`IsCustom`,`MapId`,`SpawnDifficulties`,`PosX`,`PosY`,`PosZ`,`Orientation`,`PhaseUseFlags`,`PhaseId`,`PhaseGroup`,`ScriptName`,`Comment`,`VerifiedBuild`) VALUES
(36,326,1,1,'0',4541.9,-5048.0,167.57,0,1,0,0,'','Blackmaw Hold - dungeon entrance (the furbolg tunnel, Azshara; spot from Everlake)',0),
(37,327,1,2974,'1,201',3470.0,3678.0,301.27,0,1,0,0,'','Blackmaw Hold (dungeon) - exit (Blackmaw Grove, INFERRED spot)',0);

-- ghosts release to Azshara's Bitter Reaches graveyard (the nearest one to the tunnel)
DELETE FROM `graveyard_zone` WHERE `GhostZone` = 16554;
INSERT INTO `graveyard_zone` (`ID`,`GhostZone`,`Comment`) VALUES
(630,16554,'Blackmaw Hold (dungeon) - Azshara, Bitter Reaches GY');

-- .tele
DELETE FROM `game_tele` WHERE `name` IN ('BlackmawHold','BlackmawHoldEntrance');
INSERT INTO `game_tele` (`id`,`position_x`,`position_y`,`position_z`,`orientation`,`map`,`name`) VALUES
(2356,3470.0,3690.0,301.9,1.571,2974,'BlackmawHold'),
(2357,4525.0,-5058.0,164.55,3.666,1,'BlackmawHoldEntrance');
