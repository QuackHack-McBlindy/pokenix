{ 
  lib,
  pkgs,
  config,
  ...
} : let
  inherit (lib)
    mkOption types genAttrs mkIf concatStringsSep filterAttrs
    mapAttrsToList fixedWidthString;

  balls = [
    "safari" "sport" "fast" "friend" "heavy" "level"
    "love" "lure" "moon" "dream" "beast"
  ];
  allBalls = balls;

  data =
    (import ./breedables/kanto.nix  { })
    // (import ./breedables/johto.nix  { })
    // (import ./breedables/hoenn.nix  { })
    // (import ./breedables/sinnoh.nix { })
    // (import ./breedables/unova.nix  { })
    // (import ./breedables/kalos.nix  { })
    // (import ./breedables/alola.nix  { })
    // (import ./breedables/galar.nix  { })
    // (import ./breedables/paldea.nix { });

  mkRo = type: value: { inherit type; default = value; apply = _: value; };
  serebiiUrl = slug: "https://www.serebii.net/pokedex-swsh/${slug}/";

  ballModule = legal: { config, ... }: {
    options = {
      possible = mkOption (mkRo types.bool legal);
      ball     = mkOption { type = types.bool; default = false; apply = v: v && legal; };
      ha       = mkOption { type = types.bool; default = false; apply = v: v && legal; };
      eggMoves = mkOption { type = types.bool; default = false; apply = v: v && legal; };
    };
    config = {
      ball = mkIf config.ha       true;
      ha   = mkIf config.eggMoves true;
    };
  };

  speciesModule = name: e: {
    options = {
      dex         = mkOption { type = types.int; default = e.dex; };
      name        = mkOption { type = types.str; default = name; };
      ha          = mkOption { type = types.str; default = e.ha; };
      serebii     = mkOption { type = types.str; default = e.serebii or (serebiiUrl (e.slug or name)); };
      sprite      = mkOption { type = types.str; default = e.sprite; };
      genderless  = mkOption { type = types.bool; default = e.genderless or false; };
      male        = mkOption {
        type    = types.nullOr (types.either types.int types.float);
        default = if e.genderless or false then null else e.male or null;
      };
      female      = mkOption {
        type    = types.nullOr (types.either types.int types.float);
        default = if e.genderless or false then null else e.female or null;
      };
      hatchCycles = mkOption { type = types.nullOr types.int; default = e.hatchCycles or null; };
    } // genAttrs balls (b: mkOption {
      type    = types.submodule (ballModule (builtins.elem b (e.balls or allBalls)));
      default = {};
    });
  };

  cfg = config.pokenix;

  spritePath   = s: ./. + "/${s.sprite}";
  ballPath     = b: ./. + "/sprites/balls/${b}.png";
  spriteExists = s: builtins.pathExists (spritePath s);
  ballExists   = b: builtins.pathExists (ballPath b);

  padDex = s: fixedWidthString 3 "0" (toString s.dex);

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


  renderSprite = name: s:
    if spriteExists s
    then ''<img class="sprite" src="data:image/png;base64,@SPRITE_${name}@" alt="${name}">''
    else ''<svg class="sprite placeholder" viewBox="0 0 32 32"><rect width="32" height="32" fill="#2a2a2a"/><text x="16" y="21" font-size="9" text-anchor="middle" fill="#666">#${padDex s}</text></svg>'';

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

  renderGender = s:
    if s.genderless then ''<span class="gender" title="genderless"> </span>''
    else if s.female == null then ''<span class="gender" title="gender ratio not recorded">?</span>''
    else if s.female == 0 then ''<span class="gender male" title="male only">♂</span>''
    else ''<span class="gender female" title="${formatRatio s.female}% female">♀</span>'';

  renderRatio = s:
    if s.genderless then ''<span class="ratio">genderless</span>''
    else if s.female == null then ''<span class="ratio">—</span>''
    else if s.female == 0 then ''<span class="ratio">100%</span>''
    else if s.male == 0 then ''<span class="ratio">100%</span>''
    else ''<span class="ratio">${formatRatio s.female}%</span>'';

  renderCycles = s:
    if s.hatchCycles == null then ''<span class="cycles">—</span>''
    else ''<span class="cycles">${toString s.hatchCycles}</span>'';

  renderBall = bname: bc:
    if !bc.possible then ""
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
      in ''<span class="ball ${state}" title="${title}"><img src="data:image/png;base64,@BALL_${bname}@" alt="${bname}"></span>'';

  renderBalls = s: concatStringsSep "" (map (b: renderBall b s.${b}) balls);

  renderCompleteStar = s:
    if builtins.any (b: s.${b}.eggMoves) balls
    then ''<span class="star" title="100% complete in at least one ball">★</span>''
    else "";

  speciesEntry = name: s: ''
    <div class="entry ${if anyOwned s then "" else "untouched"}">
      ${renderDex name s}
      ${renderSprite name s}
      <span class="name">${s.name}${renderCompleteStar s}</span>
      <span class="ha">${s.ha}</span>
      <span class="balls">${renderBalls s}</span>
      ${renderGender s}
      ${renderRatio s}
      ${renderCycles s}
    </div>
  '';

  renderGeneration = n: ''
    <div class="generation-label">GENERATION ${toString n}</div>
  '';


  entriesHtml =
    let
      result = builtins.foldl'
        (acc: name:
          let
            s = cfg.breedables.${name};
            g = genOfDex s.dex;
            divider = if g != acc.prevGen then renderGeneration g + "\n" else "";
          in {
            text = acc.text + divider + (speciesEntry name s) + "\n";
            prevGen = g;
          }
        ) { text = ""; prevGen = 0; } sortedNames;
    in result.text;

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
      <span class="sprite"></span>
      <span class="name">Pokémon</span>
      <span class="ha">Hidden Ability</span>
      <span class="balls">
        ${concatStringsSep "" (map renderBallHeader balls)}
        <span class="total" title="total captures across all balls">= ${toString totalCaptures}</span>
      </span>
      <span class="gender"></span>
      <span class="ratio">Gender</span>
      <span class="cycles">Egg Cycles</span>
    </div>
  '';

  existingBalls   = builtins.filter ballExists balls;
  existingSprites = builtins.filter (n: spriteExists cfg.breedables.${n}) sortedNames;


  html = pkgs.runCommand "pokenix-html" { } ''
    mkdir -p $out

    cat > $out/index.html <<'HEAD'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Pokenix · breedables</title>
