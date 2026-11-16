-- Rows from our own files that SIN's fixes replace (2026_11_13_36, 2026_11_13_40, 2026_11_14_50/51/52, 2026_11_15_50/51).
-- Those files shipped in 0.1.37, so every 0.1.37 world database has these rows and SIN's 2026_11_16_60..73 would
-- fail on them (duplicate pool_members key at 2026_11_16_69). His clean-up statements, as he wrote them. Safe on a fresh install.
DELETE FROM gameobject WHERE guid=838000800 AND id=8380008;
DELETE FROM gameobject_template WHERE entry=8380008;
UPDATE quest_poi_points SET X=-9817,Y=-3361 WHERE QuestID=95999 AND Idx1=1 AND Idx2=0 AND X=-9721 AND Y=-3189;
DELETE FROM quest_poi_points WHERE QuestID=86667 AND Idx1=1;
DELETE FROM quest_poi WHERE QuestID=86667 AND Idx1=1;
DELETE FROM pool_members WHERE type=0 AND poolSpawnId=2706930;
DELETE FROM pool_template WHERE entry=2706930;
