{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.frc = {
    config,
    pkgs,
    ...
  }: {
    imports = [
      (self.lib.hm config.username "frc")
    ];

    # GradleRIO downloads prebuilt WPILib/vendor JNI libraries for `simulateJava`
    # that expect an FHS layout, so they can't find libstdc++ etc. on NixOS.
    # nix-ld gives them a working dynamic loader instead.
    # Docs: https://github.com/frc4451/frc-nix/blob/season/2026/docs/simulation-gui.md
    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.simulate
    ];

    programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [
        libGL # needed if the WPILib sim GUI window is opened
      ];
    };
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
