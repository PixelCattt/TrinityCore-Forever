-- WoW Forever: two quests for the new dungeons that live has and we lacked, from a player's client cache (build 70959), and
-- the drops they need. Held until now in 2026_11_19_70 (Blackmaw Hold) and 2026_11_19_72 (Shaper's Terrace).
--  * Claws That Rend, Tusks that Gore 92069 (Blackmaw Hold, dungeon quest): Ogtinc in Azshara wants the Claws of the Great
--    Bear (249697, off Withermaw) and the Tusks of the Unbroken (249696, off Bonesnout the Unbroken).
--  * Unstable Magic 98477 (Mulgore, Horde): Nuara Tremorhoof hands out the Elemental Attractor (281371) and wants 10 Motes
--    of Unstable Magic (274964, in our hotfixes since 2026_11_19_77), which the Blackmaw Hold and Shaper's Terrace bosses drop.
-- Sources (read as data): quest text, levels, objectives, rewards and races are Blizzard's quest records as a player's client
-- got them on the live realm (its cache), and agree with Efficient Games' EG Link export (CC BY 4.0). Which boss drops which
-- item and the mote chances are from Everlake's world data (buildthehomelab, GPL-3.0).
-- INFERRED: who gives each quest (the record names only who takes it in; here the same NPC), and that a boss always drops its
-- part to a player on 92069. Not in the data, so the same placeholder as 2026_11_11_74: reward text 'Well done, $n. Thank you.'
-- Still held (need data we don't have): Blackmaw Pouches 97327 (its giver Ekkal at the Ruins of Eldarath has no spot in any
-- data), Blackmaw Magic 97198 (no giver or turn-in named), Get to the Roots of It 92343 (where the Nordrassil Root Caps
-- 250773 come from inside the dungeon), Crystalline Elements 95928 (where the four crystals come from in Shaper's Terrace).
-- Safe to run again: every key is deleted first.

-- 92069 Claws That Rend, Tusks that Gore (player cache, build 70959): giver 8405 Ogtinc, turn-in 8405 Ogtinc: turn-in named in the quest record; giver INFERRED (the one who asks for the remains is the one who makes the weapon from them)
DELETE FROM `quest_template` WHERE `ID`=92069;
INSERT INTO `quest_template` (`ID`,`QuestType`,`LogTitle`,`VerifiedBuild`) VALUES (92069,2,'Claws That Rend, Tusks that Gore',-1);
DELETE FROM `quest_classic_level` WHERE `ID`=92069;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (92069,58,45,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=92069;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (92069,2,58);
DELETE FROM `quest_template_addon` WHERE `ID`=92069;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`,`ProvidedItemCount`) VALUES (92069,0,0,0,0);
DELETE FROM `quest_offer_reward` WHERE `ID`=92069;
INSERT INTO `quest_offer_reward` (`ID`,`RewardText`,`VerifiedBuild`) VALUES (92069,'Well done, $n. Thank you.',-1);
DELETE FROM `creature_queststarter` WHERE `quest`=92069;
DELETE FROM `gameobject_queststarter` WHERE `quest`=92069;
DELETE FROM `creature_questender` WHERE `quest`=92069;
DELETE FROM `gameobject_questender` WHERE `quest`=92069;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (8405,92069,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (8405,92069,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (8405,8405);
UPDATE `quest_template` SET `QuestDescription`='Two behemoths patrol the place the Blackmaw once called home: Bonesnout, the Unbroken and Withermaw, the great bear. Generations of hunters have tried to fell them, and all have failed.\n\nI take no joy in asking you to slay these magnificent beasts, but my people need to be able to return home. The least I can do is ensure their deaths are not in vain. If you bring me their remains, I will fashion a weapon in memory of their strength.', `LogDescription`='Bring the Claws of the Great Bear and the Tusks of the Unbroken to Ogtinc, in Azshara.', `AreaDescription`='', `QuestCompletionLog`='', `LogTitle`='Claws That Rend, Tusks that Gore', `QuestSortID`=16554, `QuestInfoID`=81, `SuggestedGroupNum`=0, `RewardNextQuest`=0, `RewardXPDifficulty`=5, `RewardXPMultiplier`=2.0, `RewardMoneyDifficulty`=0, `RewardMoneyMultiplier`=1.0, `RewardSpell`=0, `StartItem`=0, `Flags`=36700424, `FlagsEx`=0, `FlagsEx2`=0, `AllowableRaces`=18446744073709551615, `TimeAllowed`=0, `VerifiedBuild`=70959, `RewardItem1`=0, `RewardAmount1`=0, `RewardItem2`=0, `RewardAmount2`=0, `RewardItem3`=0, `RewardAmount3`=0, `RewardItem4`=0, `RewardAmount4`=0, `RewardChoiceItemID1`=260213, `RewardChoiceItemQuantity1`=1, `RewardChoiceItemID2`=260214, `RewardChoiceItemQuantity2`=1, `RewardChoiceItemID3`=260215, `RewardChoiceItemQuantity3`=1, `RewardChoiceItemID4`=0, `RewardChoiceItemQuantity4`=0, `RewardChoiceItemID5`=0, `RewardChoiceItemQuantity5`=0, `RewardChoiceItemID6`=0, `RewardChoiceItemQuantity6`=0, `RewardFactionID1`=576, `RewardFactionValue1`=6, `RewardFactionOverride1`=0, `RewardFactionCapIn1`=7, `RewardFactionID2`=0, `RewardFactionValue2`=0, `RewardFactionOverride2`=0, `RewardFactionCapIn2`=7, `RewardFactionID3`=0, `RewardFactionValue3`=0, `RewardFactionOverride3`=0, `RewardFactionCapIn3`=7, `RewardFactionID4`=0, `RewardFactionValue4`=0, `RewardFactionOverride4`=0, `RewardFactionCapIn4`=7, `RewardFactionID5`=0, `RewardFactionValue5`=0, `RewardFactionOverride5`=0, `RewardFactionCapIn5`=7 WHERE `ID`=92069 AND `VerifiedBuild`=-1;
DELETE FROM `quest_objectives` WHERE `QuestID`=92069;
DELETE FROM `quest_objectives` WHERE `ID` IN (464120,464239);
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(464120,92069,1,0,1,249697,1,0,32,1,0.0,0,1,NULL,70959),
(464239,92069,1,1,0,249696,1,0,32,1,0.0,0,1,NULL,70959);
DELETE FROM `quest_classic_money` WHERE `ID`=92069;

-- 98477 Unstable Magic (player cache, build 70959): giver 272633 Nuara Tremorhoof, turn-in 272633 Nuara Tremorhoof: turn-in named in the quest record; giver INFERRED (the one who hands over the Elemental Attractor asks for the motes back)
DELETE FROM `quest_template` WHERE `ID`=98477;
INSERT INTO `quest_template` (`ID`,`QuestType`,`LogTitle`,`VerifiedBuild`) VALUES (98477,2,'Unstable Magic',-1);
DELETE FROM `quest_classic_level` WHERE `ID`=98477;
INSERT INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (98477,60,48,0);
DELETE FROM `quest_template_classic_level` WHERE `ID`=98477;
INSERT INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (98477,2,60);
DELETE FROM `quest_template_addon` WHERE `ID`=98477;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`,`AllowableClasses`,`PrevQuestID`,`ProvidedItemCount`) VALUES (98477,0,0,0,1);
DELETE FROM `quest_offer_reward` WHERE `ID`=98477;
INSERT INTO `quest_offer_reward` (`ID`,`RewardText`,`VerifiedBuild`) VALUES (98477,'Well done, $n. Thank you.',-1);
DELETE FROM `creature_queststarter` WHERE `quest`=98477;
DELETE FROM `gameobject_queststarter` WHERE `quest`=98477;
DELETE FROM `creature_questender` WHERE `quest`=98477;
DELETE FROM `gameobject_questender` WHERE `quest`=98477;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (272633,98477,0);
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES (272633,98477,0);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (272633,272633);
UPDATE `quest_template` SET `QuestDescription`='Any experienced shaman who attempts to scry the elemental plane can tell you that there is a blip of sorts, a distortion that you feel as you cross over to the other realms of existence.\n\nWe have need of adventurers like yourself to help us better understand this disturbance. Take this Elemental Attractor. You will be able to extract motes of unstable magic with it from the most skilled spellcasters and other powerful entities you may encounter. Bring me these motes so that we may study them.', `LogDescription`='Bring $1oa Motes of Unstable Magic to Nuara Tremorhoof.', `AreaDescription`='', `QuestCompletionLog`='', `LogTitle`='Unstable Magic', `QuestSortID`=215, `QuestInfoID`=1, `SuggestedGroupNum`=0, `RewardNextQuest`=0, `RewardXPDifficulty`=6, `RewardXPMultiplier`=1.75, `RewardMoneyDifficulty`=7, `RewardMoneyMultiplier`=1.255556, `RewardSpell`=0, `StartItem`=281371, `Flags`=0, `FlagsEx`=0, `FlagsEx2`=0, `AllowableRaces`=12261800583900083122, `TimeAllowed`=0, `VerifiedBuild`=70959, `RewardItem1`=0, `RewardAmount1`=0, `RewardItem2`=0, `RewardAmount2`=0, `RewardItem3`=0, `RewardAmount3`=0, `RewardItem4`=0, `RewardAmount4`=0, `RewardChoiceItemID1`=0, `RewardChoiceItemQuantity1`=0, `RewardChoiceItemID2`=0, `RewardChoiceItemQuantity2`=0, `RewardChoiceItemID3`=0, `RewardChoiceItemQuantity3`=0, `RewardChoiceItemID4`=0, `RewardChoiceItemQuantity4`=0, `RewardChoiceItemID5`=0, `RewardChoiceItemQuantity5`=0, `RewardChoiceItemID6`=0, `RewardChoiceItemQuantity6`=0, `RewardFactionID1`=2787, `RewardFactionValue1`=7, `RewardFactionOverride1`=50000, `RewardFactionCapIn1`=5, `RewardFactionID2`=0, `RewardFactionValue2`=0, `RewardFactionOverride2`=0, `RewardFactionCapIn2`=7, `RewardFactionID3`=0, `RewardFactionValue3`=0, `RewardFactionOverride3`=0, `RewardFactionCapIn3`=7, `RewardFactionID4`=0, `RewardFactionValue4`=0, `RewardFactionOverride4`=0, `RewardFactionCapIn4`=7, `RewardFactionID5`=0, `RewardFactionValue5`=0, `RewardFactionOverride5`=0, `RewardFactionCapIn5`=7 WHERE `ID`=98477 AND `VerifiedBuild`=-1;
DELETE FROM `quest_objectives` WHERE `QuestID`=98477;
DELETE FROM `quest_objectives` WHERE `ID` IN (477857);
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(477857,98477,1,0,1,274964,10,0,32,0,0.0,0,1,NULL,70959);
DELETE FROM `quest_classic_money` WHERE `ID`=98477;
INSERT INTO `quest_classic_money` (`ID`,`RewardMoney`,`RewardMoneyMaxLevel`) VALUES (98477,33900,0);

-- the quest items: Withermaw and Bonesnout drop their parts, and the Blackmaw Hold and Shaper's Terrace bosses drop motes. Only rows for these items are touched, so the rest of each creature's loot stays as it is.
DELETE FROM `creature_loot_template` WHERE `Entry` IN (247195,247198,247206,247207,247209,247231,247234,253201,261809,261811,261812,261813,261974,262081,262127,262297,272561) AND `ItemType`=0 AND `Item` IN (249696,249697,274964);
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(247195,0,249697,100,1,1,0,1,1,'Withermaw: Claws of the Great Bear for Claws That Rend, Tusks that Gore 92069 (which boss: Everlake; one each kill while on the quest INFERRED)'),
(247198,0,249696,100,1,1,0,1,1,'Bonesnout the Unbroken: Tusks of the Unbroken for 92069 (which boss: Everlake; one each kill while on the quest INFERRED)'),
(247195,0,274964,4.82,0,1,0,1,1,'Withermaw: Mote of Unstable Magic for Unstable Magic 98477 (seen on live; chance from Everlake)'),
(247198,0,274964,6.18,0,1,0,1,1,'Bonesnout the Unbroken: Mote of Unstable Magic for Unstable Magic 98477 (seen on live; chance from Everlake)'),
(247206,0,274964,6.16,0,1,0,1,1,'Impaan the Imprisoner: Mote of Unstable Magic for Unstable Magic 98477 (seen on live; chance from Everlake)'),
(247207,0,274964,6.81,0,1,0,1,1,'Blackmaw Behemoth: Mote of Unstable Magic for Unstable Magic 98477 (seen on live; chance from Everlake)'),
(247209,0,274964,6.67,0,1,0,1,1,'Elder Shaman Bloodmane: Mote of Unstable Magic for Unstable Magic 98477 (seen on live; chance from Everlake)'),
(247231,0,274964,6.64,0,1,0,1,1,'Unbound Spirit: Mote of Unstable Magic for Unstable Magic 98477 (seen on live; chance from Everlake)'),
(247234,0,274964,5.73,0,1,0,1,1,'Varrox Bleakhoof: Mote of Unstable Magic for Unstable Magic 98477 (seen on live; chance from Everlake)'),
(253201,0,274964,5.8,0,1,0,1,1,'Titanosaur: Mote of Unstable Magic for Unstable Magic 98477 (seen on live; chance from Everlake)'),
(261809,0,274964,3.07,0,1,0,1,1,'Nanaya: Mote of Unstable Magic for Unstable Magic 98477 (seen on live; chance from Everlake)'),
(261811,0,274964,4.08,0,1,0,1,1,'Tor''Rel: Mote of Unstable Magic for Unstable Magic 98477 (seen on live; chance from Everlake)'),
(261812,0,274964,8.97,0,1,0,1,1,'Thunderhoof: Mote of Unstable Magic for Unstable Magic 98477 (seen on live; chance from Everlake)'),
(261813,0,274964,3.61,0,1,0,1,1,'Venomridge: Mote of Unstable Magic for Unstable Magic 98477 (seen on live; chance from Everlake)'),
(261974,0,274964,3.64,0,1,0,1,1,'Cinder: Mote of Unstable Magic for Unstable Magic 98477 (seen on live; chance from Everlake)'),
(262081,0,274964,4.43,0,1,0,1,1,'Bolt: Mote of Unstable Magic for Unstable Magic 98477 (seen on live; chance from Everlake)'),
(262127,0,274964,4.52,0,1,0,1,1,'Direhorn Matriarch: Mote of Unstable Magic for Unstable Magic 98477 (seen on live; chance from Everlake)'),
(262297,0,274964,5.63,0,1,0,1,1,'Snowtalon: Mote of Unstable Magic for Unstable Magic 98477 (seen on live; chance from Everlake)'),
(272561,0,274964,4.2,0,1,0,1,1,'Vitrix: Mote of Unstable Magic for Unstable Magic 98477 (seen on live; chance from Everlake)');
