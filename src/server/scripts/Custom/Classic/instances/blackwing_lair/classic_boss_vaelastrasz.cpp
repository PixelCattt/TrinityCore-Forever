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

// Classic 1.60 port of VMaNGOS src/scripts/eastern_kingdoms/burning_steppes/blackwing_lair/boss_vaelastrasz.cpp (ScriptDev2 lineage, GPL-2)
// Scripts: boss_vaelastrasz, npc_death_talon_Captain, npc_death_talon_Seether

#include "ObjectAccessor.h"
#include "ScriptMgr.h"
#include "DB2Stores.h"
#include "GossipDef.h"
#include "InstanceScript.h"
#include "Map.h"
#include "MotionMaster.h"
#include "Player.h"
#include "QuestDef.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "SpellAuras.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "TemporarySummon.h"
#include "ThreatManager.h"
#include "WorldSession.h"
#include "classic_blackwing_lair.h"
#include "classic_script_text.h"
#include <list>
#include <string>
#include <vector>

namespace
{
enum ClassicBwlVaelastrasz : uint32
{
    CLASSIC_BWL_SAY_VAEL_LINE_1              = 9886,
    CLASSIC_BWL_SAY_VAEL_LINE_2              = 9887,
    CLASSIC_BWL_SAY_VAEL_LINE_3              = 9888,
    CLASSIC_BWL_SAY_VAEL_HALFLIFE            = 9965,
    CLASSIC_BWL_SAY_VAEL_KILLTARGET          = 9964,
    CLASSIC_BWL_SAY_NEFARIUS_CORRUPT_1       = 9794, // When he corrupts Vaelastrasz
    CLASSIC_BWL_SAY_NEFARIUS_CORRUPT_2       = 9844,

    CLASSIC_BWL_SPELL_ESSENCE_OF_THE_RED     = 23513,
    CLASSIC_BWL_SPELL_VAEL_FLAME_BREATH      = 23461,
    CLASSIC_BWL_SPELL_VAEL_FIRE_NOVA         = 23462,
    CLASSIC_BWL_SPELL_VAEL_TAIL_SWEEP        = 15847,
    CLASSIC_BWL_SPELL_BURNING_ADRENALINE     = 23620,
    CLASSIC_BWL_SPELL_VAEL_CLEAVE            = 19983,

    CLASSIC_BWL_SPELL_BANISHEMENT_OF_SCALE   = 16404,
    CLASSIC_BWL_SPELL_NEFARIUS_CORRUPTION    = 23642,

    CLASSIC_BWL_GOSSIP_TEXT_VAEL_1           = 7156,
    CLASSIC_BWL_GOSSIP_TEXT_VAEL_2           = 7256,

    CLASSIC_BWL_GOSSIP_ITEM_VAEL_1           = 9847,  // I cannot, Vaelastrasz! Surely something can be done to heal you!
    CLASSIC_BWL_GOSSIP_ITEM_VAEL_2           = 10011  // Vaelastrasz, no!!!
};

// Coords used to spawn Nefarius at the throne
Position const ClassicBwlNefariusSpawnLoc = { -7466.16f, -1040.80f, 412.053f, 2.14675f };

// VMaNGOS ADD_GOSSIP_ITEM(broadcast text id): localized BroadcastText when present in the client data
std::string ClassicBwlVaelGossipText(Player* player, uint32 broadcastTextId, char const* fallback)
{
    if (BroadcastTextEntry const* bct = sBroadcastTextStore.LookupEntry(broadcastTextId))
    {
        char const* text = DB2Manager::GetBroadcastTextValue(bct, player->GetSession()->GetSessionDbLocaleIndex(), player->GetGender());
        if (text && *text)
            return text;
    }
    return fallback;
}

// VMaNGOS SetGuidValue(UNIT_FIELD_CHANNEL_OBJECT) + SetUInt32Value(UNIT_CHANNEL_SPELL) (channel visual without a cast)
void ClassicBwlVaelSetChannel(Unit* unit, ObjectGuid target, uint32 spellId)
{
    unit->ClearChannelObjects();
    if (!target.IsEmpty())
        unit->AddChannelObject(target);
    unit->SetChannelSpellId(spellId);
    SpellCastVisual visual;
    if (spellId)
        if (SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId, unit->GetMap()->GetDifficultyID()))
            visual.SpellXSpellVisualID = unit->GetCastSpellXSpellVisualId(spellInfo);
    unit->SetChannelVisual(visual);
}
}

