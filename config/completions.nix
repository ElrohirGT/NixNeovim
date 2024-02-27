{
	plugins = {
      # Completions framework and sources
      nvim-cmp = {
        enable = true;
        autoEnableSources = true;
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
