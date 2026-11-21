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

// Classic 1.60 (WoW Forever): the rogue jobs of "C" at the Dead Drop (410369) near Pyrewood Village, Silverpine Forest.
//
//   The Horn of Xelthos (78261, level 20+): alone in Shadowfang Keep, get past the Courtyard Door (Breaching Charge from Veenix,
//   Goblin Lockpicks 78270, or the prisoners), pickpocket the twins Gemela (Sister's Half-Key) and Gefell (Brother's Half-Key),
//   combine them into the Twin Key and open the Ornamented Chest in the stables. After the hand-in, the next visit to a capital
//   brings word from C and the payment (78307, Pyrewood Signet Ring) waits in the Dead Drop.
//
//   The Eye of Bhossca (78676): alone in the Scarlet Monastery, with the Scarlet Initiate's Uniform from the Supply Locker in the
//   monastery stables. Pickpocket a Scarlet Scryer (Scryer's Key), open the Personal Letterbox in the Library (Confidential
//   Message), sit on the two benches between the statues of the Graveyard (a click each, then stone moving), loot the Reliquary
//   Key from the Stone Coffer in the northern mausoleum and the Eye from the Padlocked Reliquary in the Library. Payment again
//   after a capital visit (78699, Ruby-Adorned Blade).
//
// Sources: quest and item records from the live game (EG Link), the steps as players describe them on Wowhead (WoW Forever) and
// QuestieDB, item and spell records on Wowhead (Breach Gate 425067: Activate Object; Combine Half-Keys 425094: Create Item
// Twin Key; Scarlet Initiate's Uniform 427592: Faction Override). The letters' words are ours: the live ones were not recorded.
// The spots of the twins, the chests and the benches inside the dungeons are estimates from the players' descriptions (see the
// world SQL 2026_11_21_86).

#include "ScriptMgr.h"
#include "AreaTrigger.h"
#include "AreaTriggerAI.h"
#include "Chat.h"
#include "DatabaseEnv.h"
#include "GameObject.h"
#include "GameObjectAI.h"
#include "Map.h"
#include "Mail.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "QuestDef.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include <set>

namespace RogueDeadDrop
{
    enum Quests : uint32
    {
        QUEST_HORN_OF_XELTHOS       = 78261,
        QUEST_HORN_PAYMENT          = 78307,
        QUEST_EYE_OF_BHOSSCA        = 78676,
        QUEST_EYE_PAYMENT           = 78699
    };

    enum Items : uint32
    {
        ITEM_BROTHERS_HALF_KEY      = 210212,
        ITEM_SISTERS_HALF_KEY       = 210213,
        ITEM_TWIN_KEY               = 210209,
        ITEM_SCRYERS_KEY            = 210963,
        ITEM_RELIQUARY_KEY          = 210968,
        ITEM_EYE_OF_BHOSSCA         = 210953
    };

    enum Objects : uint32
    {
        GO_DEAD_DROP                = 410369,
        GO_COURTYARD_DOOR           = 18895,
        GO_ORNAMENTED_CHEST         = 410528,
        GO_PERSONAL_LETTERBOX       = 412759,
        GO_PADLOCKED_RELIQUARY      = 412261,
        GO_STONE_COFFER             = 412198
    };

    // capitals where the word from C reaches the player (Forever players report Stormwind, Ironforge and Undercity)
    constexpr uint32 CapitalZones[] = { 1519, 1537, 1657, 1637, 1638, 1497 };

    // the two benches of the Graveyard: static area triggers of world SQL 2026_11_21_86
    constexpr ObjectGuid::LowType BenchSpawnIds[] = { 78676001, 78676002 };

    // the Stone Coffer appears in the northern mausoleum (estimate, see the SQL)
    Position const StoneCofferPos = { 1852.0f, 1345.5f, 18.47f, 3.40f };

    struct Letter
    {
        char const* Subject;
        char const* Body;
    };

    Letter const LetterHornOffer =
    {
        "An Offer",
        "Hello,\n\nI have a job for someone with your particular skills. Come to my dead drop, the chest in the house beside the road "
        "just outside Pyrewood Village in Silverpine Forest. My instructions are inside.\n\n- C"
    };

