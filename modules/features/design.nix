{self, ...}: {
  flake.nixosModules.design = {
    config,
    pkgs,
    ...
  }: {
    imports = [
      (self.lib.hm config.username "design")
    ];
    programs.java.enable = true;
    programs.java.package = pkgs.jdk25;
  };
  flake.homeModules.design = {pkgs, ...}: {
    home.packages = with pkgs; [
      cura-appimage
      freecad
      kicad
      prusa-slicer
    ];
  };
}
