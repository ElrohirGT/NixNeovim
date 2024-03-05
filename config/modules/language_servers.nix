{
  pkgs,
  lib,
  config,
  options,
  ...
}: {
  options.language-servers.isDefault = lib.mkOption {
    type = lib.types.nullOr lib.types.bool;
    description = "If set to false, some functionality will be disabled to save disk space.";
    default = true;
  };

  config = {
    plugins.lsp = {
      enable = true;
      keymaps = {
        silent = true;
        diagnostic = {
          "<leader>k" = "goto_prev";
          "<leader>j" = "goto_next";
        };
        lspBuf = {
          K = "hover";
          gD = "references";
          gd = "definition";
          gi = "implementation";
          gt = "type_definition";
          "<leader>a" = "code_action";
        };
      };
      servers = {
        # Javascript / Typescript
        tsserver.enable = config.language-servers.isDefault;

        # Lua
        lua-ls.enable = true;

        # Go
        gopls.enable = true;

        # Bash
        bashls.enable = true;

        # Nix
        nil_ls.enable = true;

        # Markdown
        marksman.enable = true;

        # LaTex
        texlab.enable = config.language-servers.isDefault;
      };
    };

    extraPlugins =
      if config.language-servers.isDefault
      then
        with pkgs; [
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
        ]
      else [];
    extraConfigLua =
      if config.language-servers.isDefault
      then ''
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
      ''
      else "";
  };
}
