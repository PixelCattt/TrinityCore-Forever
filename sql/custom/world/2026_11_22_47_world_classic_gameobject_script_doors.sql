-- WoW Classic: the door actions of the VMaNGOS gameobject scripts (2026_10_12_31 and _34) never moved a door.
-- They used SMART_ACTION_ACTIVATE_GAMEOBJECT (147) Open/Close, but these lists run on a gameobject (the lock, lever or
-- gate itself): Open only works with a unit caster, and Close only resets a door something used before, so neither
-- touched a door sitting in its spawn state. Seen in Blackrock Depths: the Shadowforge Key lowers the lock but the giant
-- door never turns (BUGS-ALL row 299); the Chromaggus lever (2026_10_30_80) was the same fault.
-- VMaNGOS open/close door set the state, so the rows now use SMART_ACTION_GO_SET_GO_STATE (118):
-- Open -> GO_STATE_ACTIVE (0), Close -> GO_STATE_READY (1). Only the gameobject-run lists and gameobject spawn scripts.
-- Safe to run again.
UPDATE `smart_scripts` SET `action_type` = 118, `action_param1` = IF(`action_param1` = 8, 0, 1), `action_param2` = 0
WHERE `source_type` = 9 AND `entryorguid` BETWEEN 940000000 AND 940199999 AND `action_type` = 147 AND `action_param1` IN (8, 10);
UPDATE `smart_scripts` SET `action_type` = 118, `action_param1` = IF(`action_param1` = 8, 0, 1), `action_param2` = 0
WHERE `source_type` = 1 AND `entryorguid` IN (-30043184, -30043187, -30043188, -30043196, -30043203, -30035798)
  AND `action_type` = 147 AND `action_param1` IN (8, 10);
