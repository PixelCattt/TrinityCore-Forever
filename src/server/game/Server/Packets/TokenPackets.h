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

#ifndef TRINITYCORE_TOKEN_PACKETS_H
#define TRINITYCORE_TOKEN_PACKETS_H

#include "Optional.h"
#include "Packet.h"
#include "PacketUtilities.h"
#include "ObjectGuid.h"
#include "Optional.h"
#include <array>

namespace WorldPackets
{
    namespace Token
    {
        class CommerceTokenGetLog final : public ClientPacket
        {
        public:
            explicit CommerceTokenGetLog(WorldPacket&& packet) : ClientPacket(CMSG_COMMERCE_TOKEN_GET_LOG, std::move(packet)) { }

            void Read() override;

            uint32 ClientToken   = 0;
        };

        class CommerceTokenGetLogResponse final : public ServerPacket
        {
        public:
            explicit CommerceTokenGetLogResponse() : ServerPacket(SMSG_COMMERCE_TOKEN_GET_LOG_RESPONSE, 12) { }

            WorldPacket const* Write() override;

            struct AuctionableTokenInfo
            {
                uint64 Id           = 0;
                Timestamp<> LastUpdate;
                int32 Status        = 0;
                uint64 Price        = 0;
                uint32 DurationLeft = 0;
            };

            uint32 ClientToken      = 0;
            uint32 Result           = 0;
            std::vector<AuctionableTokenInfo> AuctionableTokens;
        };

        class CommerceTokenGetMarketPrice final : public ClientPacket
        {
        public:
            explicit CommerceTokenGetMarketPrice(WorldPacket&& packet) : ClientPacket(CMSG_COMMERCE_TOKEN_GET_MARKET_PRICE, std::move(packet)) { }

            void Read() override;

            uint32 ClientToken = 0;
        };

        class CommerceTokenGetMarketPriceResponse final : public ServerPacket
        {
        public:
            explicit CommerceTokenGetMarketPriceResponse() : ServerPacket(SMSG_COMMERCE_TOKEN_GET_MARKET_PRICE_RESPONSE, 20) { }

            WorldPacket const* Write() override;

            uint32 ClientToken              = 0;
            int32 Result                    = 0;
            uint64 Price                    = 0;
            uint32 ExpectedSecondsUntilSold = 0;
        };
    }

    // Classic 1.60 in-game Store (legacy StoreFrame, used while the mirror var shop2Enabled is 0). Layouts read from the client
    // readers (70291 product list decoder 0x8287b0, deliverable 0x91e130, purchase 0x91e530, distribution 0x91e650; 70338
    // product 0x91b440, display info 0x91a6d0).
    namespace BattlePay
    {
        struct DisplayCard
        {
            std::string Title;                  // 10 bit length
            uint32 CreatureDisplayInfoID = 0;
            uint32 ModelSceneID = 0;
            uint32 TransmogSetID = 0;
        };

        struct DisplayInfo
        {
            Optional<uint32> FileDataID;        // icon / card texture
            Optional<uint32> ModelSceneID;
            std::string Name1;                  // title, 10 bit length
            std::string Name2;                  // 10 bit length
            std::string Name3;                  // description, 13 bit length
            std::string Tooltip;                // 13 bit length
            std::string Instructions;           // 13 bit length
            std::string Disclaimer;             // 13 bit length
            std::string NydusLink;              // 12 bit length
            Optional<uint32> Flags;
            Optional<uint32> OverrideTextColor;
            Optional<uint32> OverrideTexture;
            Optional<uint32> OverrideBackground;
            int32 CardType = 0;
            int32 BannerType = 0;
            int32 ItemQuantity = 0;
            std::vector<DisplayCard> Cards;
        };

