{ 
  spriteRoot
  ?
  "sprites"
} : let
  sprite = name: "${spriteRoot}/hoenn/${name}.png";
  
  allBalls = [
    "safari" "sport" "fast" "friend" "heavy" "level"
    "love" "lure" "moon" "dream" "beast"
  ];
  without = exclude:
    builtins.filter (b: !(builtins.elem b exclude)) allBalls;
in {
  # HOENN — GENERATION 3 — 64 entries

  treecko    = { dex = 252; ha = "Unburden";          male = 87.5; female = 12.5; hatchCycles = 20; sprite = sprite "treecko"; };
  torchic    = { dex = 255; ha = "Speed Boost";       male = 87.5; female = 12.5; hatchCycles = 20; sprite = sprite "torchic"; };
  mudkip     = { dex = 258; ha = "Damp";              male = 87.5; female = 12.5; hatchCycles = 20; sprite = sprite "mudkip"; };
  poochyena  = { dex = 261; ha = "Rattled";           male = 50;   female = 50;   hatchCycles = 15; sprite = sprite "poochyena"; };
  zigzagoon  = { dex = 263; ha = "Quick Feet";        male = 50;   female = 50;   hatchCycles = 15; sprite = sprite "zigzagoon"; };
  zigzagoon-galar = { dex = 263; ha = "Quick Feet"; male = 50; female = 50;  hatchCycles = 15; sprite = sprite "zigzagoon-galar"; };
  wurmple    = { dex = 265; ha = "Run Away";          male = 50;   female = 50;   hatchCycles = 15; sprite = sprite "wurmple"; };
  lotad      = { dex = 270; ha = "Own Tempo";         male = 50;   female = 50;   hatchCycles = 15; sprite = sprite "lotad"; };
  seedot     = { dex = 273; ha = "Pickpocket";        male = 50;   female = 50;   hatchCycles = 15; sprite = sprite "seedot"; };
  taillow    = { dex = 276; ha = "Scrappy";           male = 50;   female = 50;   hatchCycles = 15; sprite = sprite "taillow"; };
  wingull    = { dex = 278; ha = "Rain Dish";         male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "wingull"; };
  ralts      = { dex = 280; ha = "Telepathy";         male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "ralts"; };
  surskit    = { dex = 283; ha = "Rain Dish";         male = 50;   female = 50;   hatchCycles = 15; sprite = sprite "surskit"; };
  shroomish  = { dex = 285; ha = "Quick Feet";        male = 50;   female = 50;   hatchCycles = 15; sprite = sprite "shroomish"; };
  slakoth    = { dex = 287; ha = "Truant";            male = 50;   female = 50;   hatchCycles = 15; sprite = sprite "slakoth"; };
  nincada    = { dex = 290; ha = "Run Away";          male = 50;   female = 50;   hatchCycles = 15; sprite = sprite "nincada"; };
  whismur    = { dex = 293; ha = "Rattled";           male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "whismur"; };
  makuhita   = { dex = 296; ha = "Sheer Force";       male = 75;   female = 25;   hatchCycles = 20; sprite = sprite "makuhita"; };
  nosepass   = { dex = 299; ha = "Sand Force";        male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "nosepass"; };
  skitty     = { dex = 300; ha = "Wonder Skin";       male = 25;   female = 75;   hatchCycles = 15; sprite = sprite "skitty"; };
  sableye    = { dex = 302; ha = "Prankster";         male = 50;   female = 50;   hatchCycles = 25; sprite = sprite "sableye"; };
  mawile     = { dex = 303; ha = "Sheer Force";       male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "mawile"; };
  aron       = { dex = 304; ha = "Heavy Metal";       male = 50;   female = 50;   hatchCycles = 35; sprite = sprite "aron"; };
  meditite   = { dex = 307; ha = "Telepathy";         male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "meditite"; };
  electrike  = { dex = 309; ha = "Minus";             male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "electrike"; };
  plusle     = { dex = 311; ha = "Lightning Rod";     male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "plusle"; };
  minun      = { dex = 312; ha = "Volt Absorb";       male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "minun"; };
  volbeat    = { dex = 313; ha = "Prankster";         male = 100;  female = 0;    hatchCycles = 15; sprite = sprite "volbeat"; };
  illumise   = { dex = 314; ha = "Prankster";         male = 0;    female = 100;  hatchCycles = 15; sprite = sprite "illumise"; };
  roselia    = { dex = 315; ha = "Leaf Guard";        male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "roselia"; };
  gulpin     = { dex = 316; ha = "Gluttony";          male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "gulpin"; };
  carvanha   = { dex = 318; ha = "Speed Boost";       male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "carvanha"; };
  wailmer    = { dex = 320; ha = "Pressure";          male = 50;   female = 50;   hatchCycles = 40; sprite = sprite "wailmer"; };
  numel      = { dex = 322; ha = "Own Tempo";         male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "numel"; };
  torkoal    = { dex = 324; ha = "Shell Armor";       male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "torkoal"; };
  spoink     = { dex = 325; ha = "Gluttony";          male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "spoink"; };
  spinda     = { dex = 327; ha = "Contrary";          male = 50;   female = 50;   hatchCycles = 15; sprite = sprite "spinda"; };
  trapinch   = { dex = 328; ha = "Sheer Force";       male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "trapinch"; };
  cacnea     = { dex = 331; ha = "Water Absorb";      male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "cacnea"; };
  swablu     = { dex = 333; ha = "Cloud Nine";        male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "swablu"; };
  zangoose   = { dex = 335; ha = "Toxic Boost";       male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "zangoose"; };
  seviper    = { dex = 336; ha = "Infiltrator";       male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "seviper"; };
  lunatone   = { dex = 337; ha = "Levitate";          genderless = true;            hatchCycles = 25; sprite = sprite "lunatone"; };
  solrock    = { dex = 338; ha = "Levitate";          genderless = true;            hatchCycles = 25; sprite = sprite "solrock"; };
  barboach   = { dex = 339; ha = "Hydration";         male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "barboach"; };
  corphish   = { dex = 341; ha = "Adaptability";      male = 50;   female = 50;   hatchCycles = 15; sprite = sprite "corphish"; };
  baltoy     = { dex = 343; ha = "Levitate";          genderless = true;            hatchCycles = 20; sprite = sprite "baltoy"; };
  lileep     = { dex = 345; ha = "Storm Drain";       male = 87.5; female = 12.5; hatchCycles = 30; sprite = sprite "lileep"; };
  anorith    = { dex = 347; ha = "Swift Swim";        male = 87.5; female = 12.5; hatchCycles = 30; sprite = sprite "anorith"; };
  feebas     = { dex = 349; ha = "Adaptability";      male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "feebas"; };
  castform   = { dex = 351; ha = "Forecast";          male = 50;   female = 50;   hatchCycles = 25; sprite = sprite "castform"; };
  kecleon    = { dex = 352; ha = "Protean";           male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "kecleon"; };
  shuppet    = { dex = 353; ha = "Cursed Body";       male = 50;   female = 50;   hatchCycles = 25; sprite = sprite "shuppet"; };
  duskull    = { dex = 355; ha = "Frisk";             male = 50;   female = 50;   hatchCycles = 25; sprite = sprite "duskull"; };
  tropius    = { dex = 357; ha = "Harvest";           male = 50;   female = 50;   hatchCycles = 25; sprite = sprite "tropius"; };
  chingling  = { dex = 433; ha = "Levitate";          male = 50;   female = 50;   hatchCycles = 25; sprite = sprite "chingling"; };
  absol      = { dex = 359; ha = "Justified";         male = 50;   female = 50;   hatchCycles = 25; sprite = sprite "absol"; };
  snorunt    = { dex = 361; ha = "Moody";             male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "snorunt"; };
  spheal     = { dex = 363; ha = "Oblivious";         male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "spheal"; };
  clamperl   = { dex = 366; ha = "Rattled";           male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "clamperl"; };
  relicanth  = { dex = 369; ha = "Sturdy";            male = 87.5; female = 12.5; hatchCycles = 40; sprite = sprite "relicanth"; };
  luvdisc    = { dex = 370; ha = "Hydration";         male = 25;   female = 75;   hatchCycles = 20; sprite = sprite "luvdisc"; };
  bagon      = { dex = 371; ha = "Sheer Force";       male = 50;   female = 50;   hatchCycles = 40; sprite = sprite "bagon"; };
  beldum     = { dex = 374; ha = "Light Metal";       genderless = true;            hatchCycles = 40; sprite = sprite "beldum"; };

}
