-- Darnassus: no Guild Vault at the bank (Discord #bug-report "Missing guild bank/vault", 2026-11-14: "After creating a guild, I
-- went to the Darnassus bank, but the guild vault appears missing"). The sniffed vaults (2026_10_01_03) stand in Stormwind,
-- Undercity, Orgrimmar, Thunder Bluff and Ratchet; Darnassus had none. Fix pack idea from SIN (#team-members 2026-11-14), written
-- again here: one vault in the Bank of Darnassus, 2.5 yd in front of the banker Idriana, facing her.
-- INFERRED: the place (no sniff of a Darnassus vault) and the look: the Alliance vault of Stormwind (630865, scale 0.66). The
-- spot is taken from Idriana's own spawn, so it follows her. Safe to run again.
DELETE FROM `gameobject` WHERE `guid` = 838001000;
INSERT INTO `gameobject` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnDifficulties`,`phaseUseFlags`,`PhaseId`,`PhaseGroup`,`terrainSwapMap`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`,`ScriptName`,`StringId`,`VerifiedBuild`)
SELECT 838001000, 630865, 1, 0, 0, '0', 0, 0, 0, -1,
    c.`position_x` + 2.5 * COS(c.`orientation`), c.`position_y` + 2.5 * SIN(c.`orientation`), c.`position_z`,
    MOD(c.`orientation` + PI(), 2 * PI()), 0, 0, SIN(MOD(c.`orientation` + PI(), 2 * PI()) / 2), COS(MOD(c.`orientation` + PI(), 2 * PI()) / 2),
    120, 255, 1, '', NULL, 0
FROM `creature` c JOIN `creature_template` t ON t.`entry` = c.`id`
WHERE t.`name` = 'Idriana' AND c.`map` = 1 AND c.`position_x` > 9000
  AND EXISTS (SELECT 1 FROM `gameobject_template` WHERE `entry` = 630865)
ORDER BY c.`guid` LIMIT 1;
