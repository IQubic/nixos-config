{ config, pkgs, ... }:

{
  # Use latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = ["hid-nintendo"];

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
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    hack-font
  ];

  environment.systemPackages = with pkgs; [
    acpi
    appimage-run
    file
    git
    gnutls
    htop
    joycond
    lm_sensors
    tree
    vim
    wget
    unzip
    usbutils
    xboxdrv
    xorg.xev
    xorg.xmodmap
    zip
  ];
  nixpkgs.config.allowUnfree = true;

  # Enable Steam  
  programs.steam.enable = true;
  hardware.steam-hardware.enable = true;

  # Enable Joycond
  services.joycond.enable = true;

  # Flatpak
  services.flatpak.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # Allow flakes
  nix.package = pkgs.nixUnstable;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Throttle an Intel CPU if too hot
  services.thermald.enable = true;

  # Enable Docker
  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "btrfs";

  # Enable the X11 windowing system.
  services = {
    xserver = {
      enable = true;

      layout = "us";
      xkbOptions = "caps:escape";
 
      libinput.enable = true;

      windowManager.xmonad.enable = true;
      displayManager.defaultSession = "none+xmonad";
      displayManager.lightdm = {
        enable = true;
        greeters.gtk = {
          enable = true;
          cursorTheme = {
            package = pkgs.bibata-cursors;
            name = "Bibata-Modern-Classic";
            size = 32;
          };
        };
      };
    };
    gnome.gnome-keyring.enable = true;
    upower.enable = true;
    udev.packages = [ pkgs.qmk-udev-rules ];

    dbus = {
      enable = true;
      packages = [ pkgs.dconf ];
    };
  };

  # Enable sound.
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };
  
  # Enable Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.settings.General.Experimental = true;
  services.blueman.enable = true;

  systemd.services.upower.enable = true;

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
      "docker"
    ];
  };
  programs.zsh.enable = true;
  # For ZSH auto completion
  environment.pathsToLink = [ "/share/zsh" ];

  system.stateVersion = "21.11";
}
