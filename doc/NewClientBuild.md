# Adding a new client build

The Forever client is WoW Classic 1.60.1. Battle.net ships a new build every few days, and each one has to be taken in
by hand. This page is the runbook; 70959 (17 November 2026) is the worked example. Every step names the file and line
it changes, or the command it runs.

## What a new build needs

| Item | Change | Worked example (70959) |
|---|---|---|
| Auth build row | one `build_info` row | `sql/custom/auth/2026_11_17_70_auth_classic_70959.sql` |
| Auth key | usually nothing (skip the check) | no key; `Network.SkipBuildAuthKeyCheck` stays 1 |
| Client build list | `Realm.AlsoAcceptBuilds` in both configs | 70959 added to the list, realm 70 stays on 70707 |
| Hotfix pushes | one SQL file per wave | `2026_11_17_75_...` (wave 1), `2026_11_17_76_..._b` (wave 2) |
| DB2 layouts | a check; edit `DB2Metadata.h` only if one changed | no change recorded |

## 1. The auth build row

Worldserver refuses any client whose build has no `build_info` row: it answers `ERROR_BAD_VERSION` and closes the socket
(`src/server/game/Server/WorldSocket.cpp:739-745`). bnetserver uses the same row for the version it shows in the realm
entry and falls back to 6.2.4 when the row is missing (`src/server/shared/Realm/RealmList.cpp:294-307`).

Create `sql/custom/auth/<date>_<nn>_auth_classic_<build>.sql`. Delete first, then insert, so the file is safe to run
again. The working part of the 70959 file (`sql/custom/auth/2026_11_17_70_auth_classic_70959.sql:8-10`):

```sql
DELETE FROM `build_info` WHERE `build`=70959;
INSERT INTO `build_info` (`build`,`majorVersion`,`minorVersion`,`bugfixVersion`,`hotfixVersion`) VALUES
(70959,1,60,1,NULL);
```

`hotfixVersion` is NULL for every Forever build. `<nn>` only orders files inside the date: the updater applies a
database's custom files in filename order (`src/server/database/Updater/UpdateFetcher.cpp:83-84`), and the auth database
includes everything under `sql/custom/auth` (`updates_include`, `sql/base/auth_database.sql:4478`).

Both servers read `build_info` once at startup (`RealmList::Initialize`, `src/server/shared/Realm/RealmList.cpp:68-77`,
which calls `ClientBuild::LoadBuildInfo`, `src/server/shared/Realm/ClientBuildInfo.cpp:125-130`). Restart bnetserver and
worldserver after the update, or the new build is still unknown. The file says this in its own header
(`2026_11_17_70_auth_classic_70959.sql:7`).

The header says what the build is, when it was first seen and whether the realm moves; 70959 has "Battle.net update of
17 November 2026, first seen 18:25Z, US first" (`sql/custom/auth/2026_11_17_70_auth_classic_70959.sql:1`).

## 2. The auth key

`build_auth_key` (`sql/base/auth_database.sql:606-614`) holds a 16 byte key per build, platform, architecture and type.
Worldserver looks up the client's variant and, when there is no row, answers `ERROR_BAD_VERSION` and closes unless
`Network.SkipBuildAuthKeyCheck = 1` (`src/server/game/Server/WorldSocket.cpp:754-771`; the config is documented at
`src/server/worldserver/worldserver.conf.dist:3480-3487`).

No auth key is known for any Forever build. Every Forever build file ties the missing key to that setting (e.g.
`2026_11_17_70_auth_classic_70959.sql:6`; `doc/ForeverSetup.md:36`), so the normal case is: touch nothing here.

If a key is ever obtained, add a row per platform/architecture/type and the check can be turned off; where such a key
would come from is in "Not confirmed".

## 3. The client build list

A realm lists for, and lets in, clients of its own `realmlist.gamebuild`. `Realm.AlsoAcceptBuilds` adds builds that use
the same game data and protocol (`src/server/shared/Realm/RealmList.cpp:255-279`). Set the same comma-separated list in
both configs:

- `bnetserver.conf` — `src/server/bnetserver/bnetserver.conf.dist:89-97`: answers the login realm list and the last
  played character.
- `worldserver.conf` — `src/server/worldserver/worldserver.conf.dist:73-80`: answers the in-game realm list and the
  realm join. The two lists must match. The value also decides what is offered and who may join:
