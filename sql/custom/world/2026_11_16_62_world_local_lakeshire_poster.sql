-- SIN's fix (1amcoff1n), Quest and World Fixes for 0.1.36, file 2026_11_14_04 renamed.
-- local_lakeshire_poster: mount the doorway poster on the opposite jamb.
-- Viewed from outside looking north, left is toward increasing world Y.
UPDATE gameobject p JOIN gameobject ref ON ref.guid=30042496 AND ref.id=60 AND ref.map=0
SET p.position_y=ref.position_y+7.2
WHERE p.guid=64905101 AND p.id=649051 AND p.map=0
  AND ABS(p.position_x-ref.position_x)<0.01
  AND ABS(p.position_z-ref.position_z)<0.01
  AND ABS(p.position_y-ref.position_y-1.3)<0.01;
