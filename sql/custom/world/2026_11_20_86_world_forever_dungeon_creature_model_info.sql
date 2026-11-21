-- Creatures of the new Forever dungeons that never spawned: a creature whose display has no creature_model_info row is not
-- created at all (Creature::InitEntry "has invalid model ... can't load"; 2026_10_27_17 and 2026_11_13_90 fixed the same for
-- the displays known then). Blackmaw Hold, 20 Nov (blackmaw_full af52): the bots cleared the trash round the spawn points of
-- Bonesnout the Unbroken (display 130427) and Impaan the Imprisoner (130432), and neither boss stood there; their creature
-- GUID counters were used and nothing was in the map. The Behemoth, Bloodmane, Varrox, the Unbound Spirit, Clawbert and Mopes
-- have no row either. The same holds for creatures in The Shaper's Terrace (19 displays), Alcaz Prison (10), The Drowned City,
-- Krol'dok Stronghold and some open-world spawns.
-- These are the displays of every spawned creature, and of every creature the Forever dungeon files add, that had no row
-- (test realm world DB with sql/custom applied, 2026-11-20). A creature with several displays fails only when the missing one
-- is picked, so those are in too.
-- Values, the same methods as 2026_10_27_17, checked against the 70938 client CreatureDisplayInfo / CreatureModelData:
-- - copied from the rows of other displays on the same client model, the most common value, scaled by CreatureModelScale;
-- - with no such row: INFERRED from CreatureModelData.CollisionWidth times the display scale (bounding radius 0.5727 x width,
--   combat reach 2.4545 x width, at least 0.5: the medians of the 11,750 rows we have);
-- - one display without model data: the player defaults 0.389 / 1.5.
-- Only displays without a row are added (INSERT IGNORE), so an existing row is never changed. Safe to run again.
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `DisplayID_Other_Gender`, `VerifiedBuild`) VALUES
(130427,0.35,1.5,0,0), /* Blackmaw Hold; creature 247198; collision width of model 16135 (INFERRED) */
(130432,0.35,1.5,0,0), /* Blackmaw Hold; creature 247206; collision width of model 16136 (INFERRED) */
(130436,0.35,1.5,0,0), /* Blackmaw Hold; creature 247207; collision width of model 16137 (INFERRED) */
(130440,0.35,1.5,0,0), /* Blackmaw Hold; creature 247209; collision width of model 16138 (INFERRED) */
(130447,0.35,1.5,0,0), /* Blackmaw Hold; creature 247234; collision width of model 16140 (INFERRED) */
(130499,0.35,1.5,0,0), /* Blackmaw Hold; creature 247412; other displays of model 16147 */
(130530,0.35,1.5,0,0), /* not spawned (a summon); creature 247432; other displays of model 16147 */
(131321,0.35,1.5,0,0), /* Blackmaw Hold; creature 247996; collision width of model 16138 (INFERRED) */
(131644,0.525,2.25,0,0), /* Blackmaw Hold; creature 247231; collision width of model 16245 (INFERRED) */
(132024,1.0,1.5,0,0), /* The Shaper's Terrace; creature 262164; other displays of model 951 */
(132032,0.584,2.25,0,0), /* The Shaper's Terrace; creature 261968; other displays of model 16312 */
(138242,0.372,1.5,0,0), /* Eastern Kingdoms; creature 254560; other displays of model 6838 */
(138246,0.389,1.5,0,0), /* The Shaper's Terrace; creature 262168; other displays of model 16312 */
(138447,0.227,0.972,0,0), /* not spawned (a summon); creature 254762; collision width of model 16741 (INFERRED) */
(138548,0.306,1.5,0,0), /* not spawned (a summon); creature 255303; other displays of model 6837 */
(138618,1.05,0.875,0,0), /* Eastern Kingdoms; creature 705; other displays of model 43 */
(138636,0.7,0.875,0,0), /* The Drowned City; creature 263055; other displays of model 132 */
(138722,0.306,1.5,0,0), /* Alcaz Prison; creature 255262; other displays of model 7661 */
(138839,0.306,1.5,0,0), /* Alcaz Prison; creature 255309; other displays of model 7661 */
(138843,0.208,1.5,0,0), /* Alcaz Prison; creature 255377, 271784; other displays of model 7599 */
(138844,0.306,1.5,0,0), /* Alcaz Prison; creature 255377, 271784; other displays of model 7661 */
(139053,0.208,1.5,0,0), /* not spawned (a summon); creature 255707; other displays of model 7599 */
(139548,0.306,1.5,0,0), /* Alcaz Prison; creature 256284; other displays of model 7661 */
(139811,0.372,1.5,0,0), /* Krol'dok Stronghold; creature 258102; other displays of model 6838 */
(139813,0.236,1.5,0,0), /* Krol'dok Stronghold; creature 258102; other displays of model 7200 */
(139814,0.236,1.5,0,0), /* Eastern Kingdoms; creature 254560; other displays of model 7200 */
(139817,0.372,1.5,0,0), /* Eastern Kingdoms, Krol'dok Stronghold; creature 256797, 258100; other displays of model 6838 */
(139818,0.236,1.5,0,0), /* Eastern Kingdoms, Krol'dok Stronghold; creature 256797, 258100; other displays of model 7200 */
(140001,0.236,1.5,0,0), /* Krol'dok Stronghold; creature 258042; other displays of model 7200 */
(140092,0.306,1.5,0,0), /* Alcaz Prison; creature 256236; other displays of model 7661 */
(140257,0.306,1.5,0,0), /* Eastern Kingdoms; creature 257558; other displays of model 7661 */
(140328,0.383,1.5,0,0), /* Eastern Kingdoms; creature 256797; other displays of model 7233 */
(140334,0.306,1.5,0,0), /* Eastern Kingdoms; creature 256797; other displays of model 7793 */
(140452,0.306,1.5,0,0), /* Eastern Kingdoms; creature 257901; other displays of model 7661 */
(140453,0.208,1.5,0,0), /* Eastern Kingdoms; creature 257901; other displays of model 7599 */
(140456,0.306,1.5,0,0), /* Eastern Kingdoms; creature 257910; other displays of model 7661 */
(140457,0.208,1.5,0,0), /* Eastern Kingdoms; creature 257910; other displays of model 7599 */
(140709,0.974,2.0,0,0), /* Blackmaw Hold; creature 258329; other displays of model 83 */
(141301,0.306,1.5,0,0), /* Eastern Kingdoms; creature 259051; other displays of model 7661 */
(142230,0.389,1.5,0,0), /* not spawned (a summon); creature 260150; no usable model data: player defaults */
(142322,1.0,1.0,0,0), /* not spawned (a summon); creature 260274; other displays of model 2151 */
(142414,0.372,1.5,0,0), /* Alcaz Prison; creature 260386; other displays of model 6838 */
(142827,0.26,1.65,0,0), /* Kalimdor; creature 260383; other displays of model 7200 */
(142989,0.875,3.75,0,0), /* The Shaper's Terrace; creature 253201; collision width of model 17246 (INFERRED) */
(142990,0.875,3.75,0,0), /* The Shaper's Terrace; creature 261750; collision width of model 17247 (INFERRED) */
(143035,0.63,2.7,0,0), /* The Shaper's Terrace; creature 261974; collision width of model 17251 (INFERRED) */
(143039,0.402,1.725,0,0), /* The Shaper's Terrace; creature 261811; collision width of model 17254 (INFERRED) */
(143040,0.35,1.5,0,0), /* The Shaper's Terrace; creature 253218; collision width of model 17254 (INFERRED) */
(143055,0.236,1.5,0,0), /* Krol'dok Stronghold; creature 262067; other displays of model 7200 */
(143056,0.236,1.5,0,0), /* Krol'dok Stronghold; creature 262067; other displays of model 7200 */
(143057,0.372,1.5,0,0), /* Krol'dok Stronghold; creature 262067; other displays of model 6838 */
(143058,0.372,1.5,0,0), /* Krol'dok Stronghold; creature 262067; other displays of model 6838 */
(143063,0.63,2.7,0,0), /* The Shaper's Terrace; creature 262081; collision width of model 17257 (INFERRED) */
(143122,0.63,2.7,0,0), /* The Shaper's Terrace; creature 262297; collision width of model 17268 (INFERRED) */
(143129,0.35,1.5,0,0), /* The Shaper's Terrace; creature 261993; collision width of model 17270 (INFERRED) */
(143142,0.372,1.5,0,0), /* Krol'dok Stronghold; creature 258104; other displays of model 6838 */
(143143,0.236,1.5,0,0), /* Krol'dok Stronghold; creature 258104; other displays of model 7200 */
(143169,0.306,1.5,0,0), /* Eastern Kingdoms; creature 262399; other displays of model 832 */
(143329,3.395,1.75,0,0), /* The Shaper's Terrace; creature 261784; other displays of model 191 */
(143565,0.389,1.5,0,0), /* The Drowned City; creature 263229; other displays of model 17004 */
(143832,1.5,1.5,0,0), /* The Shaper's Terrace; creature 261809; other displays of model 39 */
(143899,0.306,1.5,0,0), /* The Drowned City; creature 263899; other displays of model 7793 */
(143900,0.306,1.5,0,0), /* The Drowned City; creature 263899; other displays of model 7778 */
(143902,0.306,1.5,0,0), /* The Drowned City; creature 263899; other displays of model 7793 */
(143903,0.306,1.5,0,0), /* The Drowned City; creature 263899; other displays of model 7793 */
(143904,0.306,1.5,0,0), /* The Drowned City; creature 263899; other displays of model 7778 */
(143905,0.306,1.5,0,0), /* The Drowned City; creature 263899; other displays of model 7778 */
(144257,0.306,1.5,0,0), /* Alcaz Prison; creature 264770; other displays of model 7661 */
(144280,0.306,1.5,0,0), /* not spawned (a summon); creature 264845; other displays of model 7661 */
(144356,0.306,1.5,0,0), /* Alcaz Prison; creature 255271; other displays of model 7661 */
(144495,2.5,7.5,0,0), /* The Shaper's Terrace; creature 261749; other displays of model 454 */
(144497,2.5,7.5,0,0), /* The Shaper's Terrace; creature 261752; other displays of model 454 */
(144511,1.5,3.75,0,0), /* The Shaper's Terrace; creature 261813; other displays of model 1211 */
(144514,0.455,1.95,0,0), /* The Shaper's Terrace; creature 261812; collision width of model 18606 (INFERRED) */
(144515,0.525,2.25,0,0), /* The Shaper's Terrace; creature 262127; collision width of model 17260 (INFERRED) */
(144671,0.893,1.5,0,0), /* Krol'dok Stronghold; creature 259256; other displays of model 32 */
(145395,0.389,1.5,0,0), /* The Drowned City; creature 268300; other displays of model 17004 */
(145808,0.35,1.5,0,0), /* Blackmaw Hold; creature 269111; collision width of model 17869 (INFERRED) */
(146761,1.254,1.875,0,0), /* Blackmaw Hold; creature 248765; other displays of model 8 */
(147098,0.63,2.7,0,0), /* The Shaper's Terrace; creature 272561; collision width of model 18060 (INFERRED) */
(147966,0.347,1.5,0,0), /* Eastern Kingdoms; creature 274781; other displays of model 5408 */
(147968,0.347,1.5,0,0), /* Eastern Kingdoms; creature 274781; other displays of model 7203 */
(147971,0.347,1.5,0,0), /* Eastern Kingdoms; creature 274781; other displays of model 7203 */
(148705,0.208,1.5,0,0), /* Eastern Kingdoms; creature 256831; other displays of model 7599 */
(148903,0.974,2.0,0,0), /* not spawned (a summon); creature 249065; other displays of model 83 */
(148904,1.169,0.825,0,0), /* not spawned (a summon); creature 249064; other displays of model 30 */
(148905,1.5,1.25,0,0), /* not spawned (a summon); creature 249061; other displays of model 43 */
(148909,1.65,1.375,0,0), /* not spawned (a summon); creature 248216; other displays of model 43 */
(149885,1.5,3.0,0,0); /* Alcaz Prison; creature 255702; other displays of model 571 */
