-- SIN's change (1amcoff1n), Respawn All OpenWorld for 0.1.35, part 02-open-world/apply.sql. Off unless Respawn.DynamicMode = 1
-- (worldserver.conf, default 0): this file only puts the spawns in spawn group 901036 (dynamic rate flag). Runs after _66.
-- Run on the matching 0.1.35 world database with the server stopped.
START TRANSACTION;
INSERT INTO spawn_group_template(groupId,groupName,groupFlags) VALUES (901036,'Forever 0.1.35 - normal outdoor combat expansion',9);
INSERT INTO spawn_group(groupId,spawnType,spawnId)
SELECT 901036,0,c.guid FROM creature c JOIN creature_template t ON t.entry=c.id
WHERE c.map IN (0,1,2991) AND c.spawntimesecs>0 AND t.Classification=0
AND t.type IN (1,2,3,4,5,6,7,9)
AND (t.faction IN (14,16,17,18,19,20,21,22,24,26,27,28,30,37,38,39,40,41,44,45,46,47,48,49,50,51,54,59,60,61,62,63,66,67,70,72,73,74,78,81,82,87,89,90,91,92,93,95,100,103,107,109,110,111,112,114,119,127,128,129,130,131,132,133,134,148,152,154,168,230,233,270,310,312,370,410,411,413,414,415,450,470,472,494,514,554,574,575,636,654,655,736,754,778,795,834,934,954,974,1081,1114,1234,1235,1236,1294,1374,1375,1394,1395,1434,1605,1614,1617,1620,1626,1630,1878,3267,3389,3422,3427,3443,3444,3461,3463,3472,3473,3493,3497,3499,3535,3542,3545,3547,3549,3551,3561,3567,3570,3578,3579,3592,3596,3597,3619,3621,3654,3665,3668,3670,3674) OR (t.type=1 AND t.faction IN (7,58,77,99,189,190,416,430,594,634,914,1094,1095,1194,3565)))
AND t.RacialLeader=0 AND t.VehicleId=0 AND COALESCE(c.npcflag,t.npcflag)=0
AND (COALESCE(c.unit_flags,t.unit_flags) & 0x02030182)=0 AND (t.flags_extra & 0x80)=0
AND NOT EXISTS (SELECT 1 FROM creature_template_difficulty d WHERE d.Entry=c.id AND (d.StaticFlags1 & 0x220)<>0)
AND NOT EXISTS (SELECT 1 FROM creature_queststarter q WHERE q.id=c.id)
AND NOT EXISTS (SELECT 1 FROM creature_questender q WHERE q.id=c.id)
AND NOT EXISTS (SELECT 1 FROM game_event_creature e WHERE e.guid=c.guid)
AND NOT EXISTS (SELECT 1 FROM pool_members p WHERE p.type=0 AND p.spawnId=c.guid)
AND NOT EXISTS (SELECT 1 FROM spawn_group s WHERE s.spawnType=0 AND s.spawnId=c.guid);
COMMIT;
