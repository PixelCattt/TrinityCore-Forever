-- Rethban Caverns (1699): SIN's fix (Quest and World Fixes for 0.1.36, his 2026_11_14_01, chris 2026-11-16: put it in as he
-- wrote it): the extra catch-all exploration objective goes; 1699 already has trigger 482. (273's row was already removed by
-- our 2026_11_13_37.) His statement, unchanged:
-- 273 already advances from Huldar's proximity credit. There is no trigger
-- relation for the extra exploration flag. 1699 already has trigger 482.
DELETE FROM quest_objectives WHERE Type=10 AND ObjectID=-1 AND
 ((QuestID=273 AND ID=90002730) OR (QuestID=1699 AND ID=90016990));
