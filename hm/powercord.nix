{ config, pkgs, ... }:
let
  fetchPowercordTarball = user: repo: sha256: 
    builtins.fetchTarball { 
      url = "https://github.com/${user}/${repo}/archive/master.tar.gz";
      inherit sha256;
    };
in
{
  home.packages = [
    (pkgs.discord-plugged.override {
      themes = [
        (fetchPowercordTarball "PhoenixColors" "phoenix-discord"
          "00qnz1p89wc3r8bxl6nv0km2k6xaxqf64j47h08qnk95r8gw81p6")
      ];
      plugins = [
        (fetchPowercordTarball "somasis" "discord-tokipona"
          "0nlsclwaqflzbvfz4dhxx9ds2nigljp89jzd7jkm4i46brljn4yr")
      ];
    })
  ];
}
