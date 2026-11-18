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

#include "AuctionHouseBotVanilla.h"
#include "Config.h"
#include "DatabaseEnv.h"
#include "ItemTemplate.h"
#include "Log.h"
#include "SharedDefines.h"
#include "Timer.h"
#include <algorithm>
#include <array>
#include <unordered_map>

namespace AuctionBotVanilla
{
namespace
{
    bool _enabled = false;
    int32 _maxReqLevel = 60;
    uint32 _maxItemLevel = 100;   // Naxxramas epics top out around 92
    bool _valueCurve = false;

    // copper per item level squared, by quality (gray .. epic); AuctionHouseBot.Vanilla.ValueCurve.Gray .. .Epic
    std::array<uint32, 5> QualityFactor = { 1, 2, 15, 50, 150 };
    // AuctionHouseBot.Vanilla.ValueCurve.Scale: one easy knob over the whole curve (1 = as set, 2 = double, 0.5 = half)
    float _scale = 1.0f;
    // AuctionHouseBot.Vanilla.ValueCurve.FullValueItemLevel: below this item level the curve scales down in proportion
    // (item level / this), so low-level goods are not priced like endgame ones (0 = off)
    uint32 _fullValueItemLevel = 0;

    // AuctionHouseBot.Vanilla.MarketPrices: per-unit market prices from the world table auctionhousebot_market_price
    bool _marketPrices = false;
    float _marketScale = 1.0f;
    std::unordered_map<uint32, uint64> _marketPrice;

