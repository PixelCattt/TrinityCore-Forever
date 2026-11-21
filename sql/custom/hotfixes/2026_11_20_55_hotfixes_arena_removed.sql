-- The custom 2v2 / 3v3 arenas (Mak'gora Arena on map 2995, then the Ring of Law arena on map 3200) are no longer part of the
-- server. This takes their rows out of an install that already has them; on an install without them it changes nothing.
-- Map 2995 (Hyjal Crater) and the BattlemasterListXMap row 1208 (Mak'gora Arena on map 2995) are the client's own records:
-- with the server rows gone the server reads them from the client files again, as the client always did.
DELETE FROM `map` WHERE `ID` IN (2995,3200);
DELETE FROM `battlemaster_list_x_map` WHERE `ID` IN (1208,1500);
DELETE FROM `pvp_difficulty` WHERE `ID` BETWEEN 1900 AND 1905;
DELETE FROM `pvp_difficulty` WHERE `ID` BETWEEN 32000 AND 32005;

-- BattlemasterList 6 "All Arenas" goes back to the row of the 2026-10-24 release base, from before the arenas (the
-- TrinityCore hotfix row, build 69497). Its locale rows were never changed.
DELETE FROM `battlemaster_list` WHERE `ID` = 6;
INSERT INTO `battlemaster_list` (`ID`,`Name`,`GameType`,`ShortDescription`,`LongDescription`,`InstanceType`,`PvpType`,`MinLevel`,`MaxLevel`,
  `RatedPlayers`,`MinPlayers`,`MaxPlayers`,`GroupsAllowed`,`MaxGroupSize`,`HolidayWorldState`,`Flags`,`IconFileDataID`,`RequiredPlayerConditionID`,`VerifiedBuild`) VALUES
(6,'All Arenas','','','',4,1,20,90,5,0,5,1,3,0,8,525915,0,69497);

-- Map 3200 was sent to every client (hotfix 3200001). It is now sent as removed, so a client that cached it drops it.
DELETE FROM `hotfix_data` WHERE `Id` IN (3200001,3200002);
INSERT INTO `hotfix_data` (`Id`,`UniqueId`,`TableHash`,`RecordId`,`Status`,`VerifiedBuild`) VALUES
(3200002,1611200001,3179597154,3200,2,0);
