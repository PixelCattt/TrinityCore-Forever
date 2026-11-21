-- Classic 1.60: every character had the other faction's language at 1/300. Spell 1293657 "Languages" sits under Common 98
-- and Orcish 109; learning it from the own language also opened the other line through SkillRaceClassInfo 49 (Orcish for
-- Alliance races) or 41 (Common for orc, tauren and troll), which rank it 1/300. On the official realm those lines show 0/0
-- (70938 login sniffs, 18 and 19 Nov 2026) and the server no longer gives them (Player::AddSpell). Take the wrong rank off
-- existing characters, bots included. Race lists are the playable races of those two SkillRaceClassInfo rows (ChrRaces
-- PlayableRaceBit, 1.60 client). Own languages are other rows (40, 48) for other races and are not touched. A GM who used
-- ".learn all lang" on such a character loses that one line too; ".learn all lang" gives it back. Safe to run again.

DELETE `cs` FROM `character_skills` `cs`
JOIN `characters` `c` ON `c`.`guid` = `cs`.`guid`
WHERE `cs`.`skill` = 109 AND `c`.`race` IN (1, 3, 4, 7, 11, 22, 25, 29, 30, 32, 34, 37, 52, 85, 86, 95);

DELETE `cs` FROM `character_skills` `cs`
JOIN `characters` `c` ON `c`.`guid` = `cs`.`guid`
WHERE `cs`.`skill` = 98 AND `c`.`race` IN (2, 6, 8);
