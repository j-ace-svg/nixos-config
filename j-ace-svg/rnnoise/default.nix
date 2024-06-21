{pkgs, ...}: {
  xdg.configFile."pipewire/pipewire.conf.d/99-input-denoising.conf" = {
    enable = true;
    text = builtins.readFile ./99-input-denoising.conf;
  };

  home.packages = [
    pkgs.rnnoise
  ];
}