- A realm whose build is not accepted is still sent to the client, flagged version mismatch
  (`src/server/shared/Realm/RealmList.cpp:310-312`).
- A character's last realm entry is only answered when the build is accepted
  (`src/server/shared/Realm/RealmList.cpp:398-406`).
- The realm join fails with `ERROR_USER_SERVER_NOT_PERMITTED_ON_REALM` when the build is not accepted
  (`src/server/shared/Realm/RealmList.cpp:446-453`).
- A build listed here but missing from `build_info` logs a `realmlist` error the first time the list is read:
  `Realm.AlsoAcceptBuilds lists <build> but auth.build_info has no row for it`
  (`src/server/shared/Realm/RealmList.cpp:269-274`).

The list is parsed once and cached in a function-local static (`src/server/shared/Realm/RealmList.cpp:262`), so restart
both servers after editing. `realmlist.gamebuild` is re-read every `RealmsStateUpdateDelay` seconds
(`src/server/shared/Realm/RealmList.cpp:103,206-212`), so moving a realm needs no restart. A realm serves one build;
clients of every other build need to be in `AlsoAcceptBuilds`.

**70959 stayed on the old protocol build.** Realm 70 keeps `gamebuild` 70707 and 70959 clients join through the list
(`sql/custom/auth/2026_11_17_70_auth_classic_70959.sql:2-5`). A build that should become the realm's own build has an
`UPDATE realmlist` in the same file instead; 70450 did that for realms 70-73
(`sql/custom/auth/2026_10_17_00_auth_classic_beta_70450.sql:8-10`).

The Windows repack keeps its own copy of the list in `repack/client-builds.txt`, newest build first, and its start
script writes `Realm.AlsoAcceptBuilds` from it (`README.md:8`, `sql/reserve/forever-launch/README.md:10`). That folder
is not in this repository; a source install edits the two configs above by hand.

## 4. Hotfix pushes

Blizzard changes items, spells and quests by hotfix between builds. The pushes are in the live hotfix cache, mirrored
publicly and used as the input here (`tools/full_forever/live_hotfix_sql.py:4-6`):

```
https://storage.googleapis.com/raidbots-static/wow/forever/enUS/DBCache.bin
```

Its header gives the build it belongs to (`tools/full_forever/live_hotfix_sql.py:41`). Decode only with the layouts of
that build (`src/server/game/DataStores/DB2Metadata.h`), so run the tool from a branch that knows the build.

Make the file, one per wave:

```
python3 -I tools/full_forever/live_hotfix_sql.py --repo . --dbcache DBCache.bin \
    --dbc <server/data/dbc/enUS> --min-push <first push> --whole-tables <tables> \
    --first-id <N> --last-id <N+999> --out sql/custom/hotfixes/<date>_<nn>_hotfixes_<name>_<build>.sql
```

`--records` takes an explicit `Table id` list, `--spells` / `--items` take ids, `--skip` leaves our own rows alone
(`tools/full_forever/live_hotfix_sql.py:118-134`). The output is same-ID rows in the server's hotfix tables
(`spell_effect`, `item_sparse`, `area_table`, ...), which the server loads over its DB2 data and sends to clients, plus
`Spell.db2` texts in `hotfix_blob` (enUS) and one `hotfix_data` row per record with the push status: 1 valid, 2 removed,
3 invalid, 4 not public (`tools/full_forever/live_hotfix_sql.py:8-14,37`). The 70959 files follow these rules:

- Only tables the server loads. Client-only records are left out (`CreatureXDisplayInfo`, `LightParams`,
  `SoundKitAdvanced` in `sql/custom/hotfixes/2026_11_17_75_hotfixes_forever_live_pushes_70959.sql:3-4`).
- Every row carries `VerifiedBuild` = the build of the cache, e.g. `70959` throughout that file.
- Delete then insert, so the file is safe to run again. Before the new `hotfix_data` rows, delete our older rows for
  the same table and record, so the newest push wins
  (`sql/custom/hotfixes/2026_11_17_75_hotfixes_forever_live_pushes_70959.sql:331-333`).
- One block of `hotfix_data` ids per file, next free block via `SELECT MAX(Id) FROM hotfix_data;`. 70959 uses
  2100000-2100999 in the `_75` file (`:5`) and 2101000-2101999 in the `_b` file,
  `sql/custom/hotfixes/2026_11_17_76_hotfixes_forever_live_pushes_70959_b.sql:6`.
