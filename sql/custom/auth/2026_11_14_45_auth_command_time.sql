-- .time / .time day / .time night / .time auto (cs_misc.cpp): every player may keep their own sky.
-- 1000 = Command: time (RBAC_PERM_COMMAND_TIME), 195 = Role: Player. Safe to run again.
INSERT IGNORE INTO `rbac_permissions` (`id`, `name`) VALUES (1000, 'Command: time');
INSERT IGNORE INTO `rbac_linked_permissions` (`id`, `linkedId`) VALUES (195, 1000);
