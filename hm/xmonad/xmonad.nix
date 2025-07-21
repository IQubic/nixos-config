{ config, pkgs, ... }:
{
  imports = [ ./polybar.nix ./theme.nix ];

  xsession = {
    enable = true;
    windowManager.xmonad = {
      enable = true;
      config = ./XMonad.hs;
      libFiles."Catppuccin.hs" = ./Catppuccin.hs;

      enableContribAndExtras = true;
    };
  };

  services.caffeine.enable = true;

  home.packages = with pkgs; [
    i3lock-color
  ];
}
