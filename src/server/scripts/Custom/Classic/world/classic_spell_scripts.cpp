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

// Classic 1.60 class spell scripts.

#include "ScriptMgr.h"
#include "AreaTrigger.h"
#include "CellImpl.h"
#include "ClassicLegacyPerks.h"
#include "ClassicVanillaAoe.h"
#include "Creature.h"
#include "CreatureAI.h"
#include "ConditionMgr.h"
#include "Containers.h"
#include "DatabaseEnv.h"
#include "DB2Stores.h"
#include "Formulas.h"
#include "GameObject.h"
#include "GameTime.h"
#include "GridNotifiersImpl.h"
#include "Item.h"
#include "ItemTemplate.h"
#include "Map.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "PhasingHandler.h"
#include "Player.h"
#include "QuestDef.h"
#include "RestMgr.h"
#include "Random.h"
#include "Spell.h"
#include "SpellAuraEffects.h"
#include "SpellHistory.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "SpellScript.h"
#include "ThreatManager.h"
#include "Unit.h"
#include "World.h"
#include "WorldSession.h"
#include <mutex>
#include <unordered_map>

/*######
## classic_spell_ground_area_damage
######*/

// Classic 1.60 ground spells (official client data): the spell creates an area trigger (effect 1) and puts a periodic dummy aura
// on the caster (effect 2); every tick damages the enemies inside the caster's area trigger of that spell. The client data has
// no damage spell or per-rank damage for them (placeholder values on effect 0): the tick damage per rank is the vanilla one
// (VMaNGOS spell_template, persistent area aura base points + 1), the spell power share per tick the vanilla coefficient.
struct ClassicGroundAreaDamage
{
    uint32 TickDamage;
    float Coefficient;      // spell power per tick
    // how a tick resists (WoW Forever, wowsims/forever, MIT, docs/evidence EV-0142): Blizzard's, Rain of Fire's and Volley's ticks like a
    // direct hit, Spell Piercing included (Blizzard's ticks 543 of 2,123 with a piercing bonus against 554 at the caster's rate);
    // Flamestrike's ground ticks at a tenth of the share with no piercing (57 of 235 with a partial, 0.09 of the target's share; 0 of 4,177
    // with a piercing bonus); Hurricane's live tick spells deal the damage and slow the target, so they are binary: a tick resists whole
    // at the target's share and one that lands takes no partial resist (0 partials on 30,053 landed ticks, 64 of 131 full resists against
    // 68.8 at the share)
    ClassicResistRoll Resist = ClassicResistRoll::Spell;
};

static std::unordered_map<uint32, ClassicGroundAreaDamage> const ClassicGroundAreaDamages =
{
    // Blizzard (frost, 1 s, 8 s channel): 33% spell power over 8 ticks
    { 10,    {  25, 0.0417f } }, { 6141,  {  44, 0.0417f } }, { 8427,  {  65, 0.0417f } },
    { 10185, {  90, 0.0417f } }, { 10186, { 117, 0.0417f } }, { 10187, { 149, 0.0417f } },
    // Flamestrike burning ground (fire, 2 s, 8 s; the direct hit is effect 0): ~12% spell power over 4 ticks
    { 2120,  {  12, 0.0305f, ClassicResistRoll::TenthShare } }, { 2121,  {  22, 0.0305f, ClassicResistRoll::TenthShare } },
    { 8422,  {  35, 0.0305f, ClassicResistRoll::TenthShare } }, { 8423,  {  49, 0.0305f, ClassicResistRoll::TenthShare } },
    { 10215, {  66, 0.0305f, ClassicResistRoll::TenthShare } }, { 10216, {  85, 0.0305f, ClassicResistRoll::TenthShare } },
    // Rain of Fire (fire, 2 s, 8 s channel): 33% spell power over 4 ticks
    { 5740,  {  42, 0.0833f } }, { 6219,  {  96, 0.0833f } }, { 11677, { 155, 0.0833f } }, { 11678, { 226, 0.0833f } },
    // Volley (arcane, 1 s, 6 s channel): no spell power
    { 1510,  {  50, 0.0f } }, { 14294, {  65, 0.0f } }, { 14295, {  80, 0.0f } },
    // Hurricane (nature, 1 s, 10 s channel): base points + die of the three ranks (classic_spell_value), 10.7% spell power per tick
    { 16914, {  70, 0.107f, ClassicResistRoll::Binary } }, { 17401, { 100, 0.107f, ClassicResistRoll::Binary } },
    { 17402, { 134, 0.107f, ClassicResistRoll::Binary } },
};

class classic_spell_ground_area_damage : public AuraScript
{
    bool Validate(SpellInfo const* spellInfo) override
    {
        return ClassicGroundAreaDamages.contains(spellInfo->Id);
    }

    void HandleTick(AuraEffect const* /*aurEff*/)
    {
        Unit* caster = GetCaster();
        if (!caster)
            return;

        SpellInfo const* spellInfo = GetSpellInfo();
        ClassicGroundAreaDamage const& values = ClassicGroundAreaDamages.at(spellInfo->Id);

        GuidUnorderedSet targets;
        for (AreaTrigger* areaTrigger : caster->GetAreaTriggers(spellInfo->Id))
            targets.insert(areaTrigger->GetInsideUnits().begin(), areaTrigger->GetInsideUnits().end());

        for (ObjectGuid const& guid : targets)
        {
            Unit* target = ObjectAccessor::GetUnit(*caster, guid);
            if (!target || !target->IsAlive() || !caster->IsValidAttackTarget(target, spellInfo))
                continue;

            // a binary tick resists whole at the target's average resist
            if (values.Resist == ClassicResistRoll::Binary
                && roll_chance(100.0f * Unit::CalculateAverageResistReduction(caster, spellInfo->GetSchoolMask(), target, spellInfo)))
            {
                caster->SendSpellMiss(target, spellInfo->Id, SPELL_MISS_RESIST);
                continue;
            }

            int32 damage = values.TickDamage;
            if (values.Coefficient > 0.0f)
                damage += int32(caster->SpellBaseDamageBonusDone(spellInfo->GetSchoolMask()) * values.Coefficient);

            // The same done modifiers a periodic tick gets in Unit::SpellDamageBonusDone: percent auras of the school and the talent
            // spell mods of the periodic damage (Fire Power, Piercing Ice, Emberstorm, Arcane Power, Shadow Mastery... carry one for
            // the periodic damage next to the direct one). Without them the ground damage ignored every one of these.
            float modifiedDamage = float(damage) * caster->SpellDamagePctDone(target, spellInfo, DOT, spellInfo->GetEffect(EFFECT_2));
            if (Player* modOwner = caster->GetSpellModOwner())
                modOwner->ApplySpellMod(spellInfo, SpellModOp::PeriodicHealingAndDamage, modifiedDamage);
            damage = int32(std::max(modifiedDamage, 0.0f));

            damage = target->SpellDamageBonusTaken(caster, spellInfo, damage, DOT);

            SpellNonMeleeDamage damageInfo(caster, target, spellInfo, GetAura()->GetSpellVisual(), spellInfo->GetSchoolMask(), GetAura()->GetCastId());
            damageInfo.periodicLog = true;
            caster->CalculateSpellDamageTaken(&damageInfo, damage, spellInfo, BASE_ATTACK, false, false, nullptr, values.Resist);
            Unit::DealDamageMods(damageInfo.attacker, damageInfo.target, damageInfo.damage, &damageInfo.absorb);
            caster->SendSpellNonMeleeDamageLog(&damageInfo);
            caster->DealSpellDamage(&damageInfo, true);
        }
    }

