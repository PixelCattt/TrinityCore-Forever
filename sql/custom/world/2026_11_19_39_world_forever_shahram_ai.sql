-- WoW Forever: Shahram (10718), whom Blackblade of Shahram summons, casts one of his six spells 1.03 to 1.83 sec after he appears and nothing
-- else (script classic_npc_shahram; wowsims/forever, MIT, docs/evidence EV-0125). He had no script or SmartAI. Safe to run again.
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_npc_shahram' WHERE `entry` = 10718;
