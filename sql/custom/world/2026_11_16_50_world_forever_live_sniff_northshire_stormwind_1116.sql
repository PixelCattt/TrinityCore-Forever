-- WoW Forever live realm: English capture from 2026-11-16 (client 70938, about 25 minutes): Northshire, Goldshire, Elwynn and
-- Stormwind (trainers, vendors, quests, loot). Only what our data lacks or has wrong. Safe to run more than once. No new spawns.

-- 1. Hand-in texts live sends in full; ours stopped after the first paragraph (Northshire library quests).
UPDATE `quest_offer_reward` SET `RewardText` = 'Hey! How did you end up with that? It''s supposed to be on the shelf! Oh dear, the kobolds have been stealing my books again. They must want to eat them!$B$BThanks for bringing back the book, but what will I do about the rest of my missing collection?' WHERE `ID` = 91741;
UPDATE `quest_offer_reward` SET `RewardText` = 'Yah, I overheard. I warned Brother Paxton three times about the kobolds tunneling under the abbey.$B$BIt looks like the kobolds have taken a lot of books. There are whole bookshelves emptied out. You should probably see what Brother Paxton wants you to do about it.$B$BWhile you''re here, can I talk to you about tradeskills? I''d be happy to answer any questions you have, or point you toward the local trainers.' WHERE `ID` = 92124;

-- 2. NPC data live sends that differs from ours.
UPDATE `creature_template` SET `type` = 12 WHERE `entry` = 7389;   -- Senegal: companion pet live
UPDATE `creature_template` SET `faction` = 55 WHERE `entry` = 248415;   -- Tordrin Sternblade
UPDATE `creature_template` SET `faction` = 1078 WHERE `entry` = 251507;   -- Josephine Carson
UPDATE `creature_template` SET `faction` = 26 WHERE `entry` = 80;   -- Kobold Laborer
-- Models live: newer models for rabbits, kobolds and cows, other child models for the orphans, Field Marshal Stonebridge.
-- The new displays get their creature_model_info rows (size as live sends it), or the creature can't load its model and won't spawn.
DELETE FROM `creature_model_info` WHERE `DisplayID` IN (139886, 127669, 127670, 129645, 137874);
INSERT INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `DisplayID_Other_Gender`, `VerifiedBuild`) VALUES (139886, 0.235, 1, 0, 70938), (127669, 0.561, 1.0625, 0, 70938), (127670, 0.462, 0.875, 0, 70938), (129645, 0.561, 1.0625, 0, 70938), (137874, 0.893, 1.5, 0, 70938);
DELETE FROM `creature_template_model` WHERE `CreatureID` = 721;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES (721, 0, 139885, 1, 1, 70938), (721, 1, 139886, 1, 1, 70938);
DELETE FROM `creature_template_model` WHERE `CreatureID` = 257;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES (257, 0, 127669, 1, 1, 70938);
DELETE FROM `creature_template_model` WHERE `CreatureID` = 6;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES (6, 0, 127670, 1, 1, 70938);
DELETE FROM `creature_template_model` WHERE `CreatureID` = 80;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES (80, 0, 129645, 1, 1, 70938);
DELETE FROM `creature_template_model` WHERE `CreatureID` = 2442;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES (2442, 0, 137874, 1, 1, 70938);
DELETE FROM `creature_template_model` WHERE `CreatureID` = 14721;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES (14721, 0, 12923, 1, 100, 70938);
DELETE FROM `creature_template_model` WHERE `CreatureID` = 3507;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES (3507, 0, 252, 1, 1, 70938);
DELETE FROM `creature_template_model` WHERE `CreatureID` = 3508;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES (3508, 0, 251, 1, 1, 70938);
DELETE FROM `creature_template_model` WHERE `CreatureID` = 3512;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES (3512, 0, 251, 1, 1, 70938);
DELETE FROM `creature_template_model` WHERE `CreatureID` = 7559;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES (7559, 0, 328, 1, 1, 70938);
-- Defias Thug 38 keeps our models 5035/5036: the live ones (129962/129963) have no size we can back. Puts ours back where the
-- first version of this file was already run.
DELETE FROM `creature_template_model` WHERE `CreatureID` = 38 AND `CreatureDisplayID` IN (129962, 129963);
INSERT IGNORE INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES (38, 0, 5035, 1, 1, 0), (38, 1, 5036, 1, 1, 0);
-- Northshire Guard carries crossbow 12523 live (ours 2551), like the Stormwind guards in sniff 4.
DELETE FROM `creature_equip_template` WHERE `ID` = 1 AND `CreatureID` = 1642;
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `AppearanceModID1`, `ItemVisual1`, `ItemID2`, `AppearanceModID2`, `ItemVisual2`, `ItemID3`, `AppearanceModID3`, `ItemVisual3`, `VerifiedBuild`) VALUES (1642, 1, 1899, 0, 0, 143, 0, 0, 12523, 0, 0, 70938);

-- 3. Shop and street signs in Stormwind, Goldshire and Elwynn (type 5): live sets Data0 = 1 (the name floats over the sign).
UPDATE `gameobject_template` SET `Data0` = 1 WHERE `type` = 5 AND `entry` IN (696146, 696147, 696148, 696149, 696150, 696151, 696152, 696153, 696154, 696155, 696156, 696157, 696158, 696159, 696164, 696165, 696166, 696167, 696168, 696169, 696170, 696171, 696172, 696173, 696174, 696175, 696176, 696177, 696178, 696179, 696180, 696181, 696182, 696183, 696187, 696188, 696189, 696190, 696191, 696192, 696193, 696194, 696195, 696196, 696197, 696198, 696200, 696201, 696204, 696205, 696206, 696207, 696208, 696209, 696212, 696213, 696215, 696216, 696217, 696218, 696220, 696221, 696222, 696223, 696224, 696225, 696226, 696227, 696233, 696234, 696235, 696236, 696237, 696238, 696239, 696240, 696241, 696242, 696243, 696244, 696245, 696246, 696248, 696249, 696251, 696252, 696254, 696255, 696256, 696260, 696262, 696263, 696282, 696283, 696284, 696285, 696286, 696287, 696288, 696289, 696290, 696292, 696342, 696377, 696750, 696778, 696779, 696781, 696782, 696783, 696785, 696786, 696787, 696788, 696789, 696790, 696791);
-- Seven signs carry their neighbour's name in ours (the pairs are swapped); names as live sends them.
UPDATE `gameobject_template` SET `name` = 'Pestle''s Apothecary' WHERE `entry` = 696200;
UPDATE `gameobject_template` SET `name` = 'Weller''s Arsenal' WHERE `entry` = 696213;
UPDATE `gameobject_template` SET `name` = 'Duncan''s Textiles' WHERE `entry` = 696224;
UPDATE `gameobject_template` SET `name` = 'Stormwind Staves' WHERE `entry` = 696212;
UPDATE `gameobject_template` SET `name` = 'Alchemy Needs' WHERE `entry` = 696201;
UPDATE `gameobject_template` SET `name` = 'The FInest Thread' WHERE `entry` = 696223;
UPDATE `gameobject_template` SET `name` = 'Just Maces' WHERE `entry` = 696211;
