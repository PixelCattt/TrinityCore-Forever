-- WoW Forever: Alcaz Prison quests (map 2994). Needs 2026_11_14_40 and 2026_11_14_41 (templates, spawns, the quest drops).
-- Quest records as players' clients got them from the live realm: two from a player's game cache (Cache.zip, build 70888:
-- 96381, 96335) and three from EG Link. Data from Efficient Games (https://efficient.games), licensed under CC BY 4.0
-- (https://creativecommons.org/licenses/by/4.0/). Source: github.com/JIVESCORP/eg-link-output-wowf, build 1.60.1.70862.
-- Changed: picked and converted to our tables. The records carry no giver or turn-in and no reward text: givers and turn-ins
-- come from the quest texts (each quest says which), the reward text is a short placeholder (VerifiedBuild -1 marks it).
-- New spawns (INFERRED spots): Sergeant Ulka on Alcaz Island by the prison entrance (guid 48120200); Commander Folkar and
-- Mason Connery are spawned inside by 2026_11_14_41. Both Kor'kron are immune to players and NPCs (Orgrimmar faction next
-- to Theramore).
-- Held (not built): 95262 The Secret Prison (its second objective is credit NPC 264861, which no cache has, and needs a
-- script), 95263 Somber News (follows 95262 and 96335; giver is not an NPC: the text is in brackets), 96337 More Valuable
-- Than Gold and 96377 State Secrets (Mason Connery's treasure, game object 653847, is not in our data), 96772 The Dragon's
-- Journal (Archmage Lan'dalock 264499 is not spawned; his journal drops from Blazeroar already), 95194 Our Man in Theramore
-- and 95284 The Elite of the Elite (lead-ins whose next quests 95196/95285 nobody has recorded). 96335 keeps its real next
-- quest (95263); until 95263 is built the server notes that at start-up and ignores it.
-- Safe to run again.

-- 96381 A Bit of Wet Work: giver and turn-in Sully McCleary (the quest text and log name him)
DELETE FROM `quest_template` WHERE `ID`=96381;
INSERT INTO `quest_template` (`ID`,`QuestType`,`LogTitle`,`VerifiedBuild`) VALUES (96381,2,'A Bit of Wet Work',-1);
UPDATE `quest_template` SET `QuestDescription`='Was spyin'' on the shore of Alcaz with my trusty lookin'' glass whilst you were off eavesdroppin'' on Lady Proudmoore. I think the island may be under attack. I saw naga--lots of them, chargin'' onto shore. \n\nThe enemy of my enemy is certainly not my friend when it comes to naga, so let''s do the world a favor and take some of them out. I also spied what looks to be the leader--a spellcaster type barkin'' orders. Take her out as well, if you can.', `LogDescription`='Enter the Alcaz Prison and slay $1oa  Strashasz Soldiers, $2oa Strashaz Enchantresses, and bring the head of Tidemistress Ca''zass to Sully McCleary.', `QuestSortID`=16620, `QuestInfoID`=81, `RewardNextQuest`=0, `RewardXPDifficulty`=5, `RewardXPMultiplier`=2.2, `StartItem`=0, `Flags`=2097160, `AllowableRaces`=6130900294268439629, `VerifiedBuild`=70888, `RewardChoiceItemID1`=279825, `RewardChoiceItemQuantity1`=1, `RewardChoiceItemID2`=279826, `RewardChoiceItemQuantity2`=1, `RewardChoiceItemID3`=279829, `RewardChoiceItemQuantity3`=1, `RewardFactionID1`=72, `RewardFactionValue1`=5, `RewardFactionID2`=47, `RewardFactionValue2`=5 WHERE `ID`=96381;
DELETE FROM `quest_classic_level` WHERE `ID`=96381;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (96381,53,48,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=96381;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (96381,2,53);
DELETE FROM `quest_template_addon` WHERE `ID`=96381;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (96381,0,0,0);
DELETE FROM `quest_offer_reward` WHERE `ID`=96381;
INSERT INTO `quest_offer_reward` (`ID`,`RewardText`,`VerifiedBuild`) VALUES (96381,'Well done, $n. Thank you.',-1);
DELETE FROM `quest_classic_money` WHERE `ID`=96381;
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES (96381,8000,0);
DELETE FROM `quest_objectives` WHERE `QuestID`=96381;
DELETE FROM `quest_objectives` WHERE `ID` IN (473005,473006,473007);
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES (473005,96381,0,0,0,255995,15,0,32,0,0.0,0,1,NULL,70888),(473006,96381,0,1,4,255373,8,0,32,0,0.0,0,1,NULL,70888),(473007,96381,1,2,5,273883,1,0,32,1,0.0,0,1,NULL,70888);
DELETE FROM `creature_queststarter` WHERE `quest`=96381;
DELETE FROM `creature_questender` WHERE `quest`=96381;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (260146,96381,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (260146,96381,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (260146,260146);

-- 96335 The Man in the Iron Chains: giver and turn-in Mason Connery (the quest text: he is in a ball and chain and speaks after the dragon)
DELETE FROM `quest_template` WHERE `ID`=96335;
INSERT INTO `quest_template` (`ID`,`QuestType`,`LogTitle`,`VerifiedBuild`) VALUES (96335,2,'The Man in the Iron Chains',-1);
UPDATE `quest_template` SET `QuestDescription`='Wow! That was impressive. The way you took down that dragon was really something!\n\nWhile you are here... do you think you might be able to help me get out of this ball and chain?\n\nIf he hasn''t fled or been killed already, the torturer they call ''The Questioner'' should have the keys to these shackles. Get the key from that sadist and bring it to me.\n\nI promise that I''ll make it well worth your while if you do.', `LogDescription`='Recover the Alcaz Shackle Key from The Questioner in Alcaz Prison.', `QuestSortID`=16620, `QuestInfoID`=81, `RewardNextQuest`=95263, `RewardXPDifficulty`=2, `RewardXPMultiplier`=2.2, `StartItem`=0, `Flags`=2097152, `AllowableRaces`=18446744073709551615, `VerifiedBuild`=70888 WHERE `ID`=96335;
DELETE FROM `quest_classic_level` WHERE `ID`=96335;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (96335,53,48,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=96335;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (96335,2,53);
DELETE FROM `quest_template_addon` WHERE `ID`=96335;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (96335,0,0,0);
DELETE FROM `quest_offer_reward` WHERE `ID`=96335;
INSERT INTO `quest_offer_reward` (`ID`,`RewardText`,`VerifiedBuild`) VALUES (96335,'Well done, $n. Thank you.',-1);
DELETE FROM `quest_classic_money` WHERE `ID`=96335;
DELETE FROM `quest_objectives` WHERE `QuestID`=96335;
DELETE FROM `quest_objectives` WHERE `ID` IN (472871);
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES (472871,96335,1,0,2,274029,1,0,32,1,0.0,0,1,NULL,70888);
DELETE FROM `creature_queststarter` WHERE `quest`=96335;
DELETE FROM `creature_questender` WHERE `quest`=96335;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (264770,96335,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (264770,96335,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (264770,264770);

-- 96332 A Little Payback: turn-in Sergeant Ulka (the log names him); giver INFERRED as Ulka too (the text is a Kor'kron who fell back from the keep)
DELETE FROM `quest_template` WHERE `ID`=96332;
INSERT INTO `quest_template` (`ID`,`QuestType`,`LogTitle`,`VerifiedBuild`) VALUES (96332,2,'A Little Payback',-1);
UPDATE `quest_template` SET `QuestDescription`='A second wave of Naga was approaching the keep when we were falling back. I suspect that the battle is still raging inside. \n\nWe Kor''kron play blood for blood. If you are going in there anyway, I want you to kill any Naga you see. I saw a sorceress among them as well, and you can bet that was their leader. Bring me her head.\n\nWe lost a lot of good orcs today and I won''t rest easy knowing that we didn''t give as good as we got.', `LogDescription`='Enter the Alcaz Prison and slay $1oa Strashasz Soldiers, $2oa Strashaz Enchantresses, and bring the head of Tidemistress Ca''zass to Sergeant Ulka.', `QuestSortID`=16620, `QuestInfoID`=81, `RewardNextQuest`=0, `RewardXPDifficulty`=5, `RewardXPMultiplier`=1.85, `StartItem`=0, `Flags`=2097160, `AllowableRaces`=12261800583900083122, `VerifiedBuild`=70862, `RewardChoiceItemID1`=279824, `RewardChoiceItemQuantity1`=1, `RewardChoiceItemID2`=279826, `RewardChoiceItemQuantity2`=1, `RewardChoiceItemID3`=279829, `RewardChoiceItemQuantity3`=1, `RewardFactionID1`=76, `RewardFactionValue1`=4 WHERE `ID`=96332;
DELETE FROM `quest_classic_level` WHERE `ID`=96332;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (96332,53,48,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=96332;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (96332,2,53);
DELETE FROM `quest_template_addon` WHERE `ID`=96332;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (96332,0,0,0);
DELETE FROM `quest_offer_reward` WHERE `ID`=96332;
INSERT INTO `quest_offer_reward` (`ID`,`RewardText`,`VerifiedBuild`) VALUES (96332,'Well done, $n. Thank you.',-1);
DELETE FROM `quest_classic_money` WHERE `ID`=96332;
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES (96332,8000,0);
DELETE FROM `quest_objectives` WHERE `QuestID`=96332;
DELETE FROM `quest_objectives` WHERE `ID` IN (472861,472862,472863);
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES (472861,96332,0,0,1,255995,15,0,32,0,0.0,0,1,NULL,70862),(472862,96332,0,1,2,255373,8,0,32,0,0.0,0,1,NULL,70862),(472863,96332,1,2,3,273883,1,0,32,0,0.0,0,1,NULL,70862);
DELETE FROM `creature_queststarter` WHERE `quest`=96332;
DELETE FROM `creature_questender` WHERE `quest`=96332;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (260383,96332,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (260383,96332,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (260383,260383);

-- 96334 Blood Red Bandanas: turn-in Eitrigg in Orgrimmar (the text names him); giver INFERRED as Sergeant Ulka (a Kor'kron who fought the humans)
DELETE FROM `quest_template` WHERE `ID`=96334;
INSERT INTO `quest_template` (`ID`,`QuestType`,`LogTitle`,`VerifiedBuild`) VALUES (96334,2,'Blood Red Bandanas',-1);
UPDATE `quest_template` SET `QuestDescription`='Most of the humans we fought wore blood red bandanas. I seem to recall hearing of a criminal organization operating in the Eastern Kingdoms known as ''The Defias Brotherhood'' who are known for their red masks. Why they are active here in Kalimdor I don''t know, but kill any that cross your path and bring their masks to Eitrigg in Orgrimmar. \n\nHe''ll be able to determine if these are in fact Defias masks.', `LogDescription`='Enter Alcaz Prison and collect $1oa Blood Red Bandanas from the human guards there.', `QuestSortID`=16620, `QuestInfoID`=81, `RewardNextQuest`=0, `RewardXPDifficulty`=5, `RewardXPMultiplier`=1.85, `StartItem`=0, `Flags`=2097160, `AllowableRaces`=12261800583900083122, `VerifiedBuild`=70862, `RewardChoiceItemID1`=279448, `RewardChoiceItemQuantity1`=1, `RewardChoiceItemID2`=279473, `RewardChoiceItemQuantity2`=1, `RewardFactionID1`=76, `RewardFactionValue1`=4 WHERE `ID`=96334;
DELETE FROM `quest_classic_level` WHERE `ID`=96334;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (96334,53,48,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=96334;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (96334,2,53);
DELETE FROM `quest_template_addon` WHERE `ID`=96334;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (96334,0,0,0);
DELETE FROM `quest_offer_reward` WHERE `ID`=96334;
INSERT INTO `quest_offer_reward` (`ID`,`RewardText`,`VerifiedBuild`) VALUES (96334,'Well done, $n. Thank you.',-1);
DELETE FROM `quest_classic_money` WHERE `ID`=96334;
DELETE FROM `quest_objectives` WHERE `QuestID`=96334;
DELETE FROM `quest_objectives` WHERE `ID` IN (472865);
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES (472865,96334,1,0,0,274028,8,0,32,0,0.0,0,1,NULL,70862);
DELETE FROM `creature_queststarter` WHERE `quest`=96334;
DELETE FROM `creature_questender` WHERE `quest`=96334;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (260383,96334,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (3144,96334,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (260383,3144);

-- 95483 Thrall Needs to Know: giver Commander Folkar (the text: he will meet up with Ulka), turn-in Thrall in Orgrimmar (the log names him)
DELETE FROM `quest_template` WHERE `ID`=95483;
INSERT INTO `quest_template` (`ID`,`QuestType`,`LogTitle`,`VerifiedBuild`) VALUES (95483,2,'Thrall Needs to Know',-1);
UPDATE `quest_template` SET `QuestDescription`='Thrall needs to know what happened here. I will meet up with Ulka and see to it that he is fit to travel before returning to Orgrimmar, so I am trusting you to bring this information to the warchief in my stead.\n\nGo now, soldier of the Horde. Tell our warchief what fate befell Varian Wrynn.', `LogDescription`='Bring word of Varian Wrynn''s fate to Thrall in Orgrimmar.', `QuestSortID`=16620, `QuestInfoID`=81, `RewardNextQuest`=0, `RewardXPDifficulty`=2, `RewardXPMultiplier`=1.85, `StartItem`=0, `Flags`=2097160, `AllowableRaces`=12261800583900083122, `VerifiedBuild`=70862, `RewardChoiceItemID1`=279831, `RewardChoiceItemQuantity1`=1, `RewardChoiceItemID2`=279833, `RewardChoiceItemQuantity2`=1, `RewardChoiceItemID3`=279474, `RewardChoiceItemQuantity3`=1, `RewardFactionID1`=76, `RewardFactionValue1`=5 WHERE `ID`=95483;
DELETE FROM `quest_classic_level` WHERE `ID`=95483;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (95483,53,48,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=95483;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (95483,2,53);
DELETE FROM `quest_template_addon` WHERE `ID`=95483;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (95483,0,0,0);
DELETE FROM `quest_offer_reward` WHERE `ID`=95483;
INSERT INTO `quest_offer_reward` (`ID`,`RewardText`,`VerifiedBuild`) VALUES (95483,'Well done, $n. Thank you.',-1);
DELETE FROM `quest_classic_money` WHERE `ID`=95483;
DELETE FROM `quest_objectives` WHERE `QuestID`=95483;
DELETE FROM `creature_queststarter` WHERE `quest`=95483;
DELETE FROM `creature_questender` WHERE `quest`=95483;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (260386,95483,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (4949,95483,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (260386,4949);

-- Sergeant Ulka on Alcaz Island, by the prison entrance (INFERRED spot; immune, see the top)
DELETE FROM `creature` WHERE `guid` = 48120200;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curHealthPct`,`MovementType`,`npcflag`,`unit_flags`,`unit_flags2`,`unit_flags3`,`ScriptName`,`StringId`,`VerifiedBuild`) VALUES
(48120200,260383,1,0,0,'0',0,0,0,-1,0,0,-2571.0,-4899.0,32.5,5.5,300,0,0,100,0,NULL,768,NULL,NULL,'',NULL,0) /* Sergeant Ulka, Alcaz Island (INFERRED spot) */;
