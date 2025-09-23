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
          exec = "\"/home/j-ace-svg/.local/share/Steam/steamapps/common/SteamVR/bin/linux64/vrurlhandler\" %U";
          terminal = false;
          noDisplay = true;
          type = "Application";
          categories = ["Game"];
          mimeType = ["x-scheme-handler/steamvr"];
        };
        valve-URI-vrmonitor = {
          name = "URI-vrmonitor";
          comment = "URI handler for vrmonitor://";
          exec = "\"/home/j-ace-svg/.local/share/Steam/steamapps/common/SteamVR/bin/linux64/vrmonitor\" %U";
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

      # Reenabled (was disabled) - prevents steamvr from being able to write to it
      /*
        configFile."openvr/openvrpaths.vrpath".text = ''
        {
          "config" :
          [
            "${config.home-manager.users.j-ace-svg.xdg.dataHome}/Steam/config"
          ],
          "external_drivers" : null,
          "jsonid" : "vrpathreg",
          "log" :
          [
            "${config.home-manager.users.j-ace-svg.xdg.dataHome}/Steam/logs"
          ],
          "runtime" :
          [
            "${pkgs.opencomposite}/lib/opencomposite"
          ],
          "version" : 1
        }
      '';

      configFile."openxr/1/active_runtime.json".source = "${pkgs.monado}/share/openxr/1/openxr_monado.json";
      */
    };
  };

  programs.steam.package = pkgs.steam.override {
    extraEnv = {
      PRESSURE_VESSEL_FILESYSTEM_RW = lib.concatStringsSep ":" [
        "$XDG_RUNTIME_DIR/monado_comp_ipc"
      ];
    };
  };

  # | Kernel patch to allow all apps to setcap. Ngl I don't understand it but
  # | it seems like a bad idea; there doesn't seem like a better way tho.
  # | Stolen from https://github.com/gradientvera/GradientOS/blob/1bb81f5ed748b69032b082cfcf157a5cf45eadc3/modules/profiles/gaming/virtual-reality.nix#L262
  # As per https://wiki.nixos.org/wiki/Linux_kernel#Patching_a_single_In-tree_kernel_module
  boot.extraModulePackages = [
    (pkgs.callPackage ./amdgpu-kernel-module.nix {
      patches = [
        # As per https://wiki.nixos.org/wiki/VR#Patching_AMDGPU_to_allow_high_priority_queues
        (pkgs.fetchpatch {
          name = "cap_sys_nice_begone.patch";
          url = "https://github.com/Frogging-Family/community-patches/raw/master/linux61-tkg/cap_sys_nice_begone.mypatch";
          hash = "sha256-Y3a0+x2xvHsfLax/uwycdJf3xLxvVfkfDVqjkxNaYEo=";
        })
      ];
      kernel = config.boot.kernelPackages.kernel;
    })
  ];

  environment.systemPackages = [
    (pkgs.writeShellScriptBin "amdgpu-vr-on" ''
      echo "Setting AMD card to VR mode..."
      echo "manual" | sudo tee /sys/class/drm/renderD128/device/power_dpm_force_performance_level
      echo "4" | sudo tee /sys/class/drm/renderD128/device/pp_power_profile_mode
      echo "Done!"
    '')
    (pkgs.writeShellScriptBin "amdgpu-vr-off" ''
      echo "Setting AMD card to auto mode..."
      echo "auto" | sudo tee /sys/class/drm/renderD128/device/power_dpm_force_performance_level
      echo "Done!"
    '')
    pkgs.opencomposite
  ];
}
