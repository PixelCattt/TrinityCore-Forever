-- Knot Thimblejack (14338, Dire Maul North): right-clicking him opened nothing (Karrz 2026-11-16, quest 5518 complete). He only had
-- the quest giver flag, as in vanilla, but his script answers with a gossip window (his shackles text, the trap question and, once
-- 5518 is turned in, "Please teach me how to make a Gordok Ogre Suit!"). This client opens a gossip window only for a creature
-- with the talk flag, and the server shows that flag only when the creature has a gossip menu whose text exists
-- (Player::CanSeeGossipOn), so he gets both: npcflag GOSSIP | QUESTGIVER and menu 91014338 with his own text (2026_11_16_04),
-- numbered like the other scripted Classic NPCs (2026_11_12_22). The script still builds the whole window. Safe to run again.
UPDATE `creature_template` SET `npcflag` = `npcflag` | 1 WHERE `entry` = 14338;

DELETE FROM `gossip_menu` WHERE `MenuID` = 91014338;
INSERT INTO `gossip_menu` (`MenuID`,`TextID`,`VerifiedBuild`) VALUES
(91014338,91014338,0);

DELETE FROM `creature_template_gossip` WHERE `CreatureID` = 14338;
INSERT INTO `creature_template_gossip` (`CreatureID`,`MenuID`,`VerifiedBuild`) VALUES
(14338,91014338,0);
