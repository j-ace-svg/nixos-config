{pkgs, ...}: {
  programs.mpv = {
    enable = true;
    scripts = [
      pkgs.mpvScripts.sponsorblock
      pkgs.mpvScripts.quality-menu
      pkgs.mpvScripts.thumbfast
      pkgs.mpvScripts.mpv-slicing
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
  };

  programs.yt-dlp = {
    enable = true;
    #extraConfig = ''
    #  -S "res:1080,quality,+size"
    #'';
  };

  home.packages = [
  ];
}
