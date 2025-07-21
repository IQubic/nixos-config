# Set-up and initial for Doom Emacs
{ pkgs, config, ... }: 

let
  cfg = config.programs.doom-emacs;
  doom = config.programs.emacs.finalPackage;
  emacs = "${doom}/bin/emacs";
  client = "${doom}/bin/emacsclient";
  epkgs = pkgs.emacsPackages;
in
{
  # Enable Emacs
  programs.emacs = {
    enable = true;
  };
  # Systemd service
  services.emacs.enable = true;

  # Enable Doom Emacs
#  programs.doom-emacs = {
#    enable = true;
#    doomPrivateDir = cfg.config.dir;  
#    config = {
#      enable = true;
#      initModules = import ./init.nix;
#      modules.config.main = {  
#        packages.source = ./packages.el;
#        config.source = ./config.el;
#      };
#    };
#  };
#  imports = [ ./lang.nix ];

  home.sessionPath = [ "$HOME/.emacs.d/bin" ];
#  xdg.configFile."doom" = {
#    source = cfg.config.dir;
#    recursive = false;
#  };  

  # Packages required for Doom Emacs
  home.packages = with pkgs; [
    ripgrep
    fd
  ];
}
