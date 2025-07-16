{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.local.gui;
in {
  config = lib.mkIf cfg.enable {
    programs.mpv = {
      enable = true;
      scripts = with pkgs; [
        mpvScripts.sponsorblock
        mpvScripts.quality-menu
        mpvScripts.thumbfast
        mpvScripts.mpv-slicing
        (callPackage ./mpv-youtube-chat.nix {
          inherit fetchFromGitHub lib unstableGitUpdater;
          buildLua = mpvScripts.buildLua;
        })
      ];
      bindings = {
        "<" = "add chapter -1";
        ">" = "add chapter 1";
        "PGDWN" = "playlist-prev";
        "PGUP" = "playlist-next";
        "WHEEL_DOWN" = "ignore";
        "WHEEL_UP" = "ignore";
        "MBTN_LEFT" = "cycle pause";
        "F" = "script-binding quality_menu/video_formats_toggle";
        "Alt+f" = "script-binding quality_menu/audio_formats_toggle";
        "F12" = "ignore";
      };
      config = {
        af-add = "scaletempo2=max-speed=32.0";
        speed = 2;
      };
      profiles = {
        audio-only = {
          profile-cond = "(get('video-frame-info/picture-type', 'I') == 'I')";
          profile-restore = "copy";
          speed = 1;
        };
      };
    };

    programs.yt-dlp = {
      enable = true;
    };

    home.packages = [
      pkgs.python313Packages.yt-dlp-dearrow
    ];
  };
}
