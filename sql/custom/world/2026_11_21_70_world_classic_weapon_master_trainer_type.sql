-- Classic 1.60 weapon masters open the ordinary trainer window: the official realm sends them as trainer type 0 (live captures of
-- 15 and 16 Nov 2026, client 70938: Ilyenia Moonfire 11866, trainer 396, and Buliwyf Stonehand 11865, trainer 393, both type 0).
-- Their trainer rows from the baseline import had type 2 (profession), which makes the client treat the weapon skills as a
-- profession list. Every weapon master's list (Hanashi 2704, Buliwyf Stonehand 11865, Ilyenia Moonfire 11866, Woo Ping 11867,
-- Sayoc 11868, Ansekhwa 11869, Archibald 11870, Bixi Wobblebonk 13084) becomes a plain trainer. Safe to run again.
UPDATE `trainer` SET `Type` = 0 WHERE `Id` IN (1002704, 1011865, 1011866, 1011867, 1011868, 1011869, 1011870, 1013084) AND `Type` = 2;
