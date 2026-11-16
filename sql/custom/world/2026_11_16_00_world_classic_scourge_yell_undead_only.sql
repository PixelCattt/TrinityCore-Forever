-- "I just saw a Scourge! Kill it!": eight Stormwind townsfolk (Renato Gallina, Thomas Miller, William Montague, Michael Garrett,
-- Hannah Akeley, Stephanie Turner, Innkeeper Norman, Officer Maloof) yell it when they see a Forsaken player. The VMaNGOS EventAI
-- conversion kept the out-of-combat line-of-sight event (any unit, 50 y) but not its undead check, so they yelled at every player,
-- bot and guard walking past (Karrz 11-16 in the Trade District). The event now needs an undead player (race 5, mask 16).
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceEntry` IN (1432,3518,4549,4551,4575,6174,6741,15766) AND `ConditionTypeOrReference`=16;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`Comment`) VALUES
(22,2,1432,0,0,16,0,16,0,0,0,'Renato Gallina: Scourge yell only at an undead player'),
(22,2,3518,0,0,16,0,16,0,0,0,'Thomas Miller: Scourge yell only at an undead player'),
(22,1,4549,0,0,16,0,16,0,0,0,'William Montague: Scourge yell only at an undead player'),
(22,4,4551,0,0,16,0,16,0,0,0,'Michael Garrett: Scourge yell only at an undead player'),
(22,1,4575,0,0,16,0,16,0,0,0,'Hannah Akeley: Scourge yell only at an undead player'),
(22,1,6174,0,0,16,0,16,0,0,0,'Stephanie Turner: Scourge yell only at an undead player'),
(22,3,6741,0,0,16,0,16,0,0,0,'Innkeeper Norman: Scourge yell only at an undead player'),
(22,1,15766,0,0,16,0,16,0,0,0,'Officer Maloof: Scourge yell only at an undead player');
