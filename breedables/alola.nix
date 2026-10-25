{ spriteRoot ? "sprites" }:
let
  sprite = name: "${spriteRoot}/alola/${name}.png";
in
{
  # ALOLA — GENERATION 7 — 44 entries

  # Note: Alolan Rattata, Diglett, Meowth, Geodude, Grimer,
  # Sandshrew, Vulpix live in kanto.nix / johto.nix 

  rowlet          = { dex = 722; ha = "Long Reach";         male = 87.5; female = 12.5; hatchCycles = 15; sprite = sprite "rowlet"; };
  litten          = { dex = 725; ha = "Intimidate";         male = 87.5; female = 12.5; hatchCycles = 15; sprite = sprite "litten"; };
  popplio         = { dex = 728; ha = "Liquid Voice";       male = 87.5; female = 12.5; hatchCycles = 15; sprite = sprite "popplio"; };
  pikipek         = { dex = 731; ha = "Pickup";             male = 50;   female = 50;   hatchCycles = 15; sprite = sprite "pikipek"; };
  yungoos         = { dex = 734; ha = "Adaptability";       male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "yungoos"; };
  grubbin         = { dex = 736; ha = "Swarm";              male = 50;   female = 50;   hatchCycles = 15; sprite = sprite "grubbin"; };
  crabrawler      = { dex = 739; ha = "Anger Point";        male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "crabrawler"; };
  oricorio-baile  = { dex = 741; ha = "Dancer";             male = 25;   female = 75;   hatchCycles = 20; sprite = sprite "oricorio-baile"; };
  oricorio-pompom = { dex = 741; ha = "Dancer";             male = 25;   female = 75;   hatchCycles = 20; sprite = sprite "oricorio-pompom"; };
  oricorio-pau    = { dex = 741; ha = "Dancer";             male = 25;   female = 75;   hatchCycles = 20; sprite = sprite "oricorio-pau"; };
  oricorio-sensu  = { dex = 741; ha = "Dancer";             male = 25;   female = 75;   hatchCycles = 20; sprite = sprite "oricorio-sensu"; };
  cutiefly        = { dex = 742; ha = "Sweet Veil";         male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "cutiefly"; };
  rockruff        = { dex = 744; ha = "Steadfast";          male = 50;   female = 50;   hatchCycles = 15; sprite = sprite "rockruff"; };
  rockruff-dusk   = { dex = 744; ha = "Own Tempo";          male = 50;   female = 50;   hatchCycles = 15; sprite = sprite "rockruff-dusk"; };
  wishiwashi      = { dex = 746; ha = "Schooling";          male = 50;   female = 50;   hatchCycles = 15; sprite = sprite "wishiwashi"; };
  mareanie        = { dex = 747; ha = "Regenerator";        male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "mareanie"; };
  mudbray         = { dex = 749; ha = "Inner Focus";        male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "mudbray"; };
  dewpider        = { dex = 751; ha = "Water Absorb";       male = 50;   female = 50;   hatchCycles = 15; sprite = sprite "dewpider"; };
  fomantis        = { dex = 753; ha = "Contrary";           male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "fomantis"; };
  morelull        = { dex = 755; ha = "Rain Dish";          male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "morelull"; };
  salandit        = { dex = 757; ha = "Oblivious";          male = 87.5; female = 12.5; hatchCycles = 20; sprite = sprite "salandit"; };
  stufful         = { dex = 759; ha = "Cute Charm";         male = 50;   female = 50;   hatchCycles = 15; sprite = sprite "stufful"; };
  bounsweet       = { dex = 761; ha = "Sweet Veil";         male = 0;    female = 100;  hatchCycles = 20; sprite = sprite "bounsweet"; };
  comfey          = { dex = 764; ha = "Natural Cure";       male = 25;   female = 75;   hatchCycles = 20; sprite = sprite "comfey"; };
  oranguru        = { dex = 765; ha = "Symbiosis";          male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "oranguru"; };
  passimian       = { dex = 766; ha = "Defiant";            male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "passimian"; };
  wimpod          = { dex = 767; ha = "Wimp Out";           male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "wimpod"; };
  sandygast       = { dex = 769; ha = "Sand Veil";          male = 50;   female = 50;   hatchCycles = 15; sprite = sprite "sandygast"; };
  pyukumuku       = { dex = 771; ha = "Unaware";            male = 50;   female = 50;   hatchCycles = 15; sprite = sprite "pyukumuku"; };
  minior-blue     = { dex = 774; ha = "Shields Down";       genderless = true;            hatchCycles = 25; sprite = sprite "minior-blue"; };
  minior-green    = { dex = 774; ha = "Shields Down";       genderless = true;            hatchCycles = 25; sprite = sprite "minior-green"; };
  minior-indigo   = { dex = 774; ha = "Shields Down";       genderless = true;            hatchCycles = 25; sprite = sprite "minior-indigo"; };
  minior-orange   = { dex = 774; ha = "Shields Down";       genderless = true;            hatchCycles = 25; sprite = sprite "minior-orange"; };
  minior-red      = { dex = 774; ha = "Shields Down";       genderless = true;            hatchCycles = 25; sprite = sprite "minior-red"; };
  minior-violet   = { dex = 774; ha = "Shields Down";       genderless = true;            hatchCycles = 25; sprite = sprite "minior-violet"; };
  minior-yellow   = { dex = 774; ha = "Shields Down";       genderless = true;            hatchCycles = 25; sprite = sprite "minior-yellow"; };
  komala          = { dex = 775; ha = "Comatose";           male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "komala"; };
  turtonator      = { dex = 776; ha = "Shell Armor";        male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "turtonator"; };
  togedemaru      = { dex = 777; ha = "Sturdy";             male = 50;   female = 50;   hatchCycles = 10; sprite = sprite "togedemaru"; };
  mimikyu         = { dex = 778; ha = "Disguise";           male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "mimikyu"; };
  bruxish         = { dex = 779; ha = "Wonder Skin";        male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "bruxish"; };
  drampa          = { dex = 780; ha = "Cloud Nine";         male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "drampa"; };
  dhelmise        = { dex = 781; ha = "Steelworker";        genderless = true;          hatchCycles = 25; sprite = sprite "dhelmise"; };
  jangmo-o        = { dex = 782; ha = "Overcoat";           male = 50;   female = 50;   hatchCycles = 40; sprite = sprite "jangmo-o"; };

}
