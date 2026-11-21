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

// Classic 1.60 (WoW Forever) rogue abilities whose client spell does nothing on its own.

#include "ScriptMgr.h"
#include <algorithm>
#include "Player.h"
#include "Random.h"
#include "Spell.h"
#include "SpellAuraEffects.h"
#include "SpellAuras.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "SpellHistory.h"
#include "SpellScript.h"
#include "Unit.h"

enum ClassicRogueAbilities
{
    // The client has no Blade Flurry strike spell (retail 22482). Sweeping Strikes 12723 is the physical school damage spell with
    // base points 1 and no bonus coefficient that the warrior copy-hit also uses; the damage comes from base point 0.
    SPELL_ROGUE_BLADE_FLURRY_STRIKE = 12723,

    SPELL_ROGUE_RUTHLESSNESS_COMBO_POINT = 14157,
    SPELL_ROGUE_REVEALED_FLAW_CRIT       = 28815
};

// 13877 - Blade Flurry: "Increases your attack speed by 20%. In addition, your attacks strike an additional nearby opponent. Lasts 15 sec."
// The client spell is only the haste aura (aura 319). The retail script bound to this id never ran: its strike spell 22482 is not in the
// client data and it hooks the retail aura type of effect 0. The extra strike repeats the damage of each melee swing or ability on a
// second enemy near the target (spell_proc: melee swing and melee ability, hit phase).
class classic_spell_rog_blade_flurry : public AuraScript
{
    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_ROGUE_BLADE_FLURRY_STRIKE });
    }

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        DamageInfo* damageInfo = eventInfo.GetDamageInfo();
        if (!damageInfo || !damageInfo->GetDamage())
            return false;

        // the extra strike is itself a melee hit
        if (SpellInfo const* spellInfo = damageInfo->GetSpellInfo())
            if (spellInfo->Id == SPELL_ROGUE_BLADE_FLURRY_STRIKE)
                return false;

        _procTarget = GetTarget()->SelectNearbyTarget(eventInfo.GetActionTarget());
        return _procTarget != nullptr;
    }

    void HandleProc(ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();

        DamageInfo* damageInfo = eventInfo.GetDamageInfo();
        if (!damageInfo || !_procTarget)
            return;

        // WoW Forever: the copy is the damage the first target took, after its armor; it takes no armor or modifiers again and procs
        // nothing (wowsims/forever, MIT, sim/rogue/talents_combat.go: the strike ignores resists and modifiers and has no proc mask).
        // Casting 12723 (a physical school damage spell) ran it through the second target's armor and the damage bonuses once more.
        Unit* rogue = GetTarget();
        SpellInfo const* strike = sSpellMgr->GetSpellInfo(SPELL_ROGUE_BLADE_FLURRY_STRIKE, DIFFICULTY_NONE);
        if (strike && _procTarget->IsAlive())
        {
            SpellNonMeleeDamage copy(rogue, _procTarget, strike, GetAura()->GetSpellVisual(), SPELL_SCHOOL_MASK_NORMAL, GetAura()->GetCastId());
            copy.damage = damageInfo->GetDamage();
            rogue->DealSpellDamage(&copy, false);
            rogue->SendSpellNonMeleeDamageLog(&copy);
        }
        _procTarget = nullptr;
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(classic_spell_rog_blade_flurry::CheckProc);
        OnProc += AuraProcFn(classic_spell_rog_blade_flurry::HandleProc);
    }

    Unit* _procTarget = nullptr;
};

