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
      gen-kanata-config = name: {
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
              "10000"
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
    in
      lib.attrsets.mergeAttrsList (map gen-kanata-config [
        "fullwidth"
        "delphiki"
      ]);

    systemd.user.services.hyprkan = lib.mkIf cfg.enableHyprkan {
      description = "Kanata Layer Switcher";
      serviceConfig = {
        ExecStart = lib.escapeShellArgs [
          "${hyprkan}/bin/hyprkan"
          "--log-level"
          "DEBUG"
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

    services.logind.settings.Login.HandlePowerKey = "ignore"; # Allow short power key press to trigger power menu

    environment.systemPackages = [
      hyprkan
      pkgs.plover.dev
    ];
  };
}
