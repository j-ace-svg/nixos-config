{pkgs, ...}: {
  programs.ssh = {
    enable = true;

    # Default values
    matchBlocks."*" = {
      forwardAgent = false;
      addKeysToAgent = "yes"; # Changed from default
      compression = false;
      serverAliveInterval = 0;
      serverAliveCountMax = 3;
      hashKnownHosts = false;
      userKnownHostsFile = "~/.ssh/known_hosts";
      controlMaster = "no";
      controlPath = "~/.ssh/master-%r@%n:%p";
      controlPersist = "no";
    };
  };

  services.ssh-agent = {
    enable = true;
  };

  home.packages = [
  ];
}
