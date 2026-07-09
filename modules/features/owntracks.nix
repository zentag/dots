{
  flake.nixosModules.owntracks = {
    services.mosquitto = {
      enable = true;
      logType = ["all"];
      listeners = [
        {
          port = 1883;
          address = "0.0.0.0";
          acl = [
            "pattern read #"
          ];

          users = {
            zen.password = "test";
            dodi.password = "test";
            mike.password = "test";
          };
        }
      ];
    };
  };
}
