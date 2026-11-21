-- Skyborne with "Feathers: None" could not log in ("wrong Appearance values", 4 characters in the af54 log). In the 70959 client data a
-- real Feather Color (male option 9217, female 9218) needs Feathers on (63028 / 63030); with Feathers None (63027 / 63029) the only valid
-- color is the blank choice 79307 (male) / 79306 (female). Characters made before that data kept a real color next to Feathers None, so
-- the appearance check refused them. They get the blank color, which is what the client shows with no feathers. Safe to run again.
UPDATE `character_customizations` `cc`
JOIN `character_customizations` `f` ON `f`.`guid`=`cc`.`guid` AND `f`.`chrCustomizationOptionID`=9229 AND `f`.`chrCustomizationChoiceID`=63027
SET `cc`.`chrCustomizationChoiceID`=79307
WHERE `cc`.`chrCustomizationOptionID`=9217 AND `cc`.`chrCustomizationChoiceID`<>79307;

UPDATE `character_customizations` `cc`
JOIN `character_customizations` `f` ON `f`.`guid`=`cc`.`guid` AND `f`.`chrCustomizationOptionID`=9230 AND `f`.`chrCustomizationChoiceID`=63029
SET `cc`.`chrCustomizationChoiceID`=79306
WHERE `cc`.`chrCustomizationOptionID`=9218 AND `cc`.`chrCustomizationChoiceID`<>79306;
