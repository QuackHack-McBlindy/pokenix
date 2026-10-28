{ 
  spriteRoot
  ?
  "sprites"
} : let
  sprite = name: "${spriteRoot}/unova/${name}.png";

  allBalls = [
    "safari" "sport" "fast" "friend" "heavy" "level"
    "love" "lure" "moon" "dream" "beast"
  ];
  without = exclude:
    builtins.filter (b: !(builtins.elem b exclude)) allBalls;
in {

  # UNOVA — GENERATION 5 — 73 entries

  snivy          = { dex = 495; ha = "Contrary";          male = 87.5; female = 12.5; hatchCycles = 20; sprite = sprite "snivy"; };
  tepig          = { dex = 498; ha = "Thick Fat";         male = 87.5; female = 12.5; hatchCycles = 20; sprite = sprite "tepig"; };
  oshawott       = { dex = 501; ha = "Shell Armor";       male = 87.5; female = 12.5; hatchCycles = 20; sprite = sprite "oshawott"; };
  patrat         = { dex = 504; ha = "Analytic";          male = 50;   female = 50;   hatchCycles = 15; sprite = sprite "patrat"; };
  lillipup       = { dex = 506; ha = "Run Away";          male = 50;   female = 50;   hatchCycles = 15; sprite = sprite "lillipup"; };
  purrloin       = { dex = 509; ha = "Prankster";         male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "purrloin"; };
  pansage        = { dex = 511; ha = "Overgrow";          male = 87.5; female = 12.5; hatchCycles = 20; sprite = sprite "pansage"; };
  pansear        = { dex = 513; ha = "Blaze";             male = 87.5; female = 12.5; hatchCycles = 20; sprite = sprite "pansear"; };
  panpour        = { dex = 515; ha = "Torrent";           male = 87.5; female = 12.5; hatchCycles = 20; sprite = sprite "panpour"; };
  munna          = { dex = 517; ha = "Telepathy";         male = 50;   female = 50;   hatchCycles = 10; sprite = sprite "munna"; };
  pidove         = { dex = 519; ha = "Rivalry";           male = 50;   female = 50;   hatchCycles = 15; sprite = sprite "pidove"; };
  blitzle        = { dex = 522; ha = "Sap Sipper";        male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "blitzle"; };
  roggenrola     = { dex = 524; ha = "Sand Force";     male = 50;   female = 50;   hatchCycles = 15; sprite = sprite "roggenrola"; };
  woobat         = { dex = 527; ha = "Simple";            male = 50;   female = 50;   hatchCycles = 15; sprite = sprite "woobat"; };
  drilbur        = { dex = 529; ha = "Mold Breaker";      male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "drilbur"; };
  audino         = { dex = 531; ha = "Klutz";             male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "audino"; };
  timburr        = { dex = 532; ha = "Iron Fist";         male = 75;   female = 25;   hatchCycles = 20; sprite = sprite "timburr"; };
  tympole        = { dex = 535; ha = "Water Absorb";      male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "tympole"; };
  throh          = { dex = 538; ha = "Mold Breaker";      male = 100;  female = 0;    hatchCycles = 20; sprite = sprite "throh"; };
  sawk           = { dex = 539; ha = "Mold Breaker";      male = 100;  female = 0;    hatchCycles = 20; sprite = sprite "sawk"; };
  sewaddle       = { dex = 540; ha = "Overcoat";          male = 50;   female = 50;   hatchCycles = 15; sprite = sprite "sewaddle"; };
  venipede       = { dex = 543; ha = "Speed Boost";       male = 50;   female = 50;   hatchCycles = 15; sprite = sprite "venipede"; };
  cottonee       = { dex = 546; ha = "Chlorophyll";       male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "cottonee"; };
  petilil        = { dex = 548; ha = "Leaf Guard";        male = 0;    female = 100;  hatchCycles = 20; sprite = sprite "petilil"; };
  basculin-red   = { dex = 550; ha = "Mold Breaker"; male = 50;   female = 50;   hatchCycles = 40; sprite = sprite "basculin-red"; };
  basculin-blue  = { dex = 550; ha = "Mold Breaker"; male = 50;  female = 50;   hatchCycles = 40; sprite = sprite "basculin-blue"; };
  sandile        = { dex = 551; ha = "Anger Point";       male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "sandile"; };
  darumaka       = { dex = 554; ha = "Inner Focus";       male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "darumaka"; };
  darumaka-galar = { dex = 554; ha = "Inner Focus"; male = 50;  female = 50;   hatchCycles = 20; sprite = sprite "darumaka-galar"; };
  maractus       = { dex = 556; ha = "Storm Drain";       male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "maractus"; };
  dwebble        = { dex = 557; ha = "Weak Armor";        male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "dwebble"; };
  scraggy        = { dex = 559; ha = "Intimidate";        male = 50;   female = 50;   hatchCycles = 15; sprite = sprite "scraggy"; };
  sigilyph       = { dex = 561; ha = "Tinted Lens";       male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "sigilyph"; };
  yamask         = { dex = 562; ha = "Mummy";             male = 50;   female = 50;   hatchCycles = 25; sprite = sprite "yamask"; };
  yamask-galar   = { dex = 562; ha = "Wandering Spirit"; male = 50;  female = 50; hatchCycles = 25; sprite = sprite "yamask-galar"; };
  tirtouga       = { dex = 564; ha = "Swift Swim";        male = 87.5; female = 12.5; hatchCycles = 30; sprite = sprite "tirtouga"; };
  archen         = { dex = 566; ha = "Defeatist";         male = 87.5; female = 12.5; hatchCycles = 30; sprite = sprite "archen"; };
  trubbish       = { dex = 568; ha = "Aftermath";         male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "trubbish"; };
  zorua          = { dex = 570; ha = "Illusion";          male = 87.5; female = 12.5; hatchCycles = 25; sprite = sprite "zorua"; };
  minccino       = { dex = 572; ha = "Skill Link";        male = 25;   female = 75;   hatchCycles = 15; sprite = sprite "minccino"; };
  gothita        = { dex = 574; ha = "Shadow Tag";        male = 25;   female = 75;   hatchCycles = 20; sprite = sprite "gothita"; };
  solosis        = { dex = 577; ha = "Regenerator";       male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "solosis"; };
  ducklett       = { dex = 580; ha = "Hydration";        male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "ducklett"; };
  vanillite      = { dex = 582; ha = "Weak Armor";      male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "vanillite"; };
  deerling       = { dex = 585; ha = "Serene Grace";      male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "deerling"; };
  emolga         = { dex = 587; ha = "Motor Drive";       male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "emolga"; };
  karrablast     = { dex = 588; ha = "No Guard";        male = 50;   female = 50;   hatchCycles = 15; sprite = sprite "karrablast"; };
  foongus        = { dex = 590; ha = "Regenerator";       male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "foongus"; };
  frillish       = { dex = 592; ha = "Damp";              male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "frillish"; };
  alomomola      = { dex = 594; ha = "Regenerator";     male = 50;   female = 50;   hatchCycles = 40; sprite = sprite "alomomola"; };
  joltik         = { dex = 595; ha = "Swarm";             male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "joltik"; };
  ferroseed      = { dex = 597; ha = "Iron Barbs";      male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "ferroseed"; };
  klink          = { dex = 599; ha = "Clear Body";        genderless = true;            hatchCycles = 20; sprite = sprite "klink"; };
  tynamo         = { dex = 602; ha = "Levitate";          male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "tynamo"; };
  elgyem         = { dex = 605; ha = "Analytic";          male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "elgyem"; };
  litwick        = { dex = 607; ha = "Infiltrator";       male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "litwick"; };
  axew           = { dex = 610; ha = "Unnerve";           male = 50;   female = 50;   hatchCycles = 40; sprite = sprite "axew"; };
  cubchoo        = { dex = 613; ha = "Rattled";           male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "cubchoo"; };
  cryogonal      = { dex = 615; ha = "Levitate";     genderless = true;            hatchCycles = 25; sprite = sprite "cryogonal"; };
  shelmet        = { dex = 616; ha = "Overcoat";          male = 50;   female = 50;   hatchCycles = 15; sprite = sprite "shelmet"; };
  stunfisk       = { dex = 618; ha = "Sand Veil";         male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "stunfisk"; };
  stunfisk-galar = { dex = 618; ha = "Mimicry";   male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "stunfisk-galar"; };
  mienfoo        = { dex = 619; ha = "Reckless";          male = 50;   female = 50;   hatchCycles = 25; sprite = sprite "mienfoo"; };
  druddigon      = { dex = 621; ha = "Mold Breaker";    male = 50;   female = 50;   hatchCycles = 30; sprite = sprite "druddigon"; };
  golett         = { dex = 622; ha = "No Guard";          genderless = true;            hatchCycles = 25; sprite = sprite "golett"; };
  pawniard       = { dex = 624; ha = "Pressure";          male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "pawniard"; };
  bouffalant     = { dex = 626; ha = "Soundproof";     male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "bouffalant"; };
  rufflet        = { dex = 627; ha = "Hustle";            male = 100;  female = 0;    hatchCycles = 20; sprite = sprite "rufflet"; };
  vullaby        = { dex = 629; ha = "Weak Armor";        male = 0;    female = 100;  hatchCycles = 20; sprite = sprite "vullaby"; };
  heatmor        = { dex = 631; ha = "White Smoke";       male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "heatmor"; };
  durant         = { dex = 632; ha = "Truant";            male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "durant"; };
  deino          = { dex = 633; ha = "Hustle";            male = 50;   female = 50;   hatchCycles = 40; sprite = sprite "deino"; };
  larvesta       = { dex = 636; ha = "Swarm";             male = 50;   female = 50;   hatchCycles = 40; sprite = sprite "larvesta"; };
}
