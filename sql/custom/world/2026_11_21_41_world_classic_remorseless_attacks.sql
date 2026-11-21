-- Classic 1.60 (client 70959): rogue talent Remorseless Attacks 14144 gives Remorseless 14143 (the talent amount as extra critical strike
-- chance on the next Sinister Strike, Backstab, Ambush, Mutilate or Ghostly Strike) after a kill that yields experience or honor
-- (classic_talents_warrior_rogue_hunter.cpp). The talent is a dummy without a triggered spell, so it did nothing. Safe to run again.
DELETE FROM `spell_script_names` WHERE `ScriptName`='classic_spell_rog_remorseless_attacks';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(14144, 'classic_spell_rog_remorseless_attacks');
