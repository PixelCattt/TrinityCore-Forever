-- SIN's fix (1amcoff1n), Quest and World Fixes for 0.1.36, file 2026_11_14_01 renamed. Taken out (held or not taken):
-- the Banner of the Fallen quest rows, the 273/1699 -1 objective delete, the Snowbound map pin and focus move, Gar'im's move,
-- and the Ylva banner script names and Headsplitter delete.
-- Forever Bots 0.1.36 local_quest_and_spawn_repairs. Client build 70938.
START TRANSACTION;

-- These are two different items with the same localized name. Core loot
-- eligibility hides the starter while active/rewarded and the quest loot
-- until needed. Independent chance rolls used to leave eligible uses empty.
UPDATE gameobject_loot_template SET Chance=100
WHERE Entry=665282 AND ItemType=0 AND GroupId=0 AND
 ((Item=278049 AND QuestRequired=0 AND Chance=30) OR
  (Item=278398 AND QuestRequired=1 AND Chance=70));

-- Keep turn-in blobs. Add the missing objective blobs using the existing
-- objective IDs. The trigger coordinates come from local AreaTrigger.db2.
INSERT INTO quest_poi (QuestID,BlobIndex,Idx1,ObjectiveIndex,QuestObjectiveID,QuestObjectID,MapID,UiMapID,Flags)
VALUES (273,0,0,0,9000273,2057,0,1432,1),
       (455,0,2,2,385480,175,0,1437,1),
       (1699,0,0,0,385494,482,0,1433,1)
ON DUPLICATE KEY UPDATE QuestID=VALUES(QuestID);
INSERT INTO quest_poi_points (QuestID,Idx1,Idx2,X,Y,Z) VALUES
 (273,0,0,-5763,-3433,306),(455,2,0,-4086,-2611,46),
 (1699,0,0,-8933,-1986,140)
ON DUPLICATE KEY UPDATE QuestID=VALUES(QuestID);

-- Both posters had the terrain elevation beneath the building. Mount them
-- beside the existing wanted notice on the same wall, at its height/facing.
UPDATE gameobject p JOIN gameobject ref ON ref.guid=30042496 AND ref.id=60 AND ref.map=0
SET p.position_x=ref.position_x,p.position_y=ref.position_y+
    CASE p.guid WHEN 64905100 THEN -1.3 ELSE 1.3 END,
    p.position_z=ref.position_z,p.orientation=ref.orientation,
    p.rotation0=ref.rotation0,p.rotation1=ref.rotation1,
    p.rotation2=ref.rotation2,p.rotation3=ref.rotation3
WHERE p.guid IN(64905100,64905101) AND p.id=649051 AND p.map=0
  AND ABS(p.position_z-63.934)<0.01;
-- Explicit area objectives already gate completion. The legacy flag also
-- sends QuestUpdateComplete on entrance, even with kills still outstanding.
UPDATE quest_template SET Flags=Flags & ~4 WHERE (ID=455 AND Flags=12) OR (ID=1699 AND Flags=5);

COMMIT;