// 14185 - Preparation: "When activated, this ability immediately finishes the cooldown on your Evasion, Sprint, Vanish, Cold Blood and
// Premeditation abilities." The client spell is a dummy effect on the rogue; every rank of those abilities is reset.
class classic_spell_rog_preparation : public SpellScript
{
    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Unit* rogue = GetCaster();
        for (uint32 spellId : { 5277u, 2983u, 8696u, 11305u, 1856u, 1857u, 14177u, 14183u })
            if (rogue->GetSpellHistory()->HasCooldown(spellId))
                rogue->GetSpellHistory()->ResetCooldown(spellId, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(classic_spell_rog_preparation::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 14179 - Relentless Strikes: "Your finishing moves have a $m1% chance per Combo Point to restore $14181s1 Energy." Forever makes it a
// five-rank talent: effect 0 carries the chance per combo point from the talent's points (trait definition 145964: 4/8/12/16/20 by rank),
// and 14181 holds the 25 energy. The vanilla 20% per point is kept only when the effect has no amount (the talent learned outside the tree).
class classic_spell_rog_relentless_strikes : public AuraScript
{
    static constexpr uint32 SPELL_ROGUE_RELENTLESS_STRIKES_EFFECT = 14181;
    static constexpr int32 VANILLA_CHANCE_PER_COMBO_POINT = 20;

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_ROGUE_RELENTLESS_STRIKES_EFFECT });
    }

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        Spell const* procSpell = eventInfo.GetProcSpell();
        if (!procSpell)
            return false;

        int32 points = procSpell->GetPowerTypeCostAmount(POWER_COMBO_POINTS).value_or(0);
        if (points <= 0)
            return false;

        int32 chancePerPoint = VANILLA_CHANCE_PER_COMBO_POINT;
        if (AuraEffect const* talent = GetEffect(EFFECT_0))
            if (talent->GetAmountAsInt() > 0)
                chancePerPoint = talent->GetAmountAsInt();

        return roll_chance(points * chancePerPoint);
    }

    void HandleProc(ProcEventInfo& /*eventInfo*/)
    {
        PreventDefaultAction();

        SpellInfo const* effect = sSpellMgr->GetSpellInfo(SPELL_ROGUE_RELENTLESS_STRIKES_EFFECT, DIFFICULTY_NONE);
        if (effect && !effect->GetEffects().empty())
        {
            Unit* rogue = GetTarget();
            rogue->EnergizeBySpell(rogue, effect, effect->GetEffect(EFFECT_0).CalcValueAsInt(rogue), POWER_ENERGY);
        }
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(classic_spell_rog_relentless_strikes::CheckProc);
        OnProc += AuraProcFn(classic_spell_rog_relentless_strikes::HandleProc);
    }
};

// 14156 - Ruthlessness: "Gives you a $m1% chance to add a combo point to your target after performing a finishing move." The client aura is a
// proc trigger spell with a proc chance of 100 and the talent rank in its amount, so it fired on every melee ability (builders included) or
// never; 14157 adds the point. Like vMaNGOS, only a finisher that hit gives the chance. The point comes in the finish phase: the finisher
// spends its combo points just before (Spell::_handle_finish_phase), a point added in the hit phase would be spent with them.
class classic_spell_rog_ruthlessness : public AuraScript
{
    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_ROGUE_RUTHLESSNESS_COMBO_POINT });
    }

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        Spell const* procSpell = eventInfo.GetProcSpell();
        AuraEffect const* talent = GetEffect(EFFECT_0);
        if (!procSpell || !talent || procSpell->GetPowerTypeCostAmount(POWER_COMBO_POINTS).value_or(0) <= 0)
            return false;

        constexpr uint32 missed = PROC_HIT_MISS | PROC_HIT_FULL_RESIST | PROC_HIT_DODGE | PROC_HIT_PARRY | PROC_HIT_EVADE | PROC_HIT_IMMUNE | PROC_HIT_DEFLECT | PROC_HIT_REFLECT;
        if (eventInfo.GetHitMask() & missed)
            return false;

        Unit* target = procSpell->m_targets.GetUnitTarget();
        if (!target || target == GetTarget() || !target->IsAlive())
            return false;

        return roll_chance(talent->GetAmountAsInt());
    }

    void HandleProc(ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();

        if (Unit* target = eventInfo.GetProcSpell()->m_targets.GetUnitTarget())
            GetTarget()->CastSpell(target, SPELL_ROGUE_RUTHLESSNESS_COMBO_POINT, CastSpellExtraArgs(GetEffect(EFFECT_0)));
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(classic_spell_rog_ruthlessness::CheckProc);
        OnProc += AuraProcFn(classic_spell_rog_ruthlessness::HandleProc);
    }
};

