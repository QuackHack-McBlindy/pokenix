{ 
  spriteRoot
  ?
  "sprites"
} : let
  sprite = name: "${spriteRoot}/johto/${name}.png";

  allBalls = [
    "safari" "sport" "fast" "friend" "heavy" "level"
    "love" "lure" "moon" "dream" "beast"
  ];
  without = exclude:
    builtins.filter (b: !(builtins.elem b exclude)) allBalls;
in {
  # JOHTO — GENERATION 2 — 46 entries

  chikorita   = { dex = 152; ha = "Leaf Guard";        male = 87.5; female = 12.5; hatchCycles = 20; balls = without [ "safari" "sport" "dream" ]; sprite = sprite "chikorita"; };
  cyndaquil   = { dex = 155; ha = "Flash Fire";        male = 87.5; female = 12.5; hatchCycles = 20; balls = without [ "safari" "sport" "dream" ]; sprite = sprite "cyndaquil"; };
  totodile    = { dex = 158; ha = "Sheer Force";       male = 87.5; female = 12.5; hatchCycles = 20; balls = without [ "safari" "sport" "dream" ]; sprite = sprite "totodile"; };
  sentret     = { dex = 161; ha = "Frisk";             male = 50;   female = 50;   hatchCycles = 15; balls = without [ "sport" "beast" ]; sprite = sprite "sentret"; };
  hoothoot    = { dex = 163; ha = "Tinted Lens";       male = 50;   female = 50;   hatchCycles = 15; sprite = sprite "hoothoot"; };
  ledyba      = { dex = 165; ha = "Rattled";           male = 50;   female = 50;   hatchCycles = 15; balls = without [ "sport" ]; sprite = sprite "ledyba"; };
  spinarak    = { dex = 167; ha = "Sniper";            male = 50;   female = 50;   hatchCycles = 15; balls = without [ "sport" ]; sprite = sprite "spinarak"; };
  chinchou    = { dex = 170; ha = "Water Absorb";      male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "chinchou"; };
  togepi      = { dex = 175; ha = "Super Luck";        male = 87.5; female = 12.5; hatchCycles = 10; sprite = sprite "togepi"; };
  natu        = { dex = 177; ha = "Magic Bounce";      male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "natu"; };
  mareep      = { dex = 179; ha = "Plus";              male = 50;   female = 50;   hatchCycles = 20; balls = without [ "sport" ]; sprite = sprite "mareep"; };
  marill      = { dex = 183; ha = "Sap Sipper";        male = 50;   female = 50;   hatchCycles = 10; sprite = sprite "marill"; };
  sudowoodo   = { dex = 185; ha = "Rattled";           male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "sudowoodo"; };
  hoppip      = { dex = 187; ha = "Infiltrator";       male = 50;   female = 50;   hatchCycles = 20; balls = without [ "sport" ]; sprite = sprite "hoppip"; };
  aipom       = { dex = 190; ha = "Skill Link";        male = 50;   female = 50;   hatchCycles = 20; balls = without [ "sport" ]; sprite = sprite "aipom"; };
  sunkern     = { dex = 191; ha = "Early Bird";        male = 50;   female = 50;   hatchCycles = 20; balls = without [ "sport" ]; sprite = sprite "sunkern"; };
  yanma       = { dex = 193; ha = "Frisk";             male = 50;   female = 50;   hatchCycles = 20; balls = without [ "sport" ]; sprite = sprite "yanma"; };
  wooper      = { dex = 194; ha = "Unaware";           male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "wooper"; };
  wooper-paldea  = { dex = 194; ha = "Unaware";        male = 50;   female = 50;   hatchCycles = 20; balls = without [ "safari" "sport" ]; sprite = sprite "wooper-paldea"; };
  murkrow     = { dex = 198; ha = "Prankster";         male = 50;   female = 50;   hatchCycles = 20; balls = without [ "sport" ]; sprite = sprite "murkrow"; };
  misdreavus  = { dex = 200; ha = "Levitate";          male = 50;   female = 50;   hatchCycles = 25; balls = without [ "sport" ]; sprite = sprite "misdreavus"; };
  wobbuffet   = { dex = 202; ha = "Telepathy";         male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "wobbuffet"; };
  girafarig   = { dex = 203; ha = "Sap Sipper";        male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "girafarig"; };
  pineco      = { dex = 204; ha = "Overcoat";          male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "pineco"; };
  dunsparce   = { dex = 206; ha = "Rattled";           male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "dunsparce"; };
  gligar      = { dex = 207; ha = "Immunity";          male = 50;   female = 50;   hatchCycles = 20; balls = without [ "sport" "beast" ]; sprite = sprite "gligar"; };
  snubbull    = { dex = 209; ha = "Rattled";           male = 25;   female = 75;   hatchCycles = 20; balls = without [ "sport" ]; sprite = sprite "snubbull"; };
  qwilfish    = { dex = 211; ha = "Intimidate";        male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "qwilfish"; };
  shuckle     = { dex = 213; ha = "Contrary";          male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "shuckle"; };
  heracross   = { dex = 214; ha = "Moxie";             male = 50;   female = 50;   hatchCycles = 25; sprite = sprite "heracross"; };
  sneasel     = { dex = 215; ha = "Pickpocket";        male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "sneasel"; };
  teddiursa   = { dex = 216; ha = "Honey Gather";      male = 50;   female = 50;   hatchCycles = 20; balls = without [ "sport" ]; sprite = sprite "teddiursa"; };
  slugma      = { dex = 218; ha = "Weak Armor";        male = 50;   female = 50;   hatchCycles = 20; balls = without [ "safari" "sport" ]; sprite = sprite "slugma"; };
  swinub      = { dex = 220; ha = "Thick Fat";         male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "swinub"; };
  corsola     = { dex = 222; ha = "Regenerator";       male = 25;   female = 75;   hatchCycles = 20; sprite = sprite "corsola"; };
  corsola-galar = { dex = 222; ha = "Cursed Body";     male = 25;   female = 75;   hatchCycles = 20; sprite = sprite "corsola-galar"; };
  remoraid    = { dex = 223; ha = "Moody";             male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "remoraid"; };
  delibird    = { dex = 225; ha = "Insomnia";          male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "delibird"; };
  mantine     = { dex = 226; ha = "Water Veil";        male = 50;   female = 50;   hatchCycles = 25; sprite = sprite "mantine"; };
  skarmory    = { dex = 227; ha = "Weak Armor";        male = 50;   female = 50;   hatchCycles = 25; sprite = sprite "skarmory"; };
  houndour    = { dex = 228; ha = "Unnerve";           male = 50;   female = 50;   hatchCycles = 20; balls = without [ "sport" ]; sprite = sprite "houndour"; };
  phanpy      = { dex = 231; ha = "Sand Veil";         male = 50;   female = 50;   hatchCycles = 20; balls = without [ "sport" "beast" ]; sprite = sprite "phanpy"; };
  stantler    = { dex = 234; ha = "Sap Sipper";        male = 50;   female = 50;   hatchCycles = 20; balls = without [ "sport" "beast" ]; sprite = sprite "stantler"; };
  smeargle    = { dex = 235; ha = "Moody";             male = 50;   female = 50;   hatchCycles = 20; balls = without [ "sport" ]; sprite = sprite "smeargle"; };
  tyrogue     = { dex = 236; ha = "Vital Spirit";      male = 100;  female = 0;    hatchCycles = 25; sprite = sprite "tyrogue"; };
  miltank     = { dex = 241; ha = "Sap Sipper";        male = 0;    female = 100;  hatchCycles = 20; sprite = sprite "miltank"; };
  larvitar    = { dex = 246; ha = "Sand Veil";         male = 50;   female = 50;   hatchCycles = 40; sprite = sprite "larvitar"; };
}
