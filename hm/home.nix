{ config, pkgs, ... }:

{
  home.username = "avi";
  home.homeDirectory = "/home/avi";

  imports = [
#   ./alacritty.nix
    ./powercord.nix
#   ./dunst.nix
#   ./firefox.nix
#   ./flameshot.nix
#   ./picom.nix 
#   ./zsh.nix
  ];

#    discord-plugged.override {
#      themes = [
#        (builtins.fetchTarball "https://github.com/PhoenixColors/phoenix-discord/archive/master.tar.gz")
#      ];
#      plugins = [
#        (builtins.fetchTarball "https://github.com/somasis/discord-tokipona/archive/master.tar.gz")
#      ];
#    }

  programs.git = {
    enable = true;
    userName = "iqubic";
    userEmail = "avi.caspe@gmail.com";
  };

  home.stateVersion = "22.05";
  programs.home-manager.enable = true;
}