// 5171, 6774 - Slice and Dice with 14156 Ruthlessness: Slice and Dice is a finisher but no melee ability (it deals no damage), so the
// Ruthlessness row (melee abilities, finish phase) never heard it and it never rolled for the combo point. After the cast (its combo points
// are spent in the finish phase before this), the talent's chance adds the point to the rogue's target (wowsims/forever, MIT,
// sim/rogue/slice_and_dice.go calls the finisher rolls for it; no log reading).
class classic_spell_rog_slice_and_dice_ruthlessness : public SpellScript
{
    static constexpr uint32 SPELL_ROGUE_RUTHLESSNESS = 14156;

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_ROGUE_RUTHLESSNESS_COMBO_POINT });
    }

    void HandleAfterCast()
    {
        Unit* rogue = GetCaster();
        AuraEffect const* talent = rogue->GetAuraEffect(SPELL_ROGUE_RUTHLESSNESS, EFFECT_0);
        if (!talent || !roll_chance(talent->GetAmountAsInt()))
            return;

        Unit* target = GetExplTargetUnit();
        if (!target || target == rogue)
            target = rogue->GetVictim();
        if (!target || target == rogue || !target->IsAlive())
            return;

        rogue->CastSpell(target, SPELL_ROGUE_RUTHLESSNESS_COMBO_POINT, CastSpellExtraArgs(talent));
    }

    void Register() override
    {
        AfterCast += SpellCastFn(classic_spell_rog_slice_and_dice_ruthlessness::HandleAfterCast);
    }
};

// 28814 - Revealed Flaw (Bonescythe Armor, 8 pieces): "Your Eviscerate has a chance per combo point to reveal a flaw in your opponent's armor, granting a 100%
// critical hit chance for your next Backstab, Sinister Strike, or Hemorrhage." The client aura is an add-target-trigger effect without a class mask or a
// chance, so every spell the rogue cast put 28815 (+100 crit, one charge) back on it and Sinister Strike and Backstab crit every time (damage_parity 149).
// SpellMgr turns the effect into a proc trigger; this rolls 20 % per combo point the Eviscerate spent, and 28815 spends its charge on the next ability its
// spell mods name.
class classic_spell_rog_revealed_flaw : public AuraScript
{
    static constexpr int32 CHANCE_PER_COMBO_POINT = 20;

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_ROGUE_REVEALED_FLAW_CRIT });
    }

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        Spell const* procSpell = eventInfo.GetProcSpell();
        SpellInfo const* spellInfo = eventInfo.GetSpellInfo();
        if (!procSpell || !spellInfo || spellInfo->SpellFamilyName != SPELLFAMILY_ROGUE)
            return false;

        switch (spellInfo->Id)
        {
            case 2098: case 6760: case 6761: case 6762: case 8623: case 8624: case 11299: case 11300: case 31016:
                break;
            default:
                return false;
        }

        constexpr uint32 missed = PROC_HIT_MISS | PROC_HIT_FULL_RESIST | PROC_HIT_DODGE | PROC_HIT_PARRY | PROC_HIT_EVADE | PROC_HIT_IMMUNE | PROC_HIT_DEFLECT | PROC_HIT_REFLECT;
        if (eventInfo.GetHitMask() & missed)
            return false;

        return roll_chance(CHANCE_PER_COMBO_POINT * procSpell->GetPowerTypeCostAmount(POWER_COMBO_POINTS).value_or(0));
    }

    void HandleProc(ProcEventInfo& /*eventInfo*/)
    {
        PreventDefaultAction();
        GetTarget()->CastSpell(GetTarget(), SPELL_ROGUE_REVEALED_FLAW_CRIT, CastSpellExtraArgs(TRIGGERED_FULL_MASK));
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(classic_spell_rog_revealed_flaw::CheckProc);
        OnProc += AuraProcFn(classic_spell_rog_revealed_flaw::HandleProc);
    }
};

