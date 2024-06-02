{pkgs, ...}: {
  opts = {
    number = true;
    relativenumber = true;

    shiftwidth = 2;
    tabstop = 2;
    softtabstop = 2;

    expandtab = false;
    hlsearch = false;
    incsearch = true;
  };

  globals = {
    mapleader = " ";
    maplocalleader = " ";
  };

  colorschemes.nightfox = {
    enable = true;
    flavor = "carbonfox";
  };

  plugins = {
    lspkind.enable = true;
    oil.enable = true;
    telescope = {
      enable = true;
      keymaps = {
        "<leader>ff" = {
          action = "find_files";
          options = {
            desc = "[F]ind [f]iles in CWD";
          };
        };
        "<leader>fg" = {
          action = "live_grep";
          options = {
            desc = "[F]ind file according to content that matches [G]rep";
          };
        };
        "<leader>fr" = {
          action = "lsp_references";
          options = {
            desc = "[F]ind [R]eferences";
          };
        };
        "<leader>fi" = {
          action = "lsp_implementations";
          options = {
            desc = "[F]ind [I]mplementations";
          };
        };
        "<leader>fs" = {
          action = "lsp_workspace_symbols";
          options = {
            desc = "[F]ind workspace [S]ymbols";
          };
        };
      };
    };

    treesitter = {
      enable = true;
      grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        java
      ];
    };

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

  keymaps = [
    {
      mode = "n";
      key = "<leader>e";
      action = ":Oil<CR>";
      options = {
        desc = "Toggle Oil";
      };
    }
  ];
}
