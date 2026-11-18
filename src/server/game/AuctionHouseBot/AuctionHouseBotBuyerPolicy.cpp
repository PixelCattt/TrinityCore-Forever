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

#include "AuctionHouseBotBuyerPolicy.h"
#include "AuctionHouseBotVanilla.h"
#include "AuctionHouseMgr.h"
#include "Common.h"
#include "Config.h"
#include "Duration.h"
#include "GameTime.h"
#include "Item.h"
#include "ItemTemplate.h"
#include "Log.h"
#include "ObjectMgr.h"
#include "Random.h"
#include "StringConvert.h"
#include "StringFormat.h"
#include "Util.h"
#include "World.h"
#include <algorithm>
#include <unordered_set>

namespace AuctionBotBuyerPolicy
{
namespace
{
    bool _stacks = false;
    float _maxPriceMultiplier = 0.0f; // 0 = no price cap
    uint32 _minDelay = 0;
    uint32 _maxDelay = 0;
    uint64 _dailyBudget = 0;          // copper, 0 = unlimited
    uint32 _maxBuysPerHour = 0;       // 0 = unlimited
    bool _fair = false;
    float _fairMinChance = 35.0f;     // percent at the price cap
    uint32 _dropFloorPerLevel = 0;    // copper per item level, 0 = off
    bool _excludeVendorItems = false;
    std::unordered_set<uint32> _vendorItems;      // sold for gold by a spawned vendor with unlimited stock
    std::unordered_set<uint32> _excludedItemIds;  // AuctionHouseBot.Buyer.ExcludeItemIDs

    time_t _dayStart = 0;
    uint64 _spentToday = 0;
    uint32 _boughtToday = 0;
    time_t _hourStart = 0;
    uint32 _boughtThisHour = 0;

    struct Counters
    {
        uint32 fresh = 0, hourLimit = 0, dayLimit = 0, bought = 0, bid = 0, lostRoll = 0, overCap = 0;
        uint32 cycles = 0, emptyCycles = 0;
    } _counters;
    time_t _countersLogged = 0;

    void RollWindows(time_t now)
    {
        if (!_dayStart || now - _dayStart >= DAY)
        {
            _dayStart = now;
            _spentToday = 0;
            _boughtToday = 0;
        }
        if (!_hourStart || now - _hourStart >= HOUR)
        {
            _hourStart = now;
            _boughtThisHour = 0;
        }
    }

    // Loot-only scrolls, potions, recipes and other drops carry a token vendor price (a scroll sells for a few copper),
    // so their fair price came out at 1 silver and the price cap at 4 silver: a player's listing at any normal price
    // was never bought, while crafted gear (real vendor value) sold. Give white and better consumables, recipes and
    // miscellaneous items a floor by item level (AuctionHouseBot.Buyer.DropFloorPerLevel copper per level).
    // Gray junk and trade goods (cloth, herbs, ore) keep their old value.
    uint64 DropFloor(ItemTemplate const* proto)
    {
        if (!_dropFloorPerLevel || proto->GetQuality() < ITEM_QUALITY_NORMAL)
            return 0;
        switch (proto->GetClass())
        {
            case ITEM_CLASS_CONSUMABLE:
            case ITEM_CLASS_RECIPE:
            case ITEM_CLASS_MISCELLANEOUS:
                break;
            default:
                return 0;
        }
        return uint64(std::max<uint32>(proto->GetBaseItemLevel(), 1)) * _dropFloorPerLevel;
    }

    // What the item is worth per unit: the vendor buy price, or four times the vendor sell price
    // (the same stand-in the seller uses when an item has no buy price).
    uint64 FairUnitPrice(ItemTemplate const* proto)
    {
        // a known market price is what the item is worth, also below 1 silver and below the stand-ins
        // (AuctionHouseBot.Vanilla.MarketPrices); the seller lists at the same price
        if (uint64 market = AuctionBotVanilla::MarketUnitPrice(proto))
            return market;

        uint64 buy = proto->GetBuyPrice() / std::max<uint32>(1, proto->GetBuyCount());
        uint64 sell = uint64(proto->GetSellPrice()) * 4;
        // the seller's market value when AuctionHouseBot.Vanilla.ValueCurve is on, so the buyer pays what the bot asks
        return std::max<uint64>({ buy, sell, AuctionBotVanilla::UnitValue(proto), SILVER, DropFloor(proto) });
    }