        struct Deliverable
        {
            uint32 DeliverableID = 0;
            int32 Type = 0;
            uint32 ItemID = 0;
            uint32 Quantity = 0;
            uint32 MountSpellID = 0;
            uint32 BattlePetCreatureID = 0;
            int32 BoostID = 0;
            int32 Flags = 0;
            uint32 TransmogItemModifiedAppearanceID = 0;
            uint32 TransmogSetID = 0;
            uint32 CharTitleID = 0;
            uint32 SpellItemEnchantmentID = 0;
            uint32 WarbandSceneID = 0;
            std::string Name;                   // 8 bit length
            bool AlreadyOwns = false;
            Optional<DisplayInfo> Display;
        };

        struct Product
        {
            uint32 ProductID = 0;
            uint64 NormalPriceFixedPoint = 0;
            uint64 CurrentPriceFixedPoint = 0;
            int32 Type = 0;
            int32 Flags = 0;                    // 0x1 visible / 0x2 buyable in one client context, 0x4 / 0x8 in the other
            uint32 RequiredDeliverableID = 0;
            int32 Eligibility = 0;
            uint64 PmtProductID = 0;
            std::vector<uint32> DeliverableIDs;
            std::vector<uint32> BundledProductIDs;
            Optional<DisplayInfo> Display;
        };

        struct ProductGroup
        {
            uint32 GroupID = 0;
            int32 IconFileDataID = 0;
            uint8 DisplayType = 0;
            int32 Ordering = 0;
            int32 Flags = 0;
            uint32 ParentGroupID = 0;
            std::string Name;                   // 8 bit length
            std::string DisabledDescription;    // 24 bit length, sent with its '\0'
        };

        struct ShopEntry
        {
            uint32 EntryID = 0;
            uint32 GroupID = 0;
            uint32 ProductID = 0;
            int32 Ordering = 0;
            int32 Flags = 0;
            uint8 BannerType = 0;
            Optional<DisplayInfo> Display;
        };

        class ProductListResponse final : public ServerPacket
        {
        public:
            explicit ProductListResponse() : ServerPacket(SMSG_BATTLE_PAY_GET_PRODUCT_LIST_RESPONSE, 24) { }

            WorldPacket const* Write() override;

            int32 Result = 0;                   // official sends 2 while its store is off
            uint32 CurrencyID = 0;
            std::vector<Product> Products;
            std::vector<Deliverable> Deliverables;
            std::vector<ProductGroup> Groups;
            std::vector<ShopEntry> Entries;
        };

        struct Purchase
        {
            uint64 PurchaseID = 0;
            int32 Status = 0;                   // 0 asserts in the client; 6 = finished (HasPurchaseInProgress 70291 0x1af9ed0)
            int32 ResultCode = 0;               // 0 = ok; anything else fires the purchase error event
            uint32 ProductID = 0;
            uint64 BasePrice = 0;               // fixed point; 0 and 0 = the product's prices
            uint64 UserPrice = 0;
            int64 TimeCreated = 0;
            std::string WalletName;             // 8 bit length, shown as payment method in the confirmation
        };

        class PurchaseListResponse final : public ServerPacket
        {
        public:
            explicit PurchaseListResponse() : ServerPacket(SMSG_BATTLE_PAY_GET_PURCHASE_LIST_RESPONSE, 8) { }

            WorldPacket const* Write() override;

            int32 Result = 0;
            std::vector<Purchase> Purchases;
        };

        class PurchaseUpdate final : public ServerPacket
        {
        public:
            explicit PurchaseUpdate() : ServerPacket(SMSG_BATTLE_PAY_PURCHASE_UPDATE, 4 + 60) { }

            WorldPacket const* Write() override;

            std::vector<Purchase> Purchases;
        };

        class StartPurchase final : public ClientPacket
        {
        public:
            explicit StartPurchase(WorldPacket&& packet) : ClientPacket(CMSG_BATTLE_PAY_START_PURCHASE, std::move(packet)) { }

            void Read() override;

