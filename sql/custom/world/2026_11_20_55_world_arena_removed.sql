-- The custom 2v2 / 3v3 arenas (Mak'gora Arena on map 2995, then the Ring of Law arena on map 3200) are no longer part of the
-- server. This takes their rows out of an install that already has them; on an install without them it changes nothing.
-- Their start points (world_safe_locs 1104110-1104113) were only used by these arenas.
DELETE FROM `battleground_scripts` WHERE `MapId` = 3200;
DELETE FROM `battleground_template` WHERE `ID` = 1169;
DELETE FROM `world_safe_locs` WHERE `ID` BETWEEN 1104110 AND 1104113;

-- "All Arenas" (6) goes back to the row of the 2026-10-24 release base, from before the arenas: no start points.
DELETE FROM `battleground_template` WHERE `ID` = 6;
INSERT INTO `battleground_template` (`ID`,`AllianceStartLoc`,`HordeStartLoc`,`StartMaxDist`,`Weight`,`ScriptName`,`Comment`) VALUES
(6,0,0,0,1,'','All Arena');
