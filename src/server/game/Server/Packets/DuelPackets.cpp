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

#include "DuelPackets.h"
#include "PacketOperators.h"

namespace WorldPackets::Duel
{
void CanDuel::Read()
{
    _worldPacket >> TargetGUID;
    _worldPacket >> Bits<1>(ToTheDeath);
}

WorldPacket const* CanDuelResult::Write()
{
    _worldPacket << TargetGUID;
    _worldPacket << Bits<1>(Result);
    _worldPacket.FlushBits();

    return &_worldPacket;
}

WorldPacket const* DuelComplete::Write()
{
    _worldPacket << Bits<1>(Started);
    _worldPacket.FlushBits();

    return &_worldPacket;
}

WorldPacket const* DuelCountdown::Write()
{
    _worldPacket << uint32(Countdown);

    return &_worldPacket;
}

WorldPacket const* DuelRequested::Write()
{
    _worldPacket << ArbiterGUID;
    _worldPacket << RequestedByGUID;
    _worldPacket << RequestedByWowAccount;
    _worldPacket << Bits<1>(ToTheDeath);
    _worldPacket.FlushBits();

    return &_worldPacket;
}

void DuelResponse::Read()
{
    _worldPacket >> ArbiterGUID;
    _worldPacket >> Bits<1>(Accepted);
    _worldPacket >> Bits<1>(Forfeited);
}

WorldPacket const* DuelWinner::Write()
{
    // Classic 1.60 (live 70938 sniff, 2026-11-16): both names are zero-terminated strings with a 24 bit length that counts the
    // terminator, then the Fled bit, flush, both realms and the names. Retail sends 6 bit lengths without terminators, which this
    // client reads as part of a 24 bit length. The names are shown as written, so the caller passes "Name Surname".
    _worldPacket << SizedCString::BitsSize<24>(BeatenName);
    _worldPacket << SizedCString::BitsSize<24>(WinnerName);
    _worldPacket << Bits<1>(Fled);
    _worldPacket.FlushBits();
    _worldPacket << uint32(BeatenVirtualRealmAddress);
    _worldPacket << uint32(WinnerVirtualRealmAddress);
    _worldPacket << SizedCString::Data(BeatenName);
    _worldPacket << SizedCString::Data(WinnerName);

    return &_worldPacket;
}
}
