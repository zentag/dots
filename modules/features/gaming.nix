{self, ...}: {
  flake.nixosModules.gaming = {config, ...}: {
    imports = [
      (self.lib.hm config.username "gaming")
    ];
    services.flatpak.enable = true;
  };
  flake.homeModules.gaming = {pkgs, ...}: {
    home.packages = with pkgs; [
      prismlauncher
    ];
  };
}
