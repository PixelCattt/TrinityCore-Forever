/*
 * This file is part of the TrinityCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "tc_catch2.h"

#include "AuctionHouseBotVanilla.h"
#include "DB2Structure.h"
#include "ItemTemplate.h"

namespace
{
    // An item as the client data has it: only the fields the price code reads.
    struct TestItem
    {
        ItemEntry basic{};
        ItemSparseEntry sparse{};
        ItemTemplate proto{};

        TestItem(uint32 id, uint32 itemClass, uint32 sellPrice, uint32 buyPrice, uint32 vendorStack = 1)
        {
            basic.ID = id;
            basic.ClassID = itemClass;
            sparse.ID = id;
            sparse.SellPrice = sellPrice;
            sparse.BuyPrice = buyPrice;
            sparse.VendorStackCount = vendorStack;
            proto.BasicData = &basic;
            proto.ExtendedData = &sparse;
        }
    };

    struct MarketPricesOff
    {
        ~MarketPricesOff() { AuctionBotVanilla::SetMarketPrices({}); }
    };
}

// Client 70938 values (ItemSparse SellPrice / BuyPrice) and the live market prices of the 15-16 November scans.
TEST_CASE("A market price below the vendor stand-ins is used as it is", "[AuctionBotMarketPrice]")
{
    MarketPricesOff off;
    TestItem linen(2589, ITEM_CLASS_TRADE_GOODS, 13, 55);     // stand-ins 55c (buy) and 52c (4x sell)
    TestItem silk(4306, ITEM_CLASS_TRADE_GOODS, 150, 600);
    AuctionBotVanilla::SetMarketPrices({ { 2589, 24 }, { 4306, 190 } });

    REQUIRE(AuctionBotVanilla::MarketUnitPrice(&linen.proto) == 24);
    REQUIRE(AuctionBotVanilla::UnitValue(&linen.proto) == 24);
    REQUIRE(AuctionBotVanilla::MarketUnitPrice(&silk.proto) == 190);
}

TEST_CASE("A market price never goes below what a vendor pays", "[AuctionBotMarketPrice]")
{
    MarketPricesOff off;
    TestItem wool(2592, ITEM_CLASS_TRADE_GOODS, 33, 135);
    AuctionBotVanilla::SetMarketPrices({ { 2592, 25 } });

    REQUIRE(AuctionBotVanilla::MarketUnitPrice(&wool.proto) == 33);
}

TEST_CASE("Ammo compares against its per-item sell price", "[AuctionBotMarketPrice]")
{
    MarketPricesOff off;
    TestItem shells(15997, ITEM_CLASS_PROJECTILE, 10, 4000, 100);
    TestItem roughArrow(2512, ITEM_CLASS_PROJECTILE, 0, 10, 200);
    AuctionBotVanilla::SetMarketPrices({ { 15997, 22 }, { 2512, 1 } });

    REQUIRE(AuctionBotVanilla::MarketUnitPrice(&shells.proto) == 22);
    REQUIRE(AuctionBotVanilla::MarketUnitPrice(&roughArrow.proto) == 1);
}

TEST_CASE("The scale multiplies the market price, still above the vendor floor", "[AuctionBotMarketPrice]")
{
    MarketPricesOff off;
    TestItem linen(2589, ITEM_CLASS_TRADE_GOODS, 13, 55);
    AuctionBotVanilla::SetMarketPrices({ { 2589, 24 } }, 2.0f);
    REQUIRE(AuctionBotVanilla::MarketUnitPrice(&linen.proto) == 48);

    AuctionBotVanilla::SetMarketPrices({ { 2589, 24 } }, 0.25f);
    REQUIRE(AuctionBotVanilla::MarketUnitPrice(&linen.proto) == 13);
}

TEST_CASE("Items without a row, and prices switched off, give no market price", "[AuctionBotMarketPrice]")
{
    MarketPricesOff off;
    TestItem linen(2589, ITEM_CLASS_TRADE_GOODS, 13, 55);
    TestItem other(765, ITEM_CLASS_TRADE_GOODS, 10, 40);
    AuctionBotVanilla::SetMarketPrices({ { 2589, 24 } });
    REQUIRE(AuctionBotVanilla::MarketUnitPrice(&other.proto) == 0);

    AuctionBotVanilla::SetMarketPrices({});
    REQUIRE(AuctionBotVanilla::MarketUnitPrice(&linen.proto) == 0);
}
