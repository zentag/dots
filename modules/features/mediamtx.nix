{
  flake.nixosModules.mediamtx = {
    lib,
    pkgs,
    ...
  }: {
    services.mediamtx = {
      enable = true;
      allowVideoAccess = true;

      settings = {
        playback = true; # enables the /list and /get HTTP API for browsing/streaming recordings

        paths = {
          cam1 = {
            runOnInit =
              "${lib.getExe pkgs.ffmpeg} -f v4l2 -i /dev/video0 "
              + "-c:v libx264 -preset veryfast -tune zerolatency "
              + "-b:v 400k -maxrate 400k -bufsize 800k "
              + "-f rtsp rtsp://localhost:8554/cam1";
            runOnInitRestart = true;

            # record to disk, keeping ~1 week (~30GB at 400kbps) and deleting older segments
            record = true;
            recordPath = "/var/lib/mediamtx/recordings/%path/%Y-%m-%d_%H-%M-%S-%f";
            recordFormat = "fmp4";
            recordSegmentDuration = "1h";
            recordDeleteAfter = "7d";
          };
        };
      };
    };

    systemd.services.mediamtx.serviceConfig.StateDirectory = "mediamtx";

    networking.firewall.allowedTCPPorts = [8554 8888 8889 9996];
  };
}
