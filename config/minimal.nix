{
  self,
  pkgs,
  ...
}: {
  # Import all your configuration modules here
  imports = [
    ./telescope.nix
    ./completions.nix
    ./treesitter.nix
		./language_servers.nix
		./mappings.nix
  ];

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

      # Snippet engine
      luasnip.enable = true;

      # Manage files in neovim buffer
      oil.enable = true;

      # Rename incrementally with LSP support
      inc-rename.enable = true;

      # Display tags inside a file
      tagbar.enable = true;

      # TODO and friends formatting for comments
      todo-comments.enable = true;

      # Support for nvim comments
      comment-nvim.enable = true;

      # Support for surrounding things with things
      surround.enable = true;
    };

    extraPlugins = with pkgs; [
      ripgrep # For Telescope
      vimPlugins.nvim-web-devicons

      # SQL LSP setup
      sqls
      (pkgs.vimUtils.buildVimPlugin {
        name = "sqls.nvim";
        src = pkgs.fetchFromGitHub {
          owner = "nanotee";
          repo = "sqls.nvim";
          rev = "4b1274b5b44c48ce784aac23747192f5d9d26207";
          # SHA-256 obtained using:
          # nix-prefetch-url --unpack https://github.com/nanotee/sqls.nvim/archive/4b1274b5b44c48ce784aac23747192f5d9d26207.tar.gz
          sha256 = "0jxgsajl7plw025a0h6r3cifrj0jyszn697247ggy0arlfvnx8cc";
        };
      })
    ];
    extraConfigLua = ''
        	require('lspconfig').sqls.setup{
          on_attach = function(client, bufnr)
            require('sqls').on_attach(client, bufnr) -- require sqls.nvim
          end;
          settings = {
            sqls = {
              connections = {
       {
                  driver = 'postgresql',
      -- change the database attribute to whatever DB we're using right now
                  dataSourceName = 'host=localhost port=5432 user=postgres database=postgres',
                },
              },
            },
          };
        }
    '';
  };
}
