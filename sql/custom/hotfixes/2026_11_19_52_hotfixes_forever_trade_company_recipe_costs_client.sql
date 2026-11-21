-- Classic 1.60: the Merchant's Favor prices of the Crossroads trade company recipe vendors (2026_10_10_03) were estimates, made when
-- the client had no ItemExtendedCost rows for them. The client has them now, and the server charged the estimate while the vendor
-- window showed the client price (e.g. Pawani, Pattern: Wisdom's Leather Gloves 252782, cost 11865: shown 30 Favor, charged 90).
-- All 22 rows now carry the client's own values (currency 3402). They stay as server rows (not deleted) so a server whose data
-- comes from an older client without these IDs still sells the recipes. Changed: 11840 90->45, 11845 45->30, 11849 45->30, 11850 90->30, 11851 120->60, 11852 180->90, 11859 60->45, 11860 135->45, 11864 45->30, 11865 90->30, 11866 120->60, 11867 180->90, 11869 45->30, 11870 90->30, 11871 120->60, 11872 180->90.
-- Reported by wowiczek (Karrz1/TrinityCore issue 350). Safe to run again.
DELETE FROM `item_extended_cost` WHERE `ID` IN (11840,11845,11848,11849,11850,11851,11852,11855,11856,11857,11858,11859,11860,11861,11864,11865,11866,11867,11869,11870,11871,11872);
INSERT INTO `item_extended_cost` (`ID`,`CurrencyID1`,`CurrencyCount1`,`VerifiedBuild`) VALUES
(11840,3402,45,0),
(11845,3402,30,0),
(11848,3402,120,0),
(11849,3402,30,0),
(11850,3402,30,0),
(11851,3402,60,0),
(11852,3402,90,0),
(11855,3402,45,0),
(11856,3402,120,0),
(11857,3402,180,0),
(11858,3402,240,0),
(11859,3402,45,0),
(11860,3402,45,0),
(11861,3402,180,0),
(11864,3402,30,0),
(11865,3402,30,0),
(11866,3402,60,0),
(11867,3402,90,0),
(11869,3402,30,0),
(11870,3402,30,0),
(11871,3402,60,0),
(11872,3402,90,0);
