{pkgs, ...}: {
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
  };

  home.packages = [
  ];
}
