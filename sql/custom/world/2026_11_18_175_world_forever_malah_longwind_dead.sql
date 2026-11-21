-- Mulgore: Longwalker Malah (99079) ends at Malah Longwind (275789), and the quest text says she lies dead with arrows in her back and
-- in the ground around her. The sniff gave her only aura 1319092 (a dummy aura with no pose of its own), so she stood. She now lies
-- dead (StandState 7), as Resaan Nimbuswalker (259013) and Deathguard Falgan (257663) do; the quest is still handed in to her.
-- Safe to run again.
INSERT INTO `creature_template_addon` (`entry`,`StandState`,`auras`) VALUES (275789,7,'1319092')
ON DUPLICATE KEY UPDATE `StandState` = 7;
