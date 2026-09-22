{
  flake.nixosModules.tailscale = {
    services.tailscale = {
      enable = true;
    };
    services.resolved.enable = true;
  };
}
