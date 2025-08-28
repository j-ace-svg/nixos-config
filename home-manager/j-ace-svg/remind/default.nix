{
  pkgs,
  config,
  ...
}: {
  home.packages = [
    pkgs.remind
    pkgs.wyrd
  ];
}
