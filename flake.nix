{
  description = "Nix vim configuration of ElrohirGT";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = {
    nixvim,
    flake-parts,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem = {
        pkgs,
        system,
        ...
      }: let
        nixvimLib = nixvim.lib.${system};
        nixvim' = nixvim.legacyPackages.${system};
        nixVimModuleFull = {
          inherit pkgs;
          module = import ./config; # import the module directly
          # You can use `extraSpecialArgs` to pass additional arguments to your module files
          extraSpecialArgs = {
            # inherit (inputs) foo;
          };
        };
				nixVimModuleMinimal = {
					inherit pkgs;
					module = import ./config/minimal.nix;
				};
        nvimFull = nixvim'.makeNixvimWithModule nixVimModuleFull;
        nvimMinimal = nixvim'.makeNixvimWithModule nixVimModuleMinimal;
      in {
        checks = {
          # Run `nix flake check .` to verify that your config is not broken
          default = nixvimLib.check.mkTestDerivationFromNixvimModule nixVimModuleFull;
					minimal = nixvimLib.check.mkTestDerivationFromNixvimModule nvimMinimal;
        };

        packages = {
          # Lets you run `nix run .` to start nixvim
          default = nvimFull;
					minimal = nvimMinimal;
        };
      };
    };
}
