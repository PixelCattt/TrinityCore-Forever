# Creature groups for the "x times as much damage to <group>" item effects (ClassicVersusBonus.h): rules on creature_template name, type and
# family. Types: 1 beast 2 dragonkin 3 demon 4 elemental 5 giant 6 undead 7 humanoid 8 critter 9 mechanical 10 not specified 11 totem.
# Families: 6 crocolisk, 8 crab, 11 raptor, 21 turtle, 27 wind serpent, 35 serpent.
import re
GROUPS = [  # bit, name
    (0, 'Troll'), (1, 'Orc'), (2, 'Dwarf'), (3, 'Plant'), (4, 'Aquatic'), (5, 'EarthElemental'), (6, 'Golem'),
    (7, 'TitanForged'), (8, 'FireElemental'), (9, 'MountainGiant'), (10, 'Naga'), (11, 'Satyr'), (12, 'Dinosaur'), (13, 'Serpentine'),
]
def rx(*w): return re.compile(r'\b(' + '|'.join(w) + r')\b', re.I)
TROLL = rx("troll", "gurubashi", "zandalar", "amani", "witherbark", "vilebranch", "smolderthorn", "skullsplitter", "bloodscalp",
           "darkspear", "sandfury", "hakkari", "atal'ai", "revantusk", "frostmane", "shatterspear", "winterax", "mossflayer",
           "shadowpine", "farraki", "jintha", "zul'farrak")
TROLL_NOT = rx("trollbane", "troll hunter", "troll slayer", "trollslayer", "orb of deception", "world troll", "troll trainer", "ward", "bat rider")
TROLL_NAMES = {"bloodlord mandokir", "jin'do the hexxer", "high priest venoxis", "high priest thekal", "high priestess arlokk",
               "high priestess mar'li", "high priestess jeklik", "chief ukorz sandscalp", "ruuzlu", "witch doctor zum'rah",
               "shadowpriest sezz'ziz", "antu'sul", "hydromancer velratha", "theka the martyr", "sergeant bly", "jammal'an the prophet",
               "ogom the wretched", "zolo", "gasher", "loro", "hukku", "zul'lor", "mijan", "shadow hunter vosh'gajin", "war master voone",
               "vol'jin", "sen'jin", "zalazane", "gan'zulah", "nimbo", "mogh the undying", "jin'do", "hex of jammal'an",
               "zanzil the outcast", "mai'zoth", "vile priestess hexx", "hitah'ya the keeper", "nekrum gutchewer",
               "witch doctor uzer'i", "hi'ji the savage"}
ORC = rx("orc", "blackrock", "dragonmaw", "burning blade", "searing blade", "bloodaxe", "warsong", "frostwolf", "grunt", "kor'kron",
         "bleeding hollow", "shattered hand", "thunderlord", "bonechewer", "dark horde")
ORC_NAMES = {"thrall", "overlord wyrmthalak", "warchief rend blackhand", "quartermaster zigris", "gizrul the slavener",
             "nazgrel", "eitrigg", "drek'thar", "garrosh hellscream", "grommash hellscream", "kargath bladefist", "taragaman the hungerer",
             "bazzalan", "jergosh the invoker", "oggleflint", "orgrimmar grunt"}
ORC_NOT = rx("orc-slayer", "orcbane", "orca", "ogre", "spirestone", "firegut", "dragon", "drake", "whelp", "dragonkin", "wolf", "rider", "kodo", "boar", "worg")
DWARF = rx("dark iron", "ironforge", "bronzebeard", "wildhammer", "mountaineer", "dwarven", "dwarf", "shadowforge", "thaurissan",
           "anvilrage", "doomforge", "grim patron", "hammered patron")
