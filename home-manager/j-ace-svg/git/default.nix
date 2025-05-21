{
  pkgs,
  config,
  ...
}: {
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    lfs.enable = true;
    userEmail = "j.ace.svg@gmail.com";
    userName = "J.ace.svg";
    extraConfig = {
      core = {
        sshCommand = "ssh -F ${config.home.homeDirectory}/.ssh/config";
      };
    };
  };

  home.packages = [
  ];
}
