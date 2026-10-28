{ 
  spriteRoot
  ?
  "sprites"
} : let
  sprite = name: "${spriteRoot}/kalos/${name}.png";
  
  allBalls = [
    "safari" "sport" "fast" "friend" "heavy" "level"
    "love" "lure" "moon" "dream" "beast"
  ];
  without = exclude:
    builtins.filter (b: !(builtins.elem b exclude)) allBalls;
in {
  # KALOS — GENERATION 6 — 38 entries

  chespin      = { dex = 650; ha = "Bulletproof";      male = 87.5; female = 12.5; hatchCycles = 20; sprite = sprite "chespin"; };
  fennekin     = { dex = 653; ha = "Magician";         male = 87.5; female = 12.5; hatchCycles = 20; sprite = sprite "fennekin"; };
  froakie      = { dex = 656; ha = "Protean";          male = 87.5; female = 12.5; hatchCycles = 20; sprite = sprite "froakie"; };
  bunnelby     = { dex = 659; ha = "Huge Power";       male = 50;   female = 50;   hatchCycles = 15; sprite = sprite "bunnelby"; };
  fletchling   = { dex = 661; ha = "Gale Wings";       male = 50;   female = 50;   hatchCycles = 15; sprite = sprite "fletchling"; };
  scatterbug   = { dex = 664; ha = "Friend Guard";     male = 50;   female = 50;   hatchCycles = 15; sprite = sprite "scatterbug"; };
  litleo       = { dex = 667; ha = "Moxie";            male = 12.5; female = 87.5; hatchCycles = 20; sprite = sprite "litleo"; };
  flabebe-red  = { dex = 671; ha = "Symbiosis";        male = 0;    female = 100;  hatchCycles = 20; sprite = sprite "flabebe-red"; };
  flabebe-blue = { dex = 671; ha = "Symbiosis";      male = 0;    female = 100;  hatchCycles = 20; sprite = sprite "flabebe-blue"; };
  flabebe-orange = { dex = 671; ha = "Symbiosis";    male = 0;   female = 100;  hatchCycles = 20; sprite = sprite "flabebe-orange"; };
  flabebe-white  = { dex = 671; ha = "Symbiosis";    male = 0;    female = 100;  hatchCycles = 20; sprite = sprite "flabebe-white"; };
  flabebe-yellow = { dex = 671; ha = "Symbiosis";    male = 0;   female = 100;  hatchCycles = 20; sprite = sprite "flabebe-yellow"; };
  skiddo       = { dex = 672; ha = "Grass Pelt";        male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "skiddo"; };
  pancham      = { dex = 674; ha = "Scrappy";           male = 50;   female = 50;   hatchCycles = 25; sprite = sprite "pancham"; };
  furfrou      = { dex = 676; ha = "Fur Coat";          male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "furfrou"; };
  espurr       = { dex = 677; ha = "Own Tempo";         male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "espurr"; };
  honedge      = { dex = 679; ha = "No Guard";          male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "honedge"; };
  spritzee     = { dex = 682; ha = "Aroma Veil";        male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "spritzee"; };
  swirlix      = { dex = 684; ha = "Unburden";          male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "swirlix"; };
  inkay        = { dex = 686; ha = "Infiltrator";       male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "inkay"; };
  binacle      = { dex = 688; ha = "Pickpocket";        male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "binacle"; };
  skrelp       = { dex = 690; ha = "Adaptability";      male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "skrelp"; };
  clauncher    = { dex = 692; ha = "Mega Launcher";     male = 50;   female = 50;   hatchCycles = 15; sprite = sprite "clauncher"; };
  helioptile   = { dex = 694; ha = "Solar Power";     male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "helioptile"; };
  tyrunt       = { dex = 696; ha = "Sturdy";            male = 87.5; female = 12.5; hatchCycles = 30; sprite = sprite "tyrunt"; };
  amaura       = { dex = 698; ha = "Snow Warning";      male = 87.5; female = 12.5; hatchCycles = 30; sprite = sprite "amaura"; };
  hawlucha     = { dex = 701; ha = "Mold Breaker";      male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "hawlucha"; };
  dedenne      = { dex = 702; ha = "Plus";              male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "dedenne"; };
  carbink      = { dex = 703; ha = "Sturdy";            genderless = true;            hatchCycles = 25; sprite = sprite "carbink"; };
  goomy        = { dex = 704; ha = "Gooey";             male = 50;   female = 50;   hatchCycles = 40; sprite = sprite "goomy"; };
  klefki       = { dex = 707; ha = "Magician";          male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "klefki"; };
  phantump     = { dex = 708; ha = "Harvest";           male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "phantump"; };
  pumpkaboo-small   = { dex = 710; ha = "Insomnia";  male = 50; female = 50; hatchCycles = 20; sprite = sprite "pumpkaboo-small"; };
  pumpkaboo-average = { dex = 710; ha = "Insomnia";  male = 50; female = 50; hatchCycles = 20; sprite = sprite "pumpkaboo-average"; };
  pumpkaboo-large   = { dex = 710; ha = "Insomnia";  male = 50; female = 50; hatchCycles = 20; sprite = sprite "pumpkaboo-large"; };
  pumpkaboo-super   = { dex = 710; ha = "Insomnia";  male = 50;   female = 50; hatchCycles = 20; sprite = sprite "pumpkaboo-super"; };
  bergmite     = { dex = 712; ha = "Sturdy";            male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "bergmite"; };
  noibat       = { dex = 714; ha = "Telepathy";         male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "noibat"; };

}
