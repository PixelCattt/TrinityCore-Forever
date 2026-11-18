#!/usr/bin/env python3
"""Five-minute check after a build lands on the dev realm. Read-only; it never starts, stops or changes the server.

1. Console flood: reads the worldserver log written since the server started (or the last N minutes) and lists every
   message that repeats (numbers ignored, so "pet 12 path" and "pet 13 path" count as one). A message printed again and
   again is a bug even when nothing is visibly broken (0.1.37.1: "Missing name Pathfinding.PetLiquidCost" on every pet
   path). Also counts errors: missing config keys, database errors, unknown tables or columns, failed SQL updates, script
   errors.
2. Quest regressions: runs the quest health sweep (quest_health.py) and compares it with the last build's run, so a
   quest that this build broke shows up on its own instead of in a list of hundreds.
3. Server answers: if SOAP is on (SOAP.Enabled = 1 in worldserver.conf), sends ".server info" and checks the reply.

    python3 -I tools/quest_health/smoke_test.py --repo . --log "<server>\\logs\\Server.log" \\
        --world <worldDB> --db2 <server>\\data\\dbc\\enUS [--mysql <path to mysql.exe>] [--user ..] [--password ..] \\
        --baseline <last build's quest-health.tsv> --out smoke-<build>.md [--soap 127.0.0.1:7878 --soap-user X --soap-password Y]

Exit code 0 when everything passes, 1 when something needs a look (the report says what).
"""
import argparse
import base64
import os
import re
import subprocess
import sys
import urllib.request
from collections import Counter

FLOOD_COUNT = 20          # the same message this many times is a flood
ERROR_PATTERNS = [
    ('missing config key', re.compile(r'Missing (name|property)', re.I)),
    ('database error', re.compile(r"(\[ERROR\].*(sql|database|mysql))|(Error \d{4} \(\w+\))|(DB error)", re.I)),
    ('unknown table or column', re.compile(r"(Table '.*' doesn't exist)|(Unknown column)", re.I)),
    ('SQL update failed', re.compile(r'(Applying of file .* failed)|(update .* failed)', re.I)),
    ('prepared statement', re.compile(r'prepared statement', re.I)),
    ('script error', re.compile(r'(ScriptName .* not found)|(Script named .* does not have a script)|(is not assigned in the database)', re.I)),
    ('crash or assert', re.compile(r'(ASSERTION FAILED)|(Exception)|(crash)', re.I)),
]
STAMP = re.compile(r'^\s*\d{4}-\d{2}-\d{2}[ _T]\d{2}:\d{2}:\d{2}\S*\s*')


def normalise(line):
    line = STAMP.sub('', line.rstrip('\r\n'))
    line = re.sub(r'0x[0-9a-fA-F]+', '#', line)
    line = re.sub(r'-?\d+(\.\d+)?', '#', line)
    return line.strip()


def read_log(path, from_start):
    """the part of the log written by the running server: from its last start banner on (or the whole file)"""
    with open(path, encoding='utf-8', errors='replace') as f:
        lines = f.readlines()
    if not from_start:
        for i in range(len(lines) - 1, -1, -1):
            if 'Using configuration file' in lines[i] or 'worldserver-daemon' in lines[i] or 'TrinityCore rev.' in lines[i]:
                return lines[i:]
    return lines


def check_log(paths, from_start):
    out, bad = [], False
    for path in paths:
        if not os.path.exists(path):
            out.append('- log %s: NOT FOUND' % path)
            bad = True
            continue
        lines = read_log(path, from_start)
        counts = Counter(normalise(l) for l in lines if l.strip())
        floods = [(n, msg) for msg, n in counts.items() if n >= FLOOD_COUNT and msg]
        floods.sort(reverse=True)
        out.append('### %s (%d lines since the server started)' % (path, len(lines)))
        if floods:
            bad = True
            out.append('FLOOD: %d message(s) repeat %d+ times:' % (len(floods), FLOOD_COUNT))
            out += ['- %d x `%s`' % (n, msg[:200]) for n, msg in floods[:25]]
        else:
            out.append('no repeated message (none %d+ times)' % FLOOD_COUNT)
        for name, rx in ERROR_PATTERNS:
            hits = [l.strip() for l in lines if rx.search(l)]
            if hits:
                bad = True
                kinds = Counter(normalise(h) for h in hits)
                out.append('%s: %d line(s), %d different:' % (name, len(hits), len(kinds)))
                out += ['- %d x `%s`' % (n, msg[:200]) for msg, n in kinds.most_common(10)]
    return bad, out


