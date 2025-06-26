{
  config,
  pkgs,
  lib,
  ...
}: {
  systemd.services."kanata-dell-manual" = {
    description = "Kanata for Dell";
    #unitConfig = {
    #  StartLimitIntervalSec = 2;
    #  StartLimitBurst = 5;
    #};
    serviceConfig = {
      ExecStart = lib.escapeShellArgs [
        "${pkgs.kanata}/bin/kanata"
        #"--input"
        #"device-file /dev/input/by-path/platform-i8042-serio-0-event-kbd"
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
}