    void HandleRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        // channels (Blizzard, Rain of Fire, Volley): the ground effect ends with the channel
        if (GetSpellInfo()->IsChanneled())
            if (Unit* caster = GetCaster())
                caster->RemoveAreaTrigger(GetSpellInfo()->Id);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(classic_spell_ground_area_damage::HandleTick, EFFECT_2, SPELL_AURA_PERIODIC_DUMMY);
        AfterEffectRemove += AuraEffectRemoveFn(classic_spell_ground_area_damage::HandleRemove, EFFECT_2, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

// 6785, 6787, 9866, 9867 - Ravage; 9005, 9823, 9827 - Pounce
// Blizzard hotfix 6 November 2026: "Night Elf: Shadowmelded Druids no longer have access to Ravage and Pounce." Shadowmeld (20580)
// is a stealth aura, so a druid in Cat Form could open with them from it instead of from Prowl. Live now lists Shadowmeld as an
// aura the caster must not have (SpellAuraRestrictions.ExcludeCasterAuraSpell 20580, seen in the live spell data of wowsims/forever,
// MIT); our client data does not have that yet, so the server checks it.
class classic_spell_dru_not_from_shadowmeld : public SpellScript
{
    static constexpr uint32 SPELL_SHADOWMELD = 20580;

    SpellCastResult CheckCast()
    {
        if (GetCaster()->HasAura(SPELL_SHADOWMELD))
            return SPELL_FAILED_CASTER_AURASTATE;
        return SPELL_CAST_OK;
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(classic_spell_dru_not_from_shadowmeld::CheckCast);
    }
};

// Classic 1.60 (WoW Forever), Shen'dar Highlands cave, quest 94489 (official beta sniff 70205): clicking an injured druid makes the
// player cast 1276047 (dummy) on it. Credit "Injured Druids healed" (257964) and the druid's own hidden objective (its entry).
enum ClassicHealInjuredDruid
{
    NPC_INJURED_DRUIDS_HEALED_CREDIT = 257964
};

class classic_spell_heal_injured_druid : public SpellScript
{
    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Player* player = GetCaster()->ToPlayer();
        Creature* druid = GetHitCreature();
        if (!player || !druid)
            return;

        player->KilledMonsterCredit(NPC_INJURED_DRUIDS_HEALED_CREDIT);
        player->KilledMonsterCredit(druid->GetEntry());
        druid->SetStandState(UNIT_STAND_STATE_STAND);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(classic_spell_heal_injured_druid::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// Classic 1.60 (WoW Forever) profession books: Mining for Dummies (247840, 1245608), Wild Harvest (247841, 1245609), Pelt Collecting for
// Beginners (247846, 1245610). "Increases your <profession> skill by $m1. Cannot raise <profession> skill over $m2. You will learn
// <profession> if it is not already trained and you do not already know two other professions." Both effects are dummies.
class classic_spell_profession_book : public SpellScript
{
    struct BookProfession
    {
        uint32 SpellId;
        uint32 SkillId;
        uint32 ApprenticeSpell;
    };

    static BookProfession const* GetProfession(uint32 spellId)
    {
        static BookProfession const books[] =
        {
            { 1245608, SKILL_MINING,    2575 },     // Mining (Apprentice)
            { 1245609, SKILL_HERBALISM, 2366 },     // Herb Gathering (Apprentice)
            { 1245610, SKILL_SKINNING,  8613 },     // Skinning (Apprentice)
        };
        for (BookProfession const& book : books)
            if (book.SpellId == spellId)
                return &book;
        return nullptr;
    }

    uint32 GetCap() const
    {
        return uint32(std::max<int32>(GetSpellInfo()->GetEffect(EFFECT_1).CalcValue(), 1));
    }

    SpellCastResult CheckCast()
    {
        Player* player = GetCaster()->ToPlayer();
        BookProfession const* book = GetProfession(GetSpellInfo()->Id);
        if (!player || !book)
            return SPELL_FAILED_DONT_REPORT;

        if (player->HasSkill(book->SkillId))
            return player->GetPureSkillValue(book->SkillId) < GetCap() ? SPELL_CAST_OK : SPELL_FAILED_CANT_DO_THAT_RIGHT_NOW;

        return player->GetFreePrimaryProfessionPoints() > 0 ? SPELL_CAST_OK : SPELL_FAILED_CANT_DO_THAT_RIGHT_NOW;
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Player* player = GetCaster()->ToPlayer();
        BookProfession const* book = GetProfession(GetSpellInfo()->Id);
        if (!player || !book)
            return;

        if (!player->HasSkill(book->SkillId))
            player->LearnSpell(book->ApprenticeSpell, false);
        if (!player->HasSkill(book->SkillId))
            return;

        uint16 const current = player->GetPureSkillValue(book->SkillId);
        uint16 const target = uint16(std::min<uint32>(current + uint32(GetEffectValue()), GetCap()));
        if (target > current)
            player->SetSkill(book->SkillId, player->GetSkillStep(book->SkillId), target, player->GetPureMaxSkillValue(book->SkillId));
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(classic_spell_profession_book::CheckCast);
        OnEffectHitTarget += SpellEffectFn(classic_spell_profession_book::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 20154, 21084, 20287-20293 - Seal of Righteousness: each melee swing that lands adds the rank's Holy damage spell. Vanilla formula on the
// seal's points (which grow per level) and the weapon: slower weapons hit harder, two-handers more (sniffs of the official beta:
// 20154 -> 25742, 21084 -> 25741, 3-6 damage at low level)
class classic_spell_pal_seal_of_righteousness : public AuraScript
{
    static uint32 GetDamageSpell(uint32 sealId)
    {
        switch (sealId)
        {
            case 20154: return 25742;
            case 21084: return 25741;
            case 20287: return 25740;
            case 20288: return 25739;
            case 20289: return 25738;
            case 20290: return 25737;
            case 20291: return 25736;
            case 20292: return 25735;
            case 20293: return 25713;
            default:    return 0;
        }
    }

public:
    // One Seal of Righteousness hit from seal `sealId` with effect points `points` (also replayed by Unsealed Wrath)
    static void Hit(Player* player, Unit* target, uint32 sealId, float points, CastSpellExtraArgs args)
    {
        uint32 const damageSpell = GetDamageSpell(sealId);
        if (!player || !target || !damageSpell)
            return;

        Item* weapon = player->GetWeaponForAttack(BASE_ATTACK, true);
        float const speed = (weapon ? weapon->GetTemplate()->GetDelay() : BASE_ATTACK_TIME) / 1000.0f;

        bool const twoHanded = weapon && weapon->GetTemplate()->GetInventoryType() == INVTYPE_2HWEAPON;
        float damage;
        if (twoHanded)
            damage = 1.2f * points * 1.2f * 1.03f * speed / 100.0f + 1.0f;
        else
            damage = 0.85f * std::ceil(points * 1.2f * 1.03f * speed / 100.0f) - 1.0f;
        damage += 0.03f * (player->GetWeaponDamageRange(BASE_ATTACK, MINDAMAGE) + player->GetWeaponDamageRange(BASE_ATTACK, MAXDAMAGE)) / 2.0f;

        // WoW Forever: a hit takes 0.1 of the paladin's Holy spell power with a one-hander and 0.12 with a two-hander, the tooltip's
        // coefficients, though the damage rows state 0 (their classic_spell_value coefficient is 0, sql 2026_11_19_54); Judgement of the
        // Crusader at the same coefficient (wowsims/forever, MIT, docs/rulings R-0009, docs/evidence EV-0060 and EV-0143). The top rank
        // had no spell power at all.
        float const coefficient = twoHanded ? 0.12f : 0.1f;
        damage += coefficient * float(std::max(0, player->SpellBaseDamageBonusDone(SPELL_SCHOOL_MASK_HOLY))
            + target->GetTotalAuraModifierByMiscMask(SPELL_AURA_MOD_DAMAGE_TAKEN, SPELL_SCHOOL_MASK_HOLY));

        player->CastSpell(target, damageSpell, args.AddSpellMod(SPELLVALUE_BASE_POINT0, std::max(int32(damage) + 1, 1)));
    }

private:
    bool Validate(SpellInfo const* spellInfo) override
    {
        return ValidateSpellInfo({ GetDamageSpell(spellInfo->Id) });
    }

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        return GetTarget()->IsPlayer() && eventInfo.GetActionTarget() && eventInfo.GetDamageInfo()
            && eventInfo.GetDamageInfo()->GetAttackType() == BASE_ATTACK;
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();
        Hit(GetTarget()->ToPlayer(), eventInfo.GetActionTarget(), GetId(), float(aurEff->GetAmount()), CastSpellExtraArgs(aurEff));
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(classic_spell_pal_seal_of_righteousness::CheckProc);
        OnEffectProc += AuraEffectProcFn(classic_spell_pal_seal_of_righteousness::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

// 20271 - Judgement: unleashes the active seal's judgement on the target; the seal stays (sniff of the official beta 2026-10-06: Seal of
// Righteousness -> 20187, Seal of the Crusader -> 21183, Seal of Righteousness keeps adding Holy damage to the swings after Judgement)
enum ClassicPaladinJudgement
{
    SPELL_JUDGEMENT_OF_THE_CRUSADER_REFRESH_PROC = 25942,
    SPELL_JUDGEMENT_OF_THE_CRUSADER_REFRESH      = 25943
};

static bool IsCrusaderJudgement(uint32 spellId)
{
    switch (spellId)
    {
        case 21183: case 20188: case 20300: case 20301: case 20302: case 20303:
            return true;
        default:
            return false;
    }
}

class classic_spell_pal_judgement : public SpellScript
{
    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        Unit* target = GetHitUnit();
        if (!target)
            return;

        for (auto const& [auraId, aurApp] : caster->GetAppliedAuras())
        {
            uint32 judgement = GetClassicSealJudgement(auraId);
            if (!judgement || aurApp->GetBase()->GetCasterGUID() != caster->GetGUID())
                continue;

            caster->CastSpell(target, judgement, CastSpellExtraArgs(TRIGGERED_FULL_MASK).SetTriggeringSpell(GetSpell()));
            // Judgement of the Crusader: the paladin's swings keep it on the target (25942 procs 25943, which casts it again)
            if (IsCrusaderJudgement(judgement))
                caster->CastSpell(caster, SPELL_JUDGEMENT_OF_THE_CRUSADER_REFRESH_PROC, CastSpellExtraArgs(TRIGGERED_FULL_MASK).SetTriggeringSpell(GetSpell()));
            break;
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(classic_spell_pal_judgement::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// 20425, 20961, 20962, 20967, 20968 - Judgement of Command: the client spell is a dummy effect whose base points name the Holy damage spell
// (20467 / 20964 / 20963 / 20965 / 20966 for the Seal of Command ranks 1 to 5); nothing cast it, so the judgement did no damage.
class classic_spell_pal_judgement_of_command : public SpellScript
{
    static uint32 GetDamageSpell(uint32 judgementId)
    {
        switch (judgementId)
        {
            case 20425: return 20467;
            case 20962: return 20963;
            case 20961: return 20964;
            case 20967: return 20965;
            case 20968: return 20966;
            default:    return 0;
        }
    }

    bool Validate(SpellInfo const* spellInfo) override
    {
        return ValidateSpellInfo({ GetDamageSpell(spellInfo->Id) });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Unit* target = GetHitUnit();
        if (!target)
            return;

        GetCaster()->CastSpell(target, GetDamageSpell(GetSpellInfo()->Id), CastSpellExtraArgs(TRIGGERED_FULL_MASK).SetTriggeringSpell(GetSpell()));
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(classic_spell_pal_judgement_of_command::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 5373, 1826 - Judgement of Light / Judgement of Wisdom "Intermediate": the judgement debuff (20185, 20186 and their ranks) procs this dummy
// from the judged enemy at whoever hits it, and nothing turned it into the heal or the mana (the client spell does neither itself). The rank's
// own spell (20267 / 20341-20343 heal, 20268 / 20352-20353 mana) targets its own caster (ImplicitTarget 1), so the attacker casts it on
// itself, with the paladin that judged as the original caster for credit. The client gives those spells no class mask and no bonus
// coefficient, so no talent or healing modifier of the paladin's could change them; the vanilla amounts are in those spells. A proc
// cast never sets the original caster, so GetOriginalCaster() here is the judged enemy itself: the old code had it cast the
// self-targeted heal / mana, which went to the enemy (Discord, dumpins 2026-11-17).
class classic_spell_pal_judgement_intermediate : public SpellScript
{
    // Redemption Armor 2-piece 28775: "Increases the amount healed by your Judgement of Light by $s1." A dummy whose class mask names no spell
    // the heal is filed under (the heals have no class mask), so it never applied; the heal is cast with the bonus added.
    static constexpr uint32 SPELL_REDEMPTION_JUDGEMENT_OF_LIGHT = 28775;

    static uint32 GetRankSpell(bool light, uint32 debuffId)
    {
        if (light)
        {
            switch (debuffId)
            {
                case 20185: return 20267;
                case 20344: return 20341;
                case 20345: return 20342;
                case 20346: return 20343;
                default:    return 0;
            }
        }
        switch (debuffId)
        {
            case 20186: return 20268;
            case 20354: return 20352;
            case 20355: return 20353;
            default:    return 0;
        }
    }

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ 20267, 20341, 20342, 20343, 20268, 20352, 20353 });
    }

    void HandleCast()
    {
        Unit* judged = GetCaster();
        Unit* attacker = GetExplTargetUnit();
        if (!judged || !attacker)
            return;

        bool const light = GetSpellInfo()->Id == 5373;
        for (auto const& [auraId, aurApp] : judged->GetAppliedAuras())
        {
            uint32 const rankSpell = GetRankSpell(light, auraId);
            if (!rankSpell)
                continue;

            CastSpellExtraArgs args(TRIGGERED_FULL_MASK);
            args.SetOriginalCaster(aurApp->GetBase()->GetCasterGUID()).SetTriggeringSpell(GetSpell());
            if (light)
                if (Unit* paladin = aurApp->GetBase()->GetCaster())
                    if (AuraEffect const* redemption = paladin->GetAuraEffect(SPELL_REDEMPTION_JUDGEMENT_OF_LIGHT, EFFECT_0))
                        args.AddSpellBP0(sSpellMgr->AssertSpellInfo(rankSpell, DIFFICULTY_NONE)->GetEffect(EFFECT_0).CalcValue(attacker)
                            + redemption->GetAmount());

            attacker->CastSpell(attacker, rankSpell, args);
            break;
        }
    }

    void Register() override
    {
        OnCast += SpellCastFn(classic_spell_pal_judgement_intermediate::HandleCast);
    }
};

// 25943 - Judgement of the Crusader (refresh, from the 25942 swing proc): casts the paladin's Judgement of the Crusader on the target
// again while it is on it (sniff 2026-10-06: every swing after the judgement shows 25942, 21183, 25943)
class classic_spell_pal_judgement_of_the_crusader_refresh : public SpellScript
{
    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        Unit* target = GetHitUnit();
        if (!target)
            return;

        for (auto const& [auraId, aurApp] : target->GetAppliedAuras())
        {
            if (!IsCrusaderJudgement(auraId) || aurApp->GetBase()->GetCasterGUID() != caster->GetGUID())
                continue;

            caster->CastSpell(target, auraId, CastSpellExtraArgs(TRIGGERED_FULL_MASK).SetTriggeringSpell(GetSpell()));
            break;
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(classic_spell_pal_judgement_of_the_crusader_refresh::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 20473, 20929, 20930 - Holy Shock (trainer, levels 40/48/56): heals a friendly target or damages an enemy with the rank's spell
// (the retail script only knows rank 1)
class classic_spell_pal_holy_shock : public SpellScript
{
    static std::pair<uint32, uint32> GetRankSpells(uint32 spellId) // damage, heal
    {
        switch (spellId)
        {
            case 20473: return { 25912, 25914 };
            case 20929: return { 25911, 25913 };
            case 20930: return { 25902, 25903 };
            default:    return { 0, 0 };
        }
    }

    bool Validate(SpellInfo const* spellInfo) override
    {
        auto [damage, heal] = GetRankSpells(spellInfo->Id);
        return ValidateSpellInfo({ damage, heal });
    }

    SpellCastResult CheckCast()
    {
        Unit* caster = GetCaster();
        Unit* target = GetExplTargetUnit();
        if (!target)
            return SPELL_FAILED_BAD_TARGETS;

        if (!caster->IsFriendlyTo(target))
        {
            if (!caster->IsValidAttackTarget(target))
                return SPELL_FAILED_BAD_TARGETS;
            if (!caster->isInFront(target))
                return SPELL_FAILED_UNIT_NOT_INFRONT;
        }
        return SPELL_CAST_OK;
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        Unit* target = GetHitUnit();
        if (!target)
            return;

        auto [damage, heal] = GetRankSpells(GetSpellInfo()->Id);
        caster->CastSpell(target, caster->IsFriendlyTo(target) ? heal : damage, GetSpell());
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(classic_spell_pal_holy_shock::CheckCast);
        OnEffectHitTarget += SpellEffectFn(classic_spell_pal_holy_shock::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 1515 - Tame Beast: a 20 second channel in Classic (periodic aura on the beast); when it runs out the beast is tamed with 13481
// (SPELL_EFFECT_TAME_CREATURE). The retail script on 1515 (spell_hun_tame_beast) keeps its cast checks; it tames instantly in
// retail, so the Classic channel ended without a pet.
class classic_spell_hun_tame_beast_channel : public AuraScript
{
    static constexpr uint32 SPELL_TAME_BEAST_TAME = 13481;

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_TAME_BEAST_TAME });
    }

    void HandleRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (GetTargetApplication()->GetRemoveMode() != AURA_REMOVE_BY_EXPIRE)
            return;

        if (Unit* caster = GetCaster())
            caster->CastSpell(GetTarget(), SPELL_TAME_BEAST_TAME, CastSpellExtraArgs(TRIGGERED_FULL_MASK).SetOriginalCaster(caster->GetGUID()));
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(classic_spell_hun_tame_beast_channel::HandleRemove, EFFECT_1, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
    }
};

// 1280003, 1280046, 1271103 - Taming Rod (Skyborne hunter quests Taming the Beast 94978, 94979, 94013), and 1277794, 1278028,
// 1278029 (human hunter quests 94792, 94863, 94864, not sniffed yet): a 20 second channel with a
// dummy aura on the beast; when it runs out the rod's tame spell charms the beast for 12 sec and completes the quest (sniff of the
// official beta: channel 20000 ms, then 1280004 / 1280044 / 1271102)
class classic_spell_hun_taming_rod : public AuraScript
{
    static uint32 GetTameSpell(uint32 channelSpellId)
    {
        switch (channelSpellId)
        {
            case 1280003: return 1280004;   // Windsong Crawler (94978)
            case 1280046: return 1280044;   // Ornery Galestrider (94979)
            case 1271103: return 1271102;   // Vuldren Alpha (94013)
            case 1277794: return 1277851;   // Rockhide Boar (94792, human)
            case 1278028: return 1278060;   // Gray Forest Wolf (94863, human)
            case 1278029: return 1278061;   // Young Forest Bear (94864, human)
            default:      return 0;
        }
    }

    bool Validate(SpellInfo const* spellInfo) override
    {
        return ValidateSpellInfo({ GetTameSpell(spellInfo->Id) });
    }

    void HandleRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (GetTargetApplication()->GetRemoveMode() != AURA_REMOVE_BY_EXPIRE)
            return;

        if (Unit* caster = GetCaster())
            caster->CastSpell(GetTarget(), GetTameSpell(GetId()), CastSpellExtraArgs(TRIGGERED_FULL_MASK).SetOriginalCaster(caster->GetGUID()));
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(classic_spell_hun_taming_rod::HandleRemove, EFFECT_1, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

// 348, 707, 1094, 2941, 11665, 11667, 11668, 25309 - Immolate: Classic 1.60 added a script effect (EFFECT_2) that puts the hidden
// Immolate aura 1282590 on the target (sniff: both auras on the target, same caster). Every Conflagrate rank needs it
// (SpellAuraRestrictions TargetAuraSpell 1282590), so without it Conflagrate could never be cast.
class classic_spell_warl_immolate : public SpellScript
{
    static constexpr uint32 SPELL_IMMOLATE_CONFLAGRATE_MARKER = 1282590;

    bool Validate(SpellInfo const* spellInfo) override
    {
        return ValidateSpellInfo({ SPELL_IMMOLATE_CONFLAGRATE_MARKER }) && ValidateSpellEffect({ { spellInfo->Id, EFFECT_2 } });
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        // the marker targets its caster, so the target casts it on itself for the warlock
        Unit* target = GetHitUnit();
        target->CastSpell(target, SPELL_IMMOLATE_CONFLAGRATE_MARKER, CastSpellExtraArgs(TRIGGERED_FULL_MASK).SetOriginalCaster(GetCaster()->GetGUID()));
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(classic_spell_warl_immolate::HandleScript, EFFECT_2, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// 1259705 - Read Ley Line, 1259686 - Skysight (Skyborne racials), as the WoW Forever beta development notes of 2026-10-26 describe them:
// the spell triggers a 15 sec buff (Energized 1270842: +50% Health and Mana regeneration / Elemental Blessing 1259688: +15% movement
// speed). Next to its spell focus object (Ley Line 602735 / 613248, focus 2246 / Elemental Convergence 616992, focus 2271) it also
// grants a 1 hour marker that stays through death (Attuned / Charged, the former 15 min buffs 1259691 / 1270893 renamed by the hotfixes
// of 2026_10_27_05); while the caster has it, the buff is doubled (100% regeneration / 30% speed). Read Ley Line cannot be used while
// Innervate is active (classic_spell_innervate_replaces_energized removes Energized when Innervate lands).
// "Reading the Ley Lines" (92597) counts a Read Ley Line cast made while the caster has Leyline Convergence 1271952 (criteria 109629,
// modifier tree 426346: has aura). Nothing in the client data or the sniffs applies that 10 sec aura, so a cast next to a ley line
// applies it before the cast is counted (Spell::_cast updates CriteriaType::CastSpell after OnCast).
enum SkyborneRacials
{
    SPELL_INNERVATE                 = 29166,
    SPELL_INNERVATE_2               = 456195,
    SPELL_ENERGIZED_READ_LEY_LINE   = 1270842
};

class classic_spell_skyborne_racial_focus : public SpellScript
{
public:
    explicit classic_spell_skyborne_racial_focus(uint32 spellFocus, uint32 markerSpell, uint32 convergenceSpell, int32 markedAmount, bool blockedByInnervate)
        : _spellFocus(spellFocus), _markerSpell(markerSpell), _convergenceSpell(convergenceSpell), _markedAmount(markedAmount),
        _blockedByInnervate(blockedByInnervate) { }

private:
    bool Validate(SpellInfo const* spellInfo) override
    {
        return ValidateSpellInfo({ _markerSpell }) && (!_convergenceSpell || ValidateSpellInfo({ _convergenceSpell }))
            && ValidateSpellEffect({ { spellInfo->Id, EFFECT_0 } });
    }

    bool IsNearFocus() const
    {
        Unit* caster = GetCaster();
        GameObject* focus = nullptr;
        Trinity::GameObjectFocusCheck check(caster, _spellFocus);
        Trinity::GameObjectSearcher searcher(caster, focus, check);
        Cell::VisitGridObjects(caster, searcher, 50.0f); // focus radius of both objects is 25
        return focus != nullptr;
    }

    SpellCastResult CheckInnervate()
    {
        if (_blockedByInnervate && (GetCaster()->HasAura(SPELL_INNERVATE) || GetCaster()->HasAura(SPELL_INNERVATE_2)))
            return SPELL_FAILED_AURA_BOUNCED;
        return SPELL_CAST_OK;
    }

    void HandleCast()
    {
        if (_convergenceSpell && GetCaster()->IsPlayer() && IsNearFocus())
            GetCaster()->CastSpell(GetCaster(), _convergenceSpell, CastSpellExtraArgs(TRIGGERED_FULL_MASK).SetTriggeringSpell(GetSpell()));
    }

    void HandleTrigger(SpellEffIndex effIndex)
    {
        Unit* caster = GetCaster();
        if (IsNearFocus())
            caster->CastSpell(caster, _markerSpell, CastSpellExtraArgs(TRIGGERED_FULL_MASK).SetTriggeringSpell(GetSpell()));

        if (!caster->HasAura(_markerSpell))
            return;

        PreventHitDefaultEffect(effIndex);
        caster->CastSpell(caster, GetEffectInfo().TriggerSpell, CastSpellExtraArgs(TRIGGERED_FULL_MASK).SetTriggeringSpell(GetSpell())
            .AddSpellMod(SPELLVALUE_BASE_POINT0, _markedAmount).AddSpellMod(SPELLVALUE_BASE_POINT1, _markedAmount));
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(classic_spell_skyborne_racial_focus::CheckInnervate);
        OnCast += SpellCastFn(classic_spell_skyborne_racial_focus::HandleCast);
        // Launch, not launch target: the self-cast buff is triggered in the launch phase (NeedsToBeTriggeredByCaster is false) and
        // lands a tick later, so preventing it at launch target let it refresh the doubled buff back to the base amount.
        OnEffectLaunch += SpellEffectFn(classic_spell_skyborne_racial_focus::HandleTrigger, EFFECT_0, SPELL_EFFECT_TRIGGER_SPELL);
    }

    uint32 _spellFocus;
    uint32 _markerSpell;
    uint32 _convergenceSpell;
    int32 _markedAmount;
    bool _blockedByInnervate;
};

// 29166, 456195 - Innervate: replaces Read Ley Line's Energized 1270842 as the more powerful effect (WoW Forever beta notes 2026-10-26).
class classic_spell_innervate_replaces_energized : public AuraScript
{
    void AfterApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetTarget()->RemoveAurasDueToSpell(SPELL_ENERGIZED_READ_LEY_LINE);
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(classic_spell_innervate_replaces_energized::AfterApply, EFFECT_0, SPELL_AURA_ANY, AURA_EFFECT_HANDLE_REAL);
    }
};

// 1301404 - Al'Aketh Spiritcaller nature damage (Zephras Isle, Shrine of Akir): the client data gives the aura no duration (index 21,
// infinite) and nothing on our server takes it off, so players kept it through teleports and logouts. It now ends when the
// Spiritcaller is gone, dead or no longer fighting the player.
class classic_spell_alaketh_spiritcaller_dot : public AuraScript
{
    void HandleTick(AuraEffect const* /*aurEff*/)
    {
        Unit* caster = GetCaster();
        if (caster && caster->IsAlive() && caster->IsInCombatWith(GetTarget()))
            return;

        PreventDefaultAction();
        Remove();
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(classic_spell_alaketh_spiritcaller_dot::HandleTick, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE);
    }
};

// 1296017 - Decipher (mage, trainer level 6): Classic 1.60 gives the mage the deciphering skill (SkillLine 3012) with it, and the
// skill teaches the four Decipher spells of the untranslated scrolls (1309973, 1309965, 1310029, 1310030, SkillLineAbility
// AcquireMethod AutomaticSkillRank, ItemSalvage 255, 261, 262, 263). The spell's effect 359 is unknown to the server and trainers only
// learn it, so the skill is started on cast and, for mages who already know Decipher, at login.
namespace ClassicScrollDeciphering
{
    static constexpr uint32 SPELL_DECIPHER = 1296017;
    static constexpr uint16 SKILL_SCROLL_DECIPHERING = 3012;

    static void LearnSkill(Player* player)
    {
        if (player->HasSkill(SKILL_SCROLL_DECIPHERING) || !player->HasSpell(SPELL_DECIPHER))
            return;

        if (SkillRaceClassInfoEntry const* rcInfo = sDB2Manager.GetSkillRaceClassInfo(SKILL_SCROLL_DECIPHERING, player->GetRace(), player->GetClass()))
            player->LearnDefaultSkill(rcInfo);
    }

    // The four Decipher spells (SALVAGE_ITEM on ItemSalvage 255/261/262/263) are hidden: the spellbook only shows Comprehend Scroll
    // (1296017), and pressing it did nothing (tested in game 11-02). So pressing it now deciphers the first untranslated scroll in the
    // bags that the mage's Comprehension skill and level allow, with that scroll's own Decipher spell. Skill ranks from ItemSalvage.
    struct ScrollBand
    {
        uint32 SpellId;
        uint16 MinSkill;
        uint32 Items[5];
    };

    static constexpr ScrollBand Bands[] =
    {
        { 1309973,   1, { 211780, 211785, 211786, 211787, 0 } },
        { 1309965,  15, { 211784, 211853, 211854, 211855, 0 } },
        { 1310029,  50, { 213543, 213544, 213545, 213546, 213547 } },
        { 1310030, 175, { 281015, 281016, 281017, 281018, 0 } },
    };

    static bool DecipherFirstScroll(Player* player)
    {
        uint16 skill = player->GetSkillValue(SKILL_SCROLL_DECIPHERING);
        for (ScrollBand const& band : Bands)
        {
            if (skill < band.MinSkill)
                continue;

            for (uint32 itemId : band.Items)
            {
                if (!itemId)
                    continue;

                Item* scroll = player->GetItemByEntry(itemId);
                if (!scroll || player->CanUseItem(scroll) != EQUIP_ERR_OK)
                    continue;

                player->CastSpell(scroll, band.SpellId, CastSpellExtraArgs(TRIGGERED_FULL_MASK));
                return true;
            }
        }
        return false;
    }
}

class classic_spell_mage_decipher : public SpellScript
{
    void HandleLearnSkill(SpellEffIndex /*effIndex*/)
    {
        if (Player* player = GetCaster()->ToPlayer())
        {
            ClassicScrollDeciphering::LearnSkill(player);
            if (player->HasSkill(ClassicScrollDeciphering::SKILL_SCROLL_DECIPHERING))
                ClassicScrollDeciphering::DecipherFirstScroll(player);
        }
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(classic_spell_mage_decipher::HandleLearnSkill, EFFECT_0, SPELL_EFFECT_359);
    }
};

class classic_player_scroll_deciphering : public PlayerScript
{
public:
    classic_player_scroll_deciphering() : PlayerScript("classic_player_scroll_deciphering") { }

    void OnLogin(Player* player, bool /*firstLogin*/) override
    {
        ClassicScrollDeciphering::LearnSkill(player);
    }
};

// 1319421 - Motivated (Executor's Motivator, undead quest Discipline 99134): a dummy aura on a Tirisfal Deathguard. The official
// server credits the objective (Deathguard Cyrus 1746, 5 needed) for any of them, with an empty victim GUID (sniff of 2026-10-06:
// QUEST_UPDATE_ADD_CREDIT 99134 / 1746, 1..5 of 5; Motivated was seen on 1496, 1652, 1735, 1738, 1742-1746, 2210, 5725, 272101).
class classic_spell_executors_motivator : public AuraScript
{
    static constexpr uint32 QUEST_DISCIPLINE = 99134;
    static constexpr uint32 NPC_DEATHGUARD_CYRUS = 1746;

    static bool IsTirisfalDeathguard(uint32 entry)
    {
        switch (entry)
        {
            case 1495: case 1496: case 1519: case 1652: case 1735: case 1736: case 1737: case 1738: case 1739: case 1740:
            case 1741: case 1742: case 1743: case 1744: case 1745: case 1746: case 2209: case 2210: case 5725:
            case 251001: case 257655: case 272101: case 275103:
                return true;
            default:
                return false;
        }
    }

    void HandleApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Player* player = Object::ToPlayer(GetCaster());
        if (!player || !IsTirisfalDeathguard(GetTarget()->GetEntry()) || player->GetQuestStatus(QUEST_DISCIPLINE) != QUEST_STATUS_INCOMPLETE)
            return;

        std::function<bool(QuestObjective const*)> const isDiscipline = [](QuestObjective const* objective) { return objective->QuestID == QUEST_DISCIPLINE; };
        player->UpdateQuestObjectiveProgress(QUEST_OBJECTIVE_MONSTER, NPC_DEATHGUARD_CYRUS, 1, ObjectGuid::Empty, nullptr, &isDiscipline);
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(classic_spell_executors_motivator::HandleApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

// 1289195-1289200 - Alchemy / Blacksmithing / Enchanting / Engineering / Leatherworking / Tailoring Certification (items 271621-271627,
// 1000 Merchant Favor at the trade company vendors): "unlocks the <profession> title for all characters on your account; to display
// it they must have 300 skill". The spell completes a hidden quest (95944-95949, not in our data); the account unlock is kept in
// account_classic_certification and Player::UpdateClassicProfessionTitles gives the title to characters with 300 skill.
class classic_spell_profession_certification : public SpellScript
{
    static uint32 SkillOf(uint32 spellId)
    {
        switch (spellId)
        {
            case 1289195: return SKILL_ALCHEMY;
            case 1289196: return SKILL_BLACKSMITHING;
            case 1289197: return SKILL_ENCHANTING;
            case 1289198: return SKILL_ENGINEERING;
            case 1289199: return SKILL_LEATHERWORKING;
            case 1289200: return SKILL_TAILORING;
            default: return 0;
        }
    }

    void HandleAfterCast()
    {
        Player* player = GetCaster()->ToPlayer();
        uint32 skillId = SkillOf(GetSpellInfo()->Id);
        if (!player || !skillId)
            return;

        // written directly: UpdateClassicProfessionTitles reads it right away
        CharacterDatabase.DirectPExecute("REPLACE INTO account_classic_certification (account, skill) VALUES ({}, {})",
            player->GetSession()->GetAccountId(), skillId);
        player->UpdateClassicProfessionTitles();
    }

    void Register() override
    {
        AfterCast += SpellCastFn(classic_spell_profession_certification::HandleAfterCast);
    }
};

// 1225472 - Thrill of Adventure (Legacy, Adventure tree 1188): after a kill that gives experience the official server casts 1261483
// on the killer, 10 sec of health (aura 8) and mana (aura 24) every 2 sec. Sniff of a level 1-10 dwarf shaman (5/5, aura amount 5):
// applied after 72 of 73 kills (the other one was before the talent), ticks of 1% of max health / mana (0.84 health, 0.96 mana per
// tick at 84 / 96), so the talent amount is the total percent restored over the 5 ticks.
class classic_player_thrill_of_adventure : public PlayerScript
{
public:
    classic_player_thrill_of_adventure() : PlayerScript("classic_player_thrill_of_adventure") { }

    static constexpr uint32 SPELL_THRILL_OF_ADVENTURE = 1225472;
    static constexpr uint32 SPELL_THRILL_OF_ADVENTURE_REGEN = 1261483;

    void OnCreatureKill(Player* killer, Creature* killed) override
    {
        AuraEffect const* talent = killer->GetAuraEffect(SPELL_THRILL_OF_ADVENTURE, EFFECT_0);
        // tooltip: "each time you deliver the killing blow to a non-trivial enemy. Ineffective in dungeons, raids, and battlegrounds."
        if (!talent || !talent->GetAmount() || !Trinity::XP::Gain(killer, killed) || killer->GetMap()->Instanceable())
            return;

        SpellInfo const* regen = sSpellMgr->GetSpellInfo(SPELL_THRILL_OF_ADVENTURE_REGEN, DIFFICULTY_NONE);
        if (!regen || regen->GetEffects().size() < 2 || !regen->GetEffect(EFFECT_0).ApplyAuraPeriod)
            return;

        int32 ticks = std::max(1, regen->GetMaxDuration() / int32(regen->GetEffect(EFFECT_0).ApplyAuraPeriod));
        float pctPerTick = float(talent->GetAmount()) / ticks;
        int32 health = std::max(1, int32(CalculatePct(float(killer->GetMaxHealth()), pctPerTick) + 0.5f));
        int32 mana = killer->GetMaxPower(POWER_MANA) ? std::max(1, int32(CalculatePct(float(killer->GetMaxPower(POWER_MANA)), pctPerTick) + 0.5f)) : 0;

        CastSpellExtraArgs args(TRIGGERED_FULL_MASK);
        args.AddSpellMod(SPELLVALUE_BASE_POINT0, health);
        args.AddSpellMod(SPELLVALUE_BASE_POINT1, mana);
        killer->CastSpell(killer, SPELL_THRILL_OF_ADVENTURE_REGEN, args);
    }
};

// 1225503 - Reagent Economy (Legacy, Adventure tree 1188): its effect is aura 215, which this core handles as arena preparation
// (unit flag PREPARATION + aura state). The perk must not put the player in that state; the reagent effect itself is not known yet.
class classic_spell_legacy_reagent_economy : public AuraScript
{
    void PreventArenaPreparation(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        PreventDefaultAction();
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(classic_spell_legacy_reagent_economy::PreventArenaPreparation, EFFECT_0, SPELL_AURA_ARENA_PREPARATION, AURA_EFFECT_HANDLE_REAL);
        OnEffectRemove += AuraEffectRemoveFn(classic_spell_legacy_reagent_economy::PreventArenaPreparation, EFFECT_0, SPELL_AURA_ARENA_PREPARATION, AURA_EFFECT_HANDLE_REAL);
    }
};

// 1225505 - Fast Recovery (Legacy): "You recover an additional ${$m1/10}.1% of your Health and Mana every 5 sec while not in combat." Effect 0
// is a periodic dummy (5 sec) without a trigger spell, so nothing was recovered. The amount is in tenths of a percent.
class classic_spell_legacy_fast_recovery : public AuraScript
{
    void HandlePeriodic(AuraEffect const* aurEff)
    {
        PreventDefaultAction();

        Unit* target = GetTarget();
        if (target->IsInCombat() || !target->IsAlive() || aurEff->GetAmount() <= 0)
            return;

        float const pct = float(aurEff->GetAmount()) / 10.0f;
        if (!target->IsFullHealth())
            target->ModifyHealth(int32(CalculatePct(float(target->GetMaxHealth()), pct) + 0.5f));

        if (target->GetMaxPower(POWER_MANA) && target->GetPower(POWER_MANA) < target->GetMaxPower(POWER_MANA))
            target->ModifyPower(POWER_MANA, int32(CalculatePct(float(target->GetMaxPower(POWER_MANA)), pct) + 0.5f));
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(classic_spell_legacy_fast_recovery::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
    }
};

// 1225494 - Second Home (Legacy): "Returns you to the rest area where you most recently set your Second Home. When used in a rest area,
// makes that location your Second Home. This ability shares a cooldown with Hearthstones." The client spell is a dummy. The location is kept
// in the client's Second Home aura 1262044 (infinite, death persistent, four dummy effects): map, then x, y and z in tenths of a yard, so it
// is saved with the character. Setting the location does not start the shared cooldown; the return does (Hearthstone category).
class classic_spell_legacy_second_home : public SpellScript
{
    static constexpr uint32 SPELL_SECOND_HOME_LOCATION = 1262044;

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellEffect({ { SPELL_SECOND_HOME_LOCATION, EFFECT_3 } });
    }

    static bool IsInRestArea(Player const* player)
    {
        return player->GetRestMgr().HasRestFlag(REST_FLAG_IN_TAVERN) || player->GetRestMgr().HasRestFlag(REST_FLAG_IN_CITY);
    }

    SpellCastResult CheckCast()
    {
        Player* player = GetCaster()->ToPlayer();
        if (!player)
            return SPELL_FAILED_BAD_TARGETS;

        if (!IsInRestArea(player) && !player->HasAura(SPELL_SECOND_HOME_LOCATION))
            return SPELL_FAILED_NOT_HERE;

        return SPELL_CAST_OK;
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Player* player = GetCaster()->ToPlayer();
        if (!player)
            return;

        if (IsInRestArea(player))
        {
            player->RemoveAurasDueToSpell(SPELL_SECOND_HOME_LOCATION);
            CastSpellExtraArgs args(TRIGGERED_FULL_MASK);
            args.AddSpellMod(SPELLVALUE_BASE_POINT0, player->GetMapId());
            args.AddSpellMod(SPELLVALUE_BASE_POINT1, std::round(player->GetPositionX() * 10.0f));
            args.AddSpellMod(SPELLVALUE_BASE_POINT2, std::round(player->GetPositionY() * 10.0f));
            args.AddSpellMod(SPELLVALUE_BASE_POINT3, std::round(player->GetPositionZ() * 10.0f));
            player->CastSpell(player, SPELL_SECOND_HOME_LOCATION, args);
            _locationSet = true;
            return;
        }

        Aura const* home = player->GetAura(SPELL_SECOND_HOME_LOCATION);
        if (!home)
            return;

        auto coordinate = [home](SpellEffIndex effIndex) { return float(home->GetEffect(effIndex)->GetAmount()) / 10.0f; };
        player->TeleportTo(uint32(home->GetEffect(EFFECT_0)->GetAmount()), coordinate(EFFECT_1), coordinate(EFFECT_2), coordinate(EFFECT_3),
            player->GetOrientation(), TELE_TO_SPELL, {}, GetSpellInfo()->Id);
    }

    void HandleAfterCast()
    {
        if (_locationSet)
            GetCaster()->GetSpellHistory()->ResetCooldown(GetSpellInfo()->Id, true);
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(classic_spell_legacy_second_home::CheckCast);
        OnEffectHitTarget += SpellEffectFn(classic_spell_legacy_second_home::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        AfterCast += SpellCastFn(classic_spell_legacy_second_home::HandleAfterCast);
    }

    bool _locationSet = false;
};

// 1262044 - Second Home (location): the amounts are the saved location and must never be recalculated.
class classic_spell_legacy_second_home_location : public AuraScript
{
    void CalcAmount(AuraEffect const* /*aurEff*/, SpellEffectValue& /*amount*/, bool& canBeRecalculated)
    {
        canBeRecalculated = false;
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(classic_spell_legacy_second_home_location::CalcAmount, EFFECT_ALL, SPELL_AURA_DUMMY);
    }
};

// Boss celebration buffs (ClassicLegacyPerks::IsBossCelebrationBuff) with 1225508 Second Chance: Unit::RemoveAllAurasOnDeath keeps them through
// the first death and marks it with 1262777; when the last of them is gone the mark goes too, so the next ones get their own second chance.
class classic_spell_legacy_boss_celebration_buff : public AuraScript
{
    void AfterRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        if (!target->HasAura(ClassicLegacyPerks::SECOND_CHANCE_USED))
            return;

        for (auto const& [spellId, aura] : target->GetOwnedAuras())
            if (aura != GetAura() && ClassicLegacyPerks::IsBossCelebrationBuff(spellId))
                return;

        target->RemoveAurasDueToSpell(ClassicLegacyPerks::SECOND_CHANCE_USED);
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(classic_spell_legacy_boss_celebration_buff::AfterRemove, EFFECT_FIRST_FOUND, SPELL_AURA_ANY,
            AURA_EFFECT_HANDLE_REAL);
    }
};

// 1225469 - Dedicated Study (Legacy, Professions tree 1187), a castable spell: "Increases your skill by 1 in your lowest tradeskill among
// your Primary and Secondary tradeskills. If you have already reached 300 skill in your two current Primary Tradeskills and all three
// Secondary Tradeskills, you will gain $s1 of a random Elemental Essence."
class classic_spell_legacy_dedicated_study : public SpellScript
{
    static constexpr uint16 MaxTradeskill = 300;
    static constexpr uint32 ElementalEssences[] = { 7076, 7078, 7080, 7082 };   // Earth, Fire, Water, Air

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Player* player = GetCaster()->ToPlayer();
        if (!player)
            return;

        uint32 lowestSkill = 0;
        uint16 lowestValue = std::numeric_limits<uint16>::max();
        uint32 primaries = 0;
        bool allMaxed = true;
        for (SkillLineEntry const* skillLine : sSkillLineStore)
        {
            if (skillLine->ParentSkillLineID || (skillLine->CategoryID != SKILL_CATEGORY_PROFESSION && skillLine->CategoryID != SKILL_CATEGORY_SECONDARY))
                continue;
            if (!player->HasSkill(skillLine->ID))
                continue;

            uint16 value = player->GetPureSkillValue(skillLine->ID);
            if (skillLine->CategoryID == SKILL_CATEGORY_PROFESSION)
                ++primaries;
            if (value < MaxTradeskill)
                allMaxed = false;
            if (value < player->GetPureMaxSkillValue(skillLine->ID) && value < lowestValue)
            {
                lowestValue = value;
                lowestSkill = skillLine->ID;
            }
        }

        bool secondariesMaxed = player->GetPureSkillValue(SKILL_COOKING) >= MaxTradeskill && player->GetPureSkillValue(129 /* First Aid */) >= MaxTradeskill
            && player->GetPureSkillValue(SKILL_FISHING) >= MaxTradeskill;
        if (allMaxed && primaries >= 2 && secondariesMaxed)
        {
            player->AddItem(Trinity::Containers::SelectRandomContainerElement(ElementalEssences), std::max(1, GetEffectValueAsInt()));
            return;
        }

        if (lowestSkill)
            player->SetSkill(lowestSkill, player->GetSkillStep(lowestSkill), lowestValue + 1, player->GetPureMaxSkillValue(lowestSkill));
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(classic_spell_legacy_dedicated_study::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 11196 - Recently Bandaged: Legacy perk Field Medicine 1225475 (Adventure tree) shortens it by its amount in ms (negative) when the
// bandage user has the perk. "Ineffective in dungeons, raids, and battlegrounds."
class classic_spell_recently_bandaged_field_medicine : public AuraScript
{
    void HandleApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Player const* bandager = Object::ToPlayer(GetCaster());
        if (!bandager || bandager->GetMap()->Instanceable())
            return;

        int32 reduction = bandager->GetClassicLegacyPerkAmount(1225475, EFFECT_0);
        if (reduction >= 0)
            return;

        Aura* aura = GetAura();
        int32 duration = std::max(1000, aura->GetMaxDuration() + reduction);
        aura->SetMaxDuration(duration);
        aura->SetDuration(duration);
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(classic_spell_recently_bandaged_field_medicine::HandleApply, EFFECT_0, SPELL_AURA_ANY, AURA_EFFECT_HANDLE_REAL);
    }
};

// 1225477 - High Alert (Legacy, Adventure tree 1188): stealth detection as if your level were higher. "Ineffective in Battlegrounds."
class classic_spell_legacy_high_alert : public AuraScript
{
    void CalculateAmount(AuraEffect const* /*aurEff*/, SpellEffectValue& amount, bool& canBeRecalculated)
    {
        canBeRecalculated = true;
        if (GetUnitOwner()->GetMap()->IsBattlegroundOrArena())
            amount = 0;
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(classic_spell_legacy_high_alert::CalculateAmount, EFFECT_0, SPELL_AURA_MOD_STEALTH_DETECT);
    }
};

// Seal of Fury (Forever, 1311649 1311656 20163 20419 20421 20422 20423): "Fills the Paladin with divine fury for 30 sec, causing melee
// attacks to deal an additional N Holy damage. While a shield is equipped, each attack also grants an absorb shield equal to 50% of the
// Holy damage dealt." Its judgement (Judgement of Fury) is in the seal table of SpellInfo.cpp.
static uint32 ClassicSealOfFuryDamageSpell(uint32 sealId)
{
    switch (sealId)
    {
        case 1311649: return 1311647;
        case 1311656: return 1311654;
        case 20163:   return 20231;
        case 20419:   return 20415;
        case 20421:   return 20416;
        case 20422:   return 20417;
        case 20423:   return 20418;
        default:      return 0;
    }
}

class classic_spell_pal_seal_of_fury : public AuraScript
{
    bool Validate(SpellInfo const* spellInfo) override
    {
        return ValidateSpellInfo({ ClassicSealOfFuryDamageSpell(spellInfo->Id) });
    }

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        return eventInfo.GetActionTarget() && eventInfo.GetDamageInfo() && eventInfo.GetDamageInfo()->GetAttackType() == BASE_ATTACK
            && !eventInfo.GetSpellInfo();
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();
        GetTarget()->CastSpell(eventInfo.GetActionTarget(), ClassicSealOfFuryDamageSpell(GetId()), CastSpellExtraArgs(aurEff));
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(classic_spell_pal_seal_of_fury::CheckProc);
        OnEffectProc += AuraEffectProcFn(classic_spell_pal_seal_of_fury::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

// Seal of Fury Holy damage (1311647 1311654 20231 20415-20418): with a shield equipped the paladin gains Light's Fury (1310927), an
// absorb shield of the seal's effect 1 percent (50) of the damage dealt
class classic_spell_pal_seal_of_fury_damage : public SpellScript
{
    static constexpr uint32 SPELL_LIGHTS_FURY = 1310927;

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_LIGHTS_FURY });
    }

    void HandleAfterHit()
    {
        Player* paladin = Object::ToPlayer(GetCaster());
        if (!paladin || GetHitDamage() <= 0)
            return;

        Item const* offhand = paladin->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND);
        if (!offhand || offhand->GetTemplate()->GetClass() != ITEM_CLASS_ARMOR || offhand->GetTemplate()->GetSubClass() != ITEM_SUBCLASS_ARMOR_SHIELD)
            return;

        for (uint32 sealId : { 1311649u, 1311656u, 20163u, 20419u, 20421u, 20422u, 20423u })
        {
            if (Aura const* seal = paladin->GetAura(sealId))
            {
                // effect 1 is a plain value (Effect 0), not an aura effect
                int32 absorb = CalculatePct(GetHitDamage(), seal->GetSpellInfo()->GetEffect(EFFECT_1).CalcValue(paladin));
                if (absorb > 0)
                    paladin->CastSpell(paladin, SPELL_LIGHTS_FURY, CastSpellExtraArgs(TRIGGERED_FULL_MASK).AddSpellBP0(absorb));
                break;
            }
        }
    }

    void Register() override
    {
        AfterHit += SpellHitFn(classic_spell_pal_seal_of_fury_damage::HandleAfterHit);
    }
};

// Well Fed from the Forever foods (1248406 1248420-1248422 1248688 1249519-1249521 1249523 1249907 1249926 1249927 1319310): "Experience
// gained from kills increased by 5%" while the player meets the client's condition for the boost (PlayerCondition 142418: the world
// state of the levelling event and the level range). Nothing applied Well Fed XP Boost (1243969), so the food never gave the extra
// experience. It now comes and goes with the Well Fed aura and lasts as long.
class classic_spell_well_fed_xp_boost : public AuraScript
{
    static constexpr uint32 SPELL_WELL_FED_XP_BOOST = 1243969;
    static constexpr uint32 CONDITION_XP_BOOST = 142418;

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_WELL_FED_XP_BOOST });
    }

    void HandleApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Player* player = GetTarget()->ToPlayer();
        if (!player || !ConditionMgr::IsPlayerMeetingCondition(player, CONDITION_XP_BOOST))
            return;

        player->CastSpell(player, SPELL_WELL_FED_XP_BOOST, CastSpellExtraArgs(TRIGGERED_FULL_MASK).SetTriggeringAura(GetEffect(EFFECT_0)));
        if (Aura* boost = player->GetAura(SPELL_WELL_FED_XP_BOOST))
        {
            boost->SetMaxDuration(GetMaxDuration());
            boost->SetDuration(GetDuration());
        }
    }

    void HandleRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetTarget()->RemoveAurasDueToSpell(SPELL_WELL_FED_XP_BOOST);
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(classic_spell_well_fed_xp_boost::HandleApply, EFFECT_0, SPELL_AURA_ANY, AURA_EFFECT_HANDLE_REAL);
        AfterEffectRemove += AuraEffectRemoveFn(classic_spell_well_fed_xp_boost::HandleRemove, EFFECT_0, SPELL_AURA_ANY, AURA_EFFECT_HANDLE_REAL);
    }
};

// Unsealed Wrath (talent 1310735): "Your melee attacks store a copy of your active Seal for 15 sec, stacking up to 3 times. Landing an
// attack with a different Seal consumes all stacks, giving the stored Seal its normal chance to activate once per stack." The stored copy is
// the seal's Echo aura (Echo of Fury / Command / Righteousness / Justice / Light / Wisdom, 3 stacks). A replay does what the seal does on a
// swing: Righteousness and Fury their scripted Holy hit, the others their triggered spell at the seal's own chance (Seal of Command's 7 per
// minute). Seal of the Crusader has no Echo. The rank replayed is the one that was stored; after a relog, the paladin's best known rank.
class classic_spell_pal_unsealed_wrath : public AuraScript
{
    enum SealKind : uint8 { SEAL_RIGHTEOUSNESS, SEAL_COMMAND, SEAL_JUSTICE, SEAL_LIGHT, SEAL_WISDOM, SEAL_FURY, SEAL_KIND_MAX };

    struct SealKindInfo
    {
        uint32 echo;
        std::initializer_list<uint32> ranks;   // lowest first
    };

    static SealKindInfo const& Info(uint8 kind)
    {
        static SealKindInfo const table[SEAL_KIND_MAX] =
        {
            { 1311704, { 20154, 21084, 20287, 20288, 20289, 20290, 20291, 20292, 20293 } },
            { 1311703, { 20375, 20915, 20918, 20919, 20920 } },
            { 1311705, { 20164 } },
            { 1328198, { 20165, 20347, 20348, 20349 } },
            { 1328206, { 20166, 20356, 20357 } },
            { 1311701, { 1311649, 1311656, 20163, 20419, 20421, 20422, 20423 } },
        };
        return table[kind];
    }

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        for (uint8 kind = 0; kind < SEAL_KIND_MAX; ++kind)
            if (!ValidateSpellInfo({ Info(kind).echo }))
                return false;
        return true;
    }

    // The seal aura on the paladin, and its kind
    static Aura const* ActiveSeal(Unit const* paladin, uint8& kindOut)
    {
        for (uint8 kind = 0; kind < SEAL_KIND_MAX; ++kind)
            for (uint32 sealId : Info(kind).ranks)
                if (Aura const* seal = paladin->GetAura(sealId))
                {
                    kindOut = kind;
                    return seal;
                }
        return nullptr;
    }

    uint32 StoredRank(Player const* paladin, uint8 kind) const
    {
        if (_stored[kind] && paladin->HasSpell(_stored[kind]))
            return _stored[kind];
        uint32 best = 0;
        for (uint32 sealId : Info(kind).ranks)
            if (paladin->HasSpell(sealId))
                best = sealId;
        return best;
    }

    static void Replay(Player* paladin, Unit* victim, uint8 kind, uint32 sealId)
    {
        SpellInfo const* seal = sSpellMgr->GetSpellInfo(sealId, DIFFICULTY_NONE);
        if (!seal)
            return;

        CastSpellExtraArgs args(TRIGGERED_FULL_MASK);
        switch (kind)
        {
            case SEAL_RIGHTEOUSNESS:
                classic_spell_pal_seal_of_righteousness::Hit(paladin, victim, sealId, float(seal->GetEffect(EFFECT_0).CalcValue(paladin)), args);
                return;
            case SEAL_FURY:
                if (uint32 damageSpell = ClassicSealOfFuryDamageSpell(sealId))
                    paladin->CastSpell(victim, damageSpell, args);
                return;
            default:
                break;
        }

        SpellEffectInfo const& effect = seal->GetEffect(EFFECT_0);
        if (effect.ApplyAuraName != SPELL_AURA_PROC_TRIGGER_SPELL || !effect.TriggerSpell)
            return;

        float chance = float(seal->ProcChance);
        if (SpellProcEntry const* procEntry = sSpellMgr->GetSpellProcEntry(seal))
        {
            if (procEntry->ProcsPerMinute > 0.0f)
                chance = paladin->GetPPMProcChance(paladin->GetBaseAttackTime(BASE_ATTACK), procEntry->ProcsPerMinute, seal);
            else if (procEntry->Chance > 0.0f)
                chance = procEntry->Chance;
        }
        if (!roll_chance(chance))
            return;

        paladin->CastSpell(victim, effect.TriggerSpell, args);
    }

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        return GetTarget()->IsPlayer() && eventInfo.GetActionTarget() && eventInfo.GetActionTarget()->IsAlive() && eventInfo.GetDamageInfo()
            && eventInfo.GetDamageInfo()->GetAttackType() == BASE_ATTACK && !eventInfo.GetSpellInfo();
    }

    void HandleProc(ProcEventInfo& eventInfo)
    {
        Player* paladin = GetTarget()->ToPlayer();
        Unit* victim = eventInfo.GetActionTarget();

        uint8 activeKind = SEAL_KIND_MAX;
        Aura const* active = ActiveSeal(paladin, activeKind);
        if (!active)
            return;
        uint32 const activeSealId = active->GetId();

        // Other seals' stored copies go off, one replay per stack
        for (uint8 kind = 0; kind < SEAL_KIND_MAX; ++kind)
        {
            if (kind == activeKind)
                continue;
            Aura* echo = paladin->GetAura(Info(kind).echo);
            if (!echo)
                continue;
            uint8 const stacks = echo->GetStackAmount();
            uint32 const sealId = StoredRank(paladin, kind);
            paladin->RemoveAura(echo);
            for (uint8 i = 0; i < stacks && sealId && victim->IsAlive(); ++i)
                Replay(paladin, victim, kind, sealId);
        }

        // Store the active seal (stacks to 3 and refreshes on its own)
        _stored[activeKind] = activeSealId;
        paladin->CastSpell(paladin, Info(activeKind).echo, CastSpellExtraArgs(TRIGGERED_FULL_MASK));
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(classic_spell_pal_unsealed_wrath::CheckProc);
        OnProc += AuraProcFn(classic_spell_pal_unsealed_wrath::HandleProc);
    }

    std::array<uint32, SEAL_KIND_MAX> _stored = { };
};

// Judgement of Fury (20183 20411-20414 1311650 1311655): "Unleashing this Seal's energy causes Holy damage to an enemy and taunts the
// target to attack you for 4 sec." Effect 1 (dummy) is the taunt, effect 2 (dummy) the extra threat.
// The taunt is 9970901 (serverside, SPELL_AURA_MOD_TAUNT for 4 sec): matching the threat alone left a mob on its current target, because
// the victim only changes past the 110%/130% threshold. The taunt aura fixates the mob on the paladin like Taunt and Growl, and the
// matched threat keeps it there afterwards. Taunt immune bosses ignore it.
enum ClassicPaladinJudgementOfFury
{
    SPELL_PAL_JUDGEMENT_OF_FURY_TAUNT = 9970901
};

class classic_spell_pal_judgement_of_fury : public SpellScript
{
    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PAL_JUDGEMENT_OF_FURY_TAUNT });
    }

    void HandleTaunt(SpellEffIndex /*effIndex*/)
    {
        Creature* target = Object::ToCreature(GetHitUnit());
        Unit* paladin = GetCaster()->ToUnit();
        if (!target || !paladin || !target->CanHaveThreatList())
            return;

        target->GetThreatManager().MatchUnitThreatToHighestThreat(paladin);
        paladin->CastSpell(target, SPELL_PAL_JUDGEMENT_OF_FURY_TAUNT, CastSpellExtraArgs(TRIGGERED_FULL_MASK)
            .SetTriggeringSpell(GetSpell())
            .AddSpellMod(SPELLVALUE_DURATION, 4 * IN_MILLISECONDS));
    }

    // effect 2 has no implicit target, so it runs once in hit mode against the judged unit
    void HandleThreat(SpellEffIndex /*effIndex*/)
    {
        Creature* target = Object::ToCreature(GetExplTargetUnit());
        Unit* paladin = GetCaster()->ToUnit();
        if (target && paladin && target->CanHaveThreatList())
            target->GetThreatManager().AddThreat(paladin, float(GetEffectValue()), GetSpellInfo(), true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(classic_spell_pal_judgement_of_fury::HandleTaunt, EFFECT_1, SPELL_EFFECT_DUMMY);
        OnEffectHit += SpellEffectFn(classic_spell_pal_judgement_of_fury::HandleThreat, EFFECT_2, SPELL_EFFECT_DUMMY);
    }
};

// 26573, 20116, 20922, 20923, 20924 - Consecration (Classic 1.60, official dungeon sniff): the cast puts a 1 sec periodic dummy on the
// paladin for 8 sec and creates area trigger 41311-41316 at his feet (no data on our server); each tick the official server casts the
// rank's Consecration damage (1280345-1280349) at the consecrated spot, hitting the enemies standing in it.
// Forever.VanillaAoE = 1: each tick does the vanilla damage instead (ClassicVanillaAoe.h): effect 0 for 0, effect 1 (the one with
// the spell power) for the vanilla tick, on every enemy in it.
class classic_spell_pal_consecration : public AuraScript
{
    static uint32 TickSpell(uint32 spellId)
    {
        return ClassicVanillaAoe::ConsecrationTickSpell(spellId);
    }

    bool Validate(SpellInfo const* spellInfo) override
    {
        return TickSpell(spellInfo->Id) && ValidateSpellInfo({ TickSpell(spellInfo->Id) });
    }

    void HandleApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        _center = GetUnitOwner()->GetPosition();
    }

    void HandleTick(AuraEffect const* aurEff)
    {
        PreventDefaultAction();
        Unit* paladin = GetUnitOwner();
        CastSpellExtraArgs args(aurEff);
        if (sWorld->getBoolConfig(CONFIG_FOREVER_VANILLA_AOE))
        {
            if (ClassicVanillaAoe::ConsecrationRank const* rank = ClassicVanillaAoe::FindConsecrationRank(GetId()))
            {
                args.AddSpellMod(SPELLVALUE_BASE_POINT0, 0);
                args.AddSpellMod(SPELLVALUE_BASE_POINT1, rank->VanillaTick);
            }
        }
        paladin->CastSpell(_center, TickSpell(GetId()), args);
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(classic_spell_pal_consecration::HandleApply, EFFECT_2, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL);
        OnEffectPeriodic += AuraEffectPeriodicFn(classic_spell_pal_consecration::HandleTick, EFFECT_2, SPELL_AURA_PERIODIC_DUMMY);
    }

    Position _center;
};

// 1280345-1280349 - Consecration tick (Forever): "the first 4 enemies" take effect 1, the bigger hit with the spell power; every
// enemy in it takes effect 0. The client data has no target cap on effect 1, so every enemy took both hits. Forever.VanillaAoE = 1
// keeps vanilla (effect 1 is the vanilla tick on every enemy, effect 0 is 0).
class classic_spell_pal_consecration_tick : public SpellScript
{
    static constexpr uint32 FULL_HIT_TARGETS = 4;

    void HandleFullHit(SpellEffIndex effIndex)
    {
        if (sWorld->getBoolConfig(CONFIG_FOREVER_VANILLA_AOE))
            return;

        if (_fullHits < FULL_HIT_TARGETS)
            ++_fullHits;
        else
            PreventHitDefaultEffect(effIndex);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(classic_spell_pal_consecration_tick::HandleFullHit, EFFECT_1, SPELL_EFFECT_ANY);
    }

    uint32 _fullHits = 0;
};

// 15286 - Vampiric Embrace (vanilla, VMaNGOS UnitAuraProcHandler): a debuff on the enemy. Shadow damage the priest deals to it
// heals the priest's party (15290, the priest included) for 20% of the damage. The retail script treated it as a self buff and
// made the debuffed enemy cast the heal.
// WoW Forever: Spirit Tap 15270 "Gives you a $m1% chance ... after killing a non-trivial target or when an enemy afflicted by your Vampiric
// Embrace dies": the second part has no proc flag, so when the debuffed enemy dies, a priest with the talent gets 15271 without a roll,
// whoever made the kill (tooltip; wowsims/forever, MIT, sim/priest/talents_shadow.go; no log reading).
class classic_spell_pri_vampiric_embrace : public AuraScript
{
    static constexpr uint32 SPELL_VAMPIRIC_EMBRACE_HEAL = 15290;
    static constexpr uint32 SPELL_SPIRIT_TAP = 15270;
    static constexpr uint32 SPELL_SPIRIT_TAP_BUFF = 15271;

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_VAMPIRIC_EMBRACE_HEAL, SPELL_SPIRIT_TAP_BUFF });
    }

    void HandleRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (GetTargetApplication()->GetRemoveMode() != AURA_REMOVE_BY_DEATH || GetTarget()->IsCritter())
            return;

        Unit* priest = GetCaster();
        if (priest && priest->IsAlive() && priest->HasAura(SPELL_SPIRIT_TAP))
            priest->CastSpell(priest, SPELL_SPIRIT_TAP_BUFF, CastSpellExtraArgs(TRIGGERED_FULL_MASK));
    }

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        DamageInfo const* damageInfo = eventInfo.GetDamageInfo();
        return damageInfo && damageInfo->GetDamage() && eventInfo.GetActor() && eventInfo.GetActor()->GetGUID() == GetCasterGUID();
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();
        Unit* priest = eventInfo.GetActor();
        int32 heal = std::max<int32>(1, CalculatePct(int32(eventInfo.GetDamageInfo()->GetDamage()), aurEff->GetAmount()));

        CastSpellExtraArgs args(aurEff);
        args.AddSpellMod(SPELLVALUE_BASE_POINT0, heal);
        priest->CastSpell(priest, SPELL_VAMPIRIC_EMBRACE_HEAL, args);
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(classic_spell_pri_vampiric_embrace::CheckProc);
        OnEffectProc += AuraEffectProcFn(classic_spell_pri_vampiric_embrace::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
        AfterEffectRemove += AuraEffectRemoveFn(classic_spell_pri_vampiric_embrace::HandleRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

// WoW Forever: Moonshadow Stave 22458, "Harmful spell casts have a chance to deal 91 Arcane or Shadow damage". The aura 1300435 is a dummy
// with no spell to fire, so it did nothing. It rolls once for each enemy a harmful spell lands on (a damage-free debuff or Hurricane's
// cast included); damage over time ticks, misses, helpful casts, melee and spells fired as a proc (Hurricane's waves) never roll it, and
// its 10 ms cooldown lets one cast proc it once. Aura::CalcProcChance prices the row's 1.5 a minute on the cast time. Each proc fires
// Shadow 1300437 or Arcane 1300438, one in two each, at the target (165 Shadow, 194 Arcane of 359; wowsims/forever, MIT, docs/evidence
// EV-0115).
// WoW Forever dungeon set procs that roll on spell casts (Crusader's Wrath 450625, The Furious Storm 450626, Nature's Bounty 450608,
// Vestments of the Devout 450576): only a cast that costs mana rolls, on the global cooldown or off it (Judgement, Holy Shield, seals,
// Counterspell); a free one rolls nothing (Swift Judgement 0 of 65, Water Shield 0 of 75, Evocation 0 of 91). White swings roll as their
// rows say (wowsims/forever, MIT, docs/evidence EV-0144). PROC_ATTR_REQ_POWER_COST would refuse the swings too.
class classic_spell_item_set_proc_mana_cast : public AuraScript
{
protected:
    bool CheckProc(ProcEventInfo& eventInfo)
    {
        Spell const* procSpell = eventInfo.GetProcSpell();
        if (!procSpell)
            return true;
        return std::ranges::any_of(procSpell->GetPowerCost(), [](SpellPowerCost const& cost) { return cost.Power == POWER_MANA && cost.Amount > 0; });
    }

public:
    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(classic_spell_item_set_proc_mana_cast::CheckProc);
    }
};

// 450608 - Nature's Bounty (Wildheart Raiment 5-piece, Feralheart Raiment reissue 4-piece): a dummy that fired nothing. A spell cast
// that costs mana restores mana (27782), 1 a minute on the cast time (64 of 2,827 casts, measured); a landed white swing gives 27784
// and a melee hit taken 10 rage (27783), whose rates are unmeasured and take the same row (wowsims/forever, MIT, EV-0144,
// sim/common/forever/items_sets.go).
class classic_spell_item_natures_bounty : public classic_spell_item_set_proc_mana_cast
{
    static constexpr uint32 SPELL_NATURES_BOUNTY_MANA = 27782;
    static constexpr uint32 SPELL_NATURES_BOUNTY_RAGE = 27783;
    static constexpr uint32 SPELL_NATURES_BOUNTY_ENERGY = 27784;

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_NATURES_BOUNTY_MANA, SPELL_NATURES_BOUNTY_RAGE, SPELL_NATURES_BOUNTY_ENERGY });
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();
        Unit* druid = GetTarget();
        uint32 spellId = SPELL_NATURES_BOUNTY_MANA;
        if (eventInfo.GetTypeMask() & PROC_FLAG_DEAL_MELEE_SWING)
            spellId = SPELL_NATURES_BOUNTY_ENERGY;
        else if (eventInfo.GetTypeMask() & (PROC_FLAG_TAKE_MELEE_SWING | PROC_FLAG_TAKE_MELEE_ABILITY))
            spellId = SPELL_NATURES_BOUNTY_RAGE;
        druid->CastSpell(druid, spellId, CastSpellExtraArgs(aurEff));
    }

    void Register() override
    {
        classic_spell_item_set_proc_mana_cast::Register();
        OnEffectProc += AuraEffectProcFn(classic_spell_item_natures_bounty::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

// 24574 - Brittle Armor (Zandalarian Hero Badge 19948 on use): "Increases your armor by 2000 and defense skill by 30 for 20 sec. Every time
// you take melee or ranged damage, this bonus is reduced by 200 armor and 3 defense." The on-use row puts on the hit listener (24590, whose
// script spell_item_brittle_armor takes a stack off) and triggers 29284, which the client does not have, so the 10-stack buff 24575 never
// went on and the badge gave nothing. The cast now applies it at its 10 stacks (wowsims/forever, MIT, tools/database/overrides/
// hand_triggers.go, tooltip).
class classic_spell_item_zandalarian_hero_badge : public SpellScript
{
    static constexpr uint32 SPELL_BRITTLE_ARMOR_BUFF = 24575;

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_BRITTLE_ARMOR_BUFF });
    }

    void HandleAfterCast()
    {
        Unit* caster = GetCaster();
        caster->CastSpell(caster, SPELL_BRITTLE_ARMOR_BUFF, CastSpellExtraArgs(TRIGGERED_FULL_MASK));
        if (Aura* buff = caster->GetAura(SPELL_BRITTLE_ARMOR_BUFF, caster->GetGUID()))
            buff->SetStackAmount(uint8(buff->GetSpellInfo()->StackAmount ? buff->GetSpellInfo()->StackAmount : 10));
    }

    void Register() override
    {
        AfterCast += SpellCastFn(classic_spell_item_zandalarian_hero_badge::HandleAfterCast);
    }
};

// 28849 - Totem of Flowing Water 23005: "Regain up to $28850s1 mana each time you cast Lesser Healing Wave." The aura is a dummy that fired
// nothing, and its class mask names bit 5 of the shaman family, under which no spell is filed; Lesser Healing Wave is bit 7 (spell_proc row,
// sql 2026_11_19_57). Each cast restores 28850's mana (wowsims/forever, MIT, tools/database/overrides/spell_overrides.go, tooltip).
class classic_spell_item_totem_of_flowing_water : public AuraScript
{
    static constexpr uint32 SPELL_FLOWING_WATER_MANA = 28850;

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_FLOWING_WATER_MANA });
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& /*eventInfo*/)
    {
        PreventDefaultAction();
        GetTarget()->CastSpell(GetTarget(), SPELL_FLOWING_WATER_MANA, CastSpellExtraArgs(aurEff));
    }

    void Register() override
    {
        OnEffectProc += AuraEffectProcFn(classic_spell_item_totem_of_flowing_water::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

// 17350 - Argent Defender: "Has a chance when struck in combat", about twice as likely when an Undead strikes (its second effect, a dummy
// of 2). The spell_proc row prices 1 a minute on the attacker's swing interval, the Undead rate; any other attacker passes half the time,
// 0.5 a minute, both behind the client's 20 s cooldown (wowsims/forever, MIT, docs/evidence EV-0126).
class classic_spell_item_argent_defender : public AuraScript
{
    bool CheckProc(ProcEventInfo& eventInfo)
    {
        Unit* attacker = eventInfo.GetActor();
        if (attacker && attacker->GetCreatureType() == CREATURE_TYPE_UNDEAD)
            return true;
        return roll_chance(50);
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(classic_spell_item_argent_defender::CheckProc);
    }
};

// 10373, 16549, 18107, 18206, 1300185 - Fatal Wound / Wound (Pendulum of Doom 9425, Blackhand Doomsaw 12583, Gut Ripper 2164, Diabolic Skiver
// 9475, Deathblow 10628): "Deals $s2% increased damage to targets below $s3% health." Both are dummies that nothing read, so the bonus never
// landed. A hit on a target below the third effect's health percent deals the second effect's percent more (wowsims/forever, MIT,
// sim/common/forever/items_weapons.go, EV-0136).
class classic_spell_item_fatal_wound : public SpellScript
{
    bool Validate(SpellInfo const* spellInfo) override
    {
        return ValidateSpellEffect({ { spellInfo->Id, EFFECT_2 } });
    }

    void CalcDamage(SpellEffectInfo const& /*spellEffectInfo*/, Unit* victim, int32& /*damage*/, int32& /*flatMod*/, float& pctMod)
    {
        if (!victim)
            return;

        int32 const healthPct = GetEffectInfo(EFFECT_2).CalcValueAsInt(GetCaster());
        if (healthPct > 0 && victim->HealthBelowPct(float(healthPct)))
            AddPct(pctMod, GetEffectInfo(EFFECT_1).CalcValueAsInt(GetCaster()));
    }

    void Register() override
    {
        SpellScript::CalcDamage += SpellCalcDamageFn(classic_spell_item_fatal_wound::CalcDamage);
    }
};

// Weapon procs that "deal $s2 times as much damage" to one kind of enemy, the multiplier being a second effect, a dummy, that nothing read:
// Drain Life 16414 and Corpse Eater 1299869 (health leech) and Smite 1299631 against Undead, Lightning Bolt 1292851 against Mechanical,
// Holy Cleaver 1293787 against Undead and boars ("Swine"), Blazewind Blast 1282503 against wolves. Blazewind Blast's tooltip also names
// Worgen, who are humanoids with no family to tell them apart, so only wolves get it (wowsims/forever, MIT, tools/database/overrides/
// spell_overrides.go, VersusBonuses).
class classic_spell_item_versus_bonus : public SpellScript
{
    static bool IsFamily(Unit const* victim, CreatureFamily family)
    {
        Creature const* creature = victim->ToCreature();
        return creature && creature->GetCreatureTemplate()->family == family;
    }

    static bool HasBonusAgainst(uint32 spellId, Unit const* victim)
    {
        switch (spellId)
        {
            case 16414:   // Drain Life
            case 1299869: // Corpse Eater
            case 1299631: // Smite
                return victim->GetCreatureType() == CREATURE_TYPE_UNDEAD;
            case 1292851: // Lightning Bolt
                return victim->GetCreatureType() == CREATURE_TYPE_MECHANICAL;
            case 1293787: // Holy Cleaver
                return victim->GetCreatureType() == CREATURE_TYPE_UNDEAD || IsFamily(victim, CREATURE_FAMILY_BOAR);
            case 1282503: // Blazewind Blast
                return IsFamily(victim, CREATURE_FAMILY_WOLF);
            default:
                return false;
        }
    }

    bool Validate(SpellInfo const* spellInfo) override
    {
        return ValidateSpellEffect({ { spellInfo->Id, EFFECT_1 } });
    }

    void CalcDamage(SpellEffectInfo const& /*spellEffectInfo*/, Unit* victim, int32& /*damage*/, int32& /*flatMod*/, float& pctMod)
    {
        if (!victim || !HasBonusAgainst(GetSpellInfo()->Id, victim))
            return;

        float const multiplier = float(GetEffectInfo(EFFECT_1).CalcValue(GetCaster()));
        if (multiplier > 1.0f)
            pctMod *= multiplier;
    }

    void Register() override
    {
        SpellScript::CalcDamage += SpellCalcDamageFn(classic_spell_item_versus_bonus::CalcDamage);
    }
};

// 1320269 - Toofbreak (Toofbreaker 286430): "Deals $s2 times as much damage if the target is facing you." The multiplier is a dummy nothing
// read (wowsims/forever, MIT, sim/common/shared/shared_utils.go).
class classic_spell_item_toofbreak : public SpellScript
{
    bool Validate(SpellInfo const* spellInfo) override
    {
        return ValidateSpellEffect({ { spellInfo->Id, EFFECT_1 } });
    }

    void CalcDamage(SpellEffectInfo const& /*spellEffectInfo*/, Unit* victim, int32& /*damage*/, int32& /*flatMod*/, float& pctMod)
    {
        if (!victim || !victim->isInFront(GetCaster()))
            return;

        float const multiplier = float(GetEffectInfo(EFFECT_1).CalcValue(GetCaster()));
        if (multiplier > 1.0f)
            pctMod *= multiplier;
    }

    void Register() override
    {
        SpellScript::CalcDamage += SpellCalcDamageFn(classic_spell_item_toofbreak::CalcDamage);
    }
};

// 14118 - Rend (Dragonkin): "Deals $s2 times as much damage to Dragonkin." 1300787 - Rend (Barman Shanker 12791): "Deals $s2 times as much
// damage if applied while behind the target." Each bleed's second effect is a dummy aura with the multiplier that nothing read. Where the
// rogue stood is taken when the bleed goes on (and again when it is put on afresh), as the tooltip says; the Dragonkin check is per tick
// (wowsims/forever, MIT, sim/common/forever/items_weapons.go, EV-0146).
class classic_spell_item_rend_bonus : public AuraScript
{
    static constexpr uint32 SPELL_REND_DRAGONKIN = 14118;
    static constexpr uint32 SPELL_REND_FROM_BEHIND = 1300787;

    bool Validate(SpellInfo const* spellInfo) override
    {
        return ValidateSpellEffect({ { spellInfo->Id, EFFECT_1 } });
    }

    void CalcAmount(AuraEffect const* /*aurEff*/, SpellEffectValue& /*amount*/, bool& /*canBeRecalculated*/)
    {
        Unit* caster = GetCaster();
        Unit* owner = GetUnitOwner();
        _fromBehind = caster && owner && !owner->isInFront(caster);
    }

    void CalcDamage(AuraEffect const* /*aurEff*/, Unit* victim, int32& /*damage*/, int32& /*flatMod*/, float& pctMod)
    {
        if (!victim)
            return;

        bool bonus = false;
        switch (GetId())
        {
            case SPELL_REND_DRAGONKIN:
                bonus = victim->GetCreatureType() == CREATURE_TYPE_DRAGONKIN;
                break;
            case SPELL_REND_FROM_BEHIND:
                bonus = _fromBehind;
                break;
            default:
                break;
        }
        if (!bonus)
            return;

        float const multiplier = float(GetEffectInfo(EFFECT_1).CalcValue(GetCaster()));
        if (multiplier > 1.0f)
            pctMod *= multiplier;
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(classic_spell_item_rend_bonus::CalcAmount, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE);
        DoEffectCalcDamageAndHealing += AuraEffectCalcDamageFn(classic_spell_item_rend_bonus::CalcDamage, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE);
    }

    bool _fromBehind = false;
};

// 1293881 - Pendulum of Doom (Pendulum of Doom 9425, equip): "Each swing alternates your attack speed between $1293885s1% faster and
// $1293886s1% slower." The equip aura is a melee haste aura of 0 that procs on each swing, and the two buffs only show the state (a dummy
// with the percent, and the removal of the other buff); nothing turned a swing into the next state, so the axe swung at its plain speed.
// Each swing now puts on the other buff and sets the haste to it: +100% after a slow swing, -50% after a fast one, which comes out at the
// plain speed over two swings (0.5 and 1.5 of the weapon's time). The 10 s periodic dummy puts the axe back to its plain speed once the
// wearer is out of combat, so a fight never opens on the slow swing.
class classic_spell_item_pendulum_of_doom : public AuraScript
{
    static constexpr uint32 SPELL_PENDULUM_FAST = 1293885;
    static constexpr uint32 SPELL_PENDULUM_SLOW = 1293886;

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellEffect({ { SPELL_PENDULUM_FAST, EFFECT_0 }, { SPELL_PENDULUM_SLOW, EFFECT_0 } });
    }

    static int32 StateHaste(uint32 spellId)
    {
        int32 const pct = sSpellMgr->AssertSpellInfo(spellId, DIFFICULTY_NONE)->GetEffect(EFFECT_0).CalcValueAsInt();
        return spellId == SPELL_PENDULUM_SLOW ? -pct : pct;
    }

    void SetState(uint32 spellId)
    {
        Unit* wielder = GetTarget();
        if (spellId)
            wielder->CastSpell(wielder, spellId, CastSpellExtraArgs(TRIGGERED_FULL_MASK).SetTriggeringAura(GetEffect(EFFECT_0)));
        else
        {
            wielder->RemoveAurasDueToSpell(SPELL_PENDULUM_FAST, wielder->GetGUID());
            wielder->RemoveAurasDueToSpell(SPELL_PENDULUM_SLOW, wielder->GetGUID());
        }

        if (AuraEffect* haste = GetEffect(EFFECT_0))
            haste->ChangeAmount(spellId ? StateHaste(spellId) : 0);
    }

    void HandleProc(AuraEffect const* /*aurEff*/, ProcEventInfo& /*eventInfo*/)
    {
        PreventDefaultAction();
        Unit* wielder = GetTarget();
        SetState(wielder->HasAura(SPELL_PENDULUM_FAST, wielder->GetGUID()) ? SPELL_PENDULUM_SLOW : SPELL_PENDULUM_FAST);
    }

    void HandlePeriodic(AuraEffect const* /*aurEff*/)
    {
        AuraEffect const* haste = GetEffect(EFFECT_0);
        if (haste && haste->GetAmountAsInt() != 0 && !GetTarget()->IsInCombat())
            SetState(0);
    }

    void HandleRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetTarget()->RemoveAurasDueToSpell(SPELL_PENDULUM_FAST, GetTarget()->GetGUID());
        GetTarget()->RemoveAurasDueToSpell(SPELL_PENDULUM_SLOW, GetTarget()->GetGUID());
    }

    void Register() override
    {
        OnEffectProc += AuraEffectProcFn(classic_spell_item_pendulum_of_doom::HandleProc, EFFECT_0, SPELL_AURA_MOD_MELEE_HASTE_3);
        OnEffectPeriodic += AuraEffectPeriodicFn(classic_spell_item_pendulum_of_doom::HandlePeriodic, EFFECT_1, SPELL_AURA_PERIODIC_DUMMY);
        AfterEffectRemove += AuraEffectRemoveFn(classic_spell_item_pendulum_of_doom::HandleRemove, EFFECT_0, SPELL_AURA_MOD_MELEE_HASTE_3,
            AURA_EFFECT_HANDLE_REAL);
    }
};

class classic_spell_item_moonshadow_stave : public AuraScript
{
    static constexpr uint32 SPELL_MOONSHADOW_SHADOW = 1300437;
    static constexpr uint32 SPELL_MOONSHADOW_ARCANE = 1300438;

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_MOONSHADOW_SHADOW, SPELL_MOONSHADOW_ARCANE });
    }

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        Spell const* procSpell = eventInfo.GetProcSpell();
        Unit* target = eventInfo.GetActionTarget();
        return procSpell && !procSpell->IsTriggered() && target && target != eventInfo.GetActor();
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();
        eventInfo.GetActor()->CastSpell(eventInfo.GetActionTarget(), urand(0, 1) ? SPELL_MOONSHADOW_SHADOW : SPELL_MOONSHADOW_ARCANE,
            CastSpellExtraArgs(aurEff));
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(classic_spell_item_moonshadow_stave::CheckProc);
        OnEffectProc += AuraEffectProcFn(classic_spell_item_moonshadow_stave::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

// High Alert follows the map: recalculated when entering or leaving a battleground
class classic_player_high_alert_map : public PlayerScript
{
public:
    classic_player_high_alert_map() : PlayerScript("classic_player_high_alert_map") { }

    void OnMapChanged(Player* player) override
    {
        if (AuraEffect* highAlert = player->GetAuraEffect(1225477, EFFECT_0))
            highAlert->RecalculateAmount();
    }
};

// 5217 - Tiger's Fury (Classic 1.60): a dummy aura, effect 0 = 15, "increases physical damage done by 15% for 6 sec". Applied to melee
// swings and physical abilities; the periodic hook carries no school, so bleeds are left alone.
class classic_unit_tigers_fury : public UnitScript
{
public:
    classic_unit_tigers_fury() : UnitScript("classic_unit_tigers_fury") { }

    static constexpr uint32 SPELL_TIGERS_FURY = 5217;

    static void Apply(Unit* attacker, uint32& damage)
    {
        if (!attacker || !damage || attacker->GetClass() != CLASS_DRUID)
            return;

        if (AuraEffect const* fury = attacker->GetAuraEffect(SPELL_TIGERS_FURY, EFFECT_0))
            damage = AddPct(damage, fury->GetAmount());
    }

    void ModifyMeleeDamage(Unit* /*target*/, Unit* attacker, uint32& damage) override
    {
        Apply(attacker, damage);
    }

    void ModifySpellDamageTaken(Unit* /*target*/, Unit* attacker, int32& damage, SpellInfo const* spellInfo) override
    {
        if (!spellInfo || damage <= 0 || !(spellInfo->GetSchoolMask() & SPELL_SCHOOL_MASK_NORMAL))
            return;

        uint32 value = uint32(damage);
        Apply(attacker, value);
        damage = int32(value);
    }
};

// 1216997 - Unflinching Morale (Grand Marshal's and High Warlord's weapons, equip): "Reduces all damage taken from players and their pets by
// $s2%. This effect cannot be combined from multiple sources." The aura is a dummy of 5 (the client has no second effect; the tooltip's
// $s2 reads the first) and nothing read it, so the rank 14 weapons gave no damage cut. Damage from a player, or from a pet, guardian or
// totem a player owns, is cut by the aura's amount before armor and resistances; two of the weapons give one cut.
class classic_unit_unflinching_morale : public UnitScript
{
public:
    classic_unit_unflinching_morale() : UnitScript("classic_unit_unflinching_morale") { }

    static constexpr uint32 SPELL_UNFLINCHING_MORALE = 1216997;

    template <typename T>
    static void Apply(Unit const* target, Unit const* attacker, T& damage)
    {
        if (!target || !attacker || !damage || !attacker->GetCharmerOrOwnerPlayerOrPlayerItself())
            return;

        AuraEffect const* morale = target->GetAuraEffect(SPELL_UNFLINCHING_MORALE, EFFECT_0);
        if (!morale || morale->GetAmountAsInt() <= 0)
            return;

        damage = T(CalculatePct(damage, 100 - std::min(morale->GetAmountAsInt(), 100)));
    }

    void ModifyMeleeDamage(Unit* target, Unit* attacker, uint32& damage) override
    {
        Apply(target, attacker, damage);
    }

    void ModifySpellDamageTaken(Unit* target, Unit* attacker, int32& damage, SpellInfo const* /*spellInfo*/) override
    {
        Apply(target, attacker, damage);
    }

    void ModifyPeriodicDamageAurasTick(Unit* target, Unit* attacker, uint32& damage) override
    {
        Apply(target, attacker, damage);
    }
};

// Tauren racial Cultivation (1.60): "Cultivate a nearby herb, growing a duplicate you can harvest without requiring Herbalism skill.
// Each herb may only be cultivated once." Official sniffs (2026-09-28, 2026-10-01): the spellbook spell 20552 (instant, dummy on game
// objects within 5 yd) makes the server start 1312643 (3 sec cast) on the herb; when it completes a duplicate herb appears on the same
// spot, created by the player: same model and loot, lock 4522 = key spell 1312650 (open lock without skill, the player does not know
// it; Player allows lock key spells of the target). Peacebloom 1618 -> 657382, Wilted Peacebloom 656160 -> 657454; the other twins are
// made by 2026_10_14_00_world_classic_tauren_cultivation.sql. A twin is found by model + loot.
namespace ClassicCultivation
{
    static constexpr uint32 SPELL_CULTIVATE_HERB = 1312643;
    static constexpr uint32 LOCK_CULTIVATED_HERB = 4522;
    static constexpr float SEARCH_RANGE = 5.0f;
    static constexpr Seconds TWIN_DURATION = 5min;
    static constexpr Seconds HERB_COOLDOWN = 15min;    // "each herb may only be cultivated once" (until it has been picked and regrown)

    static bool IsHerbalismLock(uint32 lockId)
    {
        LockEntry const* lock = sLockStore.LookupEntry(lockId);
        if (!lock)
            return false;
        for (uint8 i = 0; i < MAX_LOCK_CASE; ++i)
            if (lock->Type[i] == LOCK_KEY_SKILL && lock->Index[i] == LOCKTYPE_HERBALISM)
                return true;
        return false;
    }

    // herb (model, loot) -> twin entry
    static uint32 GetTwinEntry(GameObjectTemplate const* herb)
    {
        static std::unordered_map<uint64, uint32> const twins = []
        {
            std::unordered_map<uint64, uint32> map;
            for (auto const& [entry, goInfo] : sObjectMgr->GetGameObjectTemplates())
                if (goInfo.type == GAMEOBJECT_TYPE_CHEST && goInfo.chest.open == LOCK_CULTIVATED_HERB)
                    map.emplace(uint64(goInfo.displayId) << 32 | goInfo.chest.chestLoot, entry);
            return map;
        }();
        if (!herb || herb->type != GAMEOBJECT_TYPE_CHEST || !IsHerbalismLock(herb->chest.open))
            return 0;
        auto itr = twins.find(uint64(herb->displayId) << 32 | herb->chest.chestLoot);
        return itr != twins.end() ? itr->second : 0;
    }

    static std::unordered_map<ObjectGuid, TimePoint> CultivatedHerbs;
    static std::mutex CultivatedHerbsLock;

    static bool WasCultivated(ObjectGuid const& herb)
    {
        std::lock_guard<std::mutex> guard(CultivatedHerbsLock);
        auto itr = CultivatedHerbs.find(herb);
        if (itr == CultivatedHerbs.end())
            return false;
        if (GameTime::Now() - itr->second < HERB_COOLDOWN)
            return true;
        CultivatedHerbs.erase(itr);
        return false;
    }

    static void MarkCultivated(ObjectGuid const& herb)
    {
        std::lock_guard<std::mutex> guard(CultivatedHerbsLock);
        CultivatedHerbs[herb] = GameTime::Now();
    }

    static bool CanCultivate(GameObject const* go)
    {
        return go && go->isSpawned() && go->GetGoState() == GO_STATE_READY && !go->GetOwnerGUID()
            && GetTwinEntry(go->GetGOInfo()) && !WasCultivated(go->GetGUID());
    }

    static GameObject* FindHerb(Unit* caster)
    {
        std::list<GameObject*> objects;
        Trinity::AllWorldObjectsInRange check(caster, SEARCH_RANGE);
        Trinity::GameObjectListSearcher<Trinity::AllWorldObjectsInRange> searcher(caster, objects, check);
        Cell::VisitGridObjects(caster, searcher, SEARCH_RANGE);
        GameObject* best = nullptr;
        for (GameObject* go : objects)
            if (CanCultivate(go) && (!best || caster->GetExactDist2dSq(go) < caster->GetExactDist2dSq(best)))
                best = go;
        return best;
    }
}

// 20552 - Cultivation (Tauren racial, spellbook): starts Cultivate (1312643) on the nearest herb within 5 yd
class classic_spell_tauren_cultivation : public SpellScript
{
    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ ClassicCultivation::SPELL_CULTIVATE_HERB });
    }

    SpellCastResult CheckCast()
    {
        return ClassicCultivation::FindHerb(GetCaster()) ? SPELL_CAST_OK : SPELL_FAILED_NO_VALID_TARGETS;
    }

    void HandleAfterCast()
    {
        if (GameObject* herb = ClassicCultivation::FindHerb(GetCaster()))
            GetCaster()->CastSpell(herb, ClassicCultivation::SPELL_CULTIVATE_HERB, CastSpellExtraArgs(TRIGGERED_IGNORE_GCD));
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(classic_spell_tauren_cultivation::CheckCast);
        AfterCast += SpellCastFn(classic_spell_tauren_cultivation::HandleAfterCast);
    }
};

