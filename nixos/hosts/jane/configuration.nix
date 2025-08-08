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
    ./sops.nix
    ./ssh/default.nix
    ./kanata/default.nix
  ];

  nix = {
    package = pkgs.nixVersions.stable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Only allow steam, printer and mc server but no other proprietary apps
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "minecraft-server"
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable windows file system support (to mount and read windows ssd)
  boot.supportedFilesystems = ["ntfs"];

  # Enable sysrq
  boot.kernel.sysctl."kernel.sysrq" = 502;

  networking.hostName = "jane"; # Define your hostname.

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

  # Configure users
  users.users = {
    j-ace-svg = {
      createHome = true;
      isNormalUser = true;
      extraGroups = ["wheel"]; # Enable ‘sudo’ for the user.
    };
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
    jq

    age
    sops

    (writeShellScriptBin "rebuild" (builtins.readFile ../../rebuild.sh))
    (writeShellScriptBin "update" (builtins.readFile ../../update.sh))
  ];

  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = ["j-ace-svg"];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib
    zlib
  ];

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
