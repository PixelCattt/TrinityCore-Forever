-- WoW Forever: weapon chance-on-hit rates measured in Forever Warcraft Logs (wowsims/forever, MIT, docs/evidence EV-0136; ported from
-- Everlake, GPL, PR 81). These weapons' proc spells state no rate (no proc row, or the 100 / 101 sentinel), so the core fell back to the
-- weapon-speed rate, which rolls only on white swings (about 1 a minute) and never on specials. Rates are procs per minute on the hitting
-- weapon's base speed (Player::CastItemCombatSpell). Only the 27 measured weapons; unvalidated log fits are not taken. Safe to run again.
-- Measured in the EV-0136 Warcraft Logs sweep (27 weapons).
INSERT INTO `item_template_addon` (`Id`,`SpellPPMChance`) VALUES
(754,1), -- Shortsword of Vengeance
(869,2.8), -- Dazzling Longsword
(1982,2), -- Nightblade
(2099,4.3), -- Dwarven Hand Cannon
(2164,1.55), -- Gut Ripper
(2825,5.4), -- Bow of Searing Arrows
(3078,2.2), -- Naga Heartpiercer
(6469,2.05), -- Venomstrike
(6831,2), -- Black Menace
(6953,2.2), -- Verigans Fist
(8225,2.15), -- Tainted Pierce
(9372,1.5), -- Sulthraze the Lasher
(9412,4.25), -- Galganns Fireblaster
(9425,1.05), -- Pendulum of Doom
(9446,4.25), -- Electrocutioner Leg
(9467,2.1), -- Gahzrilla Fang
(9477,1), -- The Chiefs Enforcer
(10567,2.9), -- Quillshooter
(10761,2.85), -- Coldrage Dagger
(11817,2.1), -- Lord Generals Sword
(13952,1.9), -- Iceblade Hacker
(17752,2.1), -- Satyrs Lash
(267369,2.25), -- Wolfsbane
(272999,3.45), -- Barbaric Crossbow
(274293,1), -- Spellsever Crossbow
(279895,3.3), -- Ironforge Greathammer
(286430,1.95) -- Toofbreaker
ON DUPLICATE KEY UPDATE `SpellPPMChance` = VALUES(`SpellPPMChance`);
