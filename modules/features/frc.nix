{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.frc = {config, ...}: {
    imports = [
      (self.lib.hm config.username "frc")
    ];
  };
  flake.homeModules.frc = {pkgs, ...}: {
    home.packages = with inputs.frc.packages.${pkgs.stdenv.hostPlatform.system}; [
      advantagescope
      choreo
      pathplanner
      elastic-dashboard
      sysid
      wpical
    ];
  };
}
