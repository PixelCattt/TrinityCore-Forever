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

#ifndef TRINITYCORE_PROXY_PROTOCOL_CONNECTION_INITIALIZER_H
#define TRINITYCORE_PROXY_PROTOCOL_CONNECTION_INITIALIZER_H

#include "ProxyProtocol.h"
#include "Socket.h"
#include "DeadlineTimer.h"
#include <boost/asio/buffer.hpp>
#include <boost/asio/read.hpp>
#include <algorithm>
#include <array>
#include <atomic>
#include <chrono>
#include <memory>
#include <sstream>
#include <string>
#include <vector>

namespace Trinity::Net
{
template<class SocketImpl>
class ProxyProtocolConnectionInitializer final : public SocketConnectionInitializer
{
public:
    explicit ProxyProtocolConnectionInitializer(SocketImpl* socket) : _socket(socket) { }

    void Start() override
    {
        ProxyProtocolSettings const& settings = GetProxyProtocolSettings();
        if (settings.Version == ProxyProtocolVersion::Disabled)
        {
            InvokeNext();
            return;
        }

        if (!settings.IsTrusted(_socket->GetRemoteIpAddress()))
        {
            TC_LOG_ERROR("network", "Rejecting connection from {}: not a trusted PROXY protocol sender", _socket->GetRemoteIpAddress());
            _socket->CloseSocket();
            return;
        }

        if (!TryAcquireProxyProtocolHandshake())
        {
            TC_LOG_ERROR("network", "Rejecting connection from {}: too many pending PROXY protocol handshakes", _socket->GetRemoteIpAddress());
            _socket->CloseSocket();
            return;
        }
        _pendingSlot.store(true, std::memory_order_release);

        _timeout = std::make_unique<Trinity::Asio::DeadlineTimer>(TcpSocket().get_executor());
        _timeout->expires_after(std::chrono::seconds(10));
        _timeout->async_wait([socketRef = _socket->weak_from_this(), self = std::static_pointer_cast<ProxyProtocolConnectionInitializer>(shared_from_this())]
            (boost::system::error_code const& error)
            {
                if (error || self->_completed.exchange(true, std::memory_order_acq_rel))
                    return;

                self->ReleasePendingSlot();
                if (auto socketBase = socketRef.lock())
                {
                    std::shared_ptr<SocketImpl> socket = std::static_pointer_cast<SocketImpl>(socketBase);
                    TC_LOG_ERROR("network", "Closing {}: PROXY protocol header timed out", socket->GetRemoteIpAddress());
                    socket->CloseSocket();
                }
            });

        if (settings.Version == ProxyProtocolVersion::V1)
            ReadV1();
        else
            ReadV2Header();
    }

private:
    auto& TcpSocket()
    {
        auto& stream = _socket->underlying_stream();
        if constexpr (requires { stream.tcp_socket(); })
            return stream.tcp_socket();
        else
            return stream;
    }

    void ReadV1()
    {
        ReadV1Byte();
    }

    void ReadV1Byte()
    {
        boost::asio::async_read(TcpSocket(), boost::asio::buffer(&_v1Byte, sizeof(_v1Byte)),
            [socketRef = _socket->weak_from_this(), self = std::static_pointer_cast<ProxyProtocolConnectionInitializer>(shared_from_this())]
            (boost::system::error_code const& error, std::size_t)
            {
                auto socketBase = socketRef.lock();
                if (!socketBase)
                {
                    self->Abandon();
                    return;
                }
                std::shared_ptr<SocketImpl> socket = std::static_pointer_cast<SocketImpl>(socketBase);
                if (error)
                {
                    TC_LOG_ERROR("network", "Rejecting invalid PROXY v1 header from {}", socket->GetRemoteIpAddress());
                    self->Reject(socket);
                    return;
                }

                self->_line.push_back(static_cast<char>(self->_v1Byte));
                if (self->_line.size() > 108)
                {
                    self->Reject(socket);
                    return;
                }

                if (self->_line.ends_with("\r\n"))
                {
                    if (!self->ParseV1())
                    {
                        TC_LOG_ERROR("network", "Rejecting invalid PROXY v1 header from {}", socket->GetRemoteIpAddress());
                        self->Reject(socket);
                        return;
                    }
                    self->Continue();
                    return;
                }

                self->ReadV1Byte();
            });
    }

