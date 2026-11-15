-- WoW Forever: Zephras Isle boss 256617 is "Duke Anvillaxx" on the live realm (client 1.60.1.70938 creature cache of 11-15 and the
-- 11-15 live combat log). Ours still had the older name "Baron Anvillaxx". The ruRU name (Герцог Ковалакс) already says Duke.
-- Safe to run again.

UPDATE `creature_template` SET `name`='Duke Anvillaxx' WHERE `entry`=256617;
