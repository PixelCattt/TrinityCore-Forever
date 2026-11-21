-- WoW Forever: live captures of 18 Nov 22:13 and 22:15 and 19 Nov 20:56 (client 70959, Dun Morogh, Ironforge, Loch Modan).
-- Stolen Blasting Powder 95214 (Dun Morogh) had no turn-in text: live text added.
-- Elder Snow Leopard 260157 was on faction 37 (Frostmane trolls); live sends 66 (leopard; 52 seen). Safe to run again.
DELETE FROM `quest_offer_reward` WHERE `ID`=95214;
INSERT INTO `quest_offer_reward` (`ID`,`Emote1`,`Emote2`,`Emote3`,`Emote4`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`EmoteDelay4`,`RewardText`,`VerifiedBuild`) VALUES
(95214,66,0,0,0,0,0,0,0,'That should be all the stolen powder. Thank you, $c.$B$BPlease accept this reward, and... I''d appreciate if you didn''t mention this little incident to anyone.',70959);
UPDATE `creature_template` SET `faction`=66 WHERE `entry`=260157;
