-- Two Discord reports, 2026-11-19. Safe to run more than once.
--
-- 1. Cooking stopped at 225 (nek0207). The Expert Cookbook gives Expert Cooking (3413, cap 225); the next rank, Artisan Cooking
--    (18260, cap 300), had no trainer at all on our server, so recipes up to 300 could never be reached. In the original game
--    Dirge Quikcleave (8125, Gadgetzan) trains it. He gets a trainer (1008125) with Artisan Cooking only, the trainer flags
--    and a "Train me." gossip option like Stephen Ryback's. Cost 25000 and skill 200 from the existing Artisan Cooking trainer
--    row (582); level 35 is the original Artisan rule (INFERRED, live gives no trainer data for him).
DELETE FROM `trainer` WHERE `Id` = 1008125;
INSERT INTO `trainer` (`Id`, `Type`, `Greeting`, `VerifiedBuild`) VALUES
(1008125, 2, 'Can I teach you how to turn the meat you find on beasts into a feast?', 0);
DELETE FROM `trainer_spell` WHERE `TrainerId` = 1008125;
INSERT INTO `trainer_spell` (`TrainerId`, `SpellId`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqAbility1`, `ReqAbility2`, `ReqAbility3`, `ReqLevel`, `VerifiedBuild`) VALUES
(1008125, 18260, 25000, 185, 200, 0, 0, 0, 35, 0);
DELETE FROM `creature_trainer` WHERE `CreatureID` = 8125;
INSERT INTO `creature_trainer` (`CreatureID`, `TrainerID`, `MenuID`, `OptionID`) VALUES (8125, 1008125, 4746, 1);
DELETE FROM `gossip_menu_option` WHERE `MenuID` = 4746 AND `OptionID` = 1;
INSERT INTO `gossip_menu_option` (`MenuID`, `GossipOptionID`, `OptionID`, `OptionNpc`, `OptionText`, `OptionBroadcastTextID`, `Language`, `Flags`,
 `ActionMenuID`, `ActionPoiID`, `GossipNpcOptionID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `SpellID`, `OverrideIconID`, `VerifiedBuild`) VALUES
(4746, 93151873, 1, 3, 'Train me.', 3266, 0, 0, 0, 0, NULL, 0, 0, '', 0, NULL, NULL, 0);
UPDATE `creature_template` SET `npcflag` = `npcflag` | 16 | 64 WHERE `entry` = 8125;
--
-- 2. Excavation Site: Wetlands (map 2998), Voldemar's list.
-- a) Dragonmaw Dispatch (284844) dropped for everyone. On live it is a quest item of the Dragonmaw Thaumaturgist (275046)
--    (questItems in the live creature data, Efficient Games, CC BY 4.0), so it drops only for players on its quest.
UPDATE `creature_loot_template` SET `QuestRequired` = 1 WHERE `Entry` = 275046 AND `Item` = 284844;
-- b) Horrible Rootcore (270180) for Horrors in the Highland (95646) dropped at 60 %, the Wowhead rate over all kills, most of them
--    by players without the quest. The quest needs one root core from the one Highland Horror, and live lists it as that
--    creature's quest item: it now always drops for players on the quest.
UPDATE `creature_loot_template` SET `Chance` = 100 WHERE `Entry` = 260808 AND `Item` = 270180 AND `QuestRequired` = 1;
-- c) Daewyn Songblade (262465) and the Dwarf Miners (261385) are corpses (their template carries the "show as dead" flag), but this
--    client shows that flag standing up. They now lie dead (stand state 7, like Mountaineer Ylva 269153); interaction stays as it was,
--    so Daewyn still gives and takes her quests.
INSERT INTO `creature_template_addon` (`entry`, `StandState`) VALUES (262465, 7), (261385, 7) ON DUPLICATE KEY UPDATE `StandState` = 7;
-- d) Two Dwarf Excavators (261603) stood on one spot (26160301 and 26160302, 0.2 yd apart, the same import twice). One goes.
DELETE FROM `creature_addon` WHERE `guid` = 26160302;
DELETE FROM `creature` WHERE `guid` = 26160302 AND `id` = 261603;
