-- WoW Forever: Dire Maul East, the Conservatory Door to Alzzin the Wildshaper never opened, for players or bots. Old Ironbark (11491)
-- is meant to turn into Ironbark the Redeemed (14241) once Zevrim Thornhoof is dead (his gossip, text 6694: "Zevrim controls...
-- end this torment"), and Ironbark the Redeemed opens the door when the party says "We are ready for you to open the door" (menu
-- 5602). Two faults in the converted VMaNGOS scripts (2026_09_28_15):
--  * his "become Ironbark the Redeemed" event (smart_scripts 11491 id 0, out of combat after 1 s) lost its condition, so he turned
--    1 s after the instance loaded, with Zevrim alive. It now waits for Zevrim: instance data 4 (TYPE_BOSS_ZEVRIM) DONE, which
--    classic_boss_zevrim sets on his death.
--  * the "open the door" event (id 2, then the gossip script 560100 in actionlist 950000427, which sets instance data 5 and so opens
--    the door) answered menu 5601, Old Ironbark's own menu, which has no option. The option is Ironbark the Redeemed's menu 5602,
--    and the event stays on 11491's script (UPDATE_TEMPLATE keeps the creature's SmartAI), so it now answers 5602 option 0.
-- Safe to run again.

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=22 AND `SourceGroup`=1 AND `SourceEntry`=11491 AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(22,1,11491,0,0,13,1,4,3,0,0,0,0,'','Old Ironbark becomes Ironbark the Redeemed only once Zevrim Thornhoof is dead');

UPDATE `smart_scripts` SET `event_param1`=5602, `event_param2`=0 WHERE `entryorguid`=11491 AND `source_type`=0 AND `id`=2 AND `event_type`=62;
