-- Library book quests (Garion Wendell 211033, Owen Thadd 211022, Jennea Cannon 5497): the book objects stay highlighted and can be
-- looted again after the player has turned the book in (Discord, voldemargreed, 2026-11-14). Each of the 29 book quests of
-- 2026_11_06_80 has one book object (a chest that drops the book). The object is now hidden for a player who has turned that book
-- quest in. It stays visible while the quest is in the log, so a player who lost the book can loot it again. The book quests are
-- not repeatable in our data (INFERRED from their flags). Safe to run again.
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 32 AND `SourceGroup` = 8 AND `SourceEntry` IN
(409496,409501,409562,409700,409735,409711,386691,386759,408014,405879,407566,423895,423896,423897,423898,423899,423900,441248,441252,441253,441254,463213,463206,463209,463207,463214,463208,463212,463211);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`Comment`) VALUES
(32,8,409496,0,0,8,0,78124,0,0,1,'Library book object 409496: hidden once its book quest 78124 is turned in'),
(32,8,409501,0,0,8,0,78127,0,0,1,'Library book object 409501: hidden once its book quest 78127 is turned in'),
(32,8,409562,0,0,8,0,78142,0,0,1,'Library book object 409562: hidden once its book quest 78142 is turned in'),
(32,8,409700,0,0,8,0,78145,0,0,1,'Library book object 409700: hidden once its book quest 78145 is turned in'),
(32,8,409735,0,0,8,0,78147,0,0,1,'Library book object 409735: hidden once its book quest 78147 is turned in'),
(32,8,409711,0,0,8,0,78149,0,0,1,'Library book object 409711: hidden once its book quest 78149 is turned in'),
(32,8,386691,0,0,8,0,79091,0,0,1,'Library book object 386691: hidden once its book quest 79091 is turned in'),
(32,8,386759,0,0,8,0,79092,0,0,1,'Library book object 386759: hidden once its book quest 79092 is turned in'),
(32,8,408014,0,0,8,0,79093,0,0,1,'Library book object 408014: hidden once its book quest 79093 is turned in'),
(32,8,405879,0,0,8,0,79095,0,0,1,'Library book object 405879: hidden once its book quest 79095 is turned in'),
(32,8,407566,0,0,8,0,79097,0,0,1,'Library book object 407566: hidden once its book quest 79097 is turned in'),
(32,8,423895,0,0,8,0,79947,0,0,1,'Library book object 423895: hidden once its book quest 79947 is turned in'),
(32,8,423896,0,0,8,0,79948,0,0,1,'Library book object 423896: hidden once its book quest 79948 is turned in'),
(32,8,423897,0,0,8,0,79949,0,0,1,'Library book object 423897: hidden once its book quest 79949 is turned in'),
(32,8,423898,0,0,8,0,79950,0,0,1,'Library book object 423898: hidden once its book quest 79950 is turned in'),
(32,8,423899,0,0,8,0,79951,0,0,1,'Library book object 423899: hidden once its book quest 79951 is turned in'),
(32,8,423900,0,0,8,0,79952,0,0,1,'Library book object 423900: hidden once its book quest 79952 is turned in'),
(32,8,441248,0,0,8,0,81949,0,0,1,'Library book object 441248: hidden once its book quest 81949 is turned in'),
(32,8,441252,0,0,8,0,81954,0,0,1,'Library book object 441252: hidden once its book quest 81954 is turned in'),
(32,8,441253,0,0,8,0,81955,0,0,1,'Library book object 441253: hidden once its book quest 81955 is turned in'),
(32,8,441254,0,0,8,0,81956,0,0,1,'Library book object 441254: hidden once its book quest 81956 is turned in'),
(32,8,463213,0,0,8,0,84395,0,0,1,'Library book object 463213: hidden once its book quest 84395 is turned in'),
(32,8,463206,0,0,8,0,84396,0,0,1,'Library book object 463206: hidden once its book quest 84396 is turned in'),
(32,8,463209,0,0,8,0,84397,0,0,1,'Library book object 463209: hidden once its book quest 84397 is turned in'),
(32,8,463207,0,0,8,0,84398,0,0,1,'Library book object 463207: hidden once its book quest 84398 is turned in'),
(32,8,463214,0,0,8,0,84399,0,0,1,'Library book object 463214: hidden once its book quest 84399 is turned in'),
(32,8,463208,0,0,8,0,84400,0,0,1,'Library book object 463208: hidden once its book quest 84400 is turned in'),
(32,8,463212,0,0,8,0,84401,0,0,1,'Library book object 463212: hidden once its book quest 84401 is turned in'),
(32,8,463211,0,0,8,0,84402,0,0,1,'Library book object 463211: hidden once its book quest 84402 is turned in');
