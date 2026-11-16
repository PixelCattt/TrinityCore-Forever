-- SIN's fixes (1amcoff1n), Quest and World Fixes for 0.1.36, the rest of his file 2026_11_14_01 (put in on Karrz's word,
-- 2026-11-16): the Snowbound map pin and Ceramic Jar focus move, Gar'im in the cave, and the Ylva banner script names with the
-- Headsplitter delete. His statements as he wrote them.
START TRANSACTION;

-- Snowbound: the objective blob for the Ceramic Jar focus (from his quest_poi insert).
INSERT INTO quest_poi (QuestID,BlobIndex,Idx1,ObjectiveIndex,QuestObjectiveID,QuestObjectID,MapID,UiMapID,Flags)
VALUES (86667,0,1,0,9400397,279379,0,1432,0)
ON DUPLICATE KEY UPDATE QuestID=VALUES(QuestID);
INSERT INTO quest_poi_points (QuestID,Idx1,Idx2,X,Y,Z) VALUES
 (86667,1,0,-5648,-2534,375)
ON DUPLICATE KEY UPDATE QuestID=VALUES(QuestID);

-- The focus was over 300 yards from the snow. Use the snow patch at the
-- tunnel and the walkable height from the installed map.
UPDATE gameobject SET position_x=-5648.28,position_y=-2534.38,position_z=374.9
WHERE guid=838000700 AND id=8380007 AND map=0 AND ABS(position_y+2206)<0.1;

-- Place Gar'im at the recorded cave waypoint and keep his quest pin in sync.
UPDATE creature SET position_x=-9824.70,position_y=-3261.40,position_z=60.5
WHERE guid=21451900 AND id=214519 AND map=0 AND ABS(position_x+9721.46)<0.1;
UPDATE quest_poi_points SET X=-9825,Y=-3261,Z=61
WHERE QuestID=95999 AND Idx1=1 AND Idx2=0 AND X=-9817 AND Y=-3361;


UPDATE creature_template SET ScriptName='classic_npc_ylva_banner'
WHERE entry=269153 AND ScriptName='';
INSERT INTO spell_script_names (spell_id,ScriptName) VALUES
 (1303317,'classic_spell_ironforge_banner') ON DUPLICATE KEY UPDATE spell_id=1303317;
-- Headsplitter now belongs to the banner encounter.
DELETE FROM creature WHERE id=269185 AND map=0 AND guid IN (26918500,26918501);
COMMIT;
