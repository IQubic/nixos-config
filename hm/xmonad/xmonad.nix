{ config, pkgs, ... }:
let
  xmonadConfig = pkgs.haskellPackages.callCabal2nix "xmonad-config" ./. {};
in 
{
  xsession = {
    enable = true;

    windowManager.command = "${xmonadConfig}/bin/xmonad-config";
  };

  # Set mouse cursor
  home.pointerCursor = {
    x11 = {
      enable = true;
      defaultCursor = "left_ptr";
    };
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 32;
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
