{ config, pkgs, ... }:
let
  xmonadConfig = pkgs.haskellPackages.callCabal2nix "xmonad-config" ./. {};
in 
{
  home.file.".xmonad/xmonad-x86_64-linux".source = "${xmonadConfig}/bin/xmonad-config";
}