struct classic_boss_vaelastrasz : public ScriptedAI
{
    classic_boss_vaelastrasz(Creature* creature) : ScriptedAI(creature)
    {
        m_pInstance = creature->GetInstanceScript();
        if (m_pInstance)
            m_bIntroEvent = m_pInstance->GetData(CLASSIC_BWL_TYPE_VAEL_EVENT) == DONE;
        else
            m_bIntroEvent = false;
        m_bEngaged = false;
    }

    InstanceScript* m_pInstance;

    uint32 m_uiSpeechTimer = 0;
    uint32 m_uiSpeechNum = 0;
    uint32 m_uiCleaveTimer = 0;
    uint32 m_uiFlameBreathTimer = 0;
    uint32 m_uiFireNovaTimer = 0;
    uint32 m_uiBurningAdrenalineCasterTimer = 0;
    uint32 m_uiBurningAdrenalineTankTimer = 0;
    uint32 m_uiTailSweepTimer = 0;
    uint32 m_uiSelectableTimer = 0;
    uint32 m_uiInitTimer = 0;
    uint32 m_uiIntroTimer = 0;
    uint32 m_uiIntroPhase = 0;
    bool m_bIntroEvent;
    bool m_bHasYelled = false;
    bool m_bIsDoingSpeech = false;
    bool m_bCastedEssenceOfTheRed = false;
    bool m_bCastedbanishment = false;
    bool m_bFlagSet = false;
    bool m_bEngaged;
    ObjectGuid m_playerGuid;
    ObjectGuid m_nefariusGuid;

    void RemoveGossipFlags()
    {
        me->RemoveNpcFlag(UNIT_NPC_FLAG_QUESTGIVER);
        me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
    }

    void Reset() override
    {
        m_uiSpeechTimer                  = 0;
        m_uiSpeechNum                    = 0;
        m_uiCleaveTimer                  = 6000;
        m_uiFlameBreathTimer             = 8000;
        m_uiBurningAdrenalineCasterTimer = 15000;
        m_uiBurningAdrenalineTankTimer   = 45000;
        m_uiFireNovaTimer                = 4000;
        m_uiTailSweepTimer               = 8000;
        m_uiSelectableTimer              = 0;
        m_uiIntroTimer                   = 0;
        m_uiIntroPhase                   = 0;
        m_bHasYelled                     = false;
        m_bIsDoingSpeech                 = false;
        m_bCastedEssenceOfTheRed         = false;
        m_bCastedbanishment              = false;
        m_bFlagSet                       = false;
        m_bEngaged                       = false;
        m_uiInitTimer                    = 2000;

        m_playerGuid.Clear();
        m_nefariusGuid.Clear();
        me->SetHealth(me->CountPctFromMaxHealth(30.0f));
    }

    void BeginSpeech(Unit* target)
    {
        if (!target)
            return;

        // Stand up and begin speech
        m_playerGuid = target->GetGUID();
        me->SetStandState(UNIT_STAND_STATE_STAND);
        RemoveGossipFlags();
        // 10 seconds
        ClassicScriptText(CLASSIC_BWL_SAY_VAEL_LINE_1, me);

        m_uiSpeechTimer  = 10000;
        m_uiSpeechNum    = 0;
        m_bIsDoingSpeech = true;

        if (!m_pInstance)
            return;

        // If Nefarius's Corruption has not been accepted by this point, fail Scepter Run
        if (m_pInstance->GetData(CLASSIC_BWL_TYPE_SCEPTER_RUN) == NOT_STARTED)
            m_pInstance->SetData(CLASSIC_BWL_TYPE_SCEPTER_RUN, FAIL);
    }

