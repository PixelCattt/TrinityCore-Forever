-- WoW Forever live realm: English capture from 2026-11-15 12:31 (client 70938): Westfall, Elwynn, Stormwind (city, harbor),
-- then Darkshore and Darnassus. Only what our data lacks or has wrong. Safe to run more than once.
-- New spawn guids: gameobject 46120200-46120399 (creature block 46120200-46120399 reserved, not used).

-- 1. Quest 98025 (Jai'vhanel bounty, Darkshore): live fixed a typo and the class word.
UPDATE `quest_offer_reward` SET `RewardText` = REPLACE(`RewardText`, 'her decent into madness', 'her descent into madness') WHERE `ID` = 98025;
UPDATE `quest_request_items` SET `CompletionText` = REPLACE(`CompletionText`, 'Greetings $C - ', 'Greetings, $c - ') WHERE `ID` = 98025;

-- 2. NPC data live sends that differs from ours.
UPDATE `creature_template` SET `subname` = 'Church of the Holy Light' WHERE `entry` = 5492;   -- Katherine the Pure
UPDATE `creature_template` SET `type` = 1 WHERE `entry` = 10598;   -- Smolderweb Hatchling: beast live
UPDATE `creature_template` SET `npcflag` = `npcflag` | 4096 WHERE `entry` IN (12782, 12777);   -- Captain O'Neal, Captain Dirgehammer: they repair live
-- Factions live uses.
UPDATE `creature_template` SET `faction` = 875 WHERE `entry` = 253395;   -- Ozwin Ironsprocket
UPDATE `creature_template` SET `faction` = 80 WHERE `entry` = 253092;   -- Alba Fairmoon
UPDATE `creature_template` SET `faction` = 84 WHERE `entry` = 4961;   -- Dashel Stonefist
UPDATE `creature_template` SET `faction` = 11 WHERE `entry` = 267007;   -- Stormwind Harbor Guard
UPDATE `creature_template` SET `faction` = 1078 WHERE `entry` = 267064;   -- Stormwind Cannoneer
UPDATE `creature_template` SET `faction` = 1078 WHERE `entry` = 249215;   -- Stormwind Dock Worker
-- Models live: Stonetusk Boar has the newer boar model, Donna and the orphans other child models, the harbor NPCs more variety.
DELETE FROM `creature_template_model` WHERE `CreatureID` = 113;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES (113, 0, 138616, 1, 1, 70938);
DELETE FROM `creature_template_model` WHERE `CreatureID` = 2532;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES (2532, 0, 252, 1, 1, 70938);
DELETE FROM `creature_template_model` WHERE `CreatureID` = 14496;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES (14496, 0, 144326, 1, 1, 70938), (14496, 1, 144327, 1, 1, 70938), (14496, 2, 144328, 1, 1, 70938), (14496, 3, 144329, 1, 1, 70938);
DELETE FROM `creature_template_model` WHERE `CreatureID` = 267007;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES (267007, 0, 3167, 1, 50, 70938), (267007, 1, 5446, 1, 50, 70938);
DELETE FROM `creature_template_model` WHERE `CreatureID` = 267064;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES (267064, 0, 144952, 1, 1, 70938), (267064, 1, 144953, 1, 1, 70938);
DELETE FROM `creature_template_model` WHERE `CreatureID` = 249215;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES (249215, 0, 144941, 1, 1, 70938), (249215, 1, 144942, 1, 1, 70938), (249215, 2, 144943, 1, 1, 70938), (249215, 3, 144944, 1, 1, 70938);
DELETE FROM `creature_template_model` WHERE `CreatureID` = 10598;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES (10598, 0, 9997, 1, 1, 70938);
-- Weapons live: Stormwind guards and the Westfall Protectors carry crossbow 12523 (ours 2551 or none), and NPCs that had none.
DELETE FROM `creature_equip_template` WHERE `ID` = 1 AND `CreatureID` IN (68, 487, 488, 489, 490, 869, 870, 874, 876, 1423, 1756, 1976, 249215, 253092, 267007, 267064, 267118, 274906);
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `AppearanceModID1`, `ItemVisual1`, `ItemID2`, `AppearanceModID2`, `ItemVisual2`, `ItemID3`, `AppearanceModID3`, `ItemVisual3`, `VerifiedBuild`) VALUES
(68, 1, 1899, 0, 0, 143, 0, 0, 12523, 0, 0, 70938),
(487, 1, 1899, 0, 0, 2053, 0, 0, 12523, 0, 0, 70938),
(488, 1, 1896, 0, 0, 2051, 0, 0, 12523, 0, 0, 70938),
(489, 1, 1897, 0, 0, 1957, 0, 0, 12523, 0, 0, 70938),
(490, 1, 1897, 0, 0, 2053, 0, 0, 12523, 0, 0, 70938),
(869, 1, 1897, 0, 0, 2053, 0, 0, 12523, 0, 0, 70938),
(870, 1, 1897, 0, 0, 2053, 0, 0, 12523, 0, 0, 70938),
(874, 1, 1896, 0, 0, 2053, 0, 0, 12523, 0, 0, 70938),
(876, 1, 1896, 0, 0, 2052, 0, 0, 12523, 0, 0, 70938),
(1423, 1, 1899, 0, 0, 143, 0, 0, 12523, 0, 0, 70938),
(1756, 1, 1899, 0, 0, 143, 0, 0, 12523, 0, 0, 70938),
(1976, 1, 1899, 0, 0, 143, 0, 0, 0, 0, 0, 70938),
(249215, 1, 1911, 0, 0, 0, 0, 0, 0, 0, 0, 70938),
(253092, 1, 2716, 0, 0, 3694, 0, 0, 0, 0, 0, 70938),
(267007, 1, 1899, 0, 0, 143, 0, 0, 12523, 0, 0, 70938),
(267064, 1, 1906, 0, 0, 0, 0, 0, 0, 0, 0, 70938),
(267118, 1, 1117, 0, 0, 0, 0, 0, 0, 0, 0, 70938),
(274906, 1, 2178, 0, 0, 2178, 0, 0, 0, 0, 0, 70938);
-- Emote states live: Westfall Woodworker (69) and Stormwind Dock Worker (233).
INSERT INTO `creature_template_addon` (`entry`, `emote`) VALUES (6670, 69), (249215, 233) ON DUPLICATE KEY UPDATE `emote` = VALUES(`emote`);

