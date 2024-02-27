{pkgs, ...}: {
  # Enable treesitter with a bunch of parsers by default
  plugins.treesitter = {
    enable = true;
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      # General
      nix
      regex
      python
      go
      proto
      bash
      sql
			c
			cpp

			# Neovim config
      lua
			vimdoc

      # configs
      yaml
      json

      # Rust
      rust
      toml

      # Web
      typescript
      javascript
      html
      css
      markdown
    ];
  };
}
