-- SIN's fix (1amcoff1n), Darnassus Guild Vault for 0.1.37 (apply.sql). Runs after 2026_11_15_59 (live Darnassus vaults):
-- it adds his vault only when no guild vault stands in the Darnassus bank.
START TRANSACTION;
-- A failed CHECK aborts the batch before COMMIT. No permanent helper tables.
CREATE TEMPORARY TABLE patch_preflight (ok INT NOT NULL CHECK (ok = 1));
INSERT INTO patch_preflight SELECT COUNT(*) FROM gameobject_template WHERE entry = 630865 AND type = 34;
INSERT INTO patch_preflight SELECT COUNT(*) = 0 FROM gameobject WHERE guid = 919934155
  AND NOT (id = 630865 AND map = 1 AND ABS(position_x - 9937.8) < 0.01
           AND ABS(position_y - 2517.0) < 0.01 AND ABS(position_z - 1317.18) < 0.01);
INSERT INTO gameobject
  (guid,id,map,spawnDifficulties,position_x,position_y,position_z,orientation,rotation2,rotation3,spawntimesecs,animprogress,state)
SELECT 919934155,630865,1,'0',9937.8,2517,1317.18,4.38,SIN(4.38/2),COS(4.38/2),120,255,1
WHERE NOT EXISTS (
  SELECT 1 FROM gameobject g JOIN gameobject_template t ON t.entry=g.id
  WHERE t.type=34 AND g.map=1 AND g.position_x BETWEEN 9920 AND 9960
    AND g.position_y BETWEEN 2500 AND 2535 AND ABS(g.position_z-1317.18)<4
);
DROP TEMPORARY TABLE patch_preflight;
COMMIT;
