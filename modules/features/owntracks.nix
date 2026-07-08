{
  flake.nixosModules.owntracks = {pkgs, ...}: {
    systemd.services.owntracks = {
      enable = true;
      description = "owntracks recorder";
      serviceConfig = {
        ExecStart = ''
          ${pkgs.owntracks-recorder}/bin/ot-recorder \
             --storage /var/lib/owntracks/recorder/store \
             --port 0
        '';
        DynamicUser = true;
        StateDirectory = "owntracks";
        Restart = "always";
      };
      wantedBy = ["multi-user.target"];
    };
    environment.systemPackages = with pkgs; [
      owntracks-recorder
    ];
  };
}
