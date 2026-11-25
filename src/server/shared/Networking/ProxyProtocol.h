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

#ifndef TRINITYCORE_PROXY_PROTOCOL_H
#define TRINITYCORE_PROXY_PROTOCOL_H

#include "Define.h"
#include <boost/asio/ip/address.hpp>
#include <string>
#include <string_view>
#include <vector>

namespace Trinity::Net
{
enum class ProxyProtocolVersion
{
    Disabled,
    V1,
    V2
};

struct ProxyProtocolNetwork
{
    boost::asio::ip::address Address;
    uint8 PrefixLength = 0;

    bool Contains(boost::asio::ip::address const& address) const;
};

struct ProxyProtocolSettings
{
    ProxyProtocolVersion Version = ProxyProtocolVersion::Disabled;
    std::vector<ProxyProtocolNetwork> TrustedProxies;

    bool IsTrusted(boost::asio::ip::address const& address) const;
};

TC_SHARED_API bool InitializeProxyProtocolSettings();
TC_SHARED_API ProxyProtocolSettings const& GetProxyProtocolSettings();
TC_SHARED_API bool TryAcquireProxyProtocolHandshake();
TC_SHARED_API void ReleaseProxyProtocolHandshake();
}

#endif
