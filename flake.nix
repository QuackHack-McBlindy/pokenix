{
  description = "PokéNix – Pokémon Collection Builder";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forAll  = nixpkgs.lib.genAttrs systems;
      lib     = nixpkgs.lib;
      
      userModule    = import ./my-pokemon.nix;
      userEvaluated = userModule { inherit lib; };

      trainerName =
        let pk = userEvaluated.pokenix or { };
            tr = pk.trainer or { };
        in tr.name or "";

      defaultNames  = [ "PokèNix" "PokéNix" ];
      isDefaultUser = builtins.elem trainerName defaultNames;

      chosenModule =
        if isDefaultUser then import ./example.nix else userModule;
    in {
      packages = forAll (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};

          eval = lib.evalModules {
            modules = [
              (import ./options.nix { inherit lib; })
              chosenModule
            ];
          };

          build  = import ./build.nix { inherit lib pkgs; };
          result = build eval.config.pokenix;
        in {
          default = result.html;
          html    = result.html;
        });

      debug = forAll (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};

          eval = lib.evalModules {
            modules = [
              (import ./options.nix { inherit lib; })
              chosenModule
            ];
          };

          build = import ./build.nix { inherit lib pkgs; };
        in (build eval.config.pokenix).debug);

      nixosModules.default = import ./module.nix;
      nixosModules.pokenix = import ./module.nix;
    };
}
