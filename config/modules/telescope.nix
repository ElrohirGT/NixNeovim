{pkgs, ...}: {
  plugins.telescope = {
    # Search through files inside workspace
    enable = true;
    keymaps = {
      "<leader>ff" = "find_files";
      "<leader>fg" = "live_grep";
      "<leader>fb" = "buffers";
      "<leader>fh" = "help_tags";
      "<leader>d" = "lsp_definitions";
      "<leader>s" = "lsp_workspace_symbols";
    };
  };

  extraPackages = with pkgs; [
    ripgrep
  ];
}
