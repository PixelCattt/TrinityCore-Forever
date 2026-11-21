-- Classic 1.60 / Forever quest 97485 "Traditions of the Bluff" (Eylah Sunhorn 269068, Thunder Bluff): the four incense
-- suppliers sold every ingredient twice, and the two sets do not mix (Discord bug-report 2026-11-20, Mansen, post
-- 1573322199639662915: "each of the four items you need to make the incense have a duplicate item at each vendor").
--   quest set, Craft Incense 1303520 -> 278078 Prepared Incense (objective 476015): 278079 278080 278081 278083 (quest items)
--   later set, Craft Incense 1310132 -> 281040 (the quest rewards 5 of these):    281041 281042 281043 281044 (soulbound)
-- Live 70124 sniff of Naal Mistrunner (3027) by a player on the quest lists 278083 and not 281044; the other three suppliers,
-- sniffed off the quest, list neither (2026_10_01_04_world_forever_sniff_npc.sql). Both sets are shown by quest state on
-- live; our rows (2026_10_22_00 and the 28104x rows of 2026_11_05_99) had no condition, so everyone saw both.
-- Now: the quest set only while 97485 is in the quest log, the later set once 97485 is rewarded. The gate of the later set
-- is INFERRED from the one sniff (hidden while the quest was taken); no live capture after the quest exists yet.
-- Conditions: CONDITION_SOURCE_TYPE_NPC_VENDOR (23), SourceGroup = vendor entry, SourceEntry = item;
-- CONDITION_QUESTTAKEN (9) and CONDITION_QUESTREWARDED (8). Safe to run again.

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 23 AND (`SourceGroup`, `SourceEntry`) IN
    ((3014, 278079), (3012, 278080), (3005, 278081), (3027, 278083),
     (3014, 281041), (3012, 281042), (3005, 281043), (3027, 281044));

INSERT INTO `conditions`
    (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`,
     `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ConditionStringValue1`, `NegativeCondition`, `ErrorType`, `ErrorTextId`,
     `ScriptName`, `Comment`)
VALUES
    (23, 3014, 278079, 0, 0, 9, 0, 97485, 0, 0, '', 0, 0, 0, '', 'Nida Winterhoof - Bundle of Herbs (quest set) only while Traditions of the Bluff is taken'),
    (23, 3012, 278080, 0, 0, 9, 0, 97485, 0, 0, '', 0, 0, 0, '', 'Nata Dawnstrider - Bundle of Dried Cedar Twigs (quest set) only while Traditions of the Bluff is taken'),
    (23, 3005, 278081, 0, 0, 9, 0, 97485, 0, 0, '', 0, 0, 0, '', 'Mahu - Sinew Thread (quest set) only while Traditions of the Bluff is taken'),
    (23, 3027, 278083, 0, 0, 9, 0, 97485, 0, 0, '', 0, 0, 0, '', 'Naal Mistrunner - Ceremonial Flint and Tinder (quest set) only while Traditions of the Bluff is taken'),
    (23, 3014, 281041, 0, 0, 8, 0, 97485, 0, 0, '', 0, 0, 0, '', 'Nida Winterhoof - Bundle of Herbs (later set) once Traditions of the Bluff is rewarded'),
    (23, 3012, 281042, 0, 0, 8, 0, 97485, 0, 0, '', 0, 0, 0, '', 'Nata Dawnstrider - Bundle of Dried Cedar Twigs (later set) once Traditions of the Bluff is rewarded'),
    (23, 3005, 281043, 0, 0, 8, 0, 97485, 0, 0, '', 0, 0, 0, '', 'Mahu - Sinew Thread (later set) once Traditions of the Bluff is rewarded'),
    (23, 3027, 281044, 0, 0, 8, 0, 97485, 0, 0, '', 0, 0, 0, '', 'Naal Mistrunner - Ceremonial Flint and Tinder (later set) once Traditions of the Bluff is rewarded');
