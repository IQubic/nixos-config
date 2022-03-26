{ config, pkgs, ... }:
let
  fetchPowercordTarball = user: repo: sha256: 
    builtins.fetchTarball "https://github.com/${user}/${repo}/master.tar.gz";
in
{
  home.packages = [
    (pkgs.discord-plugged.override {
      themes = [
        (fetchPowercordTarball "PhoenixColors" "phoenix-discord" pkgs.lib.fakeSha256)
      ];
      plugins = [
        (fetchPowercordTarball "somasis" "discord-tokipona" pkgs.lib.fakeSha256)
      ];
    })
  ];
}
