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

    kmonad = {
      url = "git+https://github.com/kmonad/kmonad?submodules=1&dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nix-snapd,
    home-manager,
    kmonad,
    ...
  }: {
    nixosConfigurations = {
      # Desktop
      wiggin = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/wiggin/configuration.nix
          nix-snapd.nixosModules.default
          {
            services.snap.enable = true;
          }
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.j-ace-svg = import ./j-ace-svg/home.nix;
          }
          kmonad.nixosModules.default
        ];
      };

      # Laptop
      delphiki = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/delphiki/configuration.nix
          nix-snapd.nixosModules.default
          {
            services.snap.enable = true;
          }
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.j-ace-svg = import ./j-ace-svg/home.nix;
          }
          kmonad.nixosModules.default
        ];
      };
    };
  };
}