    void LoadMarketPrices()
    {
        _marketPrice.clear();
        if (!_marketPrices)
            return;

        uint32 oldMSTime = getMSTime();
        PreparedQueryResult result = WorldDatabase.Query(WorldDatabase.GetPreparedStatement(WORLD_SEL_AUCTIONHOUSEBOT_MARKET_PRICES));
        if (!result)
        {
            TC_LOG_INFO("ahbot", "AHBot: AuctionHouseBot.Vanilla.MarketPrices is on but auctionhousebot_market_price is empty; "
                "item prices come from the value curve or the vendor price.");
            return;
        }

        do
        {
            Field* fields = result->Fetch();
            _marketPrice[fields[0].GetUInt32()] = fields[1].GetUInt64();
        } while (result->NextRow());

        TC_LOG_INFO("ahbot", "AHBot: loaded {} item market prices in {} ms", _marketPrice.size(), GetMSTimeDiffToNow(oldMSTime));
    }
}

void LoadConfig()
{
    _enabled = sConfigMgr->GetBoolDefault("AuctionHouseBot.Vanilla.Only", false);
    _maxReqLevel = sConfigMgr->GetIntDefault("AuctionHouseBot.Vanilla.MaxReqLevel", 60);
    _maxItemLevel = sConfigMgr->GetIntDefault("AuctionHouseBot.Vanilla.MaxItemLevel", 100);
    _valueCurve = sConfigMgr->GetBoolDefault("AuctionHouseBot.Vanilla.ValueCurve", false);
    QualityFactor[0] = sConfigMgr->GetIntDefault("AuctionHouseBot.Vanilla.ValueCurve.Gray", 1);
    QualityFactor[1] = sConfigMgr->GetIntDefault("AuctionHouseBot.Vanilla.ValueCurve.White", 2);
    QualityFactor[2] = sConfigMgr->GetIntDefault("AuctionHouseBot.Vanilla.ValueCurve.Green", 15);
    QualityFactor[3] = sConfigMgr->GetIntDefault("AuctionHouseBot.Vanilla.ValueCurve.Blue", 50);
    QualityFactor[4] = sConfigMgr->GetIntDefault("AuctionHouseBot.Vanilla.ValueCurve.Epic", 150);
    _scale = std::clamp(sConfigMgr->GetFloatDefault("AuctionHouseBot.Vanilla.ValueCurve.Scale", 1.0f), 0.1f, 10.0f);
    _fullValueItemLevel = sConfigMgr->GetIntDefault("AuctionHouseBot.Vanilla.ValueCurve.FullValueItemLevel", 0);
    _marketPrices = sConfigMgr->GetBoolDefault("AuctionHouseBot.Vanilla.MarketPrices", false);
    _marketScale = std::clamp(sConfigMgr->GetFloatDefault("AuctionHouseBot.Vanilla.MarketPrices.Scale", 1.0f), 0.1f, 10.0f);
    LoadMarketPrices();
}

bool Enabled()
{
    return _enabled;
}

bool IsAllowed(ItemTemplate const* proto)
{
    if (!_enabled)
        return true;

    // anything flagged for a later expansion
    if (proto->GetRequiredExpansion() > 0)
        return false;

    // no gems, glyphs or other post-classic classes
    switch (proto->GetClass())
    {
        case ITEM_CLASS_GEM:
        case ITEM_CLASS_GLYPH:
            return false;
        default:
            break;
    }

    // artifact/legendary and above are never sold by the bot
    if (proto->GetQuality() > ITEM_QUALITY_EPIC)
        return false;

    if (proto->GetBaseRequiredLevel() > _maxReqLevel)
        return false;

    if (proto->GetBaseItemLevel() > _maxItemLevel)
        return false;

    return true;
}

uint64 MarketUnitPrice(ItemTemplate const* proto)
{
    if (!_marketPrices)
        return 0;

    auto itr = _marketPrice.find(proto->GetId());
    if (itr == _marketPrice.end())
        return 0;

    // The only floor is what a vendor pays for the item (SellPrice is per item, ammo included): below it, buying from the
    // auction house and selling to a vendor would make money. The buy price and the 4x sell price are stand-ins for items
    // with no known price; live players list most cloth, leather, herbs and ore well below them (Linen Cloth 24c a piece,
    // its stand-in 55c), so using them here would throw the market price away for more than half of the items.
    return std::max<uint64>({ uint64(double(itr->second) * _marketScale), uint64(proto->GetSellPrice()), 1 });
}

void SetMarketPrices(std::unordered_map<uint32, uint64> prices, float scale)
{
    _marketPrices = !prices.empty();
    _marketScale = std::clamp(scale, 0.1f, 10.0f);
    _marketPrice = std::move(prices);
}

uint64 UnitValue(ItemTemplate const* proto)
{
    // a known market price wins over the curve
    if (uint64 market = MarketUnitPrice(proto))
        return market;

    if (!_valueCurve)
        return 0;

    // the 70532 data gives most loot-only goods a token vendor price (enchanting essences and shards: 1 copper),
    // so the vendor price alone lists them for a few copper
    uint64 vendor = std::max<uint64>(proto->GetBuyPrice() / std::max<uint32>(1, proto->GetBuyCount()), uint64(proto->GetSellPrice()) * 4);
    if (proto->GetClass() == ITEM_CLASS_PROJECTILE)
        vendor = proto->GetBuyPrice() / 200;   // ammo is bought in stacks of 200

    uint32 classPct = 0;
    switch (proto->GetClass())
    {
        case ITEM_CLASS_WEAPON:
        case ITEM_CLASS_ARMOR:
        case ITEM_CLASS_CONTAINER:
        case ITEM_CLASS_TRADE_GOODS:
            classPct = 100;
            break;
        case ITEM_CLASS_RECIPE:
        case ITEM_CLASS_MISCELLANEOUS:
            classPct = 50;
            break;
        case ITEM_CLASS_CONSUMABLE:
            classPct = 25;
            break;
        default:                        // ammo, reagents, quivers: vendor goods, vendor price
            break;
    }

    uint32 quality = std::min<uint32>(proto->GetQuality(), QualityFactor.size() - 1);
    uint64 itemLevel = proto->GetBaseItemLevel();
    double curve = double(itemLevel * itemLevel * QualityFactor[quality] * classPct / 100) * _scale;
    // Squared item level alone priced a level 14 green bracer at 1g (Discord 2026-11-12, dumpins); vanilla houses sold them for
    // a few tens of silver. Below the full value level the price falls with the item level once more.
    if (_fullValueItemLevel && itemLevel < _fullValueItemLevel)
        curve *= double(itemLevel) / double(_fullValueItemLevel);
    return std::max<uint64>(vendor, uint64(curve));
}
}
