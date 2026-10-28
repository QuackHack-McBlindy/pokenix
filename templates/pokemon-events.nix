{
  lib,
  config,
  ...
} : let

in {

  pokenix = { 
    # EVENT POKÉMON
    events = {
      "farfetchd-wishmkr-2003" = {
        species="farfetchd";
        dex=83;
        name="Farfetch'd";
        ball="pokeball";
        year="2003";
        ot="Ash";
        id="123456";      
        region="ENG";
        notes="WiSHMKR";
        proof="friend of OT TC";
        obtained="2021/02/16";
        moves=[ "Wish" "Yawn" ];
        tradeHistory="TrainerName#1234 > my username";
      };
      # more here
    };  

  };}
