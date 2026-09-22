{lib, ...}: {
  vim = {
    # this is shown on startup if you don't provide any args
    dashboard.alpha = {
      enable = true;
      theme = "theta";
    };
    theme = {
      enable = true;
      name = "tokyonight";
      style = "moon";
      transparent = true;
    };
    # bottom bar
    statusline.lualine = {
      enable = true;
    };
    mini = {
      icons.enable = true;
      notify = {
        enable = true;
        setupOpts.window.config = lib.generators.mkLuaInline ''
          function()
            local has_statusline = vim.o.laststatus > 0
            local pad = vim.o.cmdheight + (has_statusline and 1 or 0)
            return { anchor = "SE", col = vim.o.columns, row = vim.o.lines - pad }
          end
        '';
      };
    };
    # do current line blames and other stuff if you want
    git.gitsigns.enable = true;
  };
}
