-- WoW Forever: quests players do on the live realm that our world did not have at all (and Everlake's open data does not
-- add either). Full live record: title, story, objective line, completion line, levels, races, flags, objectives with their
-- live ids, item/choice/reputation/money rewards, start item, next quest.
-- Quest record: Data from Efficient Games (https://efficient.games), licensed under CC BY 4.0
-- (https://creativecommons.org/licenses/by/4.0/). Source: github.com/JIVESCORP/eg-link-output-wowf quests.enUS (players' quest
-- caches) and npcs (who offered and took each quest), builds 70888-70959. Changed: picked and converted to our tables.
-- Givers, turn-ins, classes and the one previous quest also from NorgannonDB (zmarotrix/NorgannonDB, GPL-3.0, built from
-- QuestieDB GPL-3.0, pfQuest MIT and its Collector add-on).
-- Givers and turn-ins missing from both: from Wowhead's WoW Forever quest pages (www.wowhead.com/forever).
-- Only quests whose giver (or start item), turn-in and every objective target exist and are spawned in our world are here;
-- the rest are listed in the kit's quests report with the reason they wait. Reward text is not in the data: none is set.
-- Safe to run again: every row is replaced by key.

-- 95820 Karolek (level 60, min 1, live build 1.60.1.70245, 1 player(s))
DELETE FROM `quest_template` WHERE `ID`=95820;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (95820,2,1637,0,95821,1,1.0,0,1.0,0,0,36700160,0,0,0,18446744073709551615,'Karolek','Meet Karolek at the Kodohide Leatherworkers shop in Orgrimmar.','We have done well to create great relationships with the merchants and craftspeople of Orgrimmar. Among these excellent relationships is an orc named Karolek, a leatherworker who ensures a steady supply of hides and other useful equipment to us.

He also happens to be great at making signs!

If you''d like to get your sign made fast, I would recommend him over anyone else. Let him know I sent you.','','',70245);
DELETE FROM `quest_objectives` WHERE `QuestID`=95820;
DELETE FROM `quest_template_addon` WHERE `ID`=95820;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (95820,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=95820;
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES (95820,900,0);
DELETE FROM `quest_classic_level` WHERE `ID`=95820;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (95820,60,1,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=95820;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (95820,2,60);
DELETE FROM `creature_queststarter` WHERE `quest`=95820;
DELETE FROM `gameobject_queststarter` WHERE `quest`=95820;
DELETE FROM `creature_questender` WHERE `quest`=95820;
DELETE FROM `gameobject_questender` WHERE `quest`=95820;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (256388,95820,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (3365,95820,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (3365,256388);

-- 97183 Blessed Arcanite Barding (level 60, min 60, live build 1.60.1.70959, 1 player(s))
DELETE FROM `quest_template` WHERE `ID`=97183;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (97183,2,-141,0,97184,6,1.0,0,1.0,0,18792,0,0,0,0,18446744073709551615,68,6,0,'Blessed Arcanite Barding','Return with the Blessed Arcanite Barding to Danitha Morr at Bandarion Keep in Tirisfal Glades.','As the barding rests on the back of the Ancient Equine Spirit, it glows white hot. The air is thick with power for a brief moment, and then the barding disappears from the back of the horse and is now secure in your backpack.

Even through the leather of your satchel, you feel the heat still coming off of the saddle. It would seem that your offering of vengeance has been accepted, and the barding has been blessed. It''s time to return to Danitha Morr at Bandarion Keep.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=97183;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (475319,97183,1,0,0,18792,1,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=97183;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (97183,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=97183;
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES (97183,24900,0);
DELETE FROM `quest_classic_level` WHERE `ID`=97183;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (97183,60,60,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=97183;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (97183,2,60);
DELETE FROM `creature_queststarter` WHERE `quest`=97183;
DELETE FROM `gameobject_queststarter` WHERE `quest`=97183;
DELETE FROM `creature_questender` WHERE `quest`=97183;
DELETE FROM `gameobject_questender` WHERE `quest`=97183;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (246378,97183,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (246378);

-- 97184 The Divination Scryer (level 60, min 60, live build 1.60.1.70959, 1 player(s))
DELETE FROM `quest_template` WHERE `ID`=97184;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (97184,2,-141,0,97185,3,1.0,0,1.0,0,0,0,0,0,0,12261800583900083122,68,3,0,'The Divination Scryer','Bring an Azerothian Diamond and a Pristine Black Diamond to Danitha Morr at Bandarion Keep in Tirisfal Glades.','We now must assemble a Divination Scryer that will be vital for your final trial. The exorcism censer you used in Terrordale is the catalyst for it, and I should be able to fashion a suitable housing for the scrying device.

The last components needed, though, are two diamonds--one white, one black. This represents the duality of our nature as paladins of The Forsaken. These two will be the beacon by which the scryer will pierce the veil between the living and the dead.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=97184;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (475322,97184,1,0,0,12800,1,0,1,NULL,70959),(475323,97184,1,1,1,18335,1,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=97184;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (97184,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=97184;
DELETE FROM `quest_classic_level` WHERE `ID`=97184;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (97184,60,60,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=97184;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (97184,2,60);
DELETE FROM `creature_queststarter` WHERE `quest`=97184;
DELETE FROM `gameobject_queststarter` WHERE `quest`=97184;
DELETE FROM `creature_questender` WHERE `quest`=97184;
DELETE FROM `gameobject_questender` WHERE `quest`=97184;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (246378,97184,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (246378,97184,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (246378);

-- 97186 Manna-Enriched Horse Feed (level 60, min 60, live build 1.60.1.70959, 2 player(s))
DELETE FROM `quest_template` WHERE `ID`=97186;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardItem1`,`RewardAmount1`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (97186,2,-141,0,0,1,1.0,0,1.0,0,0,256,0,0,0,18446744073709551615,18775,1,'Manna-Enriched Horse Feed','Retrieve 20 Enriched Manna Biscuits for Nathanos Blightcaller in Eastern Plaguelands. The Argent Dawn is known as the sole purveyor of the biscuits. You''ll also need to provide Blightcaller with 50 gold for his time.','So you need feed to give to the incorporeal spirit of a horse? Interesting.

Yes, I suppose I can help you with what you need. I have spent a considerable amount of time rearing beasts that are... let''s say--no longer entirely of this world, and I know a thing or two about how to sustain them.

I simply need some of the spiritually-enriched biscuits that the Argent Dawn sells... and a small offering of gold. For my time, of course.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=97186;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (475328,97186,1,0,0,13724,20,0,1,NULL,70959),(475329,97186,8,1,1,0,500000,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=97186;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (97186,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=97186;
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES (97186,-500000,0);
DELETE FROM `quest_classic_level` WHERE `ID`=97186;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (97186,60,60,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=97186;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (97186,2,60);
DELETE FROM `creature_queststarter` WHERE `quest`=97186;
DELETE FROM `gameobject_queststarter` WHERE `quest`=97186;
DELETE FROM `creature_questender` WHERE `quest`=97186;
DELETE FROM `gameobject_questender` WHERE `quest`=97186;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (11878,97186,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (11878,97186,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (11878);

-- 97412 Just Compensation (level 60, min 58, live build 1.60.1.70959, 2 player(s))
DELETE FROM `quest_template` WHERE `ID`=97412;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (97412,2,1637,81,8930,7,2.0,0,1.0,0,0,8,0,0,0,12261800583900083122,227343,1,227344,1,227345,1,'Just Compensation','Bring a Lightforge Belt and a set of Lightforge Gauntlets to Mokvar in Orgrimmar.','You''ve proven to be a very reliable individual, $n.  As much as I trust that you''ll help me through this predicament, it would be wise of me to reward you according to your performance.

For now I will exchange your belt and gloves. If we both see this through I shall make the rest of the pieces available to you.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=97412;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (475885,97412,1,0,2,16723,1,0,1,NULL,70959),(475886,97412,1,1,3,16724,1,0,1,NULL,70959);
DELETE FROM `quest_template_addon` WHERE `ID`=97412;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (97412,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=97412;
DELETE FROM `quest_classic_level` WHERE `ID`=97412;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (97412,60,58,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=97412;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (97412,2,60);
DELETE FROM `creature_queststarter` WHERE `quest`=97412;
DELETE FROM `gameobject_queststarter` WHERE `quest`=97412;
DELETE FROM `creature_questender` WHERE `quest`=97412;
DELETE FROM `gameobject_questender` WHERE `quest`=97412;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (230317,97412,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (230317,97412,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (230317);

-- 99210 An Epic Ride (level 60, min 60, live build 1.60.1.70959, 3 player(s))
DELETE FROM `quest_template` WHERE `ID`=99210;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (99210,2,1,0,0,3,1.0,0,1.0,0,0,1048576,0,0,0,4,18785,1,18786,1,18787,1,47,2,0,'An Epic Ride','Inspect the armored riding rams to choose your epic mount.','Ah, hail $n! My, you''ve certainly grown since the last time you were at my humble stable, eh?

It would seem you have the experience ta be ridin'' our fiercest and fastest rams now! Ah, I''m proud of ye.

So, you have an important choice to make. You and yer ram will traverse the world together so choose wisely! Not to worry, whatever choice you make will be the right one.

Go see the armored rams and return to me when you''ve made yer choice.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=99210;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (479625,99210,3,0,0,276737,1,0,1,'Swift Gray Ram',70959),(479626,99210,3,1,1,276779,1,0,1,'Swift Brown Ram',70959),(479627,99210,3,2,2,276783,1,0,1,'Swift White Ram',70959);
DELETE FROM `quest_template_addon` WHERE `ID`=99210;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (99210,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=99210;
DELETE FROM `quest_classic_level` WHERE `ID`=99210;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (99210,60,60,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=99210;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (99210,2,60);
DELETE FROM `creature_queststarter` WHERE `quest`=99210;
DELETE FROM `gameobject_queststarter` WHERE `quest`=99210;
DELETE FROM `creature_questender` WHERE `quest`=99210;
DELETE FROM `gameobject_questender` WHERE `quest`=99210;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (1261,99210,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (1261,99210,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (1261);

-- 99211 An Epic Ride (level 60, min 60, live build 1.60.1.70959, 2 player(s))
DELETE FROM `quest_template` WHERE `ID`=99211;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (99211,2,85,0,0,0,1.0,0,1.0,0,0,1048576,0,0,0,16,274799,1,13334,1,18791,1,68,2,0,'An Epic Ride','Inspect the armored undead riding warhorses to choose your epic mount.','Greetings, $n. I didn''t expect to see you back to my humble stables again so soon.

You certainly have had quite a journey. I think I can guess what has brought you here today.

You now have enough power, experience and skill to ride our deftest and most fearsome warhorses. These armored fiends will bear you through any trial, even past the gates of death itself. 

Go examine the armored undead warhorses and return to me when you have made your choice.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=99211;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (479628,99211,3,0,1,276793,1,0,1,'Ochre Skeletal Warhorse',70959),(479629,99211,3,1,2,276797,1,0,1,'Purple Skeletal Warhorse',70959),(479630,99211,3,2,3,276796,1,0,1,'Green Skeletal Warhorse',70959);
DELETE FROM `quest_template_addon` WHERE `ID`=99211;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (99211,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=99211;
DELETE FROM `quest_classic_level` WHERE `ID`=99211;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (99211,60,60,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=99211;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (99211,2,60);
DELETE FROM `creature_queststarter` WHERE `quest`=99211;
DELETE FROM `gameobject_queststarter` WHERE `quest`=99211;
DELETE FROM `creature_questender` WHERE `quest`=99211;
DELETE FROM `gameobject_questender` WHERE `quest`=99211;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (4731,99211,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (4731,99211,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (4731);

-- 99214 An Epic Ride (level 60, min 60, live build 1.60.1.70959, 2 player(s))
DELETE FROM `quest_template` WHERE `ID`=99214;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (99214,2,1657,0,0,3,1.0,0,1.0,0,0,1048576,0,0,0,8,18902,1,18767,1,18766,1,69,2,0,'An Epic Ride','Inspect the armored riding sabers to choose your epic mount.','Greetings, friend! I am pleased to see you again. Today you have enough experience and aptitude to bond with our fastest and fiercest sabers.

These sabers are, of course, extremely intelligent and fiercely loyal to their bonded rider. You won''t find a more noble and steadfast companion.

As such, you have an important choice to make. You and your saber will traverse the world together, so choose wisely!

Go, examine the armored sabers and return to me when you have made your choice.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=99214;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (479641,99214,3,0,4,276730,1,0,1,'Swift Stormsaber',70959),(479642,99214,3,1,5,276731,1,0,1,'Swift Mistsaber',70959),(479643,99214,3,2,6,276732,1,0,1,'Swift Frostsaber',70959);
DELETE FROM `quest_template_addon` WHERE `ID`=99214;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (99214,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=99214;
DELETE FROM `quest_classic_level` WHERE `ID`=99214;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (99214,60,60,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=99214;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (99214,2,60);
DELETE FROM `creature_queststarter` WHERE `quest`=99214;
DELETE FROM `gameobject_queststarter` WHERE `quest`=99214;
DELETE FROM `creature_questender` WHERE `quest`=99214;
DELETE FROM `gameobject_questender` WHERE `quest`=99214;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (4730,99214,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (4730,99214,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (4730);

-- 99215 An Epic Ride (level 60, min 60, live build 1.60.1.70959, 2 player(s))
DELETE FROM `quest_template` WHERE `ID`=99215;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (99215,2,1637,0,0,0,1.0,0,1.0,0,0,1048576,0,0,0,2,18797,1,18796,1,18798,1,76,2,0,'An Epic Ride','Inspect the armored riding wolves to choose your epic mount.','Lok-tar, $n. It is good to see you again. 
 
As you know, there is no stronger bond than that of an orc and their wolf, and now you have enough experience to handle and ride our fiercest and fastest wolves. 
 
Many of these fine wolves remember you from the last time you were here and have grown since you first met. They are stronger, faster and braver than before, much like yourself. 

Go and find which armored wolf speaks to you. Return to me when you have your answer.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=99215;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (479644,99215,3,0,1,276833,1,0,1,'Swift Brown Wolf',70959),(479645,99215,3,1,2,276805,1,0,1,'Swift Gray Wolf',70959),(479646,99215,3,2,3,276832,1,0,1,'Swift Timber Wolf',70959);
DELETE FROM `quest_template_addon` WHERE `ID`=99215;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (99215,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=99215;
DELETE FROM `quest_classic_level` WHERE `ID`=99215;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (99215,60,60,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=99215;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (99215,2,60);
DELETE FROM `creature_queststarter` WHERE `quest`=99215;
DELETE FROM `gameobject_queststarter` WHERE `quest`=99215;
DELETE FROM `creature_questender` WHERE `quest`=99215;
DELETE FROM `gameobject_questender` WHERE `quest`=99215;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (3362,99215,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (3362,99215,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (3362);

-- 99217 An Epic Ride (level 60, min 60, live build 1.60.1.70959, 2 player(s))
DELETE FROM `quest_template` WHERE `ID`=99217;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`RewardChoiceItemID1`,`RewardChoiceItemQuantity1`,`RewardChoiceItemID2`,`RewardChoiceItemQuantity2`,`RewardChoiceItemID3`,`RewardChoiceItemQuantity3`,`RewardFactionID1`,`RewardFactionValue1`,`RewardFactionOverride1`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (99217,2,215,0,0,0,1.0,0,1.0,0,0,1048576,0,0,0,32,18795,1,18794,1,18793,1,81,2,0,'An Epic Ride','Inspect the armored riding kodos to choose your epic mount.','Ah, I''ve been expecting you $n. It would seem the winds have brought you to me once again, so you may ride our fastest and strongest kodos.

Today, I am proud to present to you your next kodo. Much like yourself, each has grown stronger and faster since you last met.

You and your kodo will travel the world together just like before, so find which one speaks to you.

Go examine the armored kodos and return to me when you have made your choice.','','',70959);
DELETE FROM `quest_objectives` WHERE `QuestID`=99217;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`Flags`,`Visible`,`Description`,`VerifiedBuild`) VALUES (479650,99217,3,0,0,276877,1,0,1,'Great Gray Kodo',70959),(479651,99217,3,1,1,276876,1,0,1,'Great Brown Kodo',70959),(479652,99217,3,2,2,276879,1,0,1,'Great White Kodo',70959);
DELETE FROM `quest_template_addon` WHERE `ID`=99217;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (99217,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=99217;
DELETE FROM `quest_classic_level` WHERE `ID`=99217;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (99217,60,60,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=99217;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (99217,2,60);
DELETE FROM `creature_queststarter` WHERE `quest`=99217;
DELETE FROM `gameobject_queststarter` WHERE `quest`=99217;
DELETE FROM `creature_questender` WHERE `quest`=99217;
DELETE FROM `gameobject_questender` WHERE `quest`=99217;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (3685,99217,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (3685,99217,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (3685);

-- 99234 Brawl at the Maul (level 60, min 55, live build 1.60.1.70938, 2 player(s))
DELETE FROM `quest_template` WHERE `ID`=99234;
INSERT INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`QuestInfoID`,`RewardNextQuest`,`RewardXPDifficulty`,`RewardXPMultiplier`,`RewardMoneyDifficulty`,`RewardMoneyMultiplier`,`RewardSpell`,`StartItem`,`Flags`,`FlagsEx`,`FlagsEx2`,`TimeAllowed`,`AllowableRaces`,`LogTitle`,`LogDescription`,`QuestDescription`,`AreaDescription`,`QuestCompletionLog`,`VerifiedBuild`) VALUES (99234,2,3217,41,0,1,1.0,0,1.0,0,277558,0,1,0,0,18446744073709551615,'Brawl at the Maul','Speak with Griniblix the Spectator above the Maul in Dire Maul.','There must be more to the Maul than this!

Perhaps the loud Spectator who oversees the event at Dire Maul will know!','','',70938);
DELETE FROM `quest_objectives` WHERE `QuestID`=99234;
DELETE FROM `quest_template_addon` WHERE `ID`=99234;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`) VALUES (99234,0,0,0);
DELETE FROM `quest_classic_money` WHERE `ID`=99234;
DELETE FROM `quest_classic_level` WHERE `ID`=99234;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (99234,60,55,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=99234;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (99234,2,60);
DELETE FROM `creature_queststarter` WHERE `quest`=99234;
DELETE FROM `gameobject_queststarter` WHERE `quest`=99234;
DELETE FROM `creature_questender` WHERE `quest`=99234;
DELETE FROM `gameobject_questender` WHERE `quest`=99234;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (14395,99234,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (14395);

-- An Epic Ride: the mount pens' display mounts are "talk to" targets, so they need the gossip flag for the credit to fire
-- (the kodo and saber templates come from the Everlake import).
UPDATE `creature_template` SET `npcflag`=`npcflag`|1 WHERE `entry` IN (276730,276731,276732,276876,276877,276879);
