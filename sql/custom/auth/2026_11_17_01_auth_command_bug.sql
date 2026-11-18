-- .bug <text> (cs_misc.cpp): every player may send a bug report that carries their spot, target and quest log.
-- 1001 = Command: bug (RBAC_PERM_COMMAND_BUG), 195 = Role: Player. Safe to run again.
INSERT IGNORE INTO `rbac_permissions` (`id`, `name`) VALUES (1001, 'Command: bug');
INSERT IGNORE INTO `rbac_linked_permissions` (`id`, `linkedId`) VALUES (195, 1001);
