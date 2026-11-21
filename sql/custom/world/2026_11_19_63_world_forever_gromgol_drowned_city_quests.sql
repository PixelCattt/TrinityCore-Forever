-- WoW Forever: seven Stranglethorn quests live has and we lacked (Grom'gol and the Drowned City), from live's own quest records.
-- Commander Aggro'gosh (2464, Grom'gol): Report to Rog'mar 95141, Enemies in the Water 95773, The Only Good Brinescale... 95776,
-- The Offense of Grom'gol 97386. Krazek (773, Booty Bay): Shady Saltseers 95789, The Saltseer Captain 95791. Mazu'kon (264074):
-- Ancient Gurubashi Idol 96774. Their givers, turn-ins, creatures and drops are all in our world already (the Drowned City from
-- 2026_11_11_30, its quest drops 270333 and 276894 and the Brinescale drop 270305).
-- Sources (read as data): quest text, levels, objectives, rewards and races are Blizzard's records as players' clients got them
-- on the live realm, and who gives and who takes each quest is what players saw on live: Efficient Games' EG Link export
-- (github.com/JIVESCORP/eg-link-output-wowf, quests.enUS.json and npcs.json, builds 1.60.1.70790-70959).
-- Data from Efficient Games (https://efficient.games), licensed under CC BY 4.0 (https://creativecommons.org/licenses/by/4.0/).
-- Changed: converted to our quest rows.
-- Not in the data, so the same placeholders as 2026_11_11_74: reward text 'Well done, $n. Thank you.' (VerifiedBuild -1).
-- Held back from this chain (need data we don't have): The Gurubashi Legends of Old 95748 and The Drowned City 95775 (tablet
-- rubbings: the hide-and-charcoal item, its spell and the tablets are not in our data), Locating the Lost City 95770 (a
-- server-side area trigger at the cavern), A Tale Spun Around the Fire 96078 (nobody seen taking it in).
-- Safe to run again: every key is deleted first.

-- 95141 Report to Rog'mar (live record build 70959): giver 2464 Commander Aggro'gosh, turn-in 256418 Krom'rosh (both seen on live)
DELETE FROM `quest_template` WHERE `ID`=95141;
INSERT INTO `quest_template` (`ID`,`QuestType`,`LogTitle`,`VerifiedBuild`) VALUES (95141,2,'Report to Rog''mar',-1);
DELETE FROM `quest_classic_level` WHERE `ID`=95141;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (95141,38,36,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=95141;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (95141,2,38);
DELETE FROM `quest_template_addon` WHERE `ID`=95141;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (95141,0,0,0);
DELETE FROM `quest_offer_reward` WHERE `ID`=95141;
INSERT INTO `quest_offer_reward` (`ID`,`RewardText`,`VerifiedBuild`) VALUES (95141,'Well done, $n. Thank you.',-1);
DELETE FROM `creature_queststarter` WHERE `quest`=95141;
DELETE FROM `gameobject_queststarter` WHERE `quest`=95141;
DELETE FROM `creature_questender` WHERE `quest`=95141;
DELETE FROM `gameobject_questender` WHERE `quest`=95141;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (2464,95141,70959);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (256418,95141,70959);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (2464,256418);
UPDATE `quest_template` SET `QuestDescription`='Far to the northeast beyond Stonard lies an embattled land along the eastern coast known as the Riverglades.\n\nMany have sought to lay claim to these lands, but few have succeeded. There is one, however, whose experience battling our enemies proved enough to settle a small outpost known as Rog''mar. Through countless attacks, it still remains.\n\nAs ruthless as Krom''rosh may be, his will has served our allies greatly. If it''s battle you seek, head northeast to seek out this old friend of ours.', `LogDescription`='Report to Krom''rosh at the Rog''mar outpost in the Riverglades.', `AreaDescription`='', `QuestCompletionLog`='', `LogTitle`='Report to Rog''mar', `QuestSortID`=33, `QuestInfoID`=0, `RewardNextQuest`=0, `RewardXPDifficulty`=1, `RewardXPMultiplier`=1.0, `RewardSpell`=0, `StartItem`=0, `Flags`=33554432, `FlagsEx`=0, `AllowableRaces`=12261800583900083122, `TimeAllowed`=0, `VerifiedBuild`=70959, `RewardItem1`=0, `RewardAmount1`=0, `RewardItem2`=0, `RewardAmount2`=0, `RewardItem3`=0, `RewardAmount3`=0, `RewardItem4`=0, `RewardAmount4`=0, `RewardChoiceItemID1`=0, `RewardChoiceItemQuantity1`=0, `RewardChoiceItemID2`=0, `RewardChoiceItemQuantity2`=0, `RewardChoiceItemID3`=0, `RewardChoiceItemQuantity3`=0, `RewardChoiceItemID4`=0, `RewardChoiceItemQuantity4`=0, `RewardChoiceItemID5`=0, `RewardChoiceItemQuantity5`=0, `RewardChoiceItemID6`=0, `RewardChoiceItemQuantity6`=0, `RewardFactionID1`=76, `RewardFactionValue1`=4, `RewardFactionOverride1`=0, `RewardFactionID2`=0, `RewardFactionValue2`=0, `RewardFactionOverride2`=0, `RewardFactionID3`=0, `RewardFactionValue3`=0, `RewardFactionOverride3`=0, `RewardFactionID4`=0, `RewardFactionValue4`=0, `RewardFactionOverride4`=0, `RewardFactionID5`=0, `RewardFactionValue5`=0, `RewardFactionOverride5`=0 WHERE `ID`=95141 AND `VerifiedBuild`=-1;
DELETE FROM `quest_objectives` WHERE `QuestID`=95141;
DELETE FROM `quest_classic_money` WHERE `ID`=95141;

-- 95773 Enemies in the Water (live record build 70938): giver 2464 Commander Aggro'gosh, turn-in 2464 Commander Aggro'gosh (both seen on live)
DELETE FROM `quest_template` WHERE `ID`=95773;
INSERT INTO `quest_template` (`ID`,`QuestType`,`LogTitle`,`VerifiedBuild`) VALUES (95773,2,'Enemies in the Water',-1);
DELETE FROM `quest_classic_level` WHERE `ID`=95773;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (95773,37,30,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=95773;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (95773,2,37);
DELETE FROM `quest_template_addon` WHERE `ID`=95773;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (95773,0,0,0);
DELETE FROM `quest_offer_reward` WHERE `ID`=95773;
INSERT INTO `quest_offer_reward` (`ID`,`RewardText`,`VerifiedBuild`) VALUES (95773,'Well done, $n. Thank you.',-1);
DELETE FROM `creature_queststarter` WHERE `quest`=95773;
DELETE FROM `gameobject_queststarter` WHERE `quest`=95773;
DELETE FROM `creature_questender` WHERE `quest`=95773;
DELETE FROM `gameobject_questender` WHERE `quest`=95773;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (2464,95773,70938);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (2464,95773,70938);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (2464);
UPDATE `quest_template` SET `QuestDescription`='$C, your arrival is timely. I have just received new reports of naga activity just off of our coast. They seem to be swarming around some old troll ruins near the ocean floor.\n\nWe are already stretched thin defending from the local Bloodscalp and ogres ransacking our caravans. We cannot afford a surprise attack from the sea.\n\nGo and slay as many as you are able, and bring me their tridents as proof of your success.', `LogDescription`='Gather $1oa Brinescale Tridents from Brinescale Skirmishers.', `AreaDescription`='', `QuestCompletionLog`='', `LogTitle`='Enemies in the Water', `QuestSortID`=33, `QuestInfoID`=0, `RewardNextQuest`=0, `RewardXPDifficulty`=5, `RewardXPMultiplier`=1.0, `RewardSpell`=0, `StartItem`=0, `Flags`=33554696, `FlagsEx`=0, `AllowableRaces`=12261800583900083122, `TimeAllowed`=0, `VerifiedBuild`=70938, `RewardItem1`=0, `RewardAmount1`=0, `RewardItem2`=0, `RewardAmount2`=0, `RewardItem3`=0, `RewardAmount3`=0, `RewardItem4`=0, `RewardAmount4`=0, `RewardChoiceItemID1`=0, `RewardChoiceItemQuantity1`=0, `RewardChoiceItemID2`=0, `RewardChoiceItemQuantity2`=0, `RewardChoiceItemID3`=0, `RewardChoiceItemQuantity3`=0, `RewardChoiceItemID4`=0, `RewardChoiceItemQuantity4`=0, `RewardChoiceItemID5`=0, `RewardChoiceItemQuantity5`=0, `RewardChoiceItemID6`=0, `RewardChoiceItemQuantity6`=0, `RewardFactionID1`=530, `RewardFactionValue1`=5, `RewardFactionOverride1`=0, `RewardFactionID2`=76, `RewardFactionValue2`=4, `RewardFactionOverride2`=0, `RewardFactionID3`=0, `RewardFactionValue3`=0, `RewardFactionOverride3`=0, `RewardFactionID4`=0, `RewardFactionValue4`=0, `RewardFactionOverride4`=0, `RewardFactionID5`=0, `RewardFactionValue5`=0, `RewardFactionOverride5`=0 WHERE `ID`=95773 AND `VerifiedBuild`=-1;
DELETE FROM `quest_objectives` WHERE `QuestID`=95773;
DELETE FROM `quest_objectives` WHERE `ID` IN (471244);
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(471244,95773,1,0,4,270305,10,0,0,0,0.0,0,1,NULL,70938);
DELETE FROM `quest_classic_money` WHERE `ID`=95773;
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES (95773,4000,0);

-- 95776 The Only Good Brinescale... (live record build 70959): giver 2464 Commander Aggro'gosh, turn-in 2464 Commander Aggro'gosh (both seen on live)
DELETE FROM `quest_template` WHERE `ID`=95776;
INSERT INTO `quest_template` (`ID`,`QuestType`,`LogTitle`,`VerifiedBuild`) VALUES (95776,2,'The Only Good Brinescale...',-1);
DELETE FROM `quest_classic_level` WHERE `ID`=95776;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (95776,38,30,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=95776;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (95776,2,38);
DELETE FROM `quest_template_addon` WHERE `ID`=95776;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (95776,0,0,0);
DELETE FROM `quest_offer_reward` WHERE `ID`=95776;
INSERT INTO `quest_offer_reward` (`ID`,`RewardText`,`VerifiedBuild`) VALUES (95776,'Well done, $n. Thank you.',-1);
DELETE FROM `creature_queststarter` WHERE `quest`=95776;
DELETE FROM `gameobject_queststarter` WHERE `quest`=95776;
DELETE FROM `creature_questender` WHERE `quest`=95776;
DELETE FROM `gameobject_questender` WHERE `quest`=95776;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (2464,95776,70959);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (2464,95776,70959);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (2464);
UPDATE `quest_template` SET `QuestDescription`='You have done well to slay the naga just off of our coast, but the fact that they are in our waters in such numbers means there is yet a larger threat.\n\nI have spoken to Kin''weelay, and he thinks these Brinescale naga are infiltrating the ruins of the Drowned City. If the naga are there, then they are up to no good and are likely searching for something.\n\nWe can''t let them get their hands on anything that could compromise us here and it is time to put an end to this. Slay their leader and return to me.', `LogDescription`='Slay Var''Taka in the Drowned City.', `AreaDescription`='', `QuestCompletionLog`='', `LogTitle`='The Only Good Brinescale...', `QuestSortID`=16550, `QuestInfoID`=81, `RewardNextQuest`=0, `RewardXPDifficulty`=6, `RewardXPMultiplier`=2.675, `RewardSpell`=0, `StartItem`=0, `Flags`=33554696, `FlagsEx`=0, `AllowableRaces`=12261800583900083122, `TimeAllowed`=0, `VerifiedBuild`=70959, `RewardItem1`=0, `RewardAmount1`=0, `RewardItem2`=0, `RewardAmount2`=0, `RewardItem3`=0, `RewardAmount3`=0, `RewardItem4`=0, `RewardAmount4`=0, `RewardChoiceItemID1`=279888, `RewardChoiceItemQuantity1`=1, `RewardChoiceItemID2`=279889, `RewardChoiceItemQuantity2`=1, `RewardChoiceItemID3`=0, `RewardChoiceItemQuantity3`=0, `RewardChoiceItemID4`=0, `RewardChoiceItemQuantity4`=0, `RewardChoiceItemID5`=0, `RewardChoiceItemQuantity5`=0, `RewardChoiceItemID6`=0, `RewardChoiceItemQuantity6`=0, `RewardFactionID1`=530, `RewardFactionValue1`=5, `RewardFactionOverride1`=0, `RewardFactionID2`=76, `RewardFactionValue2`=5, `RewardFactionOverride2`=0, `RewardFactionID3`=0, `RewardFactionValue3`=0, `RewardFactionOverride3`=0, `RewardFactionID4`=0, `RewardFactionValue4`=0, `RewardFactionOverride4`=0, `RewardFactionID5`=0, `RewardFactionValue5`=0, `RewardFactionOverride5`=0 WHERE `ID`=95776 AND `VerifiedBuild`=-1;
DELETE FROM `quest_objectives` WHERE `QuestID`=95776;
DELETE FROM `quest_objectives` WHERE `ID` IN (471330);
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(471330,95776,0,0,4,258924,1,0,0,0,0.0,0,1,NULL,70959);
DELETE FROM `quest_classic_money` WHERE `ID`=95776;
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES (95776,13000,0);

-- 97386 The Offense of Grom'gol (live record build 70959): giver 2464 Commander Aggro'gosh, turn-in 2464 Commander Aggro'gosh (both seen on live)
DELETE FROM `quest_template` WHERE `ID`=97386;
INSERT INTO `quest_template` (`ID`,`QuestType`,`LogTitle`,`VerifiedBuild`) VALUES (97386,2,'The Offense of Grom''gol',-1);
DELETE FROM `quest_classic_level` WHERE `ID`=97386;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (97386,44,38,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=97386;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (97386,2,44);
DELETE FROM `quest_template_addon` WHERE `ID`=97386;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (97386,0,0,0);
DELETE FROM `quest_offer_reward` WHERE `ID`=97386;
INSERT INTO `quest_offer_reward` (`ID`,`RewardText`,`VerifiedBuild`) VALUES (97386,'Well done, $n. Thank you.',-1);
DELETE FROM `creature_queststarter` WHERE `quest`=97386;
DELETE FROM `gameobject_queststarter` WHERE `quest`=97386;
DELETE FROM `creature_questender` WHERE `quest`=97386;
DELETE FROM `gameobject_questender` WHERE `quest`=97386;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (2464,97386,70959);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (2464,97386,70959);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (2464);
UPDATE `quest_template` SET `QuestDescription`='$n! Your arrival is timely, as always.\n\nYou have provided valuable assistance to the defense of Grom''gol, and we are grateful. After your recent push against the ogres nearby, we sent out a scout to see if there are more out there that may try to enact vengeance against us. As it turns out, there is a cave far to the east that they have claimed as their hovel.\n\nGather a friend or two and make it very clear that we will not tolerate another threat to our settlement, now or ever!', `LogDescription`='Commander Aggro''gosh of the Grom''gol base camp wants you to kill ogres at the Mosh''Ogg Ogre Mount.', `AreaDescription`='', `QuestCompletionLog`='', `LogTitle`='The Offense of Grom''gol', `QuestSortID`=33, `QuestInfoID`=1, `RewardNextQuest`=0, `RewardXPDifficulty`=6, `RewardXPMultiplier`=1.0, `RewardSpell`=0, `StartItem`=0, `Flags`=8, `FlagsEx`=0, `AllowableRaces`=12261800583900083122, `TimeAllowed`=0, `VerifiedBuild`=70959, `RewardItem1`=0, `RewardAmount1`=0, `RewardItem2`=0, `RewardAmount2`=0, `RewardItem3`=0, `RewardAmount3`=0, `RewardItem4`=0, `RewardAmount4`=0, `RewardChoiceItemID1`=277979, `RewardChoiceItemQuantity1`=1, `RewardChoiceItemID2`=277980, `RewardChoiceItemQuantity2`=1, `RewardChoiceItemID3`=277981, `RewardChoiceItemQuantity3`=1, `RewardChoiceItemID4`=0, `RewardChoiceItemQuantity4`=0, `RewardChoiceItemID5`=0, `RewardChoiceItemQuantity5`=0, `RewardChoiceItemID6`=0, `RewardChoiceItemQuantity6`=0, `RewardFactionID1`=76, `RewardFactionValue1`=5, `RewardFactionOverride1`=0, `RewardFactionID2`=0, `RewardFactionValue2`=0, `RewardFactionOverride2`=0, `RewardFactionID3`=0, `RewardFactionValue3`=0, `RewardFactionOverride3`=0, `RewardFactionID4`=0, `RewardFactionValue4`=0, `RewardFactionOverride4`=0, `RewardFactionID5`=0, `RewardFactionValue5`=0, `RewardFactionOverride5`=0 WHERE `ID`=97386 AND `VerifiedBuild`=-1;
DELETE FROM `quest_objectives` WHERE `QuestID`=97386;
DELETE FROM `quest_objectives` WHERE `ID` IN (475855,475856,475857,475858);
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(475855,97386,0,0,2,710,3,0,0,0,0.0,0,1,NULL,70959),
(475856,97386,0,1,3,709,3,0,0,0,0.0,0,1,NULL,70959),
(475857,97386,0,2,4,678,3,0,0,0,0.0,0,1,NULL,70959),
(475858,97386,0,3,5,679,3,0,0,0,0.0,0,1,NULL,70959);
DELETE FROM `quest_classic_money` WHERE `ID`=97386;

-- 95789 Shady Saltseers (live record build 70959): giver 773 Krazek, turn-in 773 Krazek (both seen on live)
DELETE FROM `quest_template` WHERE `ID`=95789;
INSERT INTO `quest_template` (`ID`,`QuestType`,`LogTitle`,`VerifiedBuild`) VALUES (95789,2,'Shady Saltseers',-1);
DELETE FROM `quest_classic_level` WHERE `ID`=95789;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (95789,40,34,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=95789;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (95789,2,40);
DELETE FROM `quest_template_addon` WHERE `ID`=95789;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (95789,0,0,0);
DELETE FROM `quest_offer_reward` WHERE `ID`=95789;
INSERT INTO `quest_offer_reward` (`ID`,`RewardText`,`VerifiedBuild`) VALUES (95789,'Well done, $n. Thank you.',-1);
DELETE FROM `creature_queststarter` WHERE `quest`=95789;
DELETE FROM `gameobject_queststarter` WHERE `quest`=95789;
DELETE FROM `creature_questender` WHERE `quest`=95789;
DELETE FROM `gameobject_questender` WHERE `quest`=95789;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (773,95789,70959);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (773,95789,70959);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (773);
UPDATE `quest_template` SET `QuestDescription`='Hey pal, you look like you can handle yourself in a fight.\n\nBaron Revilgaz has me keep''n my ear to the ground for magical objects. Word on the street is that a sunken troll ruin has mysteriously become, eh, un-sunk, which means there are a lot of unclaimed goods, if you catch my meaning.\n\nProblem is, it''s also caught the eye of pirates! Not just any pirates, the Saltseers specifically collect magical artifacts. I need you to go into the Drowned City, clear them out and take their stolen artifacts.', `LogDescription`='Collect $1oa Voodoo Infused Artifacts from Saltseer pirates in the Drowned City.', `AreaDescription`='', `QuestCompletionLog`='', `LogTitle`='Shady Saltseers', `QuestSortID`=16550, `QuestInfoID`=81, `RewardNextQuest`=0, `RewardXPDifficulty`=6, `RewardXPMultiplier`=2.675, `RewardSpell`=0, `StartItem`=0, `Flags`=33554696, `FlagsEx`=0, `AllowableRaces`=18446744073709551615, `TimeAllowed`=0, `VerifiedBuild`=70959, `RewardItem1`=0, `RewardAmount1`=0, `RewardItem2`=0, `RewardAmount2`=0, `RewardItem3`=0, `RewardAmount3`=0, `RewardItem4`=0, `RewardAmount4`=0, `RewardChoiceItemID1`=279882, `RewardChoiceItemQuantity1`=1, `RewardChoiceItemID2`=279930, `RewardChoiceItemQuantity2`=1, `RewardChoiceItemID3`=0, `RewardChoiceItemQuantity3`=0, `RewardChoiceItemID4`=0, `RewardChoiceItemQuantity4`=0, `RewardChoiceItemID5`=0, `RewardChoiceItemQuantity5`=0, `RewardChoiceItemID6`=0, `RewardChoiceItemQuantity6`=0, `RewardFactionID1`=21, `RewardFactionValue1`=5, `RewardFactionOverride1`=0, `RewardFactionID2`=470, `RewardFactionValue2`=3, `RewardFactionOverride2`=0, `RewardFactionID3`=369, `RewardFactionValue3`=3, `RewardFactionOverride3`=0, `RewardFactionID4`=577, `RewardFactionValue4`=3, `RewardFactionOverride4`=0, `RewardFactionID5`=0, `RewardFactionValue5`=0, `RewardFactionOverride5`=0 WHERE `ID`=95789 AND `VerifiedBuild`=-1;
DELETE FROM `quest_objectives` WHERE `QuestID`=95789;
DELETE FROM `quest_objectives` WHERE `ID` IN (471326);
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(471326,95789,1,0,4,270333,10,0,0,0,0.0,0,1,NULL,70959);
DELETE FROM `quest_classic_money` WHERE `ID`=95789;
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES (95789,10000,0);

-- 95791 The Saltseer Captain (live record build 70959): giver 773 Krazek, turn-in 773 Krazek (both seen on live)
DELETE FROM `quest_template` WHERE `ID`=95791;
INSERT INTO `quest_template` (`ID`,`QuestType`,`LogTitle`,`VerifiedBuild`) VALUES (95791,2,'The Saltseer Captain',-1);
DELETE FROM `quest_classic_level` WHERE `ID`=95791;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (95791,40,34,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=95791;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (95791,2,40);
DELETE FROM `quest_template_addon` WHERE `ID`=95791;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (95791,0,0,0);
DELETE FROM `quest_offer_reward` WHERE `ID`=95791;
INSERT INTO `quest_offer_reward` (`ID`,`RewardText`,`VerifiedBuild`) VALUES (95791,'Well done, $n. Thank you.',-1);
DELETE FROM `creature_queststarter` WHERE `quest`=95791;
DELETE FROM `gameobject_queststarter` WHERE `quest`=95791;
DELETE FROM `creature_questender` WHERE `quest`=95791;
DELETE FROM `gameobject_questender` WHERE `quest`=95791;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (773,95791,70959);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (773,95791,70959);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (773);
UPDATE `quest_template` SET `QuestDescription`='The Saltseer pirates have been a thorn in my side recently and knowing they''re in the Drowned City makes it worse! I mean they''re always bad news, but there is one captain in particular I want outta the picture. That damned Captain Dreadrise!\n\nHe and his crew are very accomplished at gathering all the magical artifacts I''ve been after, and I''m tired of the competition.\n\nI want you to remove Captain Dreadrise and his Saltseer Coroners from the picture. Permanently.', `LogDescription`='Slay 3 Saltseer Coroners and Captain Dreadrise in the Drowned City.', `AreaDescription`='', `QuestCompletionLog`='', `LogTitle`='The Saltseer Captain', `QuestSortID`=16550, `QuestInfoID`=81, `RewardNextQuest`=0, `RewardXPDifficulty`=6, `RewardXPMultiplier`=2.675, `RewardSpell`=0, `StartItem`=0, `Flags`=33554696, `FlagsEx`=0, `AllowableRaces`=18446744073709551615, `TimeAllowed`=0, `VerifiedBuild`=70959, `RewardItem1`=0, `RewardAmount1`=0, `RewardItem2`=0, `RewardAmount2`=0, `RewardItem3`=0, `RewardAmount3`=0, `RewardItem4`=0, `RewardAmount4`=0, `RewardChoiceItemID1`=279883, `RewardChoiceItemQuantity1`=1, `RewardChoiceItemID2`=279884, `RewardChoiceItemQuantity2`=1, `RewardChoiceItemID3`=0, `RewardChoiceItemQuantity3`=0, `RewardChoiceItemID4`=0, `RewardChoiceItemQuantity4`=0, `RewardChoiceItemID5`=0, `RewardChoiceItemQuantity5`=0, `RewardChoiceItemID6`=0, `RewardChoiceItemQuantity6`=0, `RewardFactionID1`=21, `RewardFactionValue1`=5, `RewardFactionOverride1`=0, `RewardFactionID2`=369, `RewardFactionValue2`=3, `RewardFactionOverride2`=0, `RewardFactionID3`=577, `RewardFactionValue3`=3, `RewardFactionOverride3`=0, `RewardFactionID4`=470, `RewardFactionValue4`=3, `RewardFactionOverride4`=0, `RewardFactionID5`=0, `RewardFactionValue5`=0, `RewardFactionOverride5`=0 WHERE `ID`=95791 AND `VerifiedBuild`=-1;
DELETE FROM `quest_objectives` WHERE `QuestID`=95791;
DELETE FROM `quest_objectives` WHERE `ID` IN (471322,471323);
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(471322,95791,0,0,4,260042,1,0,0,0,0.0,0,1,NULL,70959),
(471323,95791,0,1,5,260353,3,0,0,0,0.0,0,1,NULL,70959);
DELETE FROM `quest_classic_money` WHERE `ID`=95791;

-- 96774 Ancient Gurubashi Idol (live record build 70938): giver 264074 Mazu'kon, turn-in 264074 Mazu'kon (both seen on live)
DELETE FROM `quest_template` WHERE `ID`=96774;
INSERT INTO `quest_template` (`ID`,`QuestType`,`LogTitle`,`VerifiedBuild`) VALUES (96774,2,'Ancient Gurubashi Idol',-1);
DELETE FROM `quest_classic_level` WHERE `ID`=96774;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (96774,40,30,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=96774;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (96774,2,40);
DELETE FROM `quest_template_addon` WHERE `ID`=96774;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (96774,0,0,0);
DELETE FROM `quest_offer_reward` WHERE `ID`=96774;
INSERT INTO `quest_offer_reward` (`ID`,`RewardText`,`VerifiedBuild`) VALUES (96774,'Well done, $n. Thank you.',-1);
DELETE FROM `creature_queststarter` WHERE `quest`=96774;
DELETE FROM `gameobject_queststarter` WHERE `quest`=96774;
DELETE FROM `creature_questender` WHERE `quest`=96774;
DELETE FROM `gameobject_questender` WHERE `quest`=96774;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (264074,96774,70938);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (264074,96774,70938);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (264074);
UPDATE `quest_template` SET `QuestDescription`='The ancient Gurubashi of Stranglethorn Vale were da masters of dark blood magics. Rumors be they''d use pure truesilver idols to channel that bad bad voodoo.\n\nOl'' Mazu''kon would love to get his hands on one of those idols... for academics ya see. How ''bout you gather some friends and do a bit of smash and grab on that drowned city stickin'' out the ocean off the coast of Stranglethorn? Kill the most impressive lookin'' priest ya can find in there, and they sure to have what I be lookin'' for.', `LogDescription`='Recover an Ancient Gurubashi Idol from the Drowned City.', `AreaDescription`='', `QuestCompletionLog`='', `LogTitle`='Ancient Gurubashi Idol', `QuestSortID`=16550, `QuestInfoID`=81, `RewardNextQuest`=0, `RewardXPDifficulty`=6, `RewardXPMultiplier`=2.25, `RewardSpell`=0, `StartItem`=0, `Flags`=8, `FlagsEx`=0, `AllowableRaces`=12261800583900083122, `TimeAllowed`=0, `VerifiedBuild`=70938, `RewardItem1`=0, `RewardAmount1`=0, `RewardItem2`=0, `RewardAmount2`=0, `RewardItem3`=0, `RewardAmount3`=0, `RewardItem4`=0, `RewardAmount4`=0, `RewardChoiceItemID1`=0, `RewardChoiceItemQuantity1`=0, `RewardChoiceItemID2`=0, `RewardChoiceItemQuantity2`=0, `RewardChoiceItemID3`=0, `RewardChoiceItemQuantity3`=0, `RewardChoiceItemID4`=0, `RewardChoiceItemQuantity4`=0, `RewardChoiceItemID5`=0, `RewardChoiceItemQuantity5`=0, `RewardChoiceItemID6`=0, `RewardChoiceItemQuantity6`=0, `RewardFactionID1`=2787, `RewardFactionValue1`=7, `RewardFactionOverride1`=30000, `RewardFactionID2`=530, `RewardFactionValue2`=6, `RewardFactionOverride2`=0, `RewardFactionID3`=0, `RewardFactionValue3`=0, `RewardFactionOverride3`=0, `RewardFactionID4`=0, `RewardFactionValue4`=0, `RewardFactionOverride4`=0, `RewardFactionID5`=0, `RewardFactionValue5`=0, `RewardFactionOverride5`=0 WHERE `ID`=96774 AND `VerifiedBuild`=-1;
DELETE FROM `quest_objectives` WHERE `QuestID`=96774;
DELETE FROM `quest_objectives` WHERE `ID` IN (475468);
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(475468,96774,1,0,0,276894,1,0,0,0,0.0,0,1,NULL,70938);
DELETE FROM `quest_classic_money` WHERE `ID`=96774;
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES (96774,10000,0);
