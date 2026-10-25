{ spriteRoot ? "sprites" }:
let
  sprite = name: "${spriteRoot}/galar/${name}.png";
in
{
  # GALAR — GENERATION 8 — 33 entries

  # Note: All Galarian forms (Meowth, Ponyta, Slowpoke, Farfetch'd,
  # Corsola, Zigzagoon, Darumaka, Yamask, Stunfisk, Mr. Mime) live
  # in their ORIGINAL region.

  grookey     = { dex = 810; ha = "Grassy Surge";       male = 87.5; female = 12.5; hatchCycles = 20; sprite = sprite "grookey"; };
  scorbunny   = { dex = 813; ha = "Libero";             male = 87.5; female = 12.5; hatchCycles = 20; sprite = sprite "scorbunny"; };
  sobble      = { dex = 816; ha = "Sniper";             male = 87.5; female = 12.5; hatchCycles = 20; sprite = sprite "sobble"; };
  skwovet     = { dex = 819; ha = "Gluttony";           male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "skwovet"; };
  rookidee    = { dex = 821; ha = "Big Pecks";          male = 50;   female = 50;   hatchCycles = 15; sprite = sprite "rookidee"; };
  blipbug     = { dex = 824; ha = "Telepathy";          male = 50;   female = 50;   hatchCycles = 15; sprite = sprite "blipbug"; };
  nickit      = { dex = 827; ha = "Stakeout";           male = 50;   female = 50;   hatchCycles = 15; sprite = sprite "nickit"; };
  gossifleur  = { dex = 829; ha = "Effect Spore";       male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "gossifleur"; };
  wooloo      = { dex = 831; ha = "Bulletproof";        male = 50;   female = 50;   hatchCycles = 15; sprite = sprite "wooloo"; };
  chewtle     = { dex = 833; ha = "Swift Swim";         male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "chewtle"; };
  yamper      = { dex = 835; ha = "Rattled";            male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "yamper"; };
  rolycoly    = { dex = 837; ha = "Flash Fire";         male = 50;   female = 50;   hatchCycles = 15; sprite = sprite "rolycoly"; };
  applin      = { dex = 840; ha = "Bulletproof";        male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "applin"; };
  silicobra   = { dex = 843; ha = "Sand Veil";          male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "silicobra"; };
  cramorant   = { dex = 845; ha = "Gulp Missile";       male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "cramorant"; };
  arrokuda    = { dex = 846; ha = "Propeller Tail";     male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "arrokuda"; };
  toxel       = { dex = 848; ha = "Klutz";              male = 50;   female = 50;   hatchCycles = 25; sprite = sprite "toxel"; };
  sizzlipede  = { dex = 850; ha = "Flame Body";         male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "sizzlipede"; };
  clobbopus   = { dex = 852; ha = "Technician";         male = 50;   female = 50;   hatchCycles = 25; sprite = sprite "clobbopus"; };
  sinistea    = { dex = 854; ha = "Cursed Body";        genderless = true;            hatchCycles = 20; sprite = sprite "sinistea"; };
  hatenna     = { dex = 856; ha = "Magic Bounce";       male = 0;    female = 100;  hatchCycles = 20; sprite = sprite "hatenna"; };
  impidimp    = { dex = 859; ha = "Pickpocket";         male = 100;  female = 0;    hatchCycles = 20; sprite = sprite "impidimp"; };
  milcery     = { dex = 868; ha = "Aroma Veil";         male = 0;    female = 100;  hatchCycles = 20; sprite = sprite "milcery"; };
  falinks     = { dex = 870; ha = "Defiant";            genderless = true;            hatchCycles = 25; sprite = sprite "falinks"; };
  pincurchin  = { dex = 871; ha = "Electric Surge";     male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "pincurchin"; };
  snom        = { dex = 872; ha = "Ice Scales";         male = 50;   female = 50;   hatchCycles = 20; sprite = sprite "snom"; };
  stonjourner = { dex = 874; ha = "Power Spot";         male = 50;   female = 50;   hatchCycles = 25; sprite = sprite "stonjourner"; };
  eiscue      = { dex = 875; ha = "Ice Face";           male = 50;   female = 50;   hatchCycles = 25; sprite = sprite "eiscue"; };
  indeedee    = { dex = 876; ha = "Psychic Surge";      male = 50;   female = 50;   hatchCycles = 40; sprite = sprite "indeedee"; };
  morpeko     = { dex = 877; ha = "Hunger Switch";      male = 50;   female = 50;   hatchCycles = 10; sprite = sprite "morpeko"; };
  cufant      = { dex = 878; ha = "Heavy Metal";        male = 50;   female = 50;   hatchCycles = 25; sprite = sprite "cufant"; };
  duraludon   = { dex = 884; ha = "Stalwart";           male = 50;   female = 50;   hatchCycles = 30; sprite = sprite "duraludon"; };
  dreepy      = { dex = 885; ha = "Cursed Body";        male = 50;   female = 50;   hatchCycles = 40; sprite = sprite "dreepy"; };
}
