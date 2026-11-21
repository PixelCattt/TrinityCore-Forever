-- WoW Forever: hotfix rows from the live captures of 20 Nov (client 70959) and the live hotfix file (now build 71037, push 114286).
-- Two greetings of new Stormwind NPCs (English text from live answers in players' caches, Russian from the captures), the Russian
-- text of a third, and push 114286 (live hides one creature difficulty and one object). Safe to run again.
DELETE FROM `broadcast_text` WHERE `ID` IN (309855,326954);
INSERT INTO `broadcast_text` (`ID`,`Text`,`Text1`,`LanguageID`,`ConditionID`,`EmotesID`,`Flags`,`ChatBubbleDurationMs`,`VoiceOverPriorityID`,`SoundKitID1`,`SoundKitID2`,`EmoteID1`,`EmoteID2`,`EmoteID3`,`EmoteDelay1`,`EmoteDelay2`,`EmoteDelay3`,`VerifiedBuild`) VALUES
(309855,'Hello there! I''ve got the finest leathers this side of Stormwind. Interested?','',0,0,0,256,0,4,0,0,1,0,0,0,0,0,70959),
(326954,'The flow of magic is unpredictable and chaotic, of late. What, I wonder, could be the cause of this?','The flow of magic is unpredictable and chaotic, of late. What, I wonder, could be the cause of this?',0,0,0,256,0,4,0,0,0,0,0,0,0,0,70959);
DELETE FROM `hotfix_data` WHERE `Id` BETWEEN 2105300 AND 2105309;
DELETE FROM `hotfix_data` WHERE (`TableHash`,`RecordId`) IN ((35137211,309855),(35137211,326954),(3386943305,7023),(331613093,718981));
INSERT INTO `hotfix_data` (`Id`,`UniqueId`,`TableHash`,`RecordId`,`Status`,`VerifiedBuild`) VALUES
(2105300,1397825300,35137211,309855,1,70959),
(2105301,1397825301,35137211,326954,1,70959),
(2105302,1397825302,3386943305,7023,3,71037),
(2105303,1397825303,331613093,718981,3,71037);
DELETE FROM `broadcast_text_locale` WHERE `locale`='ruRU' AND `ID` IN (250597,309855,326954);
INSERT INTO `broadcast_text_locale` (`ID`,`locale`,`Text_lang`,`Text1_lang`,`VerifiedBuild`) VALUES
(250597,'ruRU','','Некоторые наши грузы потерялись в разных уголках Азерота. Если найдешь какие-то из них, я буду благодарна за их возвращение.',70959),
(309855,'ruRU','Привет! У меня лучшие кожи в этом районе Штормграда. Что-то интересует?','',70959),
(326954,'ruRU','В последнее время магия стала более буйной и непредсказуемой. Что же на нее так влияет?','В последнее время магия стала более буйной и непредсказуемой. Что же на нее так влияет?',70959);
