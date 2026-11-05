{ 
  lib,
  pokemonRaw,
  evtDex
} : let
  natures = {
    hardy = { up = null; down = null; };   lonely = { up = "atk"; down = "def"; };
    brave = { up = "atk"; down = "spe"; }; adamant = { up = "atk"; down = "spa"; };
    naughty = { up = "atk"; down = "spd"; }; bold = { up = "def"; down = "atk"; };
    docile = { up = null; down = null; };  relaxed = { up = "def"; down = "spe"; };
    impish = { up = "def"; down = "spa"; }; lax = { up = "def"; down = "spd"; };
    timid = { up = "spe"; down = "atk"; }; hasty = { up = "spe"; down = "def"; };
    serious = { up = null; down = null; }; jolly = { up = "spe"; down = "spa"; };
    naive = { up = "spe"; down = "spd"; }; modest = { up = "spa"; down = "atk"; };
    mild = { up = "spa"; down = "def"; };  quiet = { up = "spa"; down = "spe"; };
    bashful = { up = null; down = null; }; rash = { up = "spa"; down = "spd"; };
    calm = { up = "spd"; down = "atk"; };  gentle = { up = "spd"; down = "def"; };
    sassy = { up = "spd"; down = "spe"; }; careful = { up = "spd"; down = "spa"; };
    quirky = { up = null; down = null; };
  };

  statsByDex =
    let
      entries = builtins.filter
        (slug:
          let p = pokemonRaw.${slug};
          in (p.dexNumber or null) != null && (p.isDefault or true))
        (builtins.attrNames pokemonRaw);
    in
    builtins.listToAttrs (map
      (slug:
        let p = pokemonRaw.${slug}; bs = p.baseStats or { };
        in {
          name  = toString p.dexNumber;
          value = [
            (bs.hp or 0) (bs.attack or 0) (bs.defense or 0)
            (bs.special-attack or 0) (bs.special-defense or 0) (bs.speed or 0)
          ];
        })
      entries);

  computeStats = sp:
    let bs = statsByDex.${toString (evtDex sp)} or null;
    in if bs == null then null
    else
      let
        lvl    = if sp.level != null then sp.level else 100;
        natKey = if sp.nature != null then lib.toLower sp.nature else "hardy";
        nat    = natures.${natKey} or { up = null; down = null; };
        mod = stat:
          if nat.up == stat then 1.1 else if nat.down == stat then 0.9 else 1.0;
        evOf = s:
          if builtins.hasAttr s sp.evs && sp.evs.${s} != null then sp.evs.${s} else 0;
        ivOf = s:
          if builtins.hasAttr s sp.ivs && sp.ivs.${s} != null then sp.ivs.${s} else 31;
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
             + 5) * mod stat);
      in {
        hp  = calcHp    (baseAt 0);
        atk = calcOther (baseAt 1) "atk";
        def = calcOther (baseAt 2) "def";
        spa = calcOther (baseAt 3) "spa";
        spd = calcOther (baseAt 4) "spd";
        spe = calcOther (baseAt 5) "spe";
      };
in {
  inherit natures statsByDex computeStats; 
}