// 13976 - Initiative: "Gives you an $m1% chance to add an additional combo point to your target after using your Ambush, Garrote, or Cheap Shot
// ability." 13754 - Improved Kick: "Gives your Kick ability a $m1% chance to silence the target for 2 sec." Same data shape as Ruthlessness: the
// proc chance of the client aura is 100 and the talent rank is its amount, so the chance is rolled here against the abilities of the rogue
// family mask (Ambush 0x200, Garrote 0x100, Cheap Shot 0x400, Kick 0x10); the client trigger spell (13977 combo point, 18425 silence) is the
// default proc action.
class classic_spell_rog_ability_chance : public AuraScript
{
public:
    explicit classic_spell_rog_ability_chance(uint32 familyMask) : _familyMask(familyMask) { }

private:
    bool CheckProc(ProcEventInfo& eventInfo)
    {
        SpellInfo const* spellInfo = eventInfo.GetSpellInfo();
        AuraEffect const* talent = GetEffect(EFFECT_0);
        Unit* target = eventInfo.GetActionTarget();
        if (!spellInfo || !talent || !target || target == GetTarget() || !target->IsAlive())
            return false;

        if (spellInfo->SpellFamilyName != SPELLFAMILY_ROGUE || !(spellInfo->SpellFamilyFlags[0] & _familyMask))
            return false;

        return roll_chance(talent->GetAmountAsInt());
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(classic_spell_rog_ability_chance::CheckProc);
    }

    uint32 _familyMask;
};

// 1943, 8639, 8640, 11273, 11274, 11275 - Rupture, 703, 8631, 8632, 8633, 11289, 11290 - Garrote: patch 1.12 made both bleeds grow with attack power.
// Ported from vMaNGOS (GPL-2.0, game/Spells/SpellAuras.cpp, Aura::CalculateDotDamage, SPELLFAMILY_ROGUE case): every tick of Rupture gets
// attack power * min(combo points, 3) / 100 on top of the spell's own amount (like Rip, only the first three points count), every tick of
// Garrote gets attack power * 3 / 100. The amount is fixed when the bleed is applied, with the combo points the finisher is spending.
class classic_spell_rog_bleed_attack_power : public AuraScript
{
    static constexpr float RUPTURE_AP_PER_COMBO_POINT = 0.01f;      // vMaNGOS: cp / 100 of attack power, up to RUPTURE_AP_MAX_COMBO_POINTS
    static constexpr int32 RUPTURE_AP_MAX_COMBO_POINTS = 3;
    static constexpr float GARROTE_AP_COEFFICIENT = 0.03f;          // vMaNGOS: 3% of attack power per tick

    void CalcAmount(AuraEffect const* /*aurEff*/, SpellEffectValue& amount, bool& canBeRecalculated)
    {
        Unit* rogue = GetCaster();
        if (!rogue)
            return;

        canBeRecalculated = false;
        float attackPower = rogue->GetTotalAttackPowerValue(BASE_ATTACK);
        if (GetSpellInfo()->SpellFamilyFlags[0] & ROGUE_GARROTE_FAMILY_FLAG)
            amount += attackPower * GARROTE_AP_COEFFICIENT;
        else
        {
            int32 points = std::min<int32>(rogue->GetPower(POWER_COMBO_POINTS), RUPTURE_AP_MAX_COMBO_POINTS);
            amount += attackPower * RUPTURE_AP_PER_COMBO_POINT * points;
        }
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(classic_spell_rog_bleed_attack_power::CalcAmount, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE);
    }

    static constexpr uint32 ROGUE_GARROTE_FAMILY_FLAG = 0x00000100;
};

// 2098, 6760, 6761, 6762, 8623, 8624, 11299, 11300, 31016 - Eviscerate: patch 1.12 made it grow with attack power. Ported from vMaNGOS
// (GPL-2.0, scripts/spells/spell_rogue.cpp, RogueEviscerateScript), where attack power * combo points * 3 / 100 is added to the damage.
// Forever's in-game tests read 4 / 100 a combo point instead (wowsims/forever, MIT, docs/evidence EV-0086, sim/rogue/eviscerate.go).
class classic_spell_rog_eviscerate : public SpellScript
{
    static constexpr float EVISCERATE_AP_PER_COMBO_POINT = 0.04f;

    void CalculateDamage(SpellEffectInfo const& /*spellEffectInfo*/, Unit* /*victim*/, int32& /*damage*/, int32& flatMod, float& /*pctMod*/) const
    {
        Unit* rogue = GetCaster();
        flatMod += int32(rogue->GetTotalAttackPowerValue(BASE_ATTACK) * rogue->GetPower(POWER_COMBO_POINTS) * EVISCERATE_AP_PER_COMBO_POINT);
    }

