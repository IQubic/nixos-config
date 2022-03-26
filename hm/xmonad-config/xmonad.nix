{ config, pkgs, ... }:
let
  xmonadConfig = pkgs.haskellPackages.callCabal2nix "xmonad-config" ./. {};
in 
{
  # Allow XMonad to my specific config
  home.file."~/.cache/xmonad/xmonad-${pkgs.stdenv.system}".source = "${xmonadConfig}/bin/xmonad-config";
}
