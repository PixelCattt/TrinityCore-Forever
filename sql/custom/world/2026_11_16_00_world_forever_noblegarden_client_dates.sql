-- Noblegarden on the client's own dates.
--
-- Event 28 owns the Noblegarden objects (192 gameobject spawns in game_event_gameobject, 2026_10_17_53) but came from
-- VMaNGOS with no start, no end and no holiday, so it never ran: GameEventMgr::CheckOneGameEvent needs start < now < end.
-- The Forever client carries the holiday as Holidays 181: a dated run every spring (2026-04-06, 2027-03-29, 2028-04-17 ... up
-- to 2030), but no duration for any stage. Since 2026_11_16 the server keeps the game_event row's length for such a holiday
-- (GameEventMgr::SetHolidayEventTime) instead of ignoring its dates, so linking the row is enough: start comes from the client's
-- next date, the length stays the row's 2880 minutes, and the next date is picked when a run ends.
-- start_time is only the fallback once the client's dates run out (after 2030); end_time matches the other yearly events.
-- With thanks to the Everlake core (GPL), whose report pointed at the missing-duration case.
UPDATE `game_event` SET `start_time` = '2026-04-06 00:00:00', `end_time` = '2037-12-31 23:59:59', `holiday` = 181, `holidayStage` = 1
WHERE `eventEntry` = 28;
