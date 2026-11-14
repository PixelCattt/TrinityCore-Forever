-- WoW Forever live data from EG Link, picked on 14 Nov: only what our world lacked or had different.
-- Data from Efficient Games (https://efficient.games), licensed under CC BY 4.0 (https://creativecommons.org/licenses/by/4.0/).
-- Source: github.com/JIVESCORP/eg-link-output-wowf commit e0f85859, folders 1.60.1.70790, 1.60.1.70888 and 1.60.1.70938
-- (the newest folder wins where several have the record). Changed: compared with our world and written as TrinityCore rows.
-- VerifiedBuild = the EG folder's build. Where our own live captures (2026_11_10_60/61) cover a record, ours is kept.
-- Safe to run more than once.

-- 1. Object templates our world lacks (template and quest loot list only, no spawns). Fill-only: rows we have stay.
--    424002 Kurzen Supply Crate (70888), 612130 Arcane Salvager (70938).
INSERT IGNORE INTO `gameobject_template` (`entry`,`type`,`displayId`,`name`,`IconName`,`castBarCaption`,`unk1`,`size`,`Data0`,`Data1`,`Data2`,`Data3`,`Data4`,`Data5`,`Data6`,`Data7`,`Data8`,`Data9`,`Data10`,`Data11`,`Data12`,`Data13`,`Data14`,`Data15`,`Data16`,`Data17`,`Data18`,`Data19`,`Data20`,`Data21`,`Data22`,`Data23`,`Data24`,`Data25`,`Data26`,`Data27`,`Data28`,`Data29`,`Data30`,`Data31`,`Data32`,`Data33`,`Data34`,`ContentTuningId`,`RequiredLevel`,`VerifiedBuild`) VALUES
(424002,3,335,'Kurzen Supply Crate','','','',1.0,93,122215,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70888);
INSERT IGNORE INTO `gameobject_questitem` (`GameObjectEntry`,`Idx`,`ItemId`,`VerifiedBuild`) VALUES
(424002,0,216617,70888);
INSERT IGNORE INTO `gameobject_template` (`entry`,`type`,`displayId`,`name`,`IconName`,`castBarCaption`,`unk1`,`size`,`Data0`,`Data1`,`Data2`,`Data3`,`Data4`,`Data5`,`Data6`,`Data7`,`Data8`,`Data9`,`Data10`,`Data11`,`Data12`,`Data13`,`Data14`,`Data15`,`Data16`,`Data17`,`Data18`,`Data19`,`Data20`,`Data21`,`Data22`,`Data23`,`Data24`,`Data25`,`Data26`,`Data27`,`Data28`,`Data29`,`Data30`,`Data31`,`Data32`,`Data33`,`Data34`,`ContentTuningId`,`RequiredLevel`,`VerifiedBuild`) VALUES
(612130,8,125481,'Arcane Salvager','','','',1.0,2256,10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,70938);

-- 2. Story text that is different on live: 8160 Cut Arathor Supply Lines (70888).
UPDATE `quest_template` SET `QuestDescription`='The League of Arathor is sparing no expense in their move to retake Arathi.  They, and all the races of the Alliance, now stream to this distant region, intent on expanding their hold from Refuge Pointe.  We must stop them, and the best means to stop them is to take their supplies.\n\nYou can help us, $n.  Enter Arathi Basin, known for its rich mines, fertile land and skilled craftsman.  Capture and control every base you can, win the battle, and return to me with the resources you gain.', `LogDescription`='Win the battle for Arathi Basin, get an Arathi Resource Crate, and return it to Deathstalker Mortis at Hammerfall.' WHERE `ID`=8160;

-- 3. Objectives live has and we lack: the Zandalar Tribe standing the other four Paragons of Power quests need (8062, 8064, 8066,
--    8073; the 13 Nov file did the first six).
DELETE FROM `quest_objectives` WHERE `ID` IN (383023,383135,383408,382899);
INSERT INTO `quest_objectives` (`ID`,`QuestID`,`Type`,`Order`,`StorageIndex`,`ObjectID`,`Amount`,`ConditionalAmount`,`Flags`,`Flags2`,`ProgressBarWeight`,`ParentObjectiveID`,`Visible`,`Description`,`VerifiedBuild`) VALUES
(383023,8062,6,1,1,270,3000,0,0,0,0,0,1,NULL,70888),
(383135,8064,6,1,1,270,9000,0,0,0,0,0,1,NULL,70888),
(383408,8066,6,1,1,270,9000,0,0,0,0,0,1,NULL,70888),
(382899,8073,6,1,1,270,21000,0,0,0,0,0,1,NULL,70888);

-- 4. Reward display spells (quest_reward_display_spell) on 2 more quests, shown in the reward window.
--    Both have a RewardSpell, so nothing new is cast at turn-in.
DELETE FROM `quest_reward_display_spell` WHERE `QuestID` IN (2771,7647);
INSERT INTO `quest_reward_display_spell` (`QuestID`,`Idx`,`SpellID`,`PlayerConditionID`,`Type`,`VerifiedBuild`) VALUES
(2771,0,9980,0,2,70888),
(7647,0,23214,0,3,70888);

-- 5. Call of Fire (98517), the Skyborne shaman call at level 10: live has the quest, ours lacks it. Record from 70888.
--    Its givers, turn-ins and quest order are in 2026_11_14_97 (Questie). Only added when the id is free.
INSERT IGNORE INTO `quest_template` (`ID`,`QuestType`,`QuestSortID`,`Flags`,`AllowableRaces`,`RewardXPDifficulty`,`RewardXPMultiplier`,
`Expansion`,`AcceptedSoundKitID`,`CompleteSoundKitID`,`LogTitle`,`LogDescription`,`QuestDescription`,`VerifiedBuild`) VALUES
(98517,2,-82,2097152,8589934592,3,1,-2,890,878,'Call of Fire','Report to Sessaria Skystride or Aarnor Galestrike on Zephras Isle to continue your training as a Shaman.\r\n\r\nYou can return to Zephras via the skycutter transport that docks in Mulgore at Skywatcher Plateau, northwest of Thunder Bluff.','Greetings, young Skyborne. The spirits have spoken of you, and tell me that you are ready to heed the call of fire. However, I shall not be the one to start you on that Path. Return to your home in the elemental plane, seek your mentors there. They will tell you what must be done.',70888);
INSERT IGNORE INTO `quest_classic_level` (`ID`,`QuestLevel`,`MinLevel`,`MaxLevel`) VALUES (98517,10,10,0);
INSERT IGNORE INTO `quest_template_classic_level` (`ID`,`LevelType`,`QuestLevel`) VALUES (98517,2,10);
INSERT IGNORE INTO `quest_template_addon` (`ID`,`AllowableClasses`) VALUES (98517,64);

-- 6. Thistle Boar (1985, Teldrassil) can be skinned on live: Ruined Leather Scraps in all 13 skinning windows (70790).
--    Same as the Young Thistle Boar (1984) row we already have. The skin loot id is only set when it has none yet.
DELETE FROM `skinning_loot_template` WHERE `Entry`=1985 AND `ItemType`=0 AND `Item`=2934;
INSERT INTO `skinning_loot_template` (`Entry`,`ItemType`,`Item`,`Chance`,`QuestRequired`,`LootMode`,`GroupId`,`MinCount`,`MaxCount`,`Comment`) VALUES
(1985,0,2934,100,0,1,0,1,1,'Thistle Boar - Ruined Leather Scraps');
UPDATE `creature_template_difficulty` SET `SkinLootID`=1985 WHERE `Entry`=1985 AND `DifficultyID`=0 AND `SkinLootID`=0;
