{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.local.keyboard;
  hyprkan = pkgs.python313Packages.callPackage ./hyprkan.nix {
    inherit (pkgs.python313Packages) buildPythonApplication i3ipc;
  };
  kbd-types = [
    "fullwidth"
    "delphiki"
  ];
in {
  options = {
    local.keyboard = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = ''
          Whether or not to use configured kebyoard on this host
        '';
      };
      enableHyprkan = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = ''
          Whether or not to use hyprkan on this host
        '';
      };
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services = let
      gen-kanata-config = i: name: {
        "kanata-${name}-manual" = {
          description = "Kanata for Dell";
          #unitConfig = {
          #  StartLimitIntervalSec = 2;
          #  StartLimitBurst = 5;
          #};
          serviceConfig = {
            ExecStart = lib.escapeShellArgs [
              "${pkgs.kanata}/bin/kanata"
              "-p"
              (toString (10000 + i))
              "-c"
              "${./kbds/${name}.kbd}"
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
      };
      gen-hyprkan-config = i: val: {
        "hyprkan-instance-${toString i}-${val}" = {
          description = "Kanata Layer Switcher";
          serviceConfig = {
            ExecStart = lib.escapeShellArgs [
              "${hyprkan}/bin/hyprkan"
              "--log-level"
              "DEBUG"
              "-p"
              (toString (10000 + i))
              "-c"
              "${./hyprkan.json}"
            ];
            Restart = "on-failure";
            RestartSec = 5;
            Type = "simple";
          };
          restartTriggers = [./hyprkan.json ./hyprkan.nix];
          wantedBy = ["graphical-session.target"];
          after = ["graphical-session.target"];
        };
      };
    in
      lib.attrsets.mergeAttrsList (lib.imap0 gen-kanata-config kbd-types)
      // lib.attrsets.optionalAttrs cfg.enableHyprkan (lib.attrsets.mergeAttrsList (lib.imap0 gen-hyprkan-config kbd-types));

    services.logind.settings.Login.HandlePowerKey = "ignore"; # Allow short power key press to trigger power menu

    environment.systemPackages = [
      hyprkan
      pkgs.plover.dev
    ];
  };
}