// 1312643 - Cultivate: the herb's twin grows on the same spot, for the caster only
class classic_spell_tauren_cultivate_herb : public SpellScript
{
    SpellCastResult CheckCast()
    {
        GameObject* herb = GetExplTargetGObj();
        return ClassicCultivation::CanCultivate(herb) ? SPELL_CAST_OK : SPELL_FAILED_BAD_TARGETS;
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Player* caster = GetCaster()->ToPlayer();
        GameObject* herb = GetHitGObj();
        if (!caster || !ClassicCultivation::CanCultivate(herb))
            return;

        uint32 twinEntry = ClassicCultivation::GetTwinEntry(herb->GetGOInfo());
        GameObject* twin = GameObject::CreateGameObject(twinEntry, herb->GetMap(), *herb, herb->GetLocalRotation(), 255, GO_STATE_READY);
        if (!twin)
            return;

        ClassicCultivation::MarkCultivated(herb->GetGUID());
        PhasingHandler::InheritPhaseShift(twin, caster);
        twin->SetPrivateObjectOwner(caster->GetGUID());
        twin->SetRespawnTime(ClassicCultivation::TWIN_DURATION.count());
        caster->AddGameObject(twin);
        herb->GetMap()->AddToMap(twin);
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(classic_spell_tauren_cultivate_herb::CheckCast);
        OnEffectHitTarget += SpellEffectFn(classic_spell_tauren_cultivate_herb::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// Classic 1.60 (client 70374) warrior talent Gore Drinker 1323967: "Your Enrage, Berserker Rage, Bloodrage, Death Wish, and Bloodthirst
// abilities cause your next $m1 melee attacks to restore ${$s2}.1% of your maximum Health." (both effects are server-side dummies: 4
// attacks, 0.5 / 1% by rank). The buff 1323969 procs on melee attacks (SPELL_AURA_PROC_TRIGGER_SPELL_WITH_VALUE) and heals with 1323968
// for its amount.
namespace ClassicGoreDrinker
{
    static constexpr uint32 SPELL_GORE_DRINKER_TALENT = 1323967;
    static constexpr uint32 SPELL_GORE_DRINKER_BUFF = 1323969;

    static void Apply(Unit* warrior)
    {
        AuraEffect const* attacks = warrior->GetAuraEffect(SPELL_GORE_DRINKER_TALENT, EFFECT_0);
        AuraEffect const* healthPct = warrior->GetAuraEffect(SPELL_GORE_DRINKER_TALENT, EFFECT_1);
        if (!attacks || !healthPct || attacks->GetAmount() <= 0 || healthPct->GetAmount() <= 0)
            return;

        int32 heal = std::max(1, int32(warrior->CountPctFromMaxHealth(healthPct->GetAmount())));
        warrior->CastSpell(warrior, SPELL_GORE_DRINKER_BUFF, CastSpellExtraArgs(TRIGGERED_FULL_MASK).AddSpellBP0(heal));
        if (Aura* buff = warrior->GetAura(SPELL_GORE_DRINKER_BUFF))
            buff->SetCharges(uint8(attacks->GetAmount()));
    }
}

// 2687 - Bloodrage, 18499 - Berserker Rage, 12328 - Death Wish, 23881, 23892, 23893, 23894 - Bloodthirst: Gore Drinker
class classic_spell_warr_gore_drinker : public SpellScript
{
    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ ClassicGoreDrinker::SPELL_GORE_DRINKER_BUFF });
    }

