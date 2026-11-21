-- .battletag [name] (cs_battlenet_account.cpp): every player may show or pick their account's BattleTag; the number is drawn.
-- 1002 = Command: battletag (RBAC_PERM_COMMAND_BATTLETAG), 195 = Role: Player. Safe to run again.
INSERT IGNORE INTO `rbac_permissions` (`id`, `name`) VALUES (1002, 'Command: battletag');
INSERT IGNORE INTO `rbac_linked_permissions` (`id`, `linkedId`) VALUES (195, 1002);
