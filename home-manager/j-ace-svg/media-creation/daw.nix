{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.local.gui;
  ll-plugins = pkgs.callPackage ./ll-plugins.nix {
    inherit (pkgs) boost cairomm gtkmm2 libsamplerate libjack2 libsndfile lv2 lv2-cpp-tools;
  };
  invada-studio = pkgs.callPackage ./invada-studio.nix {
    inherit (pkgs) ladspa-sdk;
  };
  the-experience-yamaha-s6 = pkgs.callPackage ./the-experience-yamaha-s6.nix {};
in {
  imports = [
  ];

  options = {
    local.gui.daw.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Whether or not to install Digital Audio Workspace tooling and related
        dependencies
      '';
    };
  };

  config = lib.mkIf cfg.daw.enable {
    assertions = [
      {
        /*
        Directly enforce cfg.enable rather than using `->` because the
        assertion is part of the conditional configuration
        */
        assertion = cfg.enable;
        message = "local.gui.daw.enable requires local.gui.enable";
      }
    ];

    # This is relevant: https://wiki.nixos.org/wiki/Audio_production
    home.sessionVariables = let
      makePluginPath = format:
        (lib.makeSearchPath format [
          "$HOME/.nix-profile/lib"
          "/run/current-system/sw/lib"
          "/etc/profiles/per-user/$USER/lib"
        ])
        + ":$HOME/.${format}";
    in {
      DSSI_PATH = makePluginPath "dssi";
      LADSPA_PATH = makePluginPath "ladspa";
      LV2_PATH = makePluginPath "lv2";
      LXVST_PATH = makePluginPath "lxvst";
      SFZ_PATH = makePluginPath "sfz";
      VST_PATH = makePluginPath "vst";
      VST3_PATH = makePluginPath "vst3";
    };

    home.packages = [
      pkgs.ardour
      pkgs.lmms

      # Plugins
      pkgs.swh_lv2
      ll-plugins
      pkgs.zynaddsubfx
      invada-studio

      # Instruments
      the-experience-yamaha-s6
    ];
  };
}