    void HandleAfterCast()
    {
        ClassicGoreDrinker::Apply(GetCaster());
    }

    void Register() override
    {
        AfterCast += SpellCastFn(classic_spell_warr_gore_drinker::HandleAfterCast);
    }
};

// 12880 - Enrage (talent proc buff): Gore Drinker
class classic_spell_warr_gore_drinker_enrage : public AuraScript
{
    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ ClassicGoreDrinker::SPELL_GORE_DRINKER_BUFF });
    }

    void HandleApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        ClassicGoreDrinker::Apply(GetTarget());
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(classic_spell_warr_gore_drinker_enrage::HandleApply, EFFECT_0, SPELL_AURA_ANY, AURA_EFFECT_HANDLE_REAL);
    }
};

/*######
## classic_spell_undead_touch_of_the_grave
######*/

// 1260189 / 1260201 - Touch of the Grave (Undead racial, 1.60): "Your spells and attacks have a chance to drain Health from the target,
// up to $s1% of your maximum Health." Warriors, paladins and rogues learn 1260189 (20%), priests, mages and warlocks learn 1260201 (30%)
// (SkillLineAbility class masks 11 and 400). The client data procs a dummy aura (15 sec recovery) and has no trigger for the drain
// 1260198, whose health leech base points are a placeholder 5: the drain is cast here for $s1% of the Undead's maximum health.
class classic_spell_undead_touch_of_the_grave : public AuraScript
{
    static constexpr uint32 SPELL_TOUCH_OF_THE_GRAVE_DRAIN = 1260198;

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_TOUCH_OF_THE_GRAVE_DRAIN });
    }

    bool CheckProc(AuraEffect const* /*aurEff*/, ProcEventInfo& eventInfo)
    {
        Unit* target = eventInfo.GetActionTarget();
        return target && target != GetTarget() && target->IsAlive() && GetTarget()->IsValidAttackTarget(target);
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();
        Unit* undead = GetTarget();
        int32 drain = CalculatePct(int32(undead->GetMaxHealth()), aurEff->GetAmount());
        if (drain > 0)
            undead->CastSpell(eventInfo.GetActionTarget(), SPELL_TOUCH_OF_THE_GRAVE_DRAIN, CastSpellExtraArgs(aurEff)
                .AddSpellMod(SPELLVALUE_BASE_POINT0, drain));
    }

    void Register() override
    {
        DoCheckEffectProc += AuraCheckEffectProcFn(classic_spell_undead_touch_of_the_grave::CheckProc, EFFECT_0, SPELL_AURA_DUMMY);
        OnEffectProc += AuraEffectProcFn(classic_spell_undead_touch_of_the_grave::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

/*######
## Vanilla item, quest and holiday spells whose retail scripts never attach
######*/

// 8213 - Savory Deviate Delight (vanilla food): eating it turns you into a pirate or a ninja (VMaNGOS 8219 - 8222). The 1.60 client data
// makes 8213 a transform aura without a creature, so the retail dummy handler never ran and the aura changed nothing. The costume
// spell is cast instead of the empty transform.
class classic_spell_item_savory_deviate_delight : public SpellScript
{
    static constexpr uint32 SPELL_FLIP_OUT_MALE   = 8219;
    static constexpr uint32 SPELL_FLIP_OUT_FEMALE = 8220;
    static constexpr uint32 SPELL_YAAARRRR_MALE   = 8221;
    static constexpr uint32 SPELL_YAAARRRR_FEMALE = 8222;

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_FLIP_OUT_MALE, SPELL_FLIP_OUT_FEMALE, SPELL_YAAARRRR_MALE, SPELL_YAAARRRR_FEMALE });
    }

    void HandleCostume(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        Unit* target = GetHitUnit();
        if (!target || target->GetTypeId() != TYPEID_PLAYER)
            return;

        bool male = target->GetNativeGender() == GENDER_MALE;
        uint32 costume = urand(0, 1) ? (male ? SPELL_FLIP_OUT_MALE : SPELL_FLIP_OUT_FEMALE) : (male ? SPELL_YAAARRRR_MALE : SPELL_YAAARRRR_FEMALE);
        target->CastSpell(target, costume, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(classic_spell_item_savory_deviate_delight::HandleCostume, EFFECT_0, SPELL_EFFECT_APPLY_AURA);
    }
};

