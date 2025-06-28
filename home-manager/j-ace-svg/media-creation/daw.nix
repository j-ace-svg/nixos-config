{
  pkgs,
  lib,
  ...
}: let
  ll-plugins = pkgs.callPackage ./ll-plugins.nix {
    inherit (pkgs) boost cairomm gtkmm2 libjack2 libsndfile libsamplerate lv2 lv2-cpp-tools;
  };
in {
  imports = [
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
    VST_PATH = makePluginPath "vst";
    VST3_PATH = makePluginPath "vst3";
  };

  home.packages = [
    pkgs.ardour
    pkgs.lmms

    # Plugins
    pkgs.swh_lv2
    ll-plugins
  ];
}