    void Register() override
    {
        CalcDamage += SpellCalcDamageFn(classic_spell_rog_eviscerate::CalculateDamage);
    }
};

// 8680, 8685, 8689, 11335, 11336, 11337 - Instant Poison: Forever adds 1% of the rogue's melee attack power to each hit; the client row
// states no attack power share (a tester's in-game reading, wowsims/forever, MIT, docs/evidence EV-0086, sim/rogue/poisons.go).
class classic_spell_rog_instant_poison_attack_power : public SpellScript
{
    static constexpr float INSTANT_POISON_AP_COEFFICIENT = 0.01f;

    void CalculateDamage(SpellEffectInfo const& /*spellEffectInfo*/, Unit* /*victim*/, int32& /*damage*/, int32& flatMod, float& /*pctMod*/) const
    {
        if (Unit* rogue = GetCaster())
            flatMod += int32(rogue->GetTotalAttackPowerValue(BASE_ATTACK) * INSTANT_POISON_AP_COEFFICIENT);
    }

    void Register() override
    {
        CalcDamage += SpellCalcDamageFn(classic_spell_rog_instant_poison_attack_power::CalculateDamage);
    }
};

// 2818, 2819, 11353, 11354, 25349 - Deadly Poison: Forever adds 0.9% of the rogue's melee attack power over the whole poison, split evenly
// over its ticks, for every stack (wowsims/forever, MIT, docs/evidence EV-0086, sim/rogue/poisons.go). The amount is read again when a
// stack is added, so it follows the rogue's attack power then, like the sim (dots do not snapshot, R-0006).
class classic_spell_rog_deadly_poison_attack_power : public AuraScript
{
    static constexpr float DEADLY_POISON_AP_COEFFICIENT = 0.009f;

    void CalcAmount(AuraEffect const* aurEff, SpellEffectValue& amount, bool& /*canBeRecalculated*/)
    {
        Unit* rogue = GetCaster();
        int32 period = aurEff->GetPeriod();
        int32 duration = GetSpellInfo()->GetDuration();
        if (!rogue || period <= 0 || duration <= 0)
            return;

        float ticks = float(duration / period);
        if (ticks <= 0.0f)
            return;

        amount += rogue->GetTotalAttackPowerValue(BASE_ATTACK) * DEADLY_POISON_AP_COEFFICIENT / ticks;
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(classic_spell_rog_deadly_poison_attack_power::CalcAmount, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE);
    }
};

// 1329283, 1329549 - Shank, with the Forever talents that hang on it. Both talents are bare dummies that name their spell, so nothing
// happened (wowsims/forever, MIT, sim/rogue/shank.go; tooltips; no log reading). On a Shank hit (the row always hits):
//   1329328 Venom: "Causes your Shank ability to increase your Poison damage by $1310703s1% and your chance to apply Poisons by
//           $1310703s3% for $1310703d": the rogue gets 1310703.
//   1329286 Boot Knife: "Grants your Shank ability a $s1% chance to add $s2 Combo Points to the target": effect 0 (20..100 by rank) is
//           the chance, and 1329285 gives the combo points.
class classic_spell_rog_shank_talents : public SpellScript
{
    static constexpr uint32 SPELL_ROGUE_VENOM = 1329328;
    static constexpr uint32 SPELL_ROGUE_VENOM_BUFF = 1310703;
    static constexpr uint32 SPELL_ROGUE_BOOT_KNIFE = 1329286;
    static constexpr uint32 SPELL_ROGUE_BOOT_KNIFE_POINTS = 1329285;

    void HandleHit(SpellEffIndex /*effIndex*/)
    {
        Unit* rogue = GetCaster();
        Unit* target = GetHitUnit();
        if (!rogue || !target)
            return;

        if (rogue->HasAura(SPELL_ROGUE_VENOM))
            rogue->CastSpell(rogue, SPELL_ROGUE_VENOM_BUFF, CastSpellExtraArgs(TRIGGERED_FULL_MASK));

        if (AuraEffect const* bootKnife = rogue->GetAuraEffect(SPELL_ROGUE_BOOT_KNIFE, EFFECT_0))
            if (roll_chance(bootKnife->GetAmountAsInt()))
                rogue->CastSpell(target, SPELL_ROGUE_BOOT_KNIFE_POINTS, CastSpellExtraArgs(TRIGGERED_FULL_MASK));
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(classic_spell_rog_shank_talents::HandleHit, EFFECT_0, SPELL_EFFECT_WEAPON_PERCENT_DAMAGE);
    }
};

