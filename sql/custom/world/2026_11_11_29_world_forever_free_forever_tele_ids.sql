-- .tele ids 2342-2399 are kept for the Forever dungeon teleports. The dungeon files insert theirs with fixed ids but delete
-- the old rows by name only (2026_11_11_30 Drowned City 2350-2351, 2026_11_11_33 Krol'dok 2352-2353, 2026_11_19_70 Blackmaw
-- Hold 2356-2357, 2026_11_19_72 Shaper's Terrace 2358-2359), so a server whose own teleports (.tele add) already use one of
-- those ids stopped starting there with "Duplicate entry '2356' for key 'game_tele.PRIMARY'".
-- This file sorts before all of them, so the updater runs it first, also on a server stuck on one of them: any teleport
-- in 2342-2399 that is not one of ours moves to a free id above every other teleport. Teleports are used by name, so
-- .tele keeps working for them. Nothing to do on a fresh install. Safe to run again.
SET @next_tele_id := (SELECT GREATEST(COALESCE(MAX(`id`), 0), 2399) FROM `game_tele`);
UPDATE `game_tele` SET `id` = (@next_tele_id := @next_tele_id + 1)
WHERE `id` BETWEEN 2342 AND 2399
  AND `name` NOT IN ('DrownedCity','DrownedCityEntrance','KroldokStronghold','KroldokStrongholdEntrance','Naxx',
                     'BlackmawHold','BlackmawHoldEntrance','ShapersTerrace','ShapersTerraceEntrance','AlcazPrison','AlcazPrisonEntrance')
ORDER BY `id`;
