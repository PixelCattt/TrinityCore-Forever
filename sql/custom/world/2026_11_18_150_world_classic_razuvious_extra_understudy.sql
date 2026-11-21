-- Naxxramas: a fifth Death Knight Understudy stood in Instructor Razuvious' room.
-- The classic script (classic_boss_razuvious.cpp, RespawnAdds) summons his four understudies itself. The AnoCore spawn restore
-- (2026_11_02_29) put back a creature row for one of them (guid 5331026, at the second summon's spot), since summons are not
-- spawns its 5 y check could see. That understudy is not his summon: it is not despawned on his reset, and it doubles the one
-- he summons there. naxx_razuvious r24h: "Death Knight Understudy x5" at the pull.
DELETE FROM `creature` WHERE `guid` = 5331026 AND `id` = 16803 AND `map` = 533;
DELETE FROM `creature_addon` WHERE `guid` = 5331026;
DELETE FROM `pool_members` WHERE `type` = 0 AND `spawnId` = 5331026;
