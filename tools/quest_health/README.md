# Quest health sweep and post-build smoke test

Both are read-only: they never start, stop or change the server or a database.

## quest_health.py

Lists the quests a player can take but cannot finish: no ender (or not spawned), a kill objective nobody can be killed for,
an item objective nothing gives, a "use object" objective whose object is not in the world, an area trigger the client does
not know, a "go there" quest nothing completes, and (low priority) quests without a map area. Only quests of this game are
checked (they have a Classic level, `quest_template_classic_level`) and only when their giver is spawned or their start item
can be had. A line ending in "(id ... is in C++ scripts)" is probably handled by code: check those in game before changing data.

    python -I tools/quest_health/quest_health.py --repo . --world <worldDB> --db2 "<server>\data\dbc\enUS" ^
        --mysql "<package>\mysql\bin\mysql.exe" --user playerbot --password playerbot --out quest-health.md --tsv quest-health.tsv

Take the database name from WorldDatabaseInfo in worldserver.conf. `--db2` adds spell checks (items made by spells, kill
credit and summons from spells) and the client's area triggers; without it those are skipped and more lines show up.

## smoke_test.py (about 5 minutes, after every build on dev)

1. The console: every message the running worldserver printed 20+ times (numbers ignored), plus missing config keys,
   database errors, unknown tables or columns, failed SQL updates, script name errors, asserts.
2. Quests: runs quest_health.py and lists only what is NEW since the last build's run (and what got fixed).
3. The server answers `.server info` over SOAP, when SOAP is on.

    python -I tools/quest_health/smoke_test.py --repo . --log "<server>\logs\Server.log" --log "<server>\logs\DBErrors.log" ^
        --world <worldDB> --db2 "<server>\data\dbc\enUS" --mysql "<package>\mysql\bin\mysql.exe" ^
        --baseline smoke-<last build>.md.quest-health.tsv --out smoke-<this build>.md

Start it a few minutes after the worldserver is up (log in once, walk around, summon a pet) so the console has something to
show. Exit code 0 = pass, 1 = the report lists what needs a look. Keep `smoke-<build>.md.quest-health.tsv` as the next baseline.