    void KilledUnit(Unit* pVictim) override
    {
        if (!pVictim || pVictim->GetTypeId() != TYPEID_PLAYER)
            return;

        if (urand(0, 4))
            return;

        ClassicScriptText(CLASSIC_BWL_SAY_VAEL_KILLTARGET, me, pVictim);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        if (!m_bCastedEssenceOfTheRed)
        {
            DoCastSelf(CLASSIC_BWL_SPELL_ESSENCE_OF_THE_RED);
            m_bCastedEssenceOfTheRed = true;
        }
        DoZoneInCombat();
        if (m_pInstance)
            m_pInstance->SetData(CLASSIC_BWL_TYPE_VAELASTRASZ, IN_PROGRESS);

        // From 1.8: There is no longer a one-hour time restriction on the Vaelastraz the Corrupt encounter (VMaNGOS pre-1.8 only)
        m_bEngaged = true;
    }

    void JustDied(Unit* /*killer*/) override
    {
        me->SetRespawnDelay(7 * DAY);
        if (m_pInstance)
            m_pInstance->SetData(CLASSIC_BWL_TYPE_VAELASTRASZ, DONE);
    }

    void JustReachedHome() override
    {
        if (m_pInstance)
            m_pInstance->SetData(CLASSIC_BWL_TYPE_VAELASTRASZ, FAIL);
        me->SetFaction(CLASSIC_BWL_FACTION_MONSTER);
        me->SetStandState(UNIT_STAND_STATE_STAND);
        me->SetImmuneToNPC(true);
        RemoveGossipFlags();
    }

    void UpdateAI(uint32 uiDiff) override
    {
        if (!m_pInstance)
            return;

        if (!m_bIntroEvent && m_pInstance->GetData(CLASSIC_BWL_TYPE_VAEL_EVENT) == DONE)
        {
            m_uiIntroTimer = 1000;
            m_bIntroEvent = true;
        }

        if (m_uiIntroTimer)
        {
            if (m_uiIntroTimer <= uiDiff)
            {
                switch (m_uiIntroPhase)
                {
                    case 0:
                    {
                        // VMaNGOS summons him with a NullCreatureAI; classic_boss_victor_nefarius stays inert when summoned
                        if (Creature* pNefarius = me->SummonCreature(CLASSIC_BWL_NPC_LORD_NEFARIAN, ClassicBwlNefariusSpawnLoc, TEMPSUMMON_TIMED_DESPAWN, 25s))
                        {
                            pNefarius->GetMotionMaster()->MoveIdle();
                            pNefarius->SetUninteractible(true);
                            m_nefariusGuid = pNefarius->GetGUID();
                        }
                        m_uiIntroTimer = 1000;
                        break;
                    }
                    case 1:
                    {
                        if (Creature* pNefarius = me->GetMap()->GetCreature(m_nefariusGuid))
                        {
                            ClassicBwlVaelSetChannel(pNefarius, me->GetGUID(), CLASSIC_BWL_SPELL_BANISHEMENT_OF_SCALE);
                            if (Aura* pAura = me->AddAura(CLASSIC_BWL_SPELL_NEFARIUS_CORRUPTION, me))
                            {
                                pAura->SetMaxDuration(24000);
                                pAura->SetDuration(24000);
                            }
                            ClassicScriptText(CLASSIC_BWL_SAY_NEFARIUS_CORRUPT_1, pNefarius);
                        }
                        m_uiIntroTimer = 15750;
                        break;
                    }
                    case 2:
                    {
                        if (Creature* pNefarius = me->GetMap()->GetCreature(m_nefariusGuid))
                            ClassicScriptText(CLASSIC_BWL_SAY_NEFARIUS_CORRUPT_2, pNefarius);
                        m_uiSelectableTimer = 8250;
                        m_bCastedbanishment = true;
                        m_pInstance->SetData(CLASSIC_BWL_TYPE_VAELASTRASZ, SPECIAL);
                        m_uiIntroTimer = 0;
                        break;
                    }
                    default:
                        break;
                }
                ++m_uiIntroPhase;
            }
            else
                m_uiIntroTimer -= uiDiff;
        }

        if (!me->IsInCombat() && !m_bFlagSet)
        {
            if (m_uiInitTimer < uiDiff)
            {
                if (m_pInstance->GetData(CLASSIC_BWL_TYPE_VAEL_EVENT) != DONE)
                {
                    me->SetFaction(CLASSIC_BWL_FACTION_FRIENDLY);
                    me->SetStandState(UNIT_STAND_STATE_DEAD);
                }
                else
                {
                    me->SetFaction(CLASSIC_BWL_FACTION_MONSTER);
                    me->SetStandState(UNIT_STAND_STATE_STAND);
                }
                me->SetImmuneToNPC(true);
                RemoveGossipFlags();
                m_bFlagSet = true;
            }
            else
                m_uiInitTimer -= uiDiff;
        }

        if (m_bCastedbanishment)
        {
            if (m_uiSelectableTimer < uiDiff)
            {
                m_bCastedbanishment = false;
                me->SetNpcFlag(UNIT_NPC_FLAG_QUESTGIVER);
                me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP);
            }
            else
                m_uiSelectableTimer -= uiDiff;
        }

