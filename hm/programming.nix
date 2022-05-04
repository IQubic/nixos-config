{ config, pkgs, ...}:

{
  home.packages = with pkgs; [
    gforth
  ];
}
