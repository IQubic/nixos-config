{
  description = "NixOS + Home-Manager Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    xmonad.url = "github:xmonad/xmonad";
    xmonad-contrib.url = "github:xmonad/xmonad-contrib";
    home-manager.url = "github:nix-community/home-manager";
    emacs.url = "github:nix-community/emacs-overlay";

    # Powercord
    powercord.url = "github:LavaDesu/powercord-overlay";
    powercord.inputs.nixpkgs.follows = "nixpkgs";

    # Plover
    plover.url = "github:dnaq/plover-flake"; 
    plover.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ { nixpkgs, home-manager, ... }: {
    nixosConfigurations.LATITUDE-NIXOS = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        ./hardware-configuration.nix

        # Overlays from flakes
        { nixpkgs.overlays = [ 
            inputs.xmonad.overlay 
            inputs.xmonad-contrib.overlay 
            inputs.powercord.overlay
          ]; 
        }

        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.avi = import ./hm/home.nix;

          home-manager.extraSpecialArgs = {
             inherit (inputs) plover;
          };
        }
      ];
    };
  };
}
