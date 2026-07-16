{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.hp = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      graphical

      hp
      hp-hardware

      design
      frc
      fun
      gaming
      music
      ssh
      tailscale
      virtualisation
    ];
  };
  flake.nixosModules.hp = {
    home-manager.users.zen.monitor = [
      "eDP-1, 1920x1080, 0x0, 1"
    ];
    services.udisks2.enable = true;
    wifi.enable = true;
    username = "zen";
    system.stateVersion = "23.11"; # absolutely do not change
    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    home-manager.users.zen = {
      home.stateVersion = "24.05"; # Please read the comment before changing.
      services.udiskie = {
        enable = true;
        automount = true;
        notify = true;
        tray = "never"; # or "auto" if you want a tray icon
      };
    };
    users.users = {
      zen = {
        isNormalUser = true;
        description = "Zen Gunawardhana";
        extraGroups = [
          # sudo privileges
          "wheel"
          "audio"
          # for access to serial devices, in my case microcontrollers
          "dialout"
        ];
      };
    };
  };
}
