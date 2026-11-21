-- .deathrecap [name] (cs_misc.cpp): a GM prints the last recorded death of the selected or named player as text.
-- 1004 = Command: deathrecap (RBAC_PERM_COMMAND_DEATHRECAP), 197 = Role: Gamemaster Commands. Safe to run again.
INSERT IGNORE INTO `rbac_permissions` (`id`, `name`) VALUES (1004, 'Command: deathrecap');
INSERT IGNORE INTO `rbac_linked_permissions` (`id`, `linkedId`) VALUES (197, 1004);
