#include "tc_catch2.h"
#include "IpAddress.h"
#include "Realm.h"
#include <boost/asio/io_context.hpp>
#include <boost/asio/ip/tcp.hpp>

namespace
{
boost::asio::ip::address Addr(char const* text)
{
    boost::system::error_code error;
    return Trinity::Net::make_address(text, error);
}

// a port on 127.0.0.1 that nothing listens on (taken from the system, then let go)
uint16 ClosedLoopbackPort()
{
    boost::asio::io_context context;
    boost::asio::ip::tcp::acceptor acceptor(context, boost::asio::ip::tcp::endpoint(boost::asio::ip::address_v4::loopback(), 0));
    uint16 port = acceptor.local_endpoint().port();
    acceptor.close();
    return port;
}
}

TEST_CASE("A game on the server PC gets 127.0.0.1 when the realm address is this PC", "[RealmLoopback]")
{
    Realm realm;
    realm.Addresses = { Addr("127.0.0.1") };
    realm.Port = ClosedLoopbackPort();
    CHECK(realm.GetAddressForClient(Addr("127.0.0.1")) == boost::asio::ip::address_v4::loopback());
}

TEST_CASE("With the world server on another PC a local game gets the realmlist address", "[RealmLoopback]")
{
    // 203.0.113.5 is a documentation address: no card of this PC has it, and nothing listens on the port here
    Realm realm;
    realm.Addresses = { Addr("203.0.113.5") };
    realm.Port = ClosedLoopbackPort();
    CHECK(realm.GetAddressForClient(Addr("127.0.0.1")) == Addr("203.0.113.5"));

    // with a localAddress too, the loopback client gets the localAddress, as before the 0.1.30 change
    Realm lan;
    lan.Addresses = { Addr("203.0.113.5"), Addr("203.0.113.6") };
    lan.Port = ClosedLoopbackPort();
    CHECK(lan.GetAddressForClient(Addr("127.0.0.1")) == Addr("203.0.113.6"));
}

TEST_CASE("A realm address that is gone (VPN off) still gives 127.0.0.1 while the world server listens here", "[RealmLoopback]")
{
    boost::asio::io_context context;
    boost::asio::ip::tcp::acceptor acceptor(context, boost::asio::ip::tcp::endpoint(boost::asio::ip::address_v4::loopback(), 0));
    Realm realm;
    realm.Addresses = { Addr("203.0.113.7") };
    realm.Port = acceptor.local_endpoint().port();
    CHECK(realm.GetAddressForClient(Addr("127.0.0.1")) == boost::asio::ip::address_v4::loopback());
}

TEST_CASE("A client from the network is not changed by the loopback rule", "[RealmLoopback]")
{
    Realm realm;
    realm.Addresses = { Addr("203.0.113.5") };
    realm.Port = ClosedLoopbackPort();
    CHECK(realm.GetAddressForClient(Addr("198.51.100.20")) == Addr("203.0.113.5"));
}
