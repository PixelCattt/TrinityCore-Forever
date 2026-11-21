-- Shipping Label 98247 (Alliance, to Marcy Baker 256390) and 98248 (Horde, to Dokimi 256386): each is started by its label
-- (item 280179 / 280180, StartQuestID in the 70790 hotfix push) and needs that same label as its one objective.
-- The quests came in as placeholder rows with StartItem 0. On accept, Player::AddQuestAndCheckCompletion destroys the item
-- that started the quest unless it is the quest's StartItem or a unique (MaxCount > 0) objective; the label has MaxCount 0,
-- so taking the quest destroyed it and the quest could never be handed in.
-- With the label as StartItem the core keeps it on accept (and does not hand out a second one, GiveQuestSourceItem skips the
-- item that started the quest while the player holds it); the objective takes it on turn-in as before.
-- Same cause as the Craftsman's Writs (public issue #354). Cause found by Everlake (credit), SQL written here.
UPDATE `quest_template` SET `StartItem` = 280179 WHERE `ID` = 98247;
UPDATE `quest_template` SET `StartItem` = 280180 WHERE `ID` = 98248;
