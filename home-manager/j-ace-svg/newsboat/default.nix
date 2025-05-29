{pkgs, ...}: {
  programs.newsboat = {
    enable = true;
    urls = [
      {
        title = "---YOUTUBE---";
        url = "";
        # Original url base for youtube feeds: https://www.youtube.com/feeds/videos.xml?channel_id=
      }
      {
        title = "~YOUTUBE: Mumbo Jumbo";
        tags = ["YOUTUBE"];
        url = "\"exec:${./execurl/youtube.sh} UChFur_NwVSbUozOcF_F2kMg\"";
      }
      {
        title = "~YOUTUBE: Mental Outlaw";
        tags = ["YOUTUBE"];
        url = "\"exec:${./execurl/youtube.sh} UC7YOGHUfC1Tb6E4pudI9STA\"";
        #url = "https://odysee.com/$/rss/@AlphaNerd:8";
      }
      {
        title = "~YOUTUBE: LibrePhoenix";
        tags = ["YOUTUBE"];
        url = "\"exec:${./execurl/youtube.sh} UCeZyoDTk0J-UPhd7MUktexw\"";
        #url = "https://odysee.com/$/rss/@LibrePhoenix:8";
      }
      {
        title = "~YOUTUBE: Ryclic";
        tags = ["YOUTUBE"];
        url = "\"exec:${./execurl/youtube.sh} UC7d6soE3Z3Duuo4OD-BibpQ\"";
      }
      {
        title = "~YOUTUBE: No Boilerplate";
        tags = ["YOUTUBE"];
        url = "\"exec:${./execurl/youtube.sh} UCUMwY9iS8oMyWDYIe6_RmoA\"";
      }
      {
        title = "~YOUTUBE: TheVimeagen";
        tags = ["YOUTUBE"];
        url = "\"exec:${./execurl/youtube.sh} UCVk4b-svNJoeytrrlOixebQ\"";
      }
      {
        title = "~YOUTUBE: Shnee";
        tags = ["YOUTUBE"];
        url = "\"exec:${./execurl/youtube.sh} UCIJhUaFcOoxyE4ImRpCaNhw\"";
      }
      {
        title = "~YOUTUBE: Two Minute Papers";
        tags = ["YOUTUBE"];
        url = "\"exec:${./execurl/youtube.sh} UCbfYPyITQ-7l4upoX8nvctg\"";
      }
      {
        title = "~YOUTUBE: ThrillSeeker";
        tags = ["YOUTUBE"];
        url = "\"exec:${./execurl/youtube.sh} UCSbdMXOI_3HGiFviLZO6kNA\"";
      }
      {
        title = "~YOUTUBE: PhrogPollen";
        tags = ["YOUTUBE"];
        url = "\"exec:${./execurl/youtube.sh} UC1gfzrtu1lNDAkQUKkR0OJA\"";
      }
      {
        title = "~YOUTUBE: Samuel Bonilla";
        tags = ["YOUTUBE"];
        url = "\"exec:${./execurl/youtube.sh} UCjU1efB7RcrXTc6M5FwkEmg\"";
      }
      {
        title = "~YOUTUBE: SkilledMusician";
        tags = ["YOUTUBE"];
        url = "\"exec:${./execurl/youtube.sh} UCxDJZNKl0RHU3wnT3c6LhSQ\"";
      }
      {
        title = "---GAME DEV---";
        url = "";
      }
      {
        title = "~GAME DEV: CodeParade";
        tags = ["GAME DEV"];
        url = "\"exec:${./execurl/youtube.sh} UCrv269YwJzuZL3dH5PCgxUw\"";
      }
      {
        title = "~GAME DEV: Virus (Wavefront dev)";
        tags = ["GAME DEV"];
        url = "\"exec:${./execurl/youtube.sh} UC4OINWRGOtWPZRjp-v4DPyA\"";
      }
      {
        title = "~GAME DEV: delgoodie (Astro dev)";
        tags = ["GAME DEV"];
        url = "\"exec:${./execurl/youtube.sh} UCLwIwKFEh0Dy_IGCDXZuoWA\"";
      }
      {
        title = "---NEWS---";
        url = "";
      }
      {
        title = "~NEWS: Qutebrowser";
        tags = ["NEWS"];
        url = "https://kill-the-newsletter.com/feeds/utegqnhc27zcnb9f.xml";
      }
      {
        title = "~NEWS: This week in neovim";
        tags = ["NEWS"];
        url = "https://dotfyle.com/this-week-in-neovim/rss.xml";
      }
      {
        title = "---BLOG---";
        url = "";
      }
      {
        title = "~BLOG: TTY1";
        tags = ["BLOG"];
        url = "https://tty1.blog/feed/";
      }
    ];
    autoReload = false;
    browser = "${./linkhandler}";
    extraConfig = ''
      #color background          default default
      #color listnormal          default default
      #color listfocus           black   yellow dim
      #color listnormal_unread   default default bold
      #color listfocus_unread    black   yellow underline
      #color info                default red
      #color article             default default

      bind-key j down
      bind-key k up
      bind-key h quit
      bind-key l open
      #bind-key j next articlelist
      #bind-key k prev articlelist
      bind-key J next-feed articlelist
      bind-key K prev-feed articlelist
      bind-key G end
      bind-key g home
      bind-key d pagedown
      bind-key u pageup
      bind-key h quit
      bind-key a toggle-article-read
      bind-key n next-unread
      bind-key N prev-unread
      bind-key D pb-download
      bind-key U show-urls
      bind-key x pb-delete


      highlight all "---.*---" default
      highlight feedlist ".*(0/0))" black
      highlight article "(^Feed:.*|^Title:.*|^Author:.*)" cyan default bold
      highlight article "(^Link:.*|^Date:.*)" default default
      highlight article "https?://[^ ]+" green default
      highlight article "^(Title):.*$" blue default
      highlight article "\\[[0-9][0-9]*\\]" yellow default bold
      highlight article "\\[image\\ [0-9]+\\]" green default bold
      highlight article "\\[embedded flash: [0-9][0-9]*\\]" green default bold
      highlight article ":.*\\(link\\)$" cyan default
      highlight article ":.*\\(image\\)$" blue default
      highlight article ":.*\\(embedded flash\\)$" magenta default
    '';
  };

  home.packages = [
  ];
}
