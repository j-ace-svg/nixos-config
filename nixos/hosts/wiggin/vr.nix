{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  services.monado = {
    enable = true;
    defaultRuntime = true;
  };

  # Disabled - prevents steamvr from being able to write to it
  /*
    home-manager.users.j-ace-svg.xdg.configFile."openvr/openvrpaths.vrpath".text = ''
    {
      "config" :
      [
        "~/.local/share/Steam/config"
      ],
      "external_drivers" : null,
      "jsonid" : "vrpathreg",
      "log" :
      [
        "~/.local/share/Steam/logs"
      ],
      "runtime" :
      [
        "${pkgs.opencomposite}/lib/opencomposite"
      ],
      "version" : 1
    }
  '';
  */

  # Kernel patch to allow all apps to setcap. Ngl I don't understand it but
  # it seems like a bad idea; there doesn't seem like a better way tho.
  boot.kernelPatches = [
    {
      name = "amdgpu-ignore-ctx-privileges";
      patch = pkgs.fetchpatch {
        name = "cap_sys_nice_begone.patch";
        url = "https://github.com/Frogging-Family/community-patches/raw/master/linux61-tkg/cap_sys_nice_begone.mypatch";
        hash = "sha256-Y3a0+x2xvHsfLax/uwycdJf3xLxvVfkfDVqjkxNaYEo=";
      };
    }
  ];

  environment.systemPackages = [
    pkgs.opencomposite
  ];
}