DWARF_NAMES = {"general angerforge", "golem lord argelmach", "fineous darkvire", "emperor dagran thaurissan", "hurley blackbreath",
               "plugger spazzring", "high interrogator gerstahn", "houndmaster grebmar", "pyromancer loregrain", "warder stilgiss",
               "bael'gar", "galgann firehammer", "magregan deepshadow", "baelog", "olaf", "eric \"the swift\"", "king magni bronzebeard",
               "muradin bronzebeard", "falstad wildhammer", "dark iron ambassador"}
DWARF_NOT = rx("golem", "construct", "reaver", "elemental", "hound", "worg", "spider", "giant", "fire spirit")
PLANT = rx("lasher", "treant", "bogling", "thistleshrub", "withervine", "shambler", "bog lord", "bog beast", "bog horror", "mire beast",
           "sapling", "bloodpetal", "constrictor vine", "flayer", "thresher vine", "mushroom", "shroom", "spore", "fungal giant", "vine",
           "ancient", "gloom weed", "briarthorn", "thornling", "razorlash", "dryad")
PLANT_TYPES = {4, 5, 10}   # never a humanoid "Ancient", a dragon or an undead
PLANT_NOT = rx("ooze", "slime", "tiger", "raptor", "boar", "bear", "kodo", "spider", "scorpid", "basilisk", "drake", "dragon", "stalker",
               "flayer", "naga", "ancient kodo", "ancient core hound", "ancient protector", "ancient stone keeper", "hive'zara", "qiraji",
               "trigore", "scorpashi", "scorpok", "phase lasher", "night elf", "ancient of lore", "ancient of war", "ember clutch ancient")
AQUATIC = rx("makrura", "crawler", "crab", "clattering", "lobstrosity", "snapper", "snapjaw", "turtle", "tortoise", "thresher", "shark",
             "eel", "hydra", "sea serpent", "sea giant", "water elemental", "tidal", "wave", "sea spray", "lurker below", "barracuda",
             "piranha", "jellyfish", "squid", "octopus", "mudsnout", "puffer", "fish")
AQUATIC_NOT = rx("tar crawler", "cavern crawler", "bone crawler", "hive crawler", "scorpid", "scorpashi", "scorpok", "crocolisk", "silithid", "branch snapper", "bloodpetal", "root thresher",
                 "mana snapper", "flame wave", "plague wave", "riding turtle", "fish market", "fisherman", "fishing", "waveslicer", "shockwave", "heatwave", "brainwave")
EARTH = rx("earth elemental", "rock elemental", "stone elemental", "rumbler", "rockbiter", "stone fury", "obsidian elemental",
           "earthborer", "rock borer", "landslide", "behemoth", "avalanchion", "shale", "gravel", "boulder", "crag", "rock", "stone",
           "earth", "theradras", "roccor")
EARTH_NOT = rx("rotting behemoth", "bonechewer behemoth", "vortex", "rockjaw", "stonesplinter", "stonevault", "stonetalon", "boulderfist", "rockhide", "crag boar", "crag coyote",
               "stonemaul", "stonetusk", "stoneclaw", "stone keeper", "stone steward", "stonard", "stormwind")
GOLEM = rx("golem", "war reaver", "wrath hammer construct", "construct", "phalanx")
GOLEM_NOT = rx("golem lord")
TITAN = rx("earthen", "stone keeper", "stone steward", "obsidian sentinel", "ironaya", "archaedas", "vault warder", "titan", "stone watcher of norgannon",
           "keeper of the vault")
TITAN_NOT = rx("earthen ring", "watcher kleeman", "nightwatch", "deathwatch", "ewatcher", "watchers")
FIRE = rx("fire elemental", "flame", "fire", "lava", "magma", "inferno", "blaze", "ember", "scorching", "burning", "molten", "firelord",
          "flamewaker", "ragnaros", "garr", "firesworn", "geddon", "incendius", "flamelash", "searing", "smoldering", "living flame",
          "pyroclast", "cinder", "incendosaur", "fireguard")
