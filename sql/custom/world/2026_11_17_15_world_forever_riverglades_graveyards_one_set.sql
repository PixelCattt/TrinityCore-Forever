-- Riverglades (zone 16591) graveyards, one set again. 2026_11_10_70 (release 0.1.37) already gave the zone four graveyards
-- (1101200-1101203) with spirit healers 47220000-47220003; 2026_11_17_13 was written on a copy without them and added three more
-- (1104114-1104116) on the same healer guids, so the zone had seven graveyards, two of them at Powderfuse Port 16 yd apart, and
-- the Farholde Keep and Rog'mar healers had moved away from their graveyards. This keeps the four old ones and takes 17_13's out.
-- Farholde Keep 1101200 stood 6 yd from Brother Lowley at his height (39.8), inside the keep's building (Tornn, Discord 17 Nov:
-- released into a building in the keep). It moves to the open ground next to gryphon master Gretchen Mayberry that ground probe
-- 154p checked (one surface, no roof, flat around it), where 17_13 had put its keep graveyard. INFERRED: live's spot is in no data.
-- Powderfuse Port's healer stands 4 yd east of graveyard 1101202 on probed open ground (the old spot was next to a roof).
DELETE FROM `world_safe_locs` WHERE `ID` IN (1104114,1104115,1104116);
DELETE FROM `graveyard_zone` WHERE `ID` IN (1104114,1104115,1104116);
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=27 AND `SourceGroup`=16591 AND `SourceEntry` IN (1104114,1104115,1104116);
UPDATE `world_safe_locs` SET `LocX`=-9105.10,`LocY`=-4820.80,`LocZ`=23.30,`Facing`=270.0,
`Comment`='Forever: Riverglades, Farholde Keep GY (INFERRED, open ground by the gryphon master, probe 154p)' WHERE `ID`=1101200;
-- the healers next to their graveyards again
UPDATE `creature` SET `position_x`=-9105.10,`position_y`=-4820.80,`position_z`=23.30,`orientation`=4.712 WHERE `guid`=47220000 AND `id`=6491;
UPDATE `creature` SET `position_x`=-7763.90,`position_y`=-4798.70,`position_z`=20.10,`orientation`=3.930 WHERE `guid`=47220001 AND `id`=6491;
UPDATE `creature` SET `position_x`=-8176.80,`position_y`=-5606.80,`position_z`=3.70,`orientation`=3.142 WHERE `guid`=47220002 AND `id`=6491;
