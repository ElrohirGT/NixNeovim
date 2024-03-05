{
  # Import all your configuration modules here
  imports = [
    ./general.nix
    ./modules/treesitter.nix
    ./modules/completions.nix
    ./modules/mappings.nix
  ];

  general.isDefault = false;
  completions.isDefault = false;
}
