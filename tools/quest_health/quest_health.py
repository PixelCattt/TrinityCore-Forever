#!/usr/bin/env python3
"""Quest health sweep: lists quests a player can take but cannot finish, before players find them.

Reads the world database (through the mysql command line client, so it runs where the server runs, with no Python
database module) and, when given, the client's DB2 folder. For every quest a player can start (its giver is spawned,
or its start item drops somewhere) it checks:

  giver/ender   the quest ender is spawned, or summoned by a SmartAI script
  kill          a kill objective's creature is spawned, summoned, or is the kill credit of a spawned creature or a spell
  item          an item objective drops (any loot table, through references), is sold, given or rewarded by a quest, made by a
                spell (DB2), given by a SmartAI script, or comes out of a container
  object        a "use object" objective's gameobject is spawned or summoned
  trigger       an area trigger objective exists in the client data (DB2) or as a server-side area trigger
  marker        the quest has objectives but no map area (quest_poi): low priority, the quest still works

A finding means "no data source found". A C++ script can still give the credit or the item, so the report names the
quest's script (quest, giver or ender) when there is one; those lines are less sure. Read-only.

    python3 -I tools/quest_health/quest_health.py --repo . --world <worldDB> [--db2 <server>/data/dbc/enUS] \
        [--mysql <path to mysql>] [--user playerbot] [--password playerbot] [--host 127.0.0.1] [--port 3306] \
        --out quest-health.md [--tsv quest-health.tsv]
"""
import argparse
import os
import subprocess
import sys
from collections import defaultdict

SEVERITY = {'ender': 1, 'kill': 2, 'item': 2, 'object': 2, 'trigger': 2, 'no-objective': 3, 'marker': 4}


class Db:
    def __init__(self, a):
        self.cmd = [a.mysql, '-B', '-N', '--default-character-set=utf8mb4']
        self.cmd += ['--socket', a.socket] if a.socket else ['-h', a.host, '-P', str(a.port), '-u', a.user]
        self.env = dict(os.environ)
        if a.password is not None:
            self.env['MYSQL_PWD'] = a.password   # not on the command line
        self.db = a.world

    def rows(self, sql):
        r = subprocess.run(self.cmd + [self.db], input=sql.encode(), capture_output=True, env=self.env)
        if r.returncode:
            sys.exit('mysql failed: %s\n%s' % (r.stderr.decode(errors='replace').strip(), sql[:200]))
        return [line.split('\t') for line in r.stdout.decode('utf-8', errors='replace').splitlines() if line]

    def ints(self, sql):
        return {int(r[0]) for r in self.rows(sql) if r[0] not in ('', 'NULL')}

    def has_table(self, name):
        return bool(self.rows("SHOW TABLES LIKE '%s'" % name))


def load_db2(repo, folder):
    """spell effects and area trigger ids from the client data; empty when no folder is given"""
    out = dict(create_item=set(), kill_credit=set(), summon_creature=set(), summon_object=set(), quest_complete=set(),
               area_triggers=None, item_starts=None)
    if not folder:
        return out
    sys.path.insert(0, os.path.join(repo, 'tools', 'client_diff'))
    from wdc5 import Schemas, read_db2   # our own reader (field names from DB2Metadata.h / DB2LoadInfo.h)
    sch = Schemas(repo)
    path = os.path.join(folder, 'SpellEffect.db2')
    if os.path.exists(path):
        rows, _ = read_db2(path, sch)
        for r in rows.values():
            e = r.get('Effect')
            misc = r.get('EffectMiscValue1') or 0
            if e in (24, 157) and r.get('EffectItemType'):       # CREATE_ITEM, CREATE_LOOT
                out['create_item'].add(r['EffectItemType'])
            elif e == 6 and r.get('EffectAura') == 86 and r.get('EffectItemType'):   # aura CHANNEL_DEATH_ITEM (shards, spirits)
                out['create_item'].add(r['EffectItemType'])
            elif e in (90, 134) and misc:                         # KILL_CREDIT, KILL_CREDIT2
                out['kill_credit'].add(misc)
            elif e in (28, 41, 56, 290) and misc:                 # SUMMON variants
                out['summon_creature'].add(misc)
            elif e in (50, 76, 86, 104, 105, 106, 107) and misc:  # TRANS_DOOR, SUMMON_OBJECT_WILD, ACTIVATE_OBJECT, SUMMON_OBJECT_SLOT
                out['summon_object'].add(misc)
            elif e == 16 and misc:                                # QUEST_COMPLETE
                out['quest_complete'].add(misc)
    path = os.path.join(folder, 'ItemSparse.db2')
    if os.path.exists(path):
        rows, _ = read_db2(path, sch)
        out['item_starts'] = {}
        for r in rows.values():
            if r.get('StartQuestID'):
                out['item_starts'][r['ID']] = r['StartQuestID']
    path = os.path.join(folder, 'AreaTrigger.db2')
    if os.path.exists(path):
        rows, _ = read_db2(path, sch)
        out['area_triggers'] = set(rows)
    return out


