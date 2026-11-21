# Writes the creature_versus_group rows (ClassicVersusBonus.h) from creature_template: the groups no creature field holds (Trolls, Plants,
# Naga...), found from each creature's name, type and family by the rules in versus_groups.py.
#
# Input: a tab separated export of the world database, one creature per line: entry, name, type, family, spawned (1 when the creature has a
# spawn or is below 25000, the classic range; the rest are retail creatures the realm never shows and are left out):
#   SELECT ct.entry, ct.name, ct.type, ct.family, (ct.entry < 25000 OR EXISTS (SELECT 1 FROM creature c WHERE c.id = ct.entry))
#   FROM creature_template ct;
# Usage: python3 gen_versus_groups.py creatures.tsv > 2026_11_21_61_world_classic_versus_groups.sql
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from versus_groups import GROUPS, groups_of  # noqa: E402


def rows_from_tsv(path):
    with open(path, encoding='utf8') as f:
        for line in f:
            p = line.rstrip('\n').split('\t')
            if len(p) < 5 or not p[0].isdigit():
                continue
            yield int(p[0]), p[1], int(p[2] or 0), int(p[3] or 0), p[4] == '1'


def sql_rows(creatures):
    out = []
    for entry, name, typ, family, shown in sorted(creatures):
        if not shown:
            continue
        g = groups_of(name, typ, family)
        if g:
            names = '+'.join(n for b, n in GROUPS if g >> b & 1)
            out.append((entry, g, name.replace('\n', ' '), names))
    return out


def write_sql(rows, f):
    f.write('-- Classic 1.60 (WoW Forever): creatures in the groups item effects name ("Deals $s2 times as much damage to Plants"), which no creature\n')
    f.write('-- field holds. Written by tools/classic_versus_groups/gen_versus_groups.py; group bits in src/server/game/Spells/ClassicVersusBonus.h:\n')
    f.write('-- ' + ', '.join(f'{n} {1 << b}' for b, n in GROUPS) + '.\n')
    f.write('DELETE FROM `creature_versus_group`;\n')
    for i in range(0, len(rows), 500):
        chunk = rows[i:i + 500]
        f.write('INSERT INTO `creature_versus_group` (`entry`, `groups`) VALUES\n')
        for j, (entry, g, name, names) in enumerate(chunk):
            sep = ';' if j == len(chunk) - 1 else ','
            f.write(f'({entry}, {g}){sep} -- {name} ({names})\n')


if __name__ == '__main__':
    write_sql(sql_rows(rows_from_tsv(sys.argv[1])), sys.stdout)