-- 3. Laird (4200, Auberdine fish vendor) sells Raw Slitherskin Mackerel (6303) live.
DELETE FROM `npc_vendor` WHERE `entry` = 4200 AND `item` = 6303;
INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `type`, `BonusListIDs`, `PlayerConditionID`, `IgnoreFiltering`, `VerifiedBuild`) VALUES (4200, 224, 6303, 5, 3600, 0, 1, '', 0, 0, 70938);   -- 5 in stock live, like his other fish

-- 4. Object data live sends that differs from ours.
UPDATE `gameobject_template` SET `displayId` = 114064 WHERE `entry` = 177666;   -- Moonwell Spell Focus
UPDATE `gameobject_template` SET `displayId` = 1287, `Data0` = 95 WHERE `entry` = 109515;   -- Night Elven Bear Trap
UPDATE `gameobject_template` SET `Data0` = 1 WHERE `entry` = 696211;   -- Just Maces
UPDATE `gameobject_template` SET `Data0` = 1 WHERE `entry` = 696293;   -- Dwarven District
UPDATE `gameobject_template` SET `Data0` = 1 WHERE `entry` = 696294;   -- Cathedral Square
UPDATE `gameobject_template` SET `name` = 'Cleansing Water Aura' WHERE `entry` = 106529;

-- 5. Object templates our data lacks, from live's object query answers: the furniture of two Stormwind houses (one with
--    bookshelf and cellar door), two fires and a mailbox.
DELETE FROM `gameobject_template` WHERE `entry` IN (660672, 660709, 696274, 696608, 696609, 696610, 696611, 696612, 696613, 696614, 696615, 696616, 696617, 696618, 696619, 696620, 696621, 696622, 696623, 696624, 696625, 696626, 696627, 696628, 696629, 696630, 696631, 696632, 696633, 696634, 696635, 696636, 696637, 696638, 696639, 696640, 696641, 696642, 696643, 696644, 696645, 696646, 696647, 696648, 696649, 696650, 696651, 696652);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `VerifiedBuild`) VALUES
(660672, 5, 137, 'Bookshelf', '', '', '', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70938),
(660709, 0, 127202, 'Cellar Door', '', '', '', 0.8, 0, 1620, 3000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70938),
(696274, 19, 1907, 'Mailbox', '', '', '', 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70938),
(696608, 7, 39, 'Wooden Chair', '', '', '', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70938),
(696609, 7, 39, 'Wooden Chair', '', '', '', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70938),
(696610, 7, 39, 'Wooden Chair', '', '', '', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70938),
(696611, 7, 39, 'Wooden Chair', '', '', '', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70938),
(696612, 7, 39, 'Wooden Chair', '', '', '', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70938),
(696613, 7, 39, 'Wooden Chair', '', '', '', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70938),
(696614, 7, 39, 'Wooden Chair', '', '', '', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70938),
(696615, 7, 39, 'Wooden Chair', '', '', '', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70938),
(696616, 7, 39, 'Wooden Chair', '', '', '', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70938),
(696617, 7, 39, 'Wooden Chair', '', '', '', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70938),
(696618, 7, 39, 'Wooden Chair', '', '', '', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70938),
(696619, 7, 39, 'Wooden Chair', '', '', '', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70938),
(696620, 7, 39, 'Wooden Chair', '', '', '', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70938),
(696621, 7, 39, 'Wooden Chair', '', '', '', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70938),
(696622, 7, 39, 'Wooden Chair', '', '', '', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70938),
(696623, 7, 39, 'Wooden Chair', '', '', '', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70938),
(696624, 7, 39, 'Wooden Chair', '', '', '', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70938),
(696625, 7, 39, 'Wooden Chair', '', '', '', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70938),
(696626, 7, 39, 'Wooden Chair', '', '', '', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70938),
(696627, 7, 39, 'Wooden Chair', '', '', '', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70938),
(696628, 7, 39, 'Wooden Chair', '', '', '', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70938),
(696629, 7, 39, 'Wooden Chair', '', '', '', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70938),
(696630, 7, 39, 'Wooden Chair', '', '', '', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70938),
(696631, 7, 39, 'Wooden Chair', '', '', '', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70938),
(696632, 7, 39, 'Wooden Chair', '', '', '', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70938),
(696633, 7, 39, 'Wooden Chair', '', '', '', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70938),
(696634, 7, 39, 'Wooden Chair', '', '', '', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70938),
(696635, 7, 39, 'Wooden Chair', '', '', '', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70938),
(696636, 7, 39, 'Wooden Chair', '', '', '', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70938),
(696637, 7, 39, 'Wooden Chair', '', '', '', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70938),
(696638, 7, 39, 'Wooden Chair', '', '', '', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70938),
(696639, 7, 39, 'Wooden Chair', '', '', '', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70938),
(696640, 7, 39, 'Wooden Chair', '', '', '', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70938),
(696641, 7, 39, 'Wooden Chair', '', '', '', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70938),
(696642, 7, 39, 'Wooden Chair', '', '', '', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70938),
(696643, 7, 39, 'Wooden Chair', '', '', '', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70938),
(696644, 7, 39, 'Wooden Chair', '', '', '', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70938),
(696645, 7, 39, 'Wooden Chair', '', '', '', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70938),
(696646, 7, 39, 'Wooden Chair', '', '', '', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70938),
(696647, 7, 39, 'Wooden Chair', '', '', '', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70938),
(696648, 7, 39, 'Wooden Chair', '', '', '', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70938),
(696649, 7, 39, 'Wooden Chair', '', '', '', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70938),
(696650, 7, 39, 'Wooden Chair', '', '', '', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70938),
(696651, 8, 199, 'Warm Fire', '', '', '', 1.18, 4, 10, 2061, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70938),
(696652, 8, 199, 'Warm Fire', '', '', '', 1, 4, 10, 2061, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70938);

