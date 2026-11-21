-- WoW Forever, Thousand Needles shaman chain, the missing end: With Wind Beneath Your Wings 79365, Heed My Call 79366 and The
-- Tempest's Weapons 79442. Storm, Earth, and Fire 79361 pointed at 79366, which did not exist, so the chain stopped there.
-- Built from the live record: EG Link (Efficient Games, https://efficient.games, CC BY 4.0, github.com/JIVESCORP/eg-link-output-wowf,
-- quests.enUS 70959 for the quests, npcs 70888 for givers and turn-ins, creature_details for Ravaging Tempest), and Wowhead
-- Forever (map points of the ritual NPCs, the Cleansing Ritual spell 1282953 = Corrupted Totems 268582, "Send Script Event 102554",
-- and players' write-ups of the event). Changed: converted to our tables; reward texts are placeholders.
--  * Heed My Call: at the summoning circle by the steam pools north-west of Freewind Post (Thousand Needles 36.7,39.3) the
--    Corrupted Totems start four timed waves of two Ravaging elementals (level 38), then the elite Ailgrha Splittusk (38) and
--    the elite Ravaging Tempest (40), which drops the Eye of the Tempest 212792 for the quest. Players report the waves come on a
--    timer and leave after about a minute if ignored, which is what event_scripts 102554 below does.
-- INFERRED, check in game: the wave order and the 45 s spacing (players don't agree on the order), the despawn times and the
--    spots (Wowhead map points turned into world spots with the Thousand Needles map fit checked on Rau Cliffrunner; heights
--    measured on dev). Ravaging Tempest copies its stats from the Ravaging Storm Elemental; its knockback is not scripted. The shaman class mask matches the rest of the chain.
-- Safe to run again.

-- 79365 With Wind Beneath Your Wings (live record build 70959): Bathrah gives it (live), Rau Cliffrunner takes it
DELETE FROM `quest_template` WHERE `ID`=79365;
INSERT INTO `quest_template` (`ID`,`QuestType`,`LogTitle`,`VerifiedBuild`) VALUES (79365,2,'With Wind Beneath Your Wings',-1);
DELETE FROM `quest_classic_level` WHERE `ID`=79365;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (79365,40,30,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=79365;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (79365,2,40);
DELETE FROM `quest_template_addon` WHERE `ID`=79365;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (79365,0,64,0);
DELETE FROM `quest_offer_reward` WHERE `ID`=79365;
INSERT INTO `quest_offer_reward` (`ID`,`RewardText`,`VerifiedBuild`) VALUES (79365,'Thank you, $n.',-1);
DELETE FROM `creature_queststarter` WHERE `quest`=79365;
DELETE FROM `gameobject_queststarter` WHERE `quest`=79365;
DELETE FROM `creature_questender` WHERE `quest`=79365;
DELETE FROM `gameobject_questender` WHERE `quest`=79365;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (6176,79365,70888);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (4722,79365,70888);
UPDATE `quest_template` SET `QuestDescription`='Here mon, a Squall-breakers Potion be what you need. Drink this to protect yourself against the elements of the storm, but remember it only goin'' to last for a short while.$B$BNow go, return to your friends in need. There''s nothing more I can do for you.', `LogDescription`='Return to Rau Cliffrunner in Thousand Needles at Freewind Post.', `AreaDescription`='', `QuestCompletionLog`='', `QuestSortID`=-82, `QuestInfoID`=0, `RewardNextQuest`=0, `RewardXPDifficulty`=0, `RewardXPMultiplier`=1.0, `StartItem`=212982, `Flags`=36700160, `FlagsEx`=0, `AllowableRaces`=12261800583900083122, `TimeAllowed`=0, `VerifiedBuild`=70959 WHERE `ID`=79365 AND `VerifiedBuild`=-1;
DELETE FROM `quest_objectives` WHERE `QuestID`=79365;
DELETE FROM `quest_classic_money` WHERE `ID`=79365;

-- 79366 Heed My Call (live record build 70959): Prate Cloudseer gives it, Rau Cliffrunner takes it
DELETE FROM `quest_template` WHERE `ID`=79366;
INSERT INTO `quest_template` (`ID`,`QuestType`,`LogTitle`,`VerifiedBuild`) VALUES (79366,2,'Heed My Call',-1);
DELETE FROM `quest_classic_level` WHERE `ID`=79366;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (79366,40,30,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=79366;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (79366,2,40);
DELETE FROM `quest_template_addon` WHERE `ID`=79366;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (79366,0,64,79361);
DELETE FROM `quest_offer_reward` WHERE `ID`=79366;
INSERT INTO `quest_offer_reward` (`ID`,`RewardText`,`VerifiedBuild`) VALUES (79366,'Thank you, $n.',-1);
DELETE FROM `creature_queststarter` WHERE `quest`=79366;
DELETE FROM `gameobject_queststarter` WHERE `quest`=79366;
DELETE FROM `creature_questender` WHERE `quest`=79366;
DELETE FROM `gameobject_questender` WHERE `quest`=79366;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (5905,79366,70888);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (4722,79366,70888);
UPDATE `quest_template` SET `QuestDescription`='Now that you have the twisted totems, we must wield them to summon forth the corrupted elementals the quilboar are calling upon. Defeat them to cleanse these lands and put an end to the Razormane''s abominable ritual then report back to Rau Cliffrunner with your success.\n\nYou should begin your clensing at the steam pools to the west. That area is rich with each of the elements. But be careful, $n. The quilboar will not sit idly while you interrupt their plans.', `LogDescription`='Use the Twisted Totems to put an end to the quilboar ritual.', `AreaDescription`='', `QuestCompletionLog`='Return to Rau Cliffrunner in Freewind Post and report what happened.', `QuestSortID`=-82, `QuestInfoID`=1, `RewardNextQuest`=79442, `RewardXPDifficulty`=5, `RewardXPMultiplier`=1.0, `StartItem`=268582, `Flags`=33554432, `FlagsEx`=0, `AllowableRaces`=12261800583900083122, `TimeAllowed`=0, `VerifiedBuild`=70959 WHERE `ID`=79366 AND `VerifiedBuild`=-1;
DELETE FROM `quest_objectives` WHERE `QuestID`=79366;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES (446124,79366,1,0,0,212792,1,0,0,0,0,0,1,NULL,70959),(478202,79366,1,1,1,268582,1,0,0,0,0,0,1,NULL,70959);
DELETE FROM `quest_classic_money` WHERE `ID`=79366;
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES (79366,5000,0);

-- 79442 The Tempest's Weapons (live record build 70959): Rau Cliffrunner gives it, Bathrah the Windwatcher takes it
DELETE FROM `quest_template` WHERE `ID`=79442;
INSERT INTO `quest_template` (`ID`,`QuestType`,`LogTitle`,`VerifiedBuild`) VALUES (79442,2,'The Tempest''s Weapons',-1);
DELETE FROM `quest_classic_level` WHERE `ID`=79442;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (79442,40,30,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=79442;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (79442,2,40);
DELETE FROM `quest_template_addon` WHERE `ID`=79442;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (79442,0,64,79366);
DELETE FROM `quest_offer_reward` WHERE `ID`=79442;
INSERT INTO `quest_offer_reward` (`ID`,`RewardText`,`VerifiedBuild`) VALUES (79442,'Thank you, $n.',-1);
DELETE FROM `creature_queststarter` WHERE `quest`=79442;
DELETE FROM `gameobject_queststarter` WHERE `quest`=79442;
DELETE FROM `creature_questender` WHERE `quest`=79442;
DELETE FROM `gameobject_questender` WHERE `quest`=79442;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (4722,79442,70888);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (6176,79442,70888);
UPDATE `quest_template` SET `QuestDescription`='Our people cannot thank you enough, but I have no real use for this eye. I have heard of an old shaman in the Alterac mountains that has an eye for storm elemental magic. Perhaps he may be able to craft something for you.', `LogDescription`='Deliver the Eye of the Tempest to Bath''rah the Windwatcher in Alterac Mountains.', `AreaDescription`='', `QuestCompletionLog`='', `QuestSortID`=-82, `QuestInfoID`=0, `RewardNextQuest`=0, `RewardXPDifficulty`=6, `RewardXPMultiplier`=1.0, `StartItem`=212792, `Flags`=36700160, `FlagsEx`=0, `AllowableRaces`=12261800583900083122, `TimeAllowed`=0, `VerifiedBuild`=70959, `RewardItem1`=280696, `RewardAmount1`=1, `RewardChoiceItemID1`=280607, `RewardChoiceItemQuantity1`=1, `RewardChoiceItemID2`=280605, `RewardChoiceItemQuantity2`=1, `RewardChoiceItemID3`=280604, `RewardChoiceItemQuantity3`=1 WHERE `ID`=79442 AND `VerifiedBuild`=-1;
DELETE FROM `quest_objectives` WHERE `QuestID`=79442;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES (446260,79442,1,0,0,212792,1,0,0,0,0,0,1,NULL,70959);
DELETE FROM `quest_classic_money` WHERE `ID`=79442;
-- 216474 Ravaging Tempest (live record: elite, elemental, mage class, health x2, model 5561 at scale 2, level 40): copy of 278382
-- Ravaging Storm Elemental; drops the Eye of the Tempest 212792 for Heed My Call (party loot, as players report)
DELETE FROM `creature_template` WHERE `entry`=216474;
DELETE FROM `creature_template_model` WHERE `CreatureID`=216474;
DELETE FROM `creature_template_difficulty` WHERE `Entry`=216474;
DELETE FROM `creature_classic_level` WHERE `entry`=216474;
INSERT INTO `creature_template` (`entry`,`KillCredit1`,`KillCredit2`,`name`,`femaleName`,`subname`,`TitleAlt`,`IconName`,`RequiredExpansion`,`VignetteID`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`scale`,`Classification`,`dmgschool`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,`unit_flags`,`unit_flags2`,`unit_flags3`,`family`,`trainer_class`,`type`,`VehicleId`,`AIName`,`MovementType`,`ExperienceModifier`,`RacialLeader`,`movementId`,`WidgetSetID`,`WidgetSetUnitConditionID`,`RegenHealth`,`CreatureImmunitiesId`,`flags_extra`,`ScriptName`,`StringId`,`VerifiedBuild`) SELECT 216474,0,0,'Ravaging Tempest',`femaleName`,NULL,`TitleAlt`,`IconName`,`RequiredExpansion`,`VignetteID`,`faction`,0,`speed_walk`,`speed_run`,`scale`,1,`dmgschool`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,8,`unit_flags`,`unit_flags2`,`unit_flags3`,0,`trainer_class`,4,`VehicleId`,'',`MovementType`,`ExperienceModifier`,`RacialLeader`,`movementId`,`WidgetSetID`,`WidgetSetUnitConditionID`,`RegenHealth`,`CreatureImmunitiesId`,`flags_extra`,'',`StringId`,70959 FROM `creature_template` WHERE `entry`=278382;
INSERT INTO `creature_template_model` (`CreatureID`,`Idx`,`CreatureDisplayID`,`DisplayScale`,`Probability`,`VerifiedBuild`) VALUES (216474,0,5561,2.0,1.0,70959);
INSERT INTO `creature_template_difficulty` (`Entry`,`DifficultyID`,`LevelScalingDeltaMin`,`LevelScalingDeltaMax`,`ContentTuningID`,`HealthScalingExpansion`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`DamageModifier`,`CreatureDifficultyID`,`TypeFlags`,`TypeFlags2`,`TypeFlags3`,`LootID`,`PickPocketLootID`,`SkinLootID`,`GoldMin`,`GoldMax`,`StaticFlags1`,`StaticFlags2`,`StaticFlags3`,`StaticFlags4`,`StaticFlags5`,`StaticFlags6`,`StaticFlags7`,`StaticFlags8`,`VerifiedBuild`) SELECT 216474,`DifficultyID`,`LevelScalingDeltaMin`,`LevelScalingDeltaMax`,`ContentTuningID`,`HealthScalingExpansion`,2.0,`ManaModifier`,`ArmorModifier`,`DamageModifier`,265961,134217728,67108864,`TypeFlags3`,216474,0,0,`GoldMin`,`GoldMax`,`StaticFlags1`,`StaticFlags2`,`StaticFlags3`,`StaticFlags4`,`StaticFlags5`,`StaticFlags6`,`StaticFlags7`,`StaticFlags8`,70959 FROM `creature_template_difficulty` WHERE `Entry`=278382 AND `DifficultyID`=0;
INSERT INTO `creature_classic_level` (`entry`,`level_min`,`level_max`) VALUES (216474,40,40);
DELETE FROM `creature_loot_template` WHERE `Entry`=216474;
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(216474,0,212792,100,1,1,0,1,1,'Eye of the Tempest (Heed My Call 79366)');

-- Cleansing Ritual (spell 1282953, cast by the Corrupted Totems 268582) sends script event 102554: the waves at the circle.
-- Each row summons one creature at a fixed spot near the circle (TEMPSUMMON_TIMED_OR_DEAD_DESPAWN). Heights measured on dev
-- (.playerbot groundz, 2026-11-20); the -5128.3 spots use the ground under a rock overhang. The circle itself is at z -43.97.
DELETE FROM `event_scripts` WHERE `id`=102554;
INSERT INTO `event_scripts` (`id`,`delay`,`command`,`datalong`,`datalong2`,`dataint`,`x`,`y`,`z`,`o`,`Comment`) VALUES
(102554,0,10,278383,60000,0,-5113.6,-2048.1,-42.57,3.1,'Heed My Call: wave 1 Ravaging Quake Elemental'),
(102554,0,10,278383,60000,0,-5125.3,-2052.5,-46.77,0.4,'Heed My Call: wave 1 Ravaging Quake Elemental'),
(102554,45,10,278382,60000,0,-5110.7,-2056.9,-43.09,2.4,'Heed My Call: wave 2 Ravaging Storm Elemental'),
(102554,45,10,278382,60000,0,-5128.3,-2043.7,-48.86,5.6,'Heed My Call: wave 2 Ravaging Storm Elemental'),
(102554,90,10,278388,60000,0,-5110.7,-2043.7,-42.31,3.9,'Heed My Call: wave 3 Ravaging Drought Elemental'),
(102554,90,10,278388,60000,0,-5128.3,-2052.5,-47.08,0.8,'Heed My Call: wave 3 Ravaging Drought Elemental'),
(102554,135,10,278384,60000,0,-5104.8,-2048.1,-43.53,3.1,'Heed My Call: wave 4 Ravaging Flood Elemental'),
(102554,135,10,278384,60000,0,-5125.3,-2043.7,-46.17,5.6,'Heed My Call: wave 4 Ravaging Flood Elemental'),
(102554,180,10,216463,300000,0,-5128.3,-2048.1,-48.35,0.0,'Heed My Call: final wave Ailgrha Splittusk (elite)'),
(102554,180,10,216474,300000,0,-5113.6,-2048.1,-42.57,3.1,'Heed My Call: final wave Ravaging Tempest (elite, drops the Eye of the Tempest)');