            uint32 ClientToken = 0;
            uint32 ProductID = 0;
            ObjectGuid TargetCharacter;         // character chosen at character select, empty in game
            uint32 Unknown = 0;
            std::string Unknown1;               // 6 bit length
            std::string Unknown2;               // 12 bit length
            std::string Unknown3;               // 7 bit length
        };

        class StartPurchaseResponse final : public ServerPacket
        {
        public:
            explicit StartPurchaseResponse() : ServerPacket(SMSG_BATTLE_PAY_START_PURCHASE_RESPONSE, 16) { }

            WorldPacket const* Write() override;

            int32 PurchaseResult = 0;           // 0 = ok
            uint32 ClientToken = 0;
            uint64 PurchaseID = 0;              // must match the CONFIRM_PURCHASE that follows
        };

        class ConfirmPurchase final : public ServerPacket
        {
        public:
            explicit ConfirmPurchase() : ServerPacket(SMSG_BATTLE_PAY_CONFIRM_PURCHASE, 12) { }

            WorldPacket const* Write() override;

            uint64 PurchaseID = 0;              // the purchase (sent before in PURCHASE_UPDATE) the client shows for confirmation
            uint32 ServerToken = 0;
        };

        class ConfirmPurchaseResponse final : public ClientPacket
        {
        public:
            explicit ConfirmPurchaseResponse(WorldPacket&& packet) : ClientPacket(CMSG_BATTLE_PAY_CONFIRM_PURCHASE_RESPONSE, std::move(packet)) { }

            void Read() override;

            uint32 ServerToken = 0;
            uint64 ClientCurrentPriceFixedPoint = 0;
            bool ConfirmPurchase = false;
        };

        // a product the account owns but has not used yet (boost, character service token); reader 70291 0x91e650.
        // Character screen service token (70058 0x24273C0): Status 1, not revoked, no manual review, deliverable Flags 0x400 and
        // deliverable Type 11 paid transfer / 6 faction / 8 race / 5 name / 25 free transfer / 39 hardcore transfer.
        struct DistributionObject
        {
            uint64 DistributionID = 0;
            int32 Status = 1;
            uint32 DeliverableID = 0;
            ObjectGuid LicenseGameAccountGUID;
            ObjectGuid TargetPlayer;
            uint32 TargetNativeRealm = 0;
            uint32 TargetVirtualRealm = 0;
            uint64 PurchaseID = 0;
            uint32 ManualReview = 0;
            Optional<Deliverable> Product;
            bool Revoked = false;
        };

        class DistributionListResponse final : public ServerPacket
        {
        public:
            explicit DistributionListResponse() : ServerPacket(SMSG_BATTLE_PAY_GET_DISTRIBUTION_LIST_RESPONSE, 6) { }

            WorldPacket const* Write() override;

            int32 Result = 0;
            std::vector<DistributionObject> Distributions;
        };

        // client asks for the characters (and target realms) of the Store's character service window; Classic 0x440120 / 0x440121
        // (writers 70058 0x8C1E70 / 0x8C1EC0), field meaning not known yet
        class GetVasAccountCharacterList final : public ClientPacket
        {
        public:
            explicit GetVasAccountCharacterList(WorldPacket&& packet) : ClientPacket(CMSG_GET_VAS_ACCOUNT_CHARACTER_LIST, std::move(packet)) { }

            void Read() override;

            uint32 Unknown1 = 0;
            int32 Unknown2 = 0;
        };

        class GetVasTransferTargetRealmList final : public ClientPacket
        {
        public:
            explicit GetVasTransferTargetRealmList(WorldPacket&& packet) : ClientPacket(CMSG_GET_VAS_TRANSFER_TARGET_REALM_LIST, std::move(packet)) { }

            void Read() override;

            uint32 Unknown1 = 0;
            int32 Unknown2 = 0;
        };

