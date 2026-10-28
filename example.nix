{
  lib,
  ...
} : let
  balls   = [ 
    "safari" "sport" "fast" "friend" "heavy"
    "level" "love" "lure" "moon" "dream" "beast"
  ];

  mkBalls = flags: lib.genAttrs balls (_: flags);
  none    = { ball = false; ha = false; eggMoves = false; };
  allNone = mkBalls none;  
  allHA   = mkBalls { ball = true; ha = true; eggMoves = false; };
  allDone = mkBalls { ball = true; ha = true; eggMoves = true;  };
in {

  pokenix = {
    # 🦆 ⮞ TRAINER CARD
    trainer = {
      name       = "pungkula";
      picture    = ./profile-picture.png;
      about      = "★ breeding master ★ shiny hunter ★ ducklett lover ★";
      region     = "Sweden";
      timezone   = "Europe/Stockholm";
      contact    = "Discord pungkula#0001";
      friendCode = "SW-1234-5678-9012";
      switchName = "pungkula";
      trainerId  = "082409";
    };

    # 🦆 ⮞ SPECIAL POKÉMON
    specials."mewtwo-ribbon-master" = {
      species    = "mewtwo";
      ball       = "master";
      shiny      = true;
      selfObtained = true;
      level      = 100;
      nature     = "Timid";
      ability    = "Pressure";
      heldItem   = "Life Orb";
      teraType   = "Psychic";
      evs        = { hp = 4; spa = 252; spe = 252; };
      ivs        = { hp = 31; atk = 0; def = 31; spa = 31; spd = 31; spe = 31; };
      moves      = [ "Psystrike" "Aura Sphere" "Ice Beam" "Calm Mind" ];
      ribbons    = [ "Effort Ribbon" "Master Rank Ribbon" ];
      marks      = [ "The Unrivaled" ];
      ot         = "pungkula";
      id         = "082409";
      region     = "ENG";
      obtained   = "2023/08/15";
      notes      = "SR 3 days";
    };

    specials."articuno-1" = {
      species = "articuno";
      ball = "beast";
      selfObtained = true;
      ability = "Pressure";
      region = "ENG";
      notes = "Lets Go";
    };

    specials."articuno-2" = {
      species = "articuno";
      ball = "beast";
      selfObtained = true;
      ability = "Pressure";
      region = "ENG";
      notes = "2020-11-08 - Max Lair";
    };

    specials."zapdos-1" = {
      species = "zapdos";
      ball = "beast";
      selfObtained = true;
      ability = "Pressure";
      region = "ENG";
    };

    specials."zapdos-2" = {
      species = "zapdos";
      ball = "beast";
      selfObtained = true;
      ability = "Pressure";
      region = "ENG";
      notes = "Max Lair - Fast ball";
    };

    specials."moltres-1" = {
      species = "moltres";
      ball = "beast";
      selfObtained = true;
      ability = "Pressure";
      region = "ENG";
    };

    specials."moltres-2" = {
      species = "moltres";
      ball = "beast";
      selfObtained = true;
      ability = "Pressure";
      region = "ENG";
      notes = "Nax Lair";
    };

    specials."mewtwo-1" = {
      species = "mewtwo";
      ball = "beast";
      selfObtained = true;
      ability = "Pressure";
      region = "ENG";
      notes = "Nax Lair";
    };

    specials."mewtwo-2" = {
      species = "mewtwo";
      ball = "beast";
      selfObtained = true;
      ability = "Pressure";
      region = "ENG";
      notes = "Nax Lair";
    };

    specials."mewtwo-3" = {
      species = "mewtwo";
      ball = "beast";
      selfObtained = false;
      ability = "Unnerve";
      region = "ENG";
      notes = "Play 2016";
    };

    specials."mew-1" = {
      species = "mew";
      ball = "beast";
      selfObtained = false;
      ability = "Synchronize";
      region = "ENG";
    };

    specials."mew-2" = {
      species = "mew";
      ball = "beast";
      selfObtained = false;
      ability = "Synchronize";
      region = "JPN";
    };

    specials."raikou-1" = {
      species = "raikou";
      ball = "beast";
    };

    specials."raikou-2" = {
      species = "raikou";
      ball = "beast";
      selfObtained = false;
      ability = "Pressure";
      region = "ENG";
      notes = "GAMESTP";
    };

    specials."entei-1" = {
      species = "entei";
      ball = "beast";
      selfObtained = false;
      region = "ENG";
      notes = "GTS";
    };

    specials."entei-2" = {
      species = "entei";
      ball = "beast";
      selfObtained = true;
      ability = "Pressure";
      region = "ENG";
      notes = "Max Lair";
    };

    specials."suicune-1" = {
      species = "suicune";
      ball = "beast";
      selfObtained = false;
      ability = "Pressure";
      region = "ENG";
      notes = "GAMESTP";
    };

    specials."lugia-1" = {
      species = "lugia";
      ball = "beast";
      selfObtained = true;
      notes = "Max Lair";
    };

    specials."ho-oh-1" = {
      species = "ho-oh";
      ball = "beast";
      selfObtained = false;
      region = "ENG";
      notes = "GTS";
    };

    specials."celebi-1" = {
      species = "celebi";
      ball = "beast";
      selfObtained = false;
      ability = "Natural Cure";
      region = "ENG";
      notes = "GF";
    };

    specials."celebi-2" = {
      species = "celebi";
      ball = "beast";
      selfObtained = false;
      ability = "Natural Cure";
      region = "JPN";
      notes = "Jungle";
    };

    specials."regirock-1" = {
      species = "regirock";
      ball = "beast";
      selfObtained = true;
      ability = "Clear Body";
      region = "ENG";
      notes = "2020-11-23 (9 BBall attempts) (decent att & SpA)";
    };

    specials."regice-1" = {
      species = "regice";
      ball = "beast";
      selfObtained = true;
      ability = "Clear Body";
      region = "ENG";
      notes = "2020-11-26 (145 BBall attempts) (decent att)";
    };

    specials."registeel-1" = {
      species = "registeel";
      ball = "beast";
      selfObtained = true;
      ability = "Clear Body";
      region = "ENG";
      notes = "2020-11-23 (89 BBall attempts) (decent att & SpA)";
    };

    specials."latias-1" = {
      species = "latias";
      ball = "beast";
      selfObtained = true;
      ability = "Levitate";
      region = "ENG";
      notes = "Max Lair";
    };

    specials."latios-1" = {
      species = "latios";
      ball = "beast";
      selfObtained = false;
    };

    specials."kyogre-1" = {
      species = "kyogre";
      ball = "beast";
      selfObtained = true;
      ability = "Drizzle";
      region = "ENG";
      notes = "Max Lair";
    };

    specials."groudon-1" = {
      species = "groudon";
      ball = "beast";
      selfObtained = true;
      ability = "Drought";
      region = "ENG";
      notes = "Max Lair";
    };

    specials."groudon-2" = {
      species = "groudon";
      ball = "beast";
      ability = "Drought";
      region = "ENG";
    };

    specials."rayquaza-1" = {
      species = "rayquaza";
      ball = "beast";
      selfObtained = true;
      ability = "Air Lock";
      region = "ENG";
      notes = "Max Lair";
    };

    specials."jirachi-1" = {
      species = "jirachi";
      ball = "beast";
      selfObtained = false;
      ability = "Serene Grace";
      region = "ENG";
      notes = "2003 WISHMKR";
    };

    specials."jirachi-2" = {
      species = "jirachi";
      ball = "beast";
      selfObtained = false;
      ability = "Serene Grace";
      region = "ENG";
      notes = "NINTENDO HK";
    };

    specials."deoxys-1" = {
      species = "deoxys";
      ball = "beast";
      selfObtained = false;
      ability = "Pressure";
      region = "ENG";
    };

    specials."mesprit-1" = {
      species = "mesprit";
      ball = "beast";
      selfObtained = false;
      ability = "Levitate";
      notes = "gts";
    };

    specials."mesprit-2" = {
      species = "mesprit";
      ball = "beast";
      selfObtained = true;
      ability = "Levitate";
      region = "ENG";
      notes = "Nax Lair";
    };

    specials."mesprit-3" = {
      species = "mesprit";
      ball = "beast";
    };

    specials."azelf-1" = {
      species = "azelf";
      ball = "beast";
      selfObtained = true;
      ability = "Levitate";
      notes = "Nax Lair";
    };

    specials."azelf-2" = {
      species = "azelf";
      ball = "beast";
    };

    specials."dialga-1" = {
      species = "dialga";
      ball = "beast";
      selfObtained = true;
      ability = "Pressure";
      region = "ENG";
      notes = "Nax Lair";
    };

    specials."dialga-2" = {
      species = "dialga";
      ball = "beast";
      selfObtained = false;
      ability = "Pressure";
      region = "ENG";
      notes = "SUM2013 2020/08/24";
    };

    specials."palkia-1" = {
      species = "palkia";
      ball = "beast";
      ability = "Pressure";
      region = "JPN";
      notes = "GTS 2020/08/16";
    };

    specials."palkia-2" = {
      species = "palkia";
      ball = "beast";
      selfObtained = false;
      ability = "Pressure";
      region = "ENG";
      notes = "SUM2013 2020/08/24";
    };

    specials."heatran-1" = {
      species = "heatran";
      ball = "beast";
      selfObtained = true;
      notes = "Max Lair";
    };

    specials."regigigas-1" = {
      species = "regigigas";
      ball = "beast";
      selfObtained = false;
      ability = "Slow Start";
      notes = "TRU";
    };

    specials."giratina-1" = {
      species = "giratina";
      ball = "beast";
      selfObtained = true;
      ability = "Pressure";
      region = "ENG";
      notes = "Max Lair";
    };

    specials."giratina-2" = {
      species = "giratina";
      ball = "beast";
      selfObtained = false;
      ability = "Pressure";
      region = "ENG";
      notes = "SUM2013";
    };

    specials."cresselia-1" = {
      species = "cresselia";
      ball = "beast";
      selfObtained = true;
      ability = "Levitate";
      region = "ENG";
      notes = "2020-11-08 Max Lair (1 attack)";
    };

    specials."phione-1" = {
      species = "phione";
      ball = "beast";
      selfObtained = false;
      ability = "Hydration";
      region = "ENG";
      notes = "Got from OT 2020/08/16";
    };

    specials."manaphy-1" = {
      species = "manaphy";
      ball = "beast";
      selfObtained = false;
      ability = "Hydration";
      region = "ENG";
      notes = "GF";
    };

    specials."darkrai-1" = {
      species = "darkrai";
      ball = "beast";
      selfObtained = false;
      ability = "Bad Dreams";
      region = "ENG";
      notes = "2012MAY . 2020/08/21";
    };

    specials."darkrai-2" = {
      species = "darkrai";
      ball = "beast";
      selfObtained = false;
      ability = "Bad Dreams";
      region = "JPN";
      notes = "2020/08/21";
    };

    specials."shaymin-1" = {
      species = "shaymin";
      ball = "beast";
      selfObtained = false;
      ability = "Natural Cure";
      notes = "20th Anniversary";
    };

    specials."shaymin-2" = {
      species = "shaymin";
      ball = "beast";
      selfObtained = false;
      ability = "Natural Cure";
      region = "ENG";
    };

    specials."arceus-1" = {
      species = "arceus";
      ball = "beast";
      selfObtained = false;
      ability = "Multitype";
      region = "ENG";
      notes = "TRU";
    };

    specials."victini-1" = {
      species = "victini";
      ball = "beast";
      selfObtained = false;
      ability = "Victory Star";
      region = "ENG";
      notes = "Movie DIstribution";
    };

    specials."ducklett-the-driven-1" = {
      species = "ducklett";
      ball = "beast";
      selfObtained = true;
      ability = "Pumped-Up Mark";
      notes = "2023/09/23";
    };

    specials."cobalion-1" = {
      species = "cobalion";
      ball = "beast";
      selfObtained = false;
      ability = "Justified";
      region = "ENG";
      notes = "2020/08/16";
    };

    specials."cobalion-2" = {
      species = "cobalion";
      ball = "beast";
      selfObtained = false;
      ability = "Justified";
      region = "ENG";
      notes = "2020/08/16";
    };

    specials."terrakion-1" = {
      species = "terrakion";
      ball = "beast";
      selfObtained = false;
      ability = "Justified";
      region = "ENG";
    };

    specials."terrakion-2" = {
      species = "terrakion";
      ball = "beast";
      selfObtained = false;
      ability = "Justified";
      region = "ENG";
    };

    specials."virizion-1" = {
      species = "virizion";
      ball = "beast";
      selfObtained = false;
      ability = "Justified";
      region = "ENG";
      notes = "2020/08/16";
    };

    specials."virizion-2" = {
      species = "virizion";
      ball = "beast";
      selfObtained = false;
      ability = "Justified";
      region = "ENG";
      notes = "2020/08/16";
    };

    specials."tornadus-1" = {
      species = "tornadus";
      ball = "beast";
      selfObtained = true;
      ability = "Prankster";
      region = "ENG";
      notes = "Max Lair";
    };

    specials."thundurus-1" = {
      species = "thundurus";
      ball = "beast";
    };

    specials."reshiram-1" = {
      species = "reshiram";
      ball = "beast";
      selfObtained = false;
      ability = "Turboblaze";
      region = "ENG";
    };

    specials."reshiram-2" = {
      species = "reshiram";
      ball = "beast";
      selfObtained = true;
      ability = "Turboblaze";
      region = "ENG";
      notes = "Max Lair";
    };

    specials."reshiram-3" = {
      species = "reshiram";
      ball = "beast";
      selfObtained = true;
      ability = "Turboblaze";
      region = "ENG";
      notes = "Max Lair";
    };

    specials."reshiram-4" = {
      species = "reshiram";
      ball = "beast";
      selfObtained = false;
      ability = "Turboblaze";
      region = "FRE";
    };

    specials."zekrom-1" = {
      species = "zekrom";
      ball = "beast";
      selfObtained = false;
      ability = "Teravolt";
      region = "ENG";
      notes = "event \"SPR2012\" 2020/08/16";
    };

    specials."zekrom-2" = {
      species = "zekrom";
      ball = "beast";
      selfObtained = true;
      ability = "Teravolt";
      region = "ENG";
      notes = "Max Lair";
    };

    specials."landorus-1" = {
      species = "landorus";
      ball = "beast";
      selfObtained = true;
      ability = "Sand Force";
      region = "ENG";
      notes = "Max Lair";
    };

    specials."kyurem-1" = {
      species = "kyurem";
      ball = "beast";
      selfObtained = false;
      ability = "Pressure";
      region = "JPN";
    };

    specials."kyurem-2" = {
      species = "kyurem";
      ball = "beast";
      selfObtained = true;
      ability = "Pressure";
      region = "ENG";
      notes = "Max Lair";
    };

    specials."keldeo-1" = {
      species = "keldeo";
      ball = "beast";
      selfObtained = false;
      ability = "Justified";
      region = "ENG";
    };

    specials."meloetta-1" = {
      species = "meloetta";
      ball = "beast";
      selfObtained = false;
      ability = "Serene Grace";
      region = "ENG";
    };

    specials."genesect-1" = {
      species = "genesect";
      ball = "beast";
    };

    specials."genesect-2" = {
      species = "genesect";
      ball = "beast";
      selfObtained = false;
      ability = "Download";
      region = "ENG";
      notes = "Movie DIstribution";
    };

    specials."xerneas-1" = {
      species = "xerneas";
      ball = "beast";
      selfObtained = true;
    };

    specials."yveltal-1" = {
      species = "yveltal";
      ball = "beast";
      selfObtained = true;
      ability = "Dark Aura";
      notes = "Max Lair";
    };

    specials."zygarde-1" = {
      species = "zygarde";
      ball = "beast";
      ability = "Aura Break";
    };

    specials."diancie-1" = {
      species = "diancie";
      ball = "beast";
    };

    specials."diancie-2" = {
      species = "diancie";
      ball = "beast";
      selfObtained = false;
      ability = "Clear Body";
      region = "ENG";
    };

    specials."hoopa-1" = {
      species = "hoopa";
      ball = "beast";
      selfObtained = false;
    };

    specials."volcanion-1" = {
      species = "volcanion";
      ball = "beast";
      selfObtained = false;
    };

    specials."type-null-1" = {
      species = "type-null";
      ball = "beast";
      selfObtained = true;
      ability = "RKS System";
      region = "ENG";
    };

    specials."silvally-1" = {
      species = "silvally";
      ball = "beast";
      selfObtained = true;
      ability = "RKS System";
      region = "ENG";
    };

    specials."silvally-2" = {
      species = "silvally";
      ball = "beast";
      selfObtained = false;
      ability = "RKS System";
      region = "ENG";
    };

    specials."tapu-koko-1" = {
      species = "tapu-koko";
      ball = "beast";
      selfObtained = false;
      ability = "Electric Surge";
      region = "ITA";
      notes = "GTS";
    };

    specials."tapu-lele-1" = {
      species = "tapu-lele";
      ball = "beast";
      selfObtained = false;
      ability = "Psychic Surge";
      region = "SPA";
      notes = "GTS";
    };

    specials."tapu-lele-2" = {
      species = "tapu-lele";
      ball = "beast";
      selfObtained = true;
      ability = "Psychic Surge";
      region = "ENG";
      notes = "Max Lair";
    };

    specials."tapu-bulu-1" = {
      species = "tapu-bulu";
      ball = "beast";
      selfObtained = false;
      ability = "Grassy Surge";
      region = "ITA";
      notes = "GTS";
    };

    specials."tapu-bulu-2" = {
      species = "tapu-bulu";
      ball = "beast";
      selfObtained = true;
      ability = "Grassy Surge";
      region = "ENG";
      notes = "Max Lair";
    };

    specials."tapu-fini-1" = {
      species = "tapu-fini";
      ball = "beast";
      selfObtained = true;
      ability = "Misty Surge";
      region = "ENG";
      notes = "Max Lair";
    };

    specials."cosmog-1" = {
      species = "cosmog";
      ball = "beast";
      selfObtained = true;
      ability = "Unaware";
      region = "ENG";
      notes = "2020/11/12";
    };

    specials."cosmog-2" = {
      species = "cosmog";
      ball = "beast";
      selfObtained = false;
      ability = "Unaware";
      region = "ENG";
      notes = "2020/08/16";
    };

    specials."cosmoem-1" = {
      species = "cosmoem";
      ball = "beast";
      selfObtained = false;
    };

    specials."solgaleo-1" = {
      species = "solgaleo";
      ball = "beast";
      selfObtained = false;
      ability = "Full Metal Body";
      region = "ENG";
      notes = "Got from OT 2020/07/12";
    };

    specials."solgaleo-2" = {
      species = "solgaleo";
      ball = "beast";
      selfObtained = false;
      ability = "Full Metal Body";
      region = "ENG";
      notes = "Eclipse 2020/08/16";
    };

    specials."lunala-1" = {
      species = "lunala";
      ball = "beast";
      selfObtained = false;
      ability = "Shadow Shield";
      region = "ENG";
    };

    specials."lunala-2" = {
      species = "lunala";
      ball = "beast";
      selfObtained = false;
      ability = "Shadow Shield";
      region = "ENG";
    };

    specials."nihilego-1" = {
      species = "nihilego";
      ball = "beast";
      selfObtained = false;
      ability = "Beast Boost";
      region = "JPN";
      notes = "GTS";
    };

    specials."buzzwole-1" = {
      species = "buzzwole";
      ball = "beast";
      selfObtained = false;
      ability = "Beast Boost";
      region = "ENG";
      notes = "GTS";
    };

    specials."pheromosa-1" = {
      species = "pheromosa";
      ball = "beast";
      selfObtained = true;
      ability = "Beast Boost";
      region = "ENG";
      notes = "Max Lair";
    };

    specials."pheromosa-2" = {
      species = "pheromosa";
      ball = "beast";
      selfObtained = false;
      ability = "Beast Boost";
      region = "ENG";
      notes = "GTS";
    };

    specials."xurkitree-1" = {
      species = "xurkitree";
      ball = "beast";
      selfObtained = false;
      ability = "Beast Boost";
      region = "ENG";
      notes = "GTS";
    };

    specials."celesteela-1" = {
      species = "celesteela";
      ball = "beast";
      selfObtained = false;
      ability = "Beast Boost";
      region = "ENG";
      notes = "GTS";
    };

    specials."kartana-1" = {
      species = "kartana";
      ball = "beast";
      selfObtained = false;
      ability = "Beast Boost";
      region = "ENG";
      notes = "GTS";
    };

    specials."guzzlord-1" = {
      species = "guzzlord";
      ball = "beast";
      selfObtained = false;
      ability = "Beast Boost";
      region = "ENG";
      notes = "GTS";
    };

    specials."necrozma-1" = {
      species = "necrozma";
      ball = "beast";
      selfObtained = false;
      ability = "Prism Armor";
      region = "ENG";
      notes = "Got from OT 2020/07/10";
    };

    specials."necrozma-2" = {
      species = "necrozma";
      ball = "beast";
      selfObtained = false;
      ability = "Prism Armor";
      region = "JPN";
      notes = "event";
    };

    specials."magearna-1" = {
      species = "magearna";
      ball = "beast";
      selfObtained = false;
      ability = "Soul-Heart";
      region = "ENG";
    };

    specials."marshadow-1" = {
      species = "marshadow";
      ball = "beast";
      selfObtained = false;
      ability = "Technician";
      region = "ENG";
      notes = "Mt Tenei";
    };

    specials."poipole-1" = {
      species = "poipole";
      ball = "beast";
      selfObtained = true;
      ability = "Beast Boost";
      region = "ENG";
      notes = "0 speed    2021/02/26";
    };

    specials."poipole-2" = {
      species = "poipole";
      ball = "beast";
      selfObtained = false;
      ability = "Beast Boost";
      region = "SPA";
      notes = "GTS";
    };

    specials."naganadel-1" = {
      species = "naganadel";
      ball = "beast";
      selfObtained = false;
      ability = "Beast Boost";
      region = "ENG";
      notes = "GTS";
    };

    specials."stakataka-1" = {
      species = "stakataka";
      ball = "beast";
      selfObtained = false;
      ability = "Beast Boost";
      notes = "GTS";
    };

    specials."blacephalon-1" = {
      species = "blacephalon";
      ball = "beast";
      selfObtained = false;
      ability = "Beast Boost";
      region = "ENG";
      notes = "GTS";
    };

    specials."zeraora-1" = {
      species = "zeraora";
      ball = "beast";
      selfObtained = true;
      ability = "Volt Absorb";
      region = "ENG";
    };

    specials."zeraora-2" = {
      species = "zeraora";
      ball = "beast";
      selfObtained = true;
      ability = "Volt Absorb";
      region = "ENG";
    };

    specials."meltan-1" = {
      species = "meltan";
      ball = "beast";
      selfObtained = false;
      ability = "Magnet Pull";
      region = "ENG";
      notes = "got from OT 2020/10/11";
    };

    specials."melmetal-1" = {
      species = "melmetal";
      ball = "beast";
      selfObtained = false;
      ability = "Iron Fist";
      region = "ENG";
      notes = "got from OT 2020/08/25";
    };

    specials."melmetal-2" = {
      species = "melmetal";
      ball = "beast";
      selfObtained = false;
      region = "ENG";
      notes = "2020/12/25  hc 700479142096797797";
    };

    specials."melmetal-3" = {
      species = "melmetal";
      ball = "beast";
      selfObtained = true;
      ability = "Iron Fist";
      region = "ENG";
      notes = "OT 2020/11/19 (0 speed)";
    };

    specials."zacian-1" = {
      species = "zacian";
      ball = "beast";
      selfObtained = true;
      ability = "Intrepid Sword";
      region = "ENG";
      ot = "pungkula";
      id = "996385";
      notes = "caught 2021/03/02    31 beast balls";
    };

    specials."zamazenta-1" = {
      species = "zamazenta";
      ball = "beast";
      selfObtained = true;
      ability = "Dauntless Shield";
      region = "ENG";
      ot = "pungkula";
      id = "384971";
      notes = "caught 2021/02/28    29 beast balls";
    };

    specials."eternatus-1" = {
      species = "eternatus";
      ball = "beast";
      selfObtained = true;
      ability = "Pressure";
      region = "ENG";
      ot = "pungkula";
      id = "384971";
      notes = "14 attack caught 2021/02/28";
    };

    specials."eternatus-2" = {
      species = "eternatus";
      ball = "beast";
      selfObtained = true;
      ability = "Pressure";
      region = "ENG";
      ot = "pungkula";
      id = "996385";
      notes = "1 attack caught 2021/03/01";
    };

    specials."eternatus-3" = {
      species = "eternatus";
      ball = "beast";
      selfObtained = true;
      ability = "Pressure";
      region = "ENG";
    };

    specials."kubfu-1" = {
      species = "kubfu";
      name = "Pungfu";
      ball = "beast";
      selfObtained = true;
      ability = "Inner Focus";
      region = "ENG";
      notes = "2021-02-26    0 speed";
    };

    specials."urshifu-1" = {
      species = "urshifu";
      ball = "beast";
      selfObtained = true;
      ability = "Unseen Fists";
      region = "ENG";
      notes = "0 speed";
    };

    specials."urshifu-2" = {
      species = "urshifu";
      ball = "beast";
      selfObtained = true;
      ability = "Unseen Fists";
      region = "ENG";
    };

    specials."zarude-1" = {
      species = "zarude";
      ball = "beast";
      selfObtained = false;
      ability = "Leaf Guard";
      region = "ENG";
      notes = "2020-09-26";
    };

    specials."zarude-dada-1" = {
      species = "zarude";
      ball = "beast";
      selfObtained = false;
      notes = "Dada form";
    };

    specials."regieleki-1" = {
      species = "regieleki";
      ball = "beast";
      selfObtained = true;
      notes = "2021-02-26";
    };

    specials."regieleki-2" = {
      species = "regieleki";
      ball = "beast";
    };

    specials."regidrago-1" = {
      species = "regidrago";
      ball = "beast";
      ability = "Dragon Maw";
      region = "ENG";
    };

    specials."regidrago-2" = {
      species = "regidrago";
      ball = "beast";
    };

    specials."glastrier-1" = {
      species = "glastrier";
      ball = "beast";
      selfObtained = true;
      ability = "Chilling Neigh";
      region = "ENG";
      notes = "2020-11-21 (17 BBall attempts) (4iv  5 SpA)";
    };

    specials."spectrier-1" = {
      species = "spectrier";
      ball = "beast";
      selfObtained = true;
      region = "ENG";
      notes = "2020-11-12 (13 BBall attempts)  (4iv)";
    };

    specials."calyrex-1" = {
      species = "calyrex";
      ball = "beast";
      selfObtained = true;
      region = "ENG";
      notes = "2020-11-12 (5iv 10 speed)";
    };

    specials."calyrex-2" = {
      species = "calyrex";
      ball = "beast";
      selfObtained = true;
      region = "ENG";
      notes = "2020-11-21 (3iv 0hp 5 attack)";
    };

    specials."ice-rider-1" = {
      species = "calyrex";
      ball = "beast";
      selfObtained = true;
      ability = "As One";
      region = "ENG";
      notes = "Ice Rider form";
    };

    specials."shadow-rider-1" = {
      species = "calyrex";
      ball = "beast";
      selfObtained = true;
      ability = "As One";
      region = "ENG";
      notes = "Shadow Rider form; 2020-11-12 (13 BBall attempts)";
    };

    specials."articuno-g-1" = {
      species = "articuno-galar";
      ball = "beast";
      selfObtained = true;
      ability = "Competetive";
      region = "ENG";
      notes = "2020-11-12 (413 BBall attempts)";
    };

    specials."zapdos-g-1" = {
      species = "zapdos-galar";
      ball = "beast";
      name = "Zapduck";
      selfObtained = true;
      ability = "Defiant";
      region = "ENG";
      notes = "2020-11-08 (870 BBall attempts)";
    };

    specials."zapdos-g-2" = {
      species = "zapdos-galar";
      name = "Zapdos";
      ball = "beast";      
      ot         = "pungkula";
      id         = "082409";
      region = "ENG";
      selfObtained = true;
      obtained   = "2021/02/26";
      level      = 100;
      nature     = "Timid";
      ability    = "Pressure";
      evs        = { hp = 4; spa = 252; spe = 252; };
      ivs        = { hp = 31; atk = 0; def = 31; spa = 31; spd = 31; spe = 31; };
      moves      = [ "Psystrike" "Aura Sphere" "Ice Beam" "Calm Mind" ];
      shiny      = false;
      marks = [ "Sleepy Time" ];
      notes = "Zzzleepy Marked 2021-02-26";      
    };

    specials."moltres-g-1" = {
      species = "moltres-galar";
      ball = "beast";
      selfObtained = true;
      ability = "Berserk";
      region = "ENG";
      notes = "2020-11-10 (15 BBall attempts)";
    };

    specials."okidogi-1" = {
      species = "okidogi";
      ball = "beast";
    };

    specials."munkidori-1" = {
      species = "munkidori";
      ball = "beast";
    };

    specials."fezandipiti-1" = {
      species = "fezandipiti";
      ball = "beast";
    };

    specials."ogerpon-1" = {
      species = "ogerpon";
      ball = "beast";
      selfObtained = true;
      notes = "2023/09/23";
    };

    specials."archaludon-1" = {
      species = "archaludon";
      ball = "beast";
    };

    specials."raging-bolt-1" = {
      species = "raging-bolt";
      ball = "beast";
    };

    specials."iron-crown-1" = {
      species = "iron-crown";
      ball = "beast";
    };

    specials."terapagos-1" = {
      species = "terapagos";
      ball = "beast";
    };



    # 🦆 ⮞ EVENT POKÉMON
    events = {
      # »  2003  «
      "farfetchd-2003-jemma" = {
        species="farfetchd"; dex=83; name="Farfetch'd"; ball = "pokeball"; year="2003"; ot="Jemma"; id="17749"; region="ENG"; notes="WiSHMKR"; 
        proof="friend of OT TC"; obtained="2021/02/16"; moves=[ "Wish" "Yawn" ]; tradeHistory="GoroMajimaIsMyIdol#8508 > pungkula";
      };
      "jirachi-2003-wishmkr-1" = {
        species="jirachi"; dex=385; name="Jirachi"; shiny=true; year="2003"; ot="WISHMKR"; id="20043"; region="ENG"; notes="WiSHMKR"; moves=[ "Wish" "Confusion" "Rest" ];
      };
      "jirachi-2003-wishmkr-2" = {
        species="jirachi"; dex=385; name="Jirachi"; shiny=true; year="2003"; ot="WISHMKR"; id="20043"; region="ENG"; notes="WiSHMKR"; moves=[ "Wish" "Confusion" "Rest" ];
      };

      # »  2005-2006  «
      "mew-2005-old-sea" = {
        species="mew"; dex=151; name="Mew"; shiny=true; year="2005"; ot="JPN??"; region="JPN"; notes="Old Sea"; moves=[ "Aerobatics" "Giga Drain" "False Swipe" "Thunder Wave" ];
      };
      "articuno-2006-10aniv" = {
        species="articuno"; dex=144; name="Articuno"; year="2006"; ot="10ANIV"; id="06227"; region="ENG"; notes="10th Anniversary"; 
        moves=[ "Agility" "Mind Reader" "Ice Beam" "Reflect" ];
      };
      "celebi-2006-10aniv" = {
        species="celebi"; dex=251; name="Celebi"; year="2006"; ot="10 ANIV"; id="00010"; region="ENG"; notes="10th Anniversary"; 
        moves=[ "Ancient Power" "Giga Drain" "Baton Pass" "Future Sight" ];
      };

      # »  2009  «
      "regigigas-2009-tru" = {
        species="regigigas"; dex=480; name="Regigigas"; year="2009"; ot="TRU"; id="03089"; region="ENG"; notes="Toys 'R Us"; obtained="2020/11/20"; 
        moves=[ "Iron Head" "Rock Slide" "Icy Wind" "Crush Grip" ];
      };
      "arceus-2009-tru" = {
        species="arceus"; dex=493; name="Arceus"; year="2009"; ot="TRU"; id="11079"; region="ENG"; notes="Toys 'R Us"; proof="WC from OT"; obtained="2020/08/24"; 
        moves=[ "Judgment" "Roar of Time" "Spacial Rend" "Shadow Force" ]; tradeHistory="Omega Galaxy#2683 -> pungkula";
      };

      # »  2011  «
      "raikou-2011-gamestp" = {
        species="raikou"; dex=243; name="Raikou"; shiny=true; year="2011"; ot="GAMESTP"; id="01031"; region="ENG"; notes="GAMESTP"; proof="WC from OT"; obtained="2020/08/24";
        moves=[ "Zap Cannon" "Aura Sphere" "Extreme Speed" "Weather Ball" ]; tradeHistory="Omega Galaxy#2683 -> pungkula";
      };
      "suicune-2011-gamestp" = {
        species="suicune"; dex=245; name="Suicune"; shiny=true; year="2011"; ot="GAMESTP"; id="01311"; region="ENG"; notes="GAMESTP"; proof="WC from OT"; obtained="2020/08/24";
        moves=[ "Sheer Cold" "Hydro Pump" "Extreme Speed" "Blizzard" ]; tradeHistory="Omega Galaxy#2683 -> pungkula";
      };

      # »  2012  «
      "pikachu-2012-world12" = {
        species="pikachu"; ball = "pokeball"; dex=25; name="Pikachu"; year="2012"; ot="WORLD12"; id="08122"; region="ENG"; notes="World12"; obtained="2021/02/16"; 
        moves=[ "Fly" "Thunderbolt" "Grass Knot" "Protect" ]; tradeHistory="Deathbane98#5493 -> pungkula";
      };
      "tyranitar-2012-vgc12" = {
        species="tyranitar"; dex=248; name="Tyranitar"; shiny=true; year="2012"; ot="VGC12"; id="03032"; region="ENG"; notes="VGC12"; obtained="2020/02/16"; 
        moves=[ "Earthquake" "Crunch" "Stone Edge" "Superpower" ]; tradeHistory="Deathbane98#5493 -> pungkula";
      };
      "darkrai-2012-2012may" = {
        species="darkrai"; dex=491; name="Darkrai"; year="2012"; ot="2012MAY"; id="05092"; region="ENG"; notes="Dark Explorers"; obtained="2020/08/21"; 
        moves=[ "Dark Void" "Ominous Wind" "Feint Attack" "Nightmare" ]; tradeHistory="Alto#0457 -> pungkula";
      };
      "victini-2012-movie14" = {
        species="victini"; dex=494; name="Victini"; year="2012"; ot="Movie14"; id="12031"; region="ENG"; notes="Black and White Movie"; obtained="2020/10/06"; 
        moves=[ "V-create" "Fusion Flare" "Fusion Bolt" "Searing Shot" ]; tradeHistory="chips#8386 -> pungkula";
      };
      "zekrom-2012-spr2012-1" = {
        species="zekrom"; dex=644; name="Zekrom"; year="2012"; ot="SPR2012"; id="03102"; region="ENG"; notes="1st Anniversary"; moves=[ "Bolt Strike" "Fusion Bolt" "Haze" "Outrage" ];
      };
      "zekrom-2012-spr2012-2" = {
        species="zekrom"; dex=644; name="Zekrom"; year="2012"; ot="SPR2012"; id="03102"; region="ENG"; notes="1st Anniversary"; obtained="2021/02/16"; 
        moves=[ "Bolt Strike" "Fusion Bolt" "Haze" "Outrage" ]; tradeHistory="Deathbane98#5493 -> pungkula";
      };
      "keldeo-2012-smr2012" = {
        species="keldeo"; ball = "sherish"; dex=647; name="Keldeo"; year="2012"; ot="SMR2012"; id="08272"; region="ENG"; notes="SMR"; 
        obtained="2020/08/29"; moves=[ "Sacred Sword" "Aqua Tail" "Double Kick" "Bubble Beam" ]; tradeHistory="Waterfly#8598 -> pungkula";
      };
      "keldeo-2012-ver2012" = {
        species="keldeo"; ball = "cherish"; dex=647; name="Keldeo"; year="2012"; ot="VER2012"; id="08272"; region="SPA"; notes="VER"; 
        moves=[ "Aqua Jet" "Sacred Sword" "Double Kick" "Surf" ];
      };

      # »  2013  «
      "smeargle-2013-world13" = {
        species="smeargle"; dex=235; name="Smeargle"; year="2013"; ot="WORLD13"; id="08113"; region="ENG"; notes="VGC Ultimate Smeargle"; obtained="2020/12/26"; 
        moves=[ "False Swipe" "Spore" "Odor Sleuth" "Mean Look" ];
      };
      "dialga-2013-sum2013" = {
        species="dialga"; dex=483; name="Dialga"; shiny=true; year="2013"; ot="SUM2013"; id="08303"; region="ENG"; notes="GAMESTP"; obtained="2020/08/26"; moves=[ "Dragon Pulse" "Draco Meteor" "Aura Sphere" "Roar of Time" ]; tradeHistory="Alto#0457";
      };
      "palkia-2013-sum2013-1" = {
        species="palkia"; dex=484; name="Palkia"; shiny=true; year="2013"; ot="SUM2013"; id="09133"; region="ENG"; notes="GAME Distribution"; obtained="2020/08/26"; 
        moves=[ "Aura Sphere" "Spacial Rend" "Hydro Pump" "Draco Meteor" ]; tradeHistory="Alto#0457";
      };
      "palkia-2013-sum2013-2" = {
        species="palkia"; dex=484; name="Palkia"; shiny=true; year="2013"; ot="SUM2013"; id="09133"; region="ENG"; obtained="2021/02/16"; 
        moves=[ "Aura Sphere" "Spacial Rend" "Hydro Pump" "Draco Meteor" ]; tradeHistory="Deathbane98#5493 -> pungkula";
      };
      "giratina-2013-sum2013" = {
        species="giratina"; dex=487; name="Giratina"; shiny=true; year="2013"; ot="SUM2013"; id="09303"; region="ENG"; notes="Gamestop Distribution"; obtained="2020/10/06"; moves=[ "Dragon Pulse" "Dragon Claw" "Aura Sphere" "Shadow Force" ]; tradeHistory="chips#8386 -> pungkula";
      };
      "meloetta-2013-spr2013" = {
        species="meloetta"; dex=648; name="Meloetta"; year="2013"; ot="SPR2013"; id="03013"; region="ENG"; notes="Gamestop"; obtained="2020/08/27"; 
        moves=[ "Round" "Teeter Dance" "Psychic" "Close Combat" ]; tradeHistory="Alto#0457 -> pungkula";
      };
      "genesect-2013-jpn" = {
        species="genesect"; dex=649; name="Genesect"; shiny=true; year="2013"; ot="JPN????"; id="07133"; region="ENG"; notes="Genesect Movie Event"; 
        obtained="2020/10/06"; moves=[ "Extreme Speed" "Techno Blast" "Blaze Kick" "Shift Gear" ]; tradeHistory="chips#8386 -> pungkula";
      };

      # »  2014  «
      "vivillon-2014-gts" = {
        species="vivillon"; dex=666; name="Vivillon"; year="2014"; ot="GTS"; id="00108"; region="ENG"; notes="Fancy Pattern"; obtained="2021/03/16"; 
        moves=[ "Gust" "Light Screen" "Struggle Bug" "Hold Hands" ]; tradeHistory="GoroMajimaIsMyIdol#8508 > pungkula";
      };
      "vivillon-2014-sum2014" = {
        species="vivillon"; dex=666; name="Vivillon"; year="2014"; ot="SUM2014"; id="08064"; region="ENG"; notes="Pokeball Pattern"; obtained="2021/03/16"; 
        moves=[ "Stun Spore" "Gust" "Light Screen" "Struggle Bug" ]; tradeHistory="GoroMajimaIsMyIdol#8508 > pungkula";
      };

      # »  2015  «
      "rayquaza-2015-galileo" = {
        species="rayquaza"; dex=384; name="Rayquaza"; shiny=true; year="2015"; ot="Galileo"; id="08055"; region="ENG"; notes="Ancient Origins Galileo"; 
        obtained="2021/02/07"; moves=[ "Dragon Pulse" "Extreme Speed" "Hyper Voice" "Dragon Ascent" ];
      };
      "jirachi-2015-nintendo-hk" = {
        species="jirachi"; dex=385; name="Jirachi"; shiny=true; year="2015"; ot="Nintendo HK"; id="12015"; region="SPA"; notes="Nintendo HK"; 
        moves=[ "Wish" "Confusion" "Swift" "Happy Hour" ];
      };
      "diancie-2015-jpn" = {
        species="diancie"; dex=719; name="Diancie"; shiny=true; year="2015"; ot="JPN???"; id="12125"; region="ENG"; notes="Mega Evolution Promo"; obtained="2020/10/06"; 
        moves=[ "Diamond Storm" "Moonblast" "Reflect" "Return" ]; tradeHistory="chips#8386 -> pungkula";
      };

      # »  2016  «
      "mewtwo-2016-play-2016" = {
        species="mewtwo"; dex=150; name="Mewtwo"; shiny=true; year="2016"; ot="Play! 2016"; id="07266"; region="ENG"; notes="Play!"; obtained="2020/08/25"; 
        moves=[ "Psystrike" "Psychic" "Recover" "Aura Sphere" ]; tradeHistory="Jaro#6218 -> pungkula";
      };
      "ho-oh-2016-pc-kyoto" = {
        species="ho-oh"; dex=250; name="Ho-Oh"; shiny=true; year="2016"; ot="PCキョウト"; id="03166"; region="ENG"; obtained="2021/02/16"; 
        moves=[ "Sacred Fire" "Brave Bird" "Recover" "Celebrate" ]; tradeHistory="doodle pie#5495 > pungkula";
      };
      "celebi-2016-gf" = {
        species="celebi"; dex=251; name="Celebi"; year="2016"; ot="GF"; id="03016"; region="ENG"; notes="20th Anniversary"; 
        moves=[ "Confusion" "Recover" "Heal Bell" "Safeguard" ];
      };
      "manaphy-2016-gf" = {
        species="manaphy"; dex=490; name="Manaphy"; year="2016"; ot="GF"; id="06016"; region="ENG"; notes="20th Anniversary"; obtained="2020/10/10"; moves=[ "Tail Glow" "Bubble" "Water Sport" ]; tradeHistory="SoulChameleon#5664 -> pungkula";
      };
      "darkrai-2016-gf" = {
        species="darkrai"; dex=491; name="Darkrai"; year="2016"; ot="GF"; id="05016"; region="ENG"; notes="GF"; obtained="2021/02/09"; 
        moves=[ "Dark Void" "Ominous Wind" "Nightmare" "Feint Attack" ]; tradeHistory="Bees’that-ramble#0728 > pungkula";
      };
      "yveltal-2016-xyz" = {
        species="yveltal"; dex=717; name="Yveltal"; shiny=true; year="2016"; ot="XYZ"; id="05206"; region="ENG"; notes="Pokémon Fates Collide XYZ"; 
        obtained="2021/02/05"; moves=[ "Oblivion Wing" "Sucker Punch" "Dark Pulse" "Foul Play" ];
      };
      "greninja-2016-ash" = {
        species="greninja"; dex=658; name="Greninja"; year="2016"; ot="Ash"; id="131017"; region="ENG"; notes="Ash's Greninja"; obtained="2020/10/28"; 
        moves=[ "Water Shuriken" "Aerial Ace" "Double Team" "Night Slash" ]; tradeHistory="seret42#0924 -> pungkula";
      };
      "volcanion-2016-nebel" = {
        species="volcanion"; dex=721; name="Volcanion"; year="2016"; ot="Nebel"; id="11036"; region="ENG"; notes="Volcanion & Mechanical Marvel"; 
        obtained="2020/10/28"; moves=[ "Steam Eruption" "Overheat" "Hydro Pump" "Mist" ]; tradeHistory="seret42#0924 -> pungkula";
      };
      "hoopa-2016-alexander" = {
        species="hoopa"; dex=720; name="Hoopa"; year="2016"; ot="Alexander"; id="10036"; region="ENG"; proof="WC from OT"; obtained="2021/02/19"; 
        moves=[ "Hyperspace Hole" "Psychic" "Astonish" "Nasty Plot" ]; tradeHistory="kaeluxx#5799 -> pungkula";
      };
      "magearna-2016-kano" = {
        species="magearna"; dex=801; name="Magearna"; year="2016"; ot="Kano"; id="890324"; region="ENG"; notes="Code Distribution"; obtained="2020/08/19"; 
        moves=[ "Fleur Cannon" "Flash Cannon" "Crafty Shield" "Helping Hand" ];
      };
      "xerneas-2016-xyz" = {
        species="xerneas"; dex=716; name="Xerneas"; shiny=true; year="2016"; ot="XYZ"; id="05116"; region="ENG"; obtained="2021/03/15"; 
        moves=[ "Geomancy" "Moonblast" "Aromatherapy" "Focus Blast" ]; tradeHistory="Protest#2763 -> pungkula";
      };

      # »  2017  «
      "pikachu-2017-unova-cap" = {
        species="pikachu"; dex=25; name="Pikachu"; year="2017"; ot="サトシ"; id="100923"; region="ENG"; notes="Unova Cap";
      };
      "pikachu-2017-kalos-cap" = {
        species="pikachu"; dex=25; name="Pikachu"; year="2017"; ot="Ash"; id="120516"; region="ENG"; notes="Kalos Cap";
      };
      "pikachu-2017-alola-cap" = {
        species="pikachu"; dex=25; name="Pikachu"; year="2017"; ot="サトシ"; id="161117"; region="JPN"; notes="Alola Cap";
      };
      "pikachu-2017-partner-cap-ger" = {
        species="pikachu"; dex=25; name="Pikachu"; year="2017"; ot="Ash"; id="170715"; region="GER"; notes="Partner Cap";
      };
      "pikachu-2017-partner-cap-eng" = {
        species="pikachu"; dex=25; name="Pikachu"; year="2017"; ot="Ash"; id="170715"; region="ENG"; notes="Partner Cap";
      };
      "silvally-2017-aether" = {
        species="silvally"; dex=773; name="Silvally"; shiny=true; year="2017"; ot="Aether"; id="102317"; region="ENG"; notes="Aether"; obtained="2020/09/04"; 
        moves=[ "Multi-Attack" "Parting Shot" "Swift" "Scary Face" ]; tradeHistory="HeadPool#0836 -> pungkula";
      };
      "marshadow-2017-mt-tensei-1" = {
        species="marshadow"; dex=802; name="Marshadow"; year="2017"; ot="MT. Tensei"; id="100917"; region="ENG"; moves=[ "Spectral Thief" "Close Combat" "Shadow Sneak" "Throat Chop" ];
      };
      "marshadow-2017-mt-tensei-2" = {
        species="marshadow"; dex=802; name="Marshadow"; year="2017"; ot="MT. Tensei"; id="100917"; region="ENG"; moves=[ "Spectral Thief" "Close Combat" "Force Palm" "Shadow Ball" ];
      };
      "exeggutor-alola-2017-worlds17" = {
        species="exeggutor-alola"; dex=103; name="Exeggutor (Alola)"; year="2017"; ot="Worlds17"; id="081817"; region="ENG"; notes="World 2017"; proof="Video"; 
        obtained="2021/03/01"; moves=[ "Power Swap" "Celebrate" "Leaf Storm" "Draco Meteor" ]; tradeHistory="SIT0#7561 > pungkula";
      };

      # »  2018  «
      "pikachu-2018-original-cap" = {
        species="pikachu"; dex=25; name="Pikachu"; year="2018"; ot="Satoshi"; id="970401"; region="ENG"; notes="Original Cap";
      };
      "pikachu-2018-sinnoh-cap" = {
        species="pikachu"; dex=25; name="Pikachu"; year="2018"; ot="Ash"; id="060407"; region="ENG"; notes="Sinnoh Cap";
      };
      "raichu-alola-2018" = {
        species="raichu-alola"; dex=26; name="Raichu (Alola)"; shiny=true; year="2018"; ot="JPN??"; id="337500"; region="ENG"; notes="Evolved Alola Pika"; 
        obtained="2020/10/06"; moves=[ "Thunder" "Expanding Force" "Volt Switch" "Rising Voltage" ]; tradeHistory="Steez#0420 -> pungkula";
      };
      "zygarde-2018-legends" = {
        species="zygarde"; dex=718; name="Zygarde"; shiny=true; year="2018"; region="ENG"; notes="2018 Legends"; obtained="2021/03/09";
      };
      "shaymin-2018-jpn" = {
        species="shaymin"; dex=492; name="Shaymin"; year="2018"; ot="JPN???"; id="180425"; region="ENG"; notes="20th Anniversary"; obtained="2020/10/06"; 
        moves=[ "Energy Ball" "Sweet Kiss" "Healing Wish" "Seed Flare" ]; tradeHistory="chips#8386 -> pungkula";
      };
      "tapu-lele-2018-akala" = {
        species="tapu-lele"; dex=786; name="Tapu Lele"; shiny=true; year="2018"; ot="Akala"; id="181130"; region="ENG"; obtained="2021/02/22"; 
        moves=[ "Magic Room" "Dazzling Gleam" "Nature's Madness" "Psychic" ]; tradeHistory="Protest#2763 -> pungkula";
      };

      # »  2019  «
      "solgaleo-2019-eclipse" = {
        species="solgaleo"; dex=791; name="Solgaleo"; shiny=true; year="2019"; ot="Eclipse"; id="100419"; region="ENG"; notes="Gamestop Eclipse"; obtained="2020/08/16"; 
        moves=[ "Sunsteel Strike" "Zen Headbutt" "Noble Roar" "Morning Sun" ];
      };
      "lunala-2019-eclipse" = {
        species="lunala"; dex=792; name="Lunala"; shiny=true; year="2019"; ot="Eclipse"; id="100419"; region="ENG"; notes="Gamestop Eclipse"; obtained="2020/08/25"; 
        moves=[ "Moongeist Beam" "Psyshock" "Moonblast" "Moonlight" ]; tradeHistory="Jaro#6218 -> pungkula";
      };
      "zeraora-2019-fula-city" = {
        species="zeraora"; dex=807; name="Zeraora"; selfObtained=true; year="2019"; ot="Fula City"; id="100118"; region="ENG"; notes="EB Games Distribution"; 
        moves=[ "Plasma Fists" "Thunder Punch" "Close Combat" "Thunder" ];
      };
      "tapu-fini-2019-poni" = {
        species="tapu-fini"; dex=788; name="Tapu Fini"; shiny=true; year="2019"; ot="Poni"; id="190524"; region="ENG"; notes="International Challenge May"; 
        obtained="2021/02/07"; moves=[ "Hydro Pump" "Ice Beam" "Moonblast" "Calm Mind" ]; tradeHistory="PicEm09#4880 -> pungkula";
      };
      "tapu-koko-2019-melemele" = {
        species="tapu-koko"; dex=785; name="Tapu Koko"; shiny=true; year="2019"; ot="Melemele"; id="191004"; region="ENG"; obtained="2021/02/20"; 
        moves=[ "Thunderbolt" "Dazzling Gleam" "Volt Switch" "Nature's Madness" ]; tradeHistory="Protest#2763 -> pungkula";
      };
      "tapu-koko-2019-ulaula" = {
        species="tapu-koko"; dex=785; name="Tapu Koko"; shiny=true; year="2019"; ot="Ula'ula"; id="190222"; region="ENG"; obtained="2021/02/24"; 
        moves=[ "Nature's Madness" "Zen Headbutt" "Megahorn" "Skull Bash" ]; tradeHistory="Protest#2763 -> pungkula";
      };

      # »  2020  «
      "pikachu-2020-original-cap" = {
        species="pikachu"; dex=25; name="Pikachu"; selfObtained=true; year="2020"; ot="Ash"; id="201023"; region="ENG"; notes="Original Cap"; proof="WC"; obtained="2020/09/26";
      };
      "pikachu-2020-partner-cap" = {
        species="pikachu"; dex=25; name="Pikachu"; selfObtained=true; year="2020"; ot="Ash"; id="201023"; region="ENG"; notes="Partner Cap"; proof="WC"; obtained="2020/09/29";
      };
      "pikachu-2020-hoenn-cap" = {
        species="pikachu"; dex=25; name="Pikachu"; selfObtained=true; year="2020"; ot="Ash"; id="201023"; region="ENG"; notes="Hoenn Cap"; proof="WC"; obtained="2020/10/02";
      };
      "pikachu-2020-sinnoh-cap" = {
        species="pikachu"; dex=25; name="Pikachu"; selfObtained=true; year="2020"; ot="Ash"; id="201023"; region="ENG"; notes="Sinnoh Cap"; proof="WC"; obtained="2020/10/09";
      };
      "pikachu-2020-unova-cap" = {
        species="pikachu"; dex=25; name="Pikachu"; selfObtained=true; year="2020"; ot="Ash"; id="201023"; region="ENG"; notes="Unova Cap: October 16"; proof="WC";
      };
      "pikachu-2020-kalos-cap" = {
        species="pikachu"; dex=25; name="Pikachu"; selfObtained=true; year="2020"; ot="Ash"; id="201023"; region="ENG"; notes="Kalos Cap: October 18"; proof="WC";
      };
      "pikachu-2020-alola-cap" = {
        species="pikachu"; dex=25; name="Pikachu"; selfObtained=true; year="2020"; ot="Ash"; id="201023"; region="ENG"; notes="Alola Cap: October 23"; proof="WC";
      };
      "pikachu-2020-world-cap" = {
        species="pikachu"; dex=25; name="Pikachu"; selfObtained=true; year="2020"; ot="Ash"; id="201023"; region="ENG"; notes="World Cap: October 30"; proof="WC";
      };
      "meowth-galar-2020" = {
        species="meowth-galar"; dex=52; name="Meowth (Galar)"; selfObtained=true; year="2020"; ot="pungkula"; id="082409"; region="ENG"; notes="Sword & Shield"; proof="WC"; 
        moves=[ "Fake Out" "Growl" "Hone Claws" "Pay Day" ];
      };
      "ponyta-galar-2020" = {
        species="ponyta-galar"; dex=77; name="Ponyta (Galar)"; year="2020"; ot="PasDer"; id="705133"; region="ENG"; notes="Sword & Shield"; obtained="2020/08/26"; 
        moves=[ "Tackle" "Growl" "Confusion" "Fairy Wind" ]; tradeHistory="PasDer#4937";
      };
      "mr-mime-galar-2020" = {
        species="mr-mime-galar"; dex=122; name="Mr. Mime (Galar)"; selfObtained=true; year="2020"; ot="pungkula"; id="082409"; region="ENG"; notes="Sword & Shield"; 
        proof="WC"; moves=[ "Copycat" "Encore" "Ice Shard" "Confusion" ];
      };
      "corsola-galar-2020" = {
        species="corsola-galar"; dex=222; name="Corsola (Galar)"; selfObtained=true; year="2020"; ot="pungkula"; id="082409"; region="ENG"; notes="Sword & Shield"; 
        proof="WC"; moves=[ "Tackle" "Astonish" "Disable" "Spite" ];
      };
      "porygon2-2020" = {
        species="porygon2"; dex=233; name="Porygon2"; selfObtained=true; year="2020"; ot="pungkula"; id="082409"; region="ENG"; notes="Players Cup Gift"; proof="WC"; 
        moves=[ "Recover" "Trick Room" "Ice Beam" "Thunderbolt" ];
      };
      "celebi-2020-coco" = {
        species="celebi"; dex=251; name="Celebi"; shiny=true; year="2020"; ot="JPN"; id="200807"; region="JPN"; notes="Pokémon Movie Coco"; obtained="2020/08/21"; 
        moves=[ "Magical Leaf" "Future Sight" "Life Dew" "Heal Bell" ];
      };
      "gastrodon-2020-japan-championships" = {
        species="gastrodon"; dex=423; name="Gastrodon"; selfObtained=true; year="2020"; ot="JPN???"; id="200822"; region="JPN"; notes="Japan Championships"; 
        proof="WC"; obtained="2020/08/22"; moves=[ "Protect" "Surf" "Ice Beam" "Earth Power" ];
      };
      "amoonguss-2020-baik-jongyoon" = {
        species="amoonguss"; dex=591; name="Amoonguss"; shiny=true; year="2020"; ot="JPN???"; id="200809"; region="KOR"; notes="Baik Jongyoon's"; 
        moves=[ "Clear Smog" "Spore" "Protect" "Rage Powder" ];
      };
      "zeraora-2020-home-1" = {
        species="zeraora"; dex=807; name="Zeraora"; shiny=true; selfObtained=true; year="2020"; ot="HOME"; id="200630"; region="ENG"; notes="Max Raid Battle Gift"; 
        proof="Picture"; obtained="2020/06/30"; moves=[ "Plasma Fists" "Close Combat" "Blaze Kick" "Outrage" ];
      };
      "zeraora-2020-home-2" = {
        species="zeraora"; dex=807; name="Zeraora"; shiny=true; year="2020"; ot="HOME"; id="200630"; region="ENG"; notes="Max Raid Battle Gift"; 
        moves=[ "Plasma Fists" "Close Combat" "Blaze Kick" "Outrage" ];
      };
      "zarude-2020-jungle-1" = {
        species="zarude"; dex=893; name="Zarude"; year="2020"; ot="Jungle"; id="200807"; region="ENG"; notes="Pokémon Movie Coco"; obtained="2020/09/26"; 
        moves=[ "Close Combat" "Power Whip" "Swagger" "Snarl" ];
      };
      "zarude-2020-jungle-2" = {
        species="zarude"; dex=893; name="Zarude"; selfObtained=true; year="2020"; ot="Jungle"; id="2001113"; region="ENG"; notes="Coco Movie NL Distribution"; 
        proof="WC"; obtained="2020/11/24"; moves=[ "Close Combat" "Power Whip" "Swagger" "Snarl" ];
      };
      "zarude-dada-2020-coco" = {
        species="zarude-dada"; dex=893; name="Zarude (Dada)"; year="2020"; ot="JPN???"; id="201225"; region="JPN"; notes="Pokémon Movie Coco"; obtained="2020/12/25"; 
        moves=[ "Jungle Healing" "Hammer Arm" "Power Whip" "Energy Ball" ];
      };
      "melmetal-gmax-2020-home" = {
        species="melmetal-gmax"; dex=809; name="Melmetal (GMax)"; selfObtained=true; year="2020"; ot="HOME"; id="808809"; region="ENG"; notes="PoGO Transfer"; 
        proof="Picture"; obtained="2020/11/19"; moves=[ "Double Iron Bash" "Hyper Beam" "Dynamic Punch" "Thunder Punch" ];
      };

      # »  2021  «
      "pikachu-2021-kibo" = {
        species="pikachu"; dex=25; name="Pikachu"; selfObtained=true; year="2021"; ot="KIBO"; id="210101"; region="ENG"; notes="Space Sunrise Gift"; 
        proof="WC"; obtained="2021/01/05"; moves=[ "Thunderbolt" "Swift" "Wish" "Celebrate" ];
      };
      "magearna-2021-pungkula" = {
        species="magearna"; dex=801; name="Magearna"; selfObtained=true; year="2021"; ot="Pungkula"; id="585967"; region="ENG"; notes="National Pokédex Completion"; 
        proof="Picture"; obtained="2021/01/05"; moves=[ "Fleur Cannon" "Flash Cannon" "Defense Curl" "Rest" ];
      };
      "pikachu-2021-gf-1" = {
        species="pikachu"; ball = "pokeball"; dex=25; name="Pikachu"; selfObtained=true; year="2021"; ot="GF"; id="210227"; region="ENG"; proof="Video + WC"; 
        obtained="2021/02/25"; moves=[ "Sing" "Encore" "Celebrate" "Electro Ball" ];
      };
      "pikachu-2021-gf-2" = {
        species="pikachu"; dex=25; name="Pikachu"; selfObtained=true; year="2021"; ot="GF"; id="210227"; region="ENG"; proof="Video + WC"; obtained="2021/02/25"; 
        moves=[ "Sing" "Encore" "Celebrate" "Electro Ball" ];
      };
      "melmetal-gmax-2021-home" = {
        species="melmetal-gmax"; dex=809; name="Melmetal (GMax)"; selfObtained=true; year="2021"; ot="HOME"; id="808809"; region="ENG"; notes="PoGO Transfer"; 
        proof="Picture"; obtained="2021/04/06"; moves=[ "Double Iron Bash" "Hyper Beam" "Dynamic Punch" "Thunder Punch" ];
      };
      "toxtricity-2021-rock-star" = {
        species="toxtricity"; dex=849; name="Toxtricity"; shiny=true; selfObtained=true; year="2021"; ot="Rock Star"; id="210219"; region="ENG"; notes="Shining Fates Tie-In"; 
        proof="WC + code"; obtained="2021/02/20"; moves=[ "Overdrive" "Sludge Wave" "Boomburst" "Rising Voltage" ];
      };
      "bulbasaur-2021-home-june" = {
        species="bulbasaur"; dex=1; name="Bulbasaur"; selfObtained=true; year="2021"; ot="HOME"; id="210601"; region="ENG"; notes="HOME June Update Gift"; 
        proof="WC"; obtained="2021/06/17";
      };
      "ivysaur-2021-home-june" = {
        species="ivysaur"; dex=2; name="Ivysaur"; selfObtained=true; year="2021"; ot="HOME"; id="210601"; region="ENG"; notes="HOME June Update Gift"; obtained="2021/06/17";
      };
      "venusaur-2021-home-june" = {
        species="venusaur"; dex=3; name="Venusaur"; selfObtained=true; year="2021"; ot="HOME"; id="210601"; region="ENG"; notes="HOME June Update Gift"; obtained="2021/06/17";
      };
      "squirtle-2021-home-june" = {
        species="squirtle"; dex=7; name="Squirtle"; selfObtained=true; year="2021"; ot="HOME"; id="210601"; region="ENG"; notes="HOME June Update Gift"; proof="WC"; obtained="2021/06/17";
      };
      "wartortle-2021-home-june" = {
        species="wartortle"; dex=8; name="Wartortle"; selfObtained=true; year="2021"; ot="HOME"; id="210601"; region="ENG"; notes="HOME June Update Gift"; obtained="2021/06/17";
      };
      "blastoise-2021-home-june" = {
        species="blastoise"; dex=9; name="Blastoise"; selfObtained=true; year="2021"; ot="HOME"; id="210601"; region="ENG"; notes="HOME June Update Gift"; obtained="2021/06/17";
      };
      "bulbasaur-2021-home-june-2" = {
        species="bulbasaur"; dex=1; name="Bulbasaur"; selfObtained=true; year="2021"; ot="HOME"; id="210601"; region="ENG"; notes="HOME June Update Gift"; 
        proof="WC"; obtained="2021/06/17";
      };
      "squirtle-2021-home-june-2" = {
        species="squirtle"; dex=7; name="Squirtle"; selfObtained=true; year="2021"; ot="HOME"; id="210601"; region="ENG"; notes="HOME June Update Gift"; proof="WC"; obtained="2021/06/17";
      };
      "bulbasaur-2021-home-june-3" = {
        species="bulbasaur"; dex=1; name="Bulbasaur"; selfObtained=true; year="2021"; ot="HOME"; id="210601"; region="ENG"; notes="HOME June Update Gift"; obtained="2021/06/17";
      };
      "squirtle-2021-home-june-3" = {
        species="squirtle"; dex=7; name="Squirtle"; selfObtained=true; year="2021"; ot="HOME"; id="210601"; region="ENG"; notes="HOME June Update Gift"; obtained="2021/06/17";
      };
      "torkoal-2021-japan-championships-1" = {
        species="torkoal"; dex=324; name="Torkoal"; selfObtained=true; year="2021"; ot="クララ"; id="210718"; region="JPN"; notes="Japan Championships 2021"; 
        proof="Video"; obtained="2021/07/18"; moves=[ "Burning Jealousy" "Body Press" "Yawn" "Protect" ];
      };
      "torkoal-2021-japan-championships-2" = {
        species="torkoal"; dex=324; name="Torkoal"; selfObtained=true; year="2021"; ot="クララ"; id="210718"; region="JPN"; notes="Japan Championships 2021"; 
        proof="WC"; obtained="2021/07/18"; moves=[ "Burning Jealousy" "Body Press" "Yawn" "Protect" ];
      };
      "torkoal-2021-japan-championships-3" = {
        species="torkoal"; dex=324; name="Torkoal"; selfObtained=true; year="2021"; ot="クララ"; id="210718"; region="JPN"; notes="Japan Championships 2021"; 
        proof="WC"; obtained="2021/07/18"; moves=[ "Burning Jealousy" "Body Press" "Yawn" "Protect" ];
      };
      "porygon-z-2021-jeong-1" = {
        species="porygon-z"; dex=474; name="Porygon-Z"; selfObtained=true; year="2021"; ot="정상윤"; id="210807"; region="KOR"; 
        notes="Jeong Sang-yoon's Porygon-Z"; proof="WC"; obtained="2021/08/21"; moves=[ "Hyper Beam" "Thunderbolt" "Dark Pulse" "Nasty Plot" ];
      };
      "porygon-z-2021-jeong-2" = {
        species="porygon-z"; dex=474; name="Porygon-Z"; selfObtained=true; year="2021"; ot="정상윤"; id="210807"; region="KOR"; 
        notes="Jeong Sang-yoon's Porygon-Z"; proof="WC"; obtained="2021/08/21"; moves=[ "Hyper Beam" "Thunderbolt" "Dark Pulse" "Nasty Plot" ];
      };
      "porygon-z-2021-jeong-3" = {
        species="porygon-z"; dex=474; name="Porygon-Z"; selfObtained=true; year="2021"; ot="정상윤"; id="210807"; region="KOR"; 
        notes="Jeong Sang-yoon's Porygon-Z"; proof="WC"; obtained="2021/08/21"; moves=[ "Hyper Beam" "Thunderbolt" "Dark Pulse" "Nasty Plot" ];
      };
      "coalossal-2021-wolfe" = {
        species="coalossal"; dex=839; name="Coalossal"; year="2021"; notes="wolfe"; proof="WC"; obtained="2021/09/03"; tradeHistory="Popski'#5621 > pungkula";
      };
      "hoopa-2021-pogo" = {
        species="hoopa"; dex=720; name="Hoopa"; selfObtained=true; year="2021"; notes="PoGo - Hoopa's Arrival"; obtained="2021/09/05";
      };
      "hoopa-unbound-2021-pogo" = {
        species="hoopa-unbound"; dex=720; name="Hoopa (Unbound)"; selfObtained=true; year="2021"; notes="PoGo - Hoopa's Arrival"; obtained="2021/09/05";
      };
      "zacian-2021-shiny" = {
        species="zacian"; dex=888; name="Zacian"; shiny=true; selfObtained=true; year="2021"; proof="WC"; obtained="2021/10/23";
      };
      "zamazenta-2021-shiny" = {
        species="zamazenta"; dex=889; name="Zamazenta"; shiny=true; selfObtained=true; year="2021"; proof="WC"; obtained="2021/10/23";
      };
      "charizard-2021-leonardo" = {
        species="charizard"; dex=6; name="Charizard"; year="2021"; ot="Leonardo"; id="211031"; region="ITA"; obtained="2021/11/07"; 
        moves=[ "Heat Wave" "Blast Burn" "Hurricane" "Protect" ]; tradeHistory="Kira > pungkula";
      };

      # »  2022  «
      "articuno-galar-2022-crown" = {
        species="articuno-galar"; dex=144; name="Articuno (Galar)"; shiny=true; selfObtained=true; year="2022"; ot="Crown"; id="220218"; region="ENG"; proof="WC"; 
        obtained="2022/02/22"; moves=[ "Freezing Glare" "Hurricane" "Psycho Cut" "Psycho Shift" ];
      };
      "zapdos-galar-2022-wild" = {
        species="zapdos-galar"; dex=145; name="Zapdos (Galar)"; shiny=true; selfObtained=true; year="2022"; ot="Wild"; id="220311"; region="ENG"; proof="WC"; 
        obtained="2022/03/14"; moves=[ "Thunderous Kick" "Drill Peck" "Reversal" "Focus Energy" ];
      };
      "moltres-galar-2022-armor" = {
        species="moltres-galar"; dex=146; name="Moltres (Galar)"; shiny=true; selfObtained=true; year="2022"; ot="Armor"; id="220415"; region="ENG"; proof="WC"; 
        obtained="2022/04/20"; moves=[ "Fiery Wrath" "Hurricane" "Sucker Punch" "Nasty Plot" ];
      };
      "dracovish-2022" = {
        species="dracovish"; dex=882; name="Dracovish"; selfObtained=true; year="2022"; id="210108"; region="JPN"; proof="WC"; obtained="2022/08/13"; 
        moves=[ "Fishious Rend" "Dragon Rush" "Ice Fang" "Water Gun" ];
      };
      "victini-2022-victory-1" = {
        species="victini"; dex=494; name="Victini"; selfObtained=true; year="2022"; ot="Victory"; id="220818"; region="ENG"; proof="WC"; obtained="2022/08/18"; 
        moves=[ "V-create" "Zen Headbutt" "Work Up" "Flame Charge" ];
      };
      "victini-2022-victory-2" = {
        species="victini"; dex=494; name="Victini"; selfObtained=true; year="2022"; ot="Victory"; id="220818"; region="ENG"; proof="WC"; obtained="2022/08/21"; 
        moves=[ "V-create" "Zen Headbutt" "Work Up" "Flame Charge" ]; tradeHistory="troll7 account";
      };
      "victini-2022-victory-3" = {
        species="victini"; dex=494; name="Victini"; selfObtained=true; year="2022"; ot="Victory"; id="220818"; region="ENG"; proof="WC"; obtained="2022/08/21"; 
        moves=[ "V-create" "Zen Headbutt" "Work Up" "Flame Charge" ]; tradeHistory="2nd switch 996385";
      };
      "sinistea-2022-wc22-eng" = {
        species="sinistea"; dex=854; name="Sinistea"; year="2022"; ot="WC22"; id="220818"; region="ENG"; obtained="2022/08/22"; moves=[ "Memento" "Metronome" "Aromatherapy" "Celebrate" ];
      };
      "sinistea-2022-wc22-cht" = {
        species="sinistea"; dex=854; name="Sinistea"; year="2022"; ot="W C S 2 2"; id="220818"; region="CHT"; obtained="2022/08/22"; 
        moves=[ "Memento" "Metronome" "Aromatherapy" "Celebrate" ];
      };
      "jirachi-2022-jpn" = {
        species="jirachi"; dex=385; name="Jirachi"; year="2022"; id="030719"; region="JPN"; obtained="2022/08/22"; moves=[ "Meteor Mash" "Psychic" "Rest" "Wish" ];
      };
      "dragonite-2022-jpn-1" = {
        species="dragonite"; dex=149; name="Dragonite"; selfObtained=true; year="2022"; id="200126"; region="JPN"; proof="WC"; obtained="2022/08/26"; 
        moves=[ "Dragon Claw" "Draco Meteor" "Hurricane" "Dragon Dance" ];
      };
      "dragonite-2022-jpn-2" = {
        species="dragonite"; dex=149; name="Dragonite"; selfObtained=true; year="2022"; id="200126"; region="JPN"; proof="WC"; obtained="2022/08/26"; 
        moves=[ "Dragon Claw" "Draco Meteor" "Hurricane" "Dragon Dance" ]; tradeHistory="517650 acc";
      };
      "gengar-gmax-2022-jpn-1" = {
        species="gengar-gmax"; dex=94; name="Gengar (GMax)"; selfObtained=true; year="2022"; id="200308"; region="JPN"; proof="WC"; obtained="2022/09/02"; 
        moves=[ "Shadow Ball" "Sludge Bomb" "Dazzling Gleam" "Will-O-Wisp" ]; tradeHistory="996365 acc";
      };
      "gengar-gmax-2022-jpn-2" = {
        species="gengar-gmax"; dex=94; name="Gengar (GMax)"; selfObtained=true; year="2022"; id="200308"; region="JPN"; proof="WC"; obtained="2022/09/02"; 
        moves=[ "Shadow Ball" "Sludge Bomb" "Dazzling Gleam" "Will-O-Wisp" ]; tradeHistory="082409 acc";
      };
      "sirfetchd-2022-jpn-1" = {
        species="sirfetchd"; dex=865; name="Sirfetch'd"; selfObtained=true; year="2022"; id="200705"; region="JPN"; proof="WC"; obtained="2022/09/09"; 
        moves=[ "Meteor Assault" "Brutal Swing" "Fury Cutter" "Detect" ]; tradeHistory="082409 acc";
      };
      "sirfetchd-2022-jpn-2" = {
        species="sirfetchd"; dex=865; name="Sirfetch'd"; selfObtained=true; year="2022"; id="200705"; region="JPN"; proof="WC"; obtained="2022/09/09"; 
        moves=[ "Meteor Assault" "Brutal Swing" "Fury Cutter" "Detect" ]; tradeHistory="996385 acc";
      };
      "marshadow-2022-mythical22" = {
        species="marshadow"; dex=802; name="Marshadow"; selfObtained=true; year="2022"; ot="Mythical22"; id="220909"; region="ENG"; proof="WC + Code Card"; 
        obtained="2022/09/14"; moves=[ "Spectral Thief" "Drain Punch" "Force Palm" "Shadow Sneak" ]; tradeHistory="082409 acc";
      };
      "genesect-2022-mythical22" = {
        species="genesect"; dex=649; name="Genesect"; selfObtained=true; year="2022"; ot="Mythical22"; id="220909"; region="ENG"; proof="WC + Code Card"; 
        obtained="2022/09/14"; moves=[ "Techno Blast" "X-Scissor" "Metal Claw" "Fell Stinger" ]; tradeHistory="082409 acc";
      };
      "volcanion-2022-mythical22" = {
        species="volcanion"; dex=721; name="Volcanion"; selfObtained=true; year="2022"; ot="Mythical22"; id="220909"; region="ENG"; proof="WC + Code Card"; 
        obtained="2022/09/14"; moves=[ "Steam Eruption" "Flare Blitz" "Incinerate" "Haze" ]; tradeHistory="082409 acc";
      };
      "lucario-2022-jpn-1" = {
        species="lucario"; dex=448; name="Lucario"; selfObtained=true; year="2022"; id="200412"; region="JPN"; proof="WC"; obtained="2022/09/17"; 
        moves=[ "Aura Sphere" "Bullet Punch" "Reversal" "Steel Beam" ]; tradeHistory="996385 acc";
      };
      "eternatus-2022-galar" = {
        species="eternatus"; dex=890; name="Eternatus"; shiny=true; selfObtained=true; year="2022"; ot="Galar"; id="221118"; region="ENG"; 
        proof="WC + Code Card"; obtained="2022/09/20"; moves=[ "Eternabeam" "Dynamax Cannon" "Sludge Bomb" "Flamethrower" ]; tradeHistory="082409 acc";
      };
      "lucario-2022-jpn-2" = {
        species="lucario"; dex=448; name="Lucario"; selfObtained=true; year="2022"; id="200412"; region="JPN"; proof="WC"; obtained="2022/09/20"; 
        moves=[ "Aura Sphere" "Bullet Punch" "Reversal" "Steel Beam" ]; tradeHistory="082409 acc";
      };
      "poipole-ultra" = {
        species="poipole"; dex=803; name="Poipole"; shiny=true; year=""; ot="Ultra"; id="091718"; region="ENG"; proof="HC"; obtained="2022/10/22"; 
        moves=[ "Venom Drench" "Nasty Plot" "Poison Jab" "Dragon Pulse" ]; tradeHistory="Striker#0962 > pungkula";
      };
      "jirachi-nintendo-hk-2" = {
        species="jirachi"; dex=385; name="Jirachi"; shiny=true; ot="Nintendo HK"; id="12015"; region="ENG"; obtained="2022/10/22"; 
        moves=[ "Wish" "Confusion" "Swift" "Happy Hour" ]; tradeHistory="Striker#0962 > pungkula";
      };
      "raikou-win2011" = {
        species="raikou"; dex=243; name="Raikou"; shiny=true; ot="WIN2011"; id="02071"; region="ENG"; obtained="2022/10/22"; 
        moves=[ "Thunderbolt" "Aura Sphere" "Extreme Speed" "Weather Ball" ]; tradeHistory="Striker#0962 > pungkula";
      };
      "lechonk-2022" = {
        species="lechonk"; dex=915; name="Lechonk";
      };

      # »  2023  «
      "bronzong-2023" = {
        species="bronzong"; dex=437; name="Bronzong"; selfObtained=true; year="2023"; id="230610"; region="JPN"; notes="Yasuharu Shimizu's Bronzong"; proof="WC"; 
        obtained="2023/06/10"; moves=[ "Body Press" "Iron Defense" "Protect" "Trick Room" ];
      };
      "gastrodon-2023-kor-1" = {
        species="gastrodon"; dex=423; name="Gastrodon"; selfObtained=true; year="2023"; id="230603"; region="KOR"; proof="WC"; obtained="2023/06/17"; 
        moves=[ "Earth Power" "Ice Beam" "Yawn" "Protect" ];
      };
      "gastrodon-2023-kor-2" = {
        species="gastrodon"; dex=423; name="Gastrodon"; selfObtained=true; year="2023"; id="230603"; region="KOR"; proof="WC"; obtained="2023/06/17"; 
        moves=[ "Earth Power" "Ice Beam" "Yawn" "Protect" ];
      };
      "charizard-2023-dark-tera-1" = {
        species="charizard"; dex=6; name="Charizard"; selfObtained=true; year="2023"; notes="Dark Tera Type"; proof="WC"; obtained="2023/07/23"; 
        moves=[ "Crunch" "Flare Blitz" "Acrobatics" "Belly Drum" ];
      };
      "charizard-2023-dark-tera-2" = {
        species="charizard"; dex=6; name="Charizard"; selfObtained=true; year="2023"; ot="★ pungkula"; id="385844"; region="ENG"; notes="Dark Tera Type"; proof="WC"; 
        obtained="2023/07/23"; moves=[ "Crunch" "Flare Blitz" "Acrobatics" "Belly Drum" ];
      };
      "grimmsnarl-2023-shiny" = {
        species="grimmsnarl"; dex=861; name="Grimmsnarl"; shiny=true; selfObtained=true; year="2023"; proof="WC"; obtained="2023/08/08";
      };
      "mew-2023-gety0urmew-1" = {
        species="mew"; dex=151; name="Mew"; selfObtained=true; year="2023"; region="ENG"; notes="GETY0URMEW"; proof="WC"; obtained="2023/08/08";
      };
      "mew-2023-gety0urmew-2" = {
        species="mew"; dex=151; name="Mew"; selfObtained=true; year="2023"; ot="★ pungkula"; id="385844"; region="ENG"; notes="Fire Tera Type"; proof="WC"; 
        obtained="2023/08/12"; moves=[ "Flamethrower" "Swift" "Light Screen" "Life Dew" ];
      };
      "gastrodon-2023-eduardo" = {
        species="gastrodon"; dex=423; name="Gastrodon"; selfObtained=true; year="2023"; ot="Eduardo"; id="230811"; region="ENG"; notes="23WCSGASTR0D0N"; proof="WC"; 
        obtained="2023/08/12"; moves=[ "Earth Power" "Icy Wind" "Yawn" "Protect" ];
      };
      "lucario-2023-shiny" = {
        species="lucario"; dex=448; name="Lucario"; shiny=true; selfObtained=true; year="2023"; notes="sh1nybuddy"; obtained="2023/12/15";
      };
      "darkrai-2023-newm00nisc0ming" = {
        species="darkrai"; dex=491; name="Darkrai"; selfObtained=true; year="2023"; notes="newm00nisc0ming"; obtained="2023/12/15";
      };
      "gimmighoul-2023-seey0u1npaldea" = {
        species="gimmighoul"; dex=999; name="Gimmighoul"; selfObtained=true; year="2023"; notes="SEEY0U1NPALDEA"; obtained="2023/12/15";
      };
      "revavroom-2023" = {
        species="revavroom"; dex=966; name="Revavroom"; selfObtained=true; year="2023"; obtained="2023/12/22";
      };
      "cetitan-2023" = {
        species="cetitan"; dex=975; name="Cetitan"; selfObtained=true; year="2023";
      };
    };


    # 🦆 ⮞ TRUE SHINY LIVING DEX ♀️/♂️  
    shiny = {
      # » GENERATION 1 - KANTO REGION
      bulbasaur       = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      ivysaur         = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      venusaur-f      = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      venusaur-m      = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      venusaur-gmax   = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      charmander      = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      charmeleon      = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      charizard       = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      charizard-gmax  = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      squirtle        = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      wartortle       = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      blastoise       = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      blastoise-gmax  = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      caterpie        = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      metapod         = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      butterfree-f    = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      butterfree-m    = { ball = "luxury"; ot = true; style = "square"; egg = true;  notes = "egg hatch"; };
      butterfree-gmax = { ball = "luxury"; ot = true; style = "square"; egg = true;  notes = "Egg hatch"; };
      weedle          = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      kakuna          = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      beedrill        = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      pidgey          = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      pidgeotto       = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      pidgeot         = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      rattata-f       = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      rattata-m       = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      rattata-alola   = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      raticate-f      = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      raticate-m      = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      raticate-alola  = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      spearow         = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      fearow          = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      ekans           = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      arbok           = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      pikachu-f       = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      pikachu-m       = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      pikachu-gmax    = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      raichu-f        = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      raichu-m        = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      raichu-alola    = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      sandshrew       = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      sandshrew-alola = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      sandslash       = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      sandslash-alola = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      nidoran-f       = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      nidorina        = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      nidoqueen       = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      nidoran-m       = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      nidorino        = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      nidoking        = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      clefairy        = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      clefable        = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      vulpix          = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      vulpix-alola    = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      ninetales       = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      ninetales-alola = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      jigglypuff      = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      wigglytuff      = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      zubat-f         = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      zubat-m         = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      golbat-f        = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      golbat-m        = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      oddish          = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      gloom-f         = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      gloom-m         = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      vileplume-f     = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      vileplume-m     = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      paras           = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      parasect        = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      venonat         = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      venomoth        = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      diglett         = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      diglett-alola   = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      dugtrio         = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      dugtrio-alola   = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      meowth          = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      meowth-alola    = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      meowth-galar    = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      meowth-gmax     = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      persian         = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      persian-alola   = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      psyduck         = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      golduck         = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      mankey          = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      primeape        = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      growlithe       = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      arcanine        = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      poliwag         = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      poliwhirl       = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      poliwrath       = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      abra            = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      kadabra-f       = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      kadabra-m       = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      alakazam-f      = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      alakazam-m      = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      machop          = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      machoke         = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      machamp         = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      machamp-gmax    = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      bellsprout      = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      weepinbell      = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      victreebel      = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      tentacool       = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      tentacruel      = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      geodude         = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      geodude-alola   = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      graveler        = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      graveler-alola  = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      golem           = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      golem-alola     = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      ponyta          = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      ponyta-galar    = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      rapidash        = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      rapidash-galar  = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      slowpoke        = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      slowpoke-galar  = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      slowbro         = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      slowbro-galar   = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      magnemite       = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      magneton        = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      farfetchd       = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      farfetchd-galar = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      doduo-f         = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      doduo-m         = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      dodrio-f        = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      dodrio-m        = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      seel            = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      dewgong         = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      grimer          = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      grimer-alola    = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      muk             = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      muk-alola       = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      shellder        = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      cloyster        = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      gastly          = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      haunter         = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      gengar          = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      gengar-gmax     = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      onix            = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      drowzee         = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      hypno-f         = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      hypno-m         = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      krabby          = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      kingler         = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      kingler-gmax    = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      voltorb         = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      electrode       = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      exeggcute       = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      exeggutor       = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      exeggutor-alola = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      cubone          = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      marowak         = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      marowak-alola   = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      hitmonlee       = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      hitmonchan      = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      lickitung       = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      koffing         = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      weezing         = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      weezing-galar   = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      rhyhorn-f       = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      rhyhorn-m       = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      rhydon-f        = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      rhydon-m        = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      chansey         = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      tangela         = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      kangaskhan      = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      horsea          = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      seadra          = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      goldeen-f       = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      goldeen-m       = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      seaking-f       = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      seaking-m       = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      staryu          = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      starmie         = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      mr-mime         = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      mr-mime-galar   = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      scyther-f       = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      scyther-m       = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      jynx            = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      electabuzz      = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      magmar          = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      pinsir          = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      tauros          = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      tauros-paldea   = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      tauros-blaze    = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      tauros-aqua     = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      magikarp-f      = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      magikarp-m      = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      gyarados-f      = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      gyarados-m      = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      lapras          = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      lapras-gmax     = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      ditto           = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      eevee-f         = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      eevee-m         = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      eevee-gmax      = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      vaporeon        = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      jolteon         = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      flareon         = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      porygon         = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      omanyte         = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      omastar         = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      kabuto          = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      kabutops        = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      aerodactyl      = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      snorlax         = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      snorlax-gmax    = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      articuno        = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      articuno-galar  = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      zapdos          = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      # zapdos-galar    = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      moltres         = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      moltres-galar   = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      dratini         = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      dragonair       = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      dragonite       = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      mewtwo          = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };
      mew             = { ball = "luxury"; ot = true; style = "star";   egg = false; notes = ""; };

      # » GENERATION 2 - JOHTO
      chikorita       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      bayleef         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      meganium-f      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      meganium-m      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      cyndaquil       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      quilava         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      typhlosion      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      totodile        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      croconaw        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      feraligatr      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      sentret         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      furret          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      hoothoot        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      noctowl         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      ledyba-f        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      ledyba-m        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      ledian-f        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      ledian-m        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      spinarak        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      ariados         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      crobat          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      chinchou        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      lanturn         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      pichu           = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      cleffa          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      igglybuff       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      togepi          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      togetic         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      natu            = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      xatu-f          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      xatu-m          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      mareep          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      flaaffy         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      ampharos        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      bellossom       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      marill          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      azumarill       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      sudowoodo-f     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      sudowoodo-m     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      politoed-f      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      politoed-m      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      hoppip          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      skiploom        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      jumpluff        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      aipom-f         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      aipom-m         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      sunkern         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      sunflora        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      yanma           = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      wooper-f        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      wooper-m        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      quagsire-f      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      quagsire-m      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      espeon          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      umbreon         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      murkrow-f       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      murkrow-m       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      slowking        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      slowking-galar  = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      misdreavus      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # unown-a            = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # unown-b            = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # unown-c            = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # unown-d            = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # unown-e            = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # unown-exclamation  = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      unown-f             = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      unown-g             = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # unown-h            = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # unown-i            = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # unown-j            = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # unown-k            = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # unown-l            = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # unown-m            = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # unown-n            = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # unown-o            = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # unown-p            = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # unown-q            = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # unown-question     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # unown-r            = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # unown-s            = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # unown-t            = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      unown-u             = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # unown-v            = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # unown-w            = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # unown-x            = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # unown-y            = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # unown-z            = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      wobbuffet-f     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      wobbuffet-m     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      girafarig-f     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      girafarig-m     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      pineco          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      forretress      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      dunsparce       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      gligar-f        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      gligar-m        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      steelix-f       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      steelix-m       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      snubbull        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      granbull        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      qwilfish        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      scizor-f        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      scizor-m        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      shuckle         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      heracross-f     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      heracross-m     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      sneasel-f       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      sneasel-m       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      teddiursa       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      ursaring-f      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      ursaring-m      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      slugma          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      magcargo        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      swinub          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      piloswine-f     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      piloswine-m     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      corsola         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      corsola-galar   = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      remoraid        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      octillery-f     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      octillery-m     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      delibird        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      mantine         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      skarmory        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      houndour        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      houndoom-f      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      houndoom-m      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      kingdra         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      phanpy          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      donphan-f       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      donphan-m       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      porygon2        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      stantler        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      smeargle        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      tyrogue         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      hitmontop       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      smoochum        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      elekid          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      magby           = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      miltank         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      blissey         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      raikou          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      entei           = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      suicune         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      larvitar        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      pupitar         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      tyranitar       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      lugia           = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      ho-oh           = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      celebi          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };

      # ── GENERATION 3 — HOENN (no Regirock / Regice) ──────────────────────
      treecko         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      grovyle         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      sceptile        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      torchic-f       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      torchic-m       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      combusken-f     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      combusken-m     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      blaziken-f      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      blaziken-m      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      mudkip          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      marshtomp       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      Swampert        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      poochyena       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      mightyena       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      zigzagoon       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      zigzagoon-galar = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      linoone         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      linoone-galar   = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      wurmple         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      silcoon         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      beautifly-f     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      beautifly-m     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      cascoon         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      dustox-f        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      dustox-m        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      lotad           = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      lombre          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      ludicolo-f      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      ludicolo-m      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      seedot          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      nuzleaf-f       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      nuzleaf-m       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      shiftry-f       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      shiftry-m       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      taillow         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      swellow         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      wingull         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      pelipper        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      ralts           = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      kirlia          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      gardevoir       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      surskit         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      masquerain      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      shroomish       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      breloom         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      slakoth         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      vigoroth        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      slaking         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      nincada         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      ninjask         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      shedinja        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      whismur         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      loudred         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      exploud         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      makuhita        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      hariyama        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      azurill         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      nosepass        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      skitty          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      delcatty        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      sableye         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      mawile          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      aron            = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      lairon          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      aggron          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      meditite-f      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      meditite-m      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      medicham-f      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      medicham-m      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      electrike       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      manectric       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      plusle          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      minun           = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      volbeat         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      illumise        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      roselia-f       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      roselia-m       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      gulpin-f        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      gulpin-m        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      swalot-f        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      swalot-m        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      carvanha        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      sharpedo        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      wailmer         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      wailord         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      numel-f         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      numel-m         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      camerupt-f      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      camerupt-m      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      torkoal         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      spoink          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      grumpig         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      spinda          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      trapinch        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      vibrava         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      flygon          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      cacnea          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      cacturne-f      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      cacturne-m      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      swablu          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      altaria         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      zangoose        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      seviper         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      lunatone        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      solrock         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      barboach        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      whiscash        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      corphish        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      crawdaunt       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      baltoy          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      claydol         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      lileep          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      cradily         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      anorith         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      armaldo         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      feebas          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      milotic-f       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      milotic-m       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      castform        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      kecleon         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      shuppet         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      banette         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      duskull         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      dusclops        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      tropius         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      chimecho        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      absol           = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      wynaut          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      snorunt         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      glalie          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      spheal          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      sealeo          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      walrein         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      clamperl        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      huntail         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      gorebyss        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      relicanth-f     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      relicanth-m     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      luvdisc         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      bagon           = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      shelgon         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      salamence       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      beldum          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      metang          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      metagross       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      registeel       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # regirock        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # regice          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      latias          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      latios          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      kyogre          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      groudon         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      rayquaza        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      jirachi         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      deoxys          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };

      # » GENERATION 4 - SINNOH
      turtwig         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      grotle          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      torterra        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      chimchar        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      monferno        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      infernape       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      piplup          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      prinplup        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      empoleon        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      starly-f        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      starly-m        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      staravia-f      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      staravia-m      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      staraptor-f     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      staraptor-m     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      bidoof-f        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      bidoof-m        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      bibarel-f       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      bibarel-m       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      kricketot-f     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      kricketot-m     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      kricketune-f    = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      kricketune-m    = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      shinx-f         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      shinx-m         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      luxio-f         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      luxio-m         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      luxray-f        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      luxray-m        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      budew           = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      roserade-f      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      roserade-m      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      cranidos        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      rampardos       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      shieldon        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      bastiodon       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      burmy-plant     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      burmy-sandy     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      burmy-trash     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      wormadam-plant  = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      wormadam-sandy  = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      wormadam-trash  = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      mothim          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      combee-f        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      combee-m        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      vespiquen       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      pachirisu-f     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      pachirisu-m     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      buizel-f        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      buizel-m        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      floatzel-f      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      floatzel-m      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      cherubi         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      cherrim         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      shellos-east    = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      shellos-west    = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      gastrodon-east  = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      gastrodon-west  = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      ambipom-f       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      ambipom-m       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      drifloon        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      drifblim        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      buneary         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      lopunny         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      mismagius       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      honchkrow       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      glameow         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      purugly         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      chingling       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      stunky          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      skuntank        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      bronzor         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      bronzong        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      bonsly          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      mime-jr         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      happiny         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      chatot          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      spiritomb       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      gible-f         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      gible-m         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      gabite-f        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      gabite-m        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      garchomp-f      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      garchomp-m      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      munchlax        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      riolu           = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      lucario         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      hippopotas-f    = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      hippopotas-m    = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      hippowdon-f     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      hippowdon-m     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      skorupi         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      drapion         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      croagunk-f      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      croagunk-m      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      toxicroak-f     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      toxicroak-m     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      carnivine       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      finneon-f       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      finneon-m       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      lumineon-f      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      lumineon-m      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      mantyke         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      snover-f        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      snover-m        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      abomasnow-f     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      abomasnow-m     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      weavile-f       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      weavile-m       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      magnezone       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      lickilicky      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      rhyperior-f     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      rhyperior-m     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      tangrowth-f     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      tangrowth-m     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      electivire      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      magmortar       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      togekiss        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      yanmega         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      leafeon         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      glaceon         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # gliscor         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      mamoswine-f     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      mamoswine-m     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      porygon-z       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      gallade         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      probopass       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      dusknoir        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      froslass        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      rotom           = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      rotom-fan       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      rotom-frost     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      rotom-heat      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      rotom-mow       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      rotom-wash      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      uxie            = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      mesprit         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      azelf           = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # dialga          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # palkia          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # heatran         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      regigigas       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      giratina        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      phione          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      darkrai         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      shaymin         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # cresselia       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # arceus          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };

      # » GENERATION 5 - UNOVAno
      # victini         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      snivy           = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      servine         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      serperior       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      tepig           = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      pignite         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      emboar          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      oshawott        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      dewott          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      samurott        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      patrat          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      watchog         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      lillipup        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      herdier         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      stoutland       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      purrloin        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      liepard         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      pansage         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # simisage        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      pansear         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      simisear        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      panpour         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # simipour        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      munna           = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      musharna        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      pidove          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      tranquill       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      unfezant-f      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      unfezant-m      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      blitzle         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      zebstrika       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      roggenrola      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      boldore         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      gigalith        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      woobat          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      swoobat         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      drilbur         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      excadrill       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      audino          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      timburr         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      gurdurr         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      conkeldurr      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      tympole         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      palpitoad       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      seismitoad      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      throh           = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      sawk            = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      sewaddle        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      swadloon        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      leavanny        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      venipede        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      whirlipede      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      scolipede       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      cottonee        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      whimsicott      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      petilil         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      lilligant       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      basculin-blue   = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      basculin-red    = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      sandile         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      krokorok        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      krookodile      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      darumaka        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      darumaka-galar  = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      darmanitan      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      darmanitan-galar= { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      maractus        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      dwebble         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      crustle         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      scraggy         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      scrafty         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      sigilyph        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      yamask          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      yamask-galar    = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      cofagrigus      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      tirtouga        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      carracosta      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      archen          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      archeops        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      trubbish        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      garbodor        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      garbodor-gmax   = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      zorua           = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      zoroark         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      minccino        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      cinccino        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      gothita         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      gothorita       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      gothitelle      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      solosis         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      duosion         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      reuniclus       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      ducklett        = { ball = "love";   ot = true; style = "star"; egg = false; notes = ""; };
      swanna          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      vanillite       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      vanillish       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      vanilluxe       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      deerling-autumn = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      deerling-spring = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      deerling-summer = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      deerling-winter = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      sawsbuck-autumn = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      sawsbuck-spring = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      sawsbuck-summer = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      sawsbuck-winter = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      emolga          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      karrablast      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      escavalier      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      foongus         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      amoonguss       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      frillish-f      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      frillish-m      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      jellicent-f     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      jellicent-m     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      alomomola       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      joltik          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      galvantula      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      ferroseed       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      ferrothorn      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      klink           = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      klang           = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      klinklang       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      tynamo          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      eelektrik       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      eelektross      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      elgyem          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      beheeyem        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      litwick         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      lampent         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      chandelure      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      axew            = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      fraxure         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      haxorus         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      cubchoo         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      beartic         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      cryogonal       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      shelmet         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      accelgor        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      stunfisk        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      stunfisk-galar  = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      mienfoo         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      mienshao        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      druddigon       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      golett          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      golurk          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      pawniard        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      bisharp         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      bouffalant      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      rufflet         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      braviary        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      vullaby         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      mandibuzz       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      heatmor         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      durant          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      deino           = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      zweilous        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      hydreigon       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      larvesta        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      volcarona       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      cobalion        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      terrakion       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      virizion        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      tornadus        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # landorus        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      thundurus       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      reshiram        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # zekrom          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      kyurem          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      genesect        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };

      # » GENERATION 6 - KALOS
      chespin         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      quilladin       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      chesnaught      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      fennekin        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      braixen         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      delphox         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      froakie         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      frogadier       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      greninja        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      bunnelby        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      diggersby       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      fletchling      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      fletchinder     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      talonflame      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      scatterbug      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      spewpa          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # vivillon-archipelago = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # vivillon-continental = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # vivillon-elegant     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # vivillon-garden      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # vivillon-high-plains = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # vivillon-icy-snow    = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # vivillon-jungle      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # vivillon-marine      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # vivillon-meadow      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # vivillon-modern      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # vivillon-monsoon     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # vivillon-ocean       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # vivillon-polar       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # vivillon-river       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # vivillon-sandstorm   = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # vivillon-savanna     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # vivillon-sun         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # vivillon-tundra      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      litleo          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      pyroar-f        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      pyroar-m        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      flabebe-blue    = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      flabebe-orange  = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      flabebe-red     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      flabebe-white   = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      flabebe-yellow  = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      floette-blue    = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      floette-eternal = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      floette-orange  = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      floette-red     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      floette-white   = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      floette-yellow  = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      florges-blue    = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      florges-orange  = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      florges-red     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      florges-white   = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      florges-yellow  = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      skiddo          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      gogoat          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      pancham         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      pangoro         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      furfrou         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      espurr          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      meowstic-f      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      meowstic-m      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      honedge         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      doublade        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      aegislash       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      spritzee        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      aromatisse      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      swirlix         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      slurpuff        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      inkay           = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      malamar         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      binacle         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      barbaracle      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      skrelp          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      dragalge        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      clauncher       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      clawitzer       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      helioptile      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      heliolisk       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      tyrunt          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      tyrantrum       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      amaura          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      aurorus         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      sylveon         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      hawlucha        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      dedenne         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      carbink         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      goomy           = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      sliggoo         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      goodra          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      klefki          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      phantump        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      trevenant       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      pumpkaboo-small = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      pumpkaboo-average = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      pumpkaboo-large = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      pumpkaboo-super = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      gourgeist-small = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      gourgeist-average = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      gourgeist-large = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      gourgeist-super = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      bergmite        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      avalugg         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      noibat          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      noivern         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      xerneas         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      yveltal         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      zygarde         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };

      # » GENERATION 7 - ALOLA
      rowlet          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      dartrix         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      decidueye       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      litten          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      torracat        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      incineroar      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      popplio         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      brionne         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      primarina       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      pikipek         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      trumbeak        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      toucannon       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      yungoos         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      gumshoos        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      grubbin         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      charjabug       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      vikavolt        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      crabrawler      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      crabominable    = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      oricorio-baile  = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      oricorio-pompom = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      oricorio-pau    = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      oricorio-sensu  = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      cutiefly        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      ribombee        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      rockruff        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      lycanroc-dusk   = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      lycanroc-midday = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      lycanroc-midnight = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      wishiwashi      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      mareanie        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      toxapex         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      mudbray         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      mudsdale        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      dewpider        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      araquanid       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      fomantis        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      lurantis        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      morelull        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      shiinotic       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      salandit        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      salazzle        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      stufful         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      bewear          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      bounsweet       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      steenee         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      tsareena        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      comfey          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      oranguru        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      passimian       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      wimpod          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      golisopod       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      sandygast       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      palossand       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      pyukumuku       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      type-null       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      silvally        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # minior          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      komala          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      turtonator      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      togedemaru      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      mimikyu         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      bruxish         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      drampa          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      dhelmise        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      jangmo-o        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      hakamo-o        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      kommo-o         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      tapu-koko       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      tapu-lele       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      tapu-bulu       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      tapu-fini       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      solgaleo        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      lunala          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      nihilego        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # pheromosa       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # xurkitree       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # celesteela      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # necrozma        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      buzzwole        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      kartana         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      guzzlord        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      poipole         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      naganadel       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      stakataka       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      blacephalon     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      zeraora         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      meltan          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      melmetal        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };

      # » GENERATION 8 - GALAR
      grookey         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      thwackey        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      rillaboom       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      rillaboom-gmax  = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      scorbunny       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      raboot          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      cinderace       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      cinderace-gmax  = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      sobble          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      drizzile        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      inteleon        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      inteleon-gmax   = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      skwovet         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      greedent        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      rookidee        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      corvisquire     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      corviknight     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
#      corviknight-gmax= { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      blipbug         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      dottler         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      orbeetle        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
 #     orbeetle-gmax   = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      nickit          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      thievul         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      gossifleur      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      eldegoss        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      wooloo          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      dubwool         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      chewtle         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      drednaw         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      drednaw-gmax    = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      yamper          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      boltund         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      rolycoly        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      carkol          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      coalossal       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
#      coalossal-gmax  = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      applin          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      flapple         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
 #     flapple-gmax    = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      appletun        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
 #     appletun-gmax   = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      silicobra       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      sandaconda      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
  #    sandaconda-gmax = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      cramorant       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      arrokuda        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      barraskewda     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      toxel           = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      toxtricity-amped   = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      toxtricity-lowkey  = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
   #   toxtricity-gmax    = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      sizzlipede      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      centiskorch     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      centiskorch-gmax= { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      clobbopus       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      grapploct       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      sinistea        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      sinistea-antique= { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      polteageist     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      polteageist-antique = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      hatenna         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      hattrem         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      hatterene       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      hatterene-gmax  = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      impidimp        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      morgrem         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      grimmsnarl      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      obstagoon       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      perrserker      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      cursola         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      sirfetchd       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      mr-rime         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      runerigus       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      milcery         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      #milcery-gmax    = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      alcremie-strawberry = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      alcremie-berry     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      alcremie-love      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      alcremie-clover    = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      alcremie-flower    = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      alcremie-star      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      alcremie-ribbon    = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
   #   alcremie-gmax      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      falinks         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      pincurchin      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      snom            = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      frosmoth        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      stonjourner     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      eiscue          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      indeedee-f      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      indeedee-m      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      morpeko         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      cufant          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      copperajah      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
   #   copperajah-gmax = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      dracozolt       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      arctozolt       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      dracovish       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      arctovish       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      duraludon       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      dreepy          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      drakloak        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      dragapult       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      zacian          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      zamazenta       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      eternatus       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      regieleki       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      regidrago       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };

      # PLA — HISUI
      # wyrdeer         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # kleavor         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # ursaluna        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # sneasler        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # overqwil        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # enamorus        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # growlithe-hisui = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # arcanine-hisui  = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # voltorb-hisui   = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # electrode-hisui = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # qwilfish-hisui  = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # sneasel-hisui   = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # lilligant-hisui = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # zoroark-hisui   = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # braviary-hisui  = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # sliggoo-hisui   = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # goodra-hisui    = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # dialga-origin   = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      # palkia-origin   = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      basculegion-f   = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      basculegion-m   = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      zorua-hisui     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      samurott-hisui  = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      typhlosion-hisui= { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      decidueye-hisui = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };

      # » GENERATION 9 - PALDEA
      sprigatito      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      floragato       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      meowscarada     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      fuecoco         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      crocalor        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      skeledirge      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      quaxly          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      quaxwell        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      quaquaval       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      lechonk         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      oinkologne-f    = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      oinkologne-m    = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      dudunsparce-two   = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      dudunsparce-three = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      tarountula      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      spidops         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      nymble          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      lokix           = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      rellor          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      rabsca          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      greavard        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      houndstone      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      flittle         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      espathra        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      farigiraf       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      wiglett         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      wugtrio         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      dondozo         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      veluza          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      finizen         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      palafin         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      smoliv          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      dolliv          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      arboliva        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      capsakid        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      scovillain      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      tadbulb         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      bellibolt       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      varoom          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      revavroom       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      orthworm        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      tandemaus       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      maushold-three  = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      maushold-four   = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      cetoddle        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      cetitan         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      frigibax        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      arctibax        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      baxcalibur      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      tatsugiri-curly = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      tatsugiri-droopy= { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      tatsugiri-stretchy = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      cyclizar        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      pawmi           = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      pawmo           = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      pawmot          = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      wattrel         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      kilowattrel     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      bombirdier      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      squawkabilly-green = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      squawkabilly-blue  = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      squawkabilly-white = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      squawkabilly-yellow= { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      flamigo         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      klawf           = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      nacli           = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      naclstack       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      garganacl       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      glimmet         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      glimmora        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      shroodle        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      grafaiai        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      fidough         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      dachsbun        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      maschiff        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      mabosstiff      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      bramblin        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      brambleghast    = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      great-tusk      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      brute-bonnet    = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      sandy-shocks    = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      scream-tail     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      flutter-mane    = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      slither-wing    = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      roaring-moon    = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      iron-treads     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      iron-moth       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      iron-hands      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      iron-jugulis    = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      iron-thorns     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      iron-bundle     = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      iron-valiant    = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      tinkatink       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      tinkatuff       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      tinkaton        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      charcadet       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      armarouge       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      ceruledge       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      toedscool       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      toedscruel      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
#      wooper-paldea   = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      clodsire        = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      kingambit       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      annihilape      = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      dipplin         = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      poltchageist    = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
      sinistcha       = { ball = "luxury"; ot = true; style = "star"; egg = false; notes = ""; };
    };
    


    # 🦆 ⮞ APRIBALLS BREEDABLES  
    breedables = {
    
      # » GENERATION 1 - KANTO REGION
      bulbasaur       = allNone; 
      charmander      = allHA // { dream = none; beast = none; };
      squirtle        = allDone;
      caterpie        = allHA;
      weedle          = allHA // { dream = none; };
      pidgey          = allDone;
      rattata         = allDone;
      rattata-alola   = allDone;
      spearow         = allDone;
      ekans           = allDone;
      pichu           = allDone;
      sandshrew       = allDone;
      sandshrew-alola = allDone;
      nidoran-f       = allDone;
      clefairy        = allDone;
      vulpix          = allDone;
      vulpix-alola    = allDone;
      zubat           = allDone;
      oddish          = allDone;
      paras           = allDone;
      venonat         = allDone;
      jigglypuff      = allDone;
      diglett         = allDone;
      diglett-alola   = allDone;
      meowth          = allDone;
      meowth-alola    = allDone;
      meowth-galar    = allDone;
      psyduck         = allDone;
      mankey          = allDone;
      growlithe       = allDone;
      poliwag         = allDone;
      abra            = allDone;
      machop          = allDone;
      bellsprout      = allDone;
      tentacool       = allDone;
      geodude         = allDone;
      geodude-alola   = allDone;
      ponyta          = allDone;
      ponyta-galar    = allDone;
      slowpoke        = allDone;
      slowpoke-galar  = allDone;
      magnemite       = allDone;
      farfetchd       = allDone;
      farfetchd-galar = allDone;
      doduo           = allDone;
      seel            = allDone;
      grimer          = allDone;
      grimer-alola    = allDone;
      shellder        = allDone;
      gastly          = allDone;
      onix            = allDone;
      drowzee         = allDone;
      krabby          = allDone;
      voltorb         = allDone;
      exeggcute       = allDone;
      cubone          = allDone;
      lickitung       = allDone;
      koffing         = allDone;
      rhyhorn         = allDone;
      chansey         = allDone;
      tangela         = allDone;
      kangaskhan      = allDone;
      horsea          = allDone;
      goldeen         = allDone;
      staryu          = allDone;
      mr-mime         = allDone;
      mr-mime-galar   = allDone;
      scyther         = allDone;
      smoochum        = allDone;
      elekid          = allDone;
      magby           = allDone;
      pinsir          = allDone;
      tauros          = allDone;
      tauros-paldea   = allDone;
      tauros-paldea-blaze    = allDone;
      tauros-paldea-aqua     = allDone;
      magikarp        = allDone;
      lapras          = allDone;
      eevee           = allDone;
      porygon         = allDone;
      omanyte         = allDone;
      kabuto          = allDone;
      aerodactyl      = allDone;
      snorlax         = allDone;
      dratini         = allDone;
      
  
      # » GENERATION 2 - JOHTO REGION
      chikorita     = allDone;
      cyndaquil     = allDone;
      totodile      = allDone;
      sentret       = allDone;
      hoothoot      = allDone;
      ledyba        = allDone;
      spinarak      = allDone;
      chinchou      = allDone;
      togepi        = allDone;
      natu          = allDone;
      mareep        = allDone;
      marill        = allDone;
      sudowoodo     = allDone;
      hoppip        = allDone;
      aipom         = allDone;
      sunkern       = allDone;
      yanma         = allDone;
      wooper        = allDone;
      wooper-paldea = allDone;
      murkrow       = allDone;
      misdreavus    = allDone;
      wobbuffet     = allDone;
      girafarig     = allDone;
      pineco        = allDone;
      dunsparce     = allDone;
      gligar        = allDone;
      snubbull      = allDone;
      qwilfish      = allDone;
      shuckle       = allDone;
      heracross     = allDone;
      sneasel       = allDone;
      teddiursa     = allDone;
      slugma        = allDone;
      swinub        = allDone;
      corsola       = allDone;
      corsola-galar = allDone;
      remoraid      = allDone;
      delibird      = allDone;
      mantine       = allDone;
      skarmory      = allDone;
      houndour      = allDone;
      phanpy        = allDone;
      stantler      = allDone;
      smeargle      = allDone;
      tyrogue       = allDone;
      miltank       = allDone;
      larvitar      = allDone;
  
      # » GENERATION 3 - HOENN REGION
      treecko         = allDone;
      torchic         = allDone;
      mudkip          = allDone;
      poochyena       = allDone;
      zigzagoon       = allDone;
      zigzagoon-galar = allDone;
      wurmple   = allDone;
      lotad     = allDone;
      seedot    = allDone;
      taillow   = allDone;
      wingull   = allDone;
      ralts     = allDone;
      surskit   = allDone;
      shroomish = allDone;
      slakoth   = allDone;
      nincada   = allDone;
      whismur   = allDone;
      makuhita  = allDone;
      nosepass  = allDone;
      skitty    = allDone;
      sableye   = allDone;
      mawile    = allDone;
      aron      = allDone;
      meditite  = allDone;
      electrike = allDone;
      plusle    = allDone;
      minun     = allDone;
      volbeat   = allDone;
      illumise  = allDone;
      roselia   = allDone;
      gulpin    = allDone;
      carvanha  = allDone;
      wailmer   = allDone;
      numel     = allDone;
      torkoal   = allDone;
      spoink    = allDone;
      spinda    = allDone;
      trapinch  = allDone;
      cacnea    = allDone;
      swablu    = allDone;
      zangoose  = allDone;
      seviper   = allDone;
      lunatone  = allDone;
      solrock   = allDone;
      barboach  = allDone;
      corphish  = allDone;
      baltoy    = allDone;
      lileep    = allDone;
      anorith   = allDone;
      feebas    = allDone;
      castform  = allDone;
      kecleon   = allDone;
      shuppet   = allDone;
      duskull   = allDone;
      tropius   = allDone;
      chingling = allDone;
      absol     = allDone;
      snorunt   = allDone;
      spheal    = allDone;
      clamperl  = allDone;
      relicanth = allDone;
      luvdisc   = allDone;
      bagon     = allDone;
      beldum    = allDone;
      
      
      
      # » GENERATION 4 - SINNOH REGION
      turtwig = allDone;
      chimchar = allDone;
      piplup = allDone;
      starly = allDone;
      bidoof = allDone;
      kricketot   = allDone;
      shinx       = allDone;
      cranidos    = allDone;
      shieldon    = allDone;
      burmy-plant = allDone;
      burmy-sandy = allDone;
      burmy-trash = allDone;
      combee = allDone;
      pachirisu = allDone;
      buizel = allDone;
      cherubi = allDone;
      shellos-east = allDone;
      shellos-west = allDone;
      drifloon = allDone;
      buneary = allDone;
      glameow = allDone;
      stunky = allDone;
      bronzor = allDone;
      chatot = allDone;
      spiritomb = allDone;
      gible = allDone;
      riolu = allDone;
      hippopotas = allDone;
      skorupi = allDone;
      croagunk = allDone;
      carnivine = allDone;
      finneon = allDone;
      snover = allDone;
      rotom = allDone;
      
      # » GENERATION 5 - UNOVA REGION
      snivy          = allDone;
      tepig          = allDone;
      oshawott       = allDone;
      patrat         = allDone;
      lillipup       = allDone;
      purrloin       = allDone;
      pansage        = allDone;
      pansear        = allDone;
      panpour        = allDone;
      munna          = allDone;
      pidove         = allDone;
      blitzle        = allDone;
      roggenrola     = allDone;
      woobat         = allDone;
      drilbur        = allDone;
      audino         = allDone;
      timburr        = allDone;
      tympole        = allDone;
      throh          = allDone;
      sawk           = allDone;
      sewaddle       = allDone;
      venipede       = allDone;
      cottonee       = allDone;
      petilil        = allDone;
      basculin-red   = allDone;
      basculin-blue  = allDone;
      sandile        = allDone;
      darumaka       = allDone;
      darumaka-galar = allDone;
      maractus       = allDone;
      dwebble        = allDone;
      scraggy        = allDone;
      sigilyph       = allDone;
      yamask         = allDone;
      yamask-galar   = allDone;
      tirtouga       = allDone;
      archen         = allDone;
      trubbish       = allDone;
      zorua          = allDone;
      minccino       = allDone;
      gothita        = allDone;
      solosis        = allDone;
      ducklett       = allDone;
      vanillite      = allDone;
      deerling       = allDone;
      emolga         = allDone;
      karrablast     = allDone;
      foongus        = allDone;
      frillish       = allDone;
      alomomola      = allDone;
      joltik         = allDone;
      ferroseed      = allDone;
      klink          = allDone;
      tynamo         = allDone;
      elgyem         = allDone;
      litwick        = allDone;
      axew           = allDone;
      cubchoo        = allDone;
      cryogonal      = allDone;
      shelmet        = allDone;
      stunfisk       = allDone;
      stunfisk-galar = allDone;
      mienfoo        = allDone;
      druddigon      = allDone;
      golett         = allDone;
      pawniard       = allDone;
      bouffalant     = allDone;
      rufflet        = allDone;
      vullaby        = allDone;
      heatmor        = allDone;
      durant         = allDone;
      deino          = allDone;
      larvesta       = allDone;
      
  
  
      # » GENERATION 6 - KALOS REGION
      chespin           = allDone;
      fennekin          = allDone;
      froakie           = allDone;
      bunnelby          = allDone;
      fletchling        = allDone;
      scatterbug        = allDone;
      litleo            = allDone;
      flabebe-blue      = allDone;
      flabebe-orange    = allDone;
      flabebe-red       = allDone;
      flabebe-white     = allDone;
      flabebe-yellow    = allDone;
      skiddo            = allDone;
      pancham           = allDone;
      furfrou           = allDone;
      espurr            = allDone;
      honedge           = allDone;
      spritzee          = allDone;
      swirlix           = allDone;
      inkay             = allDone;
      binacle           = allDone;
      skrelp            = allDone;
      clauncher         = allDone;
      helioptile        = allDone;
      tyrunt            = allDone;
      amaura            = allDone;
      hawlucha          = allDone;
      dedenne           = allDone;
      carbink           = allDone;
      goomy             = allDone;
      klefki            = allDone;
      phantump          = allDone;
      pumpkaboo-small   = allDone;
      pumpkaboo-average = allDone;
      pumpkaboo-large   = allDone;
      pumpkaboo-super   = allDone;
      bergmite          = allDone;
      noibat            = allDone;
  
  
  
      # » GENERATION 7 - ALOLA REGION
      rowlet          = allDone;
      litten          = allDone;
      popplio         = allDone;
      pikipek         = allDone;
      yungoos         = allDone;
      grubbin         = allDone;
      crabrawler      = allDone;
      oricorio-baile  = allDone;
      oricorio-pompom = allDone;
      oricorio-pau    = allDone;
      oricorio-sensu  = allDone;
      cutiefly        = allDone;
      rockruff        = allDone;
      rockruff-dusk   = allDone;
      wishiwashi      = allDone;
      mareanie        = allDone;
      mudbray         = allDone;
      dewpider        = allDone;
      fomantis        = allDone;
      morelull        = allDone;
      salandit        = allDone;
      stufful         = allDone;
      bounsweet       = allDone;
      comfey          = allDone;
      oranguru        = allDone;
      passimian       = allDone;
      wimpod          = allDone;
      sandygast       = allDone;
      pyukumuku       = allDone;
      minior-blue     = allDone;
      minior-green    = allDone;
      minior-indigo   = allDone;
      minior-orange   = allDone;
      minior-red      = allDone;
      minior-violet   = allDone;
      minior-yellow   = allDone;
      komala          = allDone;
      turtonator      = allDone;
      togedemaru      = allDone;
      mimikyu         = allDone;
      bruxish         = allDone;
      drampa          = allDone;
      dhelmise        = allDone;
      jangmo-o        = allDone;
  
  
  
      # » GENERATION 8 - GALAR REGION
      grookey     = allDone;
      scorbunny   = allDone;
      sobble      = allDone;
      skwovet     = allDone;
      rookidee    = allDone;
      blipbug     = allDone;
      nickit      = allDone;
      gossifleur  = allDone;
      wooloo      = allDone;
      chewtle     = allDone;
      yamper      = allDone;
      rolycoly    = allDone;
      applin      = allDone;
      silicobra   = allDone;
      cramorant   = allDone;
      arrokuda    = allDone;
      toxel       = allDone;
      sizzlipede  = allDone;
      clobbopus   = allDone;
      sinistea    = allDone;
      hatenna     = allDone;
      impidimp    = allDone;
      milcery     = allDone;
      falinks     = allDone;
      pincurchin  = allDone;
      snom        = allDone;
      stonjourner = allDone;
      eiscue      = allDone;
      indeedee    = allDone;
      morpeko     = allDone;
      cufant      = allDone;
      duraludon   = allDone;
      dreepy      = allDone;
    };  
  
  };}
