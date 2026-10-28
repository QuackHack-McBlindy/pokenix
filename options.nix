{ 
  lib,
  ...
} : let
  inherit (lib) mkOption types genAttrs mkIf fixedWidthString;

  pokespriteData = builtins.fromJSON (builtins.readFile ./data/pokemon.json);

  padNum = n:
    let
      s = toString n;
      w = if builtins.stringLength s > 3 then builtins.stringLength s else 3;
    in
    fixedWidthString w "0" s;

  formSuffixFor = dex: key:
    let
      padDex = padNum dex;
      entry  = pokespriteData.${padDex} or null;
      forms =
        if entry == null then []
        else
          let
            g8 = (entry."gen-8" or {}).forms or {};
            g7 = (entry."gen-7" or {}).forms or {};
          in builtins.filter (k: k != "$")
               (builtins.attrNames (g8 // g7));
      matching = builtins.filter
        (form:
          let suffix = "-" + form;
          in builtins.stringLength key > builtins.stringLength suffix
             && lib.hasSuffix suffix key)
        forms;
      sorted = builtins.sort
        (a: b: builtins.stringLength a > builtins.stringLength b) matching;
    in
    if sorted == [] then "" else "-" + builtins.head sorted;

  slugForDex = dex:
    let
      padDex = padNum dex;
      entry  = pokespriteData.${padDex} or null;
    in
    if entry == null then null else entry.slug.eng;

  autoSprite = dex: key: shiny:
    let
      padDex   = padNum dex;
      baseName = let s = slugForDex dex; in if s != null then s else key;
      suffix   = formSuffixFor dex key;
      variant  = if shiny then "shiny" else "regular";
      candidates = [
        "sprites/pokemon-gen9/${variant}/${baseName}${suffix}.png"
        "sprites/pokemon-gen8/${variant}/${baseName}${suffix}.png"
        "sprites/pokemon-gen7x/${variant}/${baseName}${suffix}.png"
        "sprites/pokemon-gen9/${variant}/${key}.png"
        "sprites/pokemon-gen8/${variant}/${key}.png"
        "sprites/pokemon-gen7x/${variant}/${key}.png"
        "sprites/pokemon-gen9/${variant}/${baseName}.png"
        "sprites/pokemon-gen8/${variant}/${baseName}.png"
        "sprites/pokemon-gen7x/${variant}/${baseName}.png"
      ];
      unique = lib.unique candidates;
      hits = builtins.filter (p: builtins.pathExists (./. + "/${p}")) unique;
    in
    if hits == [] then null else builtins.head hits;

  balls = [
    "safari" "sport" "fast" "friend" "heavy" "level"
    "love" "lure" "moon" "dream" "beast"
  ];
  allBalls = balls;

  mkRo = type: value: { inherit type; default = value; apply = _: value; };

  ballModule = legal: { config, ... }: {
    options = {
      possible = mkOption {
        type        = types.bool;
        default     = legal;
        description = "Whether this ball is legal for this species. Auto-computed from the species' `balls` list — do not set manually.";
        example     = legal;
      };
      ball = mkOption {
        type        = types.bool;
        default     = false;
        description = "Whether you have this species caught in this ball. Implied true if `ha = true`.";
        example     = true;
      };
      ha = mkOption {
        type        = types.bool;
        default     = false;
        description = "Whether the caught specimen has its Hidden Ability. Implied true if `eggMoves = true`.";
        example     = true;
      };
      eggMoves = mkOption {
        type        = types.bool;
        default     = false;
        description = "Whether the caught specimen has all its egg moves. Implies `ball` and `ha`.";
        example     = true;
      };
    };
    config = {
      ball = mkIf config.ha       true;
      ha   = mkIf config.eggMoves true;
    };
  };

  speciesModule = name: e: {
    options = {
      dex = mkOption {
        type        = types.int;
        default     = e.dex;
        description = "National Pokédex number. Auto-set from the breedable data — do not override unless fixing a data error.";
        example     = e.dex;
      };
      name = mkOption {
        type        = types.str;
        default     = name;
        description = "Display name shown in the breedables table. Auto-set from the breedable key — override only for spelling fixes.";
        example     = name;
      };
      ha = mkOption {
        type        = types.str;
        default     = e.ha;
        description = "Name of the Hidden Ability. Auto-set from the breedable data.";
        example     = e.ha;
      };
      serebii = mkOption {
        type        = types.str;
        default     = e.serebii or ("https://www.serebii.net/pokedex-swsh/${e.slug or name}/");
        description = "Serebii Pokédex URL opened when the dex number is hovered. Auto-computed from the slug — override only to point at a different source.";
        example     = "https://www.serebii.net/pokedex-swsh/bulbasaur/";
      };
      sprite = mkOption {
        type        = types.nullOr types.str;
        default     = null;
        description = "Custom sprite path (relative to module root). Leave unset to auto-resolve via `autoSprite`.";
        example     = "sprites/pokemon-gen8/regular/bulbasaur.png";
      };
      genderless = mkOption {
        type        = types.bool;
        default     = false;
        description = "Whether this species has no gender. Auto-set from breedable data.";
        example     = false;
      };
      male = mkOption {
        type        = types.nullOr (types.either types.int types.float);
        default     = null;
        description = "Male gender ratio (0–100). Auto-set from breedable data.";
        example     = 87.5;
      };
      female = mkOption {
        type        = types.nullOr (types.either types.int types.float);
        default     = null;
        description = "Female gender ratio (0–100). Auto-set from breedable data.";
        example     = 12.5;
      };
      hatchCycles = mkOption {
        type        = types.nullOr types.int;
        default     = null;
        description = "Number of egg cycles needed to hatch. Auto-set from breedable data.";
        example     = 20;
      };
    } // genAttrs balls (b: mkOption {
      type    = types.submodule (ballModule (builtins.elem b (e.balls or allBalls)));
      default = {};
    });
  };

  data      = import ./breedables { };
  shinyData = import ./shiny { };

  eventModule = { ... }: {
    options = {
      species = mkOption {
        type        = types.str;
        description = "Species identifier — a breedable key (`jirachi`) or free-form id for event-only Pokémon (`walking-wake`). Used to auto-resolve dex, sprite, and display name.";
        example     = "jirachi";
      };
      dex = mkOption {
        type        = types.nullOr types.int;
        default     = null;
        description = "National Pokédex number. Auto-resolved from the breedables entry if unset; required for species not in the breedables list.";
        example     = 385;
      };
      sprite = mkOption {
        type        = types.nullOr types.str;
        default     = null;
        description = "Custom sprite path (relative to module root). Leave unset to use the auto-resolved sprite.";
        example     = "sprites/pokemon-gen8/shiny/385.png";
      };
      name = mkOption {
        type        = types.nullOr types.str;
        default     = null;
        description = "Display name shown in the events list. Falls back to the breedable's name or the raw species key.";
        example     = "Jirachi";
      };
      ball = mkOption {
        type        = types.nullOr types.str;
        default     = "cherish";
        description = "Ball sprite rendered next to the event. Matches `sprites/balls/<ball>.png` (`pokeball` maps to `poke.png`).";
        example     = "cherish";
      };
      shiny = mkOption {
        type        = types.bool;
        default     = false;
        description = "Whether this event Pokémon is shiny. Affects sprite lookup (shiny/ vs regular/) and the ✨ column.";
        example     = true;
      };
      selfObtained = mkOption {
        type        = types.bool;
        default     = false;
        description = "True if you obtained this yourself; false for trades. Drives the ✓ column on the events page.";
        example     = false;
      };
      year = mkOption {
        type        = types.nullOr types.str;
        default     = null;
        description = "Year of the distribution or event. Rendered in the Year column.";
        example     = "2003";
      };
      ot = mkOption {
        type        = types.nullOr types.str;
        default     = null;
        description = "Original Trainer name.";
        example     = "WISHMKR";
      };
      id = mkOption {
        type        = types.nullOr types.str;
        default     = null;
        description = "Trainer ID (5–6 digit string). Rendered in the expanded details.";
        example     = "20043";
      };
      region = mkOption {
        type        = types.nullOr types.str;
        default     = null;
        description = "Region/language code — `ENG`, `JPN`, `GER`, `KOR`, `SPA`, `ITA`, `FRE`, `CHT`, `CHS`.";
        example     = "ENG";
      };
      notes = mkOption {
        type        = types.nullOr types.str;
        default     = null;
        description = "Free-form event notes — distribution name, source, anything worth remembering.";
        example     = "WiSHMKR GameCube distribution";
      };
      proof = mkOption {
        type        = types.nullOr types.str;
        default     = null;
        description = "Proof of legitimacy — WC photo, video, trade receipt, etc.";
        example     = "WC photo in /proofs/jirachi-wishmkr.png";
      };
      obtained = mkOption {
        type        = types.nullOr types.str;
        default     = null;
        description = "Date obtained. Free-form, `YYYY/MM/DD` recommended.";
        example     = "2021/02/16";
      };
      moves = mkOption {
        type        = types.listOf types.str;
        default     = [];
        description = "Moveset at the time of the event. Rendered joined with ` · ` in the expanded details.";
        example     = [ "Wish" "Confusion" "Rest" "Doom Desire" ];
      };
      tradeHistory = mkOption {
        type        = types.nullOr types.str;
        default     = null;
        description = "Chain of trades that led to you owning this Pokémon.";
        example     = "GoroMajimaIsMyIdol#8508 > pungkula";
      };
    };
  };

  statModule = { ... }: {
    options = {
      hp  = mkOption { type = types.nullOr types.int; default = null; description = "HP stat value (0–252 for EVs, 0–31 for IVs)."; example = 4; };
      atk = mkOption { type = types.nullOr types.int; default = null; description = "Attack stat value (0–252 for EVs, 0–31 for IVs)."; example = 0; };
      def = mkOption { type = types.nullOr types.int; default = null; description = "Defense stat value (0–252 for EVs, 0–31 for IVs)."; example = 0; };
      spa = mkOption { type = types.nullOr types.int; default = null; description = "Special Attack stat value (0–252 for EVs, 0–31 for IVs)."; example = 252; };
      spd = mkOption { type = types.nullOr types.int; default = null; description = "Special Defense stat value (0–252 for EVs, 0–31 for IVs)."; example = 0; };
      spe = mkOption { type = types.nullOr types.int; default = null; description = "Speed stat value (0–252 for EVs, 0–31 for IVs)."; example = 252; };
    };
  };

  specialModule = { ... }: {
    options = {
      species = mkOption {
        type        = types.str;
        description = "Species identifier — a breedable key (`mewtwo`) or free-form id for unique forms. Used to auto-resolve dex, sprite, and display name.";
        example     = "mewtwo";
      };
      dex = mkOption {
        type        = types.nullOr types.int;
        default     = null;
        description = "National Pokédex number. Auto-resolved from breedables if unset; required for paradox/PLA-only species.";
        example     = 150;
      };
      sprite = mkOption {
        type        = types.nullOr types.str;
        default     = null;
        description = "Custom sprite path (relative to module root). Leave unset to use the auto-resolved sprite.";
        example     = "sprites/pokemon-gen8/shiny/150.png";
      };
      name = mkOption {
        type        = types.nullOr types.str;
        default     = null;
        description = "Display name. Falls back to the breedable's name or the species key.";
        example     = "Mewtwo";
      };
      ball = mkOption {
        type        = types.nullOr types.str;
        default     = null;
        description = "Ball sprite rendered next to the Pokémon. Matches `sprites/balls/<ball>.png`.";
        example     = "master";
      };
      shiny = mkOption {
        type        = types.bool;
        default     = false;
        description = "Whether this Pokémon is shiny. Affects sprite lookup and the ✨ column.";
        example     = true;
      };
      selfObtained = mkOption {
        type        = types.bool;
        default     = false;
        description = "True if obtained yourself; false for trades.";
        example     = true;
      };
      level = mkOption {
        type        = types.nullOr types.int;
        default     = null;
        description = "Current level (1–100). Rendered in the Level column.";
        example     = 100;
      };
      nature = mkOption {
        type        = types.nullOr types.str;
        default     = null;
        description = "Nature — `Timid`, `Adamant`, `Jolly`, `Modest`, etc.";
        example     = "Timid";
      };
      ability = mkOption {
        type        = types.nullOr types.str;
        default     = null;
        description = "Ability name. Include `(Hidden)` suffix if the Hidden Ability.";
        example     = "Pressure";
      };
      heldItem = mkOption {
        type        = types.nullOr types.str;
        default     = null;
        description = "Item currently held.";
        example     = "Life Orb";
      };
      teraType = mkOption {
        type        = types.nullOr types.str;
        default     = null;
        description = "Tera Type (Gen 9 only). One of the 18 types.";
        example     = "Psychic";
      };
      evs = mkOption {
        type        = types.submodule statModule;
        default     = {};
        description = "EV spread. Each stat 0–252, total ≤ 508. Leave unset for untrained.";
        example     = { hp = 4; spa = 252; spe = 252; };
      };
      ivs = mkOption {
        type        = types.submodule statModule;
        default     = {}; 
        description = "IV spread. Each stat 0–31. Leave unset for unknown / not-recorded.";
        example     = { hp = 31; atk = 0; def = 31; spa = 31; spd = 31; spe = 31; };
      };
      moves = mkOption {
        type        = types.listOf types.str;
        default     = [];
        description = "Current moveset (up to 4 moves). Rendered joined with ` · `.";
        example     = [ "Psystrike" "Aura Sphere" "Ice Beam" "Calm Mind" ];
      };
      marks = mkOption {
        type        = types.listOf types.str;
        default     = [];
        description = "Marks earned (Gen 8+) — `The Unrivaled`, `The Recluse`, `Itemfinder`, etc.";
        example     = [ "The Unrivaled" "Itemfinder" ];
      };
      ribbons = mkOption {
        type        = types.listOf types.str;
        default     = [];
        description = "Ribbons earned — `Effort Ribbon`, `Master Rank Ribbon`, `Best Friends Ribbon`, etc.";
        example     = [ "Effort Ribbon" "Master Rank Ribbon" ];
      };
      ot = mkOption {
        type        = types.nullOr types.str;
        default     = null;
        description = "Original Trainer name.";
        example     = "pungkula";
      };
      id = mkOption {
        type        = types.nullOr types.str;
        default     = null;
        description = "Trainer ID (5–6 digit string).";
        example     = "082409";
      };
      region = mkOption {
        type        = types.nullOr types.str;
        default     = null;
        description = "Region/language code — `ENG`, `JPN`, `GER`, `KOR`, `SPA`, `ITA`, etc.";
        example     = "ENG";
      };
      obtained = mkOption {
        type        = types.nullOr types.str;
        default     = null;
        description = "Date obtained. Free-form, `YYYY/MM/DD` recommended.";
        example     = "2023/08/15";
      };
      notes = mkOption {
        type        = types.nullOr types.str;
        default     = null;
        description = "Free-form notes — origin, what makes it special, etc.";
        example     = "Soft-reset 3 days, Timid sync";
      };
      proof = mkOption {
        type        = types.nullOr types.str;
        default     = null;
        description = "Proof of legitimacy — WC photo, video, screenshot, etc.";
        example     = "Video in /proofs/mewtwo.mp4";
      };
      tradeHistory = mkOption {
        type        = types.nullOr types.str;
        default     = null;
        description = "Chain of trades that led to you owning this Pokémon.";
        example     = "Alto#0457 > pungkula";
      };
    };
  };

