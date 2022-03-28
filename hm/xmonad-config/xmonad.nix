{ config, pkgs, ... }:
let
  xmonadConfig = pkgs.haskellPackages.callCabal2nix "xmonad-config" ./. {};
in 
{
  # Allow XMonad to find my specific config when hot-reloading
  home.file.".cache/xmonad/xmonad-${pkgs.stdenv.system}".source = "${xmonadConfig}/bin/xmonad-config";

  home.packages = with pkgs; [
    dmenu
    i3lock-color
    xmobar
  ];
}
