-- WoW Forever: Lacerate "Causes a high amount of threat", which its rows state no effect for. In game the weapon hit 414647 and the bleed
-- ticks of every rank each threaten for 10/3 of their damage, with no flat part, before the bear form's threat multiplier
-- (wowsims/forever, MIT, docs/evidence EV-0034: 3.335 +- 0.0075 on hits, 3.3296 +- 0.0025 on ticks; EV-0037). Safe to run again.
DELETE FROM `spell_threat` WHERE `entry` IN (1328617, 1328616, 414644, 1235826, 1235827, 414647);
INSERT INTO `spell_threat` (`entry`, `flatMod`, `pctMod`, `apPctMod`) VALUES
(1328617, 0, 3.3333, 0),
(1328616, 0, 3.3333, 0),
(414644, 0, 3.3333, 0),
(1235826, 0, 3.3333, 0),
(1235827, 0, 3.3333, 0),
(414647, 0, 3.3333, 0);
