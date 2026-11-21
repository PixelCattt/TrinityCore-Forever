-- WoW Forever: live captures of 20 Nov 09:52, 15:40 and 16:47 (client 70959, Russian client; Barrens, Ashenvale, Wailing Caverns,
-- Darkshore, Elwynn and Stormwind, Redridge, Stranglethorn). Only what the world DB lacked. Safe to run again.

-- 1. Lakeshire Guard 10037: live has four standing at the north end of Lakeshire; we spawn none.
DELETE FROM `creature` WHERE `guid` BETWEEN 46130000 AND 46130003;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`,
  `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `ScriptName`, `VerifiedBuild`) VALUES
(46130000, 10037, 0, 44, 1002, '0', 0, 0, 0, -1, 0, 1, -9615.92, -1844.8, 54.4017, 1.0821, 120, 0, 0, 100, 0, '', 70959),
(46130001, 10037, 0, 44, 1002, '0', 0, 0, 0, -1, 0, 1, -9666.71, -1890.47, 55.3461, 3.543, 120, 0, 0, 100, 0, '', 70959),
(46130002, 10037, 0, 44, 1002, '0', 0, 0, 0, -1, 0, 1, -9671.12, -1902.88, 55.6562, 2.0769, 120, 0, 0, 100, 0, '', 70959),
(46130003, 10037, 0, 44, 1002, '0', 0, 0, 0, -1, 0, 1, -9590.35, -1927.36, 63.1421, 2.0595, 120, 0, 0, 100, 0, '', 70959);

-- 2. Thurman Mullby 1285 (Stormwind general goods) also sells Mining Pick 2901, Skinning Knife 7005 and Star Wood 11291 on live.
DELETE FROM `npc_vendor` WHERE `entry`=1285 AND `item` IN (2901,7005,11291) AND `type`=1;
INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `type`, `BonusListIDs`, `PlayerConditionID`, `IgnoreFiltering`, `VerifiedBuild`) VALUES
(1285, 7, 7005, 0, 0, 0, 1, NULL, 0, 0, 70959),
(1285, 8, 2901, 0, 0, 0, 1, NULL, 0, 0, 70959),
(1285, 24, 11291, 0, 0, 0, 1, NULL, 0, 0, 70959);

-- 3. Greetings for three new Stormwind NPCs that had no gossip menu (the texts are in the hotfixes file of this kit, or already ours):
--    High Sorcerer Andromath 5694 menu 45049 (text 326954), Daniel Stitchsong 256734 menu 42592 (text 309855, with his vendor option),
--    Marcy Baker 256390 menu 32970 (text 250597).
DELETE FROM `npc_text` WHERE `ID` BETWEEN 690000 AND 690002;
INSERT INTO `npc_text` (`ID`, `Probability0`, `BroadcastTextID0`, `VerifiedBuild`) VALUES
(690000, 1, 326954, 70959),
(690001, 1, 309855, 70959),
(690002, 1, 250597, 70959);
DELETE FROM `gossip_menu` WHERE `MenuID` IN (45049,42592,32970);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`, `VerifiedBuild`) VALUES
(45049, 690000, 70959),
(42592, 690001, 70959),
(32970, 690002, 70959);
DELETE FROM `gossip_menu_option` WHERE `MenuID`=42592;
INSERT INTO `gossip_menu_option` (`MenuID`, `GossipOptionID`, `OptionID`, `OptionNpc`, `OptionText`, `OptionBroadcastTextID`, `Language`, `Flags`, `ActionMenuID`, `ActionPoiID`, `GossipNpcOptionID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `SpellID`, `OverrideIconID`, `VerifiedBuild`) VALUES
(42592, 138814, 0, 1, 'I would like to buy from you.', 2583, 0, 0, 0, 0, NULL, 0, 0, '', 0, NULL, NULL, 70959);
DELETE FROM `creature_template_gossip` WHERE `CreatureID` IN (5694,256734,256390);
INSERT INTO `creature_template_gossip` (`CreatureID`, `MenuID`, `VerifiedBuild`) VALUES
(5694, 45049, 70959),
(256734, 42592, 70959),
(256390, 32970, 70959);

