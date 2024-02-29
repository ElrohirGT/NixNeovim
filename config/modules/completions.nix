{
  plugins = {
    # Completions framework and sources
    nvim-cmp = {
      enable = true;
      mappingPresets = ["insert"];
      mapping = {
        "<C-d>" = "cmp.mapping.scroll_docs(-4)";
        "<C-f>" = "cmp.mapping.scroll_docs(4)";
        "<C-Space>" = "cmp.mapping.complete()";
        "<C-e>" = "cmp.mapping.close()";
        "<Tab>" = {
          modes = ["i" "s"];
          action = "cmp.mapping.select_next_item()";
        };
        "<S-Tab>" = {
          modes = ["i" "s"];
          action = "cmp.mapping.select_prev_item()";
        };
        "<CR>" = "cmp.mapping.confirm({ select = true })";
      };
      preselect = "None";

      autoEnableSources = false;
      sources = [
        {name = "nvim_lsp";}
        {name = "path";}
        {name = "buffer";}
        {name = "treesitter";}
      ];
    };

    cmp-nvim-lsp.enable = true;
    cmp-nvim-lsp-signature-help.enable = true;
    cmp-path.enable = true;
    cmp-buffer.enable = true;
    cmp-treesitter.enable = true;
  };
}