def check_quests(a):
    here = os.path.dirname(os.path.abspath(__file__))
    tsv = a.out + '.quest-health.tsv'
    cmd = [sys.executable, '-I', os.path.join(here, 'quest_health.py'), '--repo', a.repo, '--world', a.world,
           '--mysql', a.mysql, '--host', a.host, '--port', str(a.port), '--user', a.user,
           '--out', a.out + '.quest-health.md', '--tsv', tsv, '--no-markers']
    if a.password is not None:
        cmd += ['--password', a.password]
    if a.socket:
        cmd += ['--socket', a.socket]
    if a.db2:
        cmd += ['--db2', a.db2]
    r = subprocess.run(cmd, capture_output=True, text=True)
    if r.returncode:
        return True, ['quest sweep FAILED: ' + (r.stderr or r.stdout).strip()[:500]]
    out = [r.stdout.strip()]

    def keys(path):
        with open(path, encoding='utf-8') as f:
            next(f, None)
            rows = [l.rstrip('\n') for l in f if l.strip()]
            # map-marker lines are left out of the smoke run (--no-markers), so they are left out of the comparison too
            return {tuple(r.split('\t')[i] for i in (0, 3, 4)): r for r in rows if r.split('\t')[3] != 'marker'}
    now = keys(tsv)
    if not a.baseline or not os.path.exists(a.baseline):
        out.append('no baseline given: this run (%s) is the baseline for the next build' % tsv)
        return False, out
    before = keys(a.baseline)
    new = [now[k] for k in now if k not in before]
    gone = [before[k] for k in before if k not in now]
    out.append('%d new finding(s) since the baseline, %d fixed' % (len(new), len(gone)))
    out += ['- NEW ' + l.replace('\t', ' | ') for l in new[:50]]
    out += ['- fixed ' + l.replace('\t', ' | ') for l in gone[:50]]
    return bool(new), out


def check_soap(a):
    if not a.soap:
        return False, ['SOAP not given: skipped']
    body = ('<?xml version="1.0" encoding="utf-8"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" '
            'xmlns:ns1="urn:TC"><SOAP-ENV:Body><ns1:executeCommand><command>server info</command></ns1:executeCommand>'
            '</SOAP-ENV:Body></SOAP-ENV:Envelope>').encode()
    req = urllib.request.Request('http://%s/' % a.soap, data=body, headers={'Content-Type': 'text/xml'})
    req.add_header('Authorization', 'Basic ' + base64.b64encode(('%s:%s' % (a.soap_user, a.soap_password)).encode()).decode())
    try:
        with urllib.request.urlopen(req, timeout=10) as r:
            text = r.read().decode(errors='replace')
    except Exception as e:      # noqa: BLE001 - any failure to answer is the finding
        return True, ['.server info over SOAP FAILED: %s' % e]
    ok = 'uptime' in text.lower() or 'connected players' in text.lower()
    return not ok, ['.server info: %s' % ('answered' if ok else 'unexpected reply: ' + text[:300])]


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument('--repo', default='.')
    ap.add_argument('--log', action='append', default=[], help='worldserver log file(s): Server.log, DBErrors.log (repeat)')
    ap.add_argument('--whole-log', action='store_true', help='read the whole log, not only since the last server start')
    ap.add_argument('--world', required=True)
    ap.add_argument('--db2', required=True, help='client DB2 folder; needed so that this run and the baseline check the same things')
    ap.add_argument('--mysql', default='mysql')
    ap.add_argument('--host', default='127.0.0.1')
    ap.add_argument('--port', type=int, default=3306)
    ap.add_argument('--socket')
    ap.add_argument('--user', default='playerbot')
    ap.add_argument('--password', default=None)
    ap.add_argument('--baseline', help="the last build's quest-health tsv (this run writes <out>.quest-health.tsv for the next)")
    ap.add_argument('--soap', help='host:port of SOAP, if SOAP.Enabled = 1')
    ap.add_argument('--soap-user')
    ap.add_argument('--soap-password')
    ap.add_argument('--out', default='smoke.md')
    a = ap.parse_args()

    report, failed = ['# Smoke test', ''], []
    for name, (bad, lines) in (('Console', check_log(a.log, a.whole_log)), ('Quests', check_quests(a)), ('Server', check_soap(a))):
        report += ['## %s: %s' % (name, 'NEEDS A LOOK' if bad else 'ok'), ''] + lines + ['']
        if bad:
            failed.append(name)
    report.insert(1, 'Result: %s' % ('PASS' if not failed else 'needs a look: ' + ', '.join(failed)))
    tmp = a.out + '.tmp'
    with open(tmp, 'w', encoding='utf-8') as f:
        f.write('\n'.join(report) + '\n')
    os.replace(tmp, a.out)
    print(report[1], '->', a.out)
    sys.exit(1 if failed else 0)


if __name__ == '__main__':
    main()
