-- WoW Forever quest order, races and givers from Questie's Forever data, picked on 14 Nov: only what our world lacked or had wrong.
-- From Questie (https://github.com/Questie/QuestieDB, Questie team, GPL-3.0), commit 4dbb8244 (corrections and play traces);
-- the Call of Fire starters are from the play traces in commit 90ab55bd. Changed: converted to our database tables.
-- Safe to run more than once.

-- 1. Facing Negolash (618): live needs The Captain's Cutlass done first, either version (615 or 8553; they share one exclusive group,
--    so one of them is enough).
UPDATE `quest_template_addon` SET `NextQuestID`=618 WHERE `ID` IN (615,8553) AND `NextQuestID`=0;

-- 2. Camping 101: Engineering (98285) is the Horde version (Questie: Horde races only). Same race list as the Horde
--    Camping 101: Enchanting (98284). Ours allowed every race.
UPDATE `quest_template` SET `AllowableRaces`=12261800583900083122 WHERE `ID`=98285 AND `AllowableRaces`=12884902143;

-- 3. Library book turn-ins with no giver in ours: both librarians give them, like the other book quests we have
--    (Owen Thadd 211022 in Undercity, Garion Wendell 211033 in Stormwind). Spotted through Everlake's 14 Nov world build.
--    78146 Goaz Scrolls, 78148 Runes of the Sorcerer-Kings, 78150 Friend of the Library, 79535 Basilisks: Should Petrification
--    be Feared?, 79536 Greater Friend of the Library, 81947 Sanguine Sorcery, 81952 Everyday Etiquette, 81953 Stonewrought Design.
DELETE FROM `creature_queststarter` WHERE `id` IN (211022,211033) AND `quest` IN (78146,78148,78150,79535,79536,81947,81952,81953);
INSERT INTO `creature_queststarter` (`id`,`quest`) VALUES
(211022,78146),(211022,78148),(211022,78150),(211022,79535),(211022,79536),(211022,81947),(211022,81952),(211022,81953),
(211033,78146),(211033,78148),(211033,78150),(211033,79535),(211033,79536),(211033,81947),(211033,81952),(211033,81953);

-- 4. Call of Fire (98517, added in 2026_11_14_96): the Horde shaman trainers send a level 10 Skyborne shaman back to Zephras.
--    Givers: Beram Skychaser (3032), Narm Skychaser (3066), Swart (3173), Kardris Dreamseeker (3344). Turn-in: Sessaria
--    Skystride (252382), and Aarnor Galestrike (254082), whom the quest text also names. It leads to Call of Fire (97243), so it
--    is not offered once 97243 is done or taken.
DELETE FROM `creature_queststarter` WHERE `quest`=98517;
DELETE FROM `creature_questender` WHERE `quest`=98517;
INSERT INTO `creature_queststarter` (`id`,`quest`)
SELECT `c`.`id`,98517 FROM (SELECT 3032 AS `id` UNION ALL SELECT 3066 UNION ALL SELECT 3173 UNION ALL SELECT 3344) `c`
WHERE EXISTS (SELECT 1 FROM `quest_template` WHERE `ID`=98517);
INSERT INTO `creature_questender` (`id`,`quest`)
SELECT `c`.`id`,98517 FROM (SELECT 252382 AS `id` UNION ALL SELECT 254082) `c`
WHERE EXISTS (SELECT 1 FROM `quest_template` WHERE `ID`=98517);
UPDATE `quest_template_addon` SET `BreadcrumbForQuestId`=97243 WHERE `ID`=98517 AND `BreadcrumbForQuestId`=0;
