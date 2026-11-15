-- Rescue OOX-17/TN! walks to Steamwheedle Port and back forever (Discord, fox4039, 2026-11-14, 0.1.36). The converted VMaNGOS
-- quest start scripts of six escorts start their path with repeat on, so when the escort reaches its last waypoint SmartAI
-- starts the same path again from the first one: the escort turns round and walks back, and on 0.1.36 (no player stored as
-- escort target, fixed in 2026_11_13_32) the quest never completed at all. An escort walks its path once, as The Defias
-- Traitor (155) already does: OOX-17/TN (648), OOX-09/HL (836), OOX-22/FE (2767), Suntara Stones (3367), In Dreams (5944)
-- and Protect Kaya (6523). Safe to run again.
UPDATE `smart_scripts` SET `action_param3` = 0
 WHERE `source_type` = 9 AND `action_type` = 53 AND `action_param3` = 1
   AND ((`entryorguid` = 950000034 AND `id` = 4 AND `action_param2` = 820077840 AND `action_param4` = 648)
     OR (`entryorguid` = 950000061 AND `id` = 4 AND `action_param2` = 820078060 AND `action_param4` = 836)
     OR (`entryorguid` = 950000185 AND `id` = 4 AND `action_param2` = 820078070 AND `action_param4` = 2767)
     OR (`entryorguid` = 950000197 AND `id` = 3 AND `action_param2` = 810082840 AND `action_param4` = 3367)
     OR (`entryorguid` = 950000253 AND `id` = 0 AND `action_param2` = 820018420 AND `action_param4` = 5944)
     OR (`entryorguid` = 950000258 AND `id` = 3 AND `action_param2` = 820118560 AND `action_param4` = 6523));
