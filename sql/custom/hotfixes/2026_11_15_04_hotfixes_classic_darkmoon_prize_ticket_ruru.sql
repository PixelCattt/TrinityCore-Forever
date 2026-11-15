-- Darkmoon Faire Prize Ticket (19182): the item is our own hotfix row (2026_10_25_63, it is not in the client's ItemSparse), written
-- with the English name only, so a Russian client showed "Darkmoon Faire Prize Ticket" (GitHub issue #10, cyborgx5, 2026-11-15).
-- Russian name of the classic item. The existing hotfix_data row (1020300) sends it with the record. Safe to run again.
SET NAMES utf8mb4;
DELETE FROM `item_sparse_locale` WHERE `ID` = 19182 AND `locale` = 'ruRU';
INSERT INTO `item_sparse_locale` (`ID`,`locale`,`Description_lang`,`Display3_lang`,`Display2_lang`,`Display1_lang`,`Display_lang`,`VerifiedBuild`) VALUES
(19182,'ruRU','','','','','Призовой билет ярмарки Новолуния',70532);