        struct VasCharacter
        {
            ObjectGuid Guid;
            ObjectGuid WowAccountGuid;
            uint32 VirtualRealmAddress = 0;     // the Store window groups characters into realms by this
            int8 Race = 0;
            int8 Class = 0;
            int8 Sex = 0;
            uint8 Level = 0;
            std::string Name;                   // 6 bit length
            std::string RealmName;              // 9 bit length
        };

        // reader 70338 0x82F830, handler 0x2E38A20: ignored unless ClientToken is the request's; Result 0 = ok
        class GetVasAccountCharacterListResult final : public ServerPacket
        {
        public:
            explicit GetVasAccountCharacterListResult() : ServerPacket(SMSG_GET_VAS_ACCOUNT_CHARACTER_LIST_RESULT, 16) { }

            WorldPacket const* Write() override;

            uint32 ClientToken = 0;
            int32 Result = 0;
            int32 Unknown = 0;                  // echo of the request (0 Store, 26 hardcore transfer token)
            std::vector<VasCharacter> Characters;
        };

        // the Store's character service window's purchase (writer 70058 0x8C1F10; captured: token, product 30, character, realm 70,
        // realm 71, 3 empty guids, "" "" "" "win" json)
        class StartVasPurchase final : public ClientPacket
        {
        public:
            explicit StartVasPurchase(WorldPacket&& packet) : ClientPacket(CMSG_BATTLE_PAY_START_VAS_PURCHASE, std::move(packet)) { }

            void Read() override;

            uint32 ClientToken = 0;
            uint32 ProductID = 0;
            ObjectGuid Character;
            uint32 CharacterRealmAddress = 0;
            uint32 DestinationRealmAddress = 0;
            std::array<ObjectGuid, 3> Guids;    // destination account etc. (empty so far)
            std::string NewName;                // 6 bit length
            std::string GuildName1;             // 7 bit length
            std::string GuildName2;             // 7 bit length
            std::string Platform;               // 6 bit length
            std::string Fingerprint;            // 12 bit length
            bool Unknown = false;
        };

        // handler 70338 0x2E3A160: fires STORE_VAS_PURCHASE_COMPLETE (product ready / purchase sent screen); field meanings inferred
        class VasPurchaseComplete final : public ServerPacket
        {
        public:
            explicit VasPurchaseComplete() : ServerPacket(SMSG_VAS_PURCHASE_COMPLETE, 40) { }

            WorldPacket const* Write() override;

            uint32 ProductID = 0;
            uint32 Unknown = 0;                 // 0 (non 0 with product 0 sets another client flag)
            ObjectGuid Character;
            ObjectGuid Guid2;
            uint32 DestinationRealmAddress = 0;
            ObjectGuid Guid3;
            std::string Name;                   // 6 bit length
            std::string RealmName;              // 9 bit length
        };

        // the Store's transfer window asks after a character is picked and waits for the answer before it shows the target realm box
        class RequestCharacterGuildFollowInfo final : public ClientPacket
        {
        public:
            explicit RequestCharacterGuildFollowInfo(WorldPacket&& packet) : ClientPacket(CMSG_REQUEST_CHARACTER_GUILD_FOLLOW_INFO, std::move(packet)) { }

            void Read() override;

            ObjectGuid Character;
            uint32 VirtualRealmAddress = 0;
        };

        // reader in the 70058 guild message switch; fires STORE_GUILD_FOLLOW_INFO_RECEIVED
        class QueryGuildFollowInfoResponse final : public ServerPacket
        {
        public:
            explicit QueryGuildFollowInfoResponse() : ServerPacket(SMSG_QUERY_GUILD_FOLLOW_INFO_RESPONSE, 20) { }

            WorldPacket const* Write() override;

            ObjectGuid Character;
            bool HasInfo = false;               // guild of the character (not sent: no guild to follow)
        };

        struct VasTransferTargetRealm
        {
            uint32 RealmAddress = 0;            // name guessed
            std::array<int32, 5> Unknown = { };
            std::string Name;                   // 9 bit length
        };

