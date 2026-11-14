-- .time day / .time night (DayCycle.h, Player::SetSkyMode): a character that keeps its own noon or midnight sky. No row is
-- .time auto, the realm's day and night (Forever.DayCycle.Speed). The row goes with the character (Player::DeleteFromDB).
-- Safe to run again.
CREATE TABLE IF NOT EXISTS `character_day_cycle` (
  `guid` bigint unsigned NOT NULL COMMENT 'characters.guid',
  `mode` tinyint unsigned NOT NULL COMMENT '1 noon, 2 midnight',
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='own sky of a character (.time)';
