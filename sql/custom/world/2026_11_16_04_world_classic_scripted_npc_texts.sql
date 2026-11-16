-- Gossip texts of two Classic scripted NPCs, each under an id of its own (the id of the creature's gossip menu, 91000000 + entry,
-- as in 2026_11_12_22, and the next one). Texts are the client's BroadcastText ids of the Classic npc_text rows. Safe to run again.
--   16365 Master Craftsman Omarion, pattern page: "Perhaps I can teach you something..." (12258). His script sent Classic's
--         npc_text 8508, which in this world is another NPC's line ("I'm sure that help from Farstrider Enclave will be here soon...").
--   14338 Knot Thimblejack: "Please, please, please tell me you are here to get me out of these shackles..." (9220) and, after
--         "Why should I bother fixing the trap?", "Well, from what I've gathered while waiting to be eaten by these yokels..." (9369).
--         His script sent Classic's 6795 / 6883, which are not in this world: right-clicking him opened nothing at all.
DELETE FROM `npc_text` WHERE `ID` IN (91016365, 91014338, 91014339);
INSERT INTO `npc_text` (`ID`,`Probability0`,`Probability1`,`Probability2`,`Probability3`,`Probability4`,`Probability5`,`Probability6`,`Probability7`,`BroadcastTextID0`,`BroadcastTextID1`,`BroadcastTextID2`,`BroadcastTextID3`,`BroadcastTextID4`,`BroadcastTextID5`,`BroadcastTextID6`,`BroadcastTextID7`,`VerifiedBuild`) VALUES
(91016365,1,0,0,0,0,0,0,0,12258,0,0,0,0,0,0,0,0),
(91014338,1,0,0,0,0,0,0,0,9220,0,0,0,0,0,0,0,0),
(91014339,1,0,0,0,0,0,0,0,9369,0,0,0,0,0,0,0,0);
