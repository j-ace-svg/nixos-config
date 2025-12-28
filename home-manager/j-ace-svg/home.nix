{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.username = "j-ace-svg";
  home.homeDirectory = "/home/j-ace-svg";
  programs.home-manager.enable = true;

  imports = [
    ./bash/default.nix
    ./custom-scripts/default.nix
    ./fastfetch/default.nix
    ./git/default.nix
    ./gui/default.nix
    ./newsboat/default.nix
    ./nvim/default.nix
    ./plover/default.nix
    ./rnnoise/default.nix
    ./ssh/default.nix
    ./tty/default.nix
    ./vifm/default.nix
  ];

  programs = {
    # Fuzzy finding
    fzf.enable = true;

    # Automatically enter shell.nix when changing directories
    direnv = {
      enable = true;
      enableBashIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };

    bash.enable = true; # see note on other shells below
  };

  home.packages = [
    pkgs.zip
    pkgs.unzip
    pkgs.ripgrep
    pkgs.hollywood
    pkgs.nms
    pkgs.unimatrix
    pkgs.cava
    pkgs.python3
    pkgs.mov-cli
    pkgs.bitwarden-cli
    pkgs.gptfdisk # Remove these after sh1mmer stuffs
    pkgs.file # |
    pkgs.ghc
    pkgs.gnumake
    pkgs.nix-init
    pkgs.stack
    pkgs.emacs
    pkgs.cmus
    pkgs.python313Packages.jupyterlab
    pkgs.python313Packages.ipykernel

    # Basic Utilities
    #pkgs.cheese
    pkgs.bc
    pkgs.wl-clipboard
    pkgs.ripgrep

    # Installing postmarketos
    pkgs.android-tools

    # PostmarketOS (and eventually maybe Mobile NixOS?)
    # pkgs.pmbootstrap # (Out of date for some reason? Use `nix run`)

    # Python
    # Uncomment these later, pry once py12 is fixed
    #pkgs.python311Packages.osmnx
    #pkgs.python311Packages.haversine
    #pkgs.python311Packages.geopy
  ];

  # This value determines the Home Manager release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  home.stateVersion = "23.11"; # Did you read the comment?
}
