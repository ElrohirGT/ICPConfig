{
  imports = [./minimal.nix];

  plugins = {
    lsp = {
      enable = true;
      servers = {
        java-language-server.enable = true;
      };
    };

    luasnip.enable = true;

    cmp = {
      enable = true;
      autoEnableSources = true;
      settings = {
        mapping = {
          "<C-d>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";

          # Manually trigger a completion from nvim-cmp
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-e>" = "cmp.mapping.close()";
          "<C-n>" = "cmp.mapping.select_next_item()";
          "<C-p>" = "cmp.mapping.select_prev_item()";
          "<C-y>" = "cmp.mapping.confirm({ select = true })";
        };
      };
    };
  };

  # Setting up the completion engine to use luasnip
  plugins.cmp.settings.snippet.expand = ''function(args) require('luasnip').lsp_expand(args.body) end'';
}
