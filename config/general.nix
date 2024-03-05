{
  pkgs,
  lib,
  config,
  options,
  ...
}: {
  options.general.isDefault = with lib;
    mkOption {
      type = types.nullOr types.bool;
      description = "If set to false, some functionality will be disabled to save disk space.";
      default = true;
    };

  config = {
    # :h option-list
    options = {
      number = true;
      relativenumber = true;

      shiftwidth = 2;
      tabstop = 2;
      softtabstop = 2;

      expandtab = false;
      hlsearch = false;
      incsearch = true;

      scrolloff = 8;
      updatetime = 50;
      colorcolumn = "180";

      spell = true;
      termguicolors = true;
    };

    autoGroups = {
      "kickstart-highlight-yank" = {
        clear = true;
      };
    };

    autoCmd = [
      {
        event = "TextYankPost";
        desc = "Highlight when yanking text";
        group = "kickstart-highlight-yank";
        callback = {
          __raw = ''
            function ()
            	vim.highlight.on_yank()
            end
          '';
        };
      }
    ];

    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    colorschemes.kanagawa.enable = true;
    plugins = {
      # Plugin to find which key does what
      which-key.enable = true;

      # Lateral file explorer
      nvim-tree.enable = true;

      # Status bar
      lualine.enable = true;

      # Manage files in neovim buffer
      oil.enable = config.general.isDefault;

      # Rename incrementally with LSP support
      inc-rename.enable = true;

      # Display tags inside a file
      tagbar.enable = true;

      # Rust setup
      rustaceanvim.enable = config.general.isDefault;

      # LaTex setup
      vimtex = {
        enable = config.general.isDefault;
        texlivePackage = null; # Dont install any package
      };

      # TODO and friends formatting for comments
      todo-comments.enable = true;

      # Support for nvim comments
      comment-nvim.enable = true;

      # Support for surrounding things with things
      surround.enable = true;
    };

    extraPlugins = with pkgs; [
      vimPlugins.nvim-web-devicons
    ];

    extraConfigLua = ''
      -- LSP Diagnostics Options Setup
      local sign = function(opts)
        vim.fn.sign_define(opts.name, {
          texthl = opts.name,
          text = opts.text,
          numhl = ""
        })
      end

      -- Diagnostic Icons
      sign({name = "DiagnosticSignError", text = ""})
      sign({name = "DiagnosticSignWarn", text = ""})
      sign({name = "DiagnosticSignHint", text = ""})
      sign({name = "DiagnosticSignInfo", text = ""})
    '';
  };
}
