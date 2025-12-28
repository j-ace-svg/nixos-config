{
  pkgs,
  config,
  ...
}: {
  programs.tmux = {
    enable = true;
    prefix = "C-_";
  };

  home.packages = [
  ];
}
