{pkgs, ...}: {
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    lfs.enable = true;
    userEmail = "j.ace.svg@gmail.com";
    userName = "J.ace.svg";
  };

  home.packages = [
  ];
}
