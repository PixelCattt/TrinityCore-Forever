-- Call of Fire 94467 (dwarf shaman, Braldir Ashmantle 257808 in Loch Modan): drinking the Fire Sapta at the shrine fails with
-- "no target". Discord 19 Nov (Blubu), after the Fire Tar fix of 2026_11_19_44.
--
-- Cause: the Fire Sapta casts Sapta Sight 8898. Its third effect (activate object, nearby object of an entry, 15 yd) may only
-- take the Shaman Shrine 101748 (conditions, source 13, effect mask 4). The only 101748 in our world is the old one in Durotar
-- (-253.3, -3976.9 on Kalimdor). The 8 Nov file 2026_11_08_60 gave the Loch Modan shrine a spell focus object (63674) but no
-- 101748, so the spell finds no target there and the cast is refused before the sapta works.
-- Fix: the Shaman Shrine 101748 at Braldir, 3 yd from him towards the peak, on his height (he stands on the ground there). The
-- condition row is the stock one; it is written again only if a world lacks it.
-- Safe to run again.
DELETE FROM `gameobject` WHERE `guid` = 21311083;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`,`ScriptName`,`VerifiedBuild`) VALUES
(21311083,101748,0,0,0,'0',0,0,0,-1,-5698.69,-2875.79,457.478,3.35,0,0,0.994576,-0.104015,900,100,1,'',0); -- Shaman Shrine (Loch Modan, Fire Sapta target)

INSERT IGNORE INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,4,8898,0,0,31,0,5,101748,0,0,0,0,'','Group 0: Spell ''Sapta Sight'' (Effect 2) targets object ''Shaman Shrine''');
