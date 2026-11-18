-- WoW Forever: paladin class trainer levels as live's trainers show them (Shari Stilwell, trainer 29, seen 2026-11-15).
--   Seal of Fury rank 3 (20163): level 26 (ours 25), between rank 2 at 18 and rank 4 at 34.
--   Holy Shield rank 2 (20927): level 40 (ours 50); rank 3 (20928): level 50 (ours 60). Live adds rank 4 (1239570) at 60;
--   that spell is not in client 70938's spell data (live sends only its name and text as a hotfix), so it is not added here.
-- Data from Efficient Games (https://efficient.games), licensed under CC BY 4.0
-- (https://creativecommons.org/licenses/by/4.0/). Source: github.com/JIVESCORP/eg-link-output-wowf 6ff5612, build 1.60.1.70938.
-- Changed: only these three levels were picked and converted to our trainer_spell rows.
-- Safe to run again.

UPDATE `trainer_spell` SET `ReqLevel` = 26 WHERE `TrainerId` = 29 AND `SpellId` = 20163; -- Seal of Fury rank 3, was 25
UPDATE `trainer_spell` SET `ReqLevel` = 40 WHERE `TrainerId` = 29 AND `SpellId` = 20927; -- Holy Shield rank 2, was 50
UPDATE `trainer_spell` SET `ReqLevel` = 50 WHERE `TrainerId` = 29 AND `SpellId` = 20928; -- Holy Shield rank 3, was 60
