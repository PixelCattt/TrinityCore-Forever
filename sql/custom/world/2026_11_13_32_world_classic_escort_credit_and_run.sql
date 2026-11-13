-- Classic escorts: quest credit at the end of the walk, and escorts that run.
--
-- 1) Rescue OOX-17/TN! (648), Rescue OOX-09/HL! (836), Rescue OOX-22/FE! (2767) and Protect Kaya (6523) never completed.
--    The converted start scripts begin the path with the creature itself as target, so no player is stored as escort
--    target and SmartAI has nobody to credit when the path ends. VMaNGOS completes these four when the escort reaches its
--    last waypoint (map event success: complete quest, then despawn after 3 seconds), so the path now starts on the player
--    who took the quest and the escort despawns 3 seconds after the end, as there. Same fix as The Defias Brotherhood (155).
--    Not touched: Questioning Reethe (1273), In Dreams (5944) and Suntara Stones (3367) complete through other events, and
--    The Exorcism, Mana Surges and Cleansing of the Orb of Orahil (1955, 1957, 4961) are not escort quests.
--
-- 2) Converted start scripts that set run before the path (VMaNGOS SET_RUN) had no effect: SmartAI takes walk or run from
--    waypoint_path.MoveType, and the converter left every path at walk. These four paths are run, as in VMaNGOS:
--    810004670 The Defias Traitor (155), 810047090 (quest 1191 end script), 820004000 (gossip 5709), 820498310 (Ogron, 12741).
--    The Defias Traitor's switch back to walk at waypoint 68 has no per-node equivalent, so he runs the whole way.
--
-- Safe to run again.

UPDATE `smart_scripts` SET `target_type` = 7, `action_param5` = 3000
 WHERE `source_type` = 9 AND `action_type` = 53
   AND ((`entryorguid` = 950000034 AND `id` = 4 AND `action_param2` = 820077840 AND `action_param4` = 648)
     OR (`entryorguid` = 950000061 AND `id` = 4 AND `action_param2` = 820078060 AND `action_param4` = 836)
     OR (`entryorguid` = 950000185 AND `id` = 4 AND `action_param2` = 820078070 AND `action_param4` = 2767)
     OR (`entryorguid` = 950000258 AND `id` = 3 AND `action_param2` = 820118560 AND `action_param4` = 6523));

UPDATE `waypoint_path` SET `MoveType` = 1 WHERE `PathId` IN (810004670, 810047090, 820004000, 820498310) AND `MoveType` = 0;
