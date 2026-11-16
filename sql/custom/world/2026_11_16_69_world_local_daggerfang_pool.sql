-- SIN's fix (1amcoff1n), Quest and World Fixes for 0.1.36, file 2026_11_14_03 renamed.
-- Twisting the Knife: one named quest target, with alternative shore positions.
START TRANSACTION;
INSERT INTO pool_template (entry, max_limit, description)
SELECT 270693, 1, 'Loch Modan - Daggerfang'
WHERE NOT EXISTS (SELECT 1 FROM pool_template WHERE entry=270693
  AND max_limit=1 AND description='Loch Modan - Daggerfang');

INSERT INTO pool_members (type, spawnId, poolSpawnId, chance, description)
SELECT 0, c.guid, 270693, 0, 'Loch Modan - Daggerfang'
FROM creature c
WHERE c.id=270693 AND c.map=0
  AND NOT EXISTS (SELECT 1 FROM pool_members p WHERE p.type=0
    AND p.spawnId=c.guid AND p.poolSpawnId=270693 AND p.chance=0);
COMMIT;
