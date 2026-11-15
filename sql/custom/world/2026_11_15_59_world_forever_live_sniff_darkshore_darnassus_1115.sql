-- WoW Forever live realm: two Russian captures from 2026-11-15 (client 70938, 14:55 and 15:47, about 6.5 hours): Darkshore,
-- Auberdine, Teldrassil, Darnassus and the north of Ashenvale. Only what our data lacks or has wrong. Safe to run more than once.
-- New spawn guids: creature 46120000-46120099, gameobject 46120000-46120099 (both reserved to 46120199).

-- 1. Russian quest texts.
--    a) Three texts still had a player's name typed in (Астерикс, Маладат). Live sends $n there.
UPDATE `quest_offer_reward_locale` SET `RewardText` = REPLACE(`RewardText`, 'Астерикс', '$n') WHERE `locale` = 'ruRU' AND `ID` = 951;
UPDATE `quest_offer_reward_locale` SET `RewardText` = REPLACE(`RewardText`, 'Маладат', '$n') WHERE `locale` = 'ruRU' AND `ID` IN (667, 990);
--    b) Hand-in and progress texts as live sends them: ours lacked them, or had an older wording or no $g he/she forms.
DELETE FROM `quest_offer_reward_locale` WHERE `locale` = 'ruRU' AND `ID` IN (729, 967, 1007, 1141, 2098, 2139, 5321, 87760, 98013, 98042);
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(729, 'ruRU', 'Это ты, Холли? Мне нужна помощь, надо подолбить этот камень. Передай-ка мне мою щетку для камня – мне кажется, я тут что-то вижу.$B$BОй, да ты не Холли! Вряд ли ты $Gвидел:видела; мою щетку для камня...$B$BА, забудь об этом! Я обещал Лиге, что отошлю им ту таинственную окаменелость, что я нашел. Куда же делась Холли?$B$BТак много нужно сделать! И где ж эта таинственная окаменелость... и моя щетка... и Холли...$B$BИ ты кто будешь... правда, это неважно, если ты хочешь помочь.$B$BДай знать, когда сможешь начать поиски.', 70938),
(967, 'ruRU', 'Если позволите, я вам скажу: слишком уж вы хорошо экипированы для $Gпростого посланца:простой посланницы;, не так ли? Предполагаю, Балтул хотел быть уверенным, что его письмо действительно попадет мне в руки. Посмотрим, что он там пишет...$B$BДа, это тревожные новости. Когда обнаруживаются силы демонов или нежити, я помогаю часовым уничтожить их.$B$BВначале мне были непривычны манеры ночных эльфов, но постепенно я стал в высшей степени уважать их как союзников.', 70938),
(1007, 'ruRU', 'Ты ее $Gнашел:нашла;! Спасибо тебе, $n!$B$BДревний город Зорам хранит неисчислимые тайны, и эта статуэтка может послужить ключом ко многим из них.', 70938),
(1141, 'ruRU', 'Какие отличные окуни, $n! Большое спасибо за помощь!$B$BТы как минимум $Gтакой же хороший рыбак:такая же хорошая рыбачка;, как моя драгоценная родственница Граун Блумп. У нее, правда, растет борода и от нее несет чем-то странным, но это для нее не причина перестать рыбачить. Думаю, ты обладаешь необходимыми качествами, чтобы пользоваться удочкой семьи Блумп.', 70938),
(2098, 'ruRU', 'Ах ты ж, акула собачья! Тебе удалось все найти! Скоро мой первый помощник будет в полном порядке, и эти звери не знают, что их тогда ждет!$B$BА кстати, ты не $gвидел:видела; моего первого помощника?', 70938),
(2139, 'ruRU', 'Ты с честью и мужеством $gсражался:сражалась; на благо Аубердина, $n. В наших измученных войной землях смерть и отчаяние стали нормой. Многие из нас не готовы принять испытания в новом доме, их выбор – скрываться в своих жилищах либо бежать в более укрепленные и безопасные земли Альянса.\n\nСпасибо тебе, $n. Может быть, вскоре мы с тобой будем плечом к плечу биться против другого врага.', 70938),
(5321, 'ruRU', 'О, я так рада, что Керлониан в безопасности. И я уверена, что найду его спящим где-нибудь поблизости... рано или поздно.$B$BСпасибо тебе за то, что $gпоказал:показала; ему дорогу, $n.', 70938),
(87760, 'ruRU', 'Мы прошли долгий путь, $n, но он того стоил.\n\nТы наконец-то $gзахватил:захватила; жезл, позволявший нагам контролировать морских существ. Я прослежу за тем, чтобы его уничтожили, после чего крепкозубы и морские черепахи снова смогут жить спокойно.\n\nСпасибо тебе еще раз от меня лично. Твоя настойчивость принесла достойные плоды.', 70938),
(98013, 'ruRU', 'Не сомневайся, дитя. Те, кто грабит свой собственный дом по велению темного владыки...\n\nНе заслуживают прощения.', 70938),
(98042, 'ruRU', '<Тандрис долго раздумывает.>\n\nЯ чувствую здесь след древнего зла, |3-6($c). Я немедленно отправлю это на изучение в Дарнас.\n\nАнде''торас-этиль.', 70938);
DELETE FROM `quest_request_items_locale` WHERE `locale` = 'ruRU' AND `ID` IN (952, 1007, 2098, 4733, 7792, 87760, 98042);
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(952, 'ruRU', 'А, |3-6($c). Чем может тебе помочь Ону?', 70938),
(1007, 'ruRU', 'Ты $Gснашел:нашла; статуэтку, $n?', 70938),
(2098, 'ruRU', 'Эй, $gсухопутник:сухопутница;, еще не нашелся мой сломанный ключ?', 70938),
(4733, 'ruRU', 'Хвала Элуне – я рада нашей встрече, $gдорогой:дорогая; $n. Расследование Храмом Луны феномена выброшенных на берег созданий продолжается. Быть может, вы хотите предложить нам еще что-то интересное?', 70938),
(7792, 'ruRU', 'Мы сейчас собираем пожертвования в виде шерстяной ткани. За щедрый дар вы получите признательность Дарнасса. Наши запасы таковы, что нам нужно от вас всего лишь шестьдесят отрезов. Мы могли бы купить их и на стороне, чтобы продолжить работу.$B$BНо если вы имеете шестьдесят отрезов шерстяной ткани и готовы пожертвовать их в дар, я с готовностью приму их у вас прямо сейчас.', 70938),
(87760, 'ruRU', 'Мы наконец-то раскрыли тайну, а животные снова смогут жить в мире!', 70938),
(98042, 'ruRU', 'У тебя обеспокоенный вид. Я слушаю.', 70938);

