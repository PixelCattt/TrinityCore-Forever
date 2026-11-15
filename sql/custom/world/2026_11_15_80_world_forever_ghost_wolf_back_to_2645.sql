-- Ghost Wolf: trainers teach 2645 again (undoes world 2026_11_13_82, which stays as shipped). The 70938 client has no SkillLineAbility
-- row for 1238640 and live sends none as a hotfix (none in the EG Link 70938 hotfix capture), so 1238640 is not in the shaman's
-- spellbook and the client does not cast it. Known spells and action bars move back in characters 2026_11_15_81. Safe to run again.
INSERT IGNORE INTO `trainer_spell` (`TrainerId`,`SpellId`,`MoneyCost`,`ReqSkillLine`,`ReqSkillRank`,`ReqAbility1`,`ReqAbility2`,`ReqAbility3`,`ReqLevel`,`VerifiedBuild`)
SELECT `TrainerId`,2645,`MoneyCost`,`ReqSkillLine`,`ReqSkillRank`,`ReqAbility1`,`ReqAbility2`,`ReqAbility3`,`ReqLevel`,0 FROM `trainer_spell` WHERE `SpellId`=1238640;
DELETE FROM `trainer_spell` WHERE `SpellId`=1238640;
UPDATE `trainer_spell` SET `ReqAbility1`=2645 WHERE `ReqAbility1`=1238640;
UPDATE `trainer_spell` SET `ReqAbility2`=2645 WHERE `ReqAbility2`=1238640;
UPDATE `trainer_spell` SET `ReqAbility3`=2645 WHERE `ReqAbility3`=1238640;
