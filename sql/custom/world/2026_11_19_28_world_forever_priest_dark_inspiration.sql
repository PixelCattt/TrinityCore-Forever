-- WoW Forever: Dark Inspiration 1326159 (party Spirit buff 1326168 after a landed Mind Blast or a full Mind Flay channel).
-- C++: Custom/Classic/world/talents/classic_talents_priest_paladin.cpp. Safe to run again.
DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('classic_spell_pri_dark_inspiration_mind_blast','classic_spell_pri_dark_inspiration_mind_flay');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(8092,'classic_spell_pri_dark_inspiration_mind_blast'),(8102,'classic_spell_pri_dark_inspiration_mind_blast'),(8103,'classic_spell_pri_dark_inspiration_mind_blast'),
(8104,'classic_spell_pri_dark_inspiration_mind_blast'),(8105,'classic_spell_pri_dark_inspiration_mind_blast'),(8106,'classic_spell_pri_dark_inspiration_mind_blast'),
(10945,'classic_spell_pri_dark_inspiration_mind_blast'),(10946,'classic_spell_pri_dark_inspiration_mind_blast'),(10947,'classic_spell_pri_dark_inspiration_mind_blast'),
(15407,'classic_spell_pri_dark_inspiration_mind_flay'),(17311,'classic_spell_pri_dark_inspiration_mind_flay'),(17312,'classic_spell_pri_dark_inspiration_mind_flay'),
(17313,'classic_spell_pri_dark_inspiration_mind_flay'),(17314,'classic_spell_pri_dark_inspiration_mind_flay'),(18807,'classic_spell_pri_dark_inspiration_mind_flay');
