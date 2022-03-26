{
  description = "NixOS + Home-Manager Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    xmonad.url = "github:xmonad/xmonad";
    xmonad-contrib.url = "github:xmonad/xmonad-contrib";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs.url = "github:nix-community/emacs-overlay";

    # Powercord
    powercord-overlay.url = "github:LavaDesu/powercord-overlay";
  };

  outputs = inputs @ { home-manager, xmonad, xmonad-contrib, ... }: {
    nixosConfigurations.LATITUDE-NIXOS = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        ./hardware-configuration.nix

        # XMonad overlay
        { nixpkgs.overlays = [ xmonad.overlay xmonad-contrib.overlay ]; }

        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.avi = import ./hm/home.nix;

          # Optionally, use home-manager.extraSpecialArgs to pass
          # arguments to home.nix
        }
      ];
    };
  };
}
