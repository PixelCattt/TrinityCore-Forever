-- WoW Forever riding prices at Friendly: Apprentice Riding (33388, level 40) 100g, Journeyman Riding (33391, level 60) 1,000g.
-- Live racial riding trainers take 10% off from Honored (90g / 900g); that discount is applied by the core
-- (Player::GetReputationPriceDiscount), so the stored price is the Friendly one. Rows that still hold the Honored price
-- (90g / 900g) are raised; any other price is left alone.
UPDATE `trainer_spell` SET `MoneyCost` = 1000000 WHERE `SpellId` = 33388 AND `MoneyCost` = 900000;
UPDATE `trainer_spell` SET `MoneyCost` = 10000000 WHERE `SpellId` = 33391 AND `MoneyCost` = 9000000;
