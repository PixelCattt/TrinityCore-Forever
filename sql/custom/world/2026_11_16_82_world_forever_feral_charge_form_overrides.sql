-- Druid: Feral Charge 1238122 (talent) turns into Feral Charge (Cat) 414924 in Cat Form and Feral Charge (Bear) 16979 in Bear and
-- Dire Bear Form through two hidden form spells: 414925 (Cat Form only) and 1238124 (Bear, Dire Bear Form), both "override action bar
-- spell 1238122". The client data (SpellLearnSpell, SkillLineAbility) teaches neither, so nobody had them and the button stayed on the
-- bear version in Cat Form ("Requires Bear Form"). Learning Feral Charge now teaches both; the shapeshift puts the one for the form on.
DELETE FROM `spell_learn_spell` WHERE `entry` = 1238122 AND `SpellID` IN (414925, 1238124);
INSERT INTO `spell_learn_spell` (`entry`, `SpellID`, `Active`) VALUES
(1238122, 414925, 0),
(1238122, 1238124, 0);
