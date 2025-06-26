{
  config,
  pkgs,
  lib,
  ...
}: let
  hyprkan = pkgs.python313Packages.callPackage ./hyprkan.nix {
    inherit (pkgs.python313Packages) buildPythonApplication;
    inherit (pkgs.python313Packages) i3ipc;
    inherit (pkgs) kanata;
  };
in {
  systemd.services."kanata-dell-manual" = {
    description = "Kanata for Dell";
    #unitConfig = {
    #  StartLimitIntervalSec = 2;
    #  StartLimitBurst = 5;
    #};
    serviceConfig = {
      ExecStart = lib.escapeShellArgs [
        "${pkgs.kanata}/bin/kanata"
        "-p"
        "10000"
        "-c"
        "${./config.kbd}"
      ];
      Restart = "always";
      RestartSec = 2;
      #RestartSteps = 30;
      #RestartMaxDelaySec = "1min";
      #DynamicUser = true;
      #User = "kanata";
      #SupplementaryGroups = ["input" "uinput"];
      Nice = -20;
    };
    wantedBy = ["default.target"];
  };

  systemd.user.services.hyprkan = {
    description = "Kanata Layer Switcher";
    serviceConfig = {
      ExecStart = lib.escapeShellArgs [
        "${hyprkan}/bin/hyprkan"
        "-p"
        "10000"
        "-c"
        "${./hyprkan.json}"
      ];
      Restart = "on-failure";
      RestartSec = 5;
      Type = "simple";
    };
    wantedBy = ["graphical-session.target"];
    after = ["graphical-session.target"];
  };

  environment.systemPackages = [
    hyprkan
  ];
}
