-- WoW Forever: rogue trainers teach Poised (1328825) at level 18 and Shank rank 1 (1329283) at level 24.
-- Both came with the live push of client 1.60.1.70840, after the official trainer sniffs our rogue trainer list 26 was made
-- from (2026_10_15_00, up to 70374), so list 26 never had them:
--   Poised: no rogue had it, so 2026_11_19_36 (its buff) and the Combat talent Composure (which adds to its -10 energy) did nothing.
--     The druid's Poised (1328829) went on the druid trainer in 2026_11_19_82; the rogue's was missed.
--   Shank: 2026_11_19_82 added Shank rank 2 (1329549) at 44, which needs rank 1, so no rogue could learn either rank.
-- The client 1.60.1.70938 has both as trainer spells for rogues (SkillLineAbility 59888: skill 39, 59899: skill 38; class mask 8,
-- not learned on skill learn) and SpellLevels BaseLevel 18 (Poised) and 24 (Shank).
-- Cost: the price live's rogue trainer list has for every other spell of that level: 2900 copper at 18 (8676, 1777),
-- 5000 at 24 (2836, 5763, 6762).
-- Safe to run again.

INSERT IGNORE INTO `trainer_spell` (`TrainerId`, `SpellId`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqAbility1`, `ReqAbility2`, `ReqAbility3`, `ReqLevel`, `VerifiedBuild`) VALUES
(26, 1328825, 2900, 0, 0, 0, 0, 0, 18, 0), -- Poised
(26, 1329283, 5000, 0, 0, 0, 0, 0, 24, 0); -- Shank rank 1
