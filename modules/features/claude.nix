{
  flake.nixosModules.claude = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      claude-code
    ];
  };
}
