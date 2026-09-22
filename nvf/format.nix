{pkgs, ...}: {
  vim = {
    extraPackages = [pkgs.google-java-format];
    formatter.conform-nvim = {
      enable = true;
      # format java like wpilib
      setupOpts = {
        formatters_by_ft.java = ["google-java-format"];
        formatters.google-java-format = {
          command = "${pkgs.google-java-format}/bin/google-java-format";
          args = ["-"];
          stdin = true;
        };
      };
    };
  };
}
