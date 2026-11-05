{ 
  lib,
  fns,
  cfg,
  root
} : let
  shinyJsonPath = root + "/data/pokedex/shiny-${cfg.trainer.shinyDexType}.json";

  shinyList =
    if builtins.pathExists shinyJsonPath
    then (builtins.fromJSON (builtins.readFile shinyJsonPath)).shiny
    else [ ];

  shinyData = builtins.listToAttrs
    (map (e: { name = e.slug; value = e; }) shinyList);

  specialShiniesBySpecies =
    let
      shinySpecialKeys = builtins.filter
        (k: cfg.specials.${k}.shiny or false)
        (builtins.attrNames cfg.specials);
    in
    builtins.foldl'
      (acc: k:
        let sp = cfg.specials.${k}.species;
        in if builtins.hasAttr sp acc then acc
           else acc // { ${sp} = cfg.specials.${k}; })
      { }
      shinySpecialKeys;

  isShinyOwned = slug:
    let userBall = (cfg.shiny.${slug} or { }).ball or null;
    in userBall != null || builtins.hasAttr slug specialShiniesBySpecies;

  isShinyFromSpecial = slug:
    ((cfg.shiny.${slug} or { }).ball or null) == null
    && builtins.hasAttr slug specialShiniesBySpecies;

  effectiveShinyFor = slug:
    let
      user    = cfg.shiny.${slug} or { };
      owned   = (user.ball or null) != null;
      special = specialShiniesBySpecies.${slug} or null;
    in
      if owned then user
      else if special != null then {
        ball = special.ball or null; ot = special.selfObtained or false;
        egg = false; style = "star";
        notes = special.notes or null;
        selfObtained = special.selfObtained or false;
        level = special.level or null; nature = special.nature or null;
        ability = special.ability or null; heldItem = special.heldItem or null;
        teraType = special.teraType or null;
        evs = special.evs or { }; ivs = special.ivs or { };
        moves = special.moves or [ ]; marks = special.marks or [ ];
        ribbons = special.ribbons or [ ];
        obtained = special.obtained or null; region = special.region or null;
        id = special.id or null; proof = special.proof or null;
        tradeHistory = special.tradeHistory or null;
      }
      else user;
in { 
  inherit shinyJsonPath shinyList shinyData specialShiniesBySpecies
            isShinyOwned isShinyFromSpecial effectiveShinyFor; 
}
