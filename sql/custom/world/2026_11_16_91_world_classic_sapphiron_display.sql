-- Sapphiron (15989) could not be created: his only model, display 113690 (VerifiedBuild 69497), has no creature_model_info row and is not
-- in the 70938 client's CreatureDisplayInfo, so Creature::InitEntry refused him ("invalid model ... in creature_template_model") and every
-- summon of him returned nothing: his lair's spawn event (EVENT_SPAWN_SAPPHIRON, classic_instance_naxxramas.cpp) as well as the scenario's
-- summon (naxx_sapphiron 1116: "the summon at its lair failed"). The classic display 16033 is in the client data (ModelID 2241, scale 2.2)
-- with a creature_model_info row (BoundingRadius 21.42, CombatReach 22), and Sapphiron (1) 29991 already wears it.
DELETE FROM `creature_template_model` WHERE `CreatureID` = 15989;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES
(15989, 0, 16033, 1, 1, 0);
