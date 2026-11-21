-- WoW Forever live realm: captures from 2026-11-16 and 2026-11-17 (client 70938, enUS and ruRU). Only what our data lacks.
-- Safe to run more than once. No new spawns.

-- 1. Flintfire's Shipment 672508 (quest 98321 "Flintfire's Shipment", needs 8 x item 280413) had no loot, so the quest could not
-- be done. Live: every one of 8 opened shipments gave exactly one 280413.
UPDATE `gameobject_template` SET `Data1` = 672508 WHERE `entry` = 672508;
DELETE FROM `gameobject_loot_template` WHERE `Entry` = 672508;
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(672508, 0, 280413, 100, 1, 1, 0, 1, 1, 'Flintfire''s Shipment - live sniff 2026-11-16');

-- 2. Mikhail 4963 <Bartender> in Menethil Harbor: live sells five drinks, ours had no list and no vendor flag. Quest giver flag
-- kept (he gives The Missing Diplomat), same as bartender 2366.
UPDATE `creature_template` SET `npcflag` = `npcflag` | 128 WHERE `entry` = 4963;
DELETE FROM `npc_vendor` WHERE `entry` = 4963;
INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `type`, `BonusListIDs`, `PlayerConditionID`, `IgnoreFiltering`, `VerifiedBuild`) VALUES
(4963, 1, 2723, 0, 0, 0, 1, NULL, 0, 0, 70938),
(4963, 2, 2593, 0, 0, 0, 1, NULL, 0, 0, 70938),
(4963, 3, 2596, 0, 0, 0, 1, NULL, 0, 0, 70938),
(4963, 4, 2594, 0, 0, 0, 1, NULL, 0, 0, 70938),
(4963, 5, 2595, 0, 0, 0, 1, NULL, 0, 0, 70938);

-- 3. Turn-in texts of the Forsaken paladin quests (The Tarnished 91317, A Lesson in Divinity 94427-94441): ours had none.
DELETE FROM `quest_offer_reward` WHERE `ID` IN (91317, 94427, 94434, 94435, 94436, 94438, 94440, 94441);
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(91317, 1, 1, 0, 0, 0, 0, 0, 0, 'Excellent work, $n. Every time one of these Tarnished strike out and kill one of the Forsaken, it becomes that much easier for our detractors to stoke mistrust towards us paladins. Eliminating them will help further our cause and solidify our place here in Tirisfal.\n\nI suspect it may take a long time for us to be fully embraced by the Forsaken and the horde. It could take years... or maybe even decades, but the best we can do is keep trying to prove ourselves.', 70938),
(94427, 1, 1, 0, 0, 0, 0, 0, 0, 'You... you are a paladin? Please, do not hurt me. I-I know I''m not supposed to be panhandling. I have no quarrel with you or your order. Leave me be, I beg you!', 70938),
(94434, 1, 1, 0, 0, 0, 0, 0, 0, 'This is very kind of you, $c. Very kind indeed.', 70938),
(94435, 1, 1, 0, 0, 0, 0, 0, 0, 'You have done well, $n. It was a small thing, but even small acts of service such as this may help strengthen our connection to the light.\n\nThe Dark Lady and many in her service mistrust us. Some even conspire against us, but we will visit their skepticism and fear with courage and righteousness. We will show them that we are members of the Forsaken and we are willing to do our part, be it large or small, to help our people prosper once again.\n\nTake this symbol, you will need it for what comes next.', 70938),
(94436, 1, 1, 0, 0, 0, 0, 0, 0, 'So you''ll help me, then? Good, good. I''ll admit I''m not proud of resorting to... well, resorting to asking paladins for aid. The priests waved me away and you might be my friend''s only chance.\n\nPlease, help me.', 70938),
(94438, 1, 1, 0, 0, 0, 0, 0, 0, 'I''m... back? And saved by a paladin no less? I see you carry a Symbol of Life. I''ve not seen one of those since... well, since before the war when Lordaeron was a very different place. I can only assume you are here to help. Billmuth and I were sent here to scout out the scarlet activity here, and we found out that they are planning some kind of attack.\n\nIf you would be willing to help more, there may yet be more that you can do to help the Forsaken.', 70938),
(94440, 1, 66, 0, 0, 0, 0, 0, 0, 'Thank you for saving my friend, $n. I will take these plans back to my commander and we will give those crusaders a welcoming they won''t forget.\n\nI know that many among our people mistrust you paladins, but it''s clear to me that you are Forsaken through and through. I won''t forget this, and I''ll make sure others know of what you did here today.', 70938),
(94441, 1, 66, 0, 0, 0, 0, 0, 0, 'The Symbol of Life is only able to be used by a paladin who is ready to make use of one of the light''s greatest blessings. I''m proud to count you among us, and I now bestow upon you the gift of redemption. With this you will be able to resurrect your fallen companions. Use this new boon wisely.\n\nYou have done well for both the Forsaken as well as the paladins of Bandarion Keep. Any steps we can take to win the hearts and minds of our fellow Forsaken is well worth the effort. Go with the light, $n.', 70938);
