{
  vim.formatter.conform-nvim = {
    enable = true;
    # format java like wpilib
    setupOpts = {
      formatters_by_ft.java = ["google-java-format"];
      formatters.google-java-format = {
        command = "google-java-format";
        args = ["--aosp" "-"];
        stdin = true;
      };
    };
  };
}
