-- Water elementals hop along the lake bed instead of swimming (Discord "bugs 5", VoldemarGreed 2026-11-14, item 7).
-- In this core a creature swims only with CREATURE_STATIC_FLAG_CAN_SWIM (0x10000000) in StaticFlags1. Befouled Water Elemental
-- 3917 (Lake Falathim, Ashenvale), Sea Elemental 5461 and Sea Spray 5462 (Feralas coast) had only AMPHIBIOUS (0x00080000):
-- they may go into water but must walk the bottom, so on an uneven lake bed they step and fall in short hops.
-- Lesser Water Elemental 691 already has both flags and swims. These three now get CAN_SWIM as well; nothing else changes.
-- Only these three water dwellers, not the other elementals that carry AMPHIBIOUS alone. Safe to run again.
UPDATE `creature_template_difficulty` SET `StaticFlags1` = `StaticFlags1` | 0x10000000 WHERE `Entry` IN (3917, 5461, 5462);
