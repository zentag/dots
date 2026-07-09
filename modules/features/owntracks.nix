{
  flake.nixosModules.owntracks = {
    services.mosquitto = {
      enable = true;

      listeners = [
        {
          port = 1883;
          address = "0.0.0.0";
          users = {
            zen = {
              password = "test";
            };
            dodi.password = "test";
            mike.password = "test";
          };
        }
      ];
    };
  };
}