in {
  options.pokenix.breedables = mkOption {
    description = ''
      Breeding tracker — one entry per species, one ball slot per apricorn ball. Shows
      **possible** (dim), **caught** (grey ring), **+ HA** (blue ring), or **HA + egg
      moves** (green ring) for each combination. Click owned balls and press
      `Ctrl+C` to copy the selection as a plain-text list.
    '';
    type = types.submodule {
      options = genAttrs (builtins.attrNames data) (n: mkOption {
        type    = types.submodule (speciesModule n data.${n});
        default = {};
      });
    };
    default = {};
    example = {
      bulbasaur  = lib.genAttrs balls (_: { ball = true; ha = true; eggMoves = true; });
      charmander = lib.genAttrs balls (_: { ball = true; ha = true; });
    };
  };

  options.pokenix.events = mkOption {
    description = ''
      Tracked event Pokémon. Each entry is a distibuted event you've redeemed —
      GameStop/GAME/JP distributions, movie events, HOME gifts, etc. Appears on
      the **events** page.
    '';
    type = types.attrsOf (types.submodule eventModule);
    default = {};
    example = {
      "jirachi-2003-wishmkr" = {
        species = "jirachi";
        ball    = "cherish";
        shiny   = true;
        year    = "2003";
        ot      = "WISHMKR";
        id      = "20043";
        region  = "ENG";
        moves   = [ "Wish" "Confusion" "Rest" "Doom Desire" ];
      };
    };
  };

  options.pokenix.shiny = mkOption {
    description = ''
      Shiny living dex progress. One entry per locked target — dex number, name,
      and sprite are fixed by `shiny/*.nix` data files. You only fill in **ball**,
      **notes**, **ot**, **egg**, and **style**. Progress counter (N/M · P%) appears
      in the sticky header on the **shiny living** page.
    '';
    type = types.submodule {
      options = genAttrs (builtins.attrNames shinyData) (n: mkOption {
        type = types.submodule {
          options = {
            ball = mkOption {
              type        = types.nullOr types.str;
              default     = null;
              description = "Ball caught in. `null` (default) means not owned — the row renders dimmed. Any string implies ownership.";
              example     = "luxury";
            };
            notes = mkOption {
              type        = types.nullOr types.str;
              default     = null;
              description = "Free-form note shown in the Notes column.";
              example     = "Self-bred, MM 42 eggs";
            };
            ot = mkOption {
              type        = types.bool;
              default     = false;
              description = "True if you are the Original Trainer. Drives the ✓ in the OT column.";
              example     = true;
            };
            egg = mkOption {
              type        = types.bool;
              default     = false;
              description = "True if obtained as an egg. Drives the ✓ in the Egg column. Renders `—` for non-eggable mons (legendaries).";
              example     = true;
            };
            style = mkOption {
              type        = types.enum [ "star" "square" ];
              default     = "star";
              description = "Sparkle glyph — `★` (star, default) or `▣` (square, BDSP-style).";
              example     = "square";
            };
          };
        };
        default = {};
      });
    };
    default = {};
    example = {
      bulbasaur = { ball = "moon"; style = "star";   ot = true; egg = true; };
      mewtwo    = { ball = "beast"; style = "square"; ot = true; };
    };
  };

  options.pokenix.specials = mkOption {
    description = ''
      Hand-curated special Pokémon — anything you want to document with full stats
      (level, nature, ability, EVs, IVs, marks, ribbons, moves, etc.). Appears on
      the specials page. Use this for competitive-ready mons, memory-keeping
      mons, or anything not covered by breeding/shiny/event tracking.
    '';
    type = types.attrsOf (types.submodule specialModule);
    default = {};
    example = {
      "mewtwo-ribbon-master" = {
        species = "mewtwo";
        ball    = "master";
        shiny   = true;
        level   = 100;
        nature  = "Timid";
        ability = "Pressure";
        evs     = { hp = 4; spa = 252; spe = 252; };
        ivs     = { hp = 31; atk = 0; def = 31; spa = 31; spd = 31; spe = 31; };
        moves   = [ "Psystrike" "Aura Sphere" "Ice Beam" "Calm Mind" ];
        ribbons = [ "Effort Ribbon" "Master Rank Ribbon" ];
      };
    };
  };

  options.pokenix.trainer = mkOption {
    description = ''
      Trainer profile shown on the **trainer** page. Set `name` to override the
      **PokèNix** brand text in the header. All fields are optional; anything
      unset is silently omitted.
    '';
    type = types.submodule {
      options = {
        picture = mkOption {
          type        = types.nullOr types.path;
          default     = null;
          description = "Avatar shown at the top of the trainer card. PNG/JPG/WEBP/GIF — mime detected from extension. Base64-embedded; no external asset needed.";
          example     = ./images/me.png;
        };
        name = mkOption {
          type        = types.nullOr types.str;
          default     = null;
          description = "Trainer name. Replaces the `PokèNix` brand text in the sticky header on every page.";
          example     = "pungkula";
        };
        about = mkOption {
          type        = types.nullOr types.str;
          default     = null;
          description = "Short bio / one-liner shown under the name on the trainer card.";
          example     = "Shiny hunter · gen 1–5 done";
        };
        region = mkOption {
          type        = types.nullOr types.str;
          default     = null;
          description = "Location or region, free-form.";
          example     = "Sweden";
        };
        timezone = mkOption {
          type        = types.nullOr types.str;
          default     = null;
          description = "IANA timezone — useful for scheduling trades.";
          example     = "Europe/Stockholm";
        };
        contact = mkOption {
          type        = types.nullOr types.str;
          default     = null;
          description = "Contact info — Discord handle, email, social media, etc.";
          example     = "Discord pungkula#0001";
        };
        friendCode = mkOption {
          type        = types.nullOr types.str;
          default     = null;
          description = "Nintendo Switch friend code.";
          example     = "SW-1234-5678-9012";
        };
        switchName = mkOption {
          type        = types.nullOr types.str;
          default     = null;
          description = "Nintendo Switch profile name.";
          example     = "pungkula";
        };
        trainerId = mkOption {
          type        = types.nullOr types.str;
          default     = null;
          description = "In-game Trainer ID.";
          example     = "082409";
        };
        secretId = mkOption {
          type        = types.nullOr types.str;
          default     = null;
          description = "In-game Secret ID (SID). Usually not shared publicly — remove from your config if privacy-sensitive.";
          example     = "12345";
        };
      };
    };
    default = {};
    example = {
      name       = "pungkula";
      about      = "Shiny hunter";
      region     = "Sweden";
      timezone   = "Europe/Stockholm";
      contact    = "Discord pungkula#0001";
      friendCode = "SW-1234-5678-9012";
    };
  };

  options.pokenix.html = mkOption {
    type        = types.package;
    description = "Self-contained HTML site (five pages: breedables, trainer, shiny, events, specials) — computed by `build.nix`. Not user-settable.";
  };


  options.pokenix.stats = {
    shinyOwned = mkOption {
      type        = types.int;
      default     = 0;
      #readOnly    = true;
      description = "Number of shiny Pokémon marked as owned (ball ≠ null).";
    };
    shinyTotal = mkOption {
      type        = types.int;
      default     = 0;
      #readOnly    = true;
      description = "Total shiny Pokémon tracked in the living dex.";
    };
    eventCount = mkOption {
      type        = types.int;
      default     = 0;
      #readOnly    = true;
      description = "Number of event Pokémon recorded.";
    };
    specialsCount = mkOption {
      type        = types.int;
      default     = 0;
      #readOnly    = true;
      description = "Number of special Pokémon recorded.";
    };
    aprimonsOwned = mkOption {
      type        = types.int;
      default     = 0;
      #readOnly    = true;
      description = "Breedable species with at least one ball marked as caught.";
    };
    aprimonsTotal = mkOption {
      type        = types.int;
      default     = 0;
      #readOnly    = true;
      description = "Total breedable species tracked.";
    };
    ballCaptures = mkOption {
      type        = types.int;
      default     = 0;
      #readOnly    = true;
      description = "Total (species × ball) captures across every breedable.";
    };
    ballPossible = mkOption {
      type        = types.int;
      default     = 0;
      # readOnly = true; 
      description = "Total legal (species × ball) combinations across every breedable.";
    };
    totalMons = mkOption {
      type        = types.int;
      default     = 0;
      # readOnly = true; 
      description = "Sum of shinyOwned + eventCount + specialsCount + aprimonsOwned.";
    };
  };

  options.pokenix.debug = mkOption {
    type        = types.anything;
    description = "Diagnostic values for sprite resolution and coverage — computed by `build.nix`. Inspect with `nix eval .#debug.x86_64-linux`. Not user-settable.";

  };}
