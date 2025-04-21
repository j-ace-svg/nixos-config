{
  pkgs,
  inputs,
  ...
}: {
  home.packages = [
    #inputs.plover-wayland.packages."x86_64-linux".plover-wtype
  ];
}
