{ config, pkgs, lib, ... }:

let
  usCzProgrammerXkb = pkgs.callPackage ../package {};
in
{
  services.xserver.xkb.extraLayouts.us-cz-programmer = {
    description = "English US with Czech programmer AltGr layer";
    languages = [ "eng" "cze" ];
    symbolsFile = "${usCzProgrammerXkb}/share/X11/xkb/symbols/us-cz-programmer";
  };
}
