{ 
  lib,
  root
} : let
  inherit (lib) concatStringsSep fixedWidthString removeSuffix splitString substring toLower toUpper;

  padNum = n:
    let s = toString n;
        w = if builtins.stringLength s > 3 then builtins.stringLength s else 3;
    in fixedWidthString w "0" s;

  padDex = s: padNum s.dex;

  formatRatio = x:
    if x == null then "—"
    else if builtins.isInt x then builtins.toString x
    else
      let scaled   = builtins.floor (x * 10 + 0.5);
          intPart  = scaled / 10;
          fracPart = scaled - (intPart * 10);
      in if fracPart == 0 then builtins.toString intPart
         else "${builtins.toString intPart}.${builtins.toString fracPart}";

  genOfDex = d:
    if d <= 151 then 1 else if d <= 251 then 2 else if d <= 386 then 3
    else if d <= 493 then 4 else if d <= 649 then 5 else if d <= 721 then 6
    else if d <= 809 then 7 else if d <= 905 then 8 else 9;

  titleCaseSlug = slug:
    let cap = w:
      if w == "" then ""
      else toUpper (substring 0 1 w) + substring 1 (builtins.stringLength w - 1) w;
    in concatStringsSep " " (map cap (splitString "-" slug));

  keyFor = name:
    lib.replaceStrings [ " " "'" "’" "/" "." ] [ "_" "" "" "_" "" ] name;

  firstExisting = candidates:
    let hits = builtins.filter (p: builtins.pathExists (root + "/${p}")) candidates;
    in if hits == [] then null else builtins.head hits;

  ballFile   = b: if b == "pokeball" then "poke" else b;
  ballPath   = b: root + "/sprites/balls/${ballFile b}.png";
  ballExists = b: builtins.pathExists (ballPath b);

  isGmax = s:
    let str = toLower s;
    in lib.hasSuffix "-gmax" str || lib.hasInfix "(gmax)" str;

  stripGmax = n:
    let cleaned = builtins.replaceStrings [ " (Gmax)" " (GMAX)" " (gmax)" ] [ "" "" "" ] n;
        low = toLower cleaned;
        len = builtins.stringLength cleaned;
    in if len > 5 && lib.hasSuffix "-gmax" low then substring 0 (len - 5) cleaned else cleaned;

  shinySpriteBase = entry:
    let slug = entry.slug; g = entry.gender or null;
    in if g == "male"   && lib.hasSuffix "-m" slug then removeSuffix "-m" slug
       else if g == "female" && lib.hasSuffix "-f" slug then removeSuffix "-f" slug
       else slug;

  shinyDisplayName = entry:
    let
      slug   = entry.slug;
      g      = entry.gender or null;
      noGmax = if lib.hasSuffix "-gmax" slug then removeSuffix "-gmax" slug else slug;
      base   = if g == "male" && lib.hasSuffix "-m" noGmax then removeSuffix "-m" noGmax
               else if g == "female" && lib.hasSuffix "-f" noGmax then removeSuffix "-f" noGmax
               else noGmax;
      pretty = titleCaseSlug base;
      symbol = if g == "male" then " ♂" else if g == "female" then " ♀" else "";
    in pretty + symbol;

  itemSlug       = name: lib.replaceStrings [ " " "'" "’" "." ] [ "-" "" "" "" ] (toLower name);
  itemCandidates = name: [
    "sprites/items/hold-item/${itemSlug name}.png"
    "sprites/items/berry/${itemSlug name}.png"
  ];

  markOverrides = {
    "the unrivaled" = "uncommon"; "unrivaled" = "uncommon"; "uncommon" = "uncommon";
    "the recluse"   = "rare";     "recluse"   = "rare";     "rare"     = "rare";
    "the teary-eyed" = "teary";   "teary-eyed" = "teary";   "teary"    = "teary";
    "the sleepy-time" = "sleepy-time";
    "the early bird"  = "dawn";
    "the itemfinder"  = "itemfinder"; "itemfinder" = "itemfinder";
  };

  markSlug = name:
    let s = toLower name;
    in if builtins.hasAttr s markOverrides then markOverrides.${s}
       else
         let stripped = if lib.hasPrefix "the " s then lib.removePrefix "the " s else s;
         in lib.replaceStrings [ " " "'" "’" "." ] [ "-" "" "" "" ] stripped;

  markFile = name: "sprites/misc/mark/${markSlug name}-mark.png";

  ribbonSlug = name:
    let s  = toLower name;
        s1 = if lib.hasSuffix " ribbon" s then lib.removeSuffix " ribbon" s else s;
    in lib.replaceStrings [ " " "'" "’" "." ] [ "-" "" "" "" ] s1;

  ribbonFileCandidates = name: [
    "sprites/misc/ribbon/${ribbonSlug name}-ribbon.png"
    "sprites/misc/ribbon/gen8/${ribbonSlug name}-ribbon.png"
  ];

  balls = [
    "safari" "sport" "fast" "friend" "heavy" "level"
    "love" "lure" "moon" "dream" "beast"
  ];

  eventBalls = [ "cherish" "pokeball" ];

  regions = {
    "1" = "KANTO";   "2" = "JOHTO";  "3" = "HOENN";  "4" = "SINNOH";  "5" = "UNOVA";
    "6" = "KALOS";   "7" = "ALOLA";  "8" = "GALAR";  "9" = "PALDEA";
  };
in { 
  inherit padNum padDex formatRatio genOfDex titleCaseSlug keyFor firstExisting
            ballFile ballPath ballExists isGmax stripGmax shinySpriteBase
            shinyDisplayName itemSlug itemCandidates markSlug markFile
            ribbonSlug ribbonFileCandidates balls eventBalls regions; 
}