-- 2. NPC data live sends that differs from ours (from live's creature query answers and the spawn data).
UPDATE `creature_template` SET `type` = 3 WHERE `entry` IN (11519, 2212);   -- Bazzalan, Deth'ryll Satyr: demons live, humanoid ours
UPDATE `creature_template` SET `type` = 10, `family` = 0 WHERE `entry` = 12940;   -- Vorsha the Lasher: live has no type and no beast family
UPDATE `creature_template` SET `family` = 0 WHERE `entry` = 11836;   -- Captured Rabid Thistle Bear: no pet family live
UPDATE `creature_template` SET `Classification` = 1 WHERE `entry` = 3468;   -- Ancient of Lore: elite live
UPDATE `creature_template` SET `unit_class` = 2 WHERE `entry` = 270294;   -- Baron Marinous: paladin class (has mana) live
UPDATE `creature_template` SET `npcflag` = `npcflag` | 4096 WHERE `entry` IN (4235, 4185);   -- Turian, Shaldyn: they repair live
-- Factions live uses (the display sabers in Darnassus were hostile-capable faction 7 or Darnassus guard faction in ours).
UPDATE `creature_template` SET `faction` = 79 WHERE `entry` = 274757;   -- Temple Highguard
UPDATE `creature_template` SET `faction` = 80 WHERE `entry` = 274927;   -- Faluris
UPDATE `creature_template` SET `faction` = 80 WHERE `entry` = 274780;   -- Damin Dawnshadow
UPDATE `creature_template` SET `faction` = 124 WHERE `entry` = 270269;   -- Arbal
UPDATE `creature_template` SET `faction` = 3634 WHERE `entry` = 263644;   -- Pherry Leftee
UPDATE `creature_template` SET `faction` = 74 WHERE `entry` = 271903;   -- Stormscale Beastmistress
UPDATE `creature_template` SET `faction` = 91 WHERE `entry` = 270294;   -- Baron Marinous
UPDATE `creature_template` SET `faction` = 35 WHERE `entry` = 261578;   -- Riding Striped Nightsaber
UPDATE `creature_template` SET `faction` = 35 WHERE `entry` = 261529;   -- Riding Striped Frostsaber
UPDATE `creature_template` SET `faction` = 35 WHERE `entry` = 261579;   -- Riding Spotted Frostsaber
UPDATE `creature_template` SET `faction` = 35 WHERE `entry` = 276731;   -- Swift Mistsaber
UPDATE `creature_template` SET `faction` = 35 WHERE `entry` = 265472;   -- Riding Striped Dawnsaber
UPDATE `creature_template` SET `faction` = 35 WHERE `entry` = 276730;   -- Swift Stormsaber
UPDATE `creature_template` SET `faction` = 35 WHERE `entry` = 276732;   -- Swift Frostsaber
-- Models: Sentinel Selarin uses her old night elf model live; Ancient Protector and Temple Highguard have more models live.
DELETE FROM `creature_template_model` WHERE `CreatureID` = 3694;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES (3694, 0, 1982, 1, 1, 70938);
DELETE FROM `creature_template_model` WHERE `CreatureID` = 2041;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES (2041, 0, 2429, 1, 2, 70938), (2041, 1, 1921, 2, 1, 70938);
DELETE FROM `creature_template_model` WHERE `CreatureID` = 274757;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES (274757, 0, 147834, 1.1, 1, 70938), (274757, 1, 147839, 1.1, 1, 70938), (274757, 2, 147840, 1.1, 1, 70938), (274757, 3, 147841, 1.1, 1, 70938);
-- Weapons live: sentinels carry newer bows, the Temple Highguard two glaives and a bow, a few NPCs had none.
DELETE FROM `creature_equip_template` WHERE `ID` = 1 AND `CreatureID` IN (4262, 6086, 274757, 274927, 263644, 271903);
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `AppearanceModID1`, `ItemVisual1`, `ItemID2`, `AppearanceModID2`, `ItemVisual2`, `ItemID3`, `AppearanceModID3`, `ItemVisual3`, `VerifiedBuild`) VALUES
(4262, 1, 5598, 0, 0, 0, 0, 0, 239123, 0, 0, 70938),
(6086, 1, 5598, 0, 0, 0, 0, 0, 2550, 0, 0, 70938),
(274757, 1, 14881, 0, 0, 14881, 0, 0, 239123, 0, 0, 70938),
(274927, 1, 13150, 0, 0, 0, 0, 0, 0, 0, 0, 70938),
(263644, 1, 5598, 0, 0, 0, 0, 0, 0, 0, 0, 70938),
(271903, 1, 270303, 0, 0, 0, 0, 0, 0, 0, 0, 70938);
-- Emote states live: Kurdram Stonehammer (69) and Delfrum Flintbeard (233) in Darnassus.
INSERT INTO `creature_template_addon` (`entry`, `emote`) VALUES (6297, 69), (6299, 233) ON DUPLICATE KEY UPDATE `emote` = VALUES(`emote`);

