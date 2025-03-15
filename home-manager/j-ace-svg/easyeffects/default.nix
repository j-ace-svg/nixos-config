{
  pkgs,
  lib,
  ...
}: {
  services.easyeffects.enable = true;

  #systemd.user.services.easyeffects = {
  #  Unit = {
  #    Description = "Audio effects for PipeWire applications";
  #  };
  #  Install = {
  #    WantedBy = ["default.target"];
  #  };
  #  Service = {
  #    ExecStart = lib.escapeShellArgs [
  #      "${pkgs.easyeffects}/bin/easyeffects"
  #      "--gapplication-service"
  #    ];
  #  };
  #};
}
