{ 
  spriteRoot
  ?
  "sprites"
} : let
  sprite = name: "${spriteRoot}/paldea/${name}.png";

  paldeaBalls = [
    "fast" "friend" "heavy" "level" "love"
    "lure" "moon" "dream" "beast" 
  ];
in
builtins.mapAttrs (_: e: e // { balls = paldeaBalls; }) {
  # PALDEA — GENERATION 9 — 43 entries
  
  # NOTE: Paldean Tauros lives in kanto.nix
  # and   Paldean Wooper lives in johto.nix

  sprigatito     = { dex = 906; ha = "Protean";        male = 87.5; female = 12.5; hatchCycles = 20; sprite = sprite "sprigatito"; };
  fuecoco        = { dex = 909; ha = "Unaware";           male = 87.5; female = 12.5; hatchCycles = 20; sprite = sprite "fuecoco"; };
  quaxly         = { dex = 912; ha = "Moxie";             male = 87.5; female = 12.5; hatchCycles = 20; sprite = sprite "quaxly"; };
  lechonk        = { dex = 915; ha = "Thick Fat";         male = 50;   female = 50;   hatchCycles = 15; sprite = sprite "lechonk"; };
  tarountula     = { dex = 917; ha = "Stakeout";       male = 50;   female = 50;   hatchCycles = 15; sprite = sprite "tarountula"; };
  nymble         = { dex = 919; ha = "Tinted Lens";       male = 50;   female = 50;   hatchCycles = 15; sprite = sprite "nymble"; };
  pawmi          = { dex = 921; ha = "Iron Fist";         male = 50;   female = 50;   hatchCycles = 15; sprite = sprite "pawmi"; };
  tandemaus      = { dex = 924; ha = "Own Tempo";       male = 50;   female = 50;   hatchCycles = 10; sprite = sprite "tandemaus"; };
  fidough        = { dex = 926; ha = "Klutz";             male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "fidough"; };
  smoliv         = { dex = 928; ha = "Harvest";           male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "smoliv"; };
  squawkabilly-green = { dex = 931; ha = "Guts";              male = 50;   female = 50;   hatchCycles = 15; sprite = sprite "squawkabilly-green"; };
  squawkabilly-blue  = { dex = 931; ha = "Guts"; male = 50;  female = 50;  hatchCycles = 15; sprite = sprite "squawkabilly-blue"; };
  squawkabilly-white = { dex = 931; ha = "Sheer Force"; male = 50; female = 50; hatchCycles = 15; sprite = sprite "squawkabilly-white"; };
  squawkabilly-yellow  = { dex = 931; ha = "Sheer Force"; male = 50; female = 50; hatchCycles = 15; sprite = sprite "squawkabilly-yellow"; };
  nacli          = { dex = 932; ha = "Clear Body";        male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "nacli"; };
  charcadet      = { dex = 935; ha = "Flame Body";      male = 50;   female = 50;   hatchCycles = 35; sprite = sprite "charcadet"; };
  tadbulb        = { dex = 938; ha = "Damp";              male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "tadbulb"; };
  wattrel        = { dex = 940; ha = "Competitive";       male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "wattrel"; };
  maschiff       = { dex = 942; ha = "Stakeout";          male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "maschiff"; };
  shroodle       = { dex = 944; ha = "Prankster";         male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "shroodle"; };
  bramblin       = { dex = 946; ha = "Infiltrator";       male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "bramblin"; };
  toedscool      = { dex = 948; ha = "Mycelium Might";  male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "toedscool"; };
  klawf          = { dex = 950; ha = "Regenerator";       male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "klawf"; };
  capsakid       = { dex = 951; ha = "Klutz";             male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "capsakid"; };
  rellor         = { dex = 953; ha = "Shed Skin";         male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "rellor"; }; 
  flittle        = { dex = 955; ha = "Speed Boost";       male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "flittle"; };
  tinkatink      = { dex = 957; ha = "Pickpocket";      male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "tinkatink"; };
  wiglett        = { dex = 960; ha = "Sand Veil";       male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "wiglett"; };
  bombirdier     = { dex = 962; ha = "Rocky Payload";   male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "bombirdier"; };
  finizen        = { dex = 963; ha = "Water Veil";      male = 50;   female = 50;   hatchCycles = 40; sprite = sprite "finizen"; };
  varoom         = { dex = 965; ha = "Slow Start";      male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "varoom"; };
  cyclizar       = { dex = 967; ha = "Regenerator";       male = 50;   female = 50;   hatchCycles = 30; sprite = sprite "cyclizar"; };
  orthworm       = { dex = 968; ha = "Sand Veil";         male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "orthworm"; };
  glimmet        = { dex = 969; ha = "Corrosion";         male = 50;   female = 50;   hatchCycles = 30; sprite = sprite "glimmet"; };
  greavard       = { dex = 971; ha = "Fluffy";            male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "greavard"; };
  flamigo        = { dex = 973; ha = "Costar";            male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "flamigo"; };
  cetoddle       = { dex = 974; ha = "Sheer Force";       male = 50;   female = 50;   hatchCycles = 25; sprite = sprite "cetoddle"; };
  veluza         = { dex = 976; ha = "Sharpness";         male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "veluza"; };
  dondozo        = { dex = 977; ha = "Water Veil";        male = 50;   female = 50;   hatchCycles = 40; sprite = sprite "dondozo"; };
  tatsugiri-curly = { dex = 978; ha = "Storm Drain";   male = 50; female = 50; hatchCycles = 35; sprite = sprite "tatsugiri-curly"; };
  tatsugiri-droopy = { dex = 978; ha = "Storm Drain"; male = 50; female = 50;  hatchCycles = 35; sprite = sprite "tatsugiri-droopy"; };
  tatsugiri-stretchy = { dex = 978; ha = "Storm Drain"; male = 50; female = 50; hatchCycles = 35; sprite = sprite "tatsugiri-stretchy"; };
  frigibax       = { dex = 996; ha = "Ice Body"; male = 50; female = 50; hatchCycles = 40; sprite = sprite "frigibax"; };
}
