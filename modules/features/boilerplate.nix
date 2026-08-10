{self, ...}: {
  flake.homeModules.boilerplate = {lib, ...}: {
    options.configDir = lib.mkOption {
      default = "~/dots";
    };
  };
  flake.nixosModules.boilerplate = {lib, ...}: {
    options.username = lib.mkOption {};

    config = {
      home-manager.sharedModules = [self.homeModules.boilerplate];
      nixpkgs.config.allowUnfree = true;
      nix = {
        optimise.automatic = true;
        # removes no longer required derivations from nix store (garbage collection)
        gc = {
          automatic = true;
          dates = "daily";
          options = "--delete-older-than 30d";
        };
        settings = {
          # adds community cache so things like frc-nix packages are downloaded binaries rather than built on my machine
          substituters = ["https://nix-community.cachix.org"];
          trusted-public-keys = [
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          ];
          # everyone uses flakes nowadays :)
          experimental-features = [
            "nix-command"
            "flakes"
          ];
        };
      };
      # bootloader
      boot.loader = {
        systemd-boot = {
          enable = true;
          # prevents /boot from getting full and cleaner look on startup
          configurationLimit = 7;
        };
        efi.canTouchEfiVariables = true;
      };
      hardware = {
        enableAllFirmware = true;
      };

      time.timeZone = "America/Indiana/Indianapolis";

      # select internationalisation properties.
      # tbh this was done by the installer and I don't feel like messing with it
      # no idea if it's really necessary
      i18n.defaultLocale = "en_US.UTF-8";

      i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
      };
    };
  };
}
