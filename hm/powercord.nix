{ config, pkgs, ... }:
{
  home.packages = [
    pkgs.discord-plugged.override {
      themes = [
        (builtins.fetchTarball "https://github.com/PhoenixColors/phoenix-discord/archive/master.tar.gz")
      ];
      plugins = [
        (builtins.fetchTarball "https://github.com/somasis/discord-tokipona/archive/master.tar.gz")
      ];
    }
  ];
}
