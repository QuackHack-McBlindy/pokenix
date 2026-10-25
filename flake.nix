{
  description = "PokéNix – Declarative Pokémon Collection Flake";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
    in
    {
      nixosModules.default  = import ./pokenix.nix;
      nixosModules.pokenix  = import ./pokenix.nix;

      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell {
          packages = with pkgs; [ python3 curl git jq nixpkgs-fmt ];
        };
      });

      formatter = forAllSystems (pkgs: pkgs.nixpkgs-fmt);

    };}
