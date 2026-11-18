-- Auction house bot: per-unit market prices (AuctionHouseBot.Vanilla.MarketPrices). Empty by default; the bot falls back to
-- AuctionHouseBot.Vanilla.ValueCurve or the vendor price for items without a row. Safe to run again.

CREATE TABLE IF NOT EXISTS `auctionhousebot_market_price` (
  `ItemID` int unsigned NOT NULL,
  `UnitPrice` bigint unsigned NOT NULL DEFAULT '0' COMMENT 'copper per unit',
  `Quantity` int unsigned NOT NULL DEFAULT '0' COMMENT 'units seen on offer',
  `Samples` smallint unsigned NOT NULL DEFAULT '0' COMMENT 'price samples behind UnitPrice',
  PRIMARY KEY (`ItemID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Auction house bot market prices';
