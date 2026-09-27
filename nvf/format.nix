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
        # nvf's astyle (used by clang) formats a .conform.* temp file in
        # place, and astyle leaves a .orig backup of it behind by default
        formatters.astyle.prepend_args = ["--suffix=none"];
      };
    };
  };
}