-- 6. Their spawns, plus chairs, benches and books live has in Stormwind (and two fires and a chair in Elwynn) whose templates we
--    have but never placed there. Inserts skip anything of the same id within 5 yd.
DELETE FROM `gameobject` WHERE `guid` BETWEEN 46120200 AND 46120399;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`,
  `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`)
SELECT n.guid, n.id, 0, 0, 0, '0', 0, 0, 0, -1, n.x, n.y, n.z, n.o, n.r0, n.r1, n.r2, n.r3, 120, 255, n.st, '', 70938 FROM (
  SELECT 46120200 AS guid, 164759 AS id, -8514.271 AS x, 1323.69 AS y, 6.067 AS z, 5.3669 AS o, 0 AS r0, 0 AS r1, -0.4423 AS r2, 0.8969 AS r3, 1 AS st
  UNION ALL SELECT 46120201 AS guid, 164760 AS id, -8513.074 AS x, 1322.334 AS y, 6.067 AS z, 2.3038 AS o, 0 AS r0, 0 AS r1, 0.9135 AS r2, 0.4067 AS r3, 1 AS st
  UNION ALL SELECT 46120202 AS guid, 164761 AS id, -8514.237 AS x, 1326.48 AS y, 6.1 AS z, 2.3038 AS o, 0 AS r0, 0 AS r1, 0.9135 AS r2, 0.4067 AS r3, 1 AS st
  UNION ALL SELECT 46120203 AS guid, 164762 AS id, -8515.447 AS x, 1327.882 AS y, 6.1 AS z, 5.3669 AS o, 0 AS r0, 0 AS r1, -0.4423 AS r2, 0.8969 AS r3, 1 AS st
  UNION ALL SELECT 46120204 AS guid, 164763 AS id, -8510.681 AS x, 1329.431 AS y, 6.1 AS z, 3.1853 AS o, 0 AS r0, 0 AS r1, -0.9998 AS r2, 0.0218 AS r3, 1 AS st
  UNION ALL SELECT 46120205 AS guid, 164764 AS id, -8512.462 AS x, 1329.384 AS y, 6.1 AS z, 6.2483 AS o, 0 AS r0, 0 AS r1, -0.0175 AS r2, 0.9998 AS r3, 1 AS st
  UNION ALL SELECT 46120206 AS guid, 164765 AS id, -8502.515 AS x, 1334.988 AS y, 6.103 AS z, 2.3038 AS o, 0 AS r0, 0 AS r1, 0.9135 AS r2, 0.4067 AS r3, 1 AS st
  UNION ALL SELECT 46120207 AS guid, 164766 AS id, -8503.532 AS x, 1336.123 AS y, 6.103 AS z, 5.3669 AS o, 0 AS r0, 0 AS r1, -0.4423 AS r2, 0.8969 AS r3, 1 AS st
  UNION ALL SELECT 46120208 AS guid, 164767 AS id, -8516.428 AS x, 1301.525 AS y, 6.102 AS z, 1.0908 AS o, 0 AS r0, 0 AS r1, 0.5188 AS r2, 0.8549 AS r3, 1 AS st
  UNION ALL SELECT 46120209 AS guid, 175735 AS id, -8717.406 AS x, 1051.908 AS y, 97.012 AS z, 5.1662 AS o, 0 AS r0, 0 AS r1, -0.5299 AS r2, 0.848 AS r3, 1 AS st
  UNION ALL SELECT 46120210 AS guid, 175746 AS id, -8724.466 AS x, 1054.722 AS y, 99.203 AS z, 5.6025 AS o, 0 AS r0, 0 AS r1, -0.3338 AS r2, 0.9426 AS r3, 1 AS st
  UNION ALL SELECT 46120211 AS guid, 175746 AS id, -8716.667 AS x, 1046.484 AS y, 97.694 AS z, 0 AS o, 0 AS r0, 0 AS r1, 0 AS r2, 1 AS r3, 1 AS st
  UNION ALL SELECT 46120212 AS guid, 175753 AS id, -8704.413 AS x, 1048.507 AS y, 97.145 AS z, 3.0194 AS o, 0 AS r0, 0 AS r1, 0.9981 AS r2, 0.0611 AS r3, 1 AS st
  UNION ALL SELECT 46120213 AS guid, 175761 AS id, -8719.312 AS x, 1046.323 AS y, 96.843 AS z, 0.6868 AS o, -0.284 AS r0, 0.6292 AS r1, 0.2928 AS r2, 0.6616 AS r3, 1 AS st
  UNION ALL SELECT 46120214 AS guid, 175855 AS id, -8722.205 AS x, 1057.059 AS y, 99.208 AS z, 0 AS o, 0 AS r0, 0 AS r1, 0 AS r2, 1 AS r3, 1 AS st
  UNION ALL SELECT 46120215 AS guid, 660672 AS id, -8724.863 AS x, 1054.712 AS y, 95.987 AS z, 5.4978 AS o, 0 AS r0, 0 AS r1, -0.3827 AS r2, 0.9239 AS r3, 1 AS st
  UNION ALL SELECT 46120216 AS guid, 660672 AS id, -8722.889 AS x, 1056.719 AS y, 95.987 AS z, 5.4803 AS o, 0 AS r0, 0 AS r1, -0.3907 AS r2, 0.9205 AS r3, 1 AS st
  UNION ALL SELECT 46120217 AS guid, 660672 AS id, -8718.988 AS x, 1045.769 AS y, 95.987 AS z, 0.7679 AS o, 0 AS r0, 0 AS r1, 0.3746 AS r2, 0.9272 AS r3, 1 AS st
  UNION ALL SELECT 46120218 AS guid, 660709 AS id, -8697.011 AS x, 1047.455 AS y, 96.023 AS z, 0.8034 AS o, 0.0748 AS r0, -0.1666 AS r1, 0.3851 AS r2, 0.9046 AS r3, 1 AS st
  UNION ALL SELECT 46120219 AS guid, 694821 AS id, -9435.124 AS x, 472.543 AS y, 53.212 AS z, 1.2828 AS o, 0 AS r0, 0 AS r1, 0.5983 AS r2, 0.8013 AS r3, 1 AS st
  UNION ALL SELECT 46120220 AS guid, 694821 AS id, -9306.58 AS x, 289.395 AS y, 70.475 AS z, 0.8639 AS o, 0 AS r0, 0 AS r1, 0.4187 AS r2, 0.9081 AS r3, 1 AS st
  UNION ALL SELECT 46120221 AS guid, 694821 AS id, -9267.925 AS x, 361.517 AS y, 76.629 AS z, 2.5307 AS o, 0 AS r0, 0 AS r1, 0.9537 AS r2, 0.3007 AS r3, 1 AS st
  UNION ALL SELECT 46120222 AS guid, 694822 AS id, -9435.847 AS x, 473.07 AS y, 53.212 AS z, 2.5744 AS o, 0 AS r0, 0 AS r1, 0.96 AS r2, 0.2798 AS r3, 1 AS st
  UNION ALL SELECT 46120223 AS guid, 694822 AS id, -9307.025 AS x, 290.171 AS y, 70.475 AS z, 2.1555 AS o, 0 AS r0, 0 AS r1, 0.8809 AS r2, 0.4733 AS r3, 1 AS st
  UNION ALL SELECT 46120224 AS guid, 694822 AS id, -9268.654 AS x, 360.999 AS y, 76.629 AS z, 3.8223 AS o, 0 AS r0, 0 AS r1, -0.9426 AS r2, 0.3338 AS r3, 1 AS st
  UNION ALL SELECT 46120225 AS guid, 694823 AS id, -9879.735 AS x, 324.175 AS y, 37.757 AS z, 3.9008 AS o, 0 AS r0, 0 AS r1, -0.9288 AS r2, 0.3706 AS r3, 1 AS st
  UNION ALL SELECT 46120226 AS guid, 694823 AS id, -9268.231 AS x, 352.679 AS y, 76.709 AS z, 0.6981 AS o, 0 AS r0, 0 AS r1, 0.342 AS r2, 0.9397 AS r3, 1 AS st
  UNION ALL SELECT 46120227 AS guid, 696274 AS id, -8393.654 AS x, 1064.353 AS y, 32.167 AS z, 3.0892 AS o, 0 AS r0, 0 AS r1, 0.9997 AS r2, 0.0262 AS r3, 1 AS st
  UNION ALL SELECT 46120228 AS guid, 696444 AS id, -8569.119 AS x, 817.202 AS y, 106.577 AS z, 0.672 AS o, 0 AS r0, 0 AS r1, 0.3297 AS r2, 0.9441 AS r3, 1 AS st
  UNION ALL SELECT 46120229 AS guid, 696445 AS id, -8557.444 AS x, 814.054 AS y, 106.577 AS z, 3.8135 AS o, 0 AS r0, 0 AS r1, -0.9441 AS r2, 0.3297 AS r3, 1 AS st
  UNION ALL SELECT 46120230 AS guid, 696446 AS id, -8569.187 AS x, 828.855 AS y, 106.577 AS z, 3.8135 AS o, 0 AS r0, 0 AS r1, -0.9441 AS r2, 0.3297 AS r3, 1 AS st
  UNION ALL SELECT 46120231 AS guid, 696450 AS id, -8533.884 AS x, 871.441 AS y, 106.574 AS z, 5.3843 AS o, 0 AS r0, 0 AS r1, -0.4344 AS r2, 0.9007 AS r3, 1 AS st
  UNION ALL SELECT 46120232 AS guid, 696451 AS id, -8508.427 AS x, 839.437 AS y, 106.574 AS z, 2.2428 AS o, 0 AS r0, 0 AS r1, 0.9007 AS r2, 0.4344 AS r3, 1 AS st
  UNION ALL SELECT 46120233 AS guid, 696452 AS id, -8569.688 AS x, 887.592 AS y, 106.523 AS z, 3.8135 AS o, 0 AS r0, 0 AS r1, -0.9441 AS r2, 0.3297 AS r3, 1 AS st
  UNION ALL SELECT 46120234 AS guid, 696453 AS id, -8558.231 AS x, 873.316 AS y, 106.523 AS z, 3.8135 AS o, 0 AS r0, 0 AS r1, -0.9441 AS r2, 0.3297 AS r3, 1 AS st
  UNION ALL SELECT 46120235 AS guid, 696456 AS id, -8558.513 AS x, 871.096 AS y, 106.523 AS z, 2.2428 AS o, 0 AS r0, 0 AS r1, 0.9007 AS r2, 0.4344 AS r3, 1 AS st
  UNION ALL SELECT 46120236 AS guid, 696457 AS id, -8571.991 AS x, 887.916 AS y, 106.523 AS z, 5.3843 AS o, 0 AS r0, 0 AS r1, -0.4344 AS r2, 0.9007 AS r3, 1 AS st
  UNION ALL SELECT 46120237 AS guid, 696458 AS id, -8528.03 AS x, 802.491 AS y, 106.523 AS z, 0.672 AS o, 0 AS r0, 0 AS r1, 0.3297 AS r2, 0.9441 AS r3, 1 AS st
  UNION ALL SELECT 46120238 AS guid, 696459 AS id, -8516.739 AS x, 788.297 AS y, 106.523 AS z, 0.672 AS o, 0 AS r0, 0 AS r1, 0.3297 AS r2, 0.9441 AS r3, 1 AS st
  UNION ALL SELECT 46120239 AS guid, 696460 AS id, -8514.438 AS x, 815.458 AS y, 106.523 AS z, 5.3843 AS o, 0 AS r0, 0 AS r1, -0.4344 AS r2, 0.9007 AS r3, 1 AS st
  UNION ALL SELECT 46120240 AS guid, 696461 AS id, -8514.44 AS x, 788.049 AS y, 106.523 AS z, 2.2428 AS o, 0 AS r0, 0 AS r1, 0.9007 AS r2, 0.4344 AS r3, 1 AS st
  UNION ALL SELECT 46120241 AS guid, 696462 AS id, -8501.154 AS x, 798.666 AS y, 106.523 AS z, 2.2428 AS o, 0 AS r0, 0 AS r1, 0.9007 AS r2, 0.4344 AS r3, 1 AS st
  UNION ALL SELECT 46120242 AS guid, 696463 AS id, -8500.72 AS x, 801.048 AS y, 106.523 AS z, 3.8135 AS o, 0 AS r0, 0 AS r1, -0.9441 AS r2, 0.3297 AS r3, 1 AS st
  UNION ALL SELECT 46120243 AS guid, 696464 AS id, -8527.743 AS x, 804.874 AS y, 106.523 AS z, 5.3843 AS o, 0 AS r0, 0 AS r1, -0.4344 AS r2, 0.9007 AS r3, 1 AS st
  UNION ALL SELECT 46120244 AS guid, 696465 AS id, -8512.067 AS x, 815.228 AS y, 106.523 AS z, 3.8135 AS o, 0 AS r0, 0 AS r1, -0.9441 AS r2, 0.3297 AS r3, 1 AS st
  UNION ALL SELECT 46120245 AS guid, 696466 AS id, -8498.374 AS x, 822.401 AS y, 96.678 AS z, 5.3843 AS o, 0 AS r0, 0 AS r1, -0.4344 AS r2, 0.9007 AS r3, 1 AS st
  UNION ALL SELECT 46120246 AS guid, 696467 AS id, -8496.031 AS x, 822.13 AS y, 96.678 AS z, 3.8135 AS o, 0 AS r0, 0 AS r1, -0.9441 AS r2, 0.3297 AS r3, 1 AS st
  UNION ALL SELECT 46120247 AS guid, 696468 AS id, -8485.335 AS x, 808.661 AS y, 96.678 AS z, 3.8135 AS o, 0 AS r0, 0 AS r1, -0.9441 AS r2, 0.3297 AS r3, 1 AS st
  UNION ALL SELECT 46120248 AS guid, 696469 AS id, -8485.567 AS x, 806.179 AS y, 96.678 AS z, 2.2428 AS o, 0 AS r0, 0 AS r1, 0.9007 AS r2, 0.4344 AS r3, 1 AS st
  UNION ALL SELECT 46120249 AS guid, 696470 AS id, -8510.779 AS x, 812.485 AS y, 96.678 AS z, 5.3843 AS o, 0 AS r0, 0 AS r1, -0.4344 AS r2, 0.9007 AS r3, 1 AS st
  UNION ALL SELECT 46120250 AS guid, 696471 AS id, -8510.987 AS x, 810.204 AS y, 96.678 AS z, 0.672 AS o, 0 AS r0, 0 AS r1, 0.3297 AS r2, 0.9441 AS r3, 1 AS st
  UNION ALL SELECT 46120251 AS guid, 696472 AS id, -8559.959 AS x, 902.136 AS y, 96.69 AS z, 5.3843 AS o, 0 AS r0, 0 AS r1, -0.4344 AS r2, 0.9007 AS r3, 1 AS st
  UNION ALL SELECT 46120252 AS guid, 696473 AS id, -8557.653 AS x, 901.768 AS y, 96.69 AS z, 3.8135 AS o, 0 AS r0, 0 AS r1, -0.9441 AS r2, 0.3297 AS r3, 1 AS st
  UNION ALL SELECT 46120253 AS guid, 696474 AS id, -8546.882 AS x, 888.219 AS y, 96.69 AS z, 3.8135 AS o, 0 AS r0, 0 AS r1, -0.9441 AS r2, 0.3297 AS r3, 1 AS st
  UNION ALL SELECT 46120254 AS guid, 696475 AS id, -8547.143 AS x, 885.77 AS y, 96.69 AS z, 2.2428 AS o, 0 AS r0, 0 AS r1, 0.9007 AS r2, 0.4344 AS r3, 1 AS st
  UNION ALL SELECT 46120255 AS guid, 696476 AS id, -8561.775 AS x, 876.324 AS y, 96.69 AS z, 0.672 AS o, 0 AS r0, 0 AS r1, 0.3297 AS r2, 0.9441 AS r3, 1 AS st
  UNION ALL SELECT 46120256 AS guid, 696477 AS id, -8559.545 AS x, 875.961 AS y, 96.69 AS z, 2.2428 AS o, 0 AS r0, 0 AS r1, 0.9007 AS r2, 0.4344 AS r3, 1 AS st
  UNION ALL SELECT 46120257 AS guid, 696478 AS id, -8562.492 AS x, 848.685 AS y, 106.574 AS z, 5.3843 AS o, 0 AS r0, 0 AS r1, -0.4344 AS r2, 0.9007 AS r3, 1 AS st
  UNION ALL SELECT 46120258 AS guid, 696479 AS id, -8569.659 AS x, 842.985 AS y, 106.574 AS z, 5.3843 AS o, 0 AS r0, 0 AS r1, -0.4344 AS r2, 0.9007 AS r3, 1 AS st
  UNION ALL SELECT 46120259 AS guid, 696480 AS id, -8544.202 AS x, 810.981 AS y, 106.574 AS z, 2.2428 AS o, 0 AS r0, 0 AS r1, 0.9007 AS r2, 0.4344 AS r3, 1 AS st
  UNION ALL SELECT 46120260 AS guid, 696481 AS id, -8537.035 AS x, 816.681 AS y, 106.574 AS z, 2.2428 AS o, 0 AS r0, 0 AS r1, 0.9007 AS r2, 0.4344 AS r3, 1 AS st
  UNION ALL SELECT 46120261 AS guid, 696482 AS id, -8548.204 AS x, 860.051 AS y, 106.574 AS z, 5.3843 AS o, 0 AS r0, 0 AS r1, -0.4344 AS r2, 0.9007 AS r3, 1 AS st
  UNION ALL SELECT 46120262 AS guid, 696483 AS id, -8522.747 AS x, 828.047 AS y, 106.574 AS z, 2.2428 AS o, 0 AS r0, 0 AS r1, 0.9007 AS r2, 0.4344 AS r3, 1 AS st
  UNION ALL SELECT 46120263 AS guid, 696608 AS id, -8720.897 AS x, 1051.01 AS y, 96.008 AS z, 0.7941 AS o, 0 AS r0, 0 AS r1, 0.3867 AS r2, 0.9222 AS r3, 1 AS st
  UNION ALL SELECT 46120264 AS guid, 696609 AS id, -8720.49 AS x, 1053.526 AS y, 96.008 AS z, 5.4542 AS o, 0 AS r0, 0 AS r1, -0.4027 AS r2, 0.9153 AS r3, 1 AS st
  UNION ALL SELECT 46120265 AS guid, 696610 AS id, -8718.16 AS x, 1053.769 AS y, 96.008 AS z, 3.9357 AS o, 0 AS r0, 0 AS r1, -0.9222 AS r2, 0.3867 AS r3, 1 AS st
  UNION ALL SELECT 46120266 AS guid, 696611 AS id, -8716.782 AS x, 1052.478 AS y, 96.008 AS z, 3.9357 AS o, 0 AS r0, 0 AS r1, -0.9222 AS r2, 0.3867 AS r3, 1 AS st
  UNION ALL SELECT 46120267 AS guid, 696612 AS id, -8716.901 AS x, 1049.969 AS y, 96.008 AS z, 2.33 AS o, 0 AS r0, 0 AS r1, 0.9188 AS r2, 0.3947 AS r3, 1 AS st
  UNION ALL SELECT 46120268 AS guid, 696613 AS id, -8719.387 AS x, 1049.551 AS y, 96.008 AS z, 0.7941 AS o, 0 AS r0, 0 AS r1, 0.3867 AS r2, 0.9222 AS r3, 1 AS st
  UNION ALL SELECT 46120269 AS guid, 696614 AS id, -8704.687 AS x, 1049.743 AS y, 95.999 AS z, 5.4542 AS o, 0 AS r0, 0 AS r1, -0.4027 AS r2, 0.9153 AS r3, 1 AS st
  UNION ALL SELECT 46120270 AS guid, 696615 AS id, -8702.493 AS x, 1049.664 AS y, 95.999 AS z, 3.9183 AS o, 0 AS r0, 0 AS r1, -0.9255 AS r2, 0.3786 AS r3, 1 AS st
  UNION ALL SELECT 46120271 AS guid, 696616 AS id, -8702.453 AS x, 1047.57 AS y, 95.999 AS z, 2.3126 AS o, 0 AS r0, 0 AS r1, 0.9153 AS r2, 0.4027 AS r3, 1 AS st
  UNION ALL SELECT 46120272 AS guid, 696617 AS id, -8704.619 AS x, 1047.447 AS y, 95.999 AS z, 0.7767 AS o, 0 AS r0, 0 AS r1, 0.3786 AS r2, 0.9255 AS r3, 1 AS st
  UNION ALL SELECT 46120273 AS guid, 696618 AS id, -8851.73 AS x, 1080.93 AS y, 95.211 AS z, 3.4383 AS o, 0 AS r0, 0 AS r1, -0.989 AS r2, 0.1478 AS r3, 1 AS st
  UNION ALL SELECT 46120274 AS guid, 696619 AS id, -8845.736 AS x, 1089.181 AS y, 95.211 AS z, 5.0091 AS o, 0 AS r0, 0 AS r1, -0.5948 AS r2, 0.8039 AS r3, 1 AS st
  UNION ALL SELECT 46120275 AS guid, 696620 AS id, -8848.68 AS x, 1086.387 AS y, 95.211 AS z, 0.2618 AS o, 0 AS r0, 0 AS r1, 0.1305 AS r2, 0.9914 AS r3, 1 AS st
  UNION ALL SELECT 46120276 AS guid, 696621 AS id, -8843.109 AS x, 1080.568 AS y, 95.211 AS z, 5.0091 AS o, 0 AS r0, 0 AS r1, -0.5948 AS r2, 0.8039 AS r3, 1 AS st
  UNION ALL SELECT 46120277 AS guid, 696622 AS id, -8847.759 AS x, 1088.579 AS y, 95.211 AS z, 5.0091 AS o, 0 AS r0, 0 AS r1, -0.5948 AS r2, 0.8039 AS r3, 1 AS st
  UNION ALL SELECT 46120278 AS guid, 696623 AS id, -8857.44 AS x, 1072.931 AS y, 102.466 AS z, 1.8151 AS o, 0 AS r0, 0 AS r1, 0.788 AS r2, 0.6157 AS r3, 1 AS st
  UNION ALL SELECT 46120279 AS guid, 696624 AS id, -8850.394 AS x, 1070.479 AS y, 95.211 AS z, 4.9567 AS o, 0 AS r0, 0 AS r1, -0.6157 AS r2, 0.788 AS r3, 1 AS st
  UNION ALL SELECT 46120280 AS guid, 696625 AS id, -8851.565 AS x, 1068.64 AS y, 95.211 AS z, 0.2792 AS o, 0 AS r0, 0 AS r1, 0.1392 AS r2, 0.9903 AS r3, 1 AS st
  UNION ALL SELECT 46120281 AS guid, 696626 AS id, -8860.2 AS x, 1067.414 AS y, 102.466 AS z, 4.9567 AS o, 0 AS r0, 0 AS r1, -0.6157 AS r2, 0.788 AS r3, 1 AS st
  UNION ALL SELECT 46120282 AS guid, 696627 AS id, -8861.173 AS x, 1065.46 AS y, 102.466 AS z, 0.2792 AS o, 0 AS r0, 0 AS r1, 0.1392 AS r2, 0.9903 AS r3, 1 AS st
  UNION ALL SELECT 46120283 AS guid, 696628 AS id, -8865.021 AS x, 1088.993 AS y, 102.466 AS z, 3.4209 AS o, 0 AS r0, 0 AS r1, -0.9903 AS r2, 0.1392 AS r3, 1 AS st
  UNION ALL SELECT 46120284 AS guid, 696629 AS id, -8861.756 AS x, 1081.64 AS y, 102.466 AS z, 0.2792 AS o, 0 AS r0, 0 AS r1, 0.1392 AS r2, 0.9903 AS r3, 1 AS st
  UNION ALL SELECT 46120285 AS guid, 696630 AS id, -8868.081 AS x, 1088.203 AS y, 102.466 AS z, 0.2792 AS o, 0 AS r0, 0 AS r1, 0.1392 AS r2, 0.9903 AS r3, 1 AS st
  UNION ALL SELECT 46120286 AS guid, 696631 AS id, -8866.089 AS x, 1086.819 AS y, 102.466 AS z, 1.8151 AS o, 0 AS r0, 0 AS r1, 0.788 AS r2, 0.6157 AS r3, 1 AS st
  UNION ALL SELECT 46120287 AS guid, 696632 AS id, -8858.282 AS x, 1075.92 AS y, 102.466 AS z, 4.9567 AS o, 0 AS r0, 0 AS r1, -0.6157 AS r2, 0.788 AS r3, 1 AS st
  UNION ALL SELECT 46120288 AS guid, 696633 AS id, -8860.58 AS x, 1083.288 AS y, 102.466 AS z, 4.9567 AS o, 0 AS r0, 0 AS r1, -0.6157 AS r2, 0.788 AS r3, 1 AS st
  UNION ALL SELECT 46120289 AS guid, 696634 AS id, -8855.142 AS x, 1079.94 AS y, 95.211 AS z, 0.2967 AS o, 0 AS r0, 0 AS r1, 0.1478 AS r2, 0.989 AS r3, 1 AS st
  UNION ALL SELECT 46120290 AS guid, 696635 AS id, -8858.266 AS x, 1066.147 AS y, 102.466 AS z, 3.4209 AS o, 0 AS r0, 0 AS r1, -0.9903 AS r2, 0.1392 AS r3, 1 AS st
  UNION ALL SELECT 46120291 AS guid, 696636 AS id, -8859.813 AS x, 1080.39 AS y, 102.466 AS z, 1.8151 AS o, 0 AS r0, 0 AS r1, 0.788 AS r2, 0.6157 AS r3, 1 AS st
  UNION ALL SELECT 46120292 AS guid, 696637 AS id, -8844.576 AS x, 1085.608 AS y, 95.211 AS z, 1.8675 AS o, 0 AS r0, 0 AS r1, 0.8039 AS r2, 0.5948 AS r3, 1 AS st
  UNION ALL SELECT 46120293 AS guid, 696638 AS id, -8846.604 AS x, 1084.967 AS y, 95.211 AS z, 1.8675 AS o, 0 AS r0, 0 AS r1, 0.8039 AS r2, 0.5948 AS r3, 1 AS st
  UNION ALL SELECT 46120294 AS guid, 696639 AS id, -8845.202 AS x, 1079.964 AS y, 95.211 AS z, 5.0091 AS o, 0 AS r0, 0 AS r1, -0.5948 AS r2, 0.8039 AS r3, 1 AS st
  UNION ALL SELECT 46120295 AS guid, 696640 AS id, -8843.801 AS x, 1087.685 AS y, 95.211 AS z, 3.3859 AS o, 0 AS r0, 0 AS r1, -0.9925 AS r2, 0.1219 AS r3, 1 AS st
  UNION ALL SELECT 46120296 AS guid, 696641 AS id, -8848.549 AS x, 1069.372 AS y, 95.211 AS z, 3.4209 AS o, 0 AS r0, 0 AS r1, -0.9903 AS r2, 0.1392 AS r3, 1 AS st
  UNION ALL SELECT 46120297 AS guid, 696642 AS id, -8841.893 AS x, 1076.856 AS y, 95.211 AS z, 1.8675 AS o, 0 AS r0, 0 AS r1, 0.8039 AS r2, 0.5948 AS r3, 1 AS st
  UNION ALL SELECT 46120298 AS guid, 696643 AS id, -8841.138 AS x, 1078.935 AS y, 95.211 AS z, 3.3859 AS o, 0 AS r0, 0 AS r1, -0.9925 AS r2, 0.1219 AS r3, 1 AS st
  UNION ALL SELECT 46120299 AS guid, 696644 AS id, -8843.959 AS x, 1076.219 AS y, 95.211 AS z, 1.8675 AS o, 0 AS r0, 0 AS r1, 0.8039 AS r2, 0.5948 AS r3, 1 AS st
  UNION ALL SELECT 46120300 AS guid, 696645 AS id, -8854.577 AS x, 1078.039 AS y, 95.211 AS z, 0.2967 AS o, 0 AS r0, 0 AS r1, 0.1478 AS r2, 0.989 AS r3, 1 AS st
  UNION ALL SELECT 46120301 AS guid, 696646 AS id, -8853.952 AS x, 1082.023 AS y, 95.211 AS z, 4.9567 AS o, 0 AS r0, 0 AS r1, -0.6157 AS r2, 0.788 AS r3, 1 AS st
  UNION ALL SELECT 46120302 AS guid, 696647 AS id, -8851.156 AS x, 1078.869 AS y, 95.211 AS z, 3.4383 AS o, 0 AS r0, 0 AS r1, -0.989 AS r2, 0.1478 AS r3, 1 AS st
  UNION ALL SELECT 46120303 AS guid, 696648 AS id, -8859.381 AS x, 1074.266 AS y, 102.466 AS z, 0.2792 AS o, 0 AS r0, 0 AS r1, 0.1392 AS r2, 0.9903 AS r3, 1 AS st
  UNION ALL SELECT 46120304 AS guid, 696649 AS id, -8846.087 AS x, 1077.478 AS y, 95.211 AS z, 0.2618 AS o, 0 AS r0, 0 AS r1, 0.1305 AS r2, 0.9914 AS r3, 1 AS st
  UNION ALL SELECT 46120305 AS guid, 696650 AS id, -8852.635 AS x, 1076.63 AS y, 95.211 AS z, 0.9337 AS o, 0 AS r0, 0 AS r1, 0.4501 AS r2, 0.893 AS r3, 1 AS st
  UNION ALL SELECT 46120306 AS guid, 696651 AS id, -8882.691 AS x, 1084.032 AS y, 92.411 AS z, 2.6704 AS o, 0 AS r0, 0 AS r1, 0.9724 AS r2, 0.2334 AS r3, 1 AS st
  UNION ALL SELECT 46120307 AS guid, 696652 AS id, -8882.171 AS x, 1083.545 AS y, 92.411 AS z, 5.777 AS o, 0 AS r0, 0 AS r1, -0.2504 AS r2, 0.9681 AS r3, 1 AS st
) n WHERE EXISTS (SELECT 1 FROM `gameobject_template` t WHERE t.`entry` = n.id) AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`map` = 0 AND g.`id` = n.id
  AND g.`guid` NOT BETWEEN 46120200 AND 46120399 AND POW(g.`position_x` - n.x, 2) + POW(g.`position_y` - n.y, 2) + POW(g.`position_z` - n.z, 2) < 25);
