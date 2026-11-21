-- Classic 1.60: the hotfix mounts 3901-3918 (2026_11_06_70) had no MountXDisplay, so the mount journal showed no model, and in the world
-- the mount took the model of its aura's creature. That is right for all of them but Riding Gryphon (mount 3915, spell 3363): its aura
-- creature is 15135, the Chromatic Drake. Each mount gets the display of its own creature (creature_template_model), the gryphon the
-- display of Riding Gryphon 541. All displays are in the client's CreatureDisplayInfo. Reported by wowiczek (Karrz1/TrinityCore issue 353),
-- who also found the displays; 3917/3918 (the Trainee's mounts) had the same gap. Safe to run again.
DELETE FROM `mount_x_display` WHERE `ID` BETWEEN 9902 AND 9919 OR (`MountID` BETWEEN 3901 AND 3918 AND `ID` NOT IN (9900,9901));
INSERT INTO `mount_x_display` (`ID`,`CreatureDisplayInfoID`,`PlayerConditionID`,`Unknown1100`,`MountID`,`VerifiedBuild`) VALUES
(9902,2408,0,0,3901,70938), -- Palomino Stallion: Palomino 306
(9903,2787,0,0,3902,70938), -- Blue Ram: Frost Ram 4778
(9904,9991,0,0,3903,70938), -- Panther: Black Nightsaber 7322
(9905,4805,0,0,3904,70938), -- Leopard: Leopard 7684
(9906,6447,0,0,3905,70938), -- Spotted Panther: Spotted Nightsaber 7689
(9907,6468,0,0,3906,70938), -- Obsidian Raptor: Obsidian Raptor 7703
(9908,4805,0,0,3907,70938), -- Primal Leopard: Primal Leopard 10336
(9909,6442,0,0,3908,70938), -- Tawny Sabercat: Tawny Sabercat 10337
(9910,9714,0,0,3909,70938), -- Golden Sabercat: Golden Sabercat 10338
(9911,10662,0,0,3910,70938), -- Purple Mechanostrider: Purple Mechanostrider 11148
(9912,10664,0,0,3911,70938), -- Red & Blue Mechanostrider: Red and Blue Mechanostrider 11149
(9913,9475,0,0,3912,70938), -- Fluorescent Green Mechanostrider: Fluorescent Green Mechanostrider 10178
(9914,14329,0,0,3913,70938), -- Swift Dawnsaber: Swift Dawnsaber 14557
(9915,15293,0,0,3914,70938), -- Chromatic Mount: Chromatic Drake Mount 15135
(9916,6852,0,0,3915,70938), -- Riding Gryphon: Riding Gryphon 541, NOT its aura creature 15135 (Chromatic Drake)
(9917,10718,0,0,3916,70938), -- Skeletal Steed: Deathcharger 11195
(9918,9991,0,0,3917,70938), -- Trainee's Sentinel Nightsaber: Riding Nightsaber 12361
(9919,2326,0,0,3918,70938); -- Trainee's Outrider Wolf: Red Riding Wolf 5197

DELETE FROM `hotfix_data` WHERE `Id` BETWEEN 985100 AND 985117 OR (`TableHash` = 2030087241 AND `RecordId` BETWEEN 9902 AND 9919);
INSERT INTO `hotfix_data` (`Id`,`UniqueId`,`TableHash`,`RecordId`,`Status`,`VerifiedBuild`) VALUES
(985100,1281450100,2030087241,9902,1,70938),
(985101,1281450101,2030087241,9903,1,70938),
(985102,1281450102,2030087241,9904,1,70938),
(985103,1281450103,2030087241,9905,1,70938),
(985104,1281450104,2030087241,9906,1,70938),
(985105,1281450105,2030087241,9907,1,70938),
(985106,1281450106,2030087241,9908,1,70938),
(985107,1281450107,2030087241,9909,1,70938),
(985108,1281450108,2030087241,9910,1,70938),
(985109,1281450109,2030087241,9911,1,70938),
(985110,1281450110,2030087241,9912,1,70938),
(985111,1281450111,2030087241,9913,1,70938),
(985112,1281450112,2030087241,9914,1,70938),
(985113,1281450113,2030087241,9915,1,70938),
(985114,1281450114,2030087241,9916,1,70938),
(985115,1281450115,2030087241,9917,1,70938),
(985116,1281450116,2030087241,9918,1,70938),
(985117,1281450117,2030087241,9919,1,70938);
