-- Moonglade (94913 Horde from Turak Runetotem, 94914 Alliance from Sheldras Moontree): the Forever copies of the druid quest 5921/5922
-- had no SourceSpellID, so taking them did not teach Teleport: Moonglade (18960, through 19027) and a Skyborne druid could not reach
-- Moonglade (public issue #6, 0.1.36). 94913 also had no class mask, so any Skyborne Horde class could take it. Same values as 5922.
INSERT INTO `quest_template_addon` (`ID`,`AllowableClasses`,`SourceSpellID`) VALUES
(94913,1024,19027),
(94914,1024,19027)
ON DUPLICATE KEY UPDATE `AllowableClasses`=VALUES(`AllowableClasses`),`SourceSpellID`=VALUES(`SourceSpellID`);
