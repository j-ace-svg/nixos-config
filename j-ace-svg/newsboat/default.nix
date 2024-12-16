{pkgs, ...}: {
  programs.newsboat = {
    enable = true;
    urls = [
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
  };

  home.packages = [
  ];
}