def script_numbers(repo):
    """every number of 3 to 7 digits in the C++ scripts: an id named there may be credited or summoned by code"""
    import re
    nums = set()
    for root in ('src/server/scripts', 'src/server/game/Battlegrounds', 'src/server/game/OutdoorPvP'):
        for dirpath, _, files in os.walk(os.path.join(repo, root)):
            for f in files:
                if f.endswith(('.cpp', '.h')):
                    with open(os.path.join(dirpath, f), encoding='latin-1') as fh:
                        nums.update(int(n) for n in re.findall(r'(?<![\w.])(\d{3,7})(?![\w.])', fh.read()))
    return nums


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument('--repo', default='.')
    ap.add_argument('--world', required=True, help='world database name, from WorldDatabaseInfo in worldserver.conf')
    ap.add_argument('--db2', help='client DB2 folder (server data\\dbc\\enUS); without it spell and trigger checks are skipped')
    ap.add_argument('--mysql', default='mysql')
    ap.add_argument('--host', default='127.0.0.1')
    ap.add_argument('--port', type=int, default=3306)
    ap.add_argument('--socket', help='connect through this socket instead (Linux)')
    ap.add_argument('--user', default='playerbot')
    ap.add_argument('--password', default=None)
    ap.add_argument('--out', default='quest-health.md')
    ap.add_argument('--tsv')
    ap.add_argument('--all', action='store_true', help='also check quests without a Classic level (retail data)')
    ap.add_argument('--no-markers', action='store_true', help='leave out the "no map area" lines')
    a = ap.parse_args()
    db = Db(a)
    d2 = load_db2(a.repo, a.db2)
    in_code = script_numbers(a.repo)

    spawned_c = db.ints('SELECT DISTINCT id FROM creature')
    spawned_g = db.ints('SELECT DISTINCT id FROM gameobject')
    sai = db.rows('SELECT action_type, action_param1 FROM smart_scripts WHERE action_type IN (12,50,56,33,15,26) AND action_param1 > 0')
    sai_c = {int(p) for t, p in sai if t == '12'}
    sai_g = {int(p) for t, p in sai if t == '50'}
    sai_item = {int(p) for t, p in sai if t == '56'}
    sai_credit = {int(p) for t, p in sai if t == '33'}
    sai_quest = {int(p) for t, p in sai if t in ('15', '26')}
    sai_g_guids = set()
    if db.has_table('creature_summon_groups'):
        sai_c |= db.ints('SELECT DISTINCT entry FROM creature_summon_groups')
    # spell events (SEND_EVENT): event_scripts command 10 = summon creature, 9 = respawn object (by guid), 8 = kill credit
    if db.has_table('event_scripts'):
        for cmd, val in db.rows('SELECT command, datalong FROM event_scripts WHERE command IN (8, 9, 10) AND datalong > 0'):
            {'10': sai_c, '8': sai_credit, '9': sai_g_guids}[cmd].add(int(val))
    if sai_g_guids:
        sai_g |= db.ints('SELECT DISTINCT id FROM gameobject WHERE guid IN (%s)' % ','.join(map(str, sorted(sai_g_guids))))
    credit_of_spawned = db.ints('SELECT DISTINCT KillCredit1 FROM creature_template WHERE KillCredit1 > 0 AND entry IN (SELECT id FROM creature)') \
        | db.ints('SELECT DISTINCT KillCredit2 FROM creature_template WHERE KillCredit2 > 0 AND entry IN (SELECT id FROM creature)')

    loot_items = set()
    for t in ('creature', 'gameobject', 'item', 'pickpocketing', 'skinning', 'fishing', 'disenchant', 'prospecting', 'milling',
              'reference', 'spell', 'mail'):
        loot_items |= db.ints('SELECT DISTINCT Item FROM %s_loot_template WHERE ItemType = 0' % t)
    vendor = db.ints('SELECT DISTINCT item FROM npc_vendor WHERE item > 0')
    q_items = db.rows('SELECT ID, StartItem, ItemDrop1, ItemDrop2, ItemDrop3, ItemDrop4, RewardItem1, RewardItem2, RewardItem3, '
                      'RewardItem4, RewardChoiceItemID1, RewardChoiceItemID2, RewardChoiceItemID3, RewardChoiceItemID4, '
                      'RewardChoiceItemID5, RewardChoiceItemID6 FROM quest_template')
    quest_given = {int(v) for r in q_items for v in r[1:] if v not in ('0', '')}
    given_by = defaultdict(set)                         # item -> quests that hand it out or reward it
    for r in q_items:
        for v in r[1:]:
            if v not in ('0', ''):
                given_by[int(v)].add(int(r[0]))
    item_sources = loot_items | vendor | quest_given | sai_item | d2['create_item']

    starters = defaultdict(set)
    for q, i in db.rows('SELECT quest, id FROM creature_queststarter'):
        starters[int(q)].add(('c', int(i)))
    for q, i in db.rows('SELECT quest, id FROM gameobject_queststarter'):
        starters[int(q)].add(('g', int(i)))
    enders = defaultdict(set)
    for q, i in db.rows('SELECT quest, id FROM creature_questender'):
        enders[int(q)].add(('c', int(i)))
    for q, i in db.rows('SELECT quest, id FROM gameobject_questender'):
        enders[int(q)].add(('g', int(i)))
    disabled = db.ints('SELECT entry FROM disables WHERE sourceType = 1')
    # the quests of this game (Classic levels known); the rest of the retail data has givers in the world but is not offered
    classic = db.ints('SELECT ID FROM quest_template_classic_level') if db.has_table('quest_template_classic_level') and not a.all else None
    addon_script = {int(r[0]): r[1] for r in db.rows("SELECT ID, ScriptName FROM quest_template_addon WHERE ScriptName <> ''")}
    c_script = {int(r[0]): r[1] for r in db.rows("SELECT entry, ScriptName FROM creature_template WHERE ScriptName <> ''")}
    g_script = {int(r[0]): r[1] for r in db.rows("SELECT entry, ScriptName FROM gameobject_template WHERE ScriptName <> ''")}
    trig_quests = db.ints('SELECT DISTINCT quest FROM areatrigger_involvedrelation')
    custom_trig = db.ints('SELECT DISTINCT AreaTriggerId FROM areatrigger_create_properties') if db.has_table('areatrigger_create_properties') else set()
    poi = db.ints('SELECT DISTINCT QuestID FROM quest_poi')
    names = {}
    for r in db.rows('SELECT entry, name FROM creature_template'):
        names[('c', int(r[0]))] = r[1]
    for r in db.rows('SELECT entry, name FROM gameobject_template'):
        names[('g', int(r[0]))] = r[1]

    def is_spawned(k):
        return (k[1] in spawned_c or k[1] in sai_c or k[1] in d2['summon_creature']) if k[0] == 'c' else \
               (k[1] in spawned_g or k[1] in sai_g or k[1] in d2['summon_object'])

    # quests started by an item (the item's StartQuestID; quest_template.StartItem is the item handed out on accept)
    item_start = defaultdict(set)
    for i, qid in (d2['item_starts'] or {}).items():
        item_start[qid].add(i)
    quests = {}
    for r in db.rows('SELECT ID, LogTitle, QuestSortID, StartItem, Flags FROM quest_template'):
        quests[int(r[0])] = dict(title=r[1], sort=int(r[2]), start_item=int(r[3]), flags=int(r[4]))
    objectives = defaultdict(list)
    for r in db.rows('SELECT QuestID, Type, ObjectID, Description FROM quest_objectives ORDER BY QuestID, `Order`'):
        objectives[int(r[0])].append((int(r[1]), int(r[2]), r[3]))

    findings = []
    startable = 0
    for qid, q in sorted(quests.items()):
        if qid in disabled or (classic is not None and qid not in classic):
            continue
        givers = starters.get(qid, set())
        if not any(is_spawned(k) for k in givers) and not any(
                i in loot_items | vendor | sai_item | d2['create_item'] or given_by.get(i, set()) - {qid}
                for i in item_start.get(qid, ())):
            continue                                    # nobody and no item can start it: not part of this world (retail data)
        startable += 1
        script = addon_script.get(qid) or next((c_script.get(k[1]) if k[0] == 'c' else g_script.get(k[1])
                                                for k in givers | enders.get(qid, set())
                                                if (c_script if k[0] == 'c' else g_script).get(k[1])), '')

        def add(kind, what, obj=None):
            sev, note = SEVERITY[kind], script
            if obj is not None and obj in in_code:      # named in C++: likely handled there, check in game, lower in the list
                sev, note = sev + 1, (script + ' ' if script else '') + '(id %d is in C++ scripts)' % obj
            findings.append((sev, qid, q['title'], q['sort'], kind, what, note))

        ends = enders.get(qid, set())
        if not ends:
            add('ender', 'no quest ender at all')
        elif not any(is_spawned(k) for k in ends):
            add('ender', 'ender not spawned: ' + ', '.join('%s %d %s' % ('creature' if k[0] == 'c' else 'object', k[1],
                                                                          names.get(k, '?')) for k in sorted(ends)),
                next((k[1] for k in sorted(ends) if k[1] in in_code), None))
        objs = objectives.get(qid, [])
        if not objs and q['flags'] & 4 and qid not in trig_quests and qid not in sai_quest and qid not in d2['quest_complete']:
            add('no-objective', 'a "go there" quest (flag 4) with no area trigger, script or spell to complete it', qid)
        for typ, obj, desc in objs:
            label = desc or str(obj)
            if typ == 0:   # kill / talk credit
                if not (obj in spawned_c or obj in sai_c or obj in credit_of_spawned or obj in sai_credit
                        or obj in d2['kill_credit'] or obj in d2['summon_creature']):
                    add('kill', 'creature %d (%s): not spawned, summoned, or anyone\'s kill credit; "%s"' % (obj, names.get(('c', obj), '?'), label), obj)
            elif typ == 1:
                if obj not in item_sources:
                    add('item', 'item %d: no drop, vendor, quest, spell or script gives it; "%s"' % (obj, label), obj)
            elif typ == 2:
                if not (obj in spawned_g or obj in sai_g or obj in d2['summon_object']):
                    add('object', 'gameobject %d (%s) not spawned or summoned; "%s"' % (obj, names.get(('g', obj), '?'), label), obj)
            elif typ == 10:
                known = d2['area_triggers'] is None or obj in d2['area_triggers'] or obj in custom_trig
                if not known:
                    add('trigger', 'area trigger %d is not in the client data and not a server-side trigger; "%s"' % (obj, label), obj)
        if objs and qid not in poi and not a.no_markers:
            add('marker', 'no map area (quest_poi)')

    findings.sort(key=lambda f: (f[0], f[3], f[1]))
    counts = defaultdict(int)
    for f in findings:
        counts[f[4]] += 1
    tmp = a.out + '.tmp'
    with open(tmp, 'w', encoding='utf-8') as o:
        o.write('# Quest health sweep\n\nWorld database `%s`; client DB2 %s.\n\n' % (a.world, a.db2 or 'not given (spell and trigger checks skipped)'))
        o.write('%d quests a player can start were checked. Findings: %s.\n\n' % (
            startable, ', '.join('%s %d' % (k, counts[k]) for k in sorted(counts, key=lambda k: SEVERITY[k])) or 'none'))
        o.write('"script" means a C++ script on the quest, giver or ender may give the credit itself: check those in game.\n\n')
        o.write('| quest | title | zone/sort | problem | what | script |\n|---|---|---|---|---|---|\n')
        for sev, qid, title, sort, kind, what, script in findings:
            o.write('| %d | %s | %d | %s | %s | %s |\n' % (qid, title.replace('|', '/'), sort, kind, what.replace('|', '/'), script))
    os.replace(tmp, a.out)
    if a.tsv:
        tmp = a.tsv + '.tmp'
        with open(tmp, 'w', encoding='utf-8') as o:
            o.write('quest\ttitle\tsort\tproblem\twhat\tscript\n')
            for sev, qid, title, sort, kind, what, script in findings:
                o.write('%d\t%s\t%d\t%s\t%s\t%s\n' % (qid, title, sort, kind, what, script))
        os.replace(tmp, a.tsv)
    print('%d startable quests, %d findings (%s) -> %s' % (startable, len(findings), dict(counts), a.out))


if __name__ == '__main__':
    main()
