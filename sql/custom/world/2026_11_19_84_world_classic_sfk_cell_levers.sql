-- Shadowfang Keep: the two cell levers open the cells again (Discord, voldemargreed "bugs 4" 14, 2026-11-13: Sorcerer Ashcrombe
-- walks through the walls when he goes to open the door).
-- Deathstalker Adamant (3849) and Sorcerer Ashcrombe (3850) sit behind Cell Doors 18934 and 18936 (spawned closed, locked). In
-- VMaNGOS each cell has a Lever (18900 / 18901) whose gameobject_scripts open the cell (command 11, 15 s): 32442 opens 32445
-- (Adamant's cell), 34006 opens 33219 (Ashcrombe's cell). The 2026_10_12_31 conversion brought over the courtyard door lever
-- (32443) but not these two, so the levers did nothing, the cells stayed shut, and both prisoners walked out through the closed
-- bars (Ashcrombe's waypoint 2 is on his cell door, Adamant's first leg crosses his).
-- Same form as 2026_10_12_31: GO_LOOT_STATE_CHANGED (GO_ACTIVATED) on the used lever spawn, ACTIVATE_GAMEOBJECT Open on the cell
-- door spawn; like the other instance doors there, the cell is not closed again after 15 s. Safe to run again.

UPDATE `gameobject_template` SET AIName = 'SmartGameObjectAI' WHERE entry IN (18900,18901) AND ScriptName = '';
DELETE FROM `smart_scripts` WHERE source_type = 1 AND entryorguid IN (-30032442,-30034006);
INSERT INTO `smart_scripts` (entryorguid, source_type, id, link, Difficulties, event_type, event_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, event_param5, event_param_string, action_type, action_param1, action_param2, action_param3, action_param4, action_param5, action_param6, action_param7, action_param_string, target_type, target_param1, target_param2, target_param3, target_param4, target_param_string, target_x, target_y, target_z, target_o, comment) VALUES
(-30032442, 1, 0, 0, '', 70, 0, 100, 0, 2, 0, 0, 0, 0, '', 147, 8, 0, 0, 0, 0, 0, 0, '', 14, 30032445, 18934, 0, 0, '', 0.0000, 0.0000, 0.0000, 0.0000, 'VMaNGOS gameobject_scripts 32442: Shadowfang Keep lever opens Deathstalker Adamant''s cell'),
(-30034006, 1, 0, 0, '', 70, 0, 100, 0, 2, 0, 0, 0, 0, '', 147, 8, 0, 0, 0, 0, 0, 0, '', 14, 30033219, 18936, 0, 0, '', 0.0000, 0.0000, 0.0000, 0.0000, 'VMaNGOS gameobject_scripts 34006: Shadowfang Keep lever opens Sorcerer Ashcrombe''s cell');
