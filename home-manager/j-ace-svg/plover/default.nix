{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.plover.homeManagerModules.plover
  ];

  programs.plover = {
    enable = true;
    settings = {
    };
  };

  home.packages = [
    #inputs.plover-wayland.packages."x86_64-linux".plover-wtype
  ];
}
