{
  pkgs,
  inputs,
  ...
}: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.j-ace-svg.imports = [./j-ace-svg/home.nix];
    extraSpecialArgs = {inherit inputs;};
    backupFileExtension = "hm-backup";
  };
}
