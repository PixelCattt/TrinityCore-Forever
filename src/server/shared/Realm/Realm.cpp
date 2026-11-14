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

#include "Realm.h"
#include "IpAddress.h"
#include "IpNetwork.h"
#include "StringFormat.h"
#include <boost/asio/io_context.hpp>
#include <boost/asio/ip/tcp.hpp>
#include <boost/asio/ip/udp.hpp>
#include <algorithm>
#include <cctype>
#include <chrono>
#include <mutex>
#include <unordered_map>

Realm::Realm() = default;
Realm::Realm(Realm const& other) = default;
Realm::Realm(Realm&& other) noexcept = default;
Realm& Realm::operator=(Realm const& other) = default;
Realm& Realm::operator=(Realm&& other) noexcept = default;
Realm::~Realm() = default;

void Realm::SetName(std::string name)
{
    Name = name;
    NormalizedName = std::move(name);
    std::erase_if(NormalizedName, [](char c) { return std::isspace(static_cast<unsigned char>(c)); });
}

namespace
{
// true when this machine owns the address: a UDP socket can be bound to it (port 0, nothing is sent)
bool IsAddressOnThisMachine(boost::asio::ip::address const& address)
{
    if (address.is_loopback() || address.is_unspecified())
        return true;
    boost::asio::io_context context;
    boost::asio::ip::udp::socket socket(context);
    boost::system::error_code error;
    socket.open(address.is_v4() ? boost::asio::ip::udp::v4() : boost::asio::ip::udp::v6(), error);
    if (error)
        return false;
    socket.bind(boost::asio::ip::udp::endpoint(address, 0), error);
    return !error;
}

// true when something accepts TCP connections on 127.0.0.1:port. Kept for a minute per port: a refused connect to
// 127.0.0.1 can take a second or two on Windows, and the realm list asks this for every loopback client.
bool IsListeningOnLoopback(uint16 port)
{
    using Clock = std::chrono::steady_clock;
    static std::mutex lock;
    static std::unordered_map<uint16, std::pair<Clock::time_point, bool>> cache;
    {
        std::scoped_lock guard(lock);
        auto itr = cache.find(port);
        if (itr != cache.end() && Clock::now() - itr->second.first < std::chrono::minutes(1))
            return itr->second.second;
    }
    boost::asio::io_context context;
    boost::asio::ip::tcp::socket socket(context);
    boost::system::error_code error;
    socket.connect(boost::asio::ip::tcp::endpoint(boost::asio::ip::address_v4::loopback(), port), error);
    bool listening = !error;
    socket.close(error);
    std::scoped_lock guard(lock);
    cache[port] = { Clock::now(), listening };
    return listening;
}
}

bool Realm::IsWorldServerOnThisMachine() const
{
    // the realmlist address or localAddress is this PC (127.0.0.1, or a network card of this PC)
    if (std::any_of(Addresses.begin(), Addresses.end(), IsAddressOnThisMachine))
        return true;
    // an address of a card that is gone now (the VPN turned off after the start): the world server still listens on
    // 127.0.0.1 here with BindIP 127.0.0.1 or 0.0.0.0
    return IsListeningOnLoopback(Port);
}

boost::asio::ip::address Realm::GetAddressForClient(boost::asio::ip::address const& clientAddr) const
{
    // A game on the server's own PC (or a friend coming in through the launcher's tunnel, which also arrives on this PC)
    // reaches the world server at 127.0.0.1: both BindIP settings the repack uses (127.0.0.1 and 0.0.0.0) listen there.
    // Picking a network address instead tied the login to whatever network card was up when the server started: with a VPN
    // on at start, the realm handed out the VPN's address and logins broke once the VPN was turned off.
    // Only when the world server is on this machine, though: with the auth server on one PC and the world server on another,
    // 127.0.0.1 pointed the game at a PC with no world server, so then the realmlist address/localAddress are used as normal.
    if (clientAddr.is_loopback() && IsWorldServerOnThisMachine())
        return boost::asio::ip::address_v4::loopback();

    if (auto addressIndex = Trinity::Net::SelectAddressForClient(clientAddr, Addresses))
        return Addresses[*addressIndex];

    if (Addresses.size() > 1 && clientAddr.is_loopback())
        return Addresses[1];

    return Addresses[0];
}

uint32 GetClassicSuperDistrictForContentSet(uint32 contentSetId)
{
    switch (contentSetId)
    {
        case 136: return 1; // PvP
        case 137: return 2; // Normal
        case 138: return 3; // Roleplay
        case 140: return 4; // Hardcore
        default:  return 0;
    }
}

uint32 GetClassicContentSetForSuperDistrict(uint32 superDistrictId)
{
    switch (superDistrictId)
    {
        case 1: return 136; // PvP
        case 2: return 137; // Normal
        case 3: return 138; // Roleplay
        case 4: return 140; // Hardcore
        default: return 0;
    }
}

uint32 Realm::GetConfigId() const
{
    return ConfigIdByType[Type];
}

uint32 const Realm::ConfigIdByType[MAX_CLIENT_REALM_TYPE] =
{
    1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14
};

std::string Battlenet::RealmHandle::GetAddressString() const
{
    return Trinity::StringFormat("{}-{}-{}", Region, Site, Realm);
}

std::string Battlenet::RealmHandle::GetSubRegionAddress() const
{
    // Classic (1.60+) "super realm" clients use the full realm address as sub-region (hard-coded 70-1-70)
    return Trinity::StringFormat("{}-{}-{}", Region, Site, Realm);
}
