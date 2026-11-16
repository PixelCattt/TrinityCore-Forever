-- SIN's fix (1amcoff1n), Warpwood Crusher Scale Fix for 0.1.37 (Warpwood-Crusher-Scale.sql).
-- local_warpwood_crusher_scale: use the standard size of display 12929.
UPDATE creature_template_model SET DisplayScale=1
WHERE CreatureID=13021 AND Idx=0 AND CreatureDisplayID=12929 AND DisplayScale=3.5;
