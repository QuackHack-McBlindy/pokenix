{ 
  lib,
  pokemonRaw,
  movesRaw
} : let
  pokemonEntryFor = name:
    let parts = lib.splitString "-" name;
        go = n:
          let candidate = lib.concatStringsSep "-" (lib.take n parts);
          in if builtins.hasAttr candidate pokemonRaw then pokemonRaw.${candidate}
             else if n <= 1 then { } else go (n - 1);
    in go (builtins.length parts);

  pokemonKeyFor = name:
    let parts = lib.splitString "-" name;
        go = n:
          let candidate = lib.concatStringsSep "-" (lib.take n parts);
          in if builtins.hasAttr candidate pokemonRaw then candidate
             else if n <= 1 then null else go (n - 1);
    in go (builtins.length parts);

  serebiiUrlFor = key:
    let k = pokemonKeyFor key;
    in if k == null then null else "https://www.serebii.net/pokedex-swsh/${k}/";

  typesFor    = key: (pokemonEntryFor key).types or [ ];
  typeSortKey = key:
    let ts = typesFor key;
    in if ts == [] then "zzz" else lib.toLower (builtins.head ts);

  cryUrlFor = key:
    let c = (pokemonEntryFor key).cries or null;
    in if c == null then null else c.latest or (c.legacy or null);

  movesEntryFor = name:
    let parts = lib.splitString "-" name;
        go = n:
          let candidate = lib.concatStringsSep "-" (lib.take n parts);
          in if builtins.hasAttr candidate movesRaw then movesRaw.${candidate}
             else if n <= 1 then { } else go (n - 1);
    in go (builtins.length parts);
in {
  inherit pokemonEntryFor pokemonKeyFor serebiiUrlFor typesFor typeSortKey
            cryUrlFor movesEntryFor; 
}