- A new wave is a new file. Editing a file that was already applied makes the updater re-apply it and every later
  custom file (`src/server/database/Updater/UpdateFetcher.cpp:226-231`).

The hotfixes database is updated by worldserver's updater like the others (`Updates.EnableDatabases = 15`, flag 8; see
`src/server/worldserver/worldserver.conf.dist:1755-1768`). The 70959 files have no `ALTER TABLE`; section 5 has that.

**70959 was two waves.** `c0341987` added `sql/custom/hotfixes/2026_11_17_75_hotfixes_forever_live_pushes_70959.sql`
for pushes 114103-114163: 76 items, 13 spells, 4 quests and records live removes or hides (`:1-5`). Overnight Blizzard
rewrote the same file, and `25fc7ca3` (release 0.1.38) added the `_b` file for pushes 114164-114196 and the records
that moved into the first range, including curves, lights, content tuning and expected stat modifiers
(`sql/custom/hotfixes/2026_11_17_76_hotfixes_forever_live_pushes_70959_b.sql:1-6`). Together they are the push state
of 70959; neither edits the other.

## 5. DB2 layouts

The server checks every `.db2` it loads against its own metadata: the header's layout hash must equal the table's
`LayoutHash`, and the field count must match (`src/common/DataStores/DB2FileLoader.cpp:1763-1774`). A mismatch is a
load error, `DB2Manager::LoadStores` returns 0 and worldserver stops before it opens a port
(`src/server/game/DataStores/DB2Stores.cpp:1070-1078`, called from `src/server/game/World/World.cpp:1411-1417`).

To check:

1. Keep the old extracted folder, then extract the new client into a copy:
   `mapextractor -i <client> -o <out> -e 15 -f 1 -l enUS`
   (`tools/extract_client_data.sh:124-128`; the full extractor sequence is `doc/ForeverSetup.md:59-66`). The files land
   in `dbc/<locale>/`.
2. Compare the two folders with `tools/client_diff/client_diff.py --old <old> --new <new> ...`
   (`tools/client_diff/README.md:8-9,20-26`). It reads tables with `DB2Metadata.h` and `DB2LoadInfo.h`, the way
   worldserver does; a layout that does not match the source shows up in the report
   (`tools/client_diff/README.md:15-16`).
3. Or start worldserver on the new folder. Any changed layout is named in
   `Incorrect layout hash in <file>, expected 0x..., got 0x...` (`src/common/DataStores/DB2FileLoader.cpp:1763-1765`).

For a fast list of changed layouts without decoding anything, compare the layout hash at byte 156 of each `.db2` header
(`LayoutHash`, after `TableHash`; `src/common/DataStores/DB2FileLoader.h:31-54`):

```
python3 - <<'EOF'
import os, struct
h = lambda p: struct.unpack_from('<I', open(p, 'rb').read(160), 156)[0]
for n in sorted(os.listdir('dbc-70707/enUS')):
    a, b = 'dbc-70707/enUS/' + n, 'dbc-70959/enUS/' + n
    if not n.endswith('.db2'): continue
    if not os.path.exists(b): print('missing', n)
    elif h(a) != h(b): print('changed', n, hex(h(a)), hex(h(b)))
EOF
```

If a layout did change, it is a code change and needs its own commit:

- `src/server/game/DataStores/DB2Metadata.h`: the table's `XxxMeta` — `Fields`, `FieldCount`, `LayoutHash`
  (`src/common/DataStores/DB2Meta.h:40-54`).
- `src/server/game/DataStores/DB2LoadInfo.h`: the field names, in record order.
- The matching hotfix table needs the same column, the way 70707's new `SpellDuration.DurationPerLevel` column did
  (`sql/custom/hotfixes/2026_10_31_00_hotfixes_spell_duration_per_level.sql:1-3`).
- If old `.db2` files must keep loading, add a converter like `DB2LegacyLayout`, which rewrites the old
  `SpellDuration.db2` into the new layout and keeps the old file as `.legacy-layout`
  (`src/server/game/DataStores/DB2LegacyLayout.h:26-28`, run from `src/server/game/DataStores/DB2Stores.cpp:683-684`;
  tests in `tests/game/DB2LegacyLayout.cpp`).

No DB2 layout change was recorded for 70959. The only written check is in the two hotfix file headers: every pushed
record decodes byte-exact with the current layouts (first file `:4-5`, `_b` file `:5-6`). That covers the hotfix cache,
not the client's own `.db2` files; step 2 or 3 above is what proves those.

