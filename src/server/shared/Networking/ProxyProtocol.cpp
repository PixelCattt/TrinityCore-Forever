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

#include "ProxyProtocol.h"
#include "Config.h"
#include "Log.h"
#include <algorithm>
#include <atomic>
#include <string_view>

namespace Trinity::Net
{
namespace
{
ProxyProtocolSettings Settings;
std::atomic<uint32> PendingProxyProtocolHandshakes = 0;
constexpr uint32 MaxPendingProxyProtocolHandshakes = 1024;

bool AddressMatches(boost::asio::ip::address const& network, uint8 prefix, boost::asio::ip::address const& candidate)
{
    if (network.is_v4() != candidate.is_v4())
        return false;

    if (network.is_v4())
    {
        auto const left = network.to_v4().to_bytes();
        auto const right = candidate.to_v4().to_bytes();
        for (uint8 bit = 0; bit < prefix; ++bit)
            if ((left[bit / 8] & (0x80 >> (bit % 8))) != (right[bit / 8] & (0x80 >> (bit % 8))))
                return false;
    }
    else
    {
        auto const left = network.to_v6().to_bytes();
        auto const right = candidate.to_v6().to_bytes();
        for (uint8 bit = 0; bit < prefix; ++bit)
            if ((left[bit / 8] & (0x80 >> (bit % 8))) != (right[bit / 8] & (0x80 >> (bit % 8))))
                return false;
    }

    return true;
}

bool ParseNetwork(std::string_view value, ProxyProtocolNetwork& network)
{
    std::size_t const separator = value.find('/');
    std::string_view addressText = value.substr(0, separator);
    boost::system::error_code error;
    network.Address = boost::asio::ip::make_address(std::string(addressText), error);
    if (error)
        return false;

    unsigned int const maxPrefix = network.Address.is_v4() ? 32 : 128;
    unsigned int prefix = maxPrefix;
    if (separator != std::string_view::npos)
    {
        std::string_view prefixText = value.substr(separator + 1);
        if (prefixText.empty())
            return false;
        try
        {
            std::size_t parsed = 0;
            prefix = std::stoul(std::string(prefixText), &parsed);
            if (parsed != prefixText.size())
                return false;
        }
        catch (...)
        {
            return false;
        }
    }

    if (prefix > maxPrefix)
        return false;
    network.PrefixLength = static_cast<uint8>(prefix);
    return true;
}
}

bool ProxyProtocolNetwork::Contains(boost::asio::ip::address const& address) const
{
    return AddressMatches(Address, PrefixLength, address);
}

bool ProxyProtocolSettings::IsTrusted(boost::asio::ip::address const& address) const
{
    return std::ranges::any_of(TrustedProxies, [&address](ProxyProtocolNetwork const& network) { return network.Contains(address); });
}

bool InitializeProxyProtocolSettings()
{
    Settings = {};
    std::string const version = sConfigMgr->GetStringDefault("ProxyProtocol.Version", "");
    if (version.empty())
        return true;
    if (version == "v1")
        Settings.Version = ProxyProtocolVersion::V1;
    else if (version == "v2")
        Settings.Version = ProxyProtocolVersion::V2;
    else
    {
        TC_LOG_ERROR("server", "ProxyProtocol.Version must be empty, 'v1', or 'v2' (got '{}')", version);
        return false;
    }

    std::string const proxies = sConfigMgr->GetStringDefault("ProxyProtocol.TrustedProxies", "127.0.0.1,::1");
    std::size_t start = 0;
    while (start < proxies.size())
    {
        std::size_t const end = proxies.find(',', start);
        std::string value = proxies.substr(start, end == std::string::npos ? std::string::npos : end - start);
        value.erase(0, value.find_first_not_of(" \t"));
        if (std::size_t last = value.find_last_not_of(" \t"); last != std::string::npos)
            value.erase(last + 1);
        if (value.empty())
        {
            TC_LOG_ERROR("server", "ProxyProtocol.TrustedProxies contains an empty entry");
            return false;
        }
        ProxyProtocolNetwork network;
        if (!ParseNetwork(value, network))
        {
            TC_LOG_ERROR("server", "Invalid proxy network '{}' in ProxyProtocol.TrustedProxies", value);
            return false;
        }
        Settings.TrustedProxies.push_back(network);
        if (end == std::string::npos)
            break;
        start = end + 1;
        if (start == proxies.size())
        {
            TC_LOG_ERROR("server", "ProxyProtocol.TrustedProxies contains an empty entry");
            return false;
        }
    }

    if (Settings.TrustedProxies.empty())
    {
        TC_LOG_ERROR("server", "ProxyProtocol.TrustedProxies must contain at least one address when PROXY protocol is enabled");
        return false;
    }

    TC_LOG_INFO("server", "PROXY protocol {} enabled for {} trusted proxy network(s)", version, Settings.TrustedProxies.size());
    return true;
}

ProxyProtocolSettings const& GetProxyProtocolSettings()
{
    return Settings;
}

bool TryAcquireProxyProtocolHandshake()
{
    uint32 pending = PendingProxyProtocolHandshakes.load(std::memory_order_relaxed);
    while (pending < MaxPendingProxyProtocolHandshakes)
        if (PendingProxyProtocolHandshakes.compare_exchange_weak(pending, pending + 1, std::memory_order_acq_rel, std::memory_order_relaxed))
            return true;
    return false;
}

void ReleaseProxyProtocolHandshake()
{
    PendingProxyProtocolHandshakes.fetch_sub(1, std::memory_order_acq_rel);
}
}