    bool ParseV1()
    {
        std::string_view header(_line);
        if (!header.starts_with("PROXY ") || !header.ends_with("\r\n"))
            return false;
        header.remove_prefix(6);
        header.remove_suffix(2);
        std::istringstream input{ std::string(header) };
        std::string protocol;
        input >> protocol;
        if (protocol == "UNKNOWN")
            return true;

        std::string source;
        std::string destination;
        unsigned int sourcePort = 0;
        unsigned int destinationPort = 0;
        std::string extra;
        if ((protocol != "TCP4" && protocol != "TCP6") || !(input >> source >> destination >> sourcePort >> destinationPort) || (input >> extra)
            || sourcePort > 65535 || destinationPort > 65535)
            return false;

        boost::system::error_code error;
        boost::asio::ip::address address = boost::asio::ip::make_address(source, error);
        if (error || (protocol == "TCP4" && !address.is_v4()) || (protocol == "TCP6" && !address.is_v6()))
            return false;
        _socket->SetRemoteEndpoint({ address, static_cast<uint16>(sourcePort) });
        return true;
    }

    void ReadV2Header()
    {
        boost::asio::async_read(TcpSocket(), boost::asio::buffer(_v2Header),
            [socketRef = _socket->weak_from_this(), self = std::static_pointer_cast<ProxyProtocolConnectionInitializer>(shared_from_this())]
            (boost::system::error_code const& error, std::size_t)
            {
                auto socketBase = socketRef.lock();
                if (!socketBase)
                {
                    self->Abandon();
                    return;
                }
                std::shared_ptr<SocketImpl> socket = std::static_pointer_cast<SocketImpl>(socketBase);
                if (error || !self->ValidV2Header())
                {
                    TC_LOG_ERROR("network", "Rejecting invalid PROXY v2 header from {}", socket->GetRemoteIpAddress());
                    self->Reject(socket);
                    return;
                }
                self->ReadV2Payload();
            });
    }

    bool ValidV2Header() const
    {
        static constexpr std::array<uint8, 12> Signature = { 0x0D, 0x0A, 0x0D, 0x0A, 0x00, 0x0D, 0x0A, 0x51, 0x55, 0x49, 0x54, 0x0A };
        return std::equal(Signature.begin(), Signature.end(), _v2Header.begin())
            && (_v2Header[12] >> 4) == 2 && (_v2Header[12] & 0x0F) <= 1;
    }

    void ReadV2Payload()
    {
        uint16 const length = static_cast<uint16>((_v2Header[14] << 8) | _v2Header[15]);
        _v2PayloadRemaining = length;

        if ((_v2Header[12] & 0x0F) == 0 || _v2Header[13] == 0x00)
        {
            SkipV2Payload();
            return;
        }

        uint8 const family = _v2Header[13];
        if (family == 0x11)
            _v2AddressLength = 12;
        else if (family == 0x21)
            _v2AddressLength = 36;
        else
        {
            Reject();
            return;
        }

        if (_v2PayloadRemaining < _v2AddressLength)
        {
            Reject();
            return;
        }

        boost::asio::async_read(TcpSocket(), boost::asio::buffer(_v2Address.data(), _v2AddressLength),
            [socketRef = _socket->weak_from_this(), self = std::static_pointer_cast<ProxyProtocolConnectionInitializer>(shared_from_this())]
            (boost::system::error_code const& error, std::size_t)
            {
                auto socketBase = socketRef.lock();
                if (!socketBase)
                {
                    self->Abandon();
                    return;
                }
                std::shared_ptr<SocketImpl> socket = std::static_pointer_cast<SocketImpl>(socketBase);
                if (error || !self->SetV2RemoteEndpoint())
                {
                    TC_LOG_ERROR("network", "Rejecting invalid PROXY v2 address from {}", socket->GetRemoteIpAddress());
                    self->Reject(socket);
                    return;
                }
                self->_v2PayloadRemaining -= self->_v2AddressLength;
                self->SkipV2Payload();
            });
    }

