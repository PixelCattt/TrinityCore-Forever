-- Mountaineer Ylva (269153, Loch Modan, quest Banner of the Fallen 86585) stood up; VoldemarGreed "bugs 6" (2026-11-17): she should
-- lie on the ground. The quest text says so: "The fallen mountaineer ... was killed outright by a trogg". She now lies dead
-- (stand state 7) and still gives the quest, as other fallen quest givers do (Fallen Earthen Warrior 26335, Tyrith 24822).
-- Not done: the trampled banner beside her. No sniff or data source has that object, so it waits for a sniff of the spot.
-- Safe to run again.
DELETE FROM `creature_template_addon` WHERE `entry` = 269153;
INSERT INTO `creature_template_addon` (`entry`,`PathId`,`mount`,`MountCreatureID`,`StandState`,`AnimTier`,`VisFlags`,`SheathState`,`PvPFlags`,`emote`,
  `aiAnimKit`,`movementAnimKit`,`meleeAnimKit`,`visibilityDistanceType`,`auras`) VALUES
(269153,0,0,0,7,0,0,0,0,0,0,0,0,0,'');
