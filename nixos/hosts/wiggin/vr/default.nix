{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: let
  thaytan-openhmd = pkgs.callPackage ./thaytan-openhmd.nix {
    inherit (pkgs) hidapi SDL2 libGL glew libusb1 opencv libjpeg;
  };
  custom-monado = pkgs.monado.overrideAttrs (final: prev: {
    buildInputs = prev.buildInputs ++ [thaytan-openhmd];
  });
in {
  services.monado = {
    enable = true;
    defaultRuntime = true;
    package = custom-monado;
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

      configFile."openxr/1/active_runtime.json".source = "${custom-monado}/share/openxr/1/openxr_monado.json";
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
    pkgs.xr-hardware
    thaytan-openhmd
    # For ongoing reference: https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/by-name/en/envision/package.nix
    /*
      (pkgs.envision.overrideAttrs (final: old: {
      targetPkgs = old.targetPkgs ++ [pkgs.opencv]; # Needed for openhmd
    }))
    */
  ];

  ### The virtualization workaround
  # Virtualisation
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["j-ace-svg"];
  users.extraGroups.vboxusers.members = ["j-ace-svg"];

  boot = {
    initrd.kernelModules = [
      "vfio_pci"
      "vfio"
      "vfio_iommu_type1"

      "amdgpu"
    ];
    kernelModules = ["kvm-amd"];
    kernelParams = [
      "intel_iommu=on"
      "vfio-pci.ids=1002:67ef,1002:aae0"
    ];
  };

  systemd.services."libvirt-nosleep@" = {
    description = ''Preventing sleep while libvirt domain "%i" is running'';
    serviceConfig = {
      Type = "simple";
      ExecStart = ''/usr/bin/systemd-inhibit --what=sleep --why="Libvirt domain \"%i\" is running" --who=%U --mode=block sleep infinity'';
    };
  };

  virtualisation = {
    docker.enable = true;
    virtualbox.host.enable = true;
    libvirtd = {
      enable = true;
      qemu.package = pkgs.qemu_kvm;
      hooks.qemu = {
        "hook.sh" = pkgs.writeShellApplication {
          name = "libvirt-qemu-hook.sh";
          runtimeInputs = [
            (pkgs.writeShellApplication
              {
                name = "vfio-startup";
                runtimeInputs = [];
                text = builtins.readFile ./vfio-startup.sh;
              })
            (pkgs.writeShellApplication
              {
                name = "vfio-teardown";
                runtimeInputs = [];
                text = builtins.readFile ./vfio-teardown.sh;
              })
          ];
          text = builtins.readFile ./libvirt-qemu-hook.sh;
        };
      };
    };
    spiceUSBRedirection.enable = true;
  };
}
