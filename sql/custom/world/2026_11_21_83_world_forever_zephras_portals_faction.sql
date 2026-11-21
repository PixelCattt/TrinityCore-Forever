-- Zephras Isle (map 2991), Valanaar auction house: Portal to Stormwind (8380101) and Portal to Orgrimmar (8380102)
-- stand side by side with no faction gate (added by 2026_11_05_99), so Alliance players saw and could use the
-- Orgrimmar portal and Horde players the Stormwind one. Each portal is now visible to its own faction only.
-- Reported by Everlake (github.com/buildthehomelab/wow-trinitycore-everlake, GPL-3, 24bae3fb), who removed both portals.
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=32 AND `SourceGroup`=8 AND `SourceEntry` IN (8380101,8380102);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ConditionStringValue1`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(32,8,8380101,0,0,6,0,469,0,0,'',0,0,0,'','Portal to Stormwind (Zephras Isle) visible to Alliance only'),
(32,8,8380102,0,0,6,0,67,0,0,'',0,0,0,'','Portal to Orgrimmar (Zephras Isle) visible to Horde only');
