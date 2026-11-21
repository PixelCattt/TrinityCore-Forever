-- .gm combatlog [group|off] (cs_gm.cpp): a GM receives the combat log around a unit or its group from any distance.
-- 1003 = Command: gm combatlog (RBAC_PERM_COMMAND_GM_COMBATLOG), 196 = Role: Administrator Commands. Safe to run again.
INSERT IGNORE INTO `rbac_permissions` (`id`, `name`) VALUES (1003, 'Command: gm combatlog');
INSERT IGNORE INTO `rbac_linked_permissions` (`id`, `linkedId`) VALUES (196, 1003);
