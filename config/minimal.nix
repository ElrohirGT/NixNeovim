{
  # Import all your configuration modules here
  imports = [
    ./general.nix
    ./modules/completions.nix 
    ./modules/language_servers.nix 
    ./modules/mappings.nix
  ];

	general.isDefault = false;
	completions.isDefault = false;
	language-servers.isDefault = false;
}