-- 4. Russian turn-in texts we lacked (the English ones are ours already).
DELETE FROM `quest_offer_reward_locale` WHERE `locale`='ruRU' AND `ID` IN (78124,78146,79097,91899,91904,97914,98247);
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(78124, 'ruRU', 'Спасибо, $n. Благодаря тебе архивы наших знаний растут.$B$BЕсли найдешь другие чародейские труды, которых не хватает в библиотеке, приноси их мне.', 70959),
(78146, 'ruRU', 'Спасибо, $n. Благодаря тебе архивы наших знаний растут.$B$BЕсли найдешь другие чародейские труды, которых не хватает в библиотеке, приноси их мне.', 70959),
(79097, 'ruRU', 'Спасибо, $n. Благодаря тебе архивы наших знаний растут.$B$BЕсли найдешь другие чародейские труды, которых не хватает в библиотеке, приноси их мне.', 70959),
(91899, 'ruRU', 'Благодарю за усердие, $n. В последнее время на торговых путях хозяйничают воры и разбойники. Если найдешь еще ящики, неси их сюда – а об остальном мы позаботимся.$B$BВот твоя плата.', 70959),
(91904, 'ruRU', 'Благодарю за усердие, $n. В последнее время на торговых путях хозяйничают воры и разбойники. Если найдешь еще ящики, неси их сюда – а об остальном мы позаботимся.$B$BВот твоя плата.', 70959),
(97914, 'ruRU', '<Барос открывает письмо и начинает читать. Улыбка постепенно сходит с его лица.>', 70959),
(98247, 'ruRU', 'Ты $gпришел:пришла; именно туда, куда надо. Я с радостью запишу тебя в перечень наших подрядчиков. Никаких контрактов подписывать не надо, да и особых обязанностей у тебя не будет. Мы лишь просим, чтобы ты $gдоставлял:доставляла; по адресу или $возвращал:возвращала; нам принадлежащие управлению грузы, которые попадутся тебе в странствиях.$B$BЗа каждую такую доставку ты получишь торговые обязательства. С их помощью ты сможешь платить нам за товары и услуги. Кстати, вот тебе сразу кое-что для начала.$B$BТеперь скажи, у тебя есть ящик, на который была наклеена эта этикетка?', 70959);
DELETE FROM `quest_request_items_locale` WHERE `locale`='ruRU' AND `ID` IN (78124,78146,79097,91899,91904,97914,98247);
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(78124, 'ruRU', '$gПринес:Принесла; что-то новенькое в нашу коллекцию?', 70959),
(78146, 'ruRU', '$gПринес:Принесла; что-то новенькое в нашу коллекцию?', 70959),
(79097, 'ruRU', '$gПринес:Принесла; что-то новенькое в нашу коллекцию?', 70959),
(91899, 'ruRU', 'А, новый груз! Чудесно. Поставь его у той кучи, и давай обсудим твою оплату.', 70959),
(91904, 'ruRU', 'А, новый груз! Чудесно. Поставь его у той кучи, и давай обсудим твою оплату.', 70959),
(97914, 'ruRU', 'По запаху чую, что ты с моря!$B$B<Барос смеется.>$B$BЧто привело тебя в Штормград?', 70959),
(98247, 'ruRU', 'О, приветствую! Чем могу помочь?', 70959);

-- 5. Quest-giver emotes live plays when offering Chol'aruk the Ravener 97005 (274) and Making Do 97926 (1143).
DELETE FROM `quest_details` WHERE `ID` IN (97005,97926);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES
(97005, 274, 0, 0, 0, 0, 0, 0, 0, 70959),
(97926, 1143, 0, 0, 0, 0, 0, 0, 0, 70959);

-- 6. Weapons live shows on twelve Forever NPCs we spawn bare-handed: equipment template 1, and their spawns switched to it.
DELETE FROM `creature_equip_template` WHERE `ID`=1 AND `CreatureID` IN (227853,248242,248248,256389,256390,256391,260873,267307,267308,267314,274931,274944);
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `AppearanceModID1`, `ItemVisual1`, `ItemID2`, `AppearanceModID2`, `ItemVisual2`, `ItemID3`, `AppearanceModID3`, `ItemVisual3`, `VerifiedBuild`) VALUES
(227853, 1, 12856, 0, 0, 0, 0, 0, 0, 0, 0, 70959),
(248242, 1, 2177, 0, 0, 0, 0, 0, 0, 0, 0, 70959),
(248248, 1, 2177, 0, 0, 0, 0, 0, 0, 0, 0, 70959),
(256389, 1, 0, 0, 0, 12743, 0, 0, 0, 0, 0, 70959),
(256390, 1, 0, 0, 0, 12743, 0, 0, 0, 0, 0, 70959),
(256391, 1, 0, 0, 0, 12743, 0, 0, 0, 0, 0, 70959),
(260873, 1, 2028, 0, 0, 0, 0, 0, 0, 0, 0, 70959),
(267307, 1, 18203, 0, 0, 18202, 0, 0, 0, 0, 0, 70959),
(267308, 1, 20003, 0, 0, 20005, 0, 0, 0, 0, 0, 70959),
(267314, 1, 10611, 0, 0, 10611, 0, 0, 0, 0, 0, 70959),
(274931, 1, 12944, 0, 0, 11041, 0, 0, 0, 0, 0, 70959),
(274944, 1, 274429, 0, 0, 0, 0, 0, 0, 0, 0, 70959);
UPDATE `creature` SET `equipment_id`=1 WHERE `equipment_id`=0 AND `id` IN (227853,248242,248248,256389,256390,256391,260873,267307,267308,267314,274931,274944);