    // Items any vendor in the world sells for gold without a stock limit (npc_vendor maxcount 0, no extended cost). The buyer's
    // price never goes below the vendor's own (FairUnitPrice), and with the SILVER and drop floors it pays more than the vendor
    // asks for cheap goods: a player bought arrows, thread and reagents from vendors and sold them to the buyer, about 8000 gold
    // on one server (Discord 2026-11-18, Tasko). Limited-stock vendor items stay eligible. Only vendors with a spawn count.
    void BuildVendorItems()
    {
        _vendorItems.clear();
        std::unordered_set<uint32> spawned;
        for (auto const& [spawnId, data] : sObjectMgr->GetAllCreatureData())
            spawned.insert(data.id);

        for (uint32 entry : spawned)
        {
            VendorItemData const* items = sObjectMgr->GetNpcVendorItemList(entry);
            if (!items)
                continue;
            for (VendorItem const& item : items->m_items)
                if (item.Type == ITEM_VENDOR_TYPE_ITEM && !item.maxcount && !item.ExtendedCost)
                    _vendorItems.insert(item.item);
        }
    }

    void ParseExcludedItemIds()
    {
        _excludedItemIds.clear();
        std::string const list = sConfigMgr->GetStringDefault("AuctionHouseBot.Buyer.ExcludeItemIDs", "");
        for (std::string_view token : Trinity::Tokenize(list, ',', false))
        {
            while (!token.empty() && token.front() == ' ')
                token.remove_prefix(1);
            while (!token.empty() && token.back() == ' ')
                token.remove_suffix(1);
            if (Optional<uint32> itemId = Trinity::StringTo<uint32>(token); itemId && *itemId)
                _excludedItemIds.insert(*itemId);
            else if (!token.empty())
                TC_LOG_ERROR("server.loading", "AuctionHouseBot.Buyer.ExcludeItemIDs: '{}' is not an item id, ignored", token);
        }
    }
}

void LoadConfig()
{
    // AuctionHouseBot.Buyer.Commodities is the name the shipped settings use (zz-0-playerbot-defaults.conf).
    // AuctionHouseBot.Buyer.Stacks is the older name and only counts when Commodities is not set.
    _stacks = sConfigMgr->GetBoolDefault("AuctionHouseBot.Buyer.Commodities",
        sConfigMgr->GetBoolDefault("AuctionHouseBot.Buyer.Stacks", false, true), true);
    _maxPriceMultiplier = sConfigMgr->GetFloatDefault("AuctionHouseBot.Buyer.MaxPriceMultiplier", 0.0f);
    _minDelay = sConfigMgr->GetIntDefault("AuctionHouseBot.Buyer.MinDelay", 0);
    _maxDelay = std::max(_minDelay, uint32(sConfigMgr->GetIntDefault("AuctionHouseBot.Buyer.MaxDelay", 0)));
    _dailyBudget = uint64(sConfigMgr->GetIntDefault("AuctionHouseBot.Buyer.DailyBudgetGold", 0)) * GOLD;
    _maxBuysPerHour = sConfigMgr->GetIntDefault("AuctionHouseBot.Buyer.MaxBuysPerHour", 0);
    _fair = sConfigMgr->GetBoolDefault("AuctionHouseBot.Buyer.FairPricing", false);
    _fairMinChance = std::clamp(sConfigMgr->GetFloatDefault("AuctionHouseBot.Buyer.FairMinChance", 35.0f), 0.0f, 100.0f);
    _dropFloorPerLevel = sConfigMgr->GetIntDefault("AuctionHouseBot.Buyer.DropFloorPerLevel", 100);
    _excludeVendorItems = sConfigMgr->GetBoolDefault("AuctionHouseBot.Buyer.ExcludeUnlimitedVendorItems", true);
    if (_excludeVendorItems)
        BuildVendorItems();
    else
        _vendorItems.clear();
    ParseExcludedItemIds();
    TC_LOG_INFO("ahbot", "AHBot buyer: leaves alone {} unlimited vendor items and {} listed item ids", _vendorItems.size(), _excludedItemIds.size());

    TC_LOG_INFO("ahbot", "AHBot buyer: stackable items {}, fair pricing {}, price cap x{:.2f}, delay {}-{} s, max {} per hour, budget {}g a day, drop floor {} copper per item level",
        _stacks ? "on" : "off", _fair ? "on" : "off", _maxPriceMultiplier, _minDelay, _maxDelay, _maxBuysPerHour, _dailyBudget / GOLD, _dropFloorPerLevel);
}

bool Excluded(uint32 itemId)
{
    return _vendorItems.contains(itemId) || _excludedItemIds.contains(itemId);
}

bool StacksEnabled()
{
    return _stacks;
}

bool Eligible(AuctionPosting const* auction)
{
    time_t const now = GameTime::GetGameTime();
    RollWindows(now);

    if (_maxBuysPerHour && _boughtThisHour >= _maxBuysPerHour)
    {
        Note(Outcome::SkippedHourLimit);
        return false;
    }
    if (_dailyBudget && _spentToday >= _dailyBudget)
    {
        Note(Outcome::SkippedDayLimit);
        return false;
    }

    // Leave new listings alone for a while; the delay differs per listing but never changes for one.
    uint32 const span = _maxDelay - _minDelay;
    uint32 const delay = _minDelay + (span ? (auction->Id * 2654435761u) % (span + 1) : 0);
    if (now - time_t(std::chrono::duration_cast<Seconds>(auction->StartTime.time_since_epoch()).count()) >= time_t(delay))
        return true;
    Note(Outcome::SkippedFresh);
    return false;
}

void Note(Outcome outcome)
{
    switch (outcome)
    {
        case Outcome::SkippedFresh:     ++_counters.fresh; break;
        case Outcome::SkippedHourLimit: ++_counters.hourLimit; break;
        case Outcome::SkippedDayLimit:  ++_counters.dayLimit; break;
        case Outcome::Bought:           ++_counters.bought; break;
        case Outcome::Bid:              ++_counters.bid; break;
        case Outcome::LostRoll:         ++_counters.lostRoll; break;
        case Outcome::OverCap:          ++_counters.overCap; break;
    }
}

void NoteCycle(uint32 eligible)
{
    ++_counters.cycles;
    if (!eligible)
        ++_counters.emptyCycles;
}

void LogCounters()
{
    time_t const now = GameTime::GetGameTime();
    if (!_countersLogged)
        _countersLogged = now;
    if (now - _countersLogged < 10 * MINUTE)
        return;
    _countersLogged = now;

    Counters const c = _counters;
    _counters = Counters();
    uint32 const fail = c.lostRoll + c.overCap;
    TC_LOG_INFO("ahbot", "[ahbot] buyouts attempts={} ok={} fail={} (lost_roll={} over_cap={}) bids={} skipped(fresh={} hour_limit={} day_limit={}) cycles={} empty_cycles={}",
        c.bought + c.bid + fail, c.bought, fail, c.lostRoll, c.overCap, c.bid, c.fresh, c.hourLimit, c.dayLimit, c.cycles, c.emptyCycles);
}

bool FairPricingEnabled()
{
    return _fair;
}

bool RollFair(AuctionPosting const* auction, uint64 unitPrice, uint32 qualityChance)
{
    if (!unitPrice || auction->Items.empty())
        return false;

    uint64 const fair = FairUnitPrice(auction->Items[0]->GetTemplate());
    uint64 const cap = _maxPriceMultiplier > 0.0f ? uint64(fair * _maxPriceMultiplier) : fair * 3;

    float chance;
    if (unitPrice <= fair)
        chance = 100.0f;
    else if (unitPrice >= cap || cap <= fair)
        chance = unitPrice == cap ? _fairMinChance : 0.0f;
    else
        chance = 100.0f - (100.0f - _fairMinChance) * float(unitPrice - fair) / float(cap - fair);

    chance *= qualityChance / 100.0f;
    bool const win = frand(0.0f, 100.0f) < chance;
    TC_LOG_DEBUG("ahbot", "AHBot: fair roll {}: price {} fair {} cap {} chance {:.1f}% -> {}",
        auction->Items[0]->GetTemplate()->GetName(sWorld->GetDefaultDbcLocale()), unitPrice, fair, cap, chance, win ? "buy" : "pass");
    return win;
}

uint64 MaxUnitPrice(AuctionPosting const* auction)
{
    if (_maxPriceMultiplier <= 0.0f || auction->Items.empty())
        return 0;
    return uint64(FairUnitPrice(auction->Items[0]->GetTemplate()) * _maxPriceMultiplier);
}

uint64 PerItemPrice(AuctionPosting const* auction, uint64 price)
{
    if (auction->IsCommodity())
        return price;
    uint32 const count = auction->GetTotalItemCount();
    return count > 1 ? price / count : price;
}

uint64 TotalPrice(AuctionPosting const* auction, uint64 unitPrice)
{
    return auction->IsCommodity() ? unitPrice * auction->GetTotalItemCount() : unitPrice;
}

void RecordBuy(AuctionPosting const* auction, uint64 totalPrice, char const* house)
{
    RollWindows(GameTime::GetGameTime());
    _spentToday += totalPrice;
    ++_boughtToday;
    ++_boughtThisHour;

    TC_LOG_INFO("ahbot", "AHBot: buy {} x{} for {:.2f}g in {} (today: {} buys, {:.2f}g)",
        auction->Items[0]->GetTemplate()->GetName(sWorld->GetDefaultDbcLocale()), auction->GetTotalItemCount(),
        float(totalPrice) / float(GOLD), house, _boughtToday, float(_spentToday) / float(GOLD));
}

std::string Describe()
{
    return Trinity::StringFormat("AuctionHouseBot buyer today: {} buys, {:.2f}g spent (budget {}g, max {} per hour, price cap x{:.2f}, stacks {})",
        _boughtToday, float(_spentToday) / float(GOLD), _dailyBudget / GOLD, _maxBuysPerHour, _maxPriceMultiplier, _stacks ? "on" : "off");
}
}
