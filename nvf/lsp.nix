{pkgs, ...}: {
  vim = {
    # show errors inline
    extraPlugins = {
      tiny-inline-diagnostics = {
        package = pkgs.vimPlugins.tiny-inline-diagnostic-nvim;
        setup = "require('tiny-inline-diagnostic').setup()";
      };
    };
    lsp = {
      enable = true;
      formatOnSave = true;
      # not really a language so has to be enabled here
      presets.tailwindcss-language-server.enable = true;
    };
    languages = {
      enableFormat = true;
      enableTreesitter = true;
      enableExtraDiagnostics = true;

      # enabling all the languages I use (or play around with)
      astro.enable = true;
      bash.enable = true;
      clang.enable = true;
      css.enable = true;
      gleam.enable = true;
      go.enable = true;
      html.enable = true;
      java.enable = true;
      lua.enable = true;
      nim.enable = true;
      nix.enable = true;
      # nixd has better autocomplete than nil
      nix.lsp.servers = ["nixd"];
      odin.enable = true;
      rust.enable = true;
      typescript.enable = true;
      typst.enable = true;
      typst.extensions.typst-preview-nvim.enable = true;
      yaml.enable = true;
      zig.enable = true;
    };
  };
}
