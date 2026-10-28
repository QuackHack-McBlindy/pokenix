{
  lib,
  config,
  ...
} : let

in {

  pokenix = {
    specials."mewtwo-ribbon-master" = {
      species    = "mewtwo";
      ball       = "master";
      shiny      = true;
      selfObtained = true;
      level      = 100;
      nature     = "Timid";
      ability    = "Pressure";
      heldItem   = "Life Orb";
      teraType   = "Psychic";
      evs        = { hp = 4; spa = 252; spe = 252; };
      ivs        = { hp = 31; atk = 0; def = 31; spa = 31; spd = 31; spe = 31; };
      moves      = [ "Psystrike" "Aura Sphere" "Ice Beam" "Calm Mind" ];
      ribbons    = [ "Effort Ribbon" "Master Rank Ribbon" ];
      marks      = [ "The Unrivaled" ];
      ot         = "pungkula";
      id         = "082409";
      region     = "ENG";
      obtained   = "2023/08/15";
      notes      = "SR 3 days";
    };
    
    # more here

  };}
