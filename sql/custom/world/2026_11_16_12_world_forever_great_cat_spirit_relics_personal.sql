-- The Great Cat Spirit (98342 / 98396 / 98404, Moonglade Barrow Dens): "some required quest relics do not drop consistently"
-- (Discord, 6_1_8_8_1 "Bugs" 2.3, 2026-11-14). The three relic templates were made by us (no sniff) as old shared chests: the
-- first player, or bot, to open one took it away from everybody for 5 minutes, and the Relic of the Claw has only one spawn.
-- Quest chests of the current client hand their item out as personal loot instead (852 of the 1074 newer chest templates we
-- have from sniffs: data1 0, data2 1, data30 = the loot id), so each player opens their own relic and it only hides for them.
-- Same loot rows (gameobject_loot_template keyed by the entry). Safe to run again.
UPDATE `gameobject_template` SET `Data1` = 0, `Data2` = 1, `Data3` = 0, `Data30` = `entry`
WHERE `entry` IN (672821,673093,673094) AND `type` = 3;