        // Speech
        if (m_bIsDoingSpeech)
        {
            if (m_uiSpeechTimer < uiDiff)
            {
                switch (m_uiSpeechNum)
                {
                    case 0:
                        // 16 seconds till next line
                        ClassicScriptText(CLASSIC_BWL_SAY_VAEL_LINE_2, me);
                        m_uiSpeechTimer = 16000;
                        ++m_uiSpeechNum;
                        break;
                    case 1:
                        // This one is actually 16 seconds but we only go to 10 seconds because he starts attacking after he says "I must fight this!"
                        ClassicScriptText(CLASSIC_BWL_SAY_VAEL_LINE_3, me);
                        m_uiSpeechTimer = 10000;
                        ++m_uiSpeechNum;
                        break;
                    case 2:
                        me->SetFaction(CLASSIC_BWL_FACTION_MONSTER);
                        if (!m_playerGuid.IsEmpty())
                        {
                            if (Player* pPlayer = ObjectAccessor::GetPlayer(*me, m_playerGuid))
                                AttackStart(pPlayer);

                            DoCastSelf(CLASSIC_BWL_SPELL_ESSENCE_OF_THE_RED);
                            m_bCastedEssenceOfTheRed = true;
                        }
                        m_uiSpeechTimer = 0;
                        m_bIsDoingSpeech = false;
                        break;
                    default:
                        break;
                }
            }
            else
                m_uiSpeechTimer -= uiDiff;
        }

        // Return since we have no target
        if (!UpdateVictim())
            return;

        // Burning Adrenaline Caster Timer
        // caster... caster... caster + tank... caster... caster... caster + tank...
        if (m_uiBurningAdrenalineCasterTimer < uiDiff)
        {
            std::vector<ObjectGuid> vPossibleVictim;
            for (ThreatReference const* ref : me->GetThreatManager().GetUnsortedThreatList())
            {
                Player* pPlayer = ref->GetVictim()->ToPlayer();
                if (pPlayer && pPlayer->IsAlive() && pPlayer->GetPowerType() == POWER_MANA && !pPlayer->HasAura(CLASSIC_BWL_SPELL_BURNING_ADRENALINE))
                    vPossibleVictim.push_back(pPlayer->GetGUID());
            }
            if (!vPossibleVictim.empty())
            {
                if (Player* pPlayer = ObjectAccessor::GetPlayer(*me, vPossibleVictim[urand(0, uint32(vPossibleVictim.size()) - 1)]))
                    pPlayer->CastSpell(pPlayer, CLASSIC_BWL_SPELL_BURNING_ADRENALINE, true);
            }
            m_uiBurningAdrenalineCasterTimer = 15000;
        }
        else
            m_uiBurningAdrenalineCasterTimer -= uiDiff;

        // Burning Adrenaline Tank Timer
        if (m_uiBurningAdrenalineTankTimer < uiDiff)
        {
            // have the victim cast the spell on himself otherwise the third effect aura will be applied
            // to Vael instead of the player
            Unit* pVictim = me->GetVictim();
            if (pVictim && !pVictim->HasAura(CLASSIC_BWL_SPELL_BURNING_ADRENALINE) && pVictim->IsAlive())
            {
                pVictim->CastSpell(pVictim, CLASSIC_BWL_SPELL_BURNING_ADRENALINE, true);
                m_uiBurningAdrenalineTankTimer = 45000;
            }
        }
        else
            m_uiBurningAdrenalineTankTimer -= uiDiff;

        // Yell if hp lower than 15%
        if (me->GetHealthPct() < 15.0f && !m_bHasYelled)
        {
            ClassicScriptText(CLASSIC_BWL_SAY_VAEL_HALFLIFE, me);
            m_bHasYelled = true;
        }

