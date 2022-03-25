{
  description = "NixOS + Home-Manager Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    home-manager = "github:rycee/home-manager";
    emacs.url = "github:nix-community/emacs-overlay";
  };

  outputs = { self, nixpkgs, nur, home-manager, emacs }: {
    nixosConfigurations.LATITUDE-NIXOS = nixpkgs.lib.nixosSystem {
      modules = [
        ./configuration.nix
        ./hardware-configuration.nix
      ];
    };
      
#      homeConfigurations = (
#        import ./hm/home-conf.nix {
#          inherit system nixpkgs nur home-manager emacs;
#        }
#      );
#    };
  };
}
