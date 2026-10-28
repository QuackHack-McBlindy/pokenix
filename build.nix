{ 
  lib,
  pkgs
} : cfg:
let
  inherit (lib)
    mkOption types genAttrs mkIf concatStringsSep filterAttrs
    mapAttrsToList fixedWidthString;

  projectToml = builtins.fromTOML (builtins.readFile ./project.toml);
  version     = projectToml.project.version;

  pokespriteData = builtins.fromJSON (builtins.readFile ./data/pokemon.json);

  rawBreedables = import ./breedables { };

  movesRaw =
    let p = ./moves.json;
    in if builtins.pathExists p then builtins.fromJSON (builtins.readFile p) else { };

  pokemonRaw =
    let
      paths = [ ./pokemon.json ./data/pokemon-fetch.json ];
      hits  = builtins.filter (p: builtins.pathExists p) paths;
    in if hits == [] then { } else builtins.fromJSON (builtins.readFile (builtins.head hits));

  moveInfoRaw =
    let
      paths = [ ./data/move-info.json ./move-info.json ];
      hits  = builtins.filter (p: builtins.pathExists p) paths;
    in if hits == [] then { } else builtins.fromJSON (builtins.readFile (builtins.head hits));

  pokemonEntryFor = name:
    let
      parts = lib.splitString "-" name;
      go = n:
        let candidate = lib.concatStringsSep "-" (lib.take n parts);
        in if builtins.hasAttr candidate pokemonRaw
           then pokemonRaw.${candidate}
           else if n <= 1 then { }
           else go (n - 1);
    in go (builtins.length parts);

  movesEntryFor = name:
    let
      parts = lib.splitString "-" name;
      go = n:
        let candidate = lib.concatStringsSep "-" (lib.take n parts);
        in if builtins.hasAttr candidate movesRaw
           then movesRaw.${candidate}
           else if n <= 1 then { }
           else go (n - 1);
    in go (builtins.length parts);

  breedMeta = name:
    let raw = rawBreedables.${name} or { };
        m   = movesEntryFor name;
        p   = pokemonEntryFor name;
    in {
      genderless     = raw.genderless     or false;
      male           = raw.male           or null;
      female         = raw.female         or null;
      hatchCycles    = raw.hatchCycles    or null;
      ha             = raw.ha             or "";
      eggMoves       = raw.eggMoves       or (m.egg   or [ ]);
      levelMoves     = raw.levelMoves     or (m.level or [ ]);
      types          = raw.types          or (p.types          or [ ]);
      cries          = raw.cries          or (p.cries          or null);
      eggGroups      = raw.eggGroups      or (p.eggGroups      or [ ]);
      isLegendary    = raw.isLegendary    or (p.isLegendary    or false);
      isMythical     = raw.isMythical     or (p.isMythical     or false);
      isBaby         = raw.isBaby         or (p.isBaby         or false);
      flavorText     = raw.flavorText     or (p.flavorText     or null);
      height         = raw.height         or (p.height         or null);
      weight         = raw.weight         or (p.weight         or null);
      growthRate     = raw.growthRate     or (p.growthRate     or null);
      captureRate    = raw.captureRate    or (p.captureRate    or null);
      baseHappiness  = raw.baseHappiness  or (p.baseHappiness  or null);
      evolutionSteps = raw.evolutionSteps or (p.evolutionSteps or [ ]);
    };

  shinyStatsSp = k: entry:
    let e = cfg.shiny.${k};
    in {
      dex    = entry.dex;
      level  = e.level  or null;
      nature = e.nature or null;
      evs    = e.evs    or { };
      ivs    = e.ivs    or { };
    };

  breedSpFor = s: {
    dex    = s.dex;
    level  = 100;
    nature = "hardy";
    evs    = { };
    ivs    = { hp = 31; atk = 31; def = 31; spa = 31; spd = 31; spe = 31; };
  };

  globalIndex = {
    breedables = builtins.map (n: {
      name = cfg.breedables.${n}.name;
      dex  = cfg.breedables.${n}.dex;
      key  = n;
      page = "index.html";
    }) sortedNames;
    shiny = builtins.map (k: {
      name = shinyData.${k}.name;
      dex  = shinyData.${k}.dex;
      key  = k;
      page = "shiny.html";
    }) (builtins.attrNames shinyData);
    events = builtins.map (k: {
      name = evtName cfg.events.${k};
      dex  = evtDex  cfg.events.${k};
      key  = k;
      page = "events.html";
    }) (builtins.attrNames cfg.events);
    specials = builtins.map (k: {
      name = evtName cfg.specials.${k};
      dex  = evtDex  cfg.specials.${k};
      key  = k;
      page = "specials.html";
    }) (builtins.attrNames cfg.specials);
  };

  loadShiny = path:
    let v = import path;
    in if builtins.isFunction v then v { } else v;

  shinyData =
    (loadShiny ./shiny/kanto.nix)
    // (loadShiny ./shiny/johto.nix)
    // (loadShiny ./shiny/hoenn.nix)
    // (loadShiny ./shiny/sinnoh.nix)
    // (loadShiny ./shiny/unova.nix)
    // (loadShiny ./shiny/kalos.nix)
    // (loadShiny ./shiny/alola.nix)
    // (loadShiny ./shiny/galar.nix)
    // (loadShiny ./shiny/paldea.nix);

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

  autoShinySprite = entry:
    let
      slug   = entry.slug;
      female = (entry.gender or null) == "f";
      femaleFirst = if female then [
        "sprites/pokemon-gen9/shiny/female/${slug}.png"
        "sprites/pokemon-gen8/shiny/female/${slug}.png"
        "sprites/pokemon-gen7x/shiny/female/${slug}.png"
        "sprites/pokemon-gen9/regular/female/${slug}.png"
        "sprites/pokemon-gen8/regular/female/${slug}.png"
        "sprites/pokemon-gen7x/regular/female/${slug}.png"
      ] else [];
      base = [
        "sprites/pokemon-gen9/shiny/${slug}.png"
        "sprites/pokemon-gen8/shiny/${slug}.png"
        "sprites/pokemon-gen7x/shiny/${slug}.png"
        "sprites/pokemon-gen9/regular/${slug}.png"
        "sprites/pokemon-gen8/regular/${slug}.png"
        "sprites/pokemon-gen7x/regular/${slug}.png"
      ];
      unique = lib.unique (femaleFirst ++ base);
      hits = builtins.filter (p: builtins.pathExists (./. + "/${p}")) unique;
    in
    if hits == [] then null else builtins.head hits;

  eventBalls = [ "cherish" "pokeball" ];

  balls = [
    "safari" "sport" "fast" "friend" "heavy" "level"
    "love" "lure" "moon" "dream" "beast"
  ];

  regions = {
    "1" = "KANTO";   "2" = "JOHTO";  "3" = "HOENN";  "4" = "SINNOH";  "5" = "UNOVA";
    "6" = "KALOS";   "7" = "ALOLA";  "8" = "GALAR";  "9" = "PALDEA";
  };

  logoPath   = ./images/logo.png;
  logoExists = builtins.pathExists logoPath;

  resolveSpeciesKey = k:
    let
      parts = lib.splitString "-" k;
      n     = builtins.length parts;
      tryPrefix = i:
        if i <= 0 then null
        else
          let p = lib.concatStringsSep "-" (lib.take i parts);
          in if builtins.hasAttr p cfg.breedables
             then p
             else tryPrefix (i - 1);
    in tryPrefix n;

  lookupSpecies = k:
    let
      parts = lib.splitString "-" k;
      n     = builtins.length parts;
      tryB = i:
        if i <= 0 then null
        else
          let p = lib.concatStringsSep "-" (lib.take i parts);
          in if builtins.hasAttr p cfg.breedables
             then {
               key    = p;
               dex    = cfg.breedables.${p}.dex;
               name   = cfg.breedables.${p}.name;
               sprite = cfg.breedables.${p}.sprite;
             }
             else tryB (i - 1);
      tryS = i:
        if i <= 0 then null
        else
          let p = lib.concatStringsSep "-" (lib.take i parts);
          in if builtins.hasAttr p shinyData
             then {
               key    = p;
               dex    = shinyData.${p}.dex;
               name   = shinyData.${p}.name;
               sprite = null;
             }
             else tryS (i - 1);
      b = tryB n;
    in
    if b != null then b else tryS n;

  evtDex = e:
    if e.dex != null then e.dex
    else
      let lu = lookupSpecies e.species;
      in if lu != null then lu.dex else 0;

  evtName = e:
    if e.name != null then e.name
    else
      let lu = lookupSpecies e.species;
      in if lu != null then lu.name else e.species;

  evtSpriteFor = k: e: shiny:
    if e.sprite != null then e.sprite
    else
      let
        lu        = lookupSpecies e.species;
        spriteKey = if lu != null then lu.key else e.species;
      in
      if !shiny && lu != null && lu.sprite != null
      then lu.sprite
      else autoSprite (evtDex e) spriteKey shiny;

  evtSpriteExists = k: e: shiny:
    let sp = evtSpriteFor k e shiny; in
    sp != null && builtins.pathExists (./. + "/${sp}");

  breedableSpriteFor = n: s:
    if s.sprite != null then s.sprite
    else autoSprite s.dex n false;

  breedableSpriteExists = n: s:
    let sp = breedableSpriteFor n s;
    in sp != null && builtins.pathExists (./. + "/${sp}");

  spritePath   = s: if s.sprite == null then null else ./. + "/${s.sprite}";
  ballFile     = b: if b == "pokeball" then "poke" else b;
  ballPath     = b: ./. + "/sprites/balls/${ballFile b}.png";
  spriteExists = s: s.sprite != null && builtins.pathExists (spritePath s);
  ballExists   = b: builtins.pathExists (ballPath b);

  picMime = p:
    let s = lib.toLower (toString p);
    in if lib.hasSuffix ".jpg" s || lib.hasSuffix ".jpeg" s then "image/jpeg"
       else if lib.hasSuffix ".webp" s then "image/webp"
       else if lib.hasSuffix ".gif" s then "image/gif"
       else "image/png";

  keyFor = name:
    lib.replaceStrings [ " " "'" "’" "/" "." ] [ "_" "" "" "_" "" ] name;

  markOverrides = {
    "the unrivaled" = "uncommon";
    "unrivaled"     = "uncommon";
    "uncommon"      = "uncommon";
    "the recluse"   = "rare";
    "recluse"       = "rare";
    "rare"          = "rare";
    "the teary-eyed" = "teary";
    "teary-eyed"    = "teary";
    "teary"         = "teary";
    "the sleepy-time" = "sleepy-time";
    "the early bird"  = "dawn";
    "the itemfinder"  = "itemfinder";
    "itemfinder"      = "itemfinder";
  };

  markSlug = name:
    let
      s = lib.toLower name;
    in
    if builtins.hasAttr s markOverrides then markOverrides.${s}
    else
      let stripped =
        if lib.hasPrefix "the " s then lib.removePrefix "the " s else s;
      in
      lib.replaceStrings [ " " "'" "’" "." ] [ "-" "" "" "" ] stripped;

  markFile = name: "sprites/misc/mark/${markSlug name}-mark.png";

  ribbonSlug = name:
    let
      s = lib.toLower name;
      s1 = if lib.hasSuffix " ribbon" s then lib.removeSuffix " ribbon" s else s;
    in
    lib.replaceStrings [ " " "'" "’" "." ] [ "-" "" "" "" ] s1;

  ribbonFileCandidates = name: [
    "sprites/misc/ribbon/${ribbonSlug name}-ribbon.png"
    "sprites/misc/ribbon/gen8/${ribbonSlug name}-ribbon.png"
  ];

  firstExisting = candidates:
    let hits = builtins.filter (p: builtins.pathExists (./. + "/${p}")) candidates;
    in if hits == [] then null else builtins.head hits;

  itemSlug = name:
    let
      s = lib.toLower name;
    in
    lib.replaceStrings [ " " "'" "’" "." ] [ "-" "" "" "" ] s;

  itemCandidates = name: [
    "sprites/items/hold-item/${itemSlug name}.png"
    "sprites/items/berry/${itemSlug name}.png"
  ];

  padNum = n:
    let
      s = toString n;
      w = if builtins.stringLength s > 3 then builtins.stringLength s else 3;
    in
    fixedWidthString w "0" s;

  padDex = s: padNum s.dex;

  formatRatio = x:
    if x == null then "—"
    else if builtins.isInt x then builtins.toString x
    else
      let
        scaled   = builtins.floor (x * 10 + 0.5);
        intPart  = scaled / 10;
        fracPart = scaled - (intPart * 10);
      in
        if fracPart == 0 then builtins.toString intPart
        else "${builtins.toString intPart}.${builtins.toString fracPart}";

  genOfDex = d:
    if d <= 151 then 1
    else if d <= 251 then 2
    else if d <= 386 then 3
    else if d <= 493 then 4
    else if d <= 649 then 5
    else if d <= 721 then 6
    else if d <= 809 then 7
    else if d <= 905 then 8
    else 9;

  maxNameLen = builtins.foldl'
    (acc: n:
      let l = builtins.stringLength cfg.breedables.${n}.name;
      in if l > acc then l else acc)
    0
    sortedNames;

  nameWidthCss = "${toString (maxNameLen + 3)}ch";

  shinyMaxNameLen = builtins.foldl'
    (acc: n:
      let l = builtins.stringLength shinyData.${n}.name;
      in if l > acc then l else acc)
    0
    (builtins.attrNames shinyData);

  shinyNameWidthCss = "${toString (shinyMaxNameLen + 3)}ch";

  typeIconKey    = t: lib.toLower t;
  typeIconPath   = t: "sprites/misc/types/gen8/${typeIconKey t}.png";
  typeIconExists = t: builtins.pathExists (./. + "/${typeIconPath t}");

  isGmax = s:
    let str = lib.toLower s;
    in lib.hasSuffix "-gmax" str || lib.hasInfix "(gmax)" str;

  stripGmax = n:
    let
      cleaned = builtins.replaceStrings
        [ " (Gmax)" " (GMAX)" " (gmax)" ]
        [ "" "" "" ]
        n;
      low = lib.toLower cleaned;
      len = builtins.stringLength cleaned;
    in
    if len > 5 && lib.hasSuffix "-gmax" low
    then lib.substring 0 (len - 5) cleaned
    else cleaned;

  gmaxIconPath   = "sprites/misc/special-attribute/gigantamax-icon.png";
  gmaxIconExists = builtins.pathExists (./. + "/${gmaxIconPath}");

  renderGmaxBadge = s:
    if !(isGmax s) || !gmaxIconExists then ""
    else ''<img class="gmax-badge" src="data:image/png;base64,@GMAX_ICON@" alt="Gmax" title="Gigantamax">'';

  nameWithGmax = n: species:
    stripGmax n + renderGmaxBadge "${n} ${species}";

  eggPath   = "sprites/pokemon-gen8/egg.png";
  eggExists = builtins.pathExists (./. + "/${eggPath}");

  baseStatsPath   = ./data/base-stats.json;
  baseStatsExists = builtins.pathExists baseStatsPath;
  baseStats       = if baseStatsExists
                    then builtins.fromJSON (builtins.readFile baseStatsPath)
                    else { };

  natures = {
    hardy   = { up = null;  down = null; };
    lonely  = { up = "atk"; down = "def"; };
    brave   = { up = "atk"; down = "spe"; };
    adamant = { up = "atk"; down = "spa"; };
    naughty = { up = "atk"; down = "spd"; };
    bold    = { up = "def"; down = "atk"; };
    docile  = { up = null;  down = null; };
    relaxed = { up = "def"; down = "spe"; };
    impish  = { up = "def"; down = "spa"; };
    lax     = { up = "def"; down = "spd"; };
    timid   = { up = "spe"; down = "atk"; };
    hasty   = { up = "spe"; down = "def"; };
    serious = { up = null;  down = null; };
    jolly   = { up = "spe"; down = "spa"; };
    naive   = { up = "spe"; down = "spd"; };
    modest  = { up = "spa"; down = "atk"; };
    mild    = { up = "spa"; down = "def"; };
    quiet   = { up = "spa"; down = "spe"; };
    bashful = { up = null;  down = null; };
    rash    = { up = "spa"; down = "spd"; };
    calm    = { up = "spd"; down = "atk"; };
    gentle  = { up = "spd"; down = "def"; };
    sassy   = { up = "spd"; down = "spe"; };
    careful = { up = "spd"; down = "spa"; };
    quirky  = { up = null;  down = null; };
  };

  computeStats = sp:
    let
      bs = baseStats.${toString (evtDex sp)} or null;
    in
    if bs == null then null
    else
      let
        lvl    = if sp.level != null then sp.level else 100;
        natKey = if sp.nature != null then lib.toLower sp.nature else "hardy";
        nat    = natures.${natKey} or { up = null; down = null; };
        mod = stat:
          if nat.up   == stat then 1.1
          else if nat.down == stat then 0.9
          else 1.0;

        evOf = s:
          if builtins.hasAttr s sp.evs && sp.evs.${s} != null
          then sp.evs.${s} else 0;
        ivOf = s:
          if builtins.hasAttr s sp.ivs && sp.ivs.${s} != null
          then sp.ivs.${s} else 31;

        baseAt = i: builtins.elemAt bs i;

        calcHp = base:
          if base == 1 then 1
          else builtins.floor
                 ((2 * base + ivOf "hp" + builtins.floor (evOf "hp" / 4)) * lvl / 100)
               + lvl + 10;

        calcOther = base: stat:
          builtins.floor (
            (builtins.floor
              ((2 * base + ivOf stat + builtins.floor (evOf stat / 4)) * lvl / 100)
             + 5)
            * mod stat
          );
      in {
        hp  = calcHp    (baseAt 0);
        atk = calcOther (baseAt 1) "atk";
        def = calcOther (baseAt 2) "def";
        spa = calcOther (baseAt 3) "spa";
        spd = calcOther (baseAt 4) "spd";
        spe = calcOther (baseAt 5) "spe";
      };

  renderCalculatedStats = sp:
    let
      s = computeStats sp;
    in
    if s == null then ""
    else
      let
        natKey = if sp.nature != null then lib.toLower sp.nature else "hardy";
        nat    = natures.${natKey} or { up = null; down = null; };
        cell = stat: val:
          if nat.up == stat
          then ''<span class="stat-up">${toString val}</span>''
          else if nat.down == stat
          then ''<span class="stat-down">${toString val}</span>''
          else toString val;
        lvlStr = toString (if sp.level != null then sp.level else 100);
      in ''
        <div class="detail detail-wide">
          <span class="detail-label">Stats · Lv ${lvlStr}</span>
          <span class="detail-value">
            HP ${toString s.hp} · Atk ${cell "atk" s.atk} · Def ${cell "def" s.def} · SpA ${cell "spa" s.spa} · SpD ${cell "spd" s.spd} · Spe ${cell "spe" s.spe}
          </span>
        </div>
      '';

  ballContentWidth = (builtins.length balls * 30) + ((builtins.length balls - 1) * 2);
  ballColumnWidth  = ballContentWidth + 16;

  breedColumns   = "56px 52px ${nameWidthCss} ${toString ballColumnWidth}px 140px 48px 80px 88px";
  eventColumns   = "56px 52px 48px minmax(${nameWidthCss}, 1fr) 44px 44px 88px 120px 88px 32px";
  specialColumns = "56px 52px 48px minmax(${nameWidthCss}, 1fr) 44px 44px 76px 100px 240px 32px";
  shinyColumns   = "56px 52px 48px minmax(${shinyNameWidthCss}, 1fr) minmax(120px, 2fr) 44px 82px 48px";

  sortedNames =
    let
      names = builtins.attrNames cfg.breedables;
      keyOf = n: { dex = cfg.breedables.${n}.dex; name = n; };
    in
    builtins.sort (a: b:
      let ka = keyOf a; kb = keyOf b; in
      if ka.dex != kb.dex then ka.dex < kb.dex
      else ka.name < kb.name
    ) names;

  totalCount        = builtins.length sortedNames;
  anyOwned          = s: builtins.any (b: s.${b}.ball) balls;
  ownedSpeciesCount = builtins.length
    (builtins.filter (n: anyOwned cfg.breedables.${n}) sortedNames);
  ballOwnedCount    = b:
    builtins.length
      (builtins.filter (n: cfg.breedables.${n}.${b}.ball) sortedNames);
  totalCaptures     = builtins.foldl' (acc: b: acc + ballOwnedCount b) 0 balls;

  ballPossibleCount = b:
    builtins.length
      (builtins.filter (n: cfg.breedables.${n}.${b}.possible) sortedNames);
  totalPossibleCaptures = builtins.foldl' (acc: b: acc + ballPossibleCount b) 0 balls;

  eventCount    = builtins.length (builtins.attrNames cfg.events);
  specialsCount = builtins.length (builtins.attrNames cfg.specials);

  shinyTotalCount = builtins.length (builtins.attrNames shinyData);
  shinyOwnedCount = builtins.length (builtins.filter
    (n: cfg.shiny.${n}.ball != null)
    (builtins.attrNames shinyData));
  shinyPct = if shinyTotalCount == 0 then 0
    else (shinyOwnedCount * 100) / shinyTotalCount;

  trainerFieldCount = builtins.length (builtins.filter (v: v != null && v != "") [
    cfg.trainer.name cfg.trainer.about cfg.trainer.region cfg.trainer.timezone
    cfg.trainer.contact cfg.trainer.friendCode cfg.trainer.switchName
    cfg.trainer.trainerId cfg.trainer.secretId
  ]);

  trainerHasContent = cfg.trainer.picture != null || trainerFieldCount > 0;

  brandName = if cfg.trainer.name != null then cfg.trainer.name else "PokèNix";

  renderSprite = name: s:
    if breedableSpriteExists name s
    then ''<span class="cell-sprite"><img class="sprite" src="data:image/png;base64,@SPRITE_${name}@" alt="${name}"></span>''
    else ''<span class="cell-sprite"><svg class="sprite placeholder" viewBox="0 0 32 32"><rect width="32" height="32" fill="#2a2a2a"/><text x="16" y="21" font-size="9" text-anchor="middle" fill="#666">#${padDex s}</text></svg></span>'';

  renderDex = name: s: ''
    <span class="dex-wrap">
      <a class="dex" href="${s.serebii}" target="_blank" rel="noopener">#${padDex s}</a>
      <div class="dex-hover">
        <iframe src="${s.serebii}" loading="lazy" title="${s.name} on Serebii"></iframe>
        <div class="dex-hover-fallback">
          <div class="dhf-title">${s.name} · Serebii</div>
          <div class="dhf-url">${s.serebii}</div>
          <div class="dhf-hint">If the preview doesn't load, click to open in a new tab.</div>
        </div>
      </div>
    </span>
  '';

  renderGender = m:
    if m.genderless then ''<span class="gender" title="genderless"> </span>''
    else if m.female == null then ''<span class="gender" title="gender ratio not recorded">?</span>''
    else if m.female == 0 then ''<span class="gender male" title="male only">♂</span>''
    else ''<span class="gender female" title="${formatRatio m.female}% female">♀</span>'';

  renderRatio = m:
    if m.genderless then ''<span class="ratio">genderless</span>''
    else if m.female == null then ''<span class="ratio">—</span>''
    else if m.female == 0 then ''<span class="ratio">100%</span>''
    else if m.male == 0 then ''<span class="ratio">100%</span>''
    else ''<span class="ratio">${formatRatio m.female}%</span>'';

  renderCycles = m:
    if m.hatchCycles == null then ''<span class="cycles">—</span>''
    else ''<span class="cycles">${toString m.hatchCycles}</span>'';

  titleCaseSlug = slug:
    let cap = w:
      if w == "" then ""
      else lib.toUpper (builtins.substring 0 1 w)
           + builtins.substring 1 (builtins.stringLength w - 1) w;
    in concatStringsSep " " (map cap (lib.splitString "-" slug));

  moveInfo = slug: moveInfoRaw.${slug} or { };

  renderMovePill = slug:
    let
      info = moveInfo slug;
      name = info.name or (titleCaseSlug slug);
      typ  = info.type or "normal";
      cls  = info.damageClass or "status";
      pw   = info.power;
      acc  = info.accuracy;
      pp   = info.pp;
      eff  = info.effect or "";
      tip  = "${name} · ${typ}"
           + (if cls == "physical" then " · physical"
              else if cls == "special" then " · special"
              else " · status")
           + (if pw  != null then " · Power ${toString pw}" else "")
           + (if acc != null then " · Acc ${toString acc}%" else "")
           + (if pp  != null then " · PP ${toString pp}"    else "")
           + (if eff != ""   then "\n\n${eff}"              else "");
    in ''
      <span class="move-pill type-${typ} cls-${cls}" title="${tip}">
        <span class="move-name">${name}</span>
        ${lib.optionalString (pw != null) ''<span class="move-power">${toString pw}</span>''}
      </span>
    '';

  renderMoveList = label: slugs:
    if slugs == [] then ""
    else ''
      <div class="detail detail-wide">
        <span class="detail-label">${label} <span class="move-count">${toString (builtins.length slugs)}</span></span>
        <div class="move-grid">${concatStringsSep "" (map renderMovePill slugs)}</div>
      </div>
    '';

  renderTypeBadge = t:
    if t == null || t == "" then ""
    else ''
      <span class="type-badge type-${lib.toLower t}" title="${t}">${t}</span>
    '';

  renderTypeBadges = types:
    if types == [] then "" else concatStringsSep "" (map renderTypeBadge types);

  renderSpecialBadges = m:
    lib.optionalString m.isLegendary ''<span class="special-badge legendary" title="Legendary">L</span>''
    + lib.optionalString m.isMythical ''<span class="special-badge mythical" title="Mythical">M</span>''
    + lib.optionalString m.isBaby ''<span class="special-badge baby" title="Baby">B</span>'';

  renderBall = pname: bname: bc:
    if !bc.possible
    then ''<span class="ball unavailable" title="${bname} — not available"><span class="ball-x">✕</span></span>''
    else if !(ballExists bname) then ''<span class="ball missing" title="${bname} (sprite missing)"></span>''
    else
      let
        state =
          if !bc.ball       then "possible"
          else if bc.eggMoves then "em"
          else if bc.ha       then "ha"
          else                     "caught";
        label =
          if !bc.ball       then "possible"
          else if bc.eggMoves then "HA + egg moves"
          else if bc.ha       then "HA"
          else                     "caught";
        title = "${bname} — ${label}";
      in ''<span class="ball ${state}" title="${title}" data-pokemon="${pname}" data-ball="${bname}" data-state="${state}"><img src="data:image/png;base64,@BALL_${bname}@" alt="${bname}"></span>'';

  renderBalls = pname: s: concatStringsSep "" (map (b: renderBall pname b s.${b}) balls);

  renderCompleteStar = s:
    if builtins.any (b: s.${b}.eggMoves) balls
    then ''<span class="star" title="100% complete in at least one ball">★</span>''
    else "";

  renderCheck = val: title:
    if val
    then ''<span class="check yes" title="${title}">✓</span>''
    else ''<span class="check no" title="not ${title}"></span>'';

  renderEvtBall = e:
    if e.ball == null then ''<span class="event-ball-slot empty" title="no ball set"></span>''
    else if !(ballExists e.ball) then ''<span class="event-ball-slot missing" title="${e.ball} (sprite missing)"></span>''
    else ''<span class="event-ball-slot" title="${e.ball}"><img src="data:image/png;base64,@BALL_${e.ball}@" alt="${e.ball}"></span>'';

  renderEvtSprite = k: shiny: e:
    let
      d   = evtDex e;
      n   = evtName e;
      pad = padNum d;
      key = if shiny then "${k}-shiny" else k;
    in
    if evtSpriteExists k e shiny
    then ''<span class="cell-sprite"><img class="sprite" src="data:image/png;base64,@EVT_SPRITE_${key}@" alt="${n}"></span>''
    else ''<span class="cell-sprite"><svg class="sprite placeholder" viewBox="0 0 32 32"><rect width="32" height="32" fill="#2a2a2a"/><text x="16" y="21" font-size="9" text-anchor="middle" fill="#666">#${pad}</text></svg></span>'';

  renderDetail = label: value:
    let v = if value == null then null else toString value;
    in ''<div class="detail"><span class="detail-label">${label}</span><span class="detail-value">${if v == null || v == "" then "—" else v}</span></div>'';

  renderItemPill = kind: name:
    let
      candidates =
        if kind == "ribbon" then ribbonFileCandidates name
        else [ (markFile name) ];
      file = firstExisting candidates;
      key  = keyFor name;
      ph   = "@${lib.toUpper kind}_FILE_${key}@";
    in
    if file == null
    then ''<span class="${kind}-item">${name}</span>''
    else ''<span class="${kind}-item"><img class="${kind}-sprite" src="data:image/png;base64,${ph}" alt="" title="${name}"><span>${name}</span></span>'';

  renderPills = kind: label: items:
    if items == [] then ""
    else ''
      <div class="detail detail-wide">
        <span class="detail-label">${label}</span>
        <div class="pills">
          ${concatStringsSep "" (map (renderItemPill kind) items)}
        </div>
      </div>
    '';

  renderRibbonMarkStrip = sp:
    let
      ribbonImgs = builtins.filter
        (n: firstExisting (ribbonFileCandidates n) != null)
        sp.ribbons;
      markImgs = builtins.filter
        (n: firstExisting [ (markFile n) ] != null)
        sp.marks;
      renderImg = kind: name:
        let
          key = keyFor name;
          ph  = "@${lib.toUpper kind}_FILE_${key}@";
        in
        ''<img src="data:image/png;base64,${ph}" alt="" title="${name}">'';
    in
    if ribbonImgs == [] && markImgs == [] then ""
    else ''
      <span class="event-ribbon-strip">
        ${concatStringsSep "" (map (renderImg "mark")   markImgs)}
        ${concatStringsSep "" (map (renderImg "ribbon") ribbonImgs)}
      </span>
    '';

  renderItemDetail = value:
    if value == null || value == ""
    then renderDetail "Held Item" value
    else
      let
        file = firstExisting (itemCandidates value);
        key  = keyFor value;
        ph   = "@ITEM_FILE_${key}@";
      in
      if file == null
      then renderDetail "Held Item" value
      else ''
        <div class="detail">
          <span class="detail-label">Held Item</span>
          <span class="detail-value">
            <span class="item-pill">
              <img class="item-sprite" src="data:image/png;base64,${ph}" alt="" title="${value}">
              <span>${value}</span>
            </span>
          </span>
        </div>
      '';

  renderTypeDetail = label: type:
    if type == null || type == ""
    then renderDetail label type
    else if !(typeIconExists type)
    then renderDetail label type
    else ''
      <div class="detail">
        <span class="detail-label">${label}</span>
        <span class="detail-value">
          <span class="type-pill">
            <img class="type-sprite" src="data:image/png;base64,@TYPE_${typeIconKey type}@" alt="" title="${type}">
            <span>${type}</span>
          </span>
        </span>
      </div>
    '';

  renderEvent = k: shiny: e:
    let
      d   = evtDex e;
      n   = evtName e;
      pad = padNum d;
      y   = if e.year   != null then e.year   else "";
      o   = if e.ot     != null then e.ot     else "";
      r   = if e.region != null then e.region else "";
    in ''
      <details class="event" id="pk-${k}" data-dex="${pad}" data-name="${n}" data-year="${y}" data-ot="${o}" data-region="${r}">
        <summary class="event-row">
          <span class="event-dex">#${pad}</span>
          ${renderEvtSprite k shiny e}
          ${renderEvtBall e}
          <span class="event-name" title="${n}">${nameWithGmax n e.species}</span>
          ${renderCheck e.shiny "shiny"}
          ${renderCheck e.selfObtained "self obtained"}
          <span class="event-field">${if e.year   != null then e.year   else "—"}</span>
          <span class="event-field" title="${if e.ot != null then e.ot else ""}">${if e.ot != null then e.ot else "—"}</span>
          <span class="event-field">${if e.region != null then e.region else "—"}</span>
          <span class="event-chevron">▸</span>
        </summary>
        <div class="event-details">
          ${renderDetail "ID"             e.id}
          ${renderDetail "Obtained"       e.obtained}
          ${renderDetail "Proof"          e.proof}
          ${renderDetail "Moves"          (if e.moves == [] then null else concatStringsSep " · " e.moves)}
          ${renderDetail "Trade History"  e.tradeHistory}
          ${renderDetail "Event / Notes"  e.notes}
        </div>
      </details>
    '';

  renderEventList = shiny: evtSet: ''
    <div class="summary">${toString (builtins.length (builtins.attrNames evtSet))} entries</div>
    <div class="event-row event-header">
      <span class="event-dex" data-sort="dex">Dex</span>
      <span class="cell-sprite"></span>
      <span class="event-ball-slot"></span>
      <span class="event-name" data-sort="name">Pokémon</span>
      <span class="check header-check" title="shiny">✨</span>
      <span class="check header-check" title="self obtained">✓</span>
      <span class="event-field" data-sort="year">Year</span>
      <span class="event-field" data-sort="ot">OT</span>
      <span class="event-field" data-sort="region">Region</span>
      <span class="event-chevron"></span>
    </div>
    <div class="event-list">
    ${concatStringsSep "\n" (map (k: renderEvent k shiny evtSet.${k})
      (builtins.sort (a: b:
        let da = evtDex evtSet.${a}; db = evtDex evtSet.${b}; in
        if da != db then da < db else a < b
      ) (builtins.attrNames evtSet)))}
    </div>
  '';

  renderShinyRow = k: entry:
    let
      e          = cfg.shiny.${k};
      sprite     = autoShinySprite entry;
      hasSprite  = sprite != null && builtins.pathExists (./. + "/${sprite}");
      pad        = padNum entry.dex;
      owned      = e.ball != null;
      eggable    = entry.eggable or true;
      shinyIcon  = if e.style == "square" then "▣" else "★";
      ballCell   =
        if !owned then ''<span class="event-ball-slot empty"></span>''
        else if !(ballExists e.ball) then ''<span class="event-ball-slot missing" title="${e.ball} (sprite missing)"></span>''
        else ''<span class="event-ball-slot" title="${e.ball}"><img src="data:image/png;base64,@BALL_${e.ball}@" alt="${e.ball}"></span>'';
      otVal      = e.ot or null;
      otCell     = if otVal == true then ''<span class="check yes" title="OT">✓</span>'' else ''<span class="check no"></span>'';
      otDisplay  =
        if otVal == true then "self obtained"
        else if otVal == false then null
        else if otVal != null then toString otVal
        else null;
      eggFlag    = e.egg or false;
      eggCell =
        if !eggable then ''<span class="check na" title="not eggable">—</span>''
        else if eggFlag && eggExists
          then ''<span class="egg-slot" title="egg obtained"><img class="egg-sprite" src="data:image/png;base64,@EGG_SPRITE@" alt="egg"></span>''
        else if eggFlag
          then ''<span class="check yes" title="egg obtained">✓</span>''
        else ''<span class="check no" title="no egg"></span>'';
      movesVal   = e.moves   or [ ];
      marksVal   = e.marks   or [ ];
      ribbonsVal = e.ribbons or [ ];
    in ''
      <details class="shiny-row-details ${if owned then "owned" else "empty"}"
               id="pk-${k}" data-dex="${pad}" data-name="${entry.name}">
        <summary class="shiny-row">
          <span class="shiny-dex">#${pad}</span>
          ${if hasSprite
            then ''<span class="cell-sprite"><img class="sprite" src="data:image/png;base64,@SHINY_${k}@" alt="${entry.name}"></span>''
            else ''<span class="cell-sprite"><svg class="sprite placeholder" viewBox="0 0 32 32"><rect width="32" height="32" fill="#2a2a2a"/><text x="16" y="21" font-size="9" text-anchor="middle" fill="#666">#${pad}</text></svg></span>''}
          ${ballCell}
          <span class="shiny-name" title="${entry.name}">${nameWithGmax entry.name k}</span>
          <span class="shiny-notes">${if e.notes or null != null then e.notes else ""}</span>
          ${otCell}
          ${eggCell}
          <span class="shiny-style">${if owned then shinyIcon else ""}</span>
        </summary>
        <div class="entry-details">
          ${renderDetail "Original Trainer" otDisplay}
          ${renderDetail "Self Obtained"    (if e.selfObtained or false then "✓" else null)}
          ${renderDetail "Level"            (e.level  or null)}
          ${renderDetail "Nature"           (e.nature or null)}
          ${renderDetail "Ability"          (e.ability or null)}
          ${renderItemDetail (e.heldItem or null)}
          ${renderTypeDetail "Tera Type"    (e.teraType or null)}
          ${renderStatLine "EVs" (e.evs or { })}
          ${renderStatLine "IVs" (e.ivs or { })}
          ${renderCalculatedStats (shinyStatsSp k entry)}
          ${renderDetail "Moves" (if movesVal == [] then null else concatStringsSep " · " movesVal)}
          ${renderPills "mark"   "Marks"   marksVal}
          ${renderPills "ribbon" "Ribbons" ribbonsVal}
          ${renderDetail "Obtained"        (e.obtained or null)}
          ${renderDetail "Region"          (e.region or null)}
          ${renderDetail "ID"              (e.id or null)}
          ${renderDetail "Proof"           (e.proof or null)}
          ${renderDetail "Trade History"   (e.tradeHistory or null)}
          ${renderDetail "Notes"           (e.notes or null)}
        </div>
      </details>
    '';

  renderTrainerField = label: value:
    if value == null || value == "" then ""
    else ''
      <div class="trainer-field">
        <span class="trainer-field-label">${label}</span>
        <span class="trainer-field-value">${value}</span>
      </div>
    '';

  trainerStats = ''
    <div class="trainer-stats">
      <div class="stat">
        <span class="stat-value">${toString totalCaptures}<span class="stat-sub"> / ${toString totalPossibleCaptures}</span></span>
        <span class="stat-label">Aprimons Bred</span>
      </div>
      <div class="stat">
        <span class="stat-value">${toString shinyOwnedCount}<span class="stat-sub"> / ${toString shinyTotalCount}</span></span>
        <span class="stat-label">Shiny living · ${toString shinyPct}%</span>
      </div>
      <div class="stat">
        <span class="stat-value">${toString eventCount}</span>
        <span class="stat-label">Event Pokémon</span>
      </div>
      <div class="stat">
        <span class="stat-value">${toString specialsCount}</span>
        <span class="stat-label">Special Pokémon</span>
      </div>
    </div>
  '';

  trainerBody = ''
    <div class="trainer-card">
      ${if cfg.trainer.picture != null then ''
        <div class="trainer-pic-wrap">
          <img class="trainer-pic" src="data:${picMime cfg.trainer.picture};base64,@TRAINER_PIC@" alt="trainer picture">
        </div>
      '' else ""}
      ${if cfg.trainer.name != null then ''<h2 class="trainer-name">${cfg.trainer.name}</h2>'' else ""}
      ${if cfg.trainer.about != null then ''<p class="trainer-about">${cfg.trainer.about}</p>'' else ""}
      ${if !trainerHasContent then ''
        <p class="trainer-about" style="opacity:0.6; font-style:italic">
          No trainer profile configured — set <code>pokenix.trainer</code> to show your name, picture, and details here.
        </p>
      '' else ""}

      <h3 class="trainer-section-label">Collection at a glance</h3>
      ${trainerStats}

      ${if trainerHasContent then ''
        <h3 class="trainer-section-label">Trainer details</h3>
        <div class="trainer-fields">
          ${renderTrainerField "Region" cfg.trainer.region}
          ${renderTrainerField "Timezone" cfg.trainer.timezone}
          ${renderTrainerField "Contact" cfg.trainer.contact}
          ${renderTrainerField "Friend Code" cfg.trainer.friendCode}
          ${renderTrainerField "Switch" cfg.trainer.switchName}
          ${renderTrainerField "Trainer ID" cfg.trainer.trainerId}
          ${renderTrainerField "Secret ID" cfg.trainer.secretId}
        </div>
      '' else ""}
    </div>
  '';

  renderShinyList = ''
    <div class="summary">${toString shinyOwnedCount} / ${toString shinyTotalCount} collected (${toString shinyPct}%)</div>
    <div class="shiny-row shiny-header">
      <span class="shiny-dex" data-sort="dex">Dex</span>
      <span class="cell-sprite"></span>
      <span class="event-ball-slot"></span>
      <span class="shiny-name" data-sort="name">Pokémon</span>
      <span class="shiny-notes">Notes</span>
      <span class="check header-check" title="Original Trainer">OT</span>
      <span class="check header-check" title="Egg obtained">Egg</span>
      <span class="shiny-style" title="Shiny sparkle style">✨</span>
    </div>
    <div class="shiny-list">
      ${concatStringsSep "\n" (map (k: renderShinyRow k shinyData.${k})
        (builtins.sort
          (a: b:
            if shinyData.${a}.dex != shinyData.${b}.dex
            then shinyData.${a}.dex < shinyData.${b}.dex
            else a < b)
          (builtins.attrNames shinyData)))}
    </div>
  '';

  renderStatLine = label: stats:
    let
      get = s:
        if builtins.hasAttr s stats && stats.${s} != null
        then toString stats.${s}
        else "—";
      any = builtins.any
        (s: builtins.hasAttr s stats && stats.${s} != null)
        [ "hp" "atk" "def" "spa" "spd" "spe" ];
    in
    if !any then ""
    else ''
      <div class="detail detail-wide">
        <span class="detail-label">${label}</span>
        <span class="detail-value">
          HP ${get "hp"} · Atk ${get "atk"} · Def ${get "def"} · SpA ${get "spa"} · SpD ${get "spd"} · Spe ${get "spe"}
        </span>
      </div>
    '';

  renderSpecialRow = k: sp:
    let
      d   = evtDex sp;
      n   = evtName sp;
      pad = padNum d;
      movesStr   = if sp.moves   == [] then null else concatStringsSep " · " sp.moves;

      lvl   = if sp.level  != null then toString sp.level  else "";
      nat   = if sp.nature != null then sp.nature         else "";
    in ''
      <details class="event special" id="pk-${k}"
               data-dex="${pad}" data-name="${n}"
               data-level="${lvl}" data-nature="${nat}">
        <summary class="event-row special-row">
          <span class="event-dex">#${pad}</span>
          ${renderEvtSprite k sp.shiny sp}
          ${renderEvtBall sp}
          <span class="event-name" title="${n}">${nameWithGmax n sp.species}</span>
          ${renderCheck sp.shiny "shiny"}
          ${renderCheck sp.selfObtained "self obtained"}
          <span class="event-field">${if sp.level  != null then toString sp.level else "—"}</span>
          <span class="event-field" title="${if sp.nature != null then sp.nature else ""}">${if sp.nature != null then sp.nature else "—"}</span>
          ${renderRibbonMarkStrip sp}
          <span class="event-chevron">▸</span>
        </summary>
        <div class="event-details special-details">
          ${renderStatLine "EVs" sp.evs}
          ${renderStatLine "IVs" sp.ivs}
          ${renderCalculatedStats sp}
          ${renderDetail "Level"          sp.level}
          ${renderDetail "Nature"         sp.nature}
          ${renderDetail "Ability"        sp.ability}
          ${renderItemDetail sp.heldItem}
          ${renderTypeDetail "Tera Type"  sp.teraType}
          ${renderDetail "Moves"          movesStr}
          ${renderPills "mark"   "Marks"   sp.marks}
          ${renderPills "ribbon" "Ribbons" sp.ribbons}
          ${renderDetail "OT"             sp.ot}
          ${renderDetail "ID"             sp.id}
          ${renderDetail "Region"         sp.region}
          ${renderDetail "Obtained"       sp.obtained}
          ${renderDetail "Proof"          sp.proof}
          ${renderDetail "Trade History"  sp.tradeHistory}
          ${renderDetail "Notes"          sp.notes}
        </div>
      </details>
    '';

  renderSpecialList = evtSet: ''
    <div class="summary">${toString (builtins.length (builtins.attrNames evtSet))} entries</div>
    <div class="event-row event-header special-row">
      <span class="event-dex" data-sort="dex">Dex</span>
      <span class="cell-sprite"></span>
      <span class="event-ball-slot"></span>
      <span class="event-name" data-sort="name">Pokémon</span>
      <span class="check header-check" title="shiny">✨</span>
      <span class="check header-check" title="self obtained">✓</span>
      <span class="event-field" data-sort="level">Level</span>
      <span class="event-field" data-sort="nature">Nature</span>
      <span class="event-ribbon-strip ribbon-header-spacer" aria-hidden="true"></span>
      <span class="event-chevron"></span>
    </div>
    <div class="event-list">
    ${concatStringsSep "\n" (map (k: renderSpecialRow k evtSet.${k})
      (builtins.sort (a: b:
        let da = evtDex evtSet.${a}; db = evtDex evtSet.${b}; in
        if da != db then da < db else a < b
      ) (builtins.attrNames evtSet)))}
    </div>
  '';

  renderLevelMoves = label: entries:
    if entries == [] then ""
    else ''
      <div class="detail detail-wide">
        <span class="detail-label">${label}</span>
        <div class="level-moves">
          ${concatStringsSep "" (map (e: ''
            <div class="level-row">
              <span class="level-num">Lv ${toString e.level}</span>
              <span class="level-moves-list">${concatStringsSep " · " e.moves}</span>
            </div>
          '') entries)}
        </div>
      </div>
    '';

  speciesEntry = name: s:
    let m = breedMeta name;
    in ''
      <details class="breedable-row" id="pk-${name}" data-name="${s.name}" data-dex="${padDex s}">
        <summary class="entry ${if anyOwned s then "" else "untouched"}">
          ${renderDex name s}
          ${renderSprite name s}
          <span class="name" title="${s.name}">${s.name}${renderCompleteStar s}${renderSpecialBadges m}</span>
          <span class="balls">${renderBalls s.name s}</span>
          <span class="hidden-ability" title="${m.ha}">${m.ha}</span>
          ${renderGender m}
          ${renderRatio m}
          ${renderCycles m}
        </summary>
        <div class="entry-details">
          <div class="detail detail-wide">
            <span class="detail-label">Ball status</span>
            <div class="pills">
              ${concatStringsSep "" (map (b:
                let bc = s.${b};
                in if !bc.ball then ""
                   else ''
                     <span class="ball-status-pill">
                       ${if ballExists b
                         then ''<span class="ball"><img src="data:image/png;base64,@BALL_${b}@" alt="${b}"></span>''
                         else ''<span class="ball missing"></span>''}
                       <span>${b}: ${if bc.eggMoves then "HA + EM" else if bc.ha then "HA" else "caught"}</span>
                     </span>
                   ''
              ) balls)}
            </div>
          </div>
          ${renderMoveList "Egg Moves" m.eggMoves}
          ${renderDetail "Egg Groups" (if m.eggGroups == [] then null else concatStringsSep " · " m.eggGroups)}
          ${if m.types == [] then "" else ''
            <div class="detail"><span class="detail-label">Types</span>
              <span class="detail-value">${renderTypeBadges m.types}</span></div>
          ''}
          ${renderCalculatedStats (breedSpFor s)}
        </div>
      </details>
    '';

  navLink = currentPage: pageId: file: label:
    if currentPage == pageId
    then ''<span class="nav-current">${label}</span>''
    else ''<a href="${file}">${label}</a>'';

  navBar = currentPage: ''
    <h1>
      ${if logoExists then ''
        <a href="https://github.com/QuackHack-McBlindy/pokenix" class="logo-link" target="_blank" rel="noopener" title="pokenix on GitHub">
          <img class="logo" src="data:image/png;base64,@LOGO@" alt="PokèNix">
        </a>
      '' else ""}
      <span class="brand">${brandName}</span>
      <small>· ${navLink currentPage "trainer"    "trainer.html" "trainer"} · ${navLink currentPage "breedables" "index.html" "breedables"} · ${navLink currentPage "shiny" "shiny.html" "shiny living"} · ${navLink currentPage "events" "events.html" "events"} · ${navLink currentPage "specials" "specials.html" "specials"}</small>
      ${lib.optionalString (currentPage == "shiny") ''<span class="progress">${toString shinyOwnedCount}/${toString shinyTotalCount} · ${toString shinyPct}%</span>''}
      <span class="h1-right">
        ${lib.optionalString (currentPage != "trainer") ''
          <span class="search-wrap">
            <input type="text" id="search-input" class="tool-input"
                   placeholder="Search all Pokémon…" autocomplete="off" spellcheck="false">
            <div id="search-results" class="search-results"></div>
          </span>
        ''}
        ${lib.optionalString (currentPage == "breedables" || currentPage == "shiny") ''
          <button id="filter-toggle" class="tool-btn" type="button">Showing: all</button>
        ''}
        <button id="theme-toggle" class="theme-btn" type="button" title="Toggle theme">☀️</button>
        <a href="#" class="top-btn" onclick="window.scrollTo({top:0,behavior:'smooth'}); return false;">↑ Top</a>
      </span>
    </h1>
  '';

  sharedJs = ''
    (function() {
      function syncH1Height() {
        var h1 = document.querySelector('h1');
        if (h1) {
          document.documentElement.style.setProperty('--h1-h', h1.offsetHeight + 'px');
        }
      }
      window.addEventListener('DOMContentLoaded', syncH1Height);
      window.addEventListener('resize', syncH1Height);
      syncH1Height();

      var themeBtn = document.getElementById('theme-toggle');
      try {
        var savedTheme = localStorage.getItem('pokenix-theme');
        if (savedTheme === 'light' || savedTheme === 'dark') {
          document.documentElement.dataset.theme = savedTheme;
        }
      } catch (e) {}
      function updateThemeBtn() {
        if (!themeBtn) return;
        var t = document.documentElement.dataset.theme || 'dark';
        themeBtn.textContent = t === 'dark' ? '☀️' : '🌙';
        themeBtn.title = t === 'dark' ? 'Switch to light' : 'Switch to dark';
      }
      updateThemeBtn();
      if (themeBtn) {
        themeBtn.addEventListener('click', function() {
          var cur = document.documentElement.dataset.theme || 'dark';
          var next = cur === 'dark' ? 'light' : 'dark';
          document.documentElement.dataset.theme = next;
          try { localStorage.setItem('pokenix-theme', next); } catch (e) {}
          updateThemeBtn();
        });
      }

      document.querySelectorAll('.event-header [data-sort]').forEach(function(th) {
        th.style.cursor = 'pointer';
        th.addEventListener('click', function() {
          var key = th.dataset.sort;
          var newDir = th.dataset.dir === 'asc' ? 'desc' : 'asc';
          var mult = newDir === 'asc' ? 1 : -1;
          document.querySelectorAll('.event-header [data-sort]').forEach(function(t) {
            delete t.dataset.dir;
            t.style.color = "";
          });
          th.dataset.dir = newDir;
          th.style.color = 'var(--accent-blue)';
          var list = document.querySelector('.event-list');
          if (!list) return;
          var items = Array.from(list.querySelectorAll('details.event'));
          items.sort(function(a, b) {
            var av = a.dataset[key] || "";
            var bv = b.dataset[key] || "";
            if (key === 'dex' || key === 'level') {
              av = parseInt(av, 10) || 0;
              bv = parseInt(bv, 10) || 0;
            }
            if (av < bv) return -1 * mult;
            if (av > bv) return 1 * mult;
            return 0;
          });
          items.forEach(function(el) { list.appendChild(el); });
        });
      });

      document.querySelectorAll('.shiny-header [data-sort]').forEach(function(th) {
        th.style.cursor = 'pointer';
        th.addEventListener('click', function() {
          var key = th.dataset.sort;
          var newDir = th.dataset.dir === 'asc' ? 'desc' : 'asc';
          var mult = newDir === 'asc' ? 1 : -1;
          document.querySelectorAll('.shiny-header [data-sort]').forEach(function(t) {
            delete t.dataset.dir;
            t.style.color = "";
          });
          th.dataset.dir = newDir;
          th.style.color = 'var(--accent-blue)';
          var list = document.querySelector('.shiny-list');
          if (!list) return;
          var items = Array.from(list.querySelectorAll('details.shiny-row-details'));
          items.sort(function(a, b) {
            var av = a.dataset[key] || "";
            var bv = b.dataset[key] || "";
            if (key === 'dex') {
              av = parseInt(av, 10) || 0;
              bv = parseInt(bv, 10) || 0;
            }
            if (av < bv) return -1 * mult;
            if (av > bv) return 1 * mult;
            return 0;
          });
          items.forEach(function(el) { list.appendChild(el); });
        });
      });

      var selected = new Map();
      document.querySelectorAll('.ball[data-pokemon][data-state]').forEach(function(ball) {
        if (ball.dataset.state === 'possible') return;
        ball.style.cursor = 'pointer';
        ball.addEventListener('click', function(ev) {
          ev.preventDefault();
          ev.stopPropagation();
          var key = ball.dataset.pokemon + '|' + ball.dataset.ball;
          if (selected.has(key)) {
            selected.delete(key);
            ball.classList.remove('selected');
          } else {
            selected.set(key, {
              pokemon: ball.dataset.pokemon,
              ball: ball.dataset.ball,
              state: ball.dataset.state
            });
            ball.classList.add('selected');
          }
          var hint = document.getElementById('copy-hint');
          if (hint) {
            if (selected.size === 0) {
              hint.textContent = 'selected: CTRL + C to copy as list';
              hint.style.color = "";
            } else {
              hint.textContent = selected.size + ' selected · CTRL + C to copy';
              hint.style.color = 'var(--accent-red)';
            }
          }
        });
      });

      function copyText(text) {
        var ta = document.createElement('textarea');
        ta.value = text;
        ta.style.position = 'fixed';
        ta.style.left = '-9999px';
        document.body.appendChild(ta);
        ta.select();
        try { document.execCommand('copy'); } catch (err) { console.error(err); }
        document.body.removeChild(ta);
      }

      document.addEventListener('keydown', function(ev) {
        if ((ev.ctrlKey || ev.metaKey) && ev.key === 'c' && selected.size > 0) {
          var lines = [];
          selected.forEach(function(v) {
            var pn = v.pokemon.charAt(0).toUpperCase() + v.pokemon.slice(1);
            var bn = v.ball.charAt(0).toUpperCase() + v.ball.slice(1);
            var line = pn + ' ' + bn + ' Ball';
            if (v.state === 'ha' || v.state === 'em') line += ' HA';
            lines.push(line);
          });
          copyText(lines.join('\n'));
          var hint = document.getElementById('copy-hint');
          if (hint) {
            var orig = hint.textContent;
            hint.textContent = '✓ Copied ' + lines.length + ' entries!';
            hint.style.color = 'var(--accent-green)';
            setTimeout(function() {
              hint.textContent = orig;
              hint.style.color = "";
            }, 2000);
          }
          ev.preventDefault();
        }
      });

      var filterState = 'all';
      var filterBtn = document.getElementById('filter-toggle');
      var searchInput = document.getElementById('search-input');

      function applyFilters() {
        var q = ((searchInput && searchInput.value) || "").toLowerCase().trim();
        var filtering = q.length > 0 || filterState !== 'all';

        var shinyList = document.querySelector('.shiny-list');
        if (shinyList) {
          Array.from(shinyList.querySelectorAll('details.shiny-row-details')).forEach(function(row) {
            var name = (row.dataset.name || "").toLowerCase();
            var dex  = row.dataset.dex || "";
            var isOwned = row.classList.contains('owned');
            var matchQ  = !q || name.indexOf(q) >= 0 || dex.indexOf(q) >= 0;
            var matchF  =
              filterState === 'all' ||
              (filterState === 'owned' && isOwned) ||
              (filterState === 'missing' && !isOwned);
            row.style.display = (matchQ && matchF) ? "" : 'none';
          });
        }

        var entriesList = document.querySelector('.entries-list');
        if (entriesList) {
          Array.from(entriesList.querySelectorAll('details.breedable-row')).forEach(function(row) {
            var name    = (row.dataset.name || "").toLowerCase();
            var dex     = row.dataset.dex  || "";
            var summary = row.querySelector('summary.entry');
            var isOwned = summary && !summary.classList.contains('untouched');
            var matchQ  = !q || name.indexOf(q) >= 0 || dex.indexOf(q) >= 0;
            var matchF  =
              filterState === 'all' ||
              (filterState === 'owned' && isOwned) ||
              (filterState === 'missing' && !isOwned);
            row.style.display = (matchQ && matchF) ? "" : 'none';
          });
          Array.from(entriesList.querySelectorAll('.generation-label')).forEach(function(el) {
            el.style.display = filtering ? 'none' : "";
          });
        }

        var eventList = document.querySelector('.event-list');
        if (eventList) {
          Array.from(eventList.querySelectorAll('details.event')).forEach(function(row) {
            var name = (row.dataset.name || "").toLowerCase();
            var dex  = row.dataset.dex  || "";
            var matchQ = !q || name.indexOf(q) >= 0 || dex.indexOf(q) >= 0;
            row.style.display = matchQ ? "" : 'none';
          });
        }
      }

      function updateFilterBtn() {
        if (!filterBtn) return;
        var labels = { all: 'Showing: all', owned: 'Showing: caught', missing: 'Showing: missing' };
        filterBtn.textContent = labels[filterState] || 'Showing: all';
        filterBtn.classList.toggle('active', filterState !== 'all');
      }

      if (filterBtn) {
        filterBtn.addEventListener('click', function(ev) {
          ev.preventDefault();
          filterState =
            filterState === 'all' ? 'owned' :
            filterState === 'owned' ? 'missing' : 'all';
          updateFilterBtn();
          applyFilters();
        });
      }

      var searchResults = document.getElementById('search-results');
      var searchWrap    = document.querySelector('.search-wrap');

      function hideGlobalResults() {
        if (searchResults) { searchResults.classList.remove('open'); }
      }

      function buildGlobalResults(q) {
        if (!searchResults) return;
        if (!q) { hideGlobalResults(); searchResults.innerHTML = ""; return; }
        if (!window.POKENIX_INDEX) return;
        var ql = q.toLowerCase();
        var cats = [
          { key: 'breedables', label: 'Breedables' },
          { key: 'shiny',      label: 'Shiny Living' },
          { key: 'events',     label: 'Events' },
          { key: 'specials',   label: 'Specials' }
        ];
        var html = "";
        var total = 0;
        cats.forEach(function(cat) {
          var items = (window.POKENIX_INDEX[cat.key] || []).filter(function(it) {
            return (it.name || "").toLowerCase().indexOf(ql) >= 0
                || String(it.dex || "").indexOf(ql) >= 0
                || (it.key || "").toLowerCase().indexOf(ql) >= 0;
          });
          if (items.length === 0) return;
          total += items.length;
          html += '<div class="sr-category">' + cat.label + ' (' + items.length + ')</div>';
          items.slice(0, 40).forEach(function(it) {
            var pad = ('000' + it.dex).slice(-3);
            var safe = document.createElement('span');
            safe.textContent = it.name;
            html += '<div class="sr-item" data-page="' + it.page + '" data-key="' + it.key + '">'
                 +  '<span class="sr-dex">#' + pad + '</span>'
                 +  '<span class="sr-name">' + safe.innerHTML + '</span>'
                 +  '</div>';
          });
        });
        if (total === 0) html = '<div class="sr-empty">No matches.</div>';
        searchResults.innerHTML = html;
        searchResults.classList.add('open');
      }

      function highlightTarget(key) {
        var t = document.getElementById('pk-' + key);
        if (!t) return;
        if (t.tagName === 'DETAILS') t.open = true;
        t.classList.add('highlight');
        setTimeout(function() { t.scrollIntoView({ behavior: 'smooth', block: 'center' }); }, 60);
        setTimeout(function() { t.classList.remove('highlight'); }, 1800);
      }

      if (searchResults && searchInput) {
        searchInput.addEventListener('input', function() {
          applyFilters();
          buildGlobalResults(searchInput.value.trim());
        });
        searchResults.addEventListener('click', function(ev) {
          var row = ev.target.closest('.sr-item');
          if (!row) return;
          var page = row.dataset.page;
          var key  = row.dataset.key;
          var currentPath = (window.location.pathname.split('/').pop() || 'index.html');
          hideGlobalResults();
          searchInput.value = "";
          applyFilters();
          if (page === currentPath) {
            highlightTarget(key);
          } else {
            window.location.href = page + '#pk-' + encodeURIComponent(key);
          }
        });
        document.addEventListener('click', function(ev) {
          if (searchWrap && !searchWrap.contains(ev.target)) hideGlobalResults();
        });
        searchInput.addEventListener('keydown', function(ev) {
          if (ev.key === 'Escape') hideGlobalResults();
        });
      }

      (function() {
        var h = window.location.hash;
        if (!h || h.indexOf('#pk-') !== 0) return;
        var key = decodeURIComponent(h.substring(4));
        setTimeout(function() { highlightTarget(key); }, 120);
      })();
    })();
  '';

  sharedCss = ''
    :root {
      color-scheme: dark;
      --h1-h: 60px;
      --bg: #121212;
      --bg-1: #161616;
      --bg-2: #1c1c1c;
      --bg-3: #1a1a1a;
      --border-1: #232323;
      --border-2: #2a2a2a;
      --border-3: #333;
      --border-4: #444;
      --fg: #e6e6e6;
      --fg-1: #ccc;
      --fg-2: #999;
      --fg-3: #888;
      --fg-4: #666;
      --accent-blue: #6cf;
      --accent-gold: #f0c040;
      --accent-green: #40e080;
      --accent-cyan: #40c0f0;
      --accent-pink: #f6c;
      --accent-red: #f04040;
    }
    :root[data-theme="light"] {
      color-scheme: light;
      --bg: #f5f5f5;
      --bg-1: #f0f0f0;
      --bg-2: #e8e8e8;
      --bg-3: #ececec;
      --border-1: #dcdcdc;
      --border-2: #cccccc;
      --border-3: #bbbbbb;
      --border-4: #999999;
      --fg: #1a1a1a;
      --fg-1: #333;
      --fg-2: #555;
      --fg-3: #666;
      --fg-4: #888;
      --accent-blue: #0066dd;
      --accent-gold: #b8860b;
      --accent-green: #108040;
      --accent-cyan: #0077bb;
      --accent-pink: #cc3388;
      --accent-red: #cc2222;
    }
    * { box-sizing: border-box; }
    body {
      font-family: -apple-system, "Segoe UI", system-ui, sans-serif;
      background: var(--bg); color: var(--fg);
      margin: 0; padding: 0 24px 28px;
      overflow-x: auto;
    }
    h1 {
      position: sticky;
      top: 0;
      z-index: 30;
      background: var(--bg);
      margin: 0;
      padding: 16px 0 12px;
      display: flex;
      align-items: center;
      gap: 8px;
      font-weight: 300;
      letter-spacing: 1px;
    }
    h1 .logo-link {
      display: inline-flex;
      flex-shrink: 0;
      margin: -4px 0 -4px -4px;
      text-decoration: none;
    }
    h1 .logo {
      width: 40px;
      height: 40px;
      image-rendering: pixelated;
      display: block;
    }
    h1 .brand { font-weight: 300; }
    h1 small { color: var(--fg-4); font-size: 13px; font-weight: 400; }
    h1 small a { color: var(--accent-blue); text-decoration: none; }
    h1 small a:hover { text-decoration: underline; }
    h1 small .nav-current { color: var(--fg); font-weight: 500; }
    h1 .h1-right {
      margin-left: auto;
      display: inline-flex;
      align-items: center;
      gap: 8px;
    }
    h1 .top-btn {
      color: var(--accent-blue);
      text-decoration: none;
      font-size: 12px;
      padding: 6px 12px;
      border: 1px solid var(--border-3);
      border-radius: 4px;
      font-weight: 400;
      transition: background .15s;
      background: var(--bg);
    }
    h1 .top-btn:hover { background: var(--bg-3); }
    h1 .progress {
      margin-left: 16px;
      color: var(--accent-gold);
      font-size: 13px;
      font-family: ui-monospace, monospace;
      font-weight: 500;
    }
    .tool-input {
      background: var(--bg-3);
      border: 1px solid var(--border-3);
      color: var(--fg);
      font-size: 12px;
      padding: 6px 10px;
      border-radius: 4px;
      width: 180px;
      font-family: inherit;
    }
    .tool-input:focus { outline: none; border-color: var(--accent-blue); }
    .tool-btn {
      background: var(--bg);
      border: 1px solid var(--border-3);
      color: var(--accent-blue);
      font-size: 12px;
      padding: 6px 12px;
      border-radius: 4px;
      cursor: pointer;
      font-family: inherit;
      transition: background .15s, border-color .15s, color .15s;
    }
    .tool-btn:hover { background: var(--bg-3); }
    .tool-btn.active { border-color: var(--accent-gold); color: var(--accent-gold); }
    .theme-btn {
      background: var(--bg);
      border: 1px solid var(--border-3);
      color: var(--fg);
      font-size: 16px;
      width: 32px;
      height: 32px;
      padding: 0;
      border-radius: 4px;
      cursor: pointer;
      line-height: 1;
      font-family: inherit;
      display: inline-flex;
      align-items: center;
      justify-content: center;
      transition: background .15s;
    }
    .theme-btn:hover { background: var(--bg-3); }

    .summary { color: var(--fg-3); margin-bottom: 14px; font-size: 13px; }
    .legend {
      color: var(--fg-2); font-size: 12px; margin-bottom: 18px;
      display: flex; gap: 16px; align-items: center; flex-wrap: wrap;
    }
    .legend .item { display: inline-flex; align-items: center; gap: 6px; }
    .legend .ball { pointer-events: none; }

    .entry,
    .event-row,
    .shiny-row {
      display: grid;
      align-items: stretch;
      width: 100%;
      background: transparent;
    }
    .entry       { grid-template-columns: ${breedColumns}; }
    .event-row   { grid-template-columns: ${eventColumns}; }
    .event-row.special-row { grid-template-columns: ${specialColumns}; }
    .shiny-row   { grid-template-columns: ${shinyColumns}; }

    .entry > *,
    .event-row > *,
    .shiny-row > * {
      display: flex;
      align-items: center;
      min-height: 42px;
      padding: 0 8px;
      min-width: 0;
      border-right: 1px solid var(--border-1);
      border-bottom: 1px solid var(--border-1);
      overflow: hidden;
      white-space: nowrap;
      text-overflow: ellipsis;
      font-size: 12px;
      line-height: 1.2;
      color: var(--fg-1);
      background: transparent;
    }
    .entry > *:last-child,
    .event-row > *:last-child,
    .shiny-row > *:last-child {
      border-right: none;
    }

    .cell-sprite {
      padding: 2px 4px !important;
      justify-content: center !important;
    }
    .cell-sprite .sprite {
      display: block;
      width: 40px;
      height: 40px;
      image-rendering: pixelated;
    }

    .balls {
      padding: 2px 4px !important;
      gap: 2px;
      justify-content: flex-start !important;
    }
    .event-ball-slot {
      padding: 2px 4px !important;
      justify-content: center !important;
      position: relative;
    }

    .entry > *:nth-child(1) { justify-content: flex-end;   font-family: ui-monospace, monospace; }
    .entry > *:nth-child(2) { justify-content: center;     padding: 2px 4px; }
    .entry > *:nth-child(3) { justify-content: flex-start; }
    .entry > *:nth-child(4) { justify-content: flex-start; padding: 2px 4px; }
    .entry > *:nth-child(5) { justify-content: flex-start; color: var(--accent-blue); }
    .entry > *:nth-child(6) { justify-content: center; }
    .entry > *:nth-child(7) { justify-content: flex-end; }
    .entry > *:nth-child(8) { justify-content: flex-end; }

    .event-row > *:nth-child(1) { justify-content: flex-end; font-family: ui-monospace, monospace; }
    .event-row > *:nth-child(2) { justify-content: center; padding: 2px 4px; }
    .event-row > *:nth-child(3) { justify-content: center; padding: 2px 4px; }
    .event-row > *:nth-child(4) { justify-content: flex-start; }
    .event-row > *:nth-child(5) { justify-content: center; }
    .event-row > *:nth-child(6) { justify-content: center; }
    .event-row > *:nth-child(7) { justify-content: center; }
    .event-row > *:nth-child(8) { justify-content: flex-start; }
    .event-row > *:nth-child(9) { justify-content: center; }
    .event-row > *:nth-child(10){ justify-content: center; }

    .special-row > *:nth-child(7) { justify-content: flex-end; font-family: ui-monospace, monospace; }
    .special-row > *:nth-child(8) { justify-content: flex-start; }
    .special-row > *:nth-child(9) { justify-content: flex-end; }

    .shiny-row > *:nth-child(1) { justify-content: flex-end; font-family: ui-monospace, monospace; }
    .shiny-row > *:nth-child(2) { justify-content: center; padding: 2px 4px; }
    .shiny-row > *:nth-child(3) { justify-content: center; padding: 2px 4px; }
    .shiny-row > *:nth-child(4) { justify-content: flex-start; }
    .shiny-row > *:nth-child(5) { justify-content: flex-start; color: var(--fg-3); }
    .shiny-row > *:nth-child(6) { justify-content: center; }
    .shiny-row > *:nth-child(7) { justify-content: center; }
    .shiny-row > *:nth-child(8) { justify-content: center; }

    .entry.header,
    .event-header,
    .shiny-header {
      position: sticky;
      top: var(--h1-h);
      z-index: 20;
      background: var(--bg-3);
    }
    .entry.header > *,
    .event-header > *,
    .shiny-header > * {
      background: var(--bg-3);
      color: var(--fg-3);
      font-size: 11px;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      border-bottom: 2px solid var(--border-3);
      min-height: 38px;
    }
    .entry.header > *:nth-child(5) { color: var(--fg-3); }

    .breedable-row { display: block; }
    .breedable-row > summary.entry { list-style: none; cursor: pointer; }
    .breedable-row > summary.entry::-webkit-details-marker { display: none; }
    .breedable-row[open] > summary.entry { background: var(--bg-2); }
    .breedable-row > summary.entry:hover { background: var(--bg-2); }

    .generation-block > .breedable-row:nth-child(even) > summary.entry { background: var(--bg-1); }

    .entry-details {
      display: grid;
      grid-template-columns: repeat(2, minmax(0, 1fr));
      gap: 10px 28px;
      padding: 10px 16px 16px 64px;
      background: var(--bg-1);
      border-bottom: 1px solid var(--border-1);
    }
    .entry-details .detail-wide { grid-column: 1 / -1; }

    .ball-status-pill {
      display: inline-flex; align-items: center; gap: 6px;
      padding: 3px 8px;
      background: var(--bg-3);
      border: 1px solid var(--border-2);
      border-radius: 4px;
      font-size: 11px; color: var(--fg-1);
      white-space: nowrap;
    }
    .ball-status-pill .ball { width: 22px; height: 22px; }
    .ball-status-pill .ball img { width: 18px; height: 18px; }

    .shiny-row-details { display: block; }
    .shiny-row-details > summary.shiny-row { list-style: none; cursor: pointer; }
    .shiny-row-details > summary.shiny-row::-webkit-details-marker { display: none; }
    .shiny-row-details[open] > summary.shiny-row { background: var(--bg-2); }
    .shiny-row-details > summary.shiny-row:hover { background: var(--bg-2); }
    .shiny-row-details.empty > summary.shiny-row { opacity: 0.55; }
    .shiny-row-details.empty > summary.shiny-row:hover { opacity: 1; }

    @keyframes highlight-pulse {
      0%   { background-color: color-mix(in srgb, var(--accent-gold) 35%, transparent); }
      100% { background-color: transparent; }
    }
    .highlight > summary { animation: highlight-pulse 1.5s ease-out; }

    .search-wrap { position: relative; display: inline-block; }
    .search-results {
      position: absolute;
      top: 100%;
      right: 0;
      width: 380px;
      max-height: 480px;
      overflow-y: auto;
      background: var(--bg-2);
      border: 1px solid var(--border-3);
      border-radius: 6px;
      box-shadow: 0 8px 24px rgba(0,0,0,0.5);
      z-index: 100;
      display: none;
      margin-top: 4px;
    }
    .search-results.open { display: block; }
    .search-results .sr-category {
      padding: 6px 10px;
      font-size: 10px;
      text-transform: uppercase;
      letter-spacing: 1px;
      color: var(--fg-4);
      border-bottom: 1px solid var(--border-1);
      background: var(--bg-3);
    }
    .search-results .sr-item {
      padding: 8px 10px;
      display: flex; gap: 8px; align-items: center;
      cursor: pointer;
      font-size: 12px; color: var(--fg-1);
      border-bottom: 1px solid var(--border-1);
    }
    .search-results .sr-item:hover { background: var(--bg-3); color: var(--fg); }
    .search-results .sr-dex  { color: var(--fg-4); font-family: ui-monospace, monospace; font-size: 11px; }
    .search-results .sr-name { font-weight: 500; }
    .search-results .sr-empty { padding: 12px; color: var(--fg-4); font-size: 12px; text-align: center; }

    .event > summary.event-row:hover { background: var(--bg-2); }
    .event[open] > summary.event-row { background: var(--bg-2); }

    .generation-block { display: block; }
    .generation-label {
      padding: 22px 0 8px;
      font-size: 11px;
      text-transform: uppercase;
      letter-spacing: 3px;
      color: var(--fg-4);
      font-weight: 600;
      border-bottom: 1px solid var(--border-2);
      margin-bottom: 2px;
    }
    .entries-list > .generation-block:first-child .generation-label { padding-top: 4px; }

    .dex-wrap { position: relative; }
    .dex {
      display: block; color: var(--fg-4);
      font-family: ui-monospace, monospace; font-size: 12px;
      text-decoration: none;
    }
    .dex:hover { color: var(--accent-blue); }
    .sprite { width: 40px; height: 40px; image-rendering: pixelated; }
    .name { font-weight: 500; color: var(--fg); display: inline-flex; align-items: center; gap: 6px; }
    .star { color: var(--accent-gold); font-size: 12px; }
    .hidden-ability { font-size: 12px; }
    .gender { font-size: 15px; }
    .gender.male   { color: var(--accent-blue); }
    .gender.female { color: var(--accent-pink); }
    .ratio  { color: var(--fg-3); font-size: 11px; }
    .cycles { color: var(--fg-3); font-size: 11px; font-family: ui-monospace, monospace; }
    .entry.untouched .ratio,
    .entry.untouched .cycles { color: var(--fg-4); }
    .entry.untouched { opacity: 0.75; }
    .entry.untouched:hover { opacity: 1; }

    .dex-hover {
      display: none;
      position: absolute;
      top: 100%;
      left: 0;
      width: 440px;
      height: 360px;
      background: var(--bg-3);
      border: 1px solid var(--border-4);
      border-radius: 8px;
      overflow: hidden;
      z-index: 100;
      box-shadow: 0 8px 32px rgba(0,0,0,0.9);
      margin-top: 2px;
    }
    .dex-wrap:hover .dex-hover { display: block; }
    .dex-hover iframe {
      width: 100%; height: 100%; border: 0; background: #fff;
      position: relative; z-index: 2;
    }
    .dex-hover-fallback {
      position: absolute; inset: 0;
      padding: 16px;
      display: flex; flex-direction: column; gap: 6px;
      align-items: center; justify-content: center;
      text-align: center;
      z-index: 1;
      color: var(--fg-3); font-size: 12px;
    }
    .dhf-title { color: var(--fg); font-size: 14px; font-weight: 500; }
    .dhf-url { color: var(--accent-blue); font-family: ui-monospace, monospace; font-size: 11px; word-break: break-all; }
    .dhf-hint { color: var(--fg-4); font-size: 11px; margin-top: 8px; }

    .ball {
      position: relative;
      box-sizing: border-box;
      width: 30px; height: 30px;
      flex-shrink: 0;
      display: inline-flex;
      align-items: center;
      justify-content: center;
      transition: transform 0.15s;
    }
    .ball img {
      width: 20px; height: 20px;
      display: block;
      image-rendering: pixelated;
      position: relative;
      z-index: 1;
    }
    .ball::before {
      content: "";
      position: absolute;
      inset: -3px;
      border-radius: 50%;
      border: 2px solid transparent;
      box-sizing: border-box;
      pointer-events: none;
      transition: border-color 0.15s;
    }
    .ball:hover { transform: scale(1.15); }
    .ball.possible       { opacity: 0.35; filter: grayscale(0.5); }
    .ball.caught::before   { border-color: var(--fg-4); }
    .ball.ha::before      { border-color: var(--accent-cyan); }
    .ball.em::before      { border-color: var(--accent-green); }
    .ball.missing::before { border-color: var(--border-3); border-style: dashed; }
    .ball.selected::after {
      content: "";
      position: absolute;
      inset: -5px;
      border-radius: 50%;
      border: 3px solid var(--accent-red);
      pointer-events: none;
    }

    .ball.unavailable {
      opacity: 0.35;
      cursor: default;
      pointer-events: none;
    }
    .ball.unavailable:hover { transform: none; }
    .ball.unavailable .ball-x {
      color: var(--fg-4);
      font-size: 13px;
      font-weight: 700;
      line-height: 1;
      user-select: none;
    }

    .entry.header .ball-col {
      display: inline-flex; flex-direction: column; align-items: center; gap: 2px;
    }
    .entry.header .ball-count {
      font-size: 10px; color: var(--fg-1);
      font-family: ui-monospace, monospace; line-height: 1;
      text-transform: none; letter-spacing: 0;
    }

    .event { border: none; }
    .event > summary.event-row { cursor: pointer; list-style: none; }
    .event > summary.event-row::-webkit-details-marker { display: none; }
    .event[open] .event-chevron { transform: rotate(90deg); }

    .event-dex, .shiny-dex { color: var(--fg-4); font-family: ui-monospace, monospace; font-size: 12px; }
    .event-name, .shiny-name { font-weight: 500; color: var(--fg); }
    .event-field { font-size: 12px; color: var(--fg-1); }
    .shiny-notes { font-size: 12px; color: var(--fg-3); }
    .shiny-style { color: var(--accent-gold); font-size: 14px; text-align: center; }

    .event-ball-slot img { width: 20px; height: 20px; image-rendering: pixelated; }
    .event-ball-slot.empty::before { display: none; }
    .event-ball-slot.missing::before {
      content: ""; width: 20px; height: 20px; border-radius: 50%;
      border: 1px dashed var(--fg-4);
    }

    .check {
      width: 22px; height: 22px; flex-shrink: 0;
      display: inline-flex; align-items: center; justify-content: center;
      font-size: 12px; font-weight: 700;
      border-radius: 3px;
    }
    .check.yes { color: var(--accent-green); border: 1px solid color-mix(in srgb, var(--accent-green) 40%, transparent); background: color-mix(in srgb, var(--accent-green) 8%, transparent); }
    .check.no  { color: transparent; border: 1px solid var(--border-3); }
    .check.na  { color: var(--fg-4); }
    .check.header-check { color: var(--fg-3); border: none; font-weight: 400; font-size: 11px; }

    .egg-slot {
      display: inline-flex;
      align-items: center;
      justify-content: center;
      width: 66px;
      height: 66px;
      flex-shrink: 0;
    }
    .egg-sprite {
      max-height: 60px;
      max-width: 60px;
      width: auto;
      image-rendering: pixelated;
      display: block;
    }

    .event-chevron {
      color: var(--fg-4); font-size: 12px;
      transition: transform .15s;
    }

    .event-details {
      display: grid;
      grid-template-columns: repeat(2, minmax(0, 1fr));
      gap: 10px 28px;
      padding: 10px 16px 16px 64px;
      background: var(--bg-1);
      border-bottom: 1px solid var(--border-1);
    }
    .event-details.special-details { grid-template-columns: repeat(3, minmax(0, 1fr)); }
    .detail { display: flex; flex-direction: column; gap: 3px; }
    .detail-wide { grid-column: 1 / -1; }
    .detail-label { color: var(--fg-4); font-size: 10px; text-transform: uppercase; letter-spacing: 1px; }
    .detail-value { color: var(--fg-1); font-size: 12px; word-break: break-word; }

    .pills { display: flex; flex-wrap: wrap; gap: 6px; align-items: flex-start; }
    .ribbon-item, .mark-item {
      display: inline-flex; align-items: center; gap: 5px;
      padding: 3px 8px;
      background: var(--bg-3);
      border: 1px solid var(--border-2);
      border-radius: 4px;
      font-size: 11px;
      color: var(--fg-1);
      white-space: nowrap;
    }
    .ribbon-sprite, .mark-sprite {
      max-height: 18px; width: auto;
      image-rendering: pixelated;
      display: block; flex-shrink: 0;
    }
    .item-pill {
      display: inline-flex; align-items: center; gap: 5px;
      padding: 3px 8px;
      background: var(--bg-3);
      border: 1px solid var(--border-2);
      border-radius: 4px;
      font-size: 11px;
      color: var(--fg-1);
      white-space: nowrap;
    }
    .item-sprite {
      max-height: 18px; width: auto;
      image-rendering: pixelated;
      display: block; flex-shrink: 0;
    }
    .ribbon-header-spacer { min-width: 0; min-height: 1px; }
    .event-ribbon-strip {
      display: inline-flex;
      gap: 3px;
      align-items: center;
      flex-shrink: 0;
      max-width: 220px;
      overflow: hidden;
    }
    .event-ribbon-strip img {
      max-height: 16px; width: auto;
      image-rendering: pixelated;
      display: block; flex-shrink: 0;
    }

    .type-pill {
      display: inline-flex;
      align-items: center;
      gap: 5px;
      padding: 3px 8px;
      background: var(--bg-3);
      border: 1px solid var(--border-2);
      border-radius: 4px;
      font-size: 11px;
      color: var(--fg-1);
      white-space: nowrap;
    }
    .type-sprite {
      max-height: 18px;
      width: auto;
      image-rendering: pixelated;
      display: block;
      flex-shrink: 0;
    }

    .gmax-badge {
      display: inline-block;
      width: 16px;
      height: 16px;
      margin-left: 5px;
      image-rendering: pixelated;
      vertical-align: middle;
      flex-shrink: 0;
    }

    .trainer-card {
      max-width: 720px;
      margin: 48px auto;
      padding: 32px;
      background: var(--bg-2);
      border: 1px solid var(--border-2);
      border-radius: 8px;
    }
    .trainer-pic-wrap { display: flex; justify-content: center; margin-bottom: 24px; }
    .trainer-pic {
      width: 128px; height: 128px;
      border-radius: 50%;
      object-fit: cover;
      border: 2px solid var(--border-2);
    }
    .trainer-name {
      font-weight: 300; letter-spacing: 2px; margin: 0 0 8px;
      font-size: 24px; text-align: center;
    }
    .trainer-about {
      color: var(--fg-2); margin: 0 0 24px;
      font-size: 13px; line-height: 1.6; text-align: center;
    }
    .trainer-fields {
      display: grid;
      grid-template-columns: repeat(2, minmax(0, 1fr));
      gap: 16px 24px;
    }
    .trainer-field { display: flex; flex-direction: column; gap: 4px; }
    .trainer-field-label {
      color: var(--fg-4); font-size: 10px;
      text-transform: uppercase; letter-spacing: 1px;
    }
    .trainer-field-value { color: var(--fg-1); font-size: 13px; word-break: break-word; }
    .trainer-section-label {
      font-size: 11px; text-transform: uppercase; letter-spacing: 2px;
      color: var(--fg-4); font-weight: 600;
      margin: 32px 0 12px; padding-bottom: 8px;
      border-bottom: 1px solid var(--border-1);
    }
    .trainer-stats {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(140px, 1fr));
      gap: 12px; margin-bottom: 8px;
    }
    .stat {
      display: flex; flex-direction: column; gap: 6px;
      padding: 16px 12px;
      background: var(--bg);
      border: 1px solid var(--border-2);
      border-radius: 6px;
      text-align: center;
    }
    .stat-value {
      font-size: 22px; font-weight: 600;
      color: var(--fg);
      font-family: ui-monospace, monospace;
      line-height: 1.2;
    }
    .stat-sub { font-size: 13px; font-weight: 400; color: var(--fg-4); }
    .stat-label {
      font-size: 10px; text-transform: uppercase; letter-spacing: 1px;
      color: var(--fg-4); line-height: 1.3;
    }

    .placeholder {
      margin-top: 48px; padding: 48px 24px;
      border: 1px dashed var(--border-3); border-radius: 8px;
      text-align: center; color: var(--fg-3);
    }
    .placeholder h2 {
      color: var(--fg); font-weight: 300; letter-spacing: 2px; margin: 0 0 12px;
    }
    .placeholder p { margin: 6px 0; font-size: 13px; }
    .stat-up   { color: var(--accent-green); font-weight: 600; }
    .stat-down { color: var(--accent-red);   font-weight: 600; }

    .level-moves { display: flex; flex-direction: column; gap: 3px; }
    .level-row   { display: flex; gap: 10px; font-size: 12px; }
    .level-num   {
      color: var(--fg-4);
      font-family: ui-monospace, monospace;
      min-width: 52px;
    }
    .level-moves-list { color: var(--fg-1); word-break: break-word; }

    .move-grid { display: flex; flex-wrap: wrap; gap: 3px; margin-top: 6px; }
    .move-count { color: var(--fg-4); font-weight: normal; margin-left: 4px; }

    .move-pill {
      display: inline-flex; align-items: center; gap: 4px;
      padding: 2px 8px;
      border-radius: 10px;
      font-size: 11px; font-weight: 500;
      color: #fff; background: #666;
      border: 1px solid rgba(0,0,0,0.25);
      white-space: nowrap; cursor: default;
      transition: transform .1s;
    }
    .move-pill:hover { transform: translateY(-1px); }
    .move-pill .move-power {
      font-size: 9px; font-family: ui-monospace, monospace;
      padding: 0 3px; border-radius: 4px;
      background: rgba(0,0,0,0.3);
    }
    .move-pill.cls-physical { box-shadow: inset 0 -2px 0 rgba(230, 80, 80, 0.9); }
    .move-pill.cls-special  { box-shadow: inset 0 -2px 0 rgba(110, 150, 240, 0.9); }
    .move-pill.cls-status   { box-shadow: inset 0 -2px 0 rgba(200, 200, 200, 0.6); }

    .move-pill.type-normal   { background: #9a9a80; }
    .move-pill.type-fire     { background: #d8543a; }
    .move-pill.type-water    { background: #3f7fd4; }
    .move-pill.type-electric { background: #c9a900; color: #111; }
    .move-pill.type-grass    { background: #3f9d45; }
    .move-pill.type-ice      { background: #6ec5c5; color: #111; }
    .move-pill.type-fighting { background: #a63939; }
    .move-pill.type-poison   { background: #924592; }
    .move-pill.type-ground   { background: #b38a37; }
    .move-pill.type-flying   { background: #7a6ed4; }
    .move-pill.type-psychic  { background: #c84875; }
    .move-pill.type-bug      { background: #7a9a22; }
    .move-pill.type-rock     { background: #a39550; }
    .move-pill.type-ghost    { background: #5c4e89; }
    .move-pill.type-dragon   { background: #5e2b9b; }
    .move-pill.type-dark     { background: #4a3a3a; }
    .move-pill.type-steel    { background: #8a8aa0; }
    .move-pill.type-fairy    { background: #d56fa7; }

    .type-badge {
      display: inline-block; padding: 2px 7px;
      border-radius: 4px; font-size: 10px;
      text-transform: uppercase; letter-spacing: .5px;
      color: #fff; background: #666;
      margin-right: 4px;
    }
    .type-badge.type-normal   { background: #9a9a80; }
    .type-badge.type-fire     { background: #d8543a; }
    .type-badge.type-water    { background: #3f7fd4; }
    .type-badge.type-electric { background: #c9a900; color: #111; }
    .type-badge.type-grass    { background: #3f9d45; }
    .type-badge.type-ice      { background: #6ec5c5; color: #111; }
    .type-badge.type-fighting { background: #a63939; }
    .type-badge.type-poison   { background: #924592; }
    .type-badge.type-ground   { background: #b38a37; }
    .type-badge.type-flying   { background: #7a6ed4; }
    .type-badge.type-psychic  { background: #c84875; }
    .type-badge.type-bug      { background: #7a9a22; }
    .type-badge.type-rock     { background: #a39550; }
    .type-badge.type-ghost    { background: #5c4e89; }
    .type-badge.type-dragon   { background: #5e2b9b; }
    .type-badge.type-dark     { background: #4a3a3a; }
    .type-badge.type-steel    { background: #8a8aa0; }
    .type-badge.type-fairy    { background: #d56fa7; }

    .special-badge {
      display: inline-flex; align-items: center; justify-content: center;
      width: 14px; height: 14px; margin-left: 4px;
      border-radius: 3px; font-size: 9px; font-weight: 700;
      color: #111; vertical-align: middle;
    }
    .special-badge.legendary { background: var(--accent-gold); }
    .special-badge.mythical  { background: var(--accent-pink); }
    .special-badge.baby      { background: var(--accent-cyan); }

    .cry-wrap { position: relative; }
    .cry-btn {
      position: absolute; bottom: 0; right: 0;
      width: 16px; height: 16px; padding: 0;
      background: var(--bg-3); border: 1px solid var(--border-3);
      border-radius: 50%; color: var(--fg-2);
      font-size: 10px; cursor: pointer; line-height: 1;
    }
    .cry-btn:hover { color: var(--accent-blue); border-color: var(--accent-blue); }

    .matchup-row { display: flex; gap: 4px; align-items: center; margin: 2px 0; }
    .matchup-label {
      min-width: 32px; font-family: ui-monospace, monospace;
      font-size: 10px; color: var(--fg-4);
    }
  '';

  siteDescription =
    "PokéNix — ${brandName}'s collection: "
    + "${toString totalCaptures}/${toString totalPossibleCaptures} aprimons · "
    + "${toString shinyOwnedCount}/${toString shinyTotalCount} shiny · "
    + "${toString eventCount} events";

  ogImage =
    let
      fontPath = "${pkgs.dejavu_fonts}/share/fonts/truetype";
      esc      = s: "'${builtins.replaceStrings [ "'" ] [ "'\\''" ] s}'";
      flat     = s: builtins.replaceStrings [ "\n" ] [ " " ] s;

      hasPic = cfg.trainer.picture != null;

      about  = flat (if cfg.trainer.about  != null then cfg.trainer.about  else "");
      region = flat (if cfg.trainer.region != null then cfg.trainer.region else "");

      stats =
        "${toString totalCaptures}/${toString totalPossibleCaptures} aprimons"
        + " · ${toString shinyOwnedCount}/${toString shinyTotalCount} shiny"
        + " · ${toString eventCount} events";

      picStep = lib.optionalString hasPic ''
        convert ${cfg.trainer.picture} \
          -resize 480x480^ -gravity center -extent 480x480 \
          -bordercolor '#333333' -border 4 \
          -alpha remove -alpha off pic.png
      '';

      picLayer = if hasPic then "pic.png -geometry +60+75 -composite" else "";
      textX    = if hasPic then "600" else "80";
    in
    pkgs.runCommand "pokenix-og.png" {
      buildInputs = [ pkgs.imagemagick pkgs.dejavu_fonts ];
    } ''
      set -euo pipefail
      ${picStep}

      convert -size 1200x630 xc:'#121212' \
        ${picLayer} \
        -font ${fontPath}/DejaVuSans-Bold.ttf -pointsize 56 -fill '#e6e6e6' \
          -annotate +${textX}+200 ${esc brandName} \
        -font ${fontPath}/DejaVuSans.ttf -pointsize 24 -fill '#999999' \
          -annotate +${textX}+260 ${esc about} \
        -pointsize 22 -fill '#6cf' \
          -annotate +${textX}+310 ${esc region} \
        -pointsize 24 -fill '#cccccc' \
          -annotate +${textX}+420 ${esc stats} \
        -pointsize 20 -fill '#666666' \
          -annotate +60+590 ${esc "PokéNix · github.com/QuackHack-McBlindy/pokenix"} \
        og.png

      cp og.png $out
    '';

  pageShell = currentPage: title: body: ''
    <!DOCTYPE html>
    <html lang="en">
    <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${title}</title>

    <meta name="description" content="${siteDescription}">

    <meta property="og:type"         content="website">
    <meta property="og:site_name"    content="PokéNix">
    <meta property="og:title"        content="${title}">
    <meta property="og:description"  content="${siteDescription}">
    <meta property="og:image"        content="og.png">
    <meta property="og:image:type"   content="image/png">
    <meta property="og:image:width"  content="1200">
    <meta property="og:image:height" content="630">
    <meta property="og:image:alt"    content="PokéNix trainer card for ${brandName}">

    <meta name="twitter:card"        content="summary_large_image">
    <meta name="twitter:title"       content="${title}">
    <meta name="twitter:description" content="${siteDescription}">
    <meta name="twitter:image"       content="og.png">

    <style>
    ${sharedCss}
    </style>
    </head>
    <body data-page="${currentPage}">
    ${navBar currentPage}
    ${body}
    <script>window.POKENIX_INDEX = ${builtins.toJSON globalIndex};</script>
    <script>${sharedJs}</script>
    </body>
    </html>
  '';

  breedablesBody = ''
    <div class="summary">${toString totalCount} species · ${toString ownedSpeciesCount} in collection · ${toString totalCaptures} ball captures</div>
    <div class="legend">
      <span>ball guide:</span>
      <span class="item"><span class="ball possible"><img src="data:image/png;base64,@BALL_safari@" alt=""></span>possible</span>
      <span class="item"><span class="ball caught"><img src="data:image/png;base64,@BALL_fast@" alt=""></span>caught</span>
      <span class="item"><span class="ball ha"><img src="data:image/png;base64,@BALL_love@" alt=""></span>+ HA</span>
      <span class="item"><span class="ball em"><img src="data:image/png;base64,@BALL_beast@" alt=""></span>HA + EM</span>
      <span class="item"><span class="ball unavailable"><span class="ball-x">✕</span></span>not available</span>
      <span class="item"><span class="ball selected"><img src="data:image/png;base64,@BALL_dream@" alt=""></span><span id="copy-hint">selected: CTRL + C to copy as list</span></span>
    </div>
    ${headerRow}
    <div class="entries-list">
      ${entriesHtml}
    </div>
  '';

  shinyBody = renderShinyList;

  eventsBody =
    if cfg.events == {}
    then ''<div class="placeholder"><h2>🎟️ events</h2><p>Event Pokémon go here.</p><p>Nothing is tracked yet.</p></div>''
    else renderEventList false cfg.events;

  specialsBody =
    if cfg.specials == {}
    then ''<div class="placeholder"><h2>⭐ specials</h2><p>Your special Pokémon go here.</p><p>Nothing is tracked yet.</p></div>''
    else renderSpecialList cfg.specials;

  renderGeneration = n: ''
    <div class="generation-label">GENERATION ${toString n} - ${regions.${toString n}} REGION</div>
  '';

  entriesHtml =
    let
      build = builtins.foldl'
        (acc: item:
          let
            g = genOfDex cfg.breedables.${item}.dex;
            isNewGen = g != acc.currentGen;
            opened =
              if acc.started
              then (if isNewGen
                     then "\n</div>\n<div class=\"generation-block\">" + (renderGeneration g)
                     else "")
              else "<div class=\"generation-block\">" + (renderGeneration g);
          in {
            text       = acc.text + opened + (speciesEntry item cfg.breedables.${item});
            currentGen = g;
            started    = true;
          }
        )
        { text = ""; currentGen = 0; started = false; }
        sortedNames;
    in
    if sortedNames == [] then ""
    else build.text + "\n</div>\n";

  renderBallHeader = bname: ''
    <span class="ball-col" title="${bname} — ${toString (ballOwnedCount bname)} caught">
      ${if ballExists bname
        then ''<span class="ball"><img src="data:image/png;base64,@BALL_${bname}@" alt="${bname}"></span>''
        else ''<span class="ball missing"></span>''}
      <span class="ball-count">${toString (ballOwnedCount bname)}</span>
    </span>
  '';

  headerRow = ''
    <div class="entry header">
      <span class="dex-wrap"><span class="dex">Dex</span></span>
      <span class="cell-sprite"></span>
      <span class="name">Pokémon</span>
      <span class="balls">
        ${concatStringsSep "" (map renderBallHeader balls)}
      </span>
      <span class="hidden-ability">Hidden Ability</span>
      <span class="gender"></span>
      <span class="ratio">Gender</span>
      <span class="cycles">Egg Cycles</span>
    </div>
  '';

  allBallFiles = builtins.attrNames (builtins.readDir ./sprites/balls);
  allBallPngs  = builtins.filter (f: lib.hasSuffix ".png" f) allBallFiles;
  allBallNames = builtins.map (f: lib.removeSuffix ".png" f) allBallPngs;
  existingBalls   = builtins.filter ballExists
    (lib.unique (balls ++ eventBalls ++ allBallNames));

  existingSprites = builtins.filter
    (n: breedableSpriteExists n cfg.breedables.${n})
    sortedNames;

  eventsExistingSprites = builtins.filter
    (k: evtSpriteExists k cfg.events.${k} false)
    (builtins.attrNames cfg.events);

  shinyExistingSprites = builtins.filter
    (k: let s = autoShinySprite shinyData.${k};
        in s != null && builtins.pathExists (./. + "/${s}"))
    (builtins.attrNames shinyData);

  specialExistingSprites = builtins.filter
    (k: evtSpriteExists k cfg.specials.${k} cfg.specials.${k}.shiny)
    (builtins.attrNames cfg.specials);

  allUsedRibbons = lib.unique (
    (builtins.concatMap (k: cfg.specials.${k}.ribbons) (builtins.attrNames cfg.specials))
    ++ (builtins.concatMap (k: cfg.shiny.${k}.ribbons or [ ]) (builtins.attrNames cfg.shiny))
  );

  allUsedMarks = lib.unique (
    (builtins.concatMap (k: cfg.specials.${k}.marks) (builtins.attrNames cfg.specials))
    ++ (builtins.concatMap (k: cfg.shiny.${k}.marks   or [ ]) (builtins.attrNames cfg.shiny))
  );

  ribbonsWithSprite = builtins.filter
    (n: firstExisting (ribbonFileCandidates n) != null)
    allUsedRibbons;

  marksWithSprite = builtins.filter
    (n: firstExisting [ (markFile n) ] != null)
    allUsedMarks;

  allUsedItems = lib.unique (builtins.filter (x: x != null && x != "") (
    (map (k: cfg.specials.${k}.heldItem)         (builtins.attrNames cfg.specials))
    ++ (map (k: cfg.shiny.${k}.heldItem or null) (builtins.attrNames cfg.shiny))
  ));

  itemsWithSprite = builtins.filter
    (n: firstExisting (itemCandidates n) != null)
    allUsedItems;

  allUsedTypes = lib.unique (builtins.filter (x: x != null && x != "") (
    (map (k: cfg.specials.${k}.teraType)         (builtins.attrNames cfg.specials))
    ++ (map (k: cfg.shiny.${k}.teraType or null) (builtins.attrNames cfg.shiny))
  ));

  typesWithSprite = builtins.filter typeIconExists allUsedTypes;

  candidatesFor = dex: key: shiny:
    let
      baseName = let s = slugForDex dex; in if s != null then s else key;
      suffix   = formSuffixFor dex key;
      variant  = if shiny then "shiny" else "regular";
    in lib.unique [
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

  debug = {
    rootPath = toString ./.;

    breedables = builtins.mapAttrs (n: s: {
      resolved = s.sprite;
      exists   = spriteExists s;
    }) cfg.breedables;

    events = builtins.mapAttrs (k: e:
      let
        d  = evtDex e;
        sp = resolveSpeciesKey e.species;
        sk = if sp != null then sp else e.species;
      in {
        species         = e.species;
        resolvedSpecies = sp;
        dex             = d;
        formSuffix      = formSuffixFor d sk;
        tried           = candidatesFor d sk false;
        resolved        = evtSpriteFor k e false;
        exists          = evtSpriteExists k e false;
      }
    ) cfg.events;

    shiny = builtins.mapAttrs (k: e:
      let entry = shinyData.${k};
      in {
        dex      = entry.dex;
        name     = entry.name;
        slug     = entry.slug;
        eggable  = entry.eggable or true;
        resolved = autoShinySprite entry;
        exists   = let s = autoShinySprite entry;
                   in s != null && builtins.pathExists (./. + "/${s}");
      }
    ) cfg.shiny;

    ballSprites = builtins.mapAttrs (b: _: {
      path   = toString (ballPath b);
      exists = ballExists b;
    }) (lib.genAttrs (lib.unique (balls ++ eventBalls)) (x: x));
  };

  html = pkgs.runCommand "pokenix-html" {
    inherit version;
  } ''
    mkdir -p $out
    cp ${ogImage} $out/og.png

    cat > $out/index.html <<'IDX'
${pageShell "breedables" "PokèNix · breedables" breedablesBody}
IDX

    cat > $out/trainer.html <<'TRN'
${pageShell "trainer" "PokèNix · trainer" trainerBody}
TRN

    cat > $out/shiny.html <<'SHN'
${pageShell "shiny" "PokèNix · shiny living" shinyBody}
SHN

    cat > $out/events.html <<'EVT'
${pageShell "events" "PokèNix · events" eventsBody}
EVT

    cat > $out/specials.html <<'SPC'
${pageShell "specials" "PokèNix · specials" specialsBody}
SPC

    : > $out/balls.sed
    ${concatStringsSep "\n" (map (b: ''
      printf 's|@BALL_${b}@|' >> $out/balls.sed
      base64 -w0 ${ballPath b} >> $out/balls.sed
      printf '|g\n' >> $out/balls.sed
    '') existingBalls)}
    for f in $out/index.html $out/events.html $out/shiny.html $out/specials.html; do
      sed -i -f $out/balls.sed "$f"
    done
    rm -f $out/balls.sed

    : > $out/sprites.sed
    ${concatStringsSep "\n" (map (n: ''
      printf 's|@SPRITE_${n}@|' >> $out/sprites.sed
      base64 -w0 ${./. + "/${breedableSpriteFor n cfg.breedables.${n}}" } >> $out/sprites.sed
      printf '|g\n' >> $out/sprites.sed
    '') existingSprites)}
    sed -i -f $out/sprites.sed $out/index.html
    rm -f $out/sprites.sed

    : > $out/sprites.sed
    ${concatStringsSep "\n" (map (k: ''
      printf 's|@EVT_SPRITE_${k}@|' >> $out/sprites.sed
      base64 -w0 ${./. + "/${evtSpriteFor k cfg.events.${k} false}"} >> $out/sprites.sed
      printf '|g\n' >> $out/sprites.sed
    '') eventsExistingSprites)}
    sed -i -f $out/sprites.sed $out/events.html
    rm -f $out/sprites.sed

    : > $out/sprites.sed
    ${concatStringsSep "\n" (map (k: ''
      printf 's|@SHINY_${k}@|' >> $out/sprites.sed
      base64 -w0 ${./. + "/${autoShinySprite shinyData.${k}}" } >> $out/sprites.sed
      printf '|g\n' >> $out/sprites.sed
    '') shinyExistingSprites)}
    sed -i -f $out/sprites.sed $out/shiny.html
    rm -f $out/sprites.sed

    : > $out/sprites.sed
    ${concatStringsSep "\n" (map (k:
      let e   = cfg.specials.${k};
          key = if e.shiny then "${k}-shiny" else k;
      in ''
        printf 's|@EVT_SPRITE_${key}@|' >> $out/sprites.sed
        base64 -w0 ${./. + "/${evtSpriteFor k e e.shiny}"} >> $out/sprites.sed
        printf '|g\n' >> $out/sprites.sed
      '') specialExistingSprites)}
    sed -i -f $out/sprites.sed $out/specials.html
    rm -f $out/sprites.sed

    : > $out/items.sed
    ${concatStringsSep "\n" (map (n: ''
      printf 's|@RIBBON_FILE_${keyFor n}@|' >> $out/items.sed
      base64 -w0 ${./. + "/${firstExisting (ribbonFileCandidates n)}"} >> $out/items.sed
      printf '|g\n' >> $out/items.sed
    '') ribbonsWithSprite)}
    ${concatStringsSep "\n" (map (n: ''
      printf 's|@MARK_FILE_${keyFor n}@|' >> $out/items.sed
      base64 -w0 ${./. + "/${markFile n}"} >> $out/items.sed
      printf '|g\n' >> $out/items.sed
    '') marksWithSprite)}
    ${concatStringsSep "\n" (map (n: ''
      printf 's|@ITEM_FILE_${keyFor n}@|' >> $out/items.sed
      base64 -w0 ${./. + "/${firstExisting (itemCandidates n)}"} >> $out/items.sed
      printf '|g\n' >> $out/items.sed
    '') itemsWithSprite)}
    for f in $out/specials.html $out/shiny.html; do
      sed -i -f $out/items.sed "$f"
    done
    rm -f $out/items.sed

    ${lib.optionalString (typesWithSprite != []) ''
      : > $out/types.sed
      ${concatStringsSep "\n" (map (t: ''
        printf 's|@TYPE_${typeIconKey t}@|' >> $out/types.sed
        base64 -w0 ${./. + "/${typeIconPath t}"} >> $out/types.sed
        printf '|g\n' >> $out/types.sed
      '') typesWithSprite)}
      for f in $out/specials.html $out/shiny.html; do
        sed -i -f $out/types.sed "$f"
      done
      rm -f $out/types.sed
    ''}

    ${lib.optionalString gmaxIconExists ''
      : > $out/gmax.sed
      printf 's|@GMAX_ICON@|' >> $out/gmax.sed
      base64 -w0 ${./. + "/${gmaxIconPath}"} >> $out/gmax.sed
      printf '|g\n' >> $out/gmax.sed
      for f in $out/shiny.html $out/events.html $out/specials.html; do
        sed -i -f $out/gmax.sed "$f"
      done
      rm -f $out/gmax.sed
    ''}

    ${lib.optionalString eggExists ''
      : > $out/egg.sed
      printf 's|@EGG_SPRITE@|' >> $out/egg.sed
      base64 -w0 ${./. + "/${eggPath}"} >> $out/egg.sed
      printf '|g\n' >> $out/egg.sed
      sed -i -f $out/egg.sed $out/shiny.html
      rm -f $out/egg.sed
    ''}

    ${lib.optionalString logoExists ''
      : > $out/logo.sed
      printf 's|@LOGO@|' >> $out/logo.sed
      base64 -w0 ${logoPath} >> $out/logo.sed
      printf '|g\n' >> $out/logo.sed
      for f in $out/*.html; do
        sed -i -f $out/logo.sed "$f"
      done
      rm -f $out/logo.sed
    ''}

    ${lib.optionalString (cfg.trainer.picture != null) ''
      : > $out/pic.sed
      printf 's|@TRAINER_PIC@|' >> $out/pic.sed
      base64 -w0 ${cfg.trainer.picture} >> $out/pic.sed
      printf '|g\n' >> $out/pic.sed
      sed -i -f $out/pic.sed $out/trainer.html
      rm -f $out/pic.sed
    ''}
  '';

  stats = {
    shinyOwned    = shinyOwnedCount;
    shinyTotal    = shinyTotalCount;
    eventCount    = eventCount;
    specialsCount = specialsCount;
    aprimonsOwned = ownedSpeciesCount;
    aprimonsTotal = totalCount;
    ballCaptures  = totalCaptures;
    ballPossible  = totalPossibleCaptures;
    totalMons     = shinyOwnedCount + eventCount + specialsCount + ownedSpeciesCount;
  };

in {
  inherit html debug stats;
}