    Letter const LetterHornPayment =
    {
        "Payment",
        "Fine work in Shadowfang Keep. As promised, your payment is waiting for you in the dead drop near Pyrewood Village.\n\n- C"
    };

    Letter const LetterEyeOffer =
    {
        "Another Offer",
        "I have another job for you, if you are interested. You know where to find my instructions: the dead drop near Pyrewood "
        "Village.\n\n- C"
    };

    Letter const LetterEyePayment =
    {
        "Payment",
        "The eye is everything I hoped it would be. Your payment is waiting in the dead drop near Pyrewood Village.\n\n- C"
    };

    bool InCapital(Player const* player)
    {
        uint32 zone = player->GetZoneId();
        for (uint32 capital : CapitalZones)
            if (zone == capital)
                return true;
        return false;
    }

    bool HasLetter(Player const* player, Letter const& letter)
    {
        for (Mail const* mail : player->GetMails())
            if (mail->state != MAIL_STATE_DELETED && mail->messageType == MAIL_GAMEOBJECT && mail->sender == GO_DEAD_DROP
                && mail->subject == letter.Subject)
                return true;
        return false;
    }

    void SendLetter(Player* player, Letter const& letter)
    {
        CharacterDatabaseTransaction trans = CharacterDatabase.BeginTransaction();
        MailDraft(letter.Subject, letter.Body).SendMailTo(trans, MailReceiver(player), MailSender(MAIL_GAMEOBJECT, GO_DEAD_DROP),
            MAIL_CHECK_MASK_NONE);
        CharacterDatabase.CommitTransaction(trans);
    }

    bool NotStarted(Player const* player, uint32 questId)
    {
        return player->GetQuestStatus(questId) == QUEST_STATUS_NONE && !player->GetQuestRewardStatus(questId);
    }

    // the payment quests have no giver: the word from C puts them in the log, finished, for the hand-in at the Dead Drop
    void GivePayment(Player* player, uint32 questId, Letter const& letter)
    {
        Quest const* quest = sObjectMgr->GetQuestTemplate(questId);
        if (!quest || !player->CanAddQuest(quest, true))
            return;

        player->AddQuestAndCheckCompletion(quest, nullptr);
        SendLetter(player, letter);
    }
}

using namespace RogueDeadDrop;

// The word from C: a rogue in a capital gets the offer at level 20, the payment after the horn, the second offer at level 30 once
// the ring is collected, and the second payment after the eye.
class classic_player_rogue_dead_drop : public PlayerScript
{
public:
    classic_player_rogue_dead_drop() : PlayerScript("classic_player_rogue_dead_drop") { }

    static void Check(Player* player)
    {
        if (player->GetClass() != CLASS_ROGUE || !player->IsInWorld() || !InCapital(player))
            return;

        if (player->GetLevel() >= 20 && NotStarted(player, QUEST_HORN_OF_XELTHOS) && !HasLetter(player, LetterHornOffer))
            SendLetter(player, LetterHornOffer);

        if (player->GetQuestRewardStatus(QUEST_HORN_OF_XELTHOS) && NotStarted(player, QUEST_HORN_PAYMENT))
            GivePayment(player, QUEST_HORN_PAYMENT, LetterHornPayment);

        if (player->GetLevel() >= 30 && player->GetQuestRewardStatus(QUEST_HORN_PAYMENT) && NotStarted(player, QUEST_EYE_OF_BHOSSCA)
            && !HasLetter(player, LetterEyeOffer))
            SendLetter(player, LetterEyeOffer);

        if (player->GetQuestRewardStatus(QUEST_EYE_OF_BHOSSCA) && NotStarted(player, QUEST_EYE_PAYMENT))
            GivePayment(player, QUEST_EYE_PAYMENT, LetterEyePayment);
    }

    void OnUpdateZone(Player* player, uint32 /*newZone*/, uint32 /*newArea*/) override
    {
        Check(player);
    }

    void OnLevelChanged(Player* player, uint8 /*oldLevel*/) override
    {
        Check(player);
    }
};