// 1316709, 1325756, 1325757, 1325758 - Death Mark: "Finishing move that marks the target, storing a portion of the damage dealt by your
// attacks per Combo Point. Garrote and Rupture damage is stored at twice the rate. After $d, the stored damage is dealt, up to a maximum
// increased by Attack Power and Critical Strike chance". The rows hold only an empty periodic damage effect (one tick at the end) and a
// dummy. The rates are in the tooltip: $ratio 12% stored per combo point, and a cap of (base + per point x points + 0.04 x attack power
// x points) x (1 + melee crit / 100) x Coup de Grace, with base / per point 63/102, 98/158, 138/217, 156/245 by rank. Coup de Grace's
// effect 1 (7/13/20%) raises both the storage rate and the cap. The stored damage already carries every modifier, so the payout takes
// none again (wowsims/forever, MIT, sim/rogue/death_mark.go; tooltip; no log reading).
class classic_spell_rog_death_mark : public AuraScript
{
    static constexpr uint32 SPELL_ROGUE_COUP_DE_GRACE = 14162;
    static constexpr float STORED_PER_COMBO_POINT = 0.12f;
    static constexpr float CAP_ATTACK_POWER_PER_COMBO_POINT = 0.04f;
    static constexpr uint32 ROGUE_GARROTE_OR_RUPTURE = 0x00100100;     // family flags word 0: Garrote 0x100, Rupture 0x100000

    struct CapRow { uint32 SpellId; float Base; float PerPoint; };
    static constexpr CapRow CapRows[] = { { 1316709, 63.0f, 102.0f }, { 1325756, 98.0f, 158.0f }, { 1325757, 138.0f, 217.0f }, { 1325758, 156.0f, 245.0f } };

    float CoupDeGrace(Unit const* rogue) const
    {
        AuraEffect const* coup = rogue->GetAuraEffect(SPELL_ROGUE_COUP_DE_GRACE, EFFECT_1);
        return coup ? 1.0f + coup->GetAmountAsInt() / 100.0f : 1.0f;
    }

    void CalcAmount(AuraEffect const* /*aurEff*/, SpellEffectValue& amount, bool& canBeRecalculated)
    {
        canBeRecalculated = false;
        amount = 0;
        // the combo points the finisher spends are still on the rogue while the aura is created
        if (Unit* rogue = GetCaster())
            _comboPoints = rogue->GetPower(POWER_COMBO_POINTS);
        _stored = 0.0f;
    }

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        Unit* rogue = GetCaster();
        DamageInfo* damageInfo = eventInfo.GetDamageInfo();
        if (!rogue || !damageInfo || !damageInfo->GetDamage() || eventInfo.GetActor() != rogue || _comboPoints <= 0)
            return false;

        SpellInfo const* spellInfo = damageInfo->GetSpellInfo();
        if (spellInfo && spellInfo->Id == GetId())
            return false;

        float rate = STORED_PER_COMBO_POINT * _comboPoints * CoupDeGrace(rogue);
        if (spellInfo && spellInfo->SpellFamilyName == SPELLFAMILY_ROGUE && (spellInfo->SpellFamilyFlags[0] & ROGUE_GARROTE_OR_RUPTURE))
            rate *= 2.0f;
        _stored += damageInfo->GetDamage() * rate;
        return false;   // stored only; the mark deals it when it ends
    }

    void HandleTick(AuraEffect const* /*aurEff*/)
    {
        PreventDefaultAction();
        Unit* rogue = GetCaster();
        Unit* target = GetTarget();
        if (!rogue || !target->IsAlive() || _stored <= 0.0f)
            return;

        CapRow const* row = nullptr;
        for (CapRow const& candidate : CapRows)
            if (candidate.SpellId == GetId())
                row = &candidate;
        if (!row)
            return;

        float const points = float(_comboPoints);
        float const cap = (row->Base + row->PerPoint * points + CAP_ATTACK_POWER_PER_COMBO_POINT * points * rogue->GetTotalAttackPowerValue(BASE_ATTACK))
            * (1.0f + rogue->GetUnitCriticalChanceDone(BASE_ATTACK) / 100.0f) * CoupDeGrace(rogue);
        uint32 const damage = uint32(std::min(_stored, cap));
        if (!damage)
            return;

        SpellNonMeleeDamage damageInfo(rogue, target, GetSpellInfo(), GetAura()->GetSpellVisual(), GetSpellInfo()->SchoolMask, GetAura()->GetCastId());
        damageInfo.periodicLog = true;
        damageInfo.damage = damage;
        rogue->DealSpellDamage(&damageInfo, false);
        rogue->SendSpellNonMeleeDamageLog(&damageInfo);
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(classic_spell_rog_death_mark::CalcAmount, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE);
        DoCheckProc += AuraCheckProcFn(classic_spell_rog_death_mark::CheckProc);
        OnEffectPeriodic += AuraEffectPeriodicFn(classic_spell_rog_death_mark::HandleTick, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE);
    }

    int32 _comboPoints = 0;
    float _stored = 0.0f;
};

