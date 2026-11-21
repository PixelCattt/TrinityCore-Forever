-- Low-level caster staves whose equip spell power our server never had (the effect never came with the item).
-- Values from the WoW Forever item tooltips. Server-only rows (no hotfix_data), same as 2026_10_10_04 and 2026_11_20_40.
-- Where no single client spell has the exact value, two or three client spells add up to it.
-- 248008 Apprentice's Spellstaff: +4 spell damage and healing (9394 Increase Spell Dam 4)
-- 249393 Soulstaff: +34 spell damage and healing (18052 Increase Spell Dam 34)
-- 249453 Radiant Staff: +56 spell damage and healing (23732 Increase Spell Dam 56)
-- 249454 Dreamstaff: +105 healing (23593 Increase Healing 92 + 7680 Increase Healing 13)
DELETE FROM `item_effect` WHERE `ID` BETWEEN 9900308 AND 9900312;
INSERT INTO `item_effect` (`ID`,`LegacySlotIndex`,`TriggerType`,`Charges`,`CoolDownMSec`,`CategoryCoolDownMSec`,`SpellCategoryID`,`SpellID`,`ChrSpecializationID`,`PlayerConditionID`,`VerifiedBuild`) VALUES
(9900308,0,1,0,-1,-1,0,9394,0,0,0),
(9900309,0,1,0,-1,-1,0,18052,0,0,0),
(9900310,0,1,0,-1,-1,0,23732,0,0,0),
(9900311,0,1,0,-1,-1,0,23593,0,0,0),
(9900312,0,1,0,-1,-1,0,7680,0,0,0);
DELETE FROM `item_x_item_effect` WHERE `ID` BETWEEN 9900308 AND 9900312;
INSERT INTO `item_x_item_effect` (`ID`,`ItemEffectID`,`ItemID`,`VerifiedBuild`) VALUES
(9900308,9900308,248008,0),
(9900309,9900309,249393,0),
(9900310,9900310,249453,0),
(9900311,9900311,249454,0),
(9900312,9900312,249454,0);
