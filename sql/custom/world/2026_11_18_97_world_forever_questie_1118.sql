-- WoW Forever live quest data from Questie (QuestieDB 4a73dc65, GPL-3.0), picked on 18 Nov: only what ours had wrong, and only
-- for quests we already have. Not their files: their values were compared with ours and only the differences are written here.
-- Safe to run more than once.

-- 1. Darkspear Islands battleground quests (levels 30-39): the first turn-in and its repeatable follow-up, for each side.
--    Horde: Conflict at Darkspear Islands 98887 / 98888 at the Horde Warbringer (15350); Alliance: Darkspear Islands Clash
--    98895 / 98896 at the Alliance Brigadier General (15351); The Battle for Darkspear Islands! 98906 (Horde).
--    Ours let anyone of any level take them, both sides took both, and the follow-up needed nothing first.
UPDATE `quest_template` SET `AllowableRaces`=8589934770 WHERE `ID`=98888 AND `AllowableRaces`=18446744073709551615;
UPDATE `quest_template` SET `AllowableRaces`=4294967373 WHERE `ID`=98895 AND `AllowableRaces`=18446744073709551615;
INSERT INTO `quest_template_addon` (`ID`,`MaxLevel`) VALUES (98887,39),(98888,39),(98895,39),(98896,39),(98906,39)
ON DUPLICATE KEY UPDATE `MaxLevel`=VALUES(`MaxLevel`);
UPDATE `quest_template_addon` SET `PrevQuestID`=98887 WHERE `ID`=98888 AND `PrevQuestID`=0;
UPDATE `quest_template_addon` SET `PrevQuestID`=98895 WHERE `ID`=98896 AND `PrevQuestID`=0;
UPDATE `quest_template_addon` SET `SpecialFlags`=`SpecialFlags`|1 WHERE `ID` IN (98888,98896);

-- 2. Buying Friendship (Desolace centaur bribes): live asks for at least Neutral with the clan being bribed before the quest can be
--    taken. 93227 and 94873 Gelkis Clan Centaur (92), 94872 Magram Clan Centaur (93).
UPDATE `quest_template_addon` SET `RequiredMinRepFaction`=92, `RequiredMinRepValue`=0 WHERE `ID` IN (93227,94873) AND `RequiredMinRepFaction`=0;
UPDATE `quest_template_addon` SET `RequiredMinRepFaction`=93, `RequiredMinRepValue`=0 WHERE `ID`=94872 AND `RequiredMinRepFaction`=0;
