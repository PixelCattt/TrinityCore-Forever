-- Night Web's Hollow (Tirisfal Glades): every Webbed Forsaken (271961) frees a Forsaken Adventurer (271968) when the web is
-- destroyed (its SAI: on death, summon 271968; the adventurer's own SAI starts "on summoned": a line, then it wanders off).
-- The sniffs of 4 Oct and 27 Oct saved the adventurers that the sniffing player had freed as fixed spawns, 10 of them on the
-- exact spot of a web and one 3 yd beside one. So a Forsaken stood inside the web (its model shows through) and a destroyed web
-- left two of them (cyborgx5, GitHub #12, 17 Nov: "can see model through web and when i destroy web there is 2 undead").
-- 271968 only ever comes from a web, so all 11 spawns go.
DELETE FROM `creature_addon` WHERE `guid` IN (21200427,21200428,21200429,21200430,21200431,21200432,43000417,43000418,43000419,43000420,43000421);
DELETE FROM `creature` WHERE `id`=271968 AND `guid` IN (21200427,21200428,21200429,21200430,21200431,21200432,43000417,43000418,43000419,43000420,43000421);
