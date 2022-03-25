{ config, pkgs, ... }:

let
  powercord-overlay = import (builtins.fetchTarball "https://github.com/LavaDesu/powercord-overlay/archive/master.tar.gz");  
in

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Setup networking
  networking.hostName = "LATITUDE-NIXOS"; 
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalization properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Fonts
  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    hack-font
  ];

  environment.systemPackages = with pkgs; [
    appimage-run
    #discord-plugged.override {
    #  themes = [
    #    (builtins.fetchTarball "https://github.com/PhoenixColors/phoenix-discord/archive/master.tar.gz")
    #  ];
    #  plugins = [
    #   (builtins.fetchTarball "https://github.com/somasis/discord-tokipona/archive/master.tar.gz")
    #  ];
    #}
    firefox-bin
    flameshot
    gimp
    git
    i3lock-color
    pavucontrol
    steam
    steam-run
    tree
    wget
    wine
    zip
  ];
  nixpkgs.config.allowUnfree = true;
  nix.package = pkgs.nixUnstable;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Enable the X11 windowing system.
  services.xserver = {
    layout = "us,gr";
    xkbOptions = "caps:escape,grp:shifts_toggle,grp_led:caps";
  };

  # Enable sound.
  hardware.pulseaudio = {
    enable = true;
    extraModules = [ pkgs.pulseaudio-modules-bt ];
    package = pkgs.pulseaudioFull;
  };
  services.blueman.enable = true;


  # Users
  users.users.avi = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ 
      "wheel"
      "networkmanager"
      "audio"
      "video"
      "dialout"
      "systemd-journal"
    ];
  };


  system.stateVersion = "21.11";

}

