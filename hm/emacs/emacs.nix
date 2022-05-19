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

  # Enable Doom Emacs
  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = cfg.config.dir;
  };

  # Enable Doom Emacs config
  programs.doom-emacs.config = {
    enable = true;
    initModules = { }; # TODO FILL THIS OUT
    modules.config.main = {
      packages.source = ./packages.el;
      config.source = ./config.el;
    };
  };
  programs.doom-emacs.doomPrivateDir = cfg.config.dir;
  xdg.configFile."doom" = {
    source = cfg.config.dir;
    recursive = false;
  };  

  # Packages required for Doom Emacs
  home.packages = with pkgs; [
    ripgrep
    fd

    # Spell checkers
    aspell
    (hunspellWithDicts (with hunspellDicts; [ en_US ]))
  ];

  # Systemd daemon
  systemd.user.services.doom-emacs-daemon = {
    Unit = {
      Description = "Doom Emacs Server Daemon";
      Documentation = [ "info:emacs" "man:emacs(1)" "https://gnu.org/software/emacs/" ];
      After = [ "graphical-session-pre.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      Type = "notify";
      ExecStart = "${pkgs.runtimeShell} -l -c '${emacs} --fg-daemon'";
      SuccessExitStatus=15;
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
