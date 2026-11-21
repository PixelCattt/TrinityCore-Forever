-- Battle.net friend invitations a player sent to a bot (its name typed in Add Friend): a bot's pool account never answers them, so
-- they stayed pending for good. From now on Add Friend makes a bot a character friend (FriendsService::HandleSendInvitation), so the
-- old invitations go. Bot pool accounts are the Battle.net accounts with the synthetic <name>@playerbot-v2.local address
-- (PlayerbotV2 BotAccountMgr). Safe to run again.
DELETE i FROM `battlenet_friend_invitations` i
JOIN `battlenet_accounts` b ON b.`id` = i.`invitee_account_id`
WHERE UPPER(b.`email`) LIKE '%@PLAYERBOT-V2.LOCAL';
