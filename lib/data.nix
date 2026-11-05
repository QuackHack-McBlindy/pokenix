{ 
  lib,
  root
} : let
  readOrEmpty = p: if builtins.pathExists p then builtins.fromJSON (builtins.readFile p) else { };

  projectToml = builtins.fromTOML (builtins.readFile (root + "/project.toml"));
  version     = projectToml.project.version;

  pokespriteData = builtins.fromJSON (builtins.readFile (root + "/data/pokemon.json"));
  rawBreedables  = import (root + "/breedables") { };

  movesRaw = readOrEmpty (root + "/data/pokedex/moves.json");

  pokemonRaw =
    let paths = [ (root + "/data/pokedex/pokemon.json") (root + "/data/pokemon-fetch.json") ];
        hits  = builtins.filter (p: builtins.pathExists p) paths;
    in if hits == [] then { } else builtins.fromJSON (builtins.readFile (builtins.head hits));

  moveInfoRaw = readOrEmpty (root + "/data/pokedex/move-info.json");

in {
  inherit version pokespriteData rawBreedables movesRaw pokemonRaw moveInfoRaw; 
}