// 211764 Gefell, 211765 Gemela: "two enemies that only spawn when doing this solo". They are shown only while one player is in the
// keep and that player is in no group.
struct classic_npc_xelthos_twin : public ScriptedAI
{
    classic_npc_xelthos_twin(Creature* creature) : ScriptedAI(creature) { }

    void InitializeAI() override
    {
        ScriptedAI::InitializeAI();
        _shown = true;
        UpdateShown();
    }

    void JustAppeared() override
    {
        ScriptedAI::JustAppeared();
        UpdateShown();
    }

    void UpdateAI(uint32 diff) override
    {
        if (!me->IsInCombat())
        {
            if (_checkTimer <= diff)
            {
                UpdateShown();
                _checkTimer = 1 * IN_MILLISECONDS;
            }
            else
                _checkTimer -= diff;
        }

        UpdateVictim();
    }

private:
    bool IsSoloRun() const
    {
        uint32 players = 0;
        bool grouped = false;
        for (MapReference const& ref : me->GetMap()->GetPlayers())
        {
            if (Player const* player = ref.GetSource())
            {
                ++players;
                if (player->GetGroup())
                    grouped = true;
            }
        }
        return players == 1 && !grouped;
    }

    void UpdateShown()
    {
        bool show = IsSoloRun();
        if (show == _shown)
            return;

        _shown = show;
        me->SetVisible(show);
        me->SetImmuneToPC(!show);
        me->SetUninteractible(!show);
        me->SetReactState(show ? REACT_AGGRESSIVE : REACT_PASSIVE);
    }

    uint32 _checkTimer = 0;
    bool _shown = true;
};

// 410528 Ornamented Chest (Twin Key), 412759 Personal Letterbox (Scryer's Key), 412261 Padlocked Reliquary (Reliquary Key): the
// key opens the lock and is used up, as the Wowhead records of the keys say ("Consumed when used").
struct classic_go_dead_drop_keyed_chest : public GameObjectAI
{
    classic_go_dead_drop_keyed_chest(GameObject* go) : GameObjectAI(go) { }

    bool OnGossipHello(Player* player) override
    {
        uint32 key = KeyItem();
        if (!key || _openedFor.count(player->GetGUID()))
            return false;

        if (!player->HasItemCount(key))
        {
            ChatHandler(player->GetSession()).SendSysMessage("It is locked.");
            return true;
        }

        player->DestroyItemCount(key, 1, true);
        _openedFor.insert(player->GetGUID());
        return false;
    }

private:
    uint32 KeyItem() const
    {
        switch (me->GetEntry())
        {
            case GO_ORNAMENTED_CHEST:       return ITEM_TWIN_KEY;
            case GO_PERSONAL_LETTERBOX:     return ITEM_SCRYERS_KEY;
            case GO_PADLOCKED_RELIQUARY:    return ITEM_RELIQUARY_KEY;
            default:                        return 0;
        }
    }

    std::set<ObjectGuid> _openedFor;
};

// The two benches between the statues of the Graveyard: sitting on one (stealth is fine) gives a faint click; with both, stone
// moves and the Stone Coffer appears in the northern mausoleum. An instance reset sets them back.
struct classic_at_bhossca_bench : AreaTriggerAI
{
    explicit classic_at_bhossca_bench(AreaTrigger* areaTrigger) : AreaTriggerAI(areaTrigger) { }

    uint32 GetData(uint32 /*id*/) const override
    {
        return _clicked ? 1 : 0;
    }

    void OnUpdate(uint32 diff) override
    {
        if (_checkTimer > diff)
        {
            _checkTimer -= diff;
            return;
        }
        _checkTimer = 500;

        for (ObjectGuid const& guid : at->GetInsideUnits())
        {
            Player* player = ObjectAccessor::GetPlayer(*at, guid);
            if (!player || !player->IsSitState() || player->GetQuestStatus(QUEST_EYE_OF_BHOSSCA) != QUEST_STATUS_INCOMPLETE)
                continue;

            if (!_clicked)
            {
                _clicked = true;
                ChatHandler(player->GetSession()).SendSysMessage("You hear a faint click.");
            }

            if (OtherBenchClicked() && NeedsCoffer(player))
            {
                ChatHandler(player->GetSession()).SendSysMessage("You hear the sound of stone moving.");
                at->SummonGameObject(GO_STONE_COFFER, StoneCofferPos, QuaternionData::fromEulerAnglesZYX(StoneCofferPos.GetOrientation(), 0.0f, 0.0f),
                    30min, GO_SUMMON_TIMED_DESPAWN);
            }
        }
    }

private:
    bool OtherBenchClicked() const
    {
        for (ObjectGuid::LowType spawnId : BenchSpawnIds)
            if (AreaTrigger* bench = at->GetMap()->GetAreaTriggerBySpawnId(spawnId))
                if (bench != at && bench->AI() && bench->AI()->GetData(0))
                    return true;
        return false;
    }