// 1856, 1857, 27617 - Vanish: ported from vMaNGOS (GPL-2.0, scripts/spells/spell_rogue.cpp, RogueVanishScript). Vanish also ends effects that let
// an enemy always know where the rogue is (Hunter's Mark, Mind Vision; patch 1.12) and puts the rogue straight into the highest Stealth rank
// known, so the stealth stays after the Vanish aura (10 s in the client data) runs out.
// Nightslayer Armor 8-piece, Clean Escape 23582: "Heals the rogue for $23583s1 when Vanish is performed." The set aura is a dummy with no
// proc flags, so nothing cast the heal; Vanish casts it while the rogue has the set aura.
class classic_spell_rog_vanish : public SpellScript
{
    static constexpr uint32 SPELL_CLEAN_ESCAPE = 23582;
    static constexpr uint32 SPELL_CLEAN_ESCAPE_HEAL = 23583;

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_CLEAN_ESCAPE_HEAL });
    }

    void HandleAfterCast()
    {
        Unit* rogue = GetCaster();
        rogue->RemoveAurasByType(SPELL_AURA_MOD_STALKED);

        if (rogue->HasAura(SPELL_CLEAN_ESCAPE))
            rogue->CastSpell(rogue, SPELL_CLEAN_ESCAPE_HEAL, CastSpellExtraArgs(TRIGGERED_FULL_MASK).SetTriggeringSpell(GetSpell()));

        Player* player = rogue->ToPlayer();
        if (!player)
            return;

        for (uint32 stealth : { 1787u, 1786u, 1785u, 1784u })
            if (player->HasSpell(stealth))
            {
                player->CastSpell(player, stealth, TRIGGERED_FULL_MASK);
                break;
            }
    }

    void Register() override
    {
        AfterCast += SpellCastFn(classic_spell_rog_vanish::HandleAfterCast);
    }
};

void AddSC_classic_rogue_abilities()
{
    RegisterSpellScript(classic_spell_rog_blade_flurry);
    RegisterSpellScript(classic_spell_rog_preparation);
    RegisterSpellScript(classic_spell_rog_eviscerate);
    RegisterSpellScript(classic_spell_rog_instant_poison_attack_power);
    RegisterSpellScript(classic_spell_rog_deadly_poison_attack_power);
    RegisterSpellScript(classic_spell_rog_vanish);
    RegisterSpellScript(classic_spell_rog_shank_talents);
    RegisterSpellScript(classic_spell_rog_death_mark);
    RegisterSpellScript(classic_spell_rog_bleed_attack_power);
    RegisterSpellScript(classic_spell_rog_relentless_strikes);
    RegisterSpellScript(classic_spell_rog_ruthlessness);
    RegisterSpellScript(classic_spell_rog_slice_and_dice_ruthlessness);
    RegisterSpellScript(classic_spell_rog_revealed_flaw);
    RegisterSpellScriptWithArgs(classic_spell_rog_ability_chance, "classic_spell_rog_initiative", 0x00000700u);
    RegisterSpellScriptWithArgs(classic_spell_rog_ability_chance, "classic_spell_rog_improved_kick", 0x00000010u);
}
