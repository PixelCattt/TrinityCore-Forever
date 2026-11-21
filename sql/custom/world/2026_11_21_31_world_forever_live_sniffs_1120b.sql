-- WoW Forever: live captures of 20 Nov 21:07 and 22:13 (client 71037; Loch Modan, Dun Morogh, Ironforge, Deeprun Tram).
-- Only what the world DB lacked or had different from live. The texts are in the hotfixes file of this kit. Safe to run again.

-- 1. Thelsamar Mountaineer 8055: live has five guarding Thelsamar; we spawn none. Equipment template 1 is ours already.
DELETE FROM `creature` WHERE `guid` BETWEEN 46130010 AND 46130014;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`,
  `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `ScriptName`, `VerifiedBuild`) VALUES
(46130010, 8055, 0, 38, 2101, '0', 0, 0, 0, -1, 0, 1, -5389.08, -2961, 315.968, 4.23121, 120, 0, 0, 100, 0, '', 71037),
(46130011, 8055, 0, 38, 2101, '0', 0, 0, 0, -1, 0, 1, -5375.87, -2984.3, 326.482, 2.83556, 120, 0, 0, 100, 0, '', 71037),
(46130012, 8055, 0, 38, 2101, '0', 0, 0, 0, -1, 0, 1, -5309.88, -2987.97, 340.613, 3.35105, 120, 0, 0, 100, 0, '', 71037),
(46130013, 8055, 0, 38, 2101, '0', 0, 0, 0, -1, 0, 1, -5381.11, -2907.89, 337.33, 2.92904, 120, 10, 0, 100, 1, '', 71037),
(46130014, 8055, 0, 38, 144, '0', 0, 0, 0, -1, 0, 1, -5324.02, -2923.82, 342.573, 4.01637, 120, 0, 0, 100, 0, '', 71037);

-- 2. Greetings and menus live shows on three Loch Modan NPCs:
--    Morhan Coppertongue 167 menu 44137 (text 10044798, ours already), Khara Deepwater 1684 menu 43913 (text 318923),
--    Norric Lochthane 258043 menu 41909 (text 307408; he had no menu at all).
DELETE FROM `npc_text` WHERE `ID` IN (690003,690004);
INSERT INTO `npc_text` (`ID`, `Probability0`, `BroadcastTextID0`, `VerifiedBuild`) VALUES
(690003, 1, 318923, 71037),
(690004, 1, 307408, 71037);
DELETE FROM `gossip_menu` WHERE `MenuID` IN (44137,43913,41909);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`, `VerifiedBuild`) VALUES
(44137, 10044798, 71037),
(43913, 690003, 71037),
(41909, 690004, 71037);
DELETE FROM `gossip_menu_option` WHERE `MenuID` IN (44137,43913);
INSERT INTO `gossip_menu_option` (`MenuID`, `GossipOptionID`, `OptionID`, `OptionNpc`, `OptionText`, `OptionBroadcastTextID`, `Language`, `Flags`, `ActionMenuID`, `ActionPoiID`, `GossipNpcOptionID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `SpellID`, `OverrideIconID`, `VerifiedBuild`) VALUES
(44137, 141441, 0, 1, 'I would like to see your wares.', 0, 0, 0, 0, 0, NULL, 0, 0, '', 0, NULL, NULL, 71037),
(43913, 140935, 0, 1, 'I\'d like to see your wares.', 0, 0, 0, 0, 0, NULL, 0, 0, '', 0, NULL, NULL, 71037);
DELETE FROM `creature_template_gossip` WHERE `CreatureID` IN (167,1684,258043);
INSERT INTO `creature_template_gossip` (`CreatureID`, `MenuID`, `VerifiedBuild`) VALUES
(167, 44137, 71037),
(1684, 43913, 71037),
(258043, 41909, 71037);

-- 3. Norric Lochthane 258043 holds a weapon on live; we spawn him bare-handed. Grenhild Darktalon 49808 has no off-hand on live.
DELETE FROM `creature_equip_template` WHERE `ID`=1 AND `CreatureID`=258043;
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `AppearanceModID1`, `ItemVisual1`, `ItemID2`, `AppearanceModID2`, `ItemVisual2`, `ItemID3`, `AppearanceModID3`, `ItemVisual3`, `VerifiedBuild`) VALUES
(258043, 1, 20654, 0, 0, 0, 0, 0, 0, 0, 0, 71037);
UPDATE `creature` SET `equipment_id`=1 WHERE `equipment_id`=0 AND `id`=258043;
UPDATE `creature_equip_template` SET `ItemID2`=0, `AppearanceModID2`=0, `ItemVisual2`=0 WHERE `CreatureID`=49808 AND `ID`=1;

-- 4. Quest texts and emotes as live sends them.
--    Me Brother, Nipsy 6662: offer emotes. Silver of the Waves 86614 and Snowbound 86667: turn-in emotes; Snowbound's turn-in text.
DELETE FROM `quest_details` WHERE `ID`=6662;
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES
(6662, 1, 1, 5, 0, 0, 0, 0, 0, 71037);
UPDATE `quest_offer_reward` SET `Emote1`=1, `EmoteDelay1`=1000, `VerifiedBuild`=71037 WHERE `ID` IN (86614,86667);
UPDATE `quest_offer_reward` SET `RewardText`='This jar is for me?$B$BSnow! Grenhild did it! She sent the snow that I asked for!$B$BA pity, though, I was hoping she would come and visit in person.$B$BWell, regardless, thank you for your effort. This is a real help for my work.' WHERE `ID`=86667;
UPDATE `quest_request_items` SET `EmoteOnComplete`=1, `VerifiedBuild`=71037 WHERE `ID` IN (86614,86667);
