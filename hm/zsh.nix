{ config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;

    envExtra = ''
      export PATH=$PATH:$HOME/.local/bin
    '';

    shellAliases = {
      # colorize grep output
      grep  = "grep  --color=auto";
      egrep = "egrep --color=auto";
      fgrep = "fgrep --color=auto";

      # human readable output
      df   = "df -h";
      free = "free -m";

      # ps
      psa    = "ps auxf";
      psgrep = "ps aux | grep -v grep | grep -i -e VSZ -e";
      psmem  = "ps auxf | sort -nr -k 4";
      pscpu  = "ps auxf | sort -nr -k 3";

      # Termbin
      tb = "nc termbin.com 9999";
    };

    oh-my-zsh = {
      enable = true;
      theme = "gallifrey";
      plugins = [ "git" ];
    };

    enableCompletion = true;
    autocd = true;
    history.ignorePatterns = [
      "ls"
      "cd"
      "pwd"
      "reboot"
      "history"
      "cd -"
      "cd .."
    ];
  };
}
