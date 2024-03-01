{
  lib,
  config,
  options,
  ...
}: {
  options.completions.isDefault = lib.mkOption {
    type = lib.types.nullOr lib.types.bool;
    description = "If set to false, some functionality will be disabled to save disk space.";
    default = true;
  };

  config = {
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
        sources =
          if config.completions.isDefault
          then [
            {name = "nvim_lsp";}
            {name = "path";}
            {name = "buffer";}
            {name = "treesitter";}
          ]
          else [
            {name = "path";}
            {name = "buffer";}
          ];
      };

      cmp-nvim-lsp.enable = config.completions.isDefault;
      cmp-nvim-lsp-signature-help.enable = config.completions.isDefault;
      cmp-path.enable = true;
      cmp-buffer.enable = true;
      cmp-treesitter.enable = config.completions.isDefault;
    };
  };
}