-- 3. Landria (4173, bows in Darnassus) sells Serrated Knife (287063) live, one at a time like her Fine Shortbow.
DELETE FROM `npc_vendor` WHERE `entry` = 4173 AND `item` = 287063;
INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `type`, `BonusListIDs`, `PlayerConditionID`, `IgnoreFiltering`, `VerifiedBuild`) VALUES (4173, 57, 287063, 1, 7200, 0, 1, '', 0, 0, 70938);

-- 4. Object templates our data lacks: the Darnassus Guild Vaults, a mailbox and the barber shop (chair, razor, brush, cup).
--    Rows from the players' cache files (cache3-1115), checked against live's query answers in these captures (same type and model).
DELETE FROM `gameobject_template` WHERE `entry` = 630866;
INSERT INTO `gameobject_template` (`entry`,`type`,`displayId`,`name`,`IconName`,`castBarCaption`,`unk1`,`size`,`Data0`,`Data1`,`Data2`,`Data3`,`Data4`,`Data5`,`Data6`,`Data7`,`Data8`,`Data9`,`Data10`,`Data11`,`Data12`,`Data13`,`Data14`,`Data15`,`Data16`,`Data17`,`Data18`,`Data19`,`Data20`,`Data21`,`Data22`,`Data23`,`Data24`,`Data25`,`Data26`,`Data27`,`Data28`,`Data29`,`Data30`,`Data31`,`Data32`,`Data33`,`Data34`,`ContentTuningId`,`RequiredLevel`,`VerifiedBuild`) VALUES (630866,34,122621,'Guild Vault','','','',1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70938);
DELETE FROM `gameobject_template` WHERE `entry` = 630867;
INSERT INTO `gameobject_template` (`entry`,`type`,`displayId`,`name`,`IconName`,`castBarCaption`,`unk1`,`size`,`Data0`,`Data1`,`Data2`,`Data3`,`Data4`,`Data5`,`Data6`,`Data7`,`Data8`,`Data9`,`Data10`,`Data11`,`Data12`,`Data13`,`Data14`,`Data15`,`Data16`,`Data17`,`Data18`,`Data19`,`Data20`,`Data21`,`Data22`,`Data23`,`Data24`,`Data25`,`Data26`,`Data27`,`Data28`,`Data29`,`Data30`,`Data31`,`Data32`,`Data33`,`Data34`,`ContentTuningId`,`RequiredLevel`,`VerifiedBuild`) VALUES (630867,34,122621,'Guild Vault','','','',0.33,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70938);
DELETE FROM `gameobject_template` WHERE `entry` = 703896;
INSERT INTO `gameobject_template` (`entry`,`type`,`displayId`,`name`,`IconName`,`castBarCaption`,`unk1`,`size`,`Data0`,`Data1`,`Data2`,`Data3`,`Data4`,`Data5`,`Data6`,`Data7`,`Data8`,`Data9`,`Data10`,`Data11`,`Data12`,`Data13`,`Data14`,`Data15`,`Data16`,`Data17`,`Data18`,`Data19`,`Data20`,`Data21`,`Data22`,`Data23`,`Data24`,`Data25`,`Data26`,`Data27`,`Data28`,`Data29`,`Data30`,`Data31`,`Data32`,`Data33`,`Data34`,`ContentTuningId`,`RequiredLevel`,`VerifiedBuild`) VALUES (703896,19,1948,'Mailbox','','','',1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70938);
DELETE FROM `gameobject_template` WHERE `entry` = 702763;
INSERT INTO `gameobject_template` (`entry`,`type`,`displayId`,`name`,`IconName`,`castBarCaption`,`unk1`,`size`,`Data0`,`Data1`,`Data2`,`Data3`,`Data4`,`Data5`,`Data6`,`Data7`,`Data8`,`Data9`,`Data10`,`Data11`,`Data12`,`Data13`,`Data14`,`Data15`,`Data16`,`Data17`,`Data18`,`Data19`,`Data20`,`Data21`,`Data22`,`Data23`,`Data24`,`Data25`,`Data26`,`Data27`,`Data28`,`Data29`,`Data30`,`Data31`,`Data32`,`Data33`,`Data34`,`ContentTuningId`,`RequiredLevel`,`VerifiedBuild`) VALUES (702763,32,7896,'Barbershop Chair','','','',1.0,1,0,0,0,67,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70938);
DELETE FROM `gameobject_template` WHERE `entry` = 702830;
INSERT INTO `gameobject_template` (`entry`,`type`,`displayId`,`name`,`IconName`,`castBarCaption`,`unk1`,`size`,`Data0`,`Data1`,`Data2`,`Data3`,`Data4`,`Data5`,`Data6`,`Data7`,`Data8`,`Data9`,`Data10`,`Data11`,`Data12`,`Data13`,`Data14`,`Data15`,`Data16`,`Data17`,`Data18`,`Data19`,`Data20`,`Data21`,`Data22`,`Data23`,`Data24`,`Data25`,`Data26`,`Data27`,`Data28`,`Data29`,`Data30`,`Data31`,`Data32`,`Data33`,`Data34`,`ContentTuningId`,`RequiredLevel`,`VerifiedBuild`) VALUES (702830,5,133588,'Razor','','','',1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70938);
DELETE FROM `gameobject_template` WHERE `entry` = 702832;
INSERT INTO `gameobject_template` (`entry`,`type`,`displayId`,`name`,`IconName`,`castBarCaption`,`unk1`,`size`,`Data0`,`Data1`,`Data2`,`Data3`,`Data4`,`Data5`,`Data6`,`Data7`,`Data8`,`Data9`,`Data10`,`Data11`,`Data12`,`Data13`,`Data14`,`Data15`,`Data16`,`Data17`,`Data18`,`Data19`,`Data20`,`Data21`,`Data22`,`Data23`,`Data24`,`Data25`,`Data26`,`Data27`,`Data28`,`Data29`,`Data30`,`Data31`,`Data32`,`Data33`,`Data34`,`ContentTuningId`,`RequiredLevel`,`VerifiedBuild`) VALUES (702832,5,133589,'Brush','','','',1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70938);
DELETE FROM `gameobject_template` WHERE `entry` = 702833;
INSERT INTO `gameobject_template` (`entry`,`type`,`displayId`,`name`,`IconName`,`castBarCaption`,`unk1`,`size`,`Data0`,`Data1`,`Data2`,`Data3`,`Data4`,`Data5`,`Data6`,`Data7`,`Data8`,`Data9`,`Data10`,`Data11`,`Data12`,`Data13`,`Data14`,`Data15`,`Data16`,`Data17`,`Data18`,`Data19`,`Data20`,`Data21`,`Data22`,`Data23`,`Data24`,`Data25`,`Data26`,`Data27`,`Data28`,`Data29`,`Data30`,`Data31`,`Data32`,`Data33`,`Data34`,`ContentTuningId`,`RequiredLevel`,`VerifiedBuild`) VALUES (702833,5,133590,'Cup','','','',1.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70938);
DELETE FROM `gameobject_template_locale` WHERE `locale` = 'ruRU' AND `entry` IN (630866, 630867, 703896, 702763, 702830, 702832, 702833);
INSERT INTO `gameobject_template_locale` (`entry`, `locale`, `name`, `castBarCaption`, `unk1`, `VerifiedBuild`) VALUES (630866, 'ruRU', 'Хранилище гильдии', '', '', 70938), (630867, 'ruRU', 'Хранилище гильдии', '', '', 70938), (703896, 'ruRU', 'Почтовый ящик', '', '', 70938), (702763, 'ruRU', 'Кресло', '', '', 70938), (702830, 'ruRU', 'Бритва', '', '', 70938), (702832, 'ruRU', 'Расческа', '', '', 70938), (702833, 'ruRU', 'Чашка', '', '', 70938);

