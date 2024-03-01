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
    };

    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    colorschemes.kanagawa.enable = true;
    plugins = {
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
  };
}
