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
		./markdown_preview.nix
		./language_servers.nix
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

      # Rust setup
      rustaceanvim.enable = true;

      # TODO and friends formatting for comments
      todo-comments.enable = true;

      # Better error messages
      trouble.enable = true;

      # Support for nvim comments
      comment-nvim.enable = true;

      # Support for surrounding things with things
      surround.enable = true;
    };

    keymaps = [
      # Markdown preview controls
      {
        mode = "n";
        key = "<leader>ms";
        action = ":MarkdownPreviewStop<CR>";
      }
      {
        mode = "n";
        key = "<leader>mp";
        action = ":MarkdownPreview<CR>";
      }

      # Change spelling
      {
        key = "<leader>ls";
        action = ":set spell spelllang=es_gt<CR>";
        mode = "n";
      }
      {
        key = "<leader>le";
        action = ":set spell spelllang=en_us<CR>";
        mode = "n";
      }

      # Enable/Disable wordwrap
      {
        key = "<leader>we";
        action = ":set wrap<CR>";
        mode = "n";
      }
      {
        key = "<leader>ws";
        action = ":set nowrap<CR>";
        mode = "n";
      }

      # Append previous line to current line
      {
        mode = "v";
        key = "J";
        action = ":m '>+1<CR>gv=gv";
      }
      {
        mode = "v";
        key = "K";
        action = ":m '<-2<CR>gv=gv";
      }
      {
        mode = "n";
        key = "J";
        action = "mzJ`z";
      }

      # Toggle NvimTree
      {
        mode = "n";
        key = "<leader>e";
        action = ":NvimTreeToggle<CR>";
      }

      # CTRL-q saves and closes file
      {
        mode = "n";
        key = "<C-Q>";
        action = ":wq<CR>";
      }

      # :w and :q are case insensitive
      {
        mode = "n";
        key = ":W";
        action = ":w";
      }
      {
        mode = "n";
        key = ":Q";
        action = ":q<CR>";
      }

      # CTRL-d/CTRL-u now centers the screen at cursor
      {
        mode = "n";
        key = "<C-d>";
        action = "<C-d>zz";
      }
      {
        mode = "n";
        key = "<C-u>";
        action = "<C-u>zz";
      }

      # Next/Previous in search centers the screen
      {
        mode = "n";
        key = "n";
        action = "nzzzv";
      }
      {
        mode = "n";
        key = "N";
        action = "Nzzzv";
      }
      {
        mode = "x";
        key = "<leader>p";
        action = "\"_dP";
      }

      # Yank to system clipboard
      {
        mode = "n";
        key = "<leader>y";
        action = "\"+y";
      }
      {
        mode = "v";
        key = "<leader>y";
        action = "\"+y";
      }
      {
        mode = "n";
        key = "<leader>Y";
        action = "\"+Y";
      }

      # Disable Q
      {
        mode = "n";
        key = "Q";
        action = "<nop>";
      }

      # Rename symbol using IncRename
      {
        mode = "n";
        key = "<leader>rn";
        action = ":IncRename";
      }

      # Error panes logic
      {
        mode = "n";
        key = "<leader>xx";
        action = "<cmd>TroubleToggle<cr>";
      }
      {
        mode = "n";
        key = "<leader>xw";
        action = "<cmd>TroubleToggle workspace_diagnostics<cr>";
      }
      {
        mode = "n";
        key = "<leader>xd";
        action = "<cmd>TroubleToggle document_diagnostics<cr>";
      }
      {
        mode = "n";
        key = "<leader>xq";
        action = "<cmd>TroubleToggle quickfix<cr>";
      }
      {
        mode = "n";
        key = "<leader>xl";
        action = "<cmd>TroubleToggle loclist<cr>";
      }
      {
        mode = "n";
        key = "gR";
        action = "<cmd>TroubleToggle lsp_references<cr>";
      }

      # Vim fugitive
      {
        mode = "n";
        key = "<leader>gl";
        action = ":Git log --oneline --graph<CR>";
      }
    ];

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
