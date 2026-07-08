{
  inputs,
  self,
  ...
}: {
  flake.nixosConfigurations.headless = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      server

      headless
      headless-hardware

      owntracks
    ];
  };
  flake.nixosModules.headless = {
    system.stateVersion = "24.05";
    home-manager.users.zen.home.stateVersion = "24.05";

    wifi.enable = true;

    username = "zen";
    users.users = {
      zen = {
        isNormalUser = true;
        description = "Zen Gunawardhana";
        extraGroups = [
          # sudo privileges
          "wheel"
        ];
      };
    };
  };
}
