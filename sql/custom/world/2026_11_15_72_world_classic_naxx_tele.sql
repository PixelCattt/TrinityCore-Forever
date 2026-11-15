-- .tele naxx sent players to an empty snowy field (game_tele 1783, map 533 at 3598,-4523).
-- ".tele naxx" matched three names by substring (Naxxramas, NaxxramasOutside, NaxxramasForever)
-- and the pick among them is not fixed. An exact "Naxx" row always wins, so add one at the
-- 40-man entrance (world_safe_locs 1104055, the same spot the areatrigger uses) and move 1783 there too.
DELETE FROM `game_tele` WHERE `id`=2354 OR `name`='Naxx';
INSERT INTO `game_tele` (`id`,`position_x`,`position_y`,`position_z`,`orientation`,`map`,`name`) VALUES
(2354,3005.87,-3435.01,293.882,0,533,'Naxx');
UPDATE `game_tele` SET `map`=533,`position_x`=3005.87,`position_y`=-3435.01,`position_z`=293.882,`orientation`=0 WHERE `id`=1783;
