{self, ...}: {
  flake.nixosModules.gaming = {config, ...}: {
    imports = [
      (self.lib.hm config.username "gaming")
    ];
  };
  flake.homeModules.gaming = {pkgs, ...}: {
    home.packages = with pkgs; [
      prismlauncher
    ];
  };
}
