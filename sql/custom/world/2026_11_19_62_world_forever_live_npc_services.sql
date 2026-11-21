-- WoW Forever: three NPCs that do less here than on the live realm.
-- Data from Efficient Games (https://efficient.games), licensed under CC BY 4.0
-- (https://creativecommons.org/licenses/by/4.0/). Source: github.com/JIVESCORP/eg-link-output-wowf, npcs.json and trainers.json of
-- builds 1.60.1.70790-70959, compared with the dev world DB on 2026-11-18. Changed: picked and converted to our rows.
-- Safe to run again.

-- 1. Cook Torka (3191, Razor Hill) trains cooking on live (70790/70840: "Train me.", the cooking list of Aska Mistrunner and
--    Duhng). Ours had her menu 5854 (its "Train me." option is live's 96866) but only the quest giver flag and no trainer, so the
--    option never showed. She gets the flags and the trainer of the other cooking trainers on that menu (Aska 3026, Duhng 8306:
--    npcflag 83, trainer 36 on menu 5854 option 0).
UPDATE `creature_template` SET `npcflag` = `npcflag` | 1 | 16 | 64 WHERE `entry` = 3191;
DELETE FROM `creature_trainer` WHERE `CreatureID` = 3191;
INSERT INTO `creature_trainer` (`CreatureID`,`TrainerID`,`MenuID`,`OptionID`) VALUES (3191, 36, 5854, 0);

-- 2. Boyle (4612, Undercity) sells on live (menu option 141115 "Show me what you have for sale."). Ours had that menu (43973)
--    and his goods, but npcflag 0, so a click did nothing.
UPDATE `creature_template` SET `npcflag` = `npcflag` | 1 | 128 WHERE `entry` = 4612;

-- 3. Nazgrel (3230, Orgrimmar) offers Regthar Deathgate (1361) on live too, besides our two starters.
DELETE FROM `creature_queststarter` WHERE `id` = 3230 AND `quest` = 1361;
INSERT INTO `creature_queststarter` (`id`,`quest`,`VerifiedBuild`) VALUES (3230, 1361, 70862);
