-- Naxxramas: pulling a boss pulled trash from all over its wing. The vanilla formations import (2026_10_11_13) put whole
-- wings in a boss's group with "members assist leader" (groupAI 1), and CreatureGroup::MemberEngagingTarget has no range:
-- Patchwerk brought 18 Bile Retchers, Sludge Belchers, Patchwork Golems and Living Monstrosities from up to 328 y away
-- (Karrz 11-15: "things coming through the wall"), Instructor Razuvious 31 mobs of the Military Quarter (up to 331 y),
-- Grobbulus 3 Stitched Spewers (up to 127 y), Grand Widow Faerlina 7 Acolytes and a Skitterer 35-79 y out.
-- The trash keeps its own packs; each boss keeps only what stands with it (Faerlina's Worshippers and Followers, 3-12 y).
DELETE FROM `creature_formations` WHERE `leaderGUID` IN (20088298, 20088460, 20088303) AND `memberGUID` <> `leaderGUID`;
DELETE f FROM `creature_formations` f
  JOIN `creature` l ON l.`guid` = f.`leaderGUID`
  JOIN `creature` c ON c.`guid` = f.`memberGUID`
 WHERE f.`leaderGUID` = 20088496 AND f.`memberGUID` <> f.`leaderGUID`
   AND (POW(c.`position_x` - l.`position_x`, 2) + POW(c.`position_y` - l.`position_y`, 2)) > 20 * 20;
