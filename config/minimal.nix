{
  # Import all your configuration modules here
  imports = [
    ./general.nix
    ./modules/telescope.nix
    ./modules/completions.nix
    ./modules/treesitter.nix
    ./modules/language_servers.nix
    ./modules/mappings.nix
  ];
}
