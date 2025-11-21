{
  pkgs,
  config,
  ...
}: {
  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    lfs.enable = true;
    settings.user = {
      email = "j.ace.svg@gmail.com";
      name = "J.ace.svg";
    };
  };

  home.packages = [
  ];
}
