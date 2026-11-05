{ 
  lib,
  fns,
  breedables,
  shinyData,
  autoSprite,
  root
} : let
  resolveSpeciesKey = k:
    let parts = lib.splitString "-" k;
        n     = builtins.length parts;
        tryPrefix = i:
          if i <= 0 then null
          else
            let p = lib.concatStringsSep "-" (lib.take i parts);
            in if builtins.hasAttr p breedables then p else tryPrefix (i - 1);
    in tryPrefix n;

  lookupSpecies = k:
    let
      parts = lib.splitString "-" k;
      n     = builtins.length parts;
      tryB = i:
        if i <= 0 then null
        else
          let p = lib.concatStringsSep "-" (lib.take i parts);
          in if builtins.hasAttr p breedables
             then {
               key = p; dex = breedables.${p}.dex;
               name = breedables.${p}.name; sprite = breedables.${p}.sprite;
             }
             else tryB (i - 1);
      tryS = i:
        if i <= 0 then null
        else
          let p = lib.concatStringsSep "-" (lib.take i parts);
          in if builtins.hasAttr p shinyData
             then { key = p; dex = shinyData.${p}.dex; name = shinyData.${p}.name; sprite = null; }
             else tryS (i - 1);
      b = tryB n;
    in if b != null then b else tryS n;

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
      let lu = lookupSpecies e.species;
          spriteKey = if lu != null then lu.key else e.species;
      in if !shiny && lu != null && lu.sprite != null
         then lu.sprite
         else autoSprite (evtDex e) spriteKey shiny;

  evtSpriteExists = k: e: shiny:
    let sp = evtSpriteFor k e shiny;
    in sp != null && builtins.pathExists (root + "/${sp}");
in { 
  inherit resolveSpeciesKey lookupSpecies evtDex evtName evtSpriteFor evtSpriteExists; 
}
