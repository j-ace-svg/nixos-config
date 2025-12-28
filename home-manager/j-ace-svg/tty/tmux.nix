{
  pkgs,
  config,
  ...
}: {
  programs.tmux = {
    enable = true;
    prefix = "S-e";
  };

  home.packages = [
  ];
}
