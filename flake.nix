{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-snapd = {
      url = "github:io12/nix-snapd";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plover-wayland = {
      url = "github:FirelightFlagboy/plover-wayland-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixCats = {
      url = "github:BirdeeHub/nixCats-nvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-minecraft = {
      url = "github:Infinidoge/nix-minecraft";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    sops-nix,
    nix-snapd,
    firefox-addons,
    plover-wayland,
    nixCats,
    nix-minecraft,
    ...
  }: {
    nixosConfigurations = let
      defaultOpts = {
        configPath = "/etc/nixos";
      };
    in {
      # Desktop
      wiggin = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos/hosts/wiggin/configuration.nix
          sops-nix.nixosModules.sops
          nix-snapd.nixosModules.default
          {
            services.snap.enable = true;
          }
          home-manager.nixosModules.home-manager
          ./home-manager/default.nix
          #kmonad.nixosModules.default

          {
            # Per-device module selection (may be a better approach than specialArgs)
            home-manager.users.j-ace-svg.local = {
              daw.enable = true;
            };
          }
        ];

        specialArgs = {
          inherit inputs;
          opts = defaultOpts // {};
        };
      };

      # Laptop
      delphiki = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos/hosts/delphiki/configuration.nix
          sops-nix.nixosModules.sops
          nix-snapd.nixosModules.default
          {
            services.snap.enable = true;
          }
          home-manager.nixosModules.home-manager
          ./home-manager/default.nix
          #kmonad.nixosModules.default
        ];

        specialArgs = {
          inherit inputs;
          opts = defaultOpts // {};
        };
      };
    };
  };
}
