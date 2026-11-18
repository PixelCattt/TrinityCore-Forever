-- Thunder Bluff weapon master Ansekhwa (11869) teaches Guns again (Discord, checkitout1333 2026-11-17: an Undead warrior could
-- not learn Guns anywhere). The weapon master pointed at trainer 398 from the Forever sniff, and a trainer list in a sniff only
-- holds what the sniffing character could learn: 398 is the druid's part (One-Handed Maces, Two-Handed Maces, Staves), the same
-- way the sniffed lists of Sayoc 397, Hanashi 399 and Archibald 400 match one class's weapons. Vanilla Ansekhwa also taught Guns
-- (VMaNGOS); our Classic trainer 1011869 has all four. Sayoc, Hanashi and Archibald's sniffed lists already equal their Classic
-- ones, so only Ansekhwa changes. Safe to run again.
UPDATE `creature_trainer` SET `TrainerID` = 1011869 WHERE `CreatureID` = 11869 AND `TrainerID` = 398;
