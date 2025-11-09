{
  pkgs,
  config,
  ...
}: {
  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    lfs.enable = true;
    userEmail = "j.ace.svg@gmail.com";
    userName = "J.ace.svg";
  };

  home.packages = [
  ];
}
