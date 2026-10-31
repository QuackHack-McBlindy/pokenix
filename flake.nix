{
  description = "PokéNix – Pokémon Collection Builder";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      lib     = nixpkgs.lib;
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forAll  = lib.genAttrs systems;

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

      buildFor = system:
        let
          pkgs = nixpkgs.legacyPackages.${system};

          eval = lib.evalModules {
            modules = [
              (import ./options.nix { inherit lib; })
              chosenModule
            ];
          };

          build = import ./build.nix { inherit lib pkgs; };
        in
        build eval.config.pokenix;

      builds = forAll buildFor;

    in {
      packages = forAll (system: {
        default = builds.${system}.html;
        html    = builds.${system}.html;
      });

      checks = forAll (system: {
        default = builds.${system}.html;
        html    = builds.${system}.html;
      });

      debug = forAll (system: builds.${system}.debug);

      nixosModules.default = import ./module.nix;
      nixosModules.pokenix = import ./module.nix;

    };}
