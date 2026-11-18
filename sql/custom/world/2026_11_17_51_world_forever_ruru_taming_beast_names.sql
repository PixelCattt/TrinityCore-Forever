-- Taming the Beast (hunter pet quests): Russian creature names did not match the Russian quest text (Russian forum report,
-- 2026-11-17). Our ruRU creature names came from the modern client data, where two Durotar crabs are named one step up:
-- the small Pygmy Surf Crawler (3106) was "Приливный краб", the name the quest text (6083) uses for the Surf Crawler the rod
-- needs, so players tamed the small crabs by the fort and got "invalid target". The Classic names (same as the quest texts):
--   3106 Pygmy Surf Crawler   "Карликовый приливный краб"  (was "Приливный краб")
--   3107 Surf Crawler         "Приливный краб"             (was "Взрослый приливный краб"; quest 6083 target)
--   3126 Armored Scorpid      "Бронескорп"                 (was "Панцирный скорпид"; quest 6082 text says "бронескорпа")
--   1998 Webwood Lurker       "Чащобный тенетник"          (was "Чащобный скрытень"; quest 6063 text says "чащобного тенетника")
-- Source: the Classic ruRU names of 2026_10_24_40 (VMaNGOS locales), which did not replace existing rows.
-- Names only. Safe to run again.
UPDATE `creature_template_locale` SET `Name` = 'Карликовый приливный краб' WHERE `entry` = 3106 AND `locale` = 'ruRU';
UPDATE `creature_template_locale` SET `Name` = 'Приливный краб' WHERE `entry` = 3107 AND `locale` = 'ruRU';
UPDATE `creature_template_locale` SET `Name` = 'Бронескорп' WHERE `entry` = 3126 AND `locale` = 'ruRU';
UPDATE `creature_template_locale` SET `Name` = 'Чащобный тенетник' WHERE `entry` = 1998 AND `locale` = 'ruRU';
