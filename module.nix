{ 
  lib,
  pkgs,
  config,
  ...
} : let
  build  = import ./build.nix { inherit lib pkgs; };
  result = build config.pokenix;
in {
  imports = [ ./options.nix ];
  config.pokenix.html  = result.html;
  config.pokenix.debug = result.debug;
  config.pokenix.stats = result.stats;

}