        // reader 70291 0x8320F0, field names not known yet
        class GetVasTransferTargetRealmListResult final : public ServerPacket
        {
        public:
            explicit GetVasTransferTargetRealmListResult() : ServerPacket(SMSG_GET_VAS_TRANSFER_TARGET_REALM_LIST_RESULT, 16) { }

            WorldPacket const* Write() override;

            uint32 Unknown1 = 0;
            int32 Unknown2 = 0;
            int32 Unknown3 = 0;
            std::vector<VasTransferTargetRealm> Realms;
        };

        // only the client token is read; the rest of the message is kept in the packet log until its layout is known
        class DistributionAssignVas final : public ClientPacket
        {
        public:
            explicit DistributionAssignVas(WorldPacket&& packet) : ClientPacket(CMSG_BATTLE_PAY_DISTRIBUTION_ASSIGN_VAS, std::move(packet)) { }

            void Read() override;

            uint32 ClientToken = 0;
            uint64 DistributionID = 0;
            ObjectGuid Character;
            uint32 SourceRealmAddress = 0;      // name guessed
            uint32 Unknown1 = 0;
            int32 DesiredSuperDistrictID = 0;   // hardcore transfer destination ruleset (name guessed)
            std::array<ObjectGuid, 3> Guids;
            std::array<uint8, 3> Unknown2 = { };
            uint32 Unknown3 = 0;
            std::vector<std::pair<uint32, uint32>> Pairs;
            std::array<std::string, 4> Strings; // 6, 9, 7, 7 bit lengths
            std::array<bool, 3> Flags = { };    // one is probably "validation only"
        };

        // character boost used on a character (writer 70058; ProductChoice = the chosen spec, inferred)
        class DistributionAssignToTarget final : public ClientPacket
        {
        public:
            explicit DistributionAssignToTarget(WorldPacket&& packet) : ClientPacket(CMSG_BATTLE_PAY_DISTRIBUTION_ASSIGN_TO_TARGET, std::move(packet)) { }

            void Read() override;

            uint32 ClientToken = 0;
            uint64 DistributionID = 0;
            ObjectGuid TargetCharacter;
            uint32 ProductChoice = 0;
        };

        // handler 70338 0x2E3A7F0: Result != 0 raises the error event with that code
        class StartDistributionAssignToTargetResponse final : public ServerPacket
        {
        public:
            explicit StartDistributionAssignToTargetResponse() : ServerPacket(SMSG_BATTLE_PAY_START_DISTRIBUTION_ASSIGN_TO_TARGET_RESPONSE, 16) { }

            WorldPacket const* Write() override;

            int32 Result = 0;
            uint32 ClientToken = 0;
            uint64 DistributionID = 0;
        };

        class DistributionUpdate final : public ServerPacket
        {
        public:
            explicit DistributionUpdate() : ServerPacket(SMSG_BATTLE_PAY_DISTRIBUTION_UPDATE, 64) { }

            WorldPacket const* Write() override;

            DistributionObject Distribution;
        };

        // SMSG_CHARACTER_UPGRADE_STARTED / _COMPLETE / _ABORTED: just the character
        class CharacterUpgradeState final : public ServerPacket
        {
        public:
            explicit CharacterUpgradeState(OpcodeServer opcode) : ServerPacket(opcode, 18) { }

            WorldPacket const* Write() override;

            ObjectGuid Character;
        };

        // ASSIGN_VAS_RESPONSE event: both results 0 = the service was assigned
        class DistributionAssignVasResponse final : public ServerPacket
        {
        public:
            explicit DistributionAssignVasResponse() : ServerPacket(SMSG_BATTLE_PAY_DISTRIBUTION_ASSIGN_VAS_RESPONSE, 12) { }

            WorldPacket const* Write() override;

            uint32 ClientToken = 0;
            int32 StoreError = 0;
            int32 VasPurchaseResult = 0;
        };
    }
}

#endif // TRINITYCORE_TOKEN_PACKETS_H
