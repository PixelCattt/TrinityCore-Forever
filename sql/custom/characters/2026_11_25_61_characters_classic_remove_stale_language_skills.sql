-- Classic 1.60: ".learn all languages" and the Availability 0 language rows in SkillRaceClassInfo could add fake
-- language lines at 1/300: opposing faction languages and the obsolete Common aliases 137..141. Real languages are
-- always 300/300; weapon skill 136 (Staves) is not a language and is deliberately absent from this list.
-- This removes only unfinished/stale language rows and is safe to run again. Legitimate own languages stay at 300/300.

DELETE `cs` FROM `character_skills` `cs`
JOIN `characters` `c` ON `c`.`guid` = `cs`.`guid`
WHERE `cs`.`skill` IN (98, 109, 111, 113, 115, 137, 138, 139, 140, 141, 313, 315, 673, 759, 791, 792, 905, 2464, 2776, 2987)
  AND (`cs`.`value` <> 300 OR `cs`.`max` <> 300);
