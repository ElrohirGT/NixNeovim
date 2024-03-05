{pkgs, ...}: {
  plugins.telescope = {
    # Search through files inside workspace
    enable = true;
    keymaps = {
      "<leader>ff" = {
        action = "find_files";
        desc = "[F]ind [f]iles in CWD";
      };
      "<leader>fg" = {
        action = "live_grep";
        desc = "[F]ind file according to content that matches [G]rep";
      };
      "<leader>fb" = {
        action = "buffers";
        desc = "[F]ind on [B]uffers";
      };
      "<leader>fc" = {
        action = "current_buffer_fuzzy_find";
        desc = "[F]ind on [C]urrent buffer";
      };
      "<leader>fh" = {
        action = "help_tags";
        desc = "[F]ind [H]elp";
      };
      "<leader>fd" = {
        action = "lsp_definitions";
        desc = "[F]ind [D]efinitions";
      };
      "<leader>fr" = {
        action = "lsp_references";
        desc = "[F]ind [R]eferences";
      };
      "<leader>fi" = {
        action = "lsp_implementations";
        desc = "[F]ind [I]mplementations";
      };
      "<leader>fs" = {
        action = "lsp_workspace_symbols";
        desc = "[F]ind workspace [S]ymbols";
      };
      "<leader>fw" = {
        action = "grep_string";
        desc = "[F]ind current [W]ord";
      };
    };
  };

  extraPackages = with pkgs; [
    ripgrep
  ];
}
