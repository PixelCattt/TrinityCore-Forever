-- Event spawns inside dungeons and Zul'Gurub were set to difficulty 0 only. Those maps have no difficulty 0,
-- so the server drops each spawn at startup ("unsupported difficulty 0 for map") and the event never shows it.
-- Dungeons use difficulty 1 (normal), Zul'Gurub uses 148 like the rest of its spawns.

-- Zul'Gurub: Brazier of Madness (Edge of Madness boss summon, events 29-32)
UPDATE `gameobject` SET `spawnDifficulties`='148' WHERE `guid` IN (30021608,30021609,30021610,30028704) AND `map`=309 AND `spawnDifficulties`='0';

-- Midsummer: bonfires and flames in Blackrock Spire, Scholomance, Stratholme and Dire Maul (event 1)
UPDATE `gameobject` SET `spawnDifficulties`='1' WHERE `guid` IN (30037095,30037096,30037097,30037098,30037099,30037100,30037101,30037102) AND `spawnDifficulties`='0';

-- Lunar Festival: Elders Starsong, Wildmane, Stonefort, Morndeep, Farwhisper, Splitrock (event 7)
UPDATE `creature` SET `spawnDifficulties`='1' WHERE `guid` IN (20052409,20052410,20052411,20052412,20052413,20052414) AND `spawnDifficulties`='0';

-- Scourge Invasion: Sever, Lady Falther'ess, Revanchion, Lord Blackwood, Balzaphon (event 81)
UPDATE `creature` SET `spawnDifficulties`='1' WHERE `guid` IN (20002349,20002351,20002352,20002353,20002354) AND `spawnDifficulties`='0';
