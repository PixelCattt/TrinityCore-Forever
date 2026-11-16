-- SIN's fix (1amcoff1n), Quest and World Fixes for 0.1.36, file 2026_11_14_02 renamed.
-- local_banner_focus_and_grunt: native spell 1303317 requires focus 2311.
START TRANSACTION;
INSERT INTO gameobject_template (entry,type,displayId,name,Data0,Data1)
VALUES (8380091,8,299,'Ironforge banner site (spell focus)',2311,15)
ON DUPLICATE KEY UPDATE entry=8380091;
INSERT INTO gameobject (guid,id,map,spawnDifficulties,position_x,position_y,position_z,orientation,rotation3,state)
SELECT 838009100,8380091,map,spawnDifficulties,position_x,position_y,position_z,0,1,1
FROM creature WHERE id=269153 AND map=0
ON DUPLICATE KEY UPDATE guid=838009100;

-- Only this stationary Blackrock Grunt had no reachable polygon at its home.
UPDATE creature SET position_x=-9706.812,position_y=-3167.993,position_z=59.415
WHERE guid=20006742 AND id=440 AND map=0 AND ABS(position_x+9711.56)<0.01
  AND ABS(position_y+3165.54)<0.01;
COMMIT;