## 6. Message numbers (only if they change)

Client builds after 70790, 70959 included, use the 70790 message numbers: the mapping applies from
`Classic.Build70790.FirstBuild`, default 70790 (`src/server/game/Server/Protocol/ClassicOpcodes.cpp:213-216`,
`src/server/worldserver/worldserver.conf.dist:5143-5148`). Nothing to do while the client's numbers do not change.

There is no hardcoded list of accepted builds in `src/`. The rest is per-build behavior, a config value like the one
above or a `>=` gate that a newer build passes anyway: opcode group shift from the realm build 70291
(`src/server/game/Server/Protocol/ClassicOpcodes.cpp:104-110`), combat nameplates from 70532
(`src/server/game/Server/WorldSession.cpp:1305`).

If a build does renumber messages, that is a code change: another `BuildMessageChanges` block and config keys, patterned
on the 70755 and 70790 ones (`src/server/game/Server/Protocol/ClassicOpcodes.cpp:130-215`). 70959 needed none.

## 7. Test

1. Let worldserver apply the updates, then restart bnetserver and worldserver (both read `build_info` and
   `AlsoAcceptBuilds` at startup only).
2. Start worldserver on the new `dbc` folder (or keep the old one if layouts did not change) and check that it loads the
   DB2 stores without `Incorrect layout hash` or `Incorrect number of fields`.
3. Log in with the new client build. Log in at least to the character screen, then into the world and back out.
4. Check the auth database for the build the client sent: `SELECT username, client_build FROM account;`
   (`client_build` column, `sql/base/auth_database.sql:47`). It must show the new build.
5. Old builds: they work only if they are still in `Realm.AlsoAcceptBuilds`. If they should be dropped, remove them
   from both configs and confirm an old client is refused at the realm join; otherwise log in once with the oldest
   accepted build.
6. Check the server logs for `Missing client build info for build ...`, `Missing client build auth key for build ...`,
   `Realm.AlsoAcceptBuilds lists ... but auth.build_info has no row for it`, and worldserver's `DBErrors.log` for the
   hotfix SQL.
7. Spot-check the hotfix content in game: one pushed item (`Whiteout Staff`, item 19101) can be found by name, one
   pushed spell works, one record live hides no longer appears.

## Not confirmed

- **Where a build auth key comes from.** Nothing in this repository derives `build_auth_key` rows, and no Forever build
  has one. The skip setting is the working state. Do not guess a key.
- **Whether the 70959 client's own `.db2` files were compared.** The commits record a hotfix-cache decode, not a folder
  comparison. The layout check in section 5 is the way to settle it for the next build.
- **The 70959 push time.** "First seen 18:25Z, US first" comes from the auth file header
  (`sql/custom/auth/2026_11_17_70_auth_classic_70959.sql:1`); the exact Battle.net publish time is not in the repo.
- **The repack's build list.** `repack/client-builds.txt` and the scripts that write `Realm.AlsoAcceptBuilds` from it are
  in the repack repository, not here; this page can only say what the core reads.

## Checklist

- [ ] Build row added to `sql/custom/auth/<date>_<nn>_auth_classic_<build>.sql`, delete before insert, header says what
      the build is and when it was first seen.
- [ ] `realmlist.gamebuild` left as is, or moved in the same file (all realms you mean to move, no others).
- [ ] No auth key added, `Network.SkipBuildAuthKeyCheck = 1` in `worldserver.conf`.
- [ ] Build added to `Realm.AlsoAcceptBuilds` in `bnetserver.conf` **and** `worldserver.conf`, lists identical; the
      repack's list updated too if the change ships with the repack (separate repository).
- [ ] Hotfix wave file(s) under `sql/custom/hotfixes/`, new `hotfix_data` id block, `VerifiedBuild` = the build, only
      tables the server loads, client-only records left out, safe to run again.
- [ ] DB2 layouts checked: client diff or worldserver start; if one changed, `DB2Metadata.h`, `DB2LoadInfo.h`, the hotfix
      table column, and a converter if old files must keep loading.
- [ ] Both servers restarted; new client logs in and enters the world; `account.client_build` shows the new build.
- [ ] Old builds kept or dropped on purpose, and tested that way.
- [ ] No error line from test step 6; `DBErrors.log` clean.
