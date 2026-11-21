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

-- 78092 It Must Be Destroyed (level 30, min 22, live build 1.60.1.70959, 1 player(s))
DELETE FROM `quest_template` WHERE `ID`=78092;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (78092,2,-141,0,78093,6,1.0,0,1.0,423561,209748,33554432,0,0,0,6130900294268439629,'It Must Be Destroyed','Gather 12 Motes of Mannoroth from demons in Ashenvale. Bring them along with the Orb of Althalaxx to the Spear of Mannoroth at Demon Fall Canyon.','The tendrils of sentience reaching out from this orb are too much for even an experienced warlock like myself to withstand for long. I am reluctant to admit this, $n, but the orb must be destroyed.

The orb is nearly impervious, but it may be vulnerable to the weapon of a powerful demon lord. I have heard that such a blade is present in Ashenvale--at the site where the pit lord Mannoroth was destroyed.

Gather motes of the fallen demon''s essence there, then shatter the orb upon the blade.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=78092;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (443906,78092,1,0,0,209779,12,0,1,NULL,70959),(443907,78092,1,1,1,209748,1,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=78092;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (78092,0,2,78091);
DELETE FROM `quest_classic_money` WHERE `ID`=78092;
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES (78092,5500,0);
DELETE FROM `quest_classic_level` WHERE `ID`=78092;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (78092,30,22,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=78092;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (78092,2,30);
DELETE FROM `creature_queststarter` WHERE `quest`=78092;
DELETE FROM `gameobject_queststarter` WHERE `quest`=78092;
DELETE FROM `creature_questender` WHERE `quest`=78092;
DELETE FROM `gameobject_questender` WHERE `quest`=78092;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (5495,78092,0);
INSERT INTO `gameobject_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (409311,78092,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (5495);

-- 79242 No Honor Among Thieves (level 40, min 30, live build 1.60.1.70959, 2 player(s))
DELETE FROM `quest_template` WHERE `ID`=79242;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (79242,2,405,0,0,6,1.0,0,1.0,0,0,33554432,0,0,0,18446744073709551615,277208,1,277223,1,277235,1,'No Honor Among Thieves','Find Illari Duskfeather on the coast of Arathi Highlands, and get access to her cache of stolen loot.','As I was saying...

Our boss wasn''t with the Horde. She was a night elf named Illari Duskfeather. She gave us intel on the camps, and even let us keep most of the loot. She only kept a few of the rarer finds.

Once the marshal was on our tail, though, she left us for dead. I don''t know her motives, but I think we were set up as patsies.

I''m not the vengeful type, but I won''t stop someone else from hunting her down. If you''re looking for her, she once mentioned a hideout on the coast of Arathi.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=79242;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (445980,79242,3,0,1,215655,1,0,1,'Found Illari Duskfeather',70959),(445876,79242,1,1,0,212347,1,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=79242;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (79242,0,0,79236);
DELETE FROM `quest_classic_money` WHERE `ID`=79242;
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES (79242,10000,0);
DELETE FROM `quest_classic_level` WHERE `ID`=79242;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (79242,40,30,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=79242;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (79242,2,40);
DELETE FROM `creature_queststarter` WHERE `quest`=79242;
DELETE FROM `gameobject_queststarter` WHERE `quest`=79242;
DELETE FROM `creature_questender` WHERE `quest`=79242;
DELETE FROM `gameobject_questender` WHERE `quest`=79242;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (215643,79242,0);
INSERT INTO `gameobject_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (418855,79242,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (215643);

-- 84135 Beach Bot (level 60, min 55, live build 1.60.1.70959, 4 player(s))
DELETE FROM `quest_template` WHERE `ID`=84135;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (84135,2,987,0,0,2,1.0,0,1.0,0,0,35652096,0,0,0,18446744073709551615,'Beach Bot','Use a rock or something to dislodge parts of the mech.','Lying on the shore, half-lost in the afternoon spray, is a strange metal contraption. It looks like some kind of mech, but you have never seen anything like it before. You notice a label on its side that reads "Property of D.E.L.T.A.: Deepsea Exploration and Liquefaction Technologies Alliance". You also spot a small compartment that you might be able to open.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=84135;
DELETE FROM `quest_template_addon` WHERE `ID`=84135;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (84135,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=84135;
DELETE FROM `quest_classic_level` WHERE `ID`=84135;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (84135,60,55,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=84135;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (84135,2,60);
DELETE FROM `creature_queststarter` WHERE `quest`=84135;
DELETE FROM `gameobject_queststarter` WHERE `quest`=84135;
DELETE FROM `creature_questender` WHERE `quest`=84135;
DELETE FROM `gameobject_questender` WHERE `quest`=84135;
INSERT INTO `gameobject_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (456682,84135,0);
INSERT INTO `gameobject_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (456685,84135,0);

-- 84332 A Thane's Gratitude (level 59, min 54, live build 1.60.1.70938, 1 player(s))
DELETE FROM `quest_template` WHERE `ID`=84332;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (84332,2,-141,0,0,6,1.5,0,1.0,0,0,0,0,0,0,18446744073709551615,227935,1,'A Thane''s Gratitude','','<You hear a disembodied voice in your head as you touch the small chest> 

Can''t be thankin'' ye enough, $n. Not how ye''d be expecting it to turn out, no doubt! Just so you aren''t too sour about it, I''ve got something for ye that I''ve no more use for that I think ye might find useful.

Good luck to ye, $n. Ah, one last thing... if ye happen to see a giant floating necropolis in the distance someday soon, I''d be turnin'' tail and runnin'' if I were ye. Hah!','','',70938);
DELETE FROM `quest_objectives` WHERE `QuestID`=84332;
DELETE FROM `quest_template_addon` WHERE `ID`=84332;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (84332,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=84332;
DELETE FROM `quest_classic_level` WHERE `ID`=84332;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (84332,59,54,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=84332;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (84332,2,59);
DELETE FROM `creature_queststarter` WHERE `quest`=84332;
DELETE FROM `gameobject_queststarter` WHERE `quest`=84332;
DELETE FROM `creature_questender` WHERE `quest`=84332;
DELETE FROM `gameobject_questender` WHERE `quest`=84332;
INSERT INTO `gameobject_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (462236,84332,0);
INSERT INTO `gameobject_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (462236,84332,0);

-- 86926 Felfire Burn, Cauldron Bubble (level 53, min 47, live build 1.60.1.70959, 2 player(s))
DELETE FROM `quest_template` WHERE `ID`=86926;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (86926,2,16,0,86927,5,1.0,0,1.0,0,0,36700424,0,0,0,18446744073709551615,576,5,0,'Felfire Burn, Cauldron Bubble','Bring $1oa Satyrweed and a Fel Mote to the Legashi Cauldron in the Legashi Encampment.','The recipe reads:

Harvest ye the sprout of hell
bushel o'' five will serve ye well
mixed with mote of demon''s power
shall usher in their final hour','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=86926;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (457572,86926,1,0,1,235470,5,0,1,NULL,70959),(457573,86926,1,1,2,235471,1,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=86926;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (86926,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=86926;
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES (86926,11156,0);
DELETE FROM `quest_classic_level` WHERE `ID`=86926;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (86926,53,47,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=86926;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (86926,2,53);
DELETE FROM `creature_queststarter` WHERE `quest`=86926;
DELETE FROM `gameobject_queststarter` WHERE `quest`=86926;
DELETE FROM `creature_questender` WHERE `quest`=86926;
DELETE FROM `gameobject_questender` WHERE `quest`=86926;
INSERT INTO `gameobject_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (506307,86926,0);
INSERT INTO `gameobject_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (506307,86926,0);

-- 86927 Running Firewater (level 53, min 47, live build 1.60.1.70959, 1 player(s))
DELETE FROM `quest_template` WHERE `ID`=86927;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardItem1`,`RewardAmount1`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (86927,2,16,0,86812,5,1.0,0,1.0,0,235472,36700160,0,0,0,18446744073709551615,236754,1,576,5,0,'Running Firewater','Bring the Legashi Firewater to Elder Bramblesnap at Ursolan.','As the satyrweed and fel mote splash into the boiling liquid, a plume of noxious gas emerges.

Best to hold your nose, quickly grab a sample, and bring it back to Elder Bramblesnap.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=86927;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (457578,86927,1,0,0,235472,1,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=86927;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (86927,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=86927;
DELETE FROM `quest_classic_level` WHERE `ID`=86927;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (86927,53,47,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=86927;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (86927,2,53);
DELETE FROM `creature_queststarter` WHERE `quest`=86927;
DELETE FROM `gameobject_queststarter` WHERE `quest`=86927;
DELETE FROM `creature_questender` WHERE `quest`=86927;
DELETE FROM `gameobject_questender` WHERE `quest`=86927;
INSERT INTO `gameobject_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (506307,86927,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (235906,86927,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (235906);

-- 90702 Disturbed Grave (level 58, min 54, live build 1.60.1.70959, 3 player(s))
DELETE FROM `quest_template` WHERE `ID`=90702;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`ItemDrop1`,`ItemDropQuantity1`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (90702,2,616,0,0,5,1.0,0,1.0,0,0,36700160,0,0,0,6130900294268439629,273642,1,'Disturbed Grave','Search the area for the grave''s missing contents.','<Someone, or something, has rummaged through the dirt, leaving fragments of bone scattered about. An oddly shaped indentation leads deeper into the cold, wet dirt.

Something within the area may have caused the disruption.>','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=90702;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (472705,90702,1,0,0,273642,1,0,1,'Object recovered',70959);
DELETE FROM `quest_template_addon` WHERE `ID`=90702;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (90702,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=90702;
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES (90702,20029,0);
DELETE FROM `quest_classic_level` WHERE `ID`=90702;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (90702,58,54,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=90702;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (90702,2,58);
DELETE FROM `creature_queststarter` WHERE `quest`=90702;
DELETE FROM `gameobject_queststarter` WHERE `quest`=90702;
DELETE FROM `creature_questender` WHERE `quest`=90702;
DELETE FROM `gameobject_questender` WHERE `quest`=90702;
INSERT INTO `gameobject_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (651262,90702,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (244517,90702,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (244517);

-- 93127 Summit Sentries (level 60, min 54, live build 1.60.1.70938, 4 player(s))
DELETE FROM `quest_template` WHERE `ID`=93127;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (93127,2,616,0,0,4,1.0,0,1.0,0,0,8,0,0,0,18446744073709551615,275666,1,275668,1,'Summit Sentries','Reactivate the sentinel stones north, west, and south around the Blackthorne cultists.','The Wild King may have a numbers advantage, but we can outmaneuver him with tactics.

Empower our living sentinel stones across the encircling hills, they can track Blackthorne movements for us. The northern ridges, the southern slopes, and the western high ground all have drained stones that will activate upon detecting your allied presence.

Tread carefully as you work, Blackthorne patrols crowd these paths, and their presence is precisely why we must bring this land under vigilant surveillance.','','',70938);
DELETE FROM `quest_objectives` WHERE `QuestID`=93127;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (472769,93127,2,0,1,651979,1,0,1,'Northern Sentinel Stone empowered',70938),(472770,93127,2,1,2,651987,1,0,1,'Western Sentinel Stone empowered',70938),(472771,93127,2,2,3,651986,1,0,1,'Southern Sentinel Stone empowered',70938);
DELETE FROM `quest_template_addon` WHERE `ID`=93127;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (93127,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=93127;
DELETE FROM `quest_classic_level` WHERE `ID`=93127;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (93127,60,54,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=93127;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (93127,2,60);
DELETE FROM `creature_queststarter` WHERE `quest`=93127;
DELETE FROM `gameobject_queststarter` WHERE `quest`=93127;
DELETE FROM `creature_questender` WHERE `quest`=93127;
DELETE FROM `gameobject_questender` WHERE `quest`=93127;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (40833,93127,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (40833,93127,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (40833);

-- 93547 A Thorny Solution (level 60, min 57, live build 1.60.1.70959, 2 player(s))
DELETE FROM `quest_template` WHERE `ID`=93547;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardItem1`,`RewardAmount1`,`ItemDrop1`,`ItemDropQuantity1`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (93547,2,616,0,0,2,1.0,0,1.0,0,259268,36700160,0,0,0,18446744073709551615,275649,1,259268,1,'A Thorny Solution','Plant thorn seeds near the inn, the storage tower, and the grouping of trees at the loyalist druid camp.','We are constantly under threat here, both by the Blackthorne Pact and by the hostile creatures of Hyjal. But we can use the thorns to our advantage! With a little help from the power of nature, we can grow new thorn bushes to help protect our enclosure.

Plant thorn seeds near the road to help create barricades by the inn, the storage tower, and the grouping of trees near the road.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=93547;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (466733,93547,2,0,0,613773,1,0,1,'Thorn seed planted near inn',70959),(475072,93547,2,1,1,659199,1,0,1,'Thorn seed planted near storage tower',70959),(475073,93547,2,2,2,659200,1,0,1,'Thorn seed planted near group of trees',70959);
DELETE FROM `quest_template_addon` WHERE `ID`=93547;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (93547,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=93547;
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES (93547,2300,0);
DELETE FROM `quest_classic_level` WHERE `ID`=93547;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (93547,60,57,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=93547;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (93547,2,60);
DELETE FROM `creature_queststarter` WHERE `quest`=93547;
DELETE FROM `gameobject_queststarter` WHERE `quest`=93547;
DELETE FROM `creature_questender` WHERE `quest`=93547;
DELETE FROM `gameobject_questender` WHERE `quest`=93547;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (40833,93547,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (40833,93547,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (40833);

-- 94829 What We Lost (level 40, min 36, live build 1.60.1.70959, 3 player(s))
DELETE FROM `quest_template` WHERE `ID`=94829;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (94829,2,16591,0,94858,4,1.0,0,1.0,0,0,36831240,0,0,0,6130900294268439629,2826,5,0,'What We Lost','Collect $1oa Farmers'' Mementos from Twilight Raiders and place them on the graves west of Elbrim''s Farm.','If you''ve come to demand more of our crop, you''re too late. No doubt you saw my farm. Destroyed. All of it.

Good folk toiled in these fields for years to feed troops and civilians alike. But when those cultists arrived, where was the military? Where was our promised protection after all the rations they''d taken from us?

If you''ve any sense of decency, I beg you. The least we can do is recover their belongings from those cursed raiders. Let my people rest with their kin in the graveyard to the west.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=94829;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (476247,94829,1,0,1,266148,5,0,1,NULL,70959),(469212,94829,2,1,0,621813,5,0,1,'Mementos buried',70959);
DELETE FROM `quest_template_addon` WHERE `ID`=94829;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (94829,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=94829;
DELETE FROM `quest_classic_level` WHERE `ID`=94829;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (94829,40,36,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=94829;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (94829,2,40);
DELETE FROM `creature_queststarter` WHERE `quest`=94829;
DELETE FROM `gameobject_queststarter` WHERE `quest`=94829;
DELETE FROM `creature_questender` WHERE `quest`=94829;
DELETE FROM `gameobject_questender` WHERE `quest`=94829;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (258697,94829,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (258697,94829,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (258697);

-- 94843 From Seed to Sprout (level 38, min 36, live build 1.60.1.70959, 2 player(s))
DELETE FROM `quest_template` WHERE `ID`=94843;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (94843,2,16591,0,0,4,1.0,0,1.0,0,266161,3145984,0,0,0,6130900294268439629,2826,5,0,'From Seed to Sprout','Plant $1oa saplings around the lumber camp with Halligan Turner''s tree sprouting kit.','Considering you got yourself wrist-deep in guts and manure for us, it''s only right you get to do the fun part too.

The boys and I gather seeds from the trees as we work. With the fertilizer you''ve provided, I''ve made a planting kit to put them in the ground to grow new saplings.

Take it, and find some good planting spots around the work sites.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=94843;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (469232,94843,2,0,1,621767,5,0,1,'Sapling planted',70959),(470322,94843,1,1,0,266161,1,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=94843;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (94843,0,0,94842);
DELETE FROM `quest_classic_money` WHERE `ID`=94843;
DELETE FROM `quest_classic_level` WHERE `ID`=94843;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (94843,38,36,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=94843;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (94843,2,38);
DELETE FROM `creature_queststarter` WHERE `quest`=94843;
DELETE FROM `gameobject_queststarter` WHERE `quest`=94843;
DELETE FROM `creature_questender` WHERE `quest`=94843;
DELETE FROM `gameobject_questender` WHERE `quest`=94843;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (256438,94843,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (256438,94843,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (256438);

-- 95165 See Ya, Scallywags! (level 44, min 38, live build 1.60.1.70959, 3 player(s))
DELETE FROM `quest_template` WHERE `ID`=95165;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (95165,2,16591,0,0,5,1.0,0,1.0,0,268505,36700160,0,0,0,18446744073709551615,2827,5,0,'See Ya, Scallywags!','Plant a remote explosive charge on each of the Eastsea''s three boats.','So, here''s how we''re gonna sink those ships. 

I can use that gunpowder you stole and make timed charges. All you''ve gotta do is hop on each of the Eastsea''s boats, and plant one charge in the hull of each. Look for a spot near their cannons, that gunpowder''ll make our explosives even more powerful. Once the charges are set, get outta there, and I''ll hit the detonator!

The elegance of the plan is in its simplicity, don''t ya think?','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=95165;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (470100,95165,2,0,1,629425,1,0,1,'First Ship Charge planted',70959),(470101,95165,2,1,2,629426,1,0,1,'Second Ship Charge planted',70959),(470102,95165,2,2,3,629427,1,0,1,'Third Ship Charge planted',70959),(473166,95165,1,3,0,268505,1,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=95165;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (95165,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=95165;
DELETE FROM `quest_classic_level` WHERE `ID`=95165;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (95165,44,38,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=95165;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (95165,2,44);
DELETE FROM `creature_queststarter` WHERE `quest`=95165;
DELETE FROM `gameobject_queststarter` WHERE `quest`=95165;
DELETE FROM `creature_questender` WHERE `quest`=95165;
DELETE FROM `gameobject_questender` WHERE `quest`=95165;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (259961,95165,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (259961,95165,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (259961);

-- 95615 In Memoriam (level 38, min 36, live build 1.60.1.70959, 1 player(s))
DELETE FROM `quest_template` WHERE `ID`=95615;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardItem1`,`RewardAmount1`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (95615,2,16591,0,0,4,1.0,0,1.0,0,269997,36700160,0,0,0,6130900294268439629,274918,1,274915,1,274916,1,2826,3,0,'In Memoriam','Place $1oa Memorial Candles on graves in the chapel graveyard for Sister Rowland at Farholde Keep.','If you don''t mind, I''d like you to do the honor of lighting these memorial candles. Go to the cemetery just outside and place a fresh candle wherever you see one that''s gone out.

Such a task is a far cry from the excitement of your other adventures, I''m sure. Think of this as an opportunity for service and reflection--a quiet moment to acknowledge those who left this world before us, so that we might carry on and make it a better place.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=95615;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (471055,95615,2,0,1,642517,3,0,1,'Candles replaced',70959),(472117,95615,1,1,0,269997,1,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=95615;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (95615,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=95615;
DELETE FROM `quest_classic_level` WHERE `ID`=95615;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (95615,38,36,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=95615;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (95615,2,38);
DELETE FROM `creature_queststarter` WHERE `quest`=95615;
DELETE FROM `gameobject_queststarter` WHERE `quest`=95615;
DELETE FROM `creature_questender` WHERE `quest`=95615;
DELETE FROM `gameobject_questender` WHERE `quest`=95615;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (262031,95615,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (262031,95615,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (262031);

-- 95882 WANTED: Scoutmaster Vargas (level 43, min 38, live build 1.60.1.70959, 2 player(s))
DELETE FROM `quest_template` WHERE `ID`=95882;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardItem1`,`RewardAmount1`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (95882,2,16591,1,0,6,1.0,0,1.0,0,0,36700168,0,0,0,12261800583900083122,276105,1,'WANTED: Scoutmaster Vargas','Bring the Scoutmaster''s Eye to Neza Bloodsnout in Rog''mar.','An Alliance scouting party has been seen on a small island northeast of Rog''mar. They are led by a scoutmaster who has made tracking enemy movements increasingly difficult. The bastard even named his filthy pet after me as an open mockery. He knows I''m hunting him.

This human has eyes everywhere, and they need to be put out. I already claimed one before he managed to flee. Bring me his other as proof that the scoutmaster is no more. Show him he is not as untouchable as he thinks.

-- Neza Bloodsnout','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=95882;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (471619,95882,1,0,0,268581,1,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=95882;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (95882,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=95882;
DELETE FROM `quest_classic_level` WHERE `ID`=95882;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (95882,43,38,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=95882;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (95882,2,43);
DELETE FROM `creature_queststarter` WHERE `quest`=95882;
DELETE FROM `gameobject_queststarter` WHERE `quest`=95882;
DELETE FROM `creature_questender` WHERE `quest`=95882;
DELETE FROM `gameobject_questender` WHERE `quest`=95882;
INSERT INTO `gameobject_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (707249,95882,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (258031,95882,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (258031);

-- 96296 Fetid Corruption (level 58, min 55, live build 1.60.1.70959, 3 player(s))
DELETE FROM `quest_template` WHERE `ID`=96296;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (96296,2,616,0,0,4,1.0,0,1.0,0,0,36700168,0,0,0,18446744073709551615,'Fetid Corruption','Find and remove $1oa Corrupted Knots from the trees nearby.','<The second you near the pulsing nodule it falls from the tree, exposing a weeping green sap. It seems the tree has corruption within its bark that has spread deep, but the tree is not yet dead.

Looking around it is clear it has spread to some of the surrounding trees, but not all suffer from the same level of corruption.

Perhaps it is not too late to save the infected trees nearby.

Surely the Highfeathers would be grateful if you remove as many corrupted knots as you can find.>','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=96296;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (472745,96296,2,0,1,651430,6,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=96296;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (96296,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=96296;
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES (96296,12788,0);
DELETE FROM `quest_classic_level` WHERE `ID`=96296;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (96296,58,55,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=96296;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (96296,2,58);
DELETE FROM `creature_queststarter` WHERE `quest`=96296;
DELETE FROM `gameobject_queststarter` WHERE `quest`=96296;
DELETE FROM `creature_questender` WHERE `quest`=96296;
DELETE FROM `gameobject_questender` WHERE `quest`=96296;
INSERT INTO `gameobject_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (651409,96296,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (260825,96296,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (260825);

-- 96959 Blademaster's Bonfires (level 59, min 56, live build 1.60.1.70959, 2 player(s))
DELETE FROM `quest_template` WHERE `ID`=96959;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (96959,2,616,0,96983,3,1.0,0,1.0,0,0,35651592,0,0,0,18446744073709551615,'Blademaster''s Bonfires','Light the two bonfires in Dae''gun and return to Yashiro.','War.

By the time I heeded the call of our clans, the battle had passed, and only ashes answered my blade.

My purpose is forged anew.

This mountain remembers strength--ancient power riding its winds and holding its water. I would earn the right to walk its spine, to reach the fallen stronghold that lies upon the road to the summit.

Demons profane these graves. Before I fight at your side, I must know you stand capable. Light the two bonfires and return to me. Their flames draw our enemy out.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=96959;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (474601,96959,2,0,2,656668,1,0,1,'South Bonfire lit',70959),(474648,96959,2,1,0,656669,1,0,1,'Southeast Bonfire lit',70959);
DELETE FROM `quest_template_addon` WHERE `ID`=96959;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (96959,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=96959;
DELETE FROM `quest_classic_level` WHERE `ID`=96959;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (96959,59,56,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=96959;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (96959,2,59);
DELETE FROM `creature_queststarter` WHERE `quest`=96959;
DELETE FROM `gameobject_queststarter` WHERE `quest`=96959;
DELETE FROM `creature_questender` WHERE `quest`=96959;
DELETE FROM `gameobject_questender` WHERE `quest`=96959;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (267121,96959,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (267121,96959,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (267121);

-- Illari Duskfeather (215655) is a talk-to objective of 79242: she needs the gossip flag for the talk to count.
UPDATE `creature_template` SET `npcflag`=`npcflag`|1 WHERE `entry`=215655;
