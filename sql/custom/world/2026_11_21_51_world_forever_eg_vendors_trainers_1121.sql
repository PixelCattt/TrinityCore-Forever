-- Forever vendors and trainers: what live sells and teaches that we lack. Data from Efficient Games (https://efficient.games),
-- licensed under CC BY 4.0 (https://creativecommons.org/licenses/by/4.0/). Source: github.com/JIVESCORP/eg-link-output-wowf
-- vendors.json and trainers.json, builds 1.60.1.70205 to 70959 (players' vendor and trainer windows). Changed: compared with our
-- world (6,125 vendor items and 8,095 trainer spells already match) and only what we lacked is written as our rows.
--   Cook Torka (3191, Orgrimmar): has the cooking trainer menu (5854, "Train me.") but no trainer flag and no trainer list, so
--     nothing happens. Live trains the same list as our cooking trainer 36 (Aska Mistrunner and Duhng use it with this menu).
--   Nyalah Brightfire (257006): flour, spices, wood, Flint and Tinder, Thick Logs and the two sagefish recipes.
--   Gor'mak (248197, Crossroads): Plans: Cracked / Mithril / Arcanite Blacksmith Hammer for 30 / 60 / 90 Merchant's Favor
--     (his own Favor costs 11844 / 11846 / 11847, with the same reputation tiers as his other 60 and 90 Favor plans).
--   Alynsia (256732): Formula: Enchant Boots - Speed for 180 Merchant's Favor (cost 11842, as her other 180 Favor formula).
--   Railee Thriceforged (257422): Serrated Knife, limited to 1 (restock time 2 hours, a guess: live shows only the limit).
-- Not here: Gelvas Grimegate's Darkmoon ticket prizes (no ticket cost rows yet); the class spells live trainers list that the
-- client cannot use (Ghost Wolf 1238640, Holy Shield 1239570, Poised 1328829, Slam 1310197/1310198: no spellbook data).
-- Everything only where missing. Safe to run more than once.

UPDATE `creature_template` SET `npcflag` = `npcflag` | 81 WHERE `entry` = 3191 AND (`npcflag` & 81) <> 81
  AND EXISTS (SELECT 1 FROM `trainer` WHERE `Id` = 36);
INSERT INTO `creature_trainer` (`CreatureID`,`TrainerID`,`MenuID`,`OptionID`)
SELECT 3191,36,5854,0 FROM DUAL WHERE EXISTS (SELECT 1 FROM `trainer` WHERE `Id` = 36)
  AND NOT EXISTS (SELECT 1 FROM `creature_trainer` WHERE `CreatureID` = 3191);

DROP TEMPORARY TABLE IF EXISTS `forever_vendor_1121`;
CREATE TEMPORARY TABLE `forever_vendor_1121` (`entry` INT UNSIGNED NOT NULL, `n` SMALLINT NOT NULL, `item` INT NOT NULL, `maxcount` INT UNSIGNED NOT NULL,
  `incrtime` INT UNSIGNED NOT NULL, `ExtendedCost` INT UNSIGNED NOT NULL, `PlayerConditionID` INT UNSIGNED NOT NULL, PRIMARY KEY (`entry`,`item`));
INSERT INTO `forever_vendor_1121` (`entry`,`n`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`PlayerConditionID`) VALUES
(257006,1,10284,0,0,0,0),     -- Simple Flour
(257006,2,11291,0,0,0,0),     -- Star Wood
(257006,3,21099,0,0,0,0),     -- Recipe: Smoked Sagefish
(257006,4,21219,0,0,0,0),     -- Recipe: Sagefish Delight
(257006,5,2692,0,0,0,0),      -- Hot Spices
(257006,6,272941,0,0,0,0),    -- Thick Logs
(257006,7,3713,0,0,0,0),      -- Soothing Spices
(257006,8,4470,0,0,0,0),      -- Simple Wood
(257006,9,4471,0,0,0,0),      -- Flint and Tinder
(248197,1,285289,0,0,11844,0),      -- Plans: Cracked Blacksmith Hammer, 30 Favor
(248197,2,285290,0,0,11846,163380), -- Plans: Mithril Blacksmith Hammer, 60 Favor
(248197,3,285291,0,0,11847,163433), -- Plans: Arcanite Blacksmith Hammer, 90 Favor
(256732,1,289560,0,0,11842,0),      -- Formula: Enchant Boots - Speed, 180 Favor
(257422,1,287063,1,7200,0,0);       -- Serrated Knife, limited
INSERT INTO `npc_vendor` (`entry`,`slot`,`item`,`maxcount`,`incrtime`,`ExtendedCost`,`type`,`BonusListIDs`,`PlayerConditionID`,`IgnoreFiltering`,`VerifiedBuild`)
SELECT `s`.`entry`, `m`.`top` + `s`.`n`, `s`.`item`, `s`.`maxcount`, `s`.`incrtime`, `s`.`ExtendedCost`, 1, NULL, `s`.`PlayerConditionID`, 0, 0
FROM `forever_vendor_1121` `s`
JOIN (SELECT `entry`, MAX(`slot`) AS `top` FROM `npc_vendor` WHERE `entry` IN (257006,248197,256732,257422) GROUP BY `entry`) `m` ON `m`.`entry` = `s`.`entry`
JOIN `creature_template` `c` ON `c`.`entry` = `s`.`entry`
WHERE NOT EXISTS (SELECT 1 FROM `npc_vendor` `v` WHERE `v`.`entry` = `s`.`entry` AND `v`.`item` = `s`.`item` AND `v`.`type` = 1);
DROP TEMPORARY TABLE IF EXISTS `forever_vendor_1121`;