    bool SetV2RemoteEndpoint()
    {
        uint8 const family = _v2Header[13];
        if (family == 0x11 && _v2AddressLength == 12)
        {
            boost::asio::ip::address_v4::bytes_type addressBytes;
            std::copy_n(_v2Address.begin(), 4, addressBytes.begin());
            uint16 const port = static_cast<uint16>((_v2Address[8] << 8) | _v2Address[9]);
            _socket->SetRemoteEndpoint({ boost::asio::ip::address_v4(addressBytes), port });
            return true;
        }
        if (family == 0x21 && _v2AddressLength == 36)
        {
            boost::asio::ip::address_v6::bytes_type addressBytes;
            std::copy_n(_v2Address.begin(), 16, addressBytes.begin());
            uint16 const port = static_cast<uint16>((_v2Address[32] << 8) | _v2Address[33]);
            _socket->SetRemoteEndpoint({ boost::asio::ip::address_v6(addressBytes), port });
            return true;
        }
        return false;
    }

    void SkipV2Payload()
    {
        if (!_v2PayloadRemaining)
        {
            Continue();
            return;
        }

        std::size_t const chunkSize = std::min<std::size_t>(_v2PayloadRemaining, _v2DiscardBuffer.size());
        boost::asio::async_read(TcpSocket(), boost::asio::buffer(_v2DiscardBuffer.data(), chunkSize),
            [socketRef = _socket->weak_from_this(), self = std::static_pointer_cast<ProxyProtocolConnectionInitializer>(shared_from_this()), chunkSize]
            (boost::system::error_code const& error, std::size_t)
            {
                auto socketBase = socketRef.lock();
                if (!socketBase)
                {
                    self->Abandon();
                    return;
                }
                std::shared_ptr<SocketImpl> socket = std::static_pointer_cast<SocketImpl>(socketBase);
                if (error)
                {
                    TC_LOG_ERROR("network", "Rejecting incomplete PROXY v2 payload from {}", socket->GetRemoteIpAddress());
                    self->Reject(socket);
                    return;
                }

                self->_v2PayloadRemaining -= static_cast<uint16>(chunkSize);
                self->SkipV2Payload();
            });
    }

    void Continue()
    {
        if (_completed.exchange(true, std::memory_order_acq_rel))
            return;
        if (_timeout)
            _timeout->cancel();
        ReleasePendingSlot();
        InvokeNext();
    }

    void Reject(std::shared_ptr<SocketImpl> const& socket = {})
    {
        if (_completed.exchange(true, std::memory_order_acq_rel))
            return;
        if (_timeout)
            _timeout->cancel();
        ReleasePendingSlot();
        if (socket)
            socket->CloseSocket();
        else
            _socket->CloseSocket();
    }

    void Abandon()
    {
        if (_completed.exchange(true, std::memory_order_acq_rel))
            return;
        if (_timeout)
            _timeout->cancel();
        ReleasePendingSlot();
    }

    void ReleasePendingSlot()
    {
        if (_pendingSlot.exchange(false, std::memory_order_acq_rel))
            ReleaseProxyProtocolHandshake();
    }

    SocketImpl* _socket;
    std::string _line;
    uint8 _v1Byte = 0;
    std::array<uint8, 16> _v2Header{};
    std::array<uint8, 36> _v2Address{};
    std::array<uint8, 512> _v2DiscardBuffer{};
    uint16 _v2PayloadRemaining = 0;
    std::size_t _v2AddressLength = 0;
    std::unique_ptr<Trinity::Asio::DeadlineTimer> _timeout;
    std::atomic_bool _pendingSlot = false;
    std::atomic_bool _completed = false;
};
}

#endif
