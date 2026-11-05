{ lib, pkgs }: cfg:
let
  inherit (lib) mkOption types genAttrs mkIf concatStringsSep filterAttrs
                mapAttrsToList fixedWidthString;

  root = ./.;

  fns     = import ./lib/fns.nix     { inherit lib root; };
  data    = import ./lib/data.nix    { inherit lib root; };
  species = import ./lib/species.nix { inherit lib; inherit (data) pokemonRaw movesRaw; };
  sprites = import ./lib/sprites.nix { inherit lib fns root; inherit (data) pokespriteData; };
  misc    = import ./lib/misc.nix    { inherit lib fns; pokedex = cfg.pokedex; };
  shiny   = import ./lib/shiny.nix   { inherit lib fns cfg root; };
  lookup  = import ./lib/lookup.nix  {
    inherit lib fns root;
    breedables = cfg.breedables;
    inherit (shiny) shinyData;
    inherit (sprites) autoSprite;
  };
  statsM  = import ./lib/stats.nix {
    inherit lib;
    inherit (data) pokemonRaw;
    inherit (lookup) evtDex;
  };

  inherit (fns) padNum padDex formatRatio genOfDex titleCaseSlug keyFor firstExisting
                ballFile ballPath ballExists isGmax stripGmax shinySpriteBase
                shinyDisplayName itemSlug itemCandidates markSlug markFile
                ribbonSlug ribbonFileCandidates balls eventBalls regions;

  inherit (data) version pokespriteData rawBreedables movesRaw pokemonRaw moveInfoRaw;

  inherit (species) pokemonEntryFor pokemonKeyFor serebiiUrlFor typesFor typeSortKey
                    cryUrlFor movesEntryFor;

  inherit (sprites) formSuffixFor slugForDex autoSprite autoShinySprite
                    breedableSpriteFor breedableSpriteExists spritePath spriteExists;

  inherit (misc) miscLookup miscSpritePath ribbonSpriteFor markSpriteFor;

  inherit (shiny) shinyJsonPath shinyList shinyData specialShiniesBySpecies
                  isShinyOwned isShinyFromSpecial effectiveShinyFor;

  inherit (lookup) resolveSpeciesKey lookupSpecies evtDex evtName evtSpriteFor evtSpriteExists;

  inherit (statsM) natures statsByDex computeStats;

  picMime = p:
    let s = lib.toLower (toString p);
    in if lib.hasSuffix ".jpg" s || lib.hasSuffix ".jpeg" s then "image/jpeg"
       else if lib.hasSuffix ".webp" s then "image/webp"
       else if lib.hasSuffix ".gif" s then "image/gif"
       else "image/png";

  breedMeta = name:
    let raw = rawBreedables.${name} or { };
        m   = movesEntryFor name;
        p   = pokemonEntryFor name;
    in {
      genderless     = raw.genderless     or false;
      male           = raw.male           or null;
      female         = raw.female         or null;
      hatchCycles    = raw.hatchCycles    or (p.hatchCounter or null);
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
    let e = effectiveShinyFor k;
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
      page = "breedables.html";
    }) sortedNames;
    shiny = builtins.map (k: {
      name = shinyDisplayName shinyData.${k};
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

  logoPath   = ./images/logo.png;
  logoExists = builtins.pathExists logoPath;

  maxNameLen = builtins.foldl'
    (acc: n:
      let l = builtins.stringLength cfg.breedables.${n}.name;
      in if l > acc then l else acc)
    0
    sortedNames;

  nameWidthCss = "${toString (maxNameLen + 3)}ch";

  shinyMaxNameLen = builtins.foldl'
    (acc: n:
      let l = builtins.stringLength (shinyDisplayName shinyData.${n});
      in if l > acc then l else acc)
    0
    (builtins.attrNames shinyData);

  shinyNameWidthCss = "${toString (shinyMaxNameLen + 3)}ch";

  typeIconKey    = t: lib.toLower t;
  typeIconPath   = t: "sprites/misc/types/gen8/${typeIconKey t}.png";
  typeIconExists = t: builtins.pathExists (./. + "/${typeIconPath t}");

  gmaxIconPath   = "sprites/misc/special-attribute/gigantamax-icon.png";
  gmaxIconExists = builtins.pathExists (./. + "/${gmaxIconPath}");

  renderGmaxBadge = s:
    if !(isGmax s) || !gmaxIconExists then ""
    else ''<img class="gmax-badge" src="data:image/png;base64,@GMAX_ICON@" alt="Gmax" title="Gigantamax">'';

  nameWithGmax = n: species:
    stripGmax n + renderGmaxBadge "${n} ${species}";

  eggPath   = "sprites/pokemon-gen8/egg.png";
  eggExists = builtins.pathExists (./. + "/${eggPath}");

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
  eventColumns   = "56px 52px 48px minmax(${nameWidthCss}, 1fr) 110px 44px 44px 88px 120px 88px 32px";
  specialColumns = "56px 52px 48px minmax(${nameWidthCss}, 1fr) 110px 44px 44px 76px 100px 240px 32px";
  shinyColumns   = "56px 52px 48px minmax(${shinyNameWidthCss}, 1fr) 110px minmax(120px, 2fr) 44px 82px 48px";

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
    isShinyOwned
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
    let
      cry      = cryUrlFor name;
      cryAttr  = if cry != null then ''data-cry="${cry}" title="Click to play cry"'' else "";
      cryClass = if cry != null then " cry-click" else "";
    in
    if breedableSpriteExists name s
    then ''<span class="cell-sprite${cryClass}" ${cryAttr}><img class="sprite" src="data:image/png;base64,@SPRITE_${name}@" alt="${name}"></span>''
    else ''<span class="cell-sprite${cryClass}" ${cryAttr}><svg class="sprite placeholder" viewBox="0 0 32 32"><rect width="32" height="32" fill="#2a2a2a"/><text x="16" y="21" font-size="9" text-anchor="middle" fill="#666">#${padDex s}</text></svg></span>'';

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

  moveInfo = slug: moveInfoRaw.${slug} or { };

  renderMovePill = slug:
    let
      info = moveInfo slug;
      name = info.name or (titleCaseSlug slug);
      typ  = info.type or "normal";
      cls  = info.damageClass or "status";
      pw   = info.power    or null;
      acc  = info.accuracy or null;
      pp   = info.pp       or null;
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
      d        = evtDex e;
      n        = evtName e;
      pad      = padNum d;
      key      = if shiny then "${k}-shiny" else k;
      cry      = cryUrlFor e.species;
      cryAttr  = if cry != null then ''data-cry="${cry}" title="Click to play cry"'' else "";
      cryClass = if cry != null then " cry-click" else "";
    in
    if evtSpriteExists k e shiny
    then ''<span class="cell-sprite${cryClass}" ${cryAttr}><img class="sprite" src="data:image/png;base64,@EVT_SPRITE_${key}@" alt="${n}"></span>''
    else ''<span class="cell-sprite${cryClass}" ${cryAttr}><svg class="sprite placeholder" viewBox="0 0 32 32"><rect width="32" height="32" fill="#2a2a2a"/><text x="16" y="21" font-size="9" text-anchor="middle" fill="#666">#${pad}</text></svg></span>'';

  renderDetail = label: value:
    let v = if value == null then null else toString value;
    in ''<div class="detail"><span class="detail-label">${label}</span><span class="detail-value">${if v == null || v == "" then "—" else v}</span></div>'';

  renderItemPill = kind: name:
    let
      category = if kind == "ribbon" then "ribbons" else "marks";
      meta     = miscLookup category name;
      display  = if meta != null then (meta.name.eng or name) else name;
      desc     = if meta != null then (meta.description.eng or "") else "";
      tip      = if desc != "" then "${display} — ${desc}" else display;
      file     =
        if kind == "ribbon" then ribbonSpriteFor name
        else                      markSpriteFor   name;
      key = keyFor name;
      ph  = "@${lib.toUpper kind}_FILE_${key}@";
    in
    if file == null
    then ''<span class="${kind}-item" title="${tip}">${display}</span>''
    else ''<span class="${kind}-item" title="${tip}"><img class="${kind}-sprite" src="data:image/png;base64,${ph}" alt="" title="${tip}"><span>${display}</span></span>'';

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
      ribbonImgs = builtins.filter (n: ribbonSpriteFor n != null) sp.ribbons;
      markImgs   = builtins.filter (n: markSpriteFor   n != null) sp.marks;
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
      ts  = typesFor e.species;
      tk  = typeSortKey e.species;
    in ''
      <details class="event" id="pk-${k}" data-dex="${pad}" data-name="${n}" data-year="${y}" data-ot="${o}" data-region="${r}" data-type="${tk}">
        <summary class="event-row">
          ${renderDexLink e.species d n}
          ${renderEvtSprite k shiny e}
          ${renderEvtBall e}
          <span class="event-name" title="${n}">${nameWithGmax n e.species}</span>
          <span class="event-type">${renderTypeBadges ts}</span>
          ${renderCheckShiny e.shiny}
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
      <span class="event-type" data-sort="type">Type</span>
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
      e             = effectiveShinyFor k;
      fromSpecial   = isShinyFromSpecial k;
      sprite        = autoShinySprite entry;
      hasSprite     = sprite != null && builtins.pathExists (./. + "/${sprite}");
      pad           = padNum entry.dex;
      owned         = isShinyOwned k;
      eggable       = entry.eggable or true;
      shinyIcon     = if (e.style or "star") == "square" then "▣" else "★";
      ballCell      =
        if !owned then ''<span class="event-ball-slot empty"></span>''
        else if e.ball == null then
          ''<span class="event-ball-slot missing" title="owned · ball not recorded"></span>''
        else if !(ballExists e.ball) then
          ''<span class="event-ball-slot missing" title="${e.ball} (sprite missing)"></span>''
        else
          ''<span class="event-ball-slot" title="${e.ball}"><img src="data:image/png;base64,@BALL_${e.ball}@" alt="${e.ball}"></span>'';
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
      ts         = typesFor k;
      tk         = typeSortKey k;
    in ''
      <details class="shiny-row-details ${if owned then "owned" else "empty"}${if fromSpecial then " from-special" else ""}"
               id="pk-${k}" data-dex="${pad}" data-name="${entry.name}" data-type="${tk}">
        <summary class="shiny-row">
          ${renderDexLink k entry.dex entry.name}
          ${if hasSprite
            then ''<span class="cell-sprite"><img class="sprite" src="data:image/png;base64,@SHINY_${k}@" alt="${entry.name}"></span>''
            else ''<span class="cell-sprite"><svg class="sprite placeholder" viewBox="0 0 32 32"><rect width="32" height="32" fill="#2a2a2a"/><text x="16" y="21" font-size="9" text-anchor="middle" fill="#666">#${pad}</text></svg></span>''}
          ${ballCell}
          <span class="shiny-name" title="${shinyDisplayName entry}">${shinyDisplayName entry}${renderGmaxBadge entry.slug}</span>
          <span class="shiny-types">${renderTypeBadges ts}</span>
          <span class="shiny-notes">${if fromSpecial then ''<span class="src-badge" title="Filled in from pokenix.specials">★ specials</span> '' else ""}${if e.notes or null != null then e.notes else ""}</span>
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
    <div class="trainer-footer">
      © PokéNix 2026 · Please report issues or feature requests at
      <a href="https://github.com/quackhack-mcblindy/pokenix" target="_blank" rel="noopener">GitHub</a>.
    </div>
  '';

  renderShinyList = ''
    <div class="summary">${toString shinyOwnedCount} / ${toString shinyTotalCount} collected (${toString shinyPct}%)</div>
    <div class="shiny-row shiny-header">
      <span class="shiny-dex" data-sort="dex">Dex</span>
      <span class="cell-sprite"></span>
      <span class="event-ball-slot"></span>
      <span class="shiny-name" data-sort="name">Pokémon</span>
      <span class="shiny-types" data-sort="type">Type</span>
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
      ts    = typesFor sp.species;
      tk    = typeSortKey sp.species;
    in ''
      <details class="event special" id="pk-${k}"
               data-dex="${pad}" data-name="${n}"
               data-level="${lvl}" data-nature="${nat}"
               data-type="${tk}">
        <summary class="event-row special-row">
          ${renderDexLink sp.species d n}
          ${renderEvtSprite k sp.shiny sp}
          ${renderEvtBall sp}
          <span class="event-name" title="${n}">${nameWithGmax n sp.species}</span>
          <span class="event-type">${renderTypeBadges ts}</span>
          ${renderCheckShiny sp.shiny}
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
      <span class="event-type" data-sort="type">Type</span>
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
      ${if logoExists then "<a href=\"https://github.com/QuackHack-McBlindy/pokenix\" class=\"logo-link\" target=\"_blank\" rel=\"noopener\" title=\"pokenix on GitHub\"><img class=\"logo\" src=\"data:image/png;base64,@LOGO@\" alt=\"PokèNix\"></a>" else ""}
      <span class="brand">${brandName}</span>
      <small>· ${navLink currentPage "trainer"    "index.html"     "trainer"} · ${navLink currentPage "breedables" "breedables.html" "breedables"} · ${navLink currentPage "shiny" "shiny.html" "shiny living"} · ${navLink currentPage "events" "events.html" "events"} · ${navLink currentPage "specials" "specials.html" "specials"}</small>
      ${lib.optionalString (currentPage == "shiny") "<span class=\"progress\">${toString shinyOwnedCount}/${toString shinyTotalCount} · ${toString shinyPct}%</span>"}
      <span class="h1-right">
        ${lib.optionalString (currentPage != "trainer") "<span class=\"search-wrap\"><input type=\"text\" id=\"search-input\" class=\"tool-input\" placeholder=\"Search all Pokémon…\" autocomplete=\"off\" spellcheck=\"false\"><div id=\"search-results\" class=\"search-results\"></div></span>"}
        ${lib.optionalString (currentPage == "breedables" || currentPage == "shiny") "<button id=\"filter-toggle\" class=\"tool-btn\" type=\"button\">Showing: all</button>"}
        <button id="pk-edit-toggle" class="tool-btn" type="button" title="Toggle inline edit mode">✎ Edit</button>
        <button id="pk-edit-new" class="tool-btn" type="button" title="Add a new blank row" hidden>＋</button>
        <button id="export-btn" class="tool-btn" type="button" title="Export collection (Upload on GitHub)">Export</button>
        <button id="theme-toggle" class="theme-btn" type="button" title="Toggle theme">☀️</button>
        <a href="#" class="top-btn" onclick="window.scrollTo({top:0,behavior:'smooth'}); return false;">↑</a>
      </span>
    </h1>
  '';

  sharedJs  = builtins.readFile ./static/script.js;
  sharedCss =
    builtins.replaceStrings
      [ "__BREED_COLUMNS__" "__EVENT_COLUMNS__" "__SPECIAL_COLUMNS__" "__SHINY_COLUMNS__" ]
      [ breedColumns        eventColumns        specialColumns        shinyColumns        ]
      (builtins.readFile ./static/styles.css);

  siteDescription =
    "PokéNix — ${brandName}'s collection: "
    + "${toString totalCaptures}/${toString totalPossibleCaptures} aprimons · "
    + "${toString shinyOwnedCount}/${toString shinyTotalCount} shiny · "
    + "${toString eventCount} events";

  ogImageUrl =
    let
      user = cfg.trainer.githubUsername;
      repo = cfg.trainer.githubRepo;
      isUserPage = repo == null || repo == "" || repo == "${user}.github.io";
    in
    if user == null || user == ""
    then "og.png"
    else if isUserPage
    then "https://${user}.github.io/og.png"
    else "https://${user}.github.io/${repo}/og.png";

  ogImage =
    let
      fontPath = "${pkgs.dejavu_fonts}/share/fonts/truetype";
      esc      = s: "'${builtins.replaceStrings [ "'" ] [ "'\\''" ] s}'";
      flat     = s: builtins.replaceStrings [ "\n" ] [ " " ] s;
      hasPic = cfg.trainer.picture != null;
      about  = flat (if cfg.trainer.about  != null then cfg.trainer.about  else "");
      region = flat (if cfg.trainer.region != null then cfg.trainer.region else "");
      statLines = [
        "${toString totalCaptures}/${toString totalPossibleCaptures} aprimons"
        "${toString shinyOwnedCount}/${toString shinyTotalCount} shiny living dex"
        "${toString eventCount} event pokémon"
        "${toString specialsCount} other pokémon"
      ];
      statAnnots = lib.concatStringsSep " " (lib.imap0
        (i: line: "-annotate +${textX}+${toString (420 + i * 38)} ${esc line}")
        statLines);
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
          ${statAnnots} \
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

    <meta property="og:type"             content="website">
    <meta property="og:site_name"        content="PokéNix">
    <meta property="og:title"            content="${title}">
    <meta property="og:description"      content="${siteDescription}">
    <meta property="og:image"            content="${ogImageUrl}">
    <meta property="og:image:secure_url" content="${ogImageUrl}">
    <meta property="og:image:type"       content="image/png">
    <meta property="og:image:width"      content="1200">
    <meta property="og:image:height"     content="630">
    <meta property="og:image:alt"        content="PokéNix trainer card for ${brandName}">
    <meta property="og:url"              content="${ogImageUrl}">

    <meta name="twitter:card"        content="summary_large_image">
    <meta name="twitter:title"       content="${title}">
    <meta name="twitter:description" content="${siteDescription}">
    <meta name="twitter:image"       content="${ogImageUrl}">

    <style>
    ${sharedCss}
    </style>
    </head>
    <body data-page="${currentPage}">
    ${navBar currentPage}
    ${body}
    <script>window.POKENIX_INDEX = ${builtins.toJSON globalIndex};</script>
    <script>window.POKENIX_DATA = ${builtins.toJSON {
      shiny      = cfg.shiny;
      events     = cfg.events;
      specials   = cfg.specials;
      trainer    = {
        inherit (cfg.trainer)
          name about region timezone contact friendCode
          switchName trainerId secretId githubUsername githubRepo shinyDexType;
      };
      breedables = builtins.mapAttrs (n: s: { inherit (s) name dex; }) cfg.breedables;
      natures    = builtins.attrNames natures;
      balls      = balls;

      breedablesFull = builtins.mapAttrs (n: s:
        let
          active = builtins.filter (b:
            (s.${b}.ball     or false) ||
            (s.${b}.ha       or false) ||
            (s.${b}.eggMoves or false)
          ) balls;
        in {
          inherit (s) name dex;
          captured = builtins.listToAttrs (map (b: {
            name = b;
            value = {
              ball     = s.${b}.ball     or false;
              ha       = s.${b}.ha       or false;
              eggMoves = s.${b}.eggMoves or false;
            };
          }) active);
        }
      ) cfg.breedables;

      speciesValid = lib.unique (builtins.attrNames (cfg.pokedex.pokemon or {}));
      speciesList  = lib.unique (
        let
          dexNames   = builtins.attrNames (cfg.pokedex.pokemon or {});
          baseNames  = map (n: builtins.head (lib.splitString "-" n)) dexNames;
          collection = (builtins.attrNames cfg.breedables)
                    ++ (builtins.attrNames cfg.shiny)
                    ++ (builtins.attrNames cfg.events)
                    ++ (builtins.attrNames cfg.specials);
        in dexNames ++ baseNames ++ collection
      );
      speciesMeta = builtins.mapAttrs (n: p: {
        dex   = p.dexNumber or null;
        types = p.types     or [];
        name  = p.name      or p.species or n;
      }) (cfg.pokedex.pokemon or {});

      ballSprites = builtins.listToAttrs (map (b: {
        name  = b;
        value = "data:image/png;base64,@BALL_${b}@";
      }) existingBalls);

      githubUrl =
        if cfg.trainer.githubUsername != null && cfg.trainer.githubRepo != null
        then "https://github.com/${cfg.trainer.githubUsername}/${cfg.trainer.githubRepo}"
        else null;
    }};</script>

    <script>${sharedJs}</script>
    </body>
    </html>
  '';

  breedablesBody = ''
    <div class="summary">${toString totalCount} species · ${toString ownedSpeciesCount} in collection · ${toString totalCaptures} aprimons total</div>
    <div class="legend">
      <span>ball guide:</span>
      <span class="item"><span class="ball possible"><img src="data:image/png;base64,@BALL_safari@" alt=""></span>legal</span>
      <span class="item"><span class="ball caught"><img src="data:image/png;base64,@BALL_fast@" alt=""></span>caught</span>
      <span class="item"><span class="ball ha"><img src="data:image/png;base64,@BALL_love@" alt=""></span>+ HA</span>
      <span class="item"><span class="ball em"><img src="data:image/png;base64,@BALL_beast@" alt=""></span>HA + EM</span>
      <span class="item"><span class="ball unavailable"><span class="ball-x">✕</span></span>not legal</span>
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

  ribbonsWithSprite = builtins.filter (n: ribbonSpriteFor n != null) allUsedRibbons;
  marksWithSprite   = builtins.filter (n: markSpriteFor   n != null) allUsedMarks;

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
${pageShell "trainer" "PokèNix · trainer" trainerBody}
IDX

    cat > $out/breedables.html <<'BRD'
${pageShell "breedables" "PokèNix · breedables" breedablesBody}
BRD

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
    for f in $out/breedables.html $out/events.html $out/shiny.html $out/specials.html; do
      sed -i -f $out/balls.sed "$f"
    done
    rm -f $out/balls.sed

    : > $out/sprites.sed
    ${concatStringsSep "\n" (map (n: ''
      printf 's|@SPRITE_${n}@|' >> $out/sprites.sed
      base64 -w0 ${./. + "/${breedableSpriteFor n cfg.breedables.${n}}" } >> $out/sprites.sed
      printf '|g\n' >> $out/sprites.sed
    '') existingSprites)}
    sed -i -f $out/sprites.sed $out/breedables.html
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
      base64 -w0 ${./. + "/${ribbonSpriteFor n}"} >> $out/items.sed
      printf '|g\n' >> $out/items.sed
    '') ribbonsWithSprite)}
    ${concatStringsSep "\n" (map (n: ''
      printf 's|@MARK_FILE_${keyFor n}@|' >> $out/items.sed
      base64 -w0 ${./. + "/${markSpriteFor n}"} >> $out/items.sed
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
      sed -i -f $out/pic.sed $out/index.html
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
  
  renderDexLink = key: dex: name:
    let
      url = serebiiUrlFor key;
      pad = padNum dex;
    in
    if url == null then ''<span class="dex">#${pad}</span>''
    else ''
      <span class="dex-wrap">
        <a class="dex" href="${url}" target="_blank" rel="noopener">#${pad}</a>
        <div class="dex-hover">
          <iframe src="${url}" loading="lazy" title="${name} on Serebii"></iframe>
          <div class="dex-hover-fallback">
            <div class="dhf-title">${name} · Serebii</div>
            <div class="dhf-url">${url}</div>
            <div class="dhf-hint">Click to open in a new tab.</div>
          </div>
        </div>
      </span>
    '';

  renderCheckShiny = val:
    if val
    then ''<span class="check yes shiny-mark" title="shiny">✨</span>''
    else ''<span class="check no" title="not shiny"></span>'';

in {
  inherit html debug stats;
}
