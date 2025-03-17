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
      iconUpdateURL = iconPath;
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
      iconUpdateURL = "https://search.nixos.org/favicon.png";
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
      iconUpdateURL = "https://home-manager-options.extranix.com/images/favicon.png";
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
      iconUpdateURL = "https://www.youtube.com/s/desktop/ee47b5e0/img/logos/favicon_32x32.png";
      definedAliases = ["yt"];
    };
    "Wayback Machine" = {
      urls = [
        {
          template = "https://web.archive.org/web/*/{searchTerms}";
        }
      ];
      iconUpdateURL = "https://web-static.archive.org/_static/images/archive.ico";
      definedAliases = ["way"];
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
    "Google".metaData.hidden = true;
    "Bing".metaData.hidden = true;
    "You.com".metaData.hidden = true;
    "DuckDuckGo".metaData.alias = "ddg";
  };
  default = "PrivAU";
  force = true;
}
