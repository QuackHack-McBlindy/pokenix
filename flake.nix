{
  description = "PokéNix – Pokémon Collection Builder";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAll  = nixpkgs.lib.genAttrs systems;
    in {
      packages = forAll (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          lib  = nixpkgs.lib;

          userConfig = import ./my-pokemon.nix;

          eval = lib.evalModules {
            modules = [
              (import ./options.nix { inherit lib; })
              { config.pokenix = userConfig; }
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
          lib  = nixpkgs.lib;
          eval = lib.evalModules {
            modules = [
              (import ./options.nix { inherit lib; })
              { config.pokenix = import ./my-pokemon.nix; }
            ];
          };
          build  = import ./build.nix { inherit lib pkgs; };
        in (build eval.config.pokenix).debug);

      nixosModules.default = import ./module.nix;
      nixosModules.pokenix = import ./module.nix;

    };}
