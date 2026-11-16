-- Gerenzo's Orders (1090, Piznik 4276, Windshear Mine, Stonetalon Mountains): the attackers were already standing at the spot their
-- waves come from before anyone took the quest. Seven base-data spawns (TDB guids 128028-128037: a Windshear Vermin, two
-- Geomancers, three Stonecutters and an Overlord) stood within 4 yd of each other on that spot, the wave positions of the
-- event, which our classic_npc_piznik summons itself when the quest is taken (VMaNGOS). VMaNGOS has no spawn there (only the
-- two Diggers of the mine around it), so these were the waves placed as standing spawns. They go; the mine's own spawns stay.
-- Safe to run again.
DELETE FROM `creature` WHERE `guid` IN (128028,128032,128033,128034,128035,128036,128037) AND `map` = 1 AND `id` IN (3998,4002,4003,4004);
