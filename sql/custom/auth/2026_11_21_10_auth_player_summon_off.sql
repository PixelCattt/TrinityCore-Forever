-- Players lose Command: summon (528). auth 2026_10_08_00 linked it to Role: Player (195) so players could bring their own
-- characters that are in the world as bots, but the command let them summon any player and move offline characters.
-- Players bring their bots with the bot commands. GMs keep .summon through their own roles.
-- After running it on a live server: .reload rbac (or a restart) makes it take effect.
DELETE FROM `rbac_linked_permissions` WHERE `id` = 195 AND `linkedId` = 528;
