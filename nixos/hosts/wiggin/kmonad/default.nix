{
  config,
  pkgs,
  lib,
  ...
}: {
  systemd.services."kmonad-dell-manual" = {
    description = "KMonad for Dell";
    #unitConfig = {
    #  StartLimitIntervalSec = 2;
    #  StartLimitBurst = 5;
    #};
    serviceConfig = {
      ExecStart = lib.escapeShellArgs [
        "${pkgs.kmonad}/bin/kmonad"
        #"--input"
        #"device-file /dev/input/by-path/platform-i8042-serio-0-event-kbd"
        "${./config.kbd}"
      ];
      Restart = "always";
      RestartSec = 2;
      #RestartSteps = 30;
      #RestartMaxDelaySec = "1min";
      #DynamicUser = true;
      #User = "kmonad";
      #SupplementaryGroups = ["input" "uinput"];
      Nice = -20;
    };
    wantedBy = ["default.target"];
  };
}
