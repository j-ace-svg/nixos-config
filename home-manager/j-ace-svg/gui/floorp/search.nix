{
  pkgs,
  inputs,
  ...
}: {
  engines = let
    mkSearXNG = args @ {
      url,
      alias,
      iconPath ? args.url + "static/themes/simple/img/favicon.png",
    }: {
      urls = [
        {
          template = url + "search";
          params = [
            {
              name = "q";
              value = "{searchTerms}";
            }
          ];
        }
      ];
      icon = iconPath;
      definedAliases = [alias];
    };
  in {
    "Nix Packages" = {
      urls = [
        {
          template = "https://search.nixos.org/packages";
          params = [
            {
              name = "type";
              value = "packages";
            }
            {
              name = "channel";
              value = "unstable";
            }
            {
              name = "query";
              value = "{searchTerms}";
            }
          ];
        }
      ];
      icon = "https://search.nixos.org/favicon.png";
      definedAliases = ["ns"];
    };
    "Nix Options" = {
      urls = [
        {
          template = "https://search.nixos.org/options";
          params = [
            {
              name = "type";
              value = "packages";
            }
            {
              name = "channel";
              value = "unstable";
            }
            {
              name = "query";
              value = "{searchTerms}";
            }
          ];
        }
      ];
      icon = "https://search.nixos.org/favicon.png";
      definedAliases = ["ns"];
    };
    "Home-Manager Options" = {
      urls = [
        {
          template = "https://home-manager-options.extranix.com/";
          params = [
            {
              name = "query";
              value = "{searchTerms}";
            }
            {
              name = "release";
              value = "master";
            }
          ];
        }
      ];
      icon = "https://home-manager-options.extranix.com/images/favicon.png";
      definedAliases = ["hs"];
    };
    "Youtube" = {
      urls = [
        {
          template = "https://youtube.com/results";
          params = [
            {
              name = "search_query";
              value = "{searchTerms}";
            }
          ];
        }
      ];
      icon = "https://www.youtube.com/s/desktop/ee47b5e0/img/logos/favicon_32x32.png";
      definedAliases = ["yt"];
    };
    "Youtube Music" = {
      urls = [
        {
          template = "https://music.youtube.com/search";
          params = [
            {
              name = "q";
              value = "{searchTerms}";
            }
          ];
        }
      ];
      icon = "https://music.youtube.com/favicon.ico";
      definedAliases = ["ym"];
    };
    "Wayback Machine" = {
      urls = [
        {
          template = "https://web.archive.org/web/*/{searchTerms}";
        }
      ];
      icon = "https://web-static.archive.org/_static/images/archive.ico";
      definedAliases = ["way"];
    };
    "WordReference" = {
      urls = [
        {
          template = "https://www.wordreference.com/es/translation.asp";
          params = [
            {
              name = "tranword";
              value = "{searchTerms}";
            }
          ];
        }
      ];
      icon = "https://www.wordreference.com/favicon.ico";
      definedAliases = ["wr"];
    };
    "OpnXNG" = mkSearXNG {
      url = "https://opnxng.com/";
      alias = "op";
    };
    "Searx Belgium" = mkSearXNG {
      url = "https://searx.be/";
      alias = "sb";
    };
    "PaulGO" = mkSearXNG {
      url = "https://paulgo.io/";
      alias = "pg";
    };
    "PrivAU" = mkSearXNG {
      url = "https://priv.au/";
      alias = "au";
    };
    "google".metaData.hidden = true;
    "bing".metaData.hidden = true;
    "You.com".metaData.hidden = true;
    "ddg".metaData.alias = "ddg";
  };
  default = "PaulGO";
  force = true;
}
