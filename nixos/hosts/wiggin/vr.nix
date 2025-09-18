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

  home-manager.users.j-ace-svg = {
    xdg = {
      desktopEntries = {
        valve-URI-steamvr = {
          name = "URI-steamvr";
          comment = "URI handler for steamvr://";
          exec = "\"/home/steamuser/.local/share/Steam/steamapps/common/SteamVR/bin/linux64/vrurlhandler\" %U";
          terminal = false;
          noDisplay = true;
          type = "Application";
          categories = ["Game"];
          mimeType = ["x-scheme-handler/steamvr"];
        };
        valve-URI-vrmonitor = {
          name = "URI-vrmonitor";
          comment = "URI handler for vrmonitor://";
          exec = "\"/home/steamuser/.local/share/Steam/steamapps/common/SteamVR/bin/linux64/../vrmonitor.sh\" %U";
          terminal = false;
          noDisplay = true;
          type = "Application";
          categories = ["Game"];
          mimeType = ["x-scheme-handler/vrmonitor"];
        };
      };
      mimeApps = {
        enable = true;
        defaultApplications = {
          "x-scheme-handler/steamvr" = ["valve-URI-steamvr.desktop"];
          "x-scheme-handler/vrmonitor" = ["valve-URI-vrmonitor.desktop"];
        };
      };
    };
    # Disabled - prevents steamvr from being able to write to it
    /*
      xdg.configFile."openvr/openvrpaths.vrpath".text = ''
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
  };

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
