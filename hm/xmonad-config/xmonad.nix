{ config, pkgs, ... }:
let
  xmonadConfig = pkgs.haskellPackages.callCabal2nix "xmonad-config" ./. {};
in 
{
  xsession = {
    enable = true;

    command = "${xmonadConfig}/bin/xmonad-config";

    # Set mouse cursor
    pointerCursor = {
      package = pkgs.bibata-extra-cursors;
      name = "Bibata-Modern-DodgerBlue";
      defaultCursor = "left_ptr";
      size = 32;
    };
  };

  # Allow XMonad to find my specific config
  home.file.".cache/xmonad/xmonad-${pkgs.stdenv.system}".source = "${xmonadConfig}/bin/xmonad-config";

  home.packages = with pkgs; [
    brightnessctl
    dmenu
    i3lock-color
    xmobar
  ];
}
