-- WoW Forever: 95924 Panic at the Digsite (The Shaper's Terrace) had no giver or turn-in (held in 2026_11_19_72). The live
-- quest record (seen 2026-11-20): it starts and ends at Curator Thorius (8256, Hall of Explorers, Ironforge). The reward text is a
-- short placeholder (VerifiedBuild -1 marks it), as for the Alcaz Prison quests. Safe to run again.

DELETE FROM `creature_queststarter` WHERE `quest`=95924;
DELETE FROM `creature_questender` WHERE `quest`=95924;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (8256,95924,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (8256,95924,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry`=8256;

DELETE FROM `quest_offer_reward` WHERE `ID`=95924 AND `VerifiedBuild`=-1;
INSERT IGNORE INTO `quest_offer_reward` (`ID`,`RewardText`,`VerifiedBuild`) VALUES (95924,'Well done, $n. Thank you.',-1);
