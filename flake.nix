{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-snapd = {
      url = "github:io12/nix-snapd";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #kmonad = {
    #  url = "git+https://github.com/kmonad/kmonad?submodules=1&dir=nix";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nix-snapd,
    home-manager,
    firefox-addons,
    ...
  }: {
    nixosConfigurations = {
      # Desktop
      wiggin = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos/hosts/wiggin/configuration.nix
          nix-snapd.nixosModules.default
          {
            services.snap.enable = true;
          }
          home-manager.nixosModules.home-manager
          ./home-manager/default.nix
          #kmonad.nixosModules.default
        ];

        specialArgs = {inherit inputs;};
      };

      # Laptop
      delphiki = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos/hosts/delphiki/configuration.nix
          nix-snapd.nixosModules.default
          {
            services.snap.enable = true;
          }
          home-manager.nixosModules.home-manager
          ./home-manager/default.nix
          #kmonad.nixosModules.default
        ];

        specialArgs = {inherit inputs;};
      };
    };
  };
}
