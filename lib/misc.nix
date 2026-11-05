{ 
  lib,
  fns,
  pokedex
} : let
  inherit (fns) firstExisting markFile ribbonFileCandidates;

  miscLookup = category: userInput:
    let
      entries        = pokedex.${category} or { };
      normalize      = lib.toLower;
      stripThe       = s:
        let n = normalize s;
        in if lib.hasPrefix "the " n then lib.removePrefix "the " n else n;
      target         = normalize userInput;
      targetStripped = stripThe userInput;
      matches = builtins.filter
        (e:
          let nEng = normalize (e.name.eng  or "");
              tEng = stripThe  (e.title.eng or "");
          in nEng == target || tEng == targetStripped)
        (builtins.attrValues entries);
    in if matches == [] then null else builtins.head matches;

  miscSpritePath = entry:
    if entry == null then null
    else
      let
        files    = entry.files or { };
        genOrder = [ "gen-9" "gen-8" "gen-7" "gen-6" "gen-5" "gen-4" "gen-3"
                     "legends-arceus" "champions" "home" "go" "masters" ];
        candidates = builtins.filter
          (x: x != null && builtins.isString x)
          (map (g: files.${g} or null) genOrder);
        paths = map (f: "sprites/misc/${f}") candidates;
      in firstExisting paths;

  ribbonSpriteFor = name:
    let meta = miscLookup "ribbons" name;
        miscPath = miscSpritePath meta;
    in if miscPath != null then miscPath
       else firstExisting (ribbonFileCandidates name);

  markSpriteFor = name:
    let meta = miscLookup "marks" name;
        miscPath = miscSpritePath meta;
    in if miscPath != null then miscPath
       else firstExisting [ (markFile name) ];
in { 
  inherit miscLookup miscSpritePath ribbonSpriteFor markSpriteFor; 
}
