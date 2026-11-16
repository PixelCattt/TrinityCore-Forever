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

#include "ScriptMgr.h"
#include "Item.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"

/*###
# gossip item and box texts
###*/

enum Gossips
{
    GOSSIP_ZAP              = 6092, // Zap Farflinger
    GOSSIP_JHORDY           = 6094, // Jhordy Lapforge
    GOSSIP_KABLAM           = 8308, // Kablamm Farflinger
    GOSSIP_SMILES           = 8306, // Smiles O'Byron
};

/*###
# spells defines
###*/

enum ProfessionSpells
{
    S_GOBLIN                = 20222,
    S_GNOMISH               = 20219,
};

/*###
# engineering trinkets
###*/

enum EngineeringTrinkets
{
    NPC_ZAP                     = 14742,
    NPC_JHORDY                  = 14743,
    NPC_KABLAM                  = 21493,
    NPC_SMILES                  = 21494,

    SPELL_LEARN_TO_EVERLOOK     = 23490,
    SPELL_LEARN_TO_GADGET       = 23491,
    SPELL_LEARN_TO_AREA52       = 36956,
    SPELL_LEARN_TO_TOSHLEY      = 36957,

    SPELL_TO_EVERLOOK           = 23486,
    SPELL_TO_GADGET             = 23489,
    SPELL_TO_AREA52             = 36954,
    SPELL_TO_TOSHLEY            = 36955,
};

class npc_engineering_tele_trinket : public CreatureScript
{
public:
    npc_engineering_tele_trinket() : CreatureScript("npc_engineering_tele_trinket") { }

    struct npc_engineering_tele_trinketAI : public ScriptedAI
    {
        npc_engineering_tele_trinketAI(Creature* creature) : ScriptedAI(creature) { }

        static bool CanLearn(Player const* player, uint32 textId, uint32 altTextId, uint32 skillId, uint32 skillValue, uint32 reqSpellId, uint32 spellId, uint32& npcTextId)
        {
            bool res = false;
            npcTextId = textId;
            if (player->GetBaseSkillValue(skillId) >= skillValue && player->HasSpell(reqSpellId))
            {
                if (!player->HasSpell(spellId))
                    res = true;
                else
                    npcTextId = altTextId;
            }
            return res;
        }

        bool OnGossipHello(Player* player) override
        {
            uint32 npcTextId = 0;
            uint32 gossipItem;
            bool canLearn = false;

            if (player->HasSkill(SKILL_ENGINEERING))
            {
                // The Forever client has no "Classic Engineering" tier line (2506): Engineering's rank and recipes live on
                // the profession's own line (202), so that is the line the 260 requirement reads.
                switch (me->GetEntry())
                {
                    // Zap's and Jhordy's texts are the ones of their own gossip menus (6092: 7249, and 7254 once the device is
                    // known; 6094: 7251 and 7253). The old ids were wrong for this world: 6092 is a menu id, and as a text it is
                    // the spirit healer's line ("It is not yet your time..."); 7252 does not exist.
                    case NPC_ZAP:
                        canLearn = CanLearn(player, 7249, 7254, SKILL_ENGINEERING, 260, S_GOBLIN, SPELL_TO_EVERLOOK, npcTextId);
                        if (canLearn)
                            gossipItem = GOSSIP_ZAP;
                        break;
                    case NPC_JHORDY:
                        canLearn = CanLearn(player, 7251, 7253, SKILL_ENGINEERING, 260, S_GNOMISH, SPELL_TO_GADGET, npcTextId);
                        if (canLearn)
                            gossipItem = GOSSIP_JHORDY;
                        break;
                    case NPC_KABLAM:
                        canLearn = CanLearn(player, 10365, 0, SKILL_OUTLAND_ENGINEERING, 50, S_GOBLIN, SPELL_TO_AREA52, npcTextId);
                        if (canLearn)
                            gossipItem = GOSSIP_KABLAM;
                        break;
                    case NPC_SMILES:
                        canLearn = CanLearn(player, 10363, 0, SKILL_OUTLAND_ENGINEERING, 50, S_GNOMISH, SPELL_TO_TOSHLEY, npcTextId);
                        if (canLearn)
                            gossipItem = GOSSIP_SMILES;
                        break;
                    default:
                        break;
                }
            }

            // The learn line is option 0 of the menu on Zap and Jhordy (the only one their menus have here; asking for option 2
            // found nothing, so no engineer ever saw it) and option 2 on the Outland pair.
            if (canLearn)
                AddGossipItemFor(player, gossipItem, (gossipItem == GOSSIP_ZAP || gossipItem == GOSSIP_JHORDY) ? 0 : 2, me->GetEntry(),
                    GOSSIP_ACTION_INFO_DEF + 1);

            SendGossipMenuFor(player, npcTextId ? npcTextId : player->GetGossipTextId(me), me->GetGUID());
            return true;
        }

        bool OnGossipSelect(Player* player, uint32 /*menuId*/, uint32 gossipListId) override
        {
            uint32 const sender = player->PlayerTalkClass->GetGossipOptionSender(gossipListId);

            if (sender != me->GetEntry())
                return true;

            switch (sender)
            {
                case NPC_ZAP:
                    player->CastSpell(player, SPELL_LEARN_TO_EVERLOOK, false);
                    break;
                case NPC_JHORDY:
                    player->CastSpell(player, SPELL_LEARN_TO_GADGET, false);
                    break;
                case NPC_KABLAM:
                    player->CastSpell(player, SPELL_LEARN_TO_AREA52, false);
                    break;
                case NPC_SMILES:
                    player->CastSpell(player, SPELL_LEARN_TO_TOSHLEY, false);
                    break;
                default:
                    break;
            }

            // The option itself points at another menu (6093 / 6095); the device is learned, so the window closes here.
            CloseGossipMenuFor(player);
            return true;
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_engineering_tele_trinketAI(creature);
    }
};

void AddSC_npc_professions()
{
    new npc_engineering_tele_trinket();
}
