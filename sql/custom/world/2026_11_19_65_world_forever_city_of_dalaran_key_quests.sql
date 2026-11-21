-- City of Dalaran: the key quests, checked end to end for both factions against live data (EG Link, Efficient Games
-- https://efficient.games, CC BY 4.0: quests, quest givers and loot of the 1.60.1.70862, 70888 and 70938 folders; changed: only
-- the facts below are taken). Player report 2026-11-19 (Fox, RU): "the key quest is broken, you only get it with a GM command".
--
-- The chains (unchanged, they match live):
--   Alliance: An Alarming Request 92432 (Emissary Jacques) -> Heart of Disruption 92458 (Image of Archmage Modera; accepting it
--             hands over the Dalaran Sewer Key 277507) -> Friend of the Kirin Tor 92459 (Archmage Celindra).
--   Horde:    Key to the City 93680 (Magus Wordeen Voidglare; the Grimy Key 279469 from the Warden's Footlocker at the internment
--             camp) -> Blood in the Streets 92434 (to Modera) -> Heart of Disruption 96984 (Modera; hands over the Sewer Key, back
--             to Voidglare) -> Shrewd Negotiations 97287 (back to Modera).
--
-- Fixed:
--  * Heart of Disruption (both) asks for the Arcane Mote 251961. Ours dropped it from Rath'mael in the Ruins of Lordaeron, another
--    dungeon, so the City of Dalaran run never finished the quest. Live it drops from the Shade of the Archmage 246020, the
--    city's last boss (2 of 2 kills, quest item).
--  * Shrewd Negotiations 97287 is turned in to the Image of Archmage Modera live (Voidglare offers it, Modera takes it); ours
--    sent it to Archmage Celindra inside the city.
--  * Blood in the Streets 92434 had none of its objectives. Live it has two: enter area trigger 43995 by Lordamere Lake, and
--    hold the Grimy Key 279469 (which the quest hands over). The key one is added; the area trigger one is not, because no data
--    we have says where 43995 is, and an objective nobody can reach would block the Horde chain.
-- Safe to run again.

DELETE FROM `creature_loot_template` WHERE `Item` = 251961 AND `Entry` IN (250657,246020);
INSERT INTO `creature_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(246020,0,251961,100,1,1,0,1,1,'Shade of the Archmage: Arcane Mote for Heart of Disruption 92458/96984 (EG Link: 2 of 2 kills, quest item)');

DELETE FROM `creature_questender` WHERE `quest` = 97287;
INSERT INTO `creature_questender` (`id`,`quest`,`VerifiedBuild`) VALUES
(269127,97287,0);

DELETE FROM `quest_objectives` WHERE `ID` = 477032;
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(477032,92434,1,0,0,279469,1,0,0,0,0,0,1,'Grimy Key',0);