        // Cleave Timer
        if (m_uiCleaveTimer < uiDiff)
        {
            if (DoCastVictim(CLASSIC_BWL_SPELL_VAEL_CLEAVE) == SPELL_CAST_OK)
                m_uiCleaveTimer = urand(5000, 10000);
        }
        else
            m_uiCleaveTimer -= uiDiff;

        // Flame Breath Timer
        if (m_uiFlameBreathTimer < uiDiff)
        {
            if (DoCastVictim(CLASSIC_BWL_SPELL_VAEL_FLAME_BREATH) == SPELL_CAST_OK)
                m_uiFlameBreathTimer = urand(5000, 10000);
        }
        else
            m_uiFlameBreathTimer -= uiDiff;

        // Fire Nova Timer
        if (m_uiFireNovaTimer < uiDiff)
        {
            if (DoCastSelf(CLASSIC_BWL_SPELL_VAEL_FIRE_NOVA) == SPELL_CAST_OK)
                m_uiFireNovaTimer = 2000;
        }
        else
            m_uiFireNovaTimer -= uiDiff;

        // Tail Sweep Timer
        if (m_uiTailSweepTimer < uiDiff)
        {
            if (DoCastSelf(CLASSIC_BWL_SPELL_VAEL_TAIL_SWEEP) == SPELL_CAST_OK)
                m_uiTailSweepTimer = urand(4000, 6000);
        }
        else
            m_uiTailSweepTimer -= uiDiff;