-- 5. Their spawns in Darnassus, plus the barber shop's mirrors, post, pole and poster (templates we have but never placed there),
--    a Blacksmith's Anvil and the Moonwell Spell Focus in the Temple of the Moon. The Guild Vault guessed in 2026_11_15_50 (guid 838001000,
--    entry 630865) goes in favour of the live ones, so run this AFTER that file. Inserts skip anything of the same id within 5 yd.
DELETE FROM `gameobject` WHERE `guid` = 838001000 AND `id` = 630865;
DELETE FROM `gameobject` WHERE `guid` BETWEEN 46120000 AND 46120199;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`,
  `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`)
SELECT n.guid, n.id, 1, 0, 0, '0', 0, 0, 0, -1, n.x, n.y, n.z, n.o, n.r0, n.r1, n.r2, n.r3, 120, 255, 1, '', 70938 FROM (
  SELECT 46120000 AS guid, 1684 AS id, 9920.427 AS x, 2309 AS y, 1330.786 AS z, 3.3331 AS o, 0 AS r0, 0 AS r1, -0.9954 AS r2, 0.0956 AS r3
  UNION ALL SELECT 46120001 AS guid, 177666 AS id, 9633.677 AS x, 2524.121 AS y, 1333.227 AS z, 2.0246 AS o, 0 AS r0, 0 AS r1, 0.848 AS r2, 0.5299 AS r3
  UNION ALL SELECT 46120002 AS guid, 630866 AS id, 9931.25 AS x, 2526.47 AS y, 1319.59 AS z, 2.4958 AS o, 0 AS r0, 0 AS r1, 0.9483 AS r2, 0.3173 AS r3
  UNION ALL SELECT 46120003 AS guid, 630867 AS id, 9935.95 AS x, 2517.15 AS y, 1318.54 AS z, 5.5676 AS o, 0 AS r0, 0 AS r1, -0.3502 AS r2, 0.9367 AS r3
  UNION ALL SELECT 46120004 AS guid, 630867 AS id, 9944.14 AS x, 2513.43 AS y, 1318.63 AS z, 3.0019 AS o, 0 AS r0, 0 AS r1, 0.9976 AS r2, 0.0698 AS r3
  UNION ALL SELECT 46120005 AS guid, 702763 AS id, 9891.795 AS x, 2326.021 AS y, 1328.34 AS z, 0.8028 AS o, 0 AS r0, 0 AS r1, 0.3907 AS r2, 0.9205 AS r3
  UNION ALL SELECT 46120006 AS guid, 702763 AS id, 9893.54 AS x, 2324.17 AS y, 1328.212 AS z, 0.5062 AS o, 0 AS r0, 0 AS r1, 0.2504 AS r2, 0.9681 AS r3
  UNION ALL SELECT 46120007 AS guid, 702763 AS id, 9894.104 AS x, 2321.749 AS y, 1328.351 AS z, 0.1929 AS o, 0 AS r0, 0 AS r1, 0.0963 AS r2, 0.9954 AS r3
  UNION ALL SELECT 46120008 AS guid, 702767 AS id, 9867.4 AS x, 2310.615 AS y, 1322.098 AS z, 3.621 AS o, 0 AS r0, 0 AS r1, -0.9714 AS r2, 0.2374 AS r3
  UNION ALL SELECT 46120009 AS guid, 702821 AS id, 9893.185 AS x, 2327.663 AS y, 1329.463 AS z, 0.66 AS o, 0 AS r0, 0 AS r1, 0.3241 AS r2, 0.946 AS r3
  UNION ALL SELECT 46120010 AS guid, 702821 AS id, 9894.894 AS x, 2324.97 AS y, 1329.463 AS z, 3.6139 AS o, 0 AS r0, 0 AS r1, -0.9722 AS r2, 0.234 AS r3
  UNION ALL SELECT 46120011 AS guid, 702821 AS id, 9896.08 AS x, 2322.227 AS y, 1329.463 AS z, 0.1208 AS o, 0 AS r0, 0 AS r1, 0.0604 AS r2, 0.9982 AS r3
  UNION ALL SELECT 46120012 AS guid, 702822 AS id, 9893.367 AS x, 2327.783 AS y, 1327.891 AS z, 0.6493 AS o, 0 AS r0, 0 AS r1, 0.319 AS r2, 0.9478 AS r3
  UNION ALL SELECT 46120013 AS guid, 702822 AS id, 9895.067 AS x, 2325.011 AS y, 1327.891 AS z, 0.452 AS o, 0 AS r0, 0 AS r1, 0.2241 AS r2, 0.9746 AS r3
  UNION ALL SELECT 46120014 AS guid, 702822 AS id, 9896.295 AS x, 2322.232 AS y, 1327.891 AS z, 0.1961 AS o, 0 AS r0, 0 AS r1, 0.0979 AS r2, 0.9952 AS r3
  UNION ALL SELECT 46120015 AS guid, 702829 AS id, 9892.252 AS x, 2316.208 AS y, 1329.317 AS z, 2.0659 AS o, 0 AS r0, 0 AS r1, 0.8588 AS r2, 0.5123 AS r3
  UNION ALL SELECT 46120016 AS guid, 702830 AS id, 9891.85 AS x, 2315.874 AS y, 1330.132 AS z, 0 AS o, 0 AS r0, 0 AS r1, 0 AS r2, 1 AS r3
  UNION ALL SELECT 46120017 AS guid, 702832 AS id, 9892.166 AS x, 2315.476 AS y, 1330.134 AS z, 0 AS o, 0 AS r0, 0 AS r1, 0 AS r2, 1 AS r3
  UNION ALL SELECT 46120018 AS guid, 702833 AS id, 9891.803 AS x, 2315.497 AS y, 1330.113 AS z, 0 AS o, 0 AS r0, 0 AS r1, 0 AS r2, 1 AS r3
  UNION ALL SELECT 46120019 AS guid, 703896 AS id, 9842.314 AS x, 2313.759 AS y, 1317.505 AS z, 2.7576 AS o, 0 AS r0, 0 AS r1, 0.9816 AS r2, 0.1908 AS r3
) n WHERE EXISTS (SELECT 1 FROM `gameobject_template` t WHERE t.`entry` = n.id) AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`map` = 1 AND g.`id` = n.id
  AND POW(g.`position_x` - n.x, 2) + POW(g.`position_y` - n.y, 2) + POW(g.`position_z` - n.z, 2) < 25);

-- 6. NPCs live has in Darnassus that we lack: the Temple Highguards of the Temple of the Moon (we had one), and four display sabers by
--    the saber vendor (we had three of the seven). Positions from the live spawn data; skips any of the same id within 5 yd.
DELETE FROM `creature` WHERE `guid` BETWEEN 46120000 AND 46120199;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`,
  `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `ScriptName`, `VerifiedBuild`)
SELECT n.guid, n.id, 1, 0, 0, '0', 0, 0, 0, -1, 0, 1, n.x, n.y, n.z, n.o, 300, 0, 0, 100, 0, '', 70938 FROM (
  SELECT 46120000 AS guid, 261529 AS id, 10131.254 AS x, 2528.95 AS y, 1324.4 AS z, 3.5256 AS o
  UNION ALL SELECT 46120001 AS guid, 261578 AS id, 10130.022 AS x, 2526.77 AS y, 1325.407 AS z, 2.7925 AS o
  UNION ALL SELECT 46120002 AS guid, 261579 AS id, 10127.163 AS x, 2523.457 AS y, 1326.099 AS z, 1.8675 AS o
  UNION ALL SELECT 46120003 AS guid, 274757 AS id, 9585.051 AS x, 2542.122 AS y, 1335.555 AS z, 6.0086 AS o
  UNION ALL SELECT 46120004 AS guid, 274757 AS id, 9590.02 AS x, 2507.204 AS y, 1335.309 AS z, 5.7421 AS o
  UNION ALL SELECT 46120005 AS guid, 274757 AS id, 9590.151 AS x, 2516.271 AS y, 1354.908 AS z, 0.1745 AS o
  UNION ALL SELECT 46120006 AS guid, 274757 AS id, 9591.953 AS x, 2509.475 AS y, 1354.94 AS z, 0.3491 AS o
  UNION ALL SELECT 46120007 AS guid, 274757 AS id, 9594.626 AS x, 2511.458 AS y, 1335.006 AS z, 5.4978 AS o
  UNION ALL SELECT 46120008 AS guid, 274757 AS id, 9611.679 AS x, 2571.196 AS y, 1335.67 AS z, 5.1887 AS o
  UNION ALL SELECT 46120009 AS guid, 274757 AS id, 9613.92 AS x, 2475.511 AS y, 1335.341 AS z, 1.1644 AS o
  UNION ALL SELECT 46120010 AS guid, 274757 AS id, 9618.166 AS x, 2564.575 AS y, 1354.891 AS z, 2.042 AS o
  UNION ALL SELECT 46120011 AS guid, 274757 AS id, 9621.314 AS x, 2481.198 AS y, 1354.891 AS z, 4.2586 AS o
  UNION ALL SELECT 46120012 AS guid, 274757 AS id, 9644.444 AS x, 2565.825 AS y, 1354.891 AS z, 1.1694 AS o
  UNION ALL SELECT 46120013 AS guid, 274757 AS id, 9647.044 AS x, 2481.672 AS y, 1354.891 AS z, 5.0091 AS o
  UNION ALL SELECT 46120014 AS guid, 274757 AS id, 9651.146 AS x, 2571.306 AS y, 1335.61 AS z, 4.2959 AS o
  UNION ALL SELECT 46120015 AS guid, 274757 AS id, 9653.326 AS x, 2476.77 AS y, 1335.154 AS z, 1.944 AS o
  UNION ALL SELECT 46120016 AS guid, 274757 AS id, 9664.496 AS x, 2533.664 AS y, 1360.082 AS z, 5.8992 AS o
  UNION ALL SELECT 46120017 AS guid, 274757 AS id, 9664.672 AS x, 2558.619 AS y, 1355.02 AS z, 2.4837 AS o
  UNION ALL SELECT 46120018 AS guid, 274757 AS id, 9664.979 AS x, 2515.359 AS y, 1360.082 AS z, 0.4538 AS o
  UNION ALL SELECT 46120019 AS guid, 274757 AS id, 9673.333 AS x, 2537.527 AS y, 1360.082 AS z, 0.2443 AS o
  UNION ALL SELECT 46120020 AS guid, 274757 AS id, 9673.723 AS x, 2512.884 AS y, 1360.082 AS z, 5.9865 AS o
  UNION ALL SELECT 46120021 AS guid, 274757 AS id, 9679.861 AS x, 2544.458 AS y, 1335.738 AS z, 3.5309 AS o
  UNION ALL SELECT 46120022 AS guid, 274757 AS id, 9680.981 AS x, 2504.791 AS y, 1335.523 AS z, 2.7667 AS o
  UNION ALL SELECT 46120023 AS guid, 274757 AS id, 9700.623 AS x, 2532.318 AS y, 1335.773 AS z, 6.2134 AS o
  UNION ALL SELECT 46120024 AS guid, 274757 AS id, 9701.3 AS x, 2518.581 AS y, 1335.773 AS z, 0.0873 AS o
  UNION ALL SELECT 46120025 AS guid, 276731 AS id, 10126.681 AS x, 2530.603 AS y, 1323.244 AS z, 3.194 AS o
) n WHERE EXISTS (SELECT 1 FROM `creature_template` t WHERE t.`entry` = n.id) AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`map` = 1 AND c.`id` = n.id
  AND POW(c.`position_x` - n.x, 2) + POW(c.`position_y` - n.y, 2) + POW(c.`position_z` - n.z, 2) < 25);