    bool NeedsCoffer(Player const* player) const
    {
        if (player->HasItemCount(ITEM_RELIQUARY_KEY) || player->HasItemCount(ITEM_EYE_OF_BHOSSCA))
            return false;
        return !at->FindNearestGameObject(GO_STONE_COFFER, 250.0f);
    }

    uint32 _checkTimer = 0;
    bool _clicked = false;
};

// 425067 - Breach Gate (Breaching Charge 210186): "Open a heavy gate, goblin-style!" The gate is the Courtyard Door of Shadowfang
// Keep. The spell's Activate Object effect opens it; the door is set open here too, in case the effect found no target.
class classic_spell_breach_gate : public SpellScript
{
    static constexpr float DOOR_RANGE = 10.0f;

    GameObject* FindDoor() const
    {
        if (GameObject* target = GetExplTargetGObj())
            return target->GetEntry() == GO_COURTYARD_DOOR ? target : nullptr;
        return GetCaster()->FindNearestGameObject(GO_COURTYARD_DOOR, DOOR_RANGE);
    }

    SpellCastResult CheckCast()
    {
        return FindDoor() ? SPELL_CAST_OK : SPELL_FAILED_BAD_TARGETS;
    }

    void HandleAfterCast()
    {
        if (GameObject* door = GetCaster()->FindNearestGameObject(GO_COURTYARD_DOOR, DOOR_RANGE))
            if (door->GetGoState() == GO_STATE_READY)
                door->SetGoState(GO_STATE_ACTIVE);
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(classic_spell_breach_gate::CheckCast);
        AfterCast += SpellCastFn(classic_spell_breach_gate::HandleAfterCast);
    }
};

// 425094 - Combine Half-Keys (Brother's and Sister's Half-Key): makes the Twin Key out of both halves.
class classic_spell_combine_half_keys : public SpellScript
{
    SpellCastResult CheckCast()
    {
        Player* player = GetCaster()->ToPlayer();
        if (!player || !player->HasItemCount(ITEM_BROTHERS_HALF_KEY) || !player->HasItemCount(ITEM_SISTERS_HALF_KEY))
            return SPELL_FAILED_REAGENTS;
        if (player->HasItemCount(ITEM_TWIN_KEY))
            return SPELL_FAILED_DONT_REPORT;
        return SPELL_CAST_OK;
    }

    void HandleAfterCast()
    {
        Player* player = GetCaster()->ToPlayer();
        if (!player)
            return;

        if (!player->HasItemCount(ITEM_TWIN_KEY))
            player->AddItem(ITEM_TWIN_KEY, 1);

        // the halves go only once the key is in the bags (a full bag keeps them)
        if (player->HasItemCount(ITEM_TWIN_KEY))
        {
            player->DestroyItemCount(ITEM_BROTHERS_HALF_KEY, 1, true);
            player->DestroyItemCount(ITEM_SISTERS_HALF_KEY, 1, true);
        }
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(classic_spell_combine_half_keys::CheckCast);
        AfterCast += SpellCastFn(classic_spell_combine_half_keys::HandleAfterCast);
    }
};

void AddSC_classic_rogue_dead_drop()
{
    new classic_player_rogue_dead_drop();
    RegisterCreatureAI(classic_npc_xelthos_twin);
    RegisterGameObjectAI(classic_go_dead_drop_keyed_chest);
    RegisterAreaTriggerAI(classic_at_bhossca_bench);
    RegisterSpellScript(classic_spell_breach_gate);
    RegisterSpellScript(classic_spell_combine_half_keys);
}
