-- Trogg Scepter 272996 (Oggleflint, Ragefire Chasm): the tooltip says
-- Equip: Increases healing done by up to 33 and damage done by up to 11 for all magical spells and effects.
-- The client gets that line from an encrypted ItemEffect/ItemXItemEffect section, so the server had no equip spell and the
-- bonus never applied (same as Glimmering Staff, 2026_10_10_04). Spell 467647 "Hybrid Healing/Spell Dam 33/11"
-- (aura 135 healing 33, aura 13 damage 11) is in the client spell data and matches the tooltip.
-- Server only (no hotfix_data): our own IDs, the client already shows the effect from its own data.
DELETE FROM `item_effect` WHERE `ID` = 9900101;
INSERT INTO `item_effect` (`ID`,`LegacySlotIndex`,`TriggerType`,`Charges`,`CoolDownMSec`,`CategoryCoolDownMSec`,`SpellCategoryID`,`SpellID`,`ChrSpecializationID`,`PlayerConditionID`,`VerifiedBuild`) VALUES
(9900101,0,1,0,-1,-1,0,467647,0,0,0);
DELETE FROM `item_x_item_effect` WHERE `ID` = 9900101;
INSERT INTO `item_x_item_effect` (`ID`,`ItemEffectID`,`ItemID`,`VerifiedBuild`) VALUES
(9900101,9900101,272996,0);
