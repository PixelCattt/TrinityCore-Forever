-- WoW Forever: item proc rates measured in Forever logs (wowsims/forever, MIT, tools/database/overrides/weapon_procs.go and
-- spell_overrides.go; its evidence notes are named per row; ported from Everlake, GPL, PR 81). Safe to run again.

-- Weapons whose chance-on-hit spell states no rate: Player::CastItemCombatSpell fell back to the weapon-speed rate, which rolls only on
-- white swings (about 1 a minute). Their measured rates also roll on specials, seals and judgements (EV-0125, EV-0126, EV-0132; Blackblade
-- 1.15 from the EV-0136 sweep). These replace the 0 of 2026_10_11_25.
INSERT INTO `item_template_addon` (`Id`,`SpellPPMChance`) VALUES
(647,1.2),    -- Destiny
(1263,1),     -- Brain Hacker
(12592,1.15), -- Blackblade of Shahram
(13246,1)     -- Argent Avenger
ON DUPLICATE KEY UPDATE `SpellPPMChance` = VALUES(`SpellPPMChance`);

-- Weapons whose proc is an equip aura (the item's own rate is never read for those) and whose client chance reads 100: every landed hit
-- procced. Procs per minute on the hitting weapon's speed (Aura::CalcProcChance); wand shots roll the wands'.
--   Fist of Stone 17943 3.2 (EV-0003), Heartseeking Crossbow 13040 2.7 and White Obsidian Wand 274425 3.75 (EV-0119). Firebelcher and
--   Mana Channeling Wand are left out: their rates are log fits wowsims has not validated yet.
-- Heart of Wyrmthalak 22321 (aura 27656): 2 a minute on the hitting weapon's speed, no cooldown (EV-0133; was 1 from VMaNGOS).
-- Rogue Armor Energize 27787 (Shadowcraft / Darkmantle 4-piece): 0.8 a minute on white swings (EV-0144; was 1).
-- Warrior's Resolve 450587 (Battlegear of Valor / Heroism): 1 a minute on white swings, base weapon speed (EV-0144; the row reads 100).
DELETE FROM `spell_proc` WHERE `SpellId` IN (1294794, 29626, 1294055, 27656, 27787, 450587);
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `SpellFamilyMask3`,
`ProcFlags`, `ProcFlags2`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(1294794, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 3.2, 0, 0, 0),
(29626, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 2.7, 0, 0, 0),
(1294055, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 3.75, 0, 0, 0),
(27656, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 2, 0, 0, 0),
(27787, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0.8, 0, 0, 0),
(450587, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 1, 0, 0, 0);

-- Blade of Eternal Darkness 17780 (aura 21978): 1.8 a minute on the cast time of each landed harmful spell, at least 1.5 s, rolled per
-- target, damage-free spells (Counterspell) and triggered hits (Arcane Missiles, Flamestrike ticks) included (AttributesMask 2); DoTs
-- and wand shots never (EV-0025; the client chance reads 100, so it procced on every spell). Its mana lands on every proc (EV-0108).
-- Zum'rah's Vexing Cane 18082 (aura 1294255): 0.7% on each hostile target a harmful spell lands on, damage or debuff, the client's 60 s
-- cooldown kept (EV-0124; the 100 gave a zombie on the first spell after every cooldown).
DELETE FROM `spell_proc` WHERE `SpellId` IN (21978, 1294255);
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `SpellFamilyMask3`,
`ProcFlags`, `ProcFlags2`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(21978, 0, 0, 0, 0, 0, 0, 0, 0, 5, 2, 0, 2, 0, 1.8, 0, 0, 0),
(1294255, 0, 0, 0, 0, 0, 0, 0, 0, 5, 2, 0, 0, 0, 0, 0.7, 0, 0);

-- Highborne Research Tablet 260205 (aura 1318159): 2.6 a minute on a weapon hit's own weapon speed (Auto Shot and wand shots on the ranged
-- weapon's), a flat 7% on a landed spell hit whatever its cast time (PROC_ATTR_CLASSIC_SPELL_FLAT_CHANCE 0x10000, Aura::CalcProcChance),
-- damaging hits only, never periodic ticks or damage shields (EV-0131, EV-0021; the client chance reads 100).
DELETE FROM `spell_proc` WHERE `SpellId` = 1318159;
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `SpellFamilyMask3`,
`ProcFlags`, `ProcFlags2`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(1318159, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0x10000, 0, 2.6, 7, 0, 0);

-- Dungeon set procs whose rows state 100% and no rate (EV-0144): procs per minute on a white swing's base weapon speed or a spell cast's
-- cast time, once per cast (cast phase, a damage-free cast such as a seal or Judgement included); only casts that cost mana roll
-- (script classic_spell_item_set_proc_mana_cast). Crusader's Wrath 450625 (Lightforge, Soulforge) 0.9, The Furious Storm 450626
-- (The Elements, The Five Thunders) 1, Nature's Bounty 450608 (Wildheart, Feralheart) 1 with its own script. Vestments of the Devout's
-- 450576 keeps its client 5% and takes the mana-cost rule (188 of 3,832 Renews).
DELETE FROM `spell_proc` WHERE `SpellId` IN (450625, 450626, 450608);
INSERT INTO `spell_proc` (`SpellId`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `SpellFamilyMask3`,
`ProcFlags`, `ProcFlags2`, `SpellTypeMask`, `SpellPhaseMask`, `HitMask`, `AttributesMask`, `DisableEffectsMask`, `ProcsPerMinute`, `Chance`, `Cooldown`, `Charges`) VALUES
(450625, 0, 0, 0, 0, 0, 0, 0, 0, 7, 1, 0, 0, 0, 0.9, 0, 0, 0),
(450626, 0, 0, 0, 0, 0, 0, 0, 0, 7, 1, 0, 0, 0, 1, 0, 0, 0),
(450608, 0, 0, 0, 0, 0, 0, 0, 0, 7, 1, 0, 0, 0, 1, 0, 0, 0);
DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('classic_spell_item_set_proc_mana_cast', 'classic_spell_item_natures_bounty');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(450625, 'classic_spell_item_set_proc_mana_cast'),
(450626, 'classic_spell_item_set_proc_mana_cast'),
(450576, 'classic_spell_item_set_proc_mana_cast'),
(450608, 'classic_spell_item_natures_bounty');
