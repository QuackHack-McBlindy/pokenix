{ spriteRoot ? "sprites" }:
let
  sprite = name: "${spriteRoot}/sinnoh/${name}.png";
in
{
  # SINNOH — GENERATION 4 — 47 entries

  turtwig     = { dex = 387; ha = "Shell Armor";       male = 87.5; female = 12.5; hatchCycles = 20; sprite = sprite "turtwig"; };
  chimchar    = { dex = 390; ha = "Iron Fist";         male = 87.5; female = 12.5; hatchCycles = 20; sprite = sprite "chimchar"; };
  piplup      = { dex = 393; ha = "Defiant";           male = 87.5; female = 12.5; hatchCycles = 20; sprite = sprite "piplup"; };
  starly      = { dex = 396; ha = "Reckless";          male = 50;   female = 50;   hatchCycles = 15; sprite = sprite "starly"; };
  bidoof      = { dex = 399; ha = "Moody";             male = 50;   female = 50;   hatchCycles = 15; sprite = sprite "bidoof"; };
  kricketot   = { dex = 401; ha = "Run Away";          male = 50;   female = 50;   hatchCycles = 15; sprite = sprite "kricketot"; };
  shinx       = { dex = 403; ha = "Guts";              male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "shinx"; };
  cranidos    = { dex = 408; ha = "Sheer Force";       male = 87.5; female = 12.5; hatchCycles = 30; sprite = sprite "cranidos"; };
  shieldon    = { dex = 410; ha = "Soundproof";        male = 87.5; female = 12.5; hatchCycles = 30; sprite = sprite "shieldon"; };
  burmy-plant = { dex = 412; ha = "Overcoat";          male = 50;   female = 50;   hatchCycles = 15; sprite = sprite "burmy-plant"; };
  burmy-sandy = { dex = 412; ha = "Overcoat";          male = 50;   female = 50;   hatchCycles = 15; sprite = sprite "burmy-sandy"; };
  burmy-trash = { dex = 412; ha = "Overcoat";          male = 50;   female = 50;   hatchCycles = 15; sprite = sprite "burmy-trash"; };
  combee      = { dex = 415; ha = "Hustle";            male = 87.5; female = 12.5; hatchCycles = 15; sprite = sprite "combee"; };
  pachirisu   = { dex = 417; ha = "Volt Absorb";       male = 50;   female = 50;   hatchCycles = 10; sprite = sprite "pachirisu"; };
  buizel      = { dex = 418; ha = "Water Veil";        male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "buizel"; };
  cherubi     = { dex = 420; ha = "Chlorophyll";       male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "cherubi"; };
  shellos-east = { dex = 422; ha = "Sand Force";        male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "shellos-east"; };
  shellos-west = { dex = 422; ha = "Sand Force";      male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "shellos-west"; };
  drifloon    = { dex = 425; ha = "Flare Boost";       male = 50;   female = 50;   hatchCycles = 30; sprite = sprite "drifloon"; };
  buneary     = { dex = 427; ha = "Limber";            male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "buneary"; };
  glameow     = { dex = 431; ha = "Keen Eye";          male = 25;   female = 75;   hatchCycles = 20; sprite = sprite "glameow"; };
  stunky      = { dex = 434; ha = "Keen Eye";          male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "stunky"; };
  bronzor     = { dex = 436; ha = "Heavy Metal";       genderless = true;            hatchCycles = 20; sprite = sprite "bronzor"; };
  chatot      = { dex = 441; ha = "Big Pecks";         male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "chatot"; };
  spiritomb   = { dex = 442; ha = "Infiltrator";       male = 50;   female = 50;   hatchCycles = 30; sprite = sprite "spiritomb"; };
  gible       = { dex = 443; ha = "Rough Skin";        male = 50;   female = 50;   hatchCycles = 40; sprite = sprite "gible"; };
  riolu       = { dex = 447; ha = "Prankster";         male = 87.5; female = 12.5; hatchCycles = 25; sprite = sprite "riolu"; };
  hippopotas  = { dex = 449; ha = "Sand Force";        male = 50;   female = 50;   hatchCycles = 30; sprite = sprite "hippopotas"; };
  skorupi     = { dex = 451; ha = "Keen Eye";          male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "skorupi"; };
  croagunk    = { dex = 453; ha = "Poison Touch";      male = 50;   female = 50;   hatchCycles = 10; sprite = sprite "croagunk"; };
  carnivine   = { dex = 455; ha = "Levitate";          male = 50;   female = 50;   hatchCycles = 25; sprite = sprite "carnivine"; };
  finneon     = { dex = 456; ha = "Water Veil";        male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "finneon"; };
  snover      = { dex = 459; ha = "Soundproof";        male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "snover"; };
  rotom       = { dex = 479; ha = "Levitate";          genderless = true;            hatchCycles = 20; sprite = sprite "rotom"; };
}
