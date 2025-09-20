{ config, pkgs, ... }:
{
  imports = [ ./xmobar.nix ./theme.nix ];

  xsession = {
    enable = true;
    windowManager.xmonad = {
      enable = true;
      config = ./XMonad.hs;
      libFiles."Catppuccin.hs" = ./Catppuccin.hs;

      enableContribAndExtras = true;
    };
  };

  # Add configuration for additional heads
  programs.autorandr {
    enable = true;
    profiles."desk" = {
      fingerprint = {
        "eDP-1" = "00ffffffffffff0006af3d3300000000001a0104951f1178028d15a156529d280a505400000001010101010101010101010101010101143780b87038244010103e0035ae1000001a102c80b87038244010103e0035ae1000001a000000fe004b57385434804231343048414e000000000000410196011100000a010a20200063";
        "HDMI-1" = "00ffffffffffff004c2d2c0d47515a42171d010380341d782a5295a556549d250e5054bb8c00b30081c0810081809500a9c001010101023a801871382d40582c450009252100001e000000fd0032481e5111000a202020202020000000fc00433234463339300a2020202020000000ff0048345a4d3630313236320a2020015c02031af14690041f131203230907078301000066030c00100080011d00bc52d01e20b828554009252100001e8c0ad090204031200c4055000925210000188c0ad08a20e02d10103e96000925210000180000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c9";
      };
      "eDP-1" = {
        enable = true;
        primary = false;
        mode = "1920x1080";
        rate = "60.00";
        position = "1920x1080";
      };
      "HDMI-1" = {
        enable = true;
        primary = true;
        mode = "1920x1080";
        rate = "60.00";
        position = "0x0";
      };
    };
  };

  services.caffeine.enable = true;

  home.packages = with pkgs; [
    i3lock-color
  ];
}
