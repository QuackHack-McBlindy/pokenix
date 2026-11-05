{ 
  lib,
  fns,
  pokespriteData,
  root
} : let
  inherit (fns) padNum shinySpriteBase;

  formSuffixFor = dex: key:
    let
      entry = pokespriteData.${padNum dex} or null;
      forms =
        if entry == null then [ ]
        else
          let g8 = (entry."gen-8" or {}).forms or {};
              g7 = (entry."gen-7" or {}).forms or {};
          in builtins.filter (k: k != "$") (builtins.attrNames (g8 // g7));
      matching = builtins.filter
        (form:
          let suffix = "-" + form;
          in builtins.stringLength key > builtins.stringLength suffix
             && lib.hasSuffix suffix key) forms;
      sorted = builtins.sort
        (a: b: builtins.stringLength a > builtins.stringLength b) matching;
    in if sorted == [] then "" else "-" + builtins.head sorted;

  slugForDex = dex:
    let entry = pokespriteData.${padNum dex} or null;
    in if entry == null then null else entry.slug.eng;

  autoSprite = dex: key: shiny:
    let
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
      hits = builtins.filter (p: builtins.pathExists (root + "/${p}")) unique;
    in if hits == [] then null else builtins.head hits;

  autoShinySprite = entry:
    let
      slug   = shinySpriteBase entry;
      female = (entry.gender or null) == "female";
      femaleFirst = if female then [
        "sprites/pokemon-gen9/shiny/female/${slug}.png"
        "sprites/pokemon-gen8/shiny/female/${slug}.png"
        "sprites/pokemon-gen7x/shiny/female/${slug}.png"
        "sprites/pokemon-gen9/regular/female/${slug}.png"
        "sprites/pokemon-gen8/regular/female/${slug}.png"
        "sprites/pokemon-gen7x/regular/female/${slug}.png"
      ] else [];
      base = [
        "sprites/pokemon-gen8/shiny/${slug}.png"
        "sprites/pokemon-gen7x/shiny/${slug}.png"
        "sprites/pokemon-gen9/shiny/${slug}.png"
        "sprites/pokemon-gen8/regular/${slug}.png"
        "sprites/pokemon-gen7x/regular/${slug}.png"
        "sprites/pokemon-gen9/regular/${slug}.png"
      ];
      unique = lib.unique (femaleFirst ++ base);
      hits = builtins.filter (p: builtins.pathExists (root + "/${p}")) unique;
    in if hits == [] then null else builtins.head hits;

  breedableSpriteFor = n: s:
    if s.sprite != null then s.sprite else autoSprite s.dex n false;

  breedableSpriteExists = n: s:
    let sp = breedableSpriteFor n s;
    in sp != null && builtins.pathExists (root + "/${sp}");

  spritePath   = s: if s.sprite == null then null else root + "/${s.sprite}";
  spriteExists = s: s.sprite != null && builtins.pathExists (spritePath s);
in {
  inherit formSuffixFor slugForDex autoSprite autoShinySprite
            breedableSpriteFor breedableSpriteExists spritePath spriteExists; 
}
