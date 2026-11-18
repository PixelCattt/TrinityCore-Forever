-- .aura self takes several spells in one line (one chat line per macro press is all the client sends during a boss fight).
-- New file; 2026_11_10_99 stays as shipped. Safe to run again.
DELETE FROM `command` WHERE `name` = 'aura self';
INSERT INTO `command` (`name`, `help`) VALUES
('aura self', 'Syntax: .aura self #spellid [#spellid ...]\r\n\r\nAdd the aura of each spell #spellid to yourself, whatever you have targeted. In a boss fight the client only lets a macro send a party, raid or whisper line, so start the macro line with /p, /ra or /w YourName (for example: /w YourName .aura self 1459 21562).');