// 13180 - Gnomish Mind Control Cap (VMaNGOS EffectDummy): one use in six does nothing, one in six makes the target control the
// wearer (not while shapeshifted), otherwise the wearer controls the target (13181). The retail script also needs Dullard 67809,
// which the 1.60 client lacks, so it never attached and the cap did nothing.
class classic_spell_item_mind_control_cap : public SpellScript
{
    static constexpr uint32 SPELL_GNOMISH_MIND_CONTROL_CAP = 13181;

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_GNOMISH_MIND_CONTROL_CAP });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        Unit* target = GetHitUnit();
        if (!target)
            return;

        switch (urand(0, 5))
        {
            case 0:
                break;
            case 1:
                if (caster->GetShapeshiftForm() == FORM_NONE)
                    target->CastSpell(caster, SPELL_GNOMISH_MIND_CONTROL_CAP, true);
                break;
            default:
                caster->CastSpell(target, SPELL_GNOMISH_MIND_CONTROL_CAP, true);
                break;
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(classic_spell_item_mind_control_cap::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 23448 - Transporter Arrival, Ultrasafe Transporter: Gadgetzan backfire (VMaNGOS EffectDummy): 1/6 polymorph (23444), 4/6 evil
// twin (23445), 1/6 nothing. The retail script also needs the TBC "miss the target" spell 36902, so it never attached.
class classic_spell_gen_gadgetzan_transporter_backfire : public SpellScript
{
    static constexpr uint32 SPELL_TRANSPORTER_MALFUNCTION_POLYMORPH = 23444;
    static constexpr uint32 SPELL_TRANSPORTER_EVIL_TWIN             = 23445;

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_TRANSPORTER_MALFUNCTION_POLYMORPH, SPELL_TRANSPORTER_EVIL_TWIN });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        int32 r = irand(0, 119);
        if (r < 20)
            caster->CastSpell(caster, SPELL_TRANSPORTER_MALFUNCTION_POLYMORPH, true);
        else if (r < 100)
            caster->CastSpell(caster, SPELL_TRANSPORTER_EVIL_TWIN, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(classic_spell_gen_gadgetzan_transporter_backfire::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 26218 - Mistletoe (Winter Veil, VMaNGOS): the kissed player gets Create Mistletoe or Create Holly (26206 / 26207). The retail script
// also needs the WotLK Create Snowflakes 45036, so it never attached.
class classic_spell_winter_veil_mistletoe : public SpellScript
{
    static constexpr uint32 SPELL_CREATE_MISTLETOE = 26206;
    static constexpr uint32 SPELL_CREATE_HOLLY     = 26207;

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_CREATE_MISTLETOE, SPELL_CREATE_HOLLY });
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        Unit* target = GetHitUnit();
        if (!target || target->GetTypeId() != TYPEID_PLAYER)
            return;

        GetCaster()->CastSpell(target, urand(0, 1) ? SPELL_CREATE_MISTLETOE : SPELL_CREATE_HOLLY, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(classic_spell_winter_veil_mistletoe::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// 25860 - Reindeer Transformation (Fresh Holly / Preserved Holly, VMaNGOS): a mounted player gets a reindeer of his mount's speed
// (25859 at 100%, 25858 at 60%). The retail script also needs the flying reindeer spells, so it never attached.
class classic_spell_winter_veil_reindeer_transformation : public SpellScript
{
    static constexpr uint32 SPELL_REINDEER_100 = 25859;
    static constexpr uint32 SPELL_REINDEER_60  = 25858;

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_REINDEER_100, SPELL_REINDEER_60 });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        if (!caster->HasAuraType(SPELL_AURA_MOUNTED))
            return;

        float speed = caster->GetSpeedRate(MOVE_RUN);
        caster->RemoveAurasByType(SPELL_AURA_MOUNTED);
        caster->CastSpell(caster, speed >= 2.0f ? SPELL_REINDEER_100 : SPELL_REINDEER_60, true);
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(classic_spell_winter_veil_reindeer_transformation::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 24194 - Uther's Tribute, 24195 - Grom's Tribute (VMaNGOS): the tribute item summons the race's offering at the tomb. Uther's
// Tribute answers the Alliance races, Grom's the Horde races. The retail script also needs the Blood Elf and Draenei offerings, so
// it never attached and the items did nothing.
class classic_spell_quest_uther_grom_tribute : public SpellScript
{
    static uint32 TributeSpell(uint32 spellId, uint8 race)
    {
        if (spellId == 24194)
        {
            switch (race)
            {
                case RACE_HUMAN:    return 24105;
                case RACE_GNOME:    return 24106;
                case RACE_DWARF:    return 24107;
                case RACE_NIGHTELF: return 24108;
                default:            return 0;
            }
        }

        switch (race)
        {
            case RACE_TROLL:         return 24101;
            case RACE_TAUREN:        return 24102;
            case RACE_UNDEAD_PLAYER: return 24103;
            case RACE_ORC:           return 24104;
            default:                 return 0;
        }
    }

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ 24101, 24102, 24103, 24104, 24105, 24106, 24107, 24108 });
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        Player* caster = GetCaster()->ToPlayer();
        if (!caster)
            return;

        if (uint32 spellId = TributeSpell(GetSpellInfo()->Id, caster->GetRace()))
            caster->CastSpell(caster, spellId, true);
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(classic_spell_quest_uther_grom_tribute::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// 19505, 19731, 19734, 19736 - Devour Magic (felhunter): "If an effect is devoured, the Felhunter will be healed for ..." The heal is
// the rank's Devour Magic Effect (19658, 19732, 19733, 19735, as the tooltips name them); the 1.60 data has no effect that casts it.
// The retail script also needs the WotLK Glyph of Demon Training and the rank 1 effect 1, so no rank ever healed.
class classic_spell_warl_devour_magic : public SpellScript
{
    static uint32 HealSpell(uint32 spellId)
    {
        switch (spellId)
        {
            case 19505: return 19658;
            case 19731: return 19732;
            case 19734: return 19733;
            case 19736: return 19735;
            default:    return 0;
        }
    }

    bool Validate(SpellInfo const* spellInfo) override
    {
        return HealSpell(spellInfo->Id) && ValidateSpellInfo({ HealSpell(spellInfo->Id) });
    }

    void HandleSuccessfulDispel(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        caster->CastSpell(caster, HealSpell(GetSpellInfo()->Id), true);
    }

    void Register() override
    {
        OnEffectSuccessfulDispel += SpellEffectFn(classic_spell_warl_devour_magic::HandleSuccessfulDispel, EFFECT_0, SPELL_EFFECT_DISPEL);
    }
};

// 14297, 26546, 26555 - Shadow Storm (Anubisath Sentinel, Guardian and Defender)
// The vanilla spell only hits players at least 25 yards from the caster: standing close is the answer to it (VMaNGOS
// handles it the same way). The client data has no minimum radius, so without this every player inside 45 yards was hit.
class classic_spell_shadow_storm_min_range : public SpellScript
{
    static constexpr float MIN_RANGE = 25.0f;

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        Unit* caster = GetCaster();
        targets.remove_if([caster](WorldObject* target)
        {
            return caster->GetExactDist2d(target) < MIN_RANGE;
        });
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(classic_spell_shadow_storm_min_range::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENEMY);
    }
};

// 19983 - Cleave (Sapphiron, Vaelastrasz and other classic NPCs): ChainTargets 10, a melee spell. The core chains it jump by jump, 5 y a
// jump, out to 50 y from the target (Spell::SearchChainTargets), so it ran through a whole raid. In vanilla a melee chain only takes those
// within its melee range (range index 2, 5 y) of the target it lands on (VMaNGOS, Spell::SetTargetMap for TARGET_UNIT_ENEMY: the search
// range is the spell's own range for a melee spell, the jumps only for the others). naxx_sapphiron r29 (1118): 16 of 39 died to his
// Cleave, healers among them 34-48 y from him.
class classic_spell_cleave_melee_reach : public SpellScript
{
    static constexpr float MELEE_CHAIN_REACH = 5.0f;

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        Unit* first = GetExplTargetUnit();
        if (!first)
            return;
        targets.remove_if([first](WorldObject* target)
        {
            return first->GetDistance(target) > MELEE_CHAIN_REACH;
        });
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(classic_spell_cleave_melee_reach::FilterTargets, EFFECT_0, TARGET_UNIT_TARGET_ENEMY);
    }
};

// 1258773 - Testing the Wells (Forever quest 92742, Westfall): the Well Testing Kit 254545 casts a dummy on a "nearby entry" target that
// nothing in the data names, so every use failed with an invalid target and the two water samples could never be had (Discord
// 2026-11-09). The target is the caster now (SpellMgr::LoadSpellInfoCorrections); next to a well the kit gives that well's sample.
// Well spots: the objective points of the quest data (ATT Forever, Westfall 56.7,18.7 Jansen Stead and 46.2,38.3 Molsen Farm) through
// the Westfall map frame fitted on 44 of our spawns (0.6% median error, about 20 yards). The first version fitted the map on two NPCs
// only: its Jansen Stead well sat 35 yards from this one (Molsen 16), more than its 25 yard reach, and the kit was reported broken
// again (Discord, voldemargreed "bugs 3", 2026-11-13). INFERRED: the live well bunnies were never sniffed; 35 yards covers the fit.
class classic_spell_quest_testing_the_wells : public SpellScript
{
    struct Well { float x, y; uint32 sample; };
    static constexpr Well WELLS[] =
    {
        { -9809.3f, 1020.8f, 254546 },      // Jansen Stead
        { -10279.7f, 1398.3f, 254547 },     // Molsen Farm
    };
    static constexpr float WELL_RADIUS = 35.0f;

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        for (Well const& well : WELLS)
            if (!sObjectMgr->GetItemTemplate(well.sample))
                return false;
        return true;
    }

    Well const* NearestWell() const
    {
        Unit* caster = GetCaster();
        if (caster->GetMapId() != 0)
            return nullptr;
        for (Well const& well : WELLS)
            if (caster->GetExactDist2d(well.x, well.y) <= WELL_RADIUS)
                return &well;
        return nullptr;
    }

    SpellCastResult CheckWell()
    {
        Player* player = GetCaster()->ToPlayer();
        if (!player)
            return SPELL_FAILED_DONT_REPORT;
        Well const* well = NearestWell();
        if (!well)
            return SPELL_FAILED_NOT_HERE;
        if (player->HasItemCount(well->sample, 1, true))   // this farm's sample is already in the bags or bank
            return SPELL_FAILED_DONT_REPORT;
        return SPELL_CAST_OK;
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Player* player = GetCaster()->ToPlayer();
        Well const* well = NearestWell();
        if (!player || !well)
            return;
        if (!player->HasItemCount(well->sample, 1, true))
            player->AddItem(well->sample, 1);
    }

    void Register() override
    {
        OnCheckCast += SpellCheckCastFn(classic_spell_quest_testing_the_wells::CheckWell);
        OnEffectHitTarget += SpellEffectFn(classic_spell_quest_testing_the_wells::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// Shaman weapon imbues of 1.60: one DUMMY aura per imbue, the enchant on the weapon tells the rank.
static Item* ClassicImbuedWeapon(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
{
    Player* player = aurEff->GetBase()->GetUnitOwner()->ToPlayer();
    DamageInfo* damage = eventInfo.GetDamageInfo();
    if (!player || !damage || !eventInfo.GetActionTarget())
        return nullptr;
    WeaponAttackType const attack = damage->GetAttackType();
    if (attack != BASE_ATTACK && attack != OFF_ATTACK)
        return nullptr;
    Item* weapon = player->GetWeaponForAttack(attack, true);
    if (!weapon || weapon->GetGUID() != aurEff->GetBase()->GetCastItemGUID())
        return nullptr;
    return weapon;
}

// 439431 - Windfury Weapon
class classic_spell_sha_windfury_weapon : public AuraScript
{
    // enchant -> the rank's attack power + extra attacks spell
    static uint32 GetRankSpell(uint32 enchantId)
    {
        switch (enchantId)
        {
            case 283:  return 8233;
            case 284:  return 8236;
            case 525:  return 10484;
            case 1669:
            case 7569: return 16361;
            case 8293: return 8233;
            default:   return 0;
        }
    }

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ 8233, 8236, 10484, 16361 });
    }

    bool CheckProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        Item* weapon = ClassicImbuedWeapon(aurEff, eventInfo);
        if (!weapon)
            return false;
        uint32 const rank = GetRankSpell(weapon->GetEnchantmentId(TEMP_ENCHANTMENT_SLOT));
        // the attacks it granted do not grant more
        return rank && GetTarget()->GetLastExtraAttackSpell() != rank;
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();
        if (Item* weapon = ClassicImbuedWeapon(aurEff, eventInfo))
            if (uint32 rank = GetRankSpell(weapon->GetEnchantmentId(TEMP_ENCHANTMENT_SLOT)))
                GetTarget()->CastSpell(GetTarget(), rank, CastSpellExtraArgs(aurEff).SetCastItem(weapon));
    }

    void Register() override
    {
        DoCheckEffectProc += AuraCheckEffectProcFn(classic_spell_sha_windfury_weapon::CheckProc, EFFECT_0, SPELL_AURA_DUMMY);
        OnEffectProc += AuraEffectProcFn(classic_spell_sha_windfury_weapon::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

// Talents of 1.60 whose proc chance is an effect value scaled by the talent rank, not SpellAuraOptions.ProcChance (100).
class classic_spell_proc_chance_from_effect : public AuraScript
{
protected:
    static SpellEffIndex ChanceEffect(uint32 spellId)
    {
        switch (spellId)
        {
            case 11180:   // Winter's Chill: $m2
            case 12298:   // Shield Specialization (warrior): $m2
            case 14909:   // Searing Light: $m2
            case 16850:   // Improved Starfire: $s2
            case 20150:   // Shield Specialization (paladin): $m2
            case 1224716: // Puncturing Wounds: $m2
                return EFFECT_1;
            default:
                return EFFECT_0;
        }
    }

    bool CheckProc(ProcEventInfo& /*eventInfo*/)
    {
        AuraEffect const* chance = GetEffect(ChanceEffect(GetId()));
        return chance && roll_chance(chance->GetAmount());
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(classic_spell_proc_chance_from_effect::CheckProc);
    }
};


void AddSC_classic_spell_scripts()
{
    RegisterSpellScript(classic_spell_sha_windfury_weapon);
    RegisterSpellScript(classic_spell_proc_chance_from_effect);
    RegisterSpellScript(classic_spell_warr_gore_drinker);
    RegisterSpellScript(classic_spell_dru_not_from_shadowmeld);
    RegisterSpellScript(classic_spell_warr_gore_drinker_enrage);
    RegisterSpellScript(classic_spell_undead_touch_of_the_grave);
    RegisterSpellScript(classic_spell_tauren_cultivation);
    RegisterSpellScript(classic_spell_tauren_cultivate_herb);
    new classic_unit_tigers_fury();
    new classic_unit_unflinching_morale();
    RegisterSpellScript(classic_spell_pri_vampiric_embrace);
    RegisterSpellScript(classic_spell_item_moonshadow_stave);
    RegisterSpellScript(classic_spell_item_argent_defender);
    RegisterSpellScript(classic_spell_item_fatal_wound);
    RegisterSpellScript(classic_spell_item_versus_bonus);
    RegisterSpellScript(classic_spell_item_toofbreak);
    RegisterSpellScript(classic_spell_item_rend_bonus);
    RegisterSpellScript(classic_spell_item_pendulum_of_doom);
    RegisterSpellScript(classic_spell_item_zandalarian_hero_badge);
    RegisterSpellScript(classic_spell_item_totem_of_flowing_water);
    RegisterSpellScript(classic_spell_item_set_proc_mana_cast);
    RegisterSpellScript(classic_spell_item_natures_bounty);
    RegisterSpellScript(classic_spell_pal_consecration);
    RegisterSpellScript(classic_spell_pal_consecration_tick);
    RegisterSpellScript(classic_spell_pal_seal_of_fury);
    RegisterSpellScript(classic_spell_pal_seal_of_fury_damage);
    RegisterSpellScript(classic_spell_pal_unsealed_wrath);
    RegisterSpellScript(classic_spell_well_fed_xp_boost);
    RegisterSpellScript(classic_spell_pal_judgement_of_fury);
    RegisterSpellScript(classic_spell_legacy_high_alert);
    new classic_player_high_alert_map();
    RegisterSpellScript(classic_spell_legacy_dedicated_study);
    RegisterSpellScript(classic_spell_recently_bandaged_field_medicine);
    new classic_player_thrill_of_adventure();
    RegisterSpellScript(classic_spell_legacy_reagent_economy);
    RegisterSpellScript(classic_spell_legacy_fast_recovery);
    RegisterSpellScript(classic_spell_legacy_second_home);
    RegisterSpellScript(classic_spell_legacy_second_home_location);
    RegisterSpellScript(classic_spell_legacy_boss_celebration_buff);
    RegisterSpellScript(classic_spell_profession_certification);
    RegisterSpellScript(classic_spell_executors_motivator);
    RegisterSpellScriptWithArgs(classic_spell_skyborne_racial_focus, "classic_spell_skyborne_read_ley_line", 2246, 1259691, 1271952, 100, true);
    RegisterSpellScriptWithArgs(classic_spell_skyborne_racial_focus, "classic_spell_skyborne_skysight", 2271, 1270893, 0, 30, false);
    RegisterSpellScript(classic_spell_innervate_replaces_energized);
    RegisterSpellScript(classic_spell_warl_immolate);
    RegisterSpellScript(classic_spell_hun_taming_rod);
    RegisterSpellScript(classic_spell_hun_tame_beast_channel);
    RegisterSpellScript(classic_spell_pal_holy_shock);
    RegisterSpellScript(classic_spell_pal_judgement_of_the_crusader_refresh);
    RegisterSpellScript(classic_spell_pal_seal_of_righteousness);
    RegisterSpellScript(classic_spell_pal_judgement);
    RegisterSpellScript(classic_spell_pal_judgement_of_command);
    RegisterSpellScript(classic_spell_pal_judgement_intermediate);
    RegisterSpellScript(classic_spell_profession_book);
    RegisterSpellScript(classic_spell_ground_area_damage);
    RegisterSpellScript(classic_spell_heal_injured_druid);
    RegisterSpellScript(classic_spell_item_savory_deviate_delight);
    RegisterSpellScript(classic_spell_item_mind_control_cap);
    RegisterSpellScript(classic_spell_gen_gadgetzan_transporter_backfire);
    RegisterSpellScript(classic_spell_winter_veil_mistletoe);
    RegisterSpellScript(classic_spell_winter_veil_reindeer_transformation);
    RegisterSpellScript(classic_spell_quest_uther_grom_tribute);
    RegisterSpellScript(classic_spell_warl_devour_magic);
    RegisterSpellScript(classic_spell_alaketh_spiritcaller_dot);
    RegisterSpellScript(classic_spell_mage_decipher);
    new classic_player_scroll_deciphering();
    RegisterSpellScript(classic_spell_shadow_storm_min_range);
    RegisterSpellScript(classic_spell_cleave_melee_reach);
    RegisterSpellScript(classic_spell_quest_testing_the_wells);
}
