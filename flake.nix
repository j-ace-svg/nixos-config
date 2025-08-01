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
      mkSystem = {
        system ? "x86_64-linux",
        modules,
        specialArgs ? {},
        systemOpts ? {},
        homeOpts ? {},
      }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules =
            [
              ./nixos/modules/default.nix
              sops-nix.nixosModules.sops
              nix-snapd.nixosModules.default
              {
                services.snap.enable = true;
              }
              home-manager.nixosModules.home-manager
              ./home-manager/default.nix
              #kmonad.nixosModules.default

              {
                local = systemOpts;
                home-manager.users.j-ace-svg.local = homeOpts;
              }
            ]
            ++ modules;

          specialArgs = {
            inherit inputs;
            opts =
              {
                configPath = "/etc/nixos";
              }
              // specialArgs;
          };
        };
    in {
      # Desktop
      wiggin = mkSystem {
        modules = [
          ./nixos/hosts/wiggin/configuration.nix
        ];
        systemOpts = {
          hosting = {
            enable = true;
            domain = "philotic.xyz";
            immich.enable = true;
            nextcloud.enable = true;
            minecraft-server.enable = true;
          };
        };
        homeOpts = {
          gui = {
            enable = true;
            daw.enable = true;
          };
        };
      };

      # Laptop
      delphiki = mkSystem {
        modules = [
          ./nixos/hosts/delphiki/configuration.nix
        ];
        homeOpts = {
          gui.enable = true;
        };
      };

      # Server
      jane = mkSystem {
        modules = [
          ./nixos/hosts/jane/configuration.nix
        ];
        systemOpts = {
          hosting = {
            enable = true;
            domain = "philotic.xyz";
            immich.enable = true;
            nextcloud.enable = true;
            minecraft-server.enable = true;
          };
        };
        # Don't install a gui
      };
    };
  };
}
