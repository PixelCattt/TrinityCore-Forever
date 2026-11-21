-- Open-world creatures that never spawned, the same fault as 2026_11_20_86: their displays have no creature_model_info row, so
-- Creature::InitEntry refuses them ("has invalid model ... can't load"). The dev realm world DB still had 155 spawns of these 12
-- displays after _86 (Eastern Kingdoms and Kalimdor; none in a dungeon), 2026-11-20.
-- Values: copied from the rows of other displays on the same client model (70938 CreatureDisplayInfo.ModelID), the most common
-- value, scaled by CreatureModelScale (the method of 2026_10_27_17). INSERT IGNORE: an existing row is never changed. Safe to
-- run again.
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `DisplayID_Other_Gender`, `VerifiedBuild`) VALUES
(138616,0.346,0.63,0,0), /* map 0, 56 spawns; other displays of model 66 */
(144326,0.134,1.0,0,0), /* map 0, 5 spawns; other displays of model 80 */
(144327,0.134,1.0,0,0), /* map 0, 5 spawns; other displays of model 80 */
(144328,0.166,1.0,0,0), /* map 0, 5 spawns; other displays of model 79 */
(144329,0.166,1.0,0,0), /* map 0, 5 spawns; other displays of model 79 */
(144942,0.306,1.5,0,0), /* map 0, 3 spawns; other displays of model 7661 */
(144943,0.306,1.5,0,0), /* map 0, 3 spawns; other displays of model 7661 */
(144944,0.208,1.5,0,0), /* map 0, 3 spawns; other displays of model 7599 */
(144953,0.208,1.5,0,0), /* map 0, 1 spawn; other displays of model 7599 */
(147839,0.306,1.5,0,0), /* map 1, 23 spawns; other displays of model 7300 */
(147840,0.306,1.5,0,0), /* map 1, 23 spawns; other displays of model 7300 */
(147841,0.306,1.5,0,0); /* map 1, 23 spawns; other displays of model 7300 */
