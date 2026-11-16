-- WoW Forever: the First Aid trainers teach the live list. On the live realm (16 Nov capture) Shaina Fuller's (2327, Stormwind)
-- list is Blizzard's First Aid trainer 39: Apprentice First Aid 3279, Journeyman First Aid 3280 and the recipes with the
-- First Aid skill line of the 1.60 client (2942, the child line of First Aid 129). Ours pointed at older copies (100xxxx:
-- 3273/3274 straight, skill line 129). Thamner Pol, Pand Stonebinder and Nurse Neela already use trainer 39 from an earlier
-- live capture; the other nine First Aid trainers with the same older copy get trainer 39 too.
-- Safe to run again.

UPDATE `creature_trainer` SET `TrainerId`=39 WHERE (`CreatureId`,`TrainerId`) IN
((2327,1002327),(2329,1002329),(3181,1003181),(3373,1003373),(4211,1004211),(4591,1004591),(5150,1005150),(5939,1005939),
(5943,1005943),(6094,1006094));