<style>
:root { color-scheme: dark; }
* { box-sizing: border-box; }
body {
  font-family: -apple-system, "Segoe UI", system-ui, sans-serif;
  background: #121212; color: #e6e6e6;
  margin: 0; padding: 28px 32px; max-width: 1280px;
}
h1 { font-weight: 300; margin: 0 0 4px; letter-spacing: 1px; }
h1 small { color: #666; font-size: 13px; font-weight: 400; margin-left: 8px; }
.summary { color: #888; margin-bottom: 14px; font-size: 13px; }
.legend {
  color: #999; font-size: 12px; margin-bottom: 18px;
  display: flex; gap: 16px; align-items: center; flex-wrap: wrap;
}
.legend .item { display: inline-flex; align-items: center; gap: 6px; }
.legend .ball { pointer-events: none; }

.entry {
  display: flex; align-items: center; gap: 10px;
  padding: 6px 8px; border-bottom: 1px solid #1e1e1e;
  border-radius: 3px; transition: background .1s;
}
.entry:hover { background: #181818; }
.entry.untouched { opacity: 0.75; }
.entry.untouched:hover { opacity: 1; }


.generation-label {
  padding: 22px 8px 8px;
  font-size: 11px;
  text-transform: uppercase;
  letter-spacing: 3px;
  color: #777;
  font-weight: 600;
  border-bottom: 1px solid #2a2a2a;
  margin-bottom: 2px;
}
.generation-label:first-of-type { padding-top: 4px; }

.entry.header {
  background: #1a1a1a;
  border-bottom: 2px solid #333;
  padding: 10px 8px;
  margin-bottom: 4px;
  font-size: 11px;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  color: #888;
  position: sticky; top: 0; z-index: 20;
}
.entry.header .ball-col {
  display: inline-flex; flex-direction: column; align-items: center; gap: 2px;
}
.entry.header .ball-count {
  font-size: 11px; color: #bbb;
  font-family: ui-monospace, monospace; line-height: 1;
  text-transform: none; letter-spacing: 0;
}
.entry.header .total {
  margin-left: 14px;
  color: #f0c040;
  font-family: ui-monospace, monospace;
  font-weight: 600;
  font-size: 11px;
  text-transform: none;
  letter-spacing: 0;
  align-self: center;
}

.dex-wrap {
  width: 46px; flex-shrink: 0; position: relative;
}
.dex {
  display: block; color: #666;
  font-family: ui-monospace, monospace; font-size: 12px;
  text-decoration: none;
}
.dex:hover { color: #6cf; }
.sprite { width: 40px; height: 40px; image-rendering: pixelated; flex-shrink: 0; }
.name { min-width: 150px; font-weight: 500; display: inline-flex; align-items: center; gap: 6px; }
.star { color: #f0c040; font-size: 12px; }
.ha { color: #6cf; min-width: 130px; font-size: 12px; }
.balls { display: inline-flex; gap: 2px; flex-shrink: 0; align-items: center; }
.gender { font-size: 15px; width: 22px; text-align: center; flex-shrink: 0; }
.gender.male   { color: #6cf; }
.gender.female { color: #f6c; }
.ratio  { color: #888; font-size: 11px; min-width: 60px; text-align: right; flex-shrink: 0; }
.cycles { color: #888; font-size: 11px; min-width: 70px; text-align: right; flex-shrink: 0; }
.untouched .ratio, .untouched .cycles { color: #666; }

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

.ball.available       { opacity: 0.35; filter: grayscale(0.5); }
.ball.owned::before   { border-color: #666; }
.ball.ha::before      { border-color: #40c0f0; }
.ball.em::before      { border-color: #40e080; }
.ball.missing::before { border-color: #333; border-style: dashed; }

.dex-hover {
  display: none;
  position: absolute;
  top: 100%;
  left: 0;
  width: 440px;
  height: 360px;
  background: #1a1a1a;
  border: 1px solid #444;
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
  color: #888; font-size: 12px;
}
.dhf-title { color: #e6e6e6; font-size: 14px; font-weight: 500; }
.dhf-url { color: #6cf; font-family: ui-monospace, monospace; font-size: 11px; word-break: break-all; }
.dhf-hint { color: #666; font-size: 11px; margin-top: 8px; }
</style>
</head>
<body>
HEAD

    cat >> $out/index.html <<HEAD2
<h1>Pokenix <small>· breedables</small></h1>
<div class="summary">${toString totalCount} species · ${toString ownedSpeciesCount} in collection · ${toString totalCaptures} ball captures</div>
<div class="legend">
  <span>legend:</span>
  <span class="item"><span class="ball available"><img src="data:image/png;base64,@BALL_safari@" alt=""></span>possible</span>
  <span class="item"><span class="ball owned"><img src="data:image/png;base64,@BALL_fast@" alt=""></span>caught</span>
  <span class="item"><span class="ball ha"><img src="data:image/png;base64,@BALL_love@" alt=""></span>+ HA</span>
  <span class="item"><span class="ball em"><img src="data:image/png;base64,@BALL_beast@" alt=""></span>HA + EM</span>
</div>
HEAD2

    cat >> $out/index.html <<ROWS
${headerRow}
${entriesHtml}
ROWS

    echo '</body></html>' >> $out/index.html

    ${concatStringsSep "\n" (map (b: ''
      b64=$(base64 -w0 ${ballPath b})
      sed -i "s|@BALL_${b}@|$b64|g" $out/index.html
    '') existingBalls)}

    ${concatStringsSep "\n" (map (n: ''
      b64=$(base64 -w0 ${spritePath cfg.breedables.${n}})
      sed -i "s|@SPRITE_${n}@|$b64|g" $out/index.html
    '') existingSprites)}
  '';

in {
  options.pokenix.breedables = mkOption {
    description = "Declarative breeding tracker per species and ball.";
    type = types.submodule {
      options = genAttrs (builtins.attrNames data) (n: mkOption {
        type    = types.submodule (speciesModule n data.${n});
        default = {};
      });
    };
    default = {};
  };

  options.pokenix.html = mkOption {
    type = types.package;
    readOnly = true;
    default = html;
    description = "Self-contained HTML page listing every breedable.";

  };}
