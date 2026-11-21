-- Taming the Beast (6102, Teldrassil): the Russian quest text named the target two other ways. The log line said "совиного
-- крикуна" and the quest text "совиного визгуна", but Strigid Screecher 1996 is "Сова-крикун" in our ruRU names and in the live
-- forever client cache (2026_11_10_44). The text now uses the creature's name: "сову-крикуна" (the quest text already says
-- "которую", "the owl"). Text only. Safe to run again.
UPDATE `quest_template_locale` SET `LogDescription` = REPLACE(`LogDescription`, 'совиного крикуна', 'сову-крикуна')
WHERE `ID` = 6102 AND `locale` = 'ruRU';
UPDATE `quest_template_locale` SET `QuestDescription` = REPLACE(`QuestDescription`, 'совиного визгуна', 'сову-крикуна')
WHERE `ID` = 6102 AND `locale` = 'ruRU';
