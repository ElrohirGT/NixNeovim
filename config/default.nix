{
  # Import all your configuration modules here
  imports = [
    ./general.nix
    ./modules/telescope.nix
    ./modules/completions.nix
    ./modules/treesitter.nix
    ./modules/markdown_preview.nix
    ./modules/language_servers.nix
    ./modules/error_panes.nix
    ./modules/mappings.nix
		./modules/snippets.nix
  ];
}
