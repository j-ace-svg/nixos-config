# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).
{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../kmonad.mod.nix
  ];

  nix = {
    package = pkgs.nixVersions.stable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Only allow steam but no other proprietary apps
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "steam"
      "steam-unwrapped"
      "steam-original"
      "steam-run"
      "steamcmd"
      "hplip"
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable windows file system support (to mount and read windows ssd)
  boot.supportedFilesystems = ["ntfs"];

  # Enable sysrq
  boot.kernel.sysctl."kernel.sysrq" = 502;

  # Battery management
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 20;

      #Optional helps save long term battery health
      START_CHARGE_THRESH_BAT0 = 40; # 40 and bellow it starts to charge
      STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging
    };
  };

  networking.hostName = "delphiki"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Localization
  # `timedatectl list-timezones`
  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkbOptions in tty.
  };
  # xkb configuration for console keyboard
  services.xserver.xkb = {
    #layout = "us,us";
    #variant = "dvorak,";
    #options = "ctrl:nocaps,ctrl:lctrl_meta,shift:both_capslock,grp:rctrl_toggle";
  };
  systemd.services."kmonad-thinkpad-manual" = {
    description = "KMonad for Thinkpad";
    #unitConfig = {
    #  StartLimitIntervalSec = 2;
    #  StartLimitBurst = 5;
    #};
    serviceConfig = {
      ExecStart = lib.escapeShellArgs [
        "${pkgs.kmonad}/bin/kmonad"
        #"--input"
        #"device-file /dev/input/by-path/platform-i8042-serio-0-event-kbd"
        "${./kmonad/config.kbd}"
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
  services.kmonad-mod = {
    enable = true;
    package = pkgs.haskellPackages.kmonad;
    keyboards = {
      thinkpad = {
        device = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";
        defcfg.enable = false;
        config = builtins.readFile ./kmonad/config.kbd;
      };
    };
  };
  environment.etc."kmonad/config.kbd".source = ./kmonad/config.kbd;

  hardware.trackpoint = {
    enable = true;
    device = "Elan TrackPoint";
    speed = 20; # Default 97
  };

  # Wayland
  programs.sway.enable = true;
  security.polkit.enable = true;
  hardware.graphics = {
    enable = true;
  };

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = [pkgs.hplipWithPlugin];
  };

  # Enable sound. (replaced PulseAudio with Pipewire because it was installing for some reason so I gave up trying to stop it)
  security.rtkit.enable = true; # rtkit is optional but recommended
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Configure users
  users.users = {
    j-ace-svg = {
      createHome = true;
      isNormalUser = true;
      extraGroups = ["wheel" "input" "uinput"]; # Enable ‘sudo’ for the user.
    };
    test-second-user = {
      createHome = true;
      isNormalUser = true;
      # No sudo
    };
  };

  services.fprintd = {
    enable = true;
    tod = {
      enable = true;
      driver = pkgs.libfprint-2-tod1-vfs0090;
    };
  };

  # XDG environment variables
  environment.sessionVariables = {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    curl
    vim
    neovim
    wget
    htop
    system-config-printer
    alejandra

    firefox-beta

    haskellPackages.kmonad

    (writeShellScriptBin "rebuild" (builtins.readFile ../../rebuild.sh))
    (writeShellScriptBin "update" (builtins.readFile ../../update.sh))
  ];

  # Virtualisation
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["j-ace-svg"];

  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };

  networking.nat.forwardPorts = [
    {
      from = "host";
      host.port = 2222;
      guest.port = 22;
    }
    {
      from = "host";
      host.port = 80;
      guest.port = 80;
    }
  ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib
    zlib
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };

  programs.ydotool.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable USB-related services
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = false; # Disable because incompatible with flakes

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
