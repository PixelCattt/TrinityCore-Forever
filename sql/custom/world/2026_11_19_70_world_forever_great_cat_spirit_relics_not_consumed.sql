-- The Great Cat Spirit relics (Moonglade Barrow Dens): a relic is gone for everybody once one player opens it (GitHub issue 16,
-- The Great Windborne Cat Spirit, 0.1.37: "one relic doesn't appear or can't be looted"). 2026_11_16_12 gave the three relics
-- personal loot (Data30), but 2026_11_04_96 had already set the Consumable chest flag (Data20 bit 0x1) on them. With that flag the
-- server despawns the whole object once the opener's own loot is empty (GameObject::Update GO_JUST_DEACTIVATED, IsDespawnAtAction)
-- and skips the hide-for-this-player-only step (GameObject::OnLootRelease), so the first player or bot to open the Relic of the
-- Claw (one spawn) takes it from everyone for 5 minutes. Quest chests with personal loot are not consumed: clear the flag on
-- these three only. Only rows still in that state are touched. Safe to run again.
UPDATE `gameobject_template` SET `Data20` = `Data20` & ~1
WHERE `entry` IN (672821,673093,673094) AND `type` = 3 AND `Data30` = `entry` AND (`Data20` & 1) = 1;