        // melee: TC master auto-melee
    }

    bool OnGossipHello(Player* pPlayer) override
    {
        if (!m_pInstance)
            return false;

        if (m_pInstance->GetData(CLASSIC_BWL_TYPE_RAZORGORE) != DONE && !pPlayer->IsGameMaster())
            return false;

        ClearGossipMenuFor(pPlayer);

        if (me->IsQuestGiver())
            if (m_pInstance->GetData(CLASSIC_BWL_TYPE_SCEPTER_RUN) == NOT_STARTED)
                pPlayer->PrepareQuestMenu(me->GetGUID());

        AddGossipItemFor(pPlayer, GossipOptionNpc::None, ClassicBwlVaelGossipText(pPlayer, CLASSIC_BWL_GOSSIP_ITEM_VAEL_1, "I cannot, Vaelastrasz! Surely something can be done to heal you!"), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        SendGossipMenuFor(pPlayer, CLASSIC_BWL_GOSSIP_TEXT_VAEL_1, me->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* pPlayer, uint32 /*menuId*/, uint32 gossipListId) override
    {
        uint32 const uiAction = pPlayer->PlayerTalkClass->GetGossipOptionAction(gossipListId);
        switch (uiAction)
        {
            case GOSSIP_ACTION_INFO_DEF + 1:
            {
                ClearGossipMenuFor(pPlayer);
                AddGossipItemFor(pPlayer, GossipOptionNpc::None, ClassicBwlVaelGossipText(pPlayer, CLASSIC_BWL_GOSSIP_ITEM_VAEL_2, "Vaelastrasz, no!!!"), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
                SendGossipMenuFor(pPlayer, CLASSIC_BWL_GOSSIP_TEXT_VAEL_2, me->GetGUID());
                break;
            }
            case GOSSIP_ACTION_INFO_DEF + 2: // Fight Time
            {
                CloseGossipMenuFor(pPlayer);
                BeginSpeech(pPlayer);
                break;
            }
            default:
                break;
        }

        return true;
    }

    void OnQuestAccept(Player* pPlayer, Quest const* pQuest) override
    {
        if (!m_pInstance)
            return;

        if (pQuest->GetQuestId() == CLASSIC_BWL_QUEST_NEFARIUS_CORRUPTION)
        {
            uint32 const scepterRunState = m_pInstance->GetData(CLASSIC_BWL_TYPE_SCEPTER_RUN);
            if (scepterRunState == NOT_STARTED)
            {
                // The first accepter starts the timed run and owns its one
                // conditioned shard; later accepters must not replace it.
                m_pInstance->SetData(CLASSIC_BWL_TYPE_SCEPTER_RUN, SPECIAL);
                m_pInstance->SetGuidData(CLASSIC_BWL_DATA_SCEPTER_CHAMPION, pPlayer->GetGUID());
            }
            else if (scepterRunState != SPECIAL)
            {
                pPlayer->FailQuest(CLASSIC_BWL_QUEST_NEFARIUS_CORRUPTION);
                return;
            }

            // Permanently bind player to instance
            if (InstanceMap* pInstanceMap = me->GetMap()->ToInstanceMap())
                pInstanceMap->CreateInstanceLockForPlayer(pPlayer);
        }
    }
};

/**************************
*** Death Talon Captain ***
***************************/

namespace
{
enum ClassicBwlDeathTalonCaptain : uint32
{
    CLASSIC_BWL_SPELL_MARK_DETONATION       = 22438,
    CLASSIC_BWL_SPELL_MARK_FLAMES           = 25050,
    CLASSIC_BWL_SPELL_COMMANDING_SHOUT      = 22440,
    CLASSIC_BWL_SPELL_CAPTAIN_CLEAVE        = 15496,
    CLASSIC_BWL_SPELL_AURA_FLAMES           = 22436
};
}

struct classic_npc_death_talon_Captain : public ScriptedAI
{
    classic_npc_death_talon_Captain(Creature* creature) : ScriptedAI(creature)
    {
        m_pInstance = creature->GetInstanceScript();
    }

    InstanceScript* m_pInstance;

    uint32 m_uiMarkDetonationTimer = 0;
    uint32 m_uiMarkFlamesTimer = 0;
    uint32 m_uiCommandingShoutTimer = 0;
    uint32 m_uiCleaveTimer = 0;

    void Reset() override
    {
        m_uiMarkDetonationTimer     = 10000;
        m_uiMarkFlamesTimer         = 6000;
        m_uiCommandingShoutTimer    = urand(12000, 25000);
        m_uiCleaveTimer             = urand(4000, 8000);
        if (!me->HasAura(CLASSIC_BWL_SPELL_AURA_FLAMES))   // CF_AURA_NOT_PRESENT
            DoCastSelf(CLASSIC_BWL_SPELL_AURA_FLAMES);
        SetAuraFlames(false);
    }

    void MoveInLineOfSight(Unit* pUnit) override
    {
        if (!pUnit || me->GetVictim())
            return;

        if (pUnit->GetTypeId() == TYPEID_PLAYER && me->GetDistance2d(pUnit) < 29.0f && me->IsWithinLOSInMap(pUnit)
            && me->IsValidAttackTarget(pUnit) && me->CanCreatureAttack(pUnit))
            AttackStart(pUnit);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        if (!me->HasAura(CLASSIC_BWL_SPELL_AURA_FLAMES))
            if (Aura* aura = me->AddAura(CLASSIC_BWL_SPELL_AURA_FLAMES, me)) // ADD_AURA_PERMANENT
            {
                aura->SetMaxDuration(-1);
                aura->SetDuration(-1);
            }

        DoCastSelf(CLASSIC_BWL_SPELL_COMMANDING_SHOUT, true);
    }

    void JustDied(Unit* /*killer*/) override
    {
        SetAuraFlames(false);
    }

    void SetAuraFlames(bool on)
    {
        std::list<Creature*> lCreature;
        for (uint32 entry : { uint32(CLASSIC_BWL_NPC_DEATH_TALON_FLAMESCALE), uint32(CLASSIC_BWL_NPC_DEATH_TALON_WYRMKIN), uint32(CLASSIC_BWL_NPC_DEATH_TALON_SEETHER) })
        {
            std::list<Creature*> tmp;
            me->GetCreatureListWithEntryInGrid(tmp, entry, 50.0f);
            lCreature.splice(lCreature.end(), tmp);
        }

        for (Creature* itr : lCreature)
        {
            if (!itr->IsAlive())
                continue;

            if (on && me->IsAlive())
            {
                if (me->IsWithinDistInMap(itr, 15.0f))
                {
                    if (!itr->HasAura(CLASSIC_BWL_SPELL_AURA_FLAMES))
                        itr->AddAura(CLASSIC_BWL_SPELL_AURA_FLAMES, itr);
                }
                else
                    itr->RemoveAurasDueToSpell(CLASSIC_BWL_SPELL_AURA_FLAMES);
            }
            else
                itr->RemoveAurasDueToSpell(CLASSIC_BWL_SPELL_AURA_FLAMES);
        }
    }

    void UpdateAI(uint32 uiDiff) override
    {
        if (!UpdateVictim())
            return;

        SetAuraFlames(true);

        if (m_uiCleaveTimer < uiDiff)
        {
            if (DoCastVictim(CLASSIC_BWL_SPELL_CAPTAIN_CLEAVE) == SPELL_CAST_OK)
                m_uiCleaveTimer = urand(4000, 8000);
        }
        else
            m_uiCleaveTimer -= uiDiff;

        if (m_uiCommandingShoutTimer < uiDiff)
        {
            if (DoCastSelf(CLASSIC_BWL_SPELL_COMMANDING_SHOUT) == SPELL_CAST_OK)
                m_uiCommandingShoutTimer = urand(12000, 25000);
        }
        else
            m_uiCommandingShoutTimer -= uiDiff;

        if (m_uiMarkFlamesTimer < uiDiff)
        {
            if (Unit* pUnit = SelectTarget(SelectTargetMethod::Random, 0))
            {
                if (DoCast(pUnit, CLASSIC_BWL_SPELL_MARK_FLAMES) == SPELL_CAST_OK)
                    m_uiMarkFlamesTimer = 15000;
            }
        }
        else
            m_uiMarkFlamesTimer -= uiDiff;

        if (m_uiMarkDetonationTimer < uiDiff)
        {
            if (Unit* pUnit = SelectTarget(SelectTargetMethod::Random, 0))
            {
                if (pUnit->IsAlive())
                {
                    pUnit->CastSpell(pUnit, CLASSIC_BWL_SPELL_MARK_DETONATION, true);
                    m_uiMarkDetonationTimer = 20000;
                }
            }
        }
        else
            m_uiMarkDetonationTimer -= uiDiff;
    }
};

/**************************
*** Death Talon Seether ***
***************************/

namespace
{
enum ClassicBwlDeathTalonSeether : uint32
{
    CLASSIC_BWL_SPELL_SEETHER_FRENZY        = 22428,
    CLASSIC_BWL_SPELL_SEETHER_FLAME_BUFFET  = 22433,

    CLASSIC_BWL_EMOTE_SEETHER_FRENZY        = 7797
};
}

struct classic_npc_death_talon_Seether : public ScriptedAI
{
    classic_npc_death_talon_Seether(Creature* creature) : ScriptedAI(creature) { }

    uint32 m_uiFlameBuffetTimer = 0;
    uint32 m_uiFrenzyTimer = 0;
    bool m_bEngaged = false;

    void Reset() override
    {
        m_uiFlameBuffetTimer = urand(5000, 10000);
        m_uiFrenzyTimer     = 15000;
        m_bEngaged          = false;
    }

    void UpdateAI(uint32 uiDiff) override
    {
        if (!UpdateVictim())
            return;

        if (m_uiFrenzyTimer < uiDiff)
        {
            if (DoCastSelf(CLASSIC_BWL_SPELL_SEETHER_FRENZY) == SPELL_CAST_OK)
            {
                ClassicScriptText(CLASSIC_BWL_EMOTE_SEETHER_FRENZY, me);
                m_uiFrenzyTimer = 15000;
            }
        }
        else
            m_uiFrenzyTimer -= uiDiff;

        if (!m_bEngaged)
        {
            if (me->IsWithinMeleeRange(me->GetVictim()))
                m_bEngaged = true;
        }
        else
        {
            if (m_uiFlameBuffetTimer < uiDiff)
            {
                if (DoCastVictim(CLASSIC_BWL_SPELL_SEETHER_FLAME_BUFFET) == SPELL_CAST_OK)
                    m_uiFlameBuffetTimer = urand(8000, 12000);
            }
            else
                m_uiFlameBuffetTimer -= uiDiff;
        }
    }
};

void AddSC_classic_boss_vaelastrasz()
{
    RegisterCreatureAI(classic_boss_vaelastrasz);
    RegisterCreatureAI(classic_npc_death_talon_Captain);
    RegisterCreatureAI(classic_npc_death_talon_Seether);
}
