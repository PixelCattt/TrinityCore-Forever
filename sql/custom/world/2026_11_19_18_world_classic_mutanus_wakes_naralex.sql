-- Wailing Caverns: Naralex never woke after Mutanus died (RU forum, DoctorSun 2026-11-17: the Disciple keeps casting Awakening
-- for ever, Naralex sleeps on). The Disciple's script (classic_npc_disciple_of_naralex, ritual step 8) waits for instance data
-- CWC_TYPE_MUTANUS (5) = DONE. Mutanus' death row came from a retail script: SetBossState(4, DONE) (action_param3 = 1), which
-- marked boss 4 of our encounter list (Skum) and never set the data the Disciple waits for. It now sets data 5 to DONE (3) with
-- SetData (param3 = 0), as VMaNGOS does; the boss kill itself is credited by the instance's encounter tracker. Safe to run again.
UPDATE `smart_scripts` SET `action_param1` = 5, `action_param2` = 3, `action_param3` = 0,
    `comment` = 'Mutanus the Devourer - On Just Died - Set Instance Data 5 (Mutanus) to 3 (DONE)'
WHERE `entryorguid` = 3654 AND `source_type` = 0 AND `id` = 0 AND `action_type` = 34;
