{
  pkgs,
  inputs,
  opts,
  ...
}: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.j-ace-svg.imports = [./j-ace-svg/home.nix];
    extraSpecialArgs = {inherit inputs opts;};
    backupFileExtension = "hm-backup";
  };
}
