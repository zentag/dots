{
  flake.nixosModules.owntracks = {
    services.mosquitto = {
      enable = true;
      logType = ["all"];
      listeners = [
        {
          port = 1883;
          address = "0.0.0.0";
          users = {
            zen = {
              password = "test";
              acl = [
                "readwrite owntracks/zen/zen"
                "read owntracks/+/+"
              ];
            };
            dodi = {
              password = "test";
              acl = [
                "readwrite owntracks/dodi/dodi"
                "read owntracks/+/+"
              ];
            };
            mike = {
              password = "test";
              acl = [
                "readwrite owntracks/mike/mike"
                "read owntracks/+/+"
              ];
            };
          };
        }
      ];
    };
  };
}
