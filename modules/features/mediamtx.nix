{
  flake.nixosModules.mediamtx = {
    lib,
    pkgs,
    ...
  }: {
    services.mediamtx = {
      enable = true;
      allowVideoAccess = true; # lets the sandboxed service open /dev/video0

      settings = {
        paths = {
          cam1 = {
            runOnInit =
              "${lib.getExe pkgs.ffmpeg} -f v4l2 -i /dev/video0 "
              + "-c:v libx264 -preset veryfast -tune zerolatency "
              + "-f rtsp rtsp://localhost:8554/cam1";
            runOnInitRestart = true; # auto-restarts ffmpeg if it dies or capture card hiccups
          };
        };
      };
    };

    # open the ports so other devices on your LAN can view the stream
    networking.firewall.allowedTCPPorts = [8554 8888 8889];
  };
}
