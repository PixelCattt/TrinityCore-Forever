-- Two Tordrin Sternblades in Northshire (Discord, sage_22186, 2026-11-14, 0.1.36). 2026_11_13_52 spawned Tordrin Sternblade
-- (248415), Josephine Carson (251507), Isaac Chan (258930) and Sam Sarsaparilla (263399) as 46100000-46100003, but the sniff
-- spawns of all four (21200082, 21200132, 21200188, 21200312 in 2026_10_03_00) are in the shipped world DB too, within half a
-- yard of them. The sniffed ones stay (live orientation and height); each of ours goes only while a spawn of the same creature
-- stands within 5 yards of it, so a world DB without the sniff spawns keeps ours. Safe to run again.
DELETE `ours` FROM `creature` `ours`
JOIN `creature` `other` ON `other`.`id` = `ours`.`id` AND `other`.`guid` <> `ours`.`guid` AND `other`.`map` = `ours`.`map`
    AND ABS(`other`.`position_x` - `ours`.`position_x`) < 5 AND ABS(`other`.`position_y` - `ours`.`position_y`) < 5
WHERE `ours`.`guid` BETWEEN 46100000 AND 46100003 AND `ours`.`id` IN (248415, 251507, 258930, 263399);
