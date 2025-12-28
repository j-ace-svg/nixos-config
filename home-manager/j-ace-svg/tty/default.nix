{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./tmux.nix
  ];

  home.packages = [
  ];
}