FIRE_NOT = rx("phase lasher", "golem", "imp", "ember clutch ancient", "test", "fireguard destroyer", "firegut", "firemane", "fireflies", "firetail", "ember worg", "scorching wind")
MOUNTAIN_GIANT = rx("mountain giant", "cliff giant", "stone giant", "rock giant")
NAGA_NOT = rx("murloc", "vile fin", "torn fin", "blacksilt", "greymist", "chillmere", "scarlet", "hydra", "image")
NAGA = rx("naga", "strashaz", "hatecrest", "wrathtail", "daggerspine", "darkcrest", "bloodscale", "coilfang", "coilskar", "riplash", "stormscale",
          "wrathscale", "spitelash", "strashaz", "slitherblade", "siren", "myrmidon", "sea witch", "tidehunter", "serpentguard", "lady sarevess",
          "lady vespia", "lady sesspira", "lady szallah", "lady sathrah", "tidecaller")
SATYR = rx("satyr", "bleakheart", "xavian", "felmusk", "haldarr", "legashi", "hatefury", "jadefire", "shadowhorn", "felsworn",
           "hellcaller", "trickster", "shadowstalker", "betrayer", "vyletongue", "xavalis", "zevrim thornhoof")
SATYR_TYPES = {3, 7, 10}
SATYR_NOT = rx("hound", "burning blade", "shadow council", "mennu", "kaide", "tarkreu")
DINO = rx("devilsaur", "stegodon", "diemetradon", "pterrordax", "raptor", "ravasaur", "king mosh",
          "incendosaur", "basaur")
SERPENT = rx("serpent", "snake", "cobra", "viper", "adder", "python", "hydra")
SERPENT_NOT = rx("snake trap", "serpent form", "serpent messenger")
JUNK_RAW = ("[ph]", "(ph)", "designer island", "(fire)", "image of ", "[deprecated", "spore cloud", "orb of deception", "troll-servant", "roof stalker", "(dnt)", " corpse", "dead orc")
JUNK = rx("trigger", "credit", "marker", "target", "costume", r"\[ph\]", "unused", "test")

def groups_of(name, typ, family):
    n = (name or '').lower(); g = 0
    def has(r): return bool(r.search(n))
    if has(JUNK) or any(j in n for j in JUNK_RAW): return 0
    if typ in (6, 7, 10) and (has(TROLL) or n in TROLL_NAMES) and not has(TROLL_NOT): g |= 1 << 0
    if typ == 7 and (has(ORC) or n in ORC_NAMES) and not has(ORC_NOT): g |= 1 << 1
    if typ == 7 and (has(DWARF) or n in DWARF_NAMES) and not has(DWARF_NOT): g |= 1 << 2
    if typ in PLANT_TYPES and has(PLANT) and not has(PLANT_NOT): g |= 1 << 3
    if typ in (1, 4, 5, 10) and (has(AQUATIC) or family in (8, 21)) and family != 6 and not has(AQUATIC_NOT): g |= 1 << 4   # crab 8, turtle 21
    if typ == 4 and has(EARTH) and not has(EARTH_NOT): g |= 1 << 5
    if typ in (9, 4, 10) and has(GOLEM) and not has(GOLEM_NOT): g |= 1 << 6
    if typ in (4, 9, 10, 5, 7) and has(TITAN) and not has(TITAN_NOT): g |= 1 << 7
    if typ == 4 and has(FIRE) and not has(FIRE_NOT): g |= 1 << 8
    if typ == 5 and has(MOUNTAIN_GIANT): g |= 1 << 9
    if typ in (7, 10) and has(NAGA) and not has(NAGA_NOT): g |= 1 << 10
    if typ in SATYR_TYPES and has(SATYR) and not has(SATYR_NOT): g |= 1 << 11
    if typ in (1, 10) and (has(DINO) or family == 11): g |= 1 << 12   # raptor 11
    if typ in (1, 10) and (has(SERPENT) or family in (27, 35)) and not has(SERPENT_NOT): g |= 1 << 13   # wind serpent 27, serpent 35
    return g
