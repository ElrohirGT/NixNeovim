{
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
      };
    };
    servers = {
      # Javascript / Typescript
      tsserver.enable = true;

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
    };
  };
}
